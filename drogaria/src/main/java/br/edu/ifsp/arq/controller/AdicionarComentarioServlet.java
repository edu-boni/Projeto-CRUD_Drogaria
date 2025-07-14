package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.dao.MedicamentoDAO;
import br.edu.ifsp.arq.model.Comentario;
import br.edu.ifsp.arq.model.Usuario;
import com.google.gson.Gson;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/adicionar-comentario")
public class AdicionarComentarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogado") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            result.put("message", "Você precisa estar logado para comentar.");
            response.getWriter().write(new Gson().toJson(result));
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");

        if (usuario.isAdmin()) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            result.put("message", "Administradores não podem adicionar comentários.");
            response.getWriter().write(new Gson().toJson(result));
            return;
        }

        try {
            int medicamentoId = Integer.parseInt(request.getParameter("medicamentoId"));
            String texto = request.getParameter("texto");
            
            if (texto == null || texto.trim().isEmpty()) {
                 response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                 result.put("message", "É necessário escrever algo.");
                 response.getWriter().write(new Gson().toJson(result));
                 return;
            }

            Comentario novoComentario = new Comentario(usuario.getNome(), texto);
            boolean sucesso = MedicamentoDAO.getInstance().adicionarComentario(medicamentoId, novoComentario);

            if (sucesso) {
                response.setStatus(HttpServletResponse.SC_OK);
                result.put("message", "Comentário adicionado com sucesso!");
                result.put("comentario", novoComentario);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                result.put("message", "Medicamento não encontrado.");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            result.put("message", "Dados inválidos.");
        }
        
        response.getWriter().write(new Gson().toJson(result));
    }
}