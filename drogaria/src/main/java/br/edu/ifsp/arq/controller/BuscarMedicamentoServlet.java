package br.edu.ifsp.arq.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

@WebServlet("/buscar-medicamento")
public class BuscarMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String termoBusca = request.getParameter("search");
        ArrayList<Medicamento> resultados = MedicamentoDAO.getInstance().buscarPorNome(termoBusca);

        request.setAttribute("resultados", resultados);
        request.setAttribute("termoBusca", termoBusca);

        String msg;
        String classAlert;
        if (resultados.isEmpty()) {
            msg = "Nenhum medicamento encontrado com esse nome.";
            classAlert = "p-0 alert alert-warning";
        } else {
            msg = resultados.size() + " medicamento(s) encontrado(s).";
            classAlert = "p-0 alert alert-success";
        }

        request.setAttribute("mensagem", msg);
        request.setAttribute("classAlert", classAlert);

        getServletContext().getRequestDispatcher("/medicamento/resultado-busca.jsp").forward(request, response);
    }
}