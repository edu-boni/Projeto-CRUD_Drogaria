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
		             <div class="modal fade" id="modal-${med.id}" tabindex="-1" role="dialog" aria-labelledby="modalLabel-${med.id}" aria-hidden="true">
					  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
					    <div class="modal-content">
					      <form action="/drogaria/medicamento/editar" method="post" class="row p-4">
					        <div class="modal-header col-12">
					          <h5 class="modal-title" id="modalLabel-${med.id}">Editar Medicamento</h5>
					          <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
					            <span aria-hidden="true">&times;</span>
					          </button>
					        </div>
					
					        <!-- Hidden ID -->
					        <input type="hidden" name="id" value="${med.id}" />
					
					        <div class="col-md-6 mb-3 mt-3">
					          <label for="nome-${med.id}" class="form-label">Nome</label>
					          <input type="text" class="form-control" id="nome-${med.id}" name="nome" value="${med.nome}" required>
					        </div>
					
					        <div class="col-md-6 mb-3 mt-3">
					          <label for="principio_ativo-${med.id}" class="form-label">Princípio Ativo</label>
					          <input type="text" class="form-control" id="principio_ativo-${med.id}" name="principio_ativo" value="${med.principio_ativo}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="fabricante-${med.id}" class="form-label">Fabricante</label>
					          <input type="text" class="form-control" id="fabricante-${med.id}" name="fabricante" value="${med.fabricante}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="validade-${med.id}" class="form-label">Validade</label>
					          <input type="date" class="form-control" id="validade-${med.id}" name="validade" value="${med.validade}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="lote-${med.id}" class="form-label">Lote</label>
					          <input type="text" class="form-control" id="lote-${med.id}" name="lote" value="${med.lote}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="indicacao-${med.id}" class="form-label">Indicação</label>
					          <input type="text" class="form-control" id="indicacao-${med.id}" name="indicacao" value="${med.indicacao}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="dosagem-${med.id}" class="form-label">Dosagem</label>
					          <input type="text" class="form-control" id="dosagem-${med.id}" name="dosagem" value="${med.dosagem}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="forma-${med.id}" class="form-label">Forma</label>
					          <input type="text" class="form-control" id="forma-${med.id}" name="forma" value="${med.forma}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="preco-${med.id}" class="form-label">Preço</label>
					          <input type="number" step="0.01" class="form-control" id="preco-${med.id}" name="preco" value="${med.preco}" required>
					        </div>
					
					        <div class="col-md-6 mb-3">
					          <label for="imagem_url-${med.id}" class="form-label">URL da Imagem</label>
					          <input type="url" class="form-control" id="imagem_url-${med.id}" name="imagem_url" value="${med.imagem_url}" maxlength="255">
					        </div>
					
					        <div class="col-12 d-flex justify-content-between mt-3">
					          <a href="/drogaria/medicamento/excluir?id=${med.id}" class="btn btn-danger">Excluir</a>
					          <button type="submit" class="btn bg-cyan">Salvar opções</button>
					        </div>
					      </form>
					    </div>
					  </div>
					 </div>
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
