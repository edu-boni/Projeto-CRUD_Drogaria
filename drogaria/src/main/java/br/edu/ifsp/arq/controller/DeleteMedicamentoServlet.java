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
        String classAlert;
        int id;

        try {
            id = Integer.parseInt(idStr);
            MedicamentoDAO dao = MedicamentoDAO.getInstance();
            boolean removido = dao.removerMedicamentoPorId(id);
            if (removido) {
                msg = "Medicamento removido com sucesso!";
                classAlert = "alert-success"; 
            } else {
                msg = "Medicamento não encontrado.";
                classAlert = "alert-warning";
            }
        } catch (NumberFormatException e) {
            msg = "ID inválido.";
            classAlert = "alert-danger";
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("mensagem", msg);
        session.setAttribute("mensagem-cor", classAlert);

        response.sendRedirect(contextPath + "/medicamento/lista-medicamentos.html");
    }
}
