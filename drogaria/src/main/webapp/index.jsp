<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="header.jsp"></c:import>
	<div class="container">
		<form action="CreateAdminServlet" method="post">
			<div class="form-row">
				<div class="col-md-6 col-sm-12">
					<label for="nome">Nome</label>
					<input type="text" id="nome" name="nome" class="form-control">
				</div>
				<div class="col-md-6 col-sm-12">
					<label for="cpf">CPF</label>
					<input type="text" id="cpf" name="cpf" class="form-control">
				</div>
				<div class="col-md-6 col-sm-12">
					<label for="email">Email</label>
					<input type="email" id="email" name="email" class="form-control">
				</div>
				<div class="col-md-6 col-sm-12">
					<label for="senha">Senha</label>
					<input type="password" id="senha" name="senha" class="form-control">
				</div>
			</div>
			<input type="submit" value="Enviar" class="btn btn-primary" class="col-12">
		</form>
	</div>
	<a href="form-medicamento.jsp">oie</a>
<c:import url="footer.jsp"></c:import>