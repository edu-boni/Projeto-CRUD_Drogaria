<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../include/header.jsp"></c:import>

<% String contextPath = request.getContextPath();
boolean usuarioLogado = session.getAttribute("usuarioLogado") != null; %>

<div class="container mt-5" style="min-height: 80vh">
	<h2 class="mb-4 text-center">
		Resultados para "<c:out value='${termoBusca}'/>"
	</h2>

	<c:choose>
		<c:when test="${not empty resultados}">
			<c:forEach var="med" items="${resultados}">
	            <% if(usuarioLogado){ %>
					<div class="row hover-card" data-toggle="modal" data-target="#modal-${med.id}">
				<% }else{ %>
					<div class="row hover-card" data-toggle="modal" data-target="#loginModal">
				<% } %>
					<div class="col-md-12 mb-3">
						<div class="card flex-row shadow-sm align-items-center p-2">
							<div class="p-2">
							<c:choose>
							  <c:when test="${empty med.imagem_url}">
							    <img src="/drogaria/images/semimagem.png" alt="Imagem padrão" class="img-fluid mb-4" style="width: 100px; height: 100px; object-fit: cover; border-radius: 6px;"" />
							  </c:when>
							  <c:otherwise>
							    <img src="${med.imagem_url}" alt="${med.nome}" class="img-fluid mb-4" style="width: 100px; height: 100px; object-fit: cover; border-radius: 6px;" onerror="this.onerror=null;this.src='/drogaria/images/semimagem.png';" />
							  </c:otherwise>
							</c:choose>
							</div>

							<div class="card-body">
								<h5 class="card-title mb-2">${med.nome}</h5>
								<p class="card-text mb-1">
									<strong>Princípio Ativo:</strong> ${med.principio_ativo}
								</p>
								<p class="card-text mb-1">
									<strong>Fabricante:</strong> ${med.fabricante}
								</p>
								<p class="card-text mb-1">
									<strong>Validade:</strong> ${med.validade}
								</p>
								<p class="card-text mb-1">
									<strong>Dosagem:</strong> ${med.dosagem}
								</p>
								<p class="card-text mb-2">
									<strong>Preço:</strong>
									<% if(usuarioLogado){ %>
					                	<span class="text-secondary" style="text-decoration: line-through">R$ ${med.preco}</span> R$ ${med.preco*0.9} <span class="text-danger col-md-6"><i class="fas fa-solid fa-tag"></i> -10%</span>
					                	</div>
					                <% }else{ %>
					               		<span>R$ ${med.preco}</span>
					                <% } %>
								</p>
							</div>
						</div>
					</div>
					<% if(!usuarioLogado){ %>
					</div>
					<% } %>
					
					<% if (usuarioLogado) { %>
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
					 <% } %>
				</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<p class="text-center text-muted">
				Nenhum resultado encontrado para "<c:out value='${termoBusca}' />"
			</p>
		</c:otherwise>
	</c:choose>
</div>

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
					class="btn btn-secondary w-100 m-1">Criar uma conta</a>
					<a href="<%= contextPath %>/login.jsp"
					class="btn bg-cyan w-100 m-1">Fazer login</a> 
				</div>
			</div>
		</div>
	</div>
</div>
<% } %>

<c:import url="../include/footer.jsp"></c:import>
