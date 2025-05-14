<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="br.edu.ifsp.arq.model.Medicamento" %>
<% Medicamento m = (Medicamento) request.getAttribute("medicamento"); %>
<c:import url="../include/header.jsp"></c:import>

<form action="UpdateMedicamentoServlet" method="post">
    <input type="hidden" name="id" value="<%= m.getId() %>"/>

    <label for="nome">Nome:</label><br>
    <input type="text" id="nome" name="nome" value="<%= m.getNome() %>" required maxlength="100" placeholder="Ex: Paracetamol"><br>

    <label for="principio_ativo">Princípio Ativo:</label><br>
    <input type="text" id="principio_ativo" name="principio_ativo" value="<%= m.getPrincipio_ativo() %>" required maxlength="100" placeholder="Ex: Paracetamol"><br>

    <label for="fabricante">Fabricante:</label><br>
    <input type="text" id="fabricante" name="fabricante" value="<%= m.getFabricante() %>" maxlength="100" placeholder="Ex: EMS"><br>

    <label for="validade">Validade:</label><br>
    <input type="date" id="validade" name="validade" value="<%= m.getValidade() %>" required><br>

    <label for="lote">Lote:</label><br>
    <input type="text" id="lote" name="lote" value="<%= m.getLote() %>" maxlength="50" placeholder="Ex: 12345"><br>

    <label for="indicacao">Indicação:</label><br>
    <input type="text" id="indicacao" name="indicacao" value="<%= m.getIndicacao() %>" maxlength="200" placeholder="Ex: Dor e febre"><br>

    <label for="dosagem">Dosagem:</label><br>
    <input type="text" id="dosagem" name="dosagem" value="<%= m.getDosagem() %>" maxlength="50" placeholder="Ex: 500 mg"><br>

    <label for="forma">Forma:</label><br>
    <input type="text" id="forma" name="forma" value="<%= m.getForma() %>" maxlength="50" placeholder="Ex: Comprimido"><br>

    <label for="preco">Preço (R$):</label><br>
    <input type="number" id="preco" name="preco" value="<%= m.getPreco() %>" step="0.01" min="0" required placeholder="Ex: 10.99"><br>

    <label for="imagem_url">URL da Imagem:</label><br>
    <input type="url" id="imagem_url" name="imagem_url" value="<%= m.getImagem_url() %>" maxlength="255"><br>

    <input type="submit" value="Atualizar">
</form>

<c:import url="../include/footer.jsp"></c:import>