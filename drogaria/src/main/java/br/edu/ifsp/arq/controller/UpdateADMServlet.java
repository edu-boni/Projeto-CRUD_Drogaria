package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.AdministradorDAO;
import br.edu.ifsp.arq.model.Administrador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet({"/editar-adm", "/UpdateADMServlet"})
public class UpdateADMServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Administrador admin = (Administrador) session.getAttribute("usuarioLogado");

        if (admin == null) {
            session.setAttribute("mensagem", "Não há nenhum perfil logado.");
            session.setAttribute("classAlert", "p-0 alert alert-danger");
            response.sendRedirect("index.jsp");
            return;
        }

        request.setAttribute("administrador", admin);
        request.getRequestDispatcher("adm/editar-adm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Administrador usuario = (Administrador) session.getAttribute("usuarioLogado");
        AdministradorDAO dao = AdministradorDAO.getInstance();
        String msg;

        if (usuario == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Fluxo de troca de senha via modal
        String senhaAtual = request.getParameter("senhaAtual");
        String novaSenha = request.getParameter("novaSenha");

        if (senhaAtual != null && novaSenha != null) {
            if (usuario.getSenha().equals(senhaAtual)) {
                usuario.setSenha(novaSenha);
                boolean atualizado = dao.atualizarAdministrador(usuario.getId(), usuario);

                if (atualizado) {
                    msg = "Senha alterada com sucesso!";
                    session.setAttribute("usuarioLogado", usuario);
                    request.setAttribute("classAlert", "alert alert-success");
                } else {
                    msg = "Erro ao atualizar a senha.";
                    request.setAttribute("classAlert", "alert alert-danger");
                }
            } else {
                msg = "Senha atual incorreta.";
                request.setAttribute("classAlert", "alert alert-danger");
            }

            request.setAttribute("mensagem", msg);
            request.setAttribute("administrador", usuario);
            request.getRequestDispatcher("adm/editar-adm.jsp").forward(request, response);
            return;
        }

        // Fluxo de edição de dados pessoais
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            msg = "ID inválido.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "alert alert-danger");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha"); // este campo vem desabilitado

        usuario.setNome(nome);
        usuario.setEmail(email);
        usuario.setCpf(cpf);
        // senha continua a mesma, pois não é alterada nesse fluxo

        boolean atualizado = dao.atualizarAdministrador(id, usuario);

        if (atualizado) {
            msg = "Dados atualizados com sucesso!";
            session.setAttribute("usuarioLogado", usuario);
            request.setAttribute("classAlert", "alert alert-success");
        } else {
            msg = "Não foi possível atualizar os dados.";
            request.setAttribute("classAlert", "alert alert-danger");
        }

        request.setAttribute("mensagem", msg);
        request.setAttribute("administrador", usuario);
        request.getRequestDispatcher("adm/editar-adm.jsp").forward(request, response);
    }
}
