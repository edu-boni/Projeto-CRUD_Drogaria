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

        String msg = "";
        boolean autenticado = false;

        for (Administrador admin : dao.getAdministradores()) {
            if (admin.getEmail().equals(email) && admin.getSenha().equals(senha)) {
                autenticado = true;
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogado", admin);
                msg = "Login realizado com sucesso!";
                request.setAttribute("mensagem", msg);
                request.setAttribute("classAlert", "alert alert-success");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }
        }

        msg = "Email ou senha inválidos.";
        request.setAttribute("mensagem", msg);
        request.setAttribute("classAlert", "alert alert-danger");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
