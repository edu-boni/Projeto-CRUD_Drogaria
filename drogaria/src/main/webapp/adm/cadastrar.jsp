<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="header.jsp"></c:import>

<main class="container mt-5">
    <section>
        <h1>Cadastro de Administrador</h1>
        <form action="CreateAdminServlet" method="post">
            <div class="form-row">
                <div class="col-md-6 col-sm-12 mb-3">
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" class="form-control" required>
                </div>
                <div class="col-md-6 col-sm-12 mb-3">
                    <label for="cpf">CPF</label>
                    <input type="text" id="cpf" name="cpf" class="form-control">
                </div>
                <div class="col-md-6 col-sm-12 mb-3">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="col-md-6 col-sm-12 mb-3">
                    <label for="senha">Senha</label>
                    <input type="password" id="senha" name="senha" class="form-control" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-block mt-4">Enviar</button>
        </form>
    </section>

    <section class="mt-4">
        <a href="form-medicamento.jsp" class="btn btn-link">Ir para o formulário de medicamento</a>
    </section>
</main>

<c:import url="footer.jsp"></c:import>
