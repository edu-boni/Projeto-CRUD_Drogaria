package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CreateMedicamentoServlet")
public class CreateMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogado") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String msg = "";
        String nome = request.getParameter("nome");
        String principio = request.getParameter("principio_ativo");
        String fabricante = request.getParameter("fabricante");
        String validade = request.getParameter("validade");
        String lote = request.getParameter("lote");
        String indicacao = request.getParameter("indicacao");
        String dosagem = request.getParameter("dosagem");
        String forma = request.getParameter("forma");
        String precoStr = request.getParameter("preco");
        String imagem_url = request.getParameter("imagem_url");

        double preco = 0.0;
        try {
            preco = Double.parseDouble(precoStr);
        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Preço inválido.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        Medicamento medicamento = new Medicamento(nome, principio, fabricante, validade, lote, indicacao, dosagem, forma, preco, imagem_url);

        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        
        if (dao.adicionarMedicamento(medicamento)) {
            msg = "Medicamento cadastrado com sucesso!";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "p-0 alert alert-success");

            getServletContext().setAttribute("listaMedicamentos", dao.getMedicamentos());

        } else {
            msg = "Erro ao cadastrar o medicamento.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "p-0 alert alert-danger");
        }

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}