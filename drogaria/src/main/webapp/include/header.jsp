<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<title>Drogaria</title>
</head>
<body>
	<c:if test="${not empty mensagem}">
		<div class="${classAlert}" role="alert">
			<p>${mensagem}</p>
		</div>
	</c:if>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">drogas drogas droguinhas</a>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<% if (session.getAttribute("usuarioLogado") != null) { %>
				<li class="nav-item">
					<a class="nav-link text-danger" href="#" data-toggle="modal" data-target="#logoutModal">Sair</a>
				</li>
				<% } else { %>
				<li class="nav-item">
					<a class="nav-link" href="login.jsp">Login</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cadastrarADM.jsp">Cadastrar</a>
				</li>
				<% } %>
			</ul>
		</div>
	</nav>

	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="logoutModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="logoutModalLabel">Confirmar Logout</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Deseja realmente sair?</p>
				</div>
				<div class="modal-footer">
					<a href="logout.jsp" class="btn btn-danger">Sair</a>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
				</div>
			</div>
		</div>
	</div>