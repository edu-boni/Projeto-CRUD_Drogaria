<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="br.edu.ifsp.arq.model.Medicamento" %>
<% Medicamento m = (Medicamento) request.getAttribute("medicamento"); %>

<c:import url="../include/header.jsp"></c:import>

<div class="container mt-5">
    <h2 class="mb-4">Editar Medicamento</h2>
    <form action="./UpdateMedicamentoServlet" method="post" class="row g-3">
        <input type="hidden" name="id" value="<%= m.getId() %>"/>

        <div class="col-md-6">
            <label for="nome" class="form-label">Nome</label>
            <input type="text" class="form-control" id="nome" name="nome" value="<%= m.getNome() %>" required maxlength="100" placeholder="Ex: Paracetamol">
        </div>

        <div class="col-md-6">
            <label for="principio_ativo" class="form-label">Princípio Ativo</label>
            <input type="text" class="form-control" id="principio_ativo" name="principio_ativo" value="<%= m.getPrincipio_ativo() %>" required maxlength="100" placeholder="Ex: Paracetamol">
        </div>

        <div class="col-md-6">
            <label for="fabricante" class="form-label">Fabricante</label>
            <input type="text" class="form-control" id="fabricante" name="fabricante" value="<%= m.getFabricante() %>" maxlength="100" placeholder="Ex: EMS">
        </div>

        <div class="col-md-6">
            <label for="validade" class="form-label">Validade</label>
            <input type="date" class="form-control" id="validade" name="validade" value="<%= m.getValidade() %>" required>
        </div>

        <div class="col-md-6">
            <label for="lote" class="form-label">Lote</label>
            <input type="text" class="form-control" id="lote" name="lote" value="<%= m.getLote() %>" maxlength="50" placeholder="Ex: 12345">
        </div>

        <div class="col-md-6">
            <label for="indicacao" class="form-label">Indicação</label>
            <input type="text" class="form-control" id="indicacao" name="indicacao" value="<%= m.getIndicacao() %>" maxlength="200" placeholder="Ex: Dor e febre">
        </div>

        <div class="col-md-6">
            <label for="dosagem" class="form-label">Dosagem</label>
            <input type="text" class="form-control" id="dosagem" name="dosagem" value="<%= m.getDosagem() %>" maxlength="50" placeholder="Ex: 500 mg">
        </div>

        <div class="col-md-6">
            <label for="forma" class="form-label">Forma</label>
            <input type="text" class="form-control" id="forma" name="forma" value="<%= m.getForma() %>" maxlength="50" placeholder="Ex: Comprimido">
        </div>

        <div class="col-md-6">
            <label for="preco" class="form-label">Preço (R$)</label>
            <input type="number" class="form-control" id="preco" name="preco" value="<%= m.getPreco() %>" step="0.01" min="0" required placeholder="Ex: 10.99">
        </div>

        <div class="col-md-12">
            <label for="imagem_url" class="form-label">URL da Imagem</label>
            <input type="url" class="form-control" id="imagem_url" name="imagem_url" value="<%= m.getImagem_url() %>" maxlength="255">
        </div>

        <div class="col-12">
            <button type="submit" class="btn btn-primary">Atualizar</button>
        </div>
    </form>
</div>

<c:import url="../include/footer.jsp"></c:import>