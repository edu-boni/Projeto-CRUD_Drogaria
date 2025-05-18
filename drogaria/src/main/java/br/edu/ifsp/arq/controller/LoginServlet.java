package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.AdministradorDAO;
import br.edu.ifsp.arq.model.Administrador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdministradorDAO dao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = AdministradorDAO.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        String msg;
        Administrador encontrado = null;
        
        for (Administrador admin : dao.getAdministradores()) {
            if (admin.getEmail().equalsIgnoreCase(email)) {
                encontrado = admin;
                break;
            }
        }

        if (encontrado == null) {
            msg = "E-mail não cadastrado.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "p-0 alert alert-danger");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (encontrado.getSenha().equals(senha)) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", encontrado);

            msg = "Login realizado com sucesso!";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "p-0 alert alert-success");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else {
            msg = "Senha incorreta.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "p-0 alert alert-danger");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
