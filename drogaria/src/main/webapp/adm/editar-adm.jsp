<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="br.edu.ifsp.arq.model.Administrador"%>
<c:import url="../include/header.jsp"></c:import>

<div class="container mt-5 mb-5">
	<h2 class="mb-4 text-center">Editar Dados do Administrador</h2>
	<% String contextPath = request.getContextPath(); %>
	<form action="<%= contextPath %>/UpdateADMServlet" method="post"
		class="row">
		<%
		    Administrador a = (Administrador) request.getAttribute("administrador");
		    if (a == null) {
		        a = (Administrador) session.getAttribute("usuarioLogado");
		    }
		%>
		<input type="hidden" name="id"
			value="<%= (a != null) ? a.getId() : 0 %>" />

		<div class="form-group col-md-6">
			<label for="nome">Nome</label> <input type="text"
				class="form-control" id="nome" name="nome"
				value="<%= a.getNome() %>" required maxlength="100"
				placeholder="Ex: João Silva">
		</div>

		<div class="form-group col-md-6">
			<label for="email">E-mail</label> <input type="email"
				class="form-control" id="email" name="email"
				value="<%= a.getEmail() %>" required maxlength="100"
				placeholder="Ex: joao@email.com">
		</div>

		<div class="form-group col-md-6">
			<label for="cpf">CPF</label> <input type="text" class="form-control"
				id="cpf" name="cpf" value="<%= a.getCpf() %>" required
				maxlength="14" placeholder="Ex: 000.000.000-00">
		</div>

		<div class="form-group col-md-6">
			<label for="senha">Senha</label> <input type="password"
				class="form-control" id="senha" name="senha" value="********"
				readonly> <small> <a href="#" data-toggle="modal"
				data-target="#alterarSenhaModal">Alterar senha</a>
			</small>
		</div>


		<div class="form-group col-12 text-center mt-3">
			<button type="submit" class="btn btn-primary">Atualizar</button>
			<a href="./DeleteADMServlet?id=<%= a.getId() %>"
				class="btn btn-danger ml-2">Excluir Conta</a>
		</div>
	</form>
	<!-- Modal de alteração de senha -->
	<div class="modal fade" id="alterarSenhaModal" tabindex="-1"
		role="dialog" aria-labelledby="modalLabelSenha" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form action="<%= contextPath %>/UpdateADMServlet" method="post"
				class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalLabelSenha">Alterar Senha</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Fechar">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="id" value="<%= a.getId() %>" />

					<div class="form-group">
						<label for="senhaAtual">Senha atual</label> <input type="password"
							class="form-control" id="senhaAtual" name="senhaAtual" required>
					</div>
					<div class="form-group">
						<label for="novaSenha">Nova senha</label> <input type="password"
							class="form-control" id="novaSenha" name="novaSenha" required>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">Salvar nova
						senha</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cancelar</button>
				</div>
			</form>
		</div>
	</div>

</div>

<c:import url="../include/footer.jsp"></c:import>
