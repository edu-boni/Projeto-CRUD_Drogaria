package br.edu.ifsp.arq.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import br.edu.ifsp.arq.dao.UsuarioDAO;
import br.edu.ifsp.arq.model.Usuario;

@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UsuarioDAO dao;

    public CreateUserServlet() {
        super();
        dao = UsuarioDAO.getInstance();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        String jsonResponse;

        if (nome == null || email == null || senha == null || nome.trim().isEmpty() || email.trim().isEmpty() || senha.trim().isEmpty()) {
            jsonResponse = "{\"message\": \"Nome, email e senha são obrigatórios.\"}";
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else if (dao.emailExiste(email)) {
            jsonResponse = "{\"message\": \"Já existe um cadastro com esse e-mail.\"}";
            response.setStatus(HttpServletResponse.SC_CONFLICT);
        } else {
        	Usuario u;

        	if ("farmacia@mail.com".equals(email)) {
        	    u = new Usuario(nome, email, cpf, senha, true);
        	} else {
        	    u = new Usuario(nome, email, cpf, senha, false);
        	}

            if (dao.adicionarUsuario(u)) {
                jsonResponse = String.format("{\"message\": \"Usuário %s cadastrado com sucesso.\"}", nome);
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                jsonResponse = "{\"message\": \"Erro ao salvar usuário no banco de dados.\"}";
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
        response.getWriter().write(jsonResponse);
    }
}
