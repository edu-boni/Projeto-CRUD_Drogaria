<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Medicamentos Cadastrados</h2>

<c:choose>
    <c:when test="${empty listaMedicamentos}">
        <p>Nenhum medicamento cadastrado ainda.</p>
    </c:when>
    <c:otherwise>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Princípio Ativo</th>
                <th>Fabricante</th>
                <th>Validade</th>
                <th>Lote</th>
                <th>Indicação</th>
                <th>Dosagem</th>
                <th>Forma</th>
                <th>Preço (R$)</th>
                <th>Editar</th>
                <th>Excluir</th>
            </tr>
            <c:forEach var="m" items="${listaMedicamentos}">
                <tr>
                    <td>${m.id}</td>
                    <td>${m.nome}</td>
                    <td>${m.principio_ativo}</td>
                    <td>${m.fabricante}</td>
                    <td>${m.validade}</td>
                    <td>${m.lote}</td>
                    <td>${m.indicacao}</td>
                    <td>${m.dosagem}</td>
                    <td>${m.forma}</td>
                    <td>${m.preco}</td>
                    <th><a href="editar-medicamento?id=${m.id}">Editar</a>
                    <td><a href="DeleteMedicamentoServlet?id=${m.id}">Excluir</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

<br>
<a href="form-medicamento.jsp">Cadastrar novo medicamento</a>
