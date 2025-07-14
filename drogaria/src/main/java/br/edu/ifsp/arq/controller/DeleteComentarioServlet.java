package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Usuario;
import com.google.gson.Gson;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/delete-comentario")
public class DeleteComentarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, String> result = new HashMap<>();

        HttpSession session = request.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;

        if (usuarioLogado == null || !usuarioLogado.isAdmin()) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            result.put("message", "Acesso negado.");
            response.getWriter().write(new Gson().toJson(result));
            return;
        }

        try {
            int medicamentoId = Integer.parseInt(request.getParameter("medicamentoId"));
            int comentarioId = Integer.parseInt(request.getParameter("comentarioId"));

            boolean sucesso = MedicamentoDAO.getInstance().removerComentario(medicamentoId, comentarioId);

            if (sucesso) {
                result.put("message", "Comentário excluído com sucesso!");
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                result.put("message", "Comentário ou medicamento não encontrado.");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            result.put("message", "Erro ao processar a solicitação.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }

        response.getWriter().write(new Gson().toJson(result));
    }
}
