package br.edu.ifsp.arq.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import br.edu.ifsp.arq.dao.AdministradorDAO;
import br.edu.ifsp.arq.model.Administrador;

@WebServlet("/CreateAdminServlet")
public class CreateAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AdministradorDAO dao;

    public CreateAdminServlet() {
        super();
        dao = AdministradorDAO.getInstance();
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
            Administrador a = new Administrador(nome, email, cpf, senha);
            if (dao.adicionarAdministrador(a)) {
                jsonResponse = String.format("{\"message\": \"Administrador %s cadastrado com sucesso.\"}", nome);
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                jsonResponse = "{\"message\": \"Erro ao salvar administrador no banco de dados.\"}";
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
        response.getWriter().write(jsonResponse);
    }
}
