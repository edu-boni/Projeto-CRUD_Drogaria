package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Medicamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/criar-medicamento")
public class CreateMedicamentoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	/*	HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("usuarioLogado") == null) {
			response.sendRedirect("erro.jsp");
			return;
		}*/
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

		double preco = 0.0;
		try {
			preco = Double.parseDouble(precoStr);
		} catch (NumberFormatException e) {
			request.setAttribute("erro", "Preço inválido.");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			return;
		}

		Medicamento medicamento = new Medicamento(
			nome, principio, fabricante, validade, lote,
			indicacao, dosagem, forma, preco
		);

		MedicamentoDAO dao = MedicamentoDAO.getInstance();
        if (dao.adicionarMedicamento(medicamento)) {
            msg = "Medicamento cadastrado com sucesso!";
            request.setAttribute("mensagem", msg);
            request.setAttribute("class-alert", "alert alert-success");
        } else {
            msg = "Erro ao cadastrar o medicamento.";
            request.setAttribute("mensagem", msg);
            request.setAttribute("class-alert", "alert alert-danger");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
	}
}
