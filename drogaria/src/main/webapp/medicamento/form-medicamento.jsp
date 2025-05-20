<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../include/header.jsp"></c:import>

<main class="container d-flex justify-content-center align-items-center" style="min-height: 80vh">
	<div>
		<h3 class="mb-2 txt-cyan">Cadastrar Medicamento</h3>
		<p class="text-secondary">Adicione um novo remédio ao sistema</p>
		<form action="../CreateMedicamentoServlet" method="post" class="row">
			<div class="col-md-6 mb-3">
				<label for="nome" class="form-label">Nome</label> <input type="text"
					class="form-control" id="nome" name="nome" minlength="3" required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="principio_ativo" class="form-label">Princípio
					Ativo</label> <input type="text" class="form-control" id="principio_ativo"
					name="principio_ativo" required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="fabricante" class="form-label">Fabricante</label> <input
					type="text" class="form-control" id="fabricante" name="fabricante"
					required>
			</div>
			
			<div class="col-md-6 mb-3">
				<label for="validade" class="form-label">Validade</label> <input
					type="date" class="form-control" id="validade" name="validade"
					required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="lote" class="form-label">Lote</label> <input type="text"
					class="form-control" id="lote" name="lote" required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="indicacao" class="form-label">Indicação</label> <input
					type="text" class="form-control" id="indicacao" name="indicacao"
					required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="dosagem" class="form-label">Dosagem</label> <input
					type="text" class="form-control" id="dosagem" name="dosagem"
					required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="forma" class="form-label">Forma</label> <input
					type="text" class="form-control" id="forma" name="forma" required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="preco" class="form-label">Preço</label> <input
					type="number" step="0.01" class="form-control" id="preco"
					name="preco" required>
			</div>
	
			<div class="col-md-6 mb-3">
				<label for="imagem_url" class="form-label">URL da Imagem</label> <input
					type="url" class="form-control" id="imagem_url" name="imagem_url"
					maxlength="255">
			</div>
	
			<div class="col-12 mt-1">
				<button type="submit" class="btn bg-cyan w-100">Cadastrar</button>
			</div>
		</form>
	</div>
</main>

<c:import url="../include/footer.jsp"></c:import>