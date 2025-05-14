package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/ReadMedicamentoServlet")
public class ReadMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        ArrayList<Medicamento> lista = dao.getMedicamentos();

        request.setAttribute("listaMedicamentos", lista);
        request.getRequestDispatcher("/medicamento/listar-medicamentos.jsp").forward(request, response);
    }
    
    @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
