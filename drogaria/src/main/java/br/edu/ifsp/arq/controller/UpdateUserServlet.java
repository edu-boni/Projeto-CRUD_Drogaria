package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.UsuarioDAO;
import br.edu.ifsp.arq.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private void sendJson(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print("{");
        out.print("\"success\": " + success + ",");
        out.print("\"message\": \"" + message.replace("\"", "\\\"") + "\"");
        out.print("}");
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        UsuarioDAO dao = UsuarioDAO.getInstance();

        if (usuario == null) {
            sendJson(response, false, "Sessão expirada. Faça login novamente.");
            return;
        }

        String senhaAtual = request.getParameter("senhaAtual");
        String novaSenha = request.getParameter("novaSenha");

        // Atualização de senha
        if (senhaAtual != null && novaSenha != null) {
            if (usuario.getSenha().equals(senhaAtual)) {
                usuario.setSenha(novaSenha);
                boolean atualizado = dao.atualizarUsuario(usuario.getId(), usuario);
                if (atualizado) {
                    // Atualiza o objeto na sessão
                    session.setAttribute("usuarioLogado", usuario);
                    sendJson(response, true, "Senha alterada com sucesso!");
                } else {
                    sendJson(response, false, "Erro ao atualizar a senha.");
                }
            } else {
                sendJson(response, false, "Senha atual incorreta.");
            }
            return;
        }

        // Atualização de dados pessoais
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            sendJson(response, false, "ID inválido.");
            return;
        }

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");

        if (!usuario.getEmail().equalsIgnoreCase(email) && dao.emailExiste(email)) {
            sendJson(response, false, "Já existe outro administrador cadastrado com esse e-mail.");
            return;
        }

        usuario.setNome(nome);
        usuario.setEmail(email);
        usuario.setCpf(cpf);

        boolean atualizado = dao.atualizarUsuario(id, usuario);
        if (atualizado) {
            // Atualiza o objeto na sessão com os novos dados
            session.setAttribute("usuarioLogado", usuario);
            sendJson(response, true, "Dados atualizados com sucesso!");
        } else {
            sendJson(response, false, "Não foi possível atualizar os dados.");
        }
    }
}
