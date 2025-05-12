<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="br.edu.ifsp.arq.dao.MedicamentoDAO" %>
<%@ page import="br.edu.ifsp.arq.model.Medicamento" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2>Medicamentos Cadastrados</h2>

<%
    MedicamentoDAO dao = MedicamentoDAO.getInstance();
    ArrayList<Medicamento> lista = dao.getMedicamentos();

    if (lista.isEmpty()) {
%>
    <p>Nenhum medicamento cadastrado ainda.</p>
<%
    } else {
%>

<table>
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Princípio Ativo</th>
        <th>Fabricante</th>
        <th>Validade</th>
        <th>Lote</th>
        <th>Indicação</th>
        <th>Dosagem</th>
        <th>Forma</th>
        <th>Preço (R$)</th>
    </tr>
<%
    for (Medicamento m : lista) {
%>
    <tr>
        <td><%= m.getId() %></td>
        <td><%= m.getNome() %></td>
        <td><%= m.getPrincipio_ativo() %></td>
        <td><%= m.getFabricante() %></td>
        <td><%= m.getValidade() %></td>
        <td><%= m.getLote() %></td>
        <td><%= m.getIndicacao() %></td>
        <td><%= m.getDosagem() %></td>
        <td><%= m.getForma() %></td>
        <td><%= String.format("%.2f", m.getPreco()) %></td>
    </tr>
<%
    }
%>
</table>

<%
    }
%>

<br>
<a href="formMedicamento.jsp">Cadastrar novo medicamento</a>
<c:import url="footer.jsp"></c:import>
