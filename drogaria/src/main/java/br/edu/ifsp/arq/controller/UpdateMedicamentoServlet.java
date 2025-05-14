package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet({"/editar-medicamento", "/UpdateMedicamentoServlet"})
public class UpdateMedicamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/editar-medicamento".equals(path)) {
            int id;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                // Usa sessão para manter padrão com doPost
                HttpSession session = request.getSession();
                session.setAttribute("mensagem", "ID inválido.");
                session.setAttribute("classAlert", "p-0 alert alert-danger");
                response.sendRedirect("ReadMedicamentoServlet");
                return;
            }

            MedicamentoDAO dao = MedicamentoDAO.getInstance();
            Medicamento m = dao.getMedicamentoPorId(id);

            if (m != null) {
                request.setAttribute("medicamento", m);
                request.getRequestDispatcher("medicamento/editar-medicamento.jsp").forward(request, response);
            } else {
                // Medicamento não encontrado
                HttpSession session = request.getSession();
                session.setAttribute("mensagem", "Medicamento não encontrado.");
                session.setAttribute("classAlert", "p-0 alert alert-danger");
                response.sendRedirect("ReadMedicamentoServlet");
            }
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String msg;
        int id;

        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            msg = "ID inválido.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "alert alert-danger");
            request.getRequestDispatcher("/ReadMedicamentoServlet").forward(request, response);
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

        double preco = 0.0;
        try {
            preco = Double.parseDouble(precoStr);
        } catch (NumberFormatException e) {
            msg = "Preço inválido.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "alert alert-danger");
            request.getRequestDispatcher("/ReadMedicamentoServlet").forward(request, response);
            return;
        }

        Medicamento medicamentoAtualizado = new Medicamento(nome, principio, fabricante, validade, lote, indicacao, dosagem, forma, preco, imagem_url);

        MedicamentoDAO dao = MedicamentoDAO.getInstance();
        boolean atualizado = dao.atualizarMedicamento(id, medicamentoAtualizado);

        if (atualizado) {
            msg = "Medicamento atualizado com sucesso!";
            request.setAttribute("classAlert", "alert alert-success");
        } else {
            msg = "Medicamento não encontrado para atualização.";
            request.setAttribute("classAlert", "alert alert-danger");
        }

        request.setAttribute("mensagem", msg);
        request.getRequestDispatcher("/ReadMedicamentoServlet").forward(request, response);
        
    }

}
