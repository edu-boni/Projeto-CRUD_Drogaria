<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*, br.edu.ifsp.arq.model.Medicamento" %>

<c:import url="/include/header.jsp"></c:import>

<main class="container mt-5">
  <% 
    String contextPath = request.getContextPath(); 
    boolean usuarioLogado = session.getAttribute("usuarioLogado") != null;
  %>

  <!-- Banner com botão -->
  <div class="promo-banner position-relative mb-5" style="height: 300px; background: url('<%= contextPath %>/images/banner.png') center/cover no-repeat;">
    <div class="overlay"></div>
    <div class="position-absolute" style="bottom: 90px; right: 100px; z-index: 2;">
      <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#loginModal">CONFIRA AGORA</button>
    </div>
  </div>

  <!-- Seção de medicamentos -->
<c:if test="${not empty listaMedicamentos}">
  <div class="row justify-content-center">
    <c:forEach var="med" items="${listaMedicamentos}" varStatus="loop">
      <c:if test="${loop.index < 6}">
        <div class="col-md-3 col-sm-6 mb-4 d-flex flex-column align-items-center">
          <img src="${med.imagem_url}" alt="${med.nome}" class="img-fluid mb-2" style="max-height: 120px;">
          <div class="p-2 w-100 text-center" style="background-color: #e8f5f2; border-radius: 6px;">
            <small class="text-muted d-block">${med.nome}</small>
            <small class="text-muted">${med.dosagem}</small>
            <p class="font-weight-bold mt-2 mb-0">R$ ${med.preco}</p>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </div>
</c:if>
<c:if test="${empty listaMedicamentos}">
  <p class="text-center text-muted">Nenhum medicamento cadastrado.</p>
</c:if>

  
    <!-- Seção vantagens e cadastro -->
 <% if (!usuarioLogado) { %>
  <!-- Seção vantagens e cadastro -->
  <section class="my-5">
    <div class="row align-items-center">

      <!-- Imagem do médico -->
      <div class="col-md-4 text-center mb-4 mb-md-0">
        <img src="<%= contextPath %>/images/medico.png" alt="Médico" class="img-fluid" style="max-height: 300px;">
      </div>

      <!-- Vantagens -->
      <div class="col-md-4 text-center mb-4 mb-md-0">
        <h5 class="mb-3">Vantagens</h5>
        <div class="mb-2">
          <button class="btn btn-light rounded-pill w-100 mb-2" data-toggle="modal" data-target="#loginModal">💎 Ofertas exclusivas</button>
        </div>
        <div>
          <button class="btn btn-light rounded-pill w-100" data-toggle="modal" data-target="#loginModal">💊 Cadastrar remédios</button>
        </div>
      </div>

      <!-- Formulário de cadastro -->
      <div class="col-md-4">
        <h5 class="mb-3 text-center">Cadastre-se</h5>
        <form action="<%= contextPath %>/CreateAdminServlet" method="post">
          <div class="form-row">
            <div class="form-group col-6">
              <input type="text" name="nome" class="form-control" placeholder="Nome" required>
            </div>
            <div class="form-group col-6">
              <input type="text" name="cpf" class="form-control" placeholder="CPF">
            </div>
          </div>
          <div class="form-group">
            <input type="email" name="email" class="form-control" placeholder="E-mail" required>
          </div>
          <div class="form-group">
            <input type="password" name="senha" class="form-control" placeholder="Senha" required>
          </div>
          <button type="submit" class="btn btn-success btn-block mt-2">Cadastrar</button>
        </form>
      </div>
    </div>
  </section>
<% } %>

  <!-- Modal de login -->
  <% if (!usuarioLogado) { %>
  <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content border-0 shadow-lg">
        <div class="modal-header bg-info text-white">
          <h5 class="modal-title">Acesso Restrito</h5>
          <button type="button" class="close text-white" data-dismiss="modal" aria-label="Fechar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>Para acessar este conteúdo, você precisa estar logado.</p>
          <div class="d-flex justify-content-between">
            <a href="<%= contextPath %>/adm/login.jsp" class="btn btn-primary w-100 mr-2">Fazer Login</a>
            <a href="<%= contextPath %>/adm/cadastrar.jsp" class="btn btn-secondary w-100 ml-2">Ir para Cadastro</a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <% } %>
</main>

<c:import url="/include/footer.jsp"></c:import>