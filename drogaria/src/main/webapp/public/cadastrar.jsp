<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/include/header.jsp"></c:import>

<main class="container d-flex justify-content-center align-items-center"
	style="min-height: 80vh">
	<div class="w-100" style="max-width: 600px;">
		<h3 class="text-center txt-cyan mb-4">Cadastro de Administrador</h3>

		<form action="<%= request.getContextPath() %>/CreateAdminServlet" method="post">
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="nome">Nome</label> <input type="text" id="nome" name="nome" class="form-control" placeholder="Nome completo" required>
				</div>

				<div class="form-group col-md-6">
					<label for="cpf">CPF</label> <input type="text" id="cpf" name="cpf" class="form-control" placeholder="000.000.000-00">
				</div>
			</div>

			<div class="form-row">
				<div class="form-group col-md-12">
					<label for="email">E-mail</label> <input type="email" id="email" name="email" class="form-control" placeholder="joao@email.com" required>
				</div>

				<div class="form-group col-md-12">
					<label for="senha">Senha</label> <input type="password" id="senha" name="senha" class="form-control" placeholder="*****" required>
				</div>
			</div>

			<div class="mt-4 d-flex justify-content-between align-items-center">
				<a href="<%= request.getContextPath() %>/public/login.jsp"
					class="btn btn-outline-secondary">Voltar ao Login</a>
				<button type="submit" class="btn bg-cyan">Cadastrar</button>
			</div>
		</form>
	</div>
</main>

<c:import url="/include/footer.jsp"></c:import>