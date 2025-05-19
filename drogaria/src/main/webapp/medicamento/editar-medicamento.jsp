<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<% String contextPath = request.getContextPath(); %>

<div class="modal fade" id="modal-${param.id}" tabindex="-1" role="dialog" aria-labelledby="modalLabel-${param.id}" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <form action="<%= contextPath %>/UpdateMedicamentoServlet" method="post" class="row p-4">
        <div class="modal-header col-12">
          <h5 class="modal-title" id="modalLabel-${param.id}">Editar Medicamento</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <!-- Hidden ID -->
        <input type="hidden" name="id" value="${param.id}" />

        <div class="col-md-6 mb-3 mt-3">
          <label for="nome-${param.id}" class="form-label">Nome</label>
          <input type="text" class="form-control" id="nome-${param.id}" name="nome" value="${param.nome}" required>
        </div>

        <div class="col-md-6 mb-3 mt-3">
          <label for="principio_ativo-${param.id}" class="form-label">Princípio Ativo</label>
          <input type="text" class="form-control" id="principio_ativo-${param.id}" name="principio_ativo" value="${param.principio_ativo}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="fabricante-${param.id}" class="form-label">Fabricante</label>
          <input type="text" class="form-control" id="fabricante-${param.id}" name="fabricante" value="${param.fabricante}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="validade-${param.id}" class="form-label">Validade</label>
          <input type="date" class="form-control" id="validade-${param.id}" name="validade" value="${param.validade}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="lote-${param.id}" class="form-label">Lote</label>
          <input type="text" class="form-control" id="lote-${param.id}" name="lote" value="${param.lote}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="indicacao-${param.id}" class="form-label">Indicação</label>
          <input type="text" class="form-control" id="indicacao-${param.id}" name="indicacao" value="${param.indicacao}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="dosagem-${param.id}" class="form-label">Dosagem</label>
          <input type="text" class="form-control" id="dosagem-${param.id}" name="dosagem" value="${param.dosagem}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="forma-${param.id}" class="form-label">Forma</label>
          <input type="text" class="form-control" id="forma-${param.id}" name="forma" value="${param.forma}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="preco-${param.id}" class="form-label">Preço</label>
          <input type="number" step="0.01" class="form-control" id="preco-${param.id}" name="preco" value="${param.preco}" required>
        </div>

        <div class="col-md-6 mb-3">
          <label for="imagem_url-${param.id}" class="form-label">URL da Imagem</label>
          <input type="url" class="form-control" id="imagem_url-${param.id}" name="imagem_url" value="${param.imagem_url}" maxlength="255">
        </div>

        <div class="col-12 d-flex justify-content-between mt-3">
          <a href="<%= contextPath %>/DeleteMedicamentoServlet?id=${param.id}" class="btn btn-danger">Excluir</a>
          <button type="submit" class="btn bg-cyan">Salvar opções</button>
        </div>
      </form>
    </div>
  </div>
</div>