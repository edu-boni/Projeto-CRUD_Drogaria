package br.edu.ifsp.arq.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.Gson;
import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Categoria; 
import br.edu.ifsp.arq.model.Medicamento;

@WebServlet("/buscar-medicamento")
public class BuscarMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String termoBusca = request.getParameter("search");
        String categoria = request.getParameter("categoria");

        ArrayList<Medicamento> resultados = MedicamentoDAO.getInstance().buscar(termoBusca, categoria);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = new Gson().toJson(resultados);
        
        response.getWriter().write(json);
    }
}