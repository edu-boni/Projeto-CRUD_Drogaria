package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;

@WebServlet("/ReadMedicamentoServlet")
public class ReadMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        String idParam = request.getParameter("id");

        Object resultado;

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Medicamento medicamento = dao.getMedicamentoPorId(id);
                resultado = medicamento != null ? medicamento : new Object();
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"erro\":\"ID inválido\"}");
                return;
            }
        } else {
            List<Medicamento> lista = dao.getMedicamentos();
            resultado = lista;
        }

        String json = new Gson().toJson(resultado);
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
