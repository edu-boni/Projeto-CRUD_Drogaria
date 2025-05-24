package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.AdministradorDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteADMServlet")
public class DeleteADMServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String msg;
        int id;

        try {
            id = Integer.parseInt(idStr);
            AdministradorDAO dao = AdministradorDAO.getInstance();
            boolean removido = dao.removerAdministradorPorId(id);
            if (removido) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect("index.jsp");
                return;
            } else {
                msg = "Conta não encontrada.";
                request.setAttribute("classAlert", "p-0 alert alert-warning");
            }
        } catch (NumberFormatException e) {
            msg = "ID inválido.";
            request.setAttribute("classAlert", "p-0 alert alert-danger");
        }

        request.setAttribute("mensagem", msg);
        request.getRequestDispatcher("/adm/editar-adm.jsp").forward(request, response);
    }
}
