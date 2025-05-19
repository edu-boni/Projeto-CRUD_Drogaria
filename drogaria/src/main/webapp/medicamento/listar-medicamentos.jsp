<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../include/header.jsp"></c:import>

<%	String contextPath = request.getContextPath();
	boolean usuarioLogado = session.getAttribute("usuarioLogado") != null; %>

<div class="container mt-5 justify-content-center d-flex flex-column align-items-center" style="min-height: 80vh">
<% if (usuarioLogado) { %>
	
	<c:choose>
		<c:when test="${empty listaMedicamentos}">
		<a href="<%= contextPath %>/medicamento/form-medicamento.jsp" class="btn w-100 bg-cyan custom-gradient p-3 text-right font-weight-bold"> <i class="fas fa-plus-circle"></i> Cadastrar medicamento</a>
		<div class="container p-3 bg-light">
	        <p class="text-center text m-1">Nenhum medicamento encontrado :/</p>
	    </div>
		</c:when>
		<c:otherwise>
			<div class="col-md-12 d-flex">
				<h2 class="txt-cyan col-md-6">Todos os medicamentos</h2>
			 	<a href="<%= contextPath %>/medicamento/form-medicamento.jsp" class="btn col-md-6 bg-cyan custom-gradient p-3 text-right font-weight-bold mb-5 mt-0"> <i class="fas fa-plus-circle"></i> Cadastrar medicamento</a>
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
			                	<p class="mt-1 mb-0 text-secondary" style="font-size: 15px; text-decoration: line-through">R$ ${med.preco}</p>
			                	<div class="d-flex space-between align-items-center" style="font-size: 20px; font-weight: bold">
			                		<p>R$ ${med.preco*0.9}</p>
			                		<p class="text-danger col-md-6"><i class="fas fa-solid fa-tag"></i> -10%</p>
			                	</div>
			                <% }else{ %>
			               		<p class="mt-1 mb-0" style="font-size: 20px; font-weight: bold">R$ ${med.preco}</p>
			                <% } %>				        </div>
				    </div>
				    
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
				</c:forEach>
			</div>
		</div>
		</c:otherwise>
	</c:choose>
<% }else{ %>

	<h2 class="txt-cyan">Faça login para visualizar o conteúdo dessa página</h2>
	
<% } %>
</div>
<c:import url="../include/footer.jsp"></c:import>