<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% boolean usuarioLogado = session.getAttribute("usuarioLogado") != null; %>

<div id="header-placeholder"></div>

<div class="container mt-5 justify-content-center d-flex flex-column align-items-center" style="min-height: 80vh">
<% if (usuarioLogado) { %>
	
	<c:choose>
		<c:when test="${empty listaMedicamentos}">
		<div class="col-md-12 row d-flex">
			<h2 class="txt-cyan col-md-6 col-sm-12">Nenhum medicamento encontrado</h2>
			 <a href="/drogaria/medicamento/form-medicamento.jsp" class="btn col-md-6 col-sm-12 bg-cyan custom-gradient p-3 text-right font-weight-bold mb-5 mt-0"> <i class="fas fa-plus-circle"></i> Cadastrar medicamento</a>
		</div>
		</c:when>
		<c:otherwise>
			<div class="col-md-12 row d-flex">
				<h2 class="txt-cyan col-md-6 col-sm-12">Todos os medicamentos</h2>
			 	<a href="/drogaria/medicamento/form-medicamento.jsp" class="btn col-md-6 col-sm-12 bg-cyan custom-gradient p-3 text-right font-weight-bold mb-5 mt-0"> <i class="fas fa-plus-circle"></i> Cadastrar medicamento</a>
			</div>
			<div class="container mb-5">
			<div class="row">
			    <c:forEach var="med" items="${listaMedicamentos}">
	            	<div class="col-md-3 col-sm-12 mb-4 d-flex flex-column align-items-center hover-card" data-toggle="modal" data-target="#modal-${med.id}">
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
				    
				   <!-- Início do modal -->
				 <c:import url="editar-medicamento.jsp">
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
				</c:forEach>
			</div>
		</div>
		</c:otherwise>
	</c:choose>
<% }else{ %>

	<h2 class="txt-cyan">Faça login para visualizar o conteúdo dessa página</h2>
	
<% } %>
</div>
<div id="footer-placeholder"></div>
<script src="/drogaria/assets/js/header_footer_include.js"></script>