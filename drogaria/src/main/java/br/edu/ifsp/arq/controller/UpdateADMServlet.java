package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.AdministradorDAO;
import br.edu.ifsp.arq.model.Administrador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet({"/editar-administrador", "/UpdateADMServlet"})
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

        String msg;
        int id;

        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            msg = "Perfil inválido.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "alert alert-danger");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");

        Administrador administradorAtualizado = new Administrador(nome, email, cpf, senha);

        AdministradorDAO dao = AdministradorDAO.getInstance();
        boolean atualizado = dao.atualizarAdministrador(id, administradorAtualizado);

        if (atualizado) {
            msg = "Dados alterados com sucesso!";
            request.setAttribute("classAlert", "alert alert-success");

            HttpSession session = request.getSession();
            administradorAtualizado.setId(id); 
            session.setAttribute("usuarioLogado", administradorAtualizado);
        } else {
            msg = "Não foi possível alterar os dados.";
            request.setAttribute("classAlert", "alert alert-danger");
        }

        request.setAttribute("mensagem", msg);
        request.setAttribute("administrador", administradorAtualizado);
        request.getRequestDispatcher("adm/editar-adm.jsp").forward(request, response);
    }
}
