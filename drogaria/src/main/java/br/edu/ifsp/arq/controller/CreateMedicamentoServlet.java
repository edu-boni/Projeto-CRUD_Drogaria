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
    private MedicamentoDAO dao;

    @Override
    public void init() throws ServletException {
        dao = MedicamentoDAO.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogado") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"message\": \"Sessão expirada. Faça login novamente.\"}");
            return;
        }

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

        String jsonResponse;

        double preco = 0.0;
        try {
            preco = Double.parseDouble(precoStr);
        } catch (NumberFormatException e) {
            jsonResponse = "{\"message\": \"Preço inválido.\"}";
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(jsonResponse);
            return;
        }

        Medicamento medicamento = new Medicamento(nome, principio, fabricante, validade, lote, indicacao, dosagem, forma, preco, imagem_url);

        if (dao.adicionarMedicamento(medicamento)) {
            jsonResponse = String.format("{\"message\": \"Medicamento '%s' cadastrado com sucesso!\"}", nome);
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            jsonResponse = "{\"message\": \"Erro ao cadastrar o medicamento.\"}";
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        response.getWriter().write(jsonResponse);
    }
}
