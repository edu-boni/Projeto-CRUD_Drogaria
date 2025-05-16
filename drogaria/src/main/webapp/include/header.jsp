<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String contextPath = request.getContextPath();%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="<%= contextPath %>/util/style.css">

<title>Drogaria</title>
</head>
<body>
	<header>
		<%@ page import="br.edu.ifsp.arq.model.Administrador" %>
		<nav class="navbar navbar-expand-md" style="background-color: #93c7cc;">
		  <div class="container-fluid">
		    <div class="row w-100 align-items-center">
		
		      <!-- LOGO -->
		      <div class="col-12 col-md-3 d-flex justify-content-center justify-content-md-start align-items-center mb-2 mb-md-0">
		        <div class="navbar-brand text-white font-weight-bold d-flex align-items-center">
		          <img src="<%= contextPath %>/images/logo.png" alt="Logo" style="height: 50px; margin-right: 10px;">
		        </div>
		      </div>
		
		      <!-- BARRA DE BUSCA -->
		      <div class="col-12 col-md-6 d-flex justify-content-center align-items-center mb-2 mb-md-0">
				<form action="buscar-medicamento" method="get" class="w-100 px-3 px-md-0" style="max-width: 600px;">
				  <div class="input-group">
				    <input name="search" class="form-control rounded-pill px-4" type="search" placeholder="Buscar" aria-label="Buscar">
				    <div class="input-group-append">
				      <button class="btn rounded-pill ml-2" type="submit" style="background-color: white; color: #333;">
				        <i class="fas fa-search"></i>
				      </button>
				    </div>
				  </div>
				</form>
		      </div>
		
		      <!-- MENU -->
		      <div class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
		        <ul class="navbar-nav w-100 w-md-auto flex-row flex-wrap justify-content-center justify-content-md-end">
		          
		          <li class="nav-item mx-2">
		            <a class="nav-link text-white font-weight-bold" href="<%= contextPath %>/index.jsp"><i class="fas fa-home"></i> Início</a>
		          </li>
		
		          <li class="nav-item mx-2">
		            <a class="nav-link text-white font-weight-bold" href="#"><i class="fas fa-info-circle"></i> Sobre</a>
		          </li>
		
		          <% if (session.getAttribute("usuarioLogado") != null) {
		               Administrador usuario = (Administrador) session.getAttribute("usuarioLogado");
		          %>
		          <li class="nav-item mx-2">
				  <% if (session.getAttribute("usuarioLogado") == null) { %>
				    <a class="nav-link text-white font-weight-bold" href="#" data-toggle="modal" data-target="#loginModal">
				      <i class="fas fa-plus-circle"></i> Cadastrar medicamento
				    </a>
				  <% } else { %>
				    <a class="nav-link text-white font-weight-bold" href="<%= contextPath %>/medicamento/form-medicamento.jsp">
				      <i class="fas fa-plus-circle"></i> Cadastrar medicamento
				    </a>
				  <% } %>
				  </li>

		
		          <li class="nav-item dropdown mx-2">
		            <a class="nav-link dropdown-toggle text-white font-weight-bold d-flex align-items-center" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
		              <i class="fas fa-user mr-1"></i> <%= usuario.getNome() %>
		            </a>
		            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
		              <a class="dropdown-item" href="<%= contextPath %>/adm/editar-adm.jsp">Meus dados</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item text-danger" href="#" data-toggle="modal" data-target="#logoutModal">Sair</a>
		            </div>
		          </li>
		          <% } else { %>
		          <li class="nav-item mx-2">
					<a class="nav-link text-white font-weight-bold" href="<%= contextPath %>/adm/login.jsp">
					  <i class="fas fa-user"></i> Login
					</a>		          
				</li>
		          <% } %>
		
		        </ul>
		      </div>
		
		    </div>
		  </div>
		</nav>
		<div class="container">
		<c:if test="${not empty mensagem}">
			<div class="${classAlert}" role="alert">
				<p>${mensagem}</p>
			</div>
		</c:if>
		</div>
	</header>
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
					<a href="<%= contextPath %>/adm/logout.jsp" class="btn btn-danger">Sair</a>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
				</div>
			</div>
		</div>
	</div>