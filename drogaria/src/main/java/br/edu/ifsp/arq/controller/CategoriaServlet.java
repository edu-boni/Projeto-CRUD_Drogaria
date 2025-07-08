package br.edu.ifsp.arq.controller;

import br.edu.ifsp.arq.model.Categoria;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/CategoriaServlet")
public class CategoriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<Map<String, String>> categoriasList = new ArrayList<>();
        
        for (Categoria cat : Categoria.values()) {
            Map<String, String> categoriaMap = new HashMap<>();
            categoriaMap.put("value", cat.name()); 
            categoriaMap.put("text", cat.getDescricao()); 
            categoriasList.add(categoriaMap);
        }

        String json = new Gson().toJson(categoriasList);
        response.getWriter().write(json);
    }
}