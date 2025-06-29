package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.AdministradorDAO;
import br.edu.ifsp.arq.model.Administrador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdministradorDAO dao;

    @Override
    public void init() throws ServletException {
        dao = AdministradorDAO.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        Administrador encontrado = null;
        for (Administrador admin : dao.getAdministradores()) {
            if (admin.getEmail().equalsIgnoreCase(email)) {
                encontrado = admin;
                break;
            }
        }

        PrintWriter out = response.getWriter();
        if (encontrado == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"message\": \"E-mail não cadastrado.\"}");
            return;
        }

        if (!encontrado.getSenha().equals(senha)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"message\": \"Senha incorreta.\"}");
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("usuarioLogado", encontrado);

        String jsonUsuario = String.format(
            "{\"nome\": \"%s\", \"email\": \"%s\"}",
            encontrado.getNome(), encontrado.getEmail()
        );

        out.write("{\"message\": \"Login realizado com sucesso.\", \"usuario\": " + jsonUsuario + "}");
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
