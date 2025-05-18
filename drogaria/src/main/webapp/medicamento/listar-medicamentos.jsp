<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../include/header.jsp"></c:import>

<div class="container mt-5">
	<h2 class="mb-4 text-center">Medicamentos Cadastrados</h2>

	<c:choose>
		<c:when test="${empty listaMedicamentos}">
			<p class="text-center">Nenhum medicamento cadastrado ainda.</p>
		</c:when>
		<c:otherwise>
			<div class="row">
				<c:forEach var="m" items="${listaMedicamentos}">
					<div class="col-md-12 mb-3">
						<div class="card flex-row shadow-sm">
							<img src="${m.imagem_url}" class="img-fluid"
								alt="Imagem do medicamento"
								style="width: 150px; object-fit: cover;">
							<div class="card-body">
								<h5 class="card-title">${m.nome}</h5>
								<p class="card-text mb-1">
									<strong>Princípio Ativo:</strong> ${m.principio_ativo}
								</p>
								<p class="card-text mb-1">
									<strong>Fabricante:</strong> ${m.fabricante}
								</p>
								<p class="card-text mb-1">
									<strong>Validade:</strong> ${m.validade}
								</p>
								<p class="card-text mb-1">
									<strong>Lote:</strong> ${m.lote}
								</p>
								<p class="card-text mb-1">
									<strong>Indicação:</strong> ${m.indicacao}
								</p>
								<p class="card-text mb-1">
									<strong>Dosagem:</strong> ${m.dosagem}
								</p>
								<p class="card-text mb-1">
									<strong>Forma:</strong> ${m.forma}
								</p>
								<p class="card-text mb-2">
									<strong>Preço:</strong> R$ ${m.preco}
								</p>
								<p class="card-text mb-2">
									<strong>URL da Imagem:</strong>${m.imagem_url}</p>
								<a href="editar-medicamento?id=${m.id}"
									class="btn btn-sm btn-warning mr-2">Editar</a> <a
									href="DeleteMedicamentoServlet?id=${m.id}"
									class="btn btn-sm btn-danger">Excluir</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>

	<div class="mt-4 text-center">
		<a href="../medicamento/form-medicamento.jsp" class="btn btn-primary">Cadastrar
			novo medicamento</a>
	</div>
</div>

<c:import url="../include/footer.jsp"></c:import>