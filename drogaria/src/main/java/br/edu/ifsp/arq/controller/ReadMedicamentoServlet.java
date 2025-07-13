package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.Gson;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/ReadMedicamentoServlet")
public class ReadMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        String idParam = request.getParameter("id");
        Object resultado; // Pode ser um único Medicamento ou uma Lista

        if (idParam != null && !idParam.isEmpty()) {
            // Se um ID foi passado na URL, busca apenas UM medicamento
            try {
                int id = Integer.parseInt(idParam);
                resultado = dao.getMedicamentoPorId(id);
            } catch (NumberFormatException e) {
                resultado = null; // ID inválido
            }
        } else {
            // Se nenhum ID foi passado, retorna a lista completa (comportamento antigo)
            resultado = dao.getMedicamentos();
        }

        String json = new Gson().toJson(resultado);
        response.getWriter().write(json);
    }

    
    @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
