<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="br.edu.ifsp.arq.model.Administrador" %>
<% Administrador a = (Administrador) request.getAttribute("administrador"); %>

<c:import url="../include/header.jsp"></c:import>

<div class="container mt-5">
    <h2 class="mb-4">Editar Dados</h2>
    <form action="./UpdateADMServlet" method="post" class="row g-3">
        <input type="hidden" name="id" value="<%= a.getId() %>"/>

        <div class="col-md-6">
            <label for="nome" class="form-label">Nome</label>
            <input type="text" class="form-control" id="nome" name="nome" value="<%= a.getNome() %>" required maxlength="100" placeholder="Ex: João Silva">
        </div>

        <div class="col-md-6">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= a.getEmail() %>" required maxlength="100" placeholder="Ex: joao@email.com">
        </div>

        <div class="col-md-6">
            <label for="cpf" class="form-label">CPF</label>
            <input type="text" class="form-control" id="cpf" name="cpf" value="<%= a.getCpf() %>" required maxlength="14" placeholder="Ex: 000.000.000-00">
        </div>

        <div class="col-md-6">
            <label for="senha" class="form-label">Senha</label>
            <input type="password" class="form-control" id="senha" name="senha" value="<%= a.getSenha() %>" required maxlength="100" placeholder="Digite a nova senha">
        </div>

        <div class="col-12">
            <button type="submit" class="btn btn-primary">Atualizar</button>
        </div>
    </form>
</div>

<div>
	   <a type="submit" href="" class="btn btn-danger">Excluir conta</a>
</div>

<c:import url="../include/footer.jsp"></c:import>
