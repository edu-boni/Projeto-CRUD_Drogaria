<%@page import="br.edu.ifsp.arq.model.Administrador"%>
<%@ page import="java.util.*, br.edu.ifsp.arq.model.Medicamento"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="/include/header.jsp"></c:import>

<main class="container mt-5" style="min-height: 80vh">
	<% 
	  	String contextPath = request.getContextPath();
	    boolean usuarioLogado = session.getAttribute("usuarioLogado") != null;
	    
	    Administrador a = (Administrador) request.getAttribute("administrador");
	    if (a == null) {
	        a = (Administrador) session.getAttribute("usuarioLogado");
	    }
	    
	    String saudacao;
	    java.util.Calendar agora = java.util.Calendar.getInstance();
	    int hora = agora.get(java.util.Calendar.HOUR_OF_DAY);
	    if (hora >= 5 && hora < 12) {
	        saudacao = "Bom dia";
	    } else if (hora >= 12 && hora < 18) {
	        saudacao = "Boa tarde";
	    } else {
	        saudacao = "Boa noite";
	    }
	%>
	
	<% if (usuarioLogado) { %>
	    <h2><%= saudacao %>, <span class="txt-cyan"><%= a.getNome() %></span>!</h2>
	    <a href="<%= contextPath %>/medicamento/form-medicamento.jsp"
	       class="btn w-100 bg-cyan custom-gradient p-3 text-right font-weight-bold mb-4 mt-1">
	        <i class="fas fa-plus-circle"></i> Cadastrar medicamento
	    </a>
	<% } %>

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
		<!--  Em destaque -->
		<div class="container mb-5">
	    <div class="mb-5 d-flex justify-content-between align-bottom">
	        <h3>Em destaque</h3>
	    </div>
	    <div class="row">
	        <c:set var="size" value="${fn:length(listaMedicamentos)}"/>
	        <c:set var="max" value="${size < 4 ? size : 4}"/>
	        
	        <!-- Início do card -->
	        <c:forEach var="i" begin="0" end="${max - 1}">
	            <c:set var="reverseIndex" value="${size - 1 - i}"/>
	            <c:set var="med" value="${listaMedicamentos[reverseIndex]}"/>
				
				<% if(usuarioLogado){ %>
	            	<div class="col-md-3 col-sm-12 mb-4 d-flex flex-column align-items-center hover-card" data-toggle="modal" data-target="#modal-${med.id}">
	            <% }else{ %>
	           		<div class="col-md-3 col-sm-12 mb-4 d-flex flex-column align-items-center hover-card" data-toggle="modal" data-target="#loginModal">
	            <% } %>
					<c:choose>
					  <c:when test="${empty med.imagem_url}">
					    <img src="/drogaria/images/semimagem.png" alt="Imagem padrão" class="img-fluid mb-4" style="max-height:120px;" />
					  </c:when>
					  <c:otherwise>
					    <img src="${med.imagem_url}" alt="${med.nome}" class="img-fluid mb-4" style="max-height:120px;" onerror="this.onerror=null;this.src='/drogaria/images/semimagem.png';" />
					  </c:otherwise>
					</c:choose>
	                <div class="p-3 w-100 bg-cyan-light" style="border-radius: 6px;">
	                    <p class="txt-cyan" style="font-size: 20px; font-weight: bold; margin: 0">${med.nome}</p>
	                    <p class="txt-cyan" style="margin: 0">${med.dosagem}</p>
						<% if(usuarioLogado){ %>
						    <p class="mt-1 mb-0 text-secondary" style="font-size: 15px; text-decoration: line-through">
						        R$ <fmt:formatNumber value="${med.preco}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
						    </p>
						    <div class="d-flex space-between align-items-center" style="font-size: 20px; font-weight: bold">
						        <p>R$ <fmt:formatNumber value="${med.preco * 0.9}" type="number" minFractionDigits="2" maxFractionDigits="2"/></p>
						        <p class="text-danger col-md-6"><i class="fas fa-solid fa-tag"></i> -10%</p>
						    </div>
						<% }else{ %>
						    <p class="mt-1 mb-0" style="font-size: 20px; font-weight: bold">
						        R$ <fmt:formatNumber value="${med.preco}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
						    </p>
						<% } %>
	                </div>
	            </div>
	            
	           	<% if (usuarioLogado) { %>
	           	<!-- Início do modal -->
	           	<c:import url="medicamento/editar-medicamento.jsp">
				    <c:param name="id" value="${med.id}" />
				    <c:param name="nome" value="${med.nome}" />
				    <c:param name="principio_ativo" value="${med.principio_ativo}" />
				    <c:param name="fabricante" value="${med.fabricante}" />
				    <c:param name="validade" value="${med.validade}" />
				    <c:param name="lote" value="${med.lote}" />
				    <c:param name="indicacao" value="${med.indicacao}" />
				    <c:param name="dosagem" value="${med.dosagem}" />
				    <c:param name="forma" value="${med.forma}" />
				    <c:param name="preco" value="${med.preco}" />
				    <c:param name="imagem_url" value="${med.imagem_url}" />
				  </c:import>
				<% } %>
	        </c:forEach>
	   	 </div>
	   	 </div>
	    
	    <!-- Todos -->
	    <div class="container mb-5">
	    <div class="mb-5 d-flex justify-content-between align-bottom">
    		<h3>Todos os medicamentos</h3>
		    <a href="<%= contextPath %>/medicamento/listar-medicamentos.jsp" class="text-secondary">Ver mais</a>
		</div>
		<div class="row">
		    <c:set var="size" value="${fn:length(listaMedicamentos)}"/>
		    <c:set var="max" value="${size < 8 ? size : 8}"/>
		
			<!-- Início card -->
		    <c:forEach var="i" begin="0" end="${max - 1}">
		        <c:set var="med" value="${listaMedicamentos[i]}"/>
					<% if(usuarioLogado){ %>
		            	<div class="col-md-3 col-sm-12 mb-4 d-flex flex-column align-items-center hover-card" data-toggle="modal" data-target="#modal-${med.id}">
		            <% }else{ %>
		           		<div class="col-md-3 col-sm-12 mb-4 d-flex flex-column align-items-center hover-card" data-toggle="modal" data-target="#loginModal">
		            <% } %>
		            <c:choose>
					  <c:when test="${empty med.imagem_url}">
					    <img src="/drogaria/images/semimagem.png" alt="Imagem padrão" class="img-fluid mb-4" style="max-height:120px;" />
					  </c:when>
					  <c:otherwise>
					    <img src="${med.imagem_url}" alt="${med.nome}" class="img-fluid mb-4" style="max-height:120px;" onerror="this.onerror=null;this.src='/drogaria/images/semimagem.png';" />
					  </c:otherwise>
					</c:choose>
		            <div class="p-3 w-100 bg-cyan-light" style="border-radius: 6px;">
		                <p class="txt-cyan" style="font-size: 20px; font-weight: bold; margin: 0">${med.nome}</p>
		                <p class="txt-cyan" style="margin: 0">${med.dosagem}</p>
		               	<% if(usuarioLogado){ %>
						    <p class="mt-1 mb-0 text-secondary" style="font-size: 15px; text-decoration: line-through">
						        R$ <fmt:formatNumber value="${med.preco}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
						    </p>
						    <div class="d-flex space-between align-items-center" style="font-size: 20px; font-weight: bold">
						        <p>R$ <fmt:formatNumber value="${med.preco * 0.9}" type="number" minFractionDigits="2" maxFractionDigits="2"/></p>
						        <p class="text-danger col-md-6"><i class="fas fa-solid fa-tag"></i> -10%</p>
						    </div>
						<% }else{ %>
						    <p class="mt-1 mb-0" style="font-size: 20px; font-weight: bold">
						        R$ <fmt:formatNumber value="${med.preco}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
						    </p>
						<% } %>
		            </div>
		        </div>
		        
		        <% if (usuarioLogado) { %>
		        <!-- Início do modal -->
	             <c:import url="medicamento/editar-medicamento.jsp">
				    <c:param name="id" value="${med.id}" />
				    <c:param name="nome" value="${med.nome}" />
				    <c:param name="principio_ativo" value="${med.principio_ativo}" />
				    <c:param name="fabricante" value="${med.fabricante}" />
				    <c:param name="validade" value="${med.validade}" />
				    <c:param name="lote" value="${med.lote}" />
				    <c:param name="indicacao" value="${med.indicacao}" />
				    <c:param name="dosagem" value="${med.dosagem}" />
				    <c:param name="forma" value="${med.forma}" />
				    <c:param name="preco" value="${med.preco}" />
				    <c:param name="imagem_url" value="${med.imagem_url}" />
				  </c:import>
				<% } %>
		    </c:forEach>
		</div>
		</div>
	</c:if>
	
	<c:if test="${empty listaMedicamentos}">
	    <div class="container mt-3 mb-5 p-3 bg-light">
	        <p class="text-center text m-1">No momento estamos sem medicamentos cadastrados :/</p>
	    </div>
	</c:if>

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
				<h5 class="mb-3 text-center txt-cyan">Cadastre-se</h5>
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
						<a href="<%= contextPath %>/public/cadastrar.jsp"
						class="btn btn-secondary w-100 m-1">Criar uma conta</a>
						<a href="<%= contextPath %>/public/login.jsp"
						class="btn bg-cyan w-100 m-1">Fazer login</a> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<% } %>
</main>

<c:import url="/include/footer.jsp"></c:import>