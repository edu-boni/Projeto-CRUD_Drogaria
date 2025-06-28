<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="br.edu.ifsp.arq.model.Administrador"%>

<div id="header-placeholder"></div>

<main class="container justify-content-center d-flex align-items-center" style="min-height: 80vh">
<div>
	<h3 class="mb-2 txt-cyan">Meus dados</h3>
	<p class="text-secondary">Altere suas informações</p>
	<form action="/drogaria/UpdateADMServlet" method="post"
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
			<label for="cpf">CPF</label> <input type="text" class="form-control"
				id="cpf" name="cpf" value="<%= a.getCpf() %>" required
				maxlength="14" placeholder="Ex: 000.000.000-00">
		</div>
		

		<div class="form-group col-md-12">
			<label for="email">E-mail</label> <input type="email"
				class="form-control" id="email" name="email"
				value="<%= a.getEmail() %>" required maxlength="100"
				placeholder="Ex: joao@email.com">
		</div>
		<div class="form-group col-md-12">
			<%
			    String senha = a.getSenha();
			    String senhaOculta = senha != null ? "*".repeat(senha.length()) : "";
			%>
			<input type="password" class="form-control" id="senha" name="senha" value="<%= senhaOculta %>" readonly>

		</div>
		<div class="form-group col-md-12 text-md-right">
			<a href="#" data-toggle="modal" data-target="#alterarSenhaModal" class="text-secondary">Alterar senha</a>
		</div>

		<div class="form-group col-md-12 d-flex justify-content-between mt-3">
			<a href="#" id="btnExcluirConta" data-id="<%= a.getId() %>" class="btn btn-danger col-md-5">Excluir Conta</a>

			<button type="submit" class="btn bg-cyan col-md-5">Atualizar</button>
			
		</div>
	</form>
	
	<!-- Modal de alteração de senha -->
	<div class="modal fade" id="alterarSenhaModal" tabindex="-1"
		role="dialog" aria-labelledby="modalLabelSenha" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<form action="/drogaria/UpdateADMServlet" method="post"
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
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cancelar</button>
					<button type="submit" class="btn bg-cyan">Salvar nova
						senha</button>
				</div>
			</form>
		</div>
	</div>
</div>
</main>

<div id="footer-placeholder"></div>
<script src="/drogaria/assets/js/header_footer_include.js"></script>