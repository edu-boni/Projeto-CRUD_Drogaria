<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../include/header.jsp"></c:import>

<div class="container mt-5">
	<h2 class="mb-4 text-center">
		Resultados para: "
		<c:out value='${termoBusca}' />
		"
	</h2>

	<c:choose>
		<c:when test="${not empty resultados}">
			<div class="row">
				<c:forEach var="med" items="${resultados}">
					<div class="col-md-12 mb-3">
						<div class="card flex-row shadow-sm align-items-center p-2">

							<!-- IMAGEM QUADRADA COM PADDING -->
							<div class="p-2">
								<img src="${med.imagem_url}" alt="${med.nome}"
									style="width: 100px; height: 100px; object-fit: cover; border-radius: 6px;" />
							</div>

							<div class="card-body">
								<h5 class="card-title mb-2">${med.nome}</h5>
								<p class="card-text mb-1">
									<strong>Princípio Ativo:</strong> ${med.principio_ativo}
								</p>
								<p class="card-text mb-1">
									<strong>Fabricante:</strong> ${med.fabricante}
								</p>
								<p class="card-text mb-1">
									<strong>Validade:</strong> ${med.validade}
								</p>
								<p class="card-text mb-1">
									<strong>Dosagem:</strong> ${med.dosagem}
								</p>
								<p class="card-text mb-2">
									<strong>Preço:</strong> R$ ${med.preco}
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<p class="text-center text-muted">
				Nenhum resultado encontrado para "
				<c:out value='${termoBusca}' />
				".
			</p>
		</c:otherwise>
	</c:choose>
</div>

<c:import url="../include/footer.jsp"></c:import>
