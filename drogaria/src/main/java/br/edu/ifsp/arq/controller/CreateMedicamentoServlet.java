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
            
            if(medicamento.getId() == 1) {
                List<Medicamento> mocks = new ArrayList<>();
                mocks.add(new Medicamento("Paracetamol", "Paracetamol", "Medley", "2025-12-31", "L001", "Dor e febre", "500mg", "Comprimido", 5.99, "images/paracetamol.png"));
                mocks.add(new Medicamento("Dipirona", "Dipirona Monoidratada", "Neo Química", "2026-06-15", "L002", "Analgésico", "1g", "Comprimido", 4.50, "images/dipirona.png"));
                mocks.add(new Medicamento("Ibuprofeno", "Ibuprofeno", "Bayer", "2026-01-20", "L003", "Inflamação e dor", "600mg", "Comprimido", 7.90, "images/ibuprofeno.png"));
                mocks.add(new Medicamento("Amoxicilina", "Amoxicilina", "EMS", "2025-11-10", "L004", "Infecção bacteriana", "500mg", "Cápsula", 12.75, "images/amoxicilina.png"));
                mocks.add(new Medicamento("Loratadina", "Loratadina", "Medquímica", "2026-04-01", "L005", "Alergia", "10mg", "Comprimido", 3.80, "images/loratadina.png"));
                mocks.add(new Medicamento("Omeprazol", "Omeprazol", "Eurofarma", "2026-02-14", "L006", "Refluxo", "20mg", "Cápsula", 6.20, "images/omeprazol.png"));
                mocks.add(new Medicamento("Salbutamol", "Salbutamol", "GSK", "2025-09-30", "L007", "Asma", "100mcg", "Spray", 15.30, "images/salbutamol.png"));
                mocks.add(new Medicamento("Metformina", "Metformina", "Teuto", "2026-03-22", "L008", "Diabetes tipo 2", "850mg", "Comprimido", 8.60, "images/metformina.png"));
                mocks.add(new Medicamento("Cetoconazol", "Cetoconazol", "Prati-Donaduzzi", "2025-10-05", "L009", "Infecções fúngicas", "200mg", "Comprimido", 9.45, "images/cetoconazol.png"));
                mocks.add(new Medicamento("Azitromicina", "Azitromicina", "EMS", "2026-07-18", "L010", "Infecção respiratória", "500mg", "Comprimido", 18.99, "images/azitromicina.png"));

                for (Medicamento m : mocks) {
                    dao.adicionarMedicamento(m);
                }
            }
        } else {
            msg = "Erro ao cadastrar o medicamento.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("classAlert", "p-0 alert alert-danger");
        }

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}