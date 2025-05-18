<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*, br.edu.ifsp.arq.model.Medicamento"%>

<c:import url="/include/header.jsp"></c:import>

<main class="container mt-5" style="min-height: 80vh">
	<% 
  	String contextPath = request.getContextPath();
    boolean usuarioLogado = session.getAttribute("usuarioLogado") != null;
  %>

	<!-- Carrossel -->
	<div id="carousel" class="carousel slide mb-5" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carousel" data-slide-to="0" class="active"></li>
			<li data-target="#carousel" data-slide-to="1"></li>
			<li data-target="#carousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="<%= contextPath %>/images/1.png"
					class="d-block w-100 rounded" alt="...">
			</div>
			<div class="carousel-item">
				<img src="<%= contextPath %>/images/2.png"
					class="d-block w-100 rounded" alt="...">
			</div>
			<div class="carousel-item">
				<img src="<%= contextPath %>/images/3.png"
					class="d-block w-100 rounded" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-target="#carousel" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-target="#carousel" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
		</button>
	</div>

	<!-- Sessão de medicamentos -->
	<c:if test="${not empty listaMedicamentos}">
		<div class="row justify-content-center">
			<c:forEach var="med" items="${listaMedicamentos}" varStatus="loop">
				<c:if test="${loop.index < 6}">
					<div
						class="col-md-3 col-sm-6 mb-4 d-flex flex-column align-items-center">
						<img src="${med.imagem_url}" alt="${med.nome}"
							class="img-fluid mb-2" style="max-height: 120px;">
						<div class="p-2 w-100 text-center"
							style="background-color: #e8f5f2; border-radius: 6px;">
							<small class="text-muted d-block">${med.nome}</small> <small
								class="text-muted">${med.dosagem}</small>
							<p class="font-weight-bold mt-2 mb-0">R$ ${med.preco}</p>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${empty listaMedicamentos}">
		<div class="container mt-3 mb-5 p-3 bg-light">
			<p class="text-center text m-1">Nenhum medicamento encontrado :/</p>
		</div>
	</c:if>
	
	<%if (usuarioLogado){ %>
		<button>AAAAA</button>
	<% } %>


	<!-- Sessão vantagens e cadastro -->
	<% if (!usuarioLogado) { %>
	<section>
		<div class="row align-items-center">
			<!-- Ilustração do médico -->
			<div class="col-md-4 text-center d-none d-md-block">
				<img src="<%= contextPath %>/images/medico.png" alt="Médico"
					class="img-fluid" style="max-height: 300px;">
			</div>
			<!-- Vantagens -->
			<div class="col-md-3 text-center">
				<h5 class="mb-3 txt-cyan">Vantagens do cadastro</h5>
				<button
					class="btn btn-light rounded-circle w-100 h-100 vantagem mb-3 text-white bg-cyan"
					data-toggle="modal" data-target="#loginModal">
					<b><i class="fas fa-solid fa-tag"></i><br>Ofertas exclusivas</b>
				</button>
				<button
					class="btn btn-light rounded-circle w-100 h-100 vantagem mb-3 text-white bg-cyan"
					data-toggle="modal" data-target="#loginModal">
					<b><i class="fas fa-solid fa-plus"></i><br>Cadastrar remédios</b>
				</button>
			</div>
			<!-- Formulário de cadastro -->
			<div class="col-md-5">
				<h5 class="mb-3 text-center">Cadastre-se</h5>
				<form action="<%= contextPath %>/CreateAdminServlet" method="post">
					<div class="form-row">
						<div class="form-group col-6">
							<input type="text" name="nome" class="form-control"
								placeholder="Nome completo" required>
						</div>
						<div class="form-group col-6">
							<input type="text" name="cpf" class="form-control"
								placeholder="CPF">
						</div>
					</div>
					<div class="form-group">
						<input type="email" name="email" class="form-control"
							placeholder="e-mail" required>
					</div>
					<div class="form-group">
						<input type="password" name="senha" class="form-control"
							placeholder="Senha" required>
					</div>
					<button type="submit" class="btn bg-cyan btn-block mt-2">Cadastrar</button>
				</form>
			</div>
		</div>
	</section>
	<% } %>

	<!-- Modal de login -->
	<% if (!usuarioLogado) { %>
	<div class="modal fade" id="loginModal" tabindex="-1"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 shadow-lg">
				<div class="modal-header bg-cyan">
					<h5 class="modal-title">Acesso Restrito</h5>
					<button type="button" class="close text-white" data-dismiss="modal"
						aria-label="Fechar">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Para acessar este conteúdo, você precisa estar logado.</p>
					<div class="d-flex justify-content-between">
						<a href="<%= contextPath %>/cadastrar.jsp"
						class="btn btn-secondary w-100 m-1">Ainda não tenho uma conta</a>
						<a href="<%= contextPath %>/login.jsp"
						class="btn bg-cyan w-100 m-1">Fazer login</a> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<% } %>
</main>

<c:import url="/include/footer.jsp"></c:import>