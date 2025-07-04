package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteMedicamentoServlet")
public class DeleteMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String contextPath = request.getContextPath();
        String idStr = request.getParameter("id");
        String msg;
        int id;

        try {
            id = Integer.parseInt(idStr);
            MedicamentoDAO dao = MedicamentoDAO.getInstance();
            boolean removido = dao.removerMedicamentoPorId(id);
            if (removido) {
                msg = "Medicamento removido com sucesso!";
                request.setAttribute("classAlert", "p-0 alert alert-danger");
            } else {
                msg = "Medicamento não encontrado.";
                request.setAttribute("classAlert", "p-0 alert alert-warning");
            }
        } catch (NumberFormatException e) {
            msg = "ID inválido.";
            request.setAttribute("classAlert", "p-0 alert alert-danger");
        }

        request.setAttribute("mensagem", msg);
        response.sendRedirect(contextPath + "/medicamento/lista-medicamentos.html");
    }
}
