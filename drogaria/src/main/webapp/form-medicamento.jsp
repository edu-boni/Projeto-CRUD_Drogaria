<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="header.jsp"></c:import>
<form action="CreateMedicamentoServlet" method="post">
    <label>Nome:</label><br>
    <input type="text" name="nome" required><br>

    <label>Princípio Ativo:</label><br>
    <input type="text" name="principio_ativo" required><br>

    <label>Fabricante:</label><br>
    <input type="text" name="fabricante" required><br>

    <label>Validade:</label><br>
    <input type="date" name="validade" required><br>

    <label>Lote:</label><br>
    <input type="text" name="lote" required><br>

    <label>Indicação:</label><br>
    <input type="text" name="indicacao" required><br>

    <label>Dosagem:</label><br>
    <input type="text" name="dosagem" required><br>

    <label>Forma:</label><br>
    <input type="text" name="forma" required><br>

    <label>Preço:</label><br>
    <input type="number" name="preco" required><br><br>

    <input type="submit" value="Cadastrar">
</form>

<c:import url="footer.jsp"></c:import>