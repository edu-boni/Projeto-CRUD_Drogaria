package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Categoria;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet({"/editar-medicamento", "/UpdateMedicamentoServlet"})
public class UpdateMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"ID inválido.\"}");
            return;
        }

        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        Medicamento med = dao.getMedicamentoPorId(id);
        if (med == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Medicamento não encontrado.\"}");
            return;
        }

        String json = new com.google.gson.Gson().toJson(med);
        response.getWriter().write(json);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String msg;
        int id;

        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            msg = "{\"success\": false, \"message\": \"ID inválido.\"}";
            response.getWriter().write(msg);
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
        String categoriaStr = request.getParameter("categoria");
        String descontoStr = request.getParameter("desconto");

        double preco;
        double desconto = 0.0;
        Categoria categoria = null;
        
        try {
            preco = Double.parseDouble(precoStr);
            if (descontoStr != null && !descontoStr.isEmpty()) {
                desconto = Double.parseDouble(descontoStr);
            }
            if (categoriaStr != null && !categoriaStr.isEmpty()) {
                categoria = Categoria.valueOf(categoriaStr);
            }
        } catch (NumberFormatException e) {
            msg = "{\"success\": false, \"message\": \"Preço ou desconto inválido.\"}";
            response.getWriter().write(msg);
            return;
        } catch (IllegalArgumentException e) {
            msg = "{\"success\": false, \"message\": \"Categoria inválida.\"}";
            response.getWriter().write(msg);
            return;
        }

        Medicamento medicamentoAtualizado = new Medicamento(nome, principio, fabricante, validade, lote, indicacao, dosagem, forma, preco, imagem_url, categoria, desconto);

        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        boolean atualizado = dao.atualizarMedicamento(id, medicamentoAtualizado);

        if (atualizado) {
            msg = "{\"success\": true, \"message\": \"Medicamento atualizado com sucesso!\"}";
        } else {
            msg = "{\"success\": false, \"message\": \"Medicamento não encontrado para atualização.\"}";
        }

        response.getWriter().write(msg);
    }
}
