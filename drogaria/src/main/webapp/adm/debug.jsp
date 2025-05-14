<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="br.edu.ifsp.arq.model.Administrador" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debug da Sessão</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h2 { color: #444; }
        .box { background: #f4f4f4; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .attr { margin-bottom: 10px; }
        .key { font-weight: bold; color: #333; }
        .value { color: #555; }
    </style>
</head>
<body>

<h2>Atributos da Sessão</h2>

<div class="box">
<%
    HttpSession sessao = request.getSession(false);
    if (sessao == null) {
%>
        <p class="value">Nenhuma sessão ativa.</p>
<%
    } else {
        Enumeration<String> nomes = sessao.getAttributeNames();
        while (nomes.hasMoreElements()) {
            String nome = nomes.nextElement();
            Object valor = sessao.getAttribute(nome);
%>
            <div class="attr">
                <span class="key"><%= nome %></span>: 
                <span class="value">
                    <%= valor != null ? valor.toString() : "null" %>
                </span>
            </div>
<%
        }
    }
%>
</div>

</body>
</html>
