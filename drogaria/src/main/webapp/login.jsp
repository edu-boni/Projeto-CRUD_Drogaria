<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/include/header.jsp"></c:import>

<main class="container d-flex justify-content-center align-items-center"
	style="min-height: 80vh">
	<div class="w-100" style="max-width: 450px;">
		<h3 class="text-center txt-cyan mb-4">Login</h3>

		<form action="<%= request.getContextPath() %>/LoginServlet" method="post">
			<div class="form-group">
				<label for="email">E-mail</label> <input type="email" name="email"
					class="form-control" placeholder="joao@email.com" required>
			</div>

			<div class="form-group mt-3">
				<label for="senha">Senha</label> <input type="password"
					name="senha" class="form-control" placeholder="*****" required>
			</div>

			<div class="mt-4 d-flex justify-content-between align-items-center">
				<a href="<%= request.getContextPath() %>/cadastrar.jsp"
					class="btn btn-outline-secondary">Cadastre-se</a>
				<button type="submit" class="btn bg-cyan">Entrar</button>
			</div>
		</form>
	</div>
</main>

<c:import url="/include/footer.jsp"></c:import>
