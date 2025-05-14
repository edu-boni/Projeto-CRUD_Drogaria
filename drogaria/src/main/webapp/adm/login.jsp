<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../include/header.jsp"></c:import>

<main class="container mt-5">
    <h2>Login do Administrador</h2>

    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">E-mail:</label>
            <input type="email" name="email" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="senha" class="form-label">Senha:</label>
            <input type="password" name="senha" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-primary">Entrar</button>
    </form>
</main>

<c:import url="../include/footer.jsp"></c:import>
