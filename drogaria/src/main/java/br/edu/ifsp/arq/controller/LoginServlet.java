package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.UsuarioDAO;
import br.edu.ifsp.arq.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsuarioDAO dao;

    @Override
    public void init() throws ServletException {
        dao = UsuarioDAO.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        Usuario encontrado = null;
        for (Usuario user : dao.getUsuarios()) {
            if (user.getEmail().equalsIgnoreCase(email)) {
                encontrado = user;
                break;
            }
        }

        PrintWriter out = response.getWriter();
        if (encontrado == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"message\": \"E-mail não cadastrado ou senha incorreta.\"}");
            return;
        }

        if (!encontrado.getSenha().equals(senha)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"message\": \"E-mail não cadastrado ou senha incorreta.\"}");
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("usuarioLogado", encontrado);

        String jsonUsuario = String.format(
        	    "{\"id\": %d, \"nome\": \"%s\", \"cpf\": \"%s\", \"email\": \"%s\", \"isAdmin\": %b}",
        	    encontrado.getId(), encontrado.getNome(), encontrado.getCpf(), encontrado.getEmail(), encontrado.isAdmin()
        );

        out.write("{\"message\": \"Login realizado com sucesso.\", \"usuario\": " + jsonUsuario + "}");
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
