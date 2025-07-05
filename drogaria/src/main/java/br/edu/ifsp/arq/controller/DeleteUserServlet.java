package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        int id;

        try {
            id = Integer.parseInt(idStr);
            UsuarioDAO dao = UsuarioDAO.getInstance();
            boolean removido = dao.removerUsuarioPorId(id);
            if (removido) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                sendJson(response, true, "Conta excluída com sucesso.");
            } else {
                sendJson(response, false, "Conta não encontrada.");
            }
        } catch (NumberFormatException e) {
            sendJson(response, false, "ID inválido.");
        }
    }
}
