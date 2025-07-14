/**
 * Formata um número para o padrão de moeda brasileiro (R$).
 */
function formatarPreco(valor) {
    return valor.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
}

/**
 * MODELO 1: Cria o card padrão em formato de grid.
 * Usado em: index.html e lista-medicamentos.html
 */
function criaCard(med, usuarioLogado) {
  const divCard = document.createElement('div');
  divCard.className = 'col-md-3 col-sm-12 mb-4 d-flex flex-column align-items-center hover-card';

  // Link
  const link = document.createElement('a');
  link.href = `/drogaria/medicamento/medicamento.html?id=${med.id}`;
  link.className = 'w-100 text-decoration-none text-reset';

  // Container interno (imagem + info)
  const divInterno = document.createElement('div');
  divInterno.className = 'd-flex flex-column align-items-center';

  // Imagem
  const img = document.createElement('img');
  img.className = 'img-fluid mb-4';
  img.style.maxHeight = '120px';
  img.alt = med.nome;
  img.src = med.imagem_url ? med.imagem_url.trim() : '/drogaria/assets/images/semimagem.png';
  img.onerror = function () {
    this.src = '/drogaria/assets/images/semimagem.png';
  };

  // Informações
  const divInfo = document.createElement('div');
  divInfo.className = 'p-3 w-100 bg-cyan-light';
  divInfo.style.borderRadius = '6px';

  const nomeP = document.createElement('p');
  nomeP.className = 'txt-cyan';
  nomeP.style.fontSize = '20px';
  nomeP.style.fontWeight = 'bold';
  nomeP.style.margin = '0';
  nomeP.textContent = med.nome;

  const dosagemP = document.createElement('p');
  dosagemP.className = 'txt-cyan';
  dosagemP.style.margin = '0';
  dosagemP.textContent = med.dosagem;

  divInfo.appendChild(nomeP);
  divInfo.appendChild(dosagemP);

  const descontoProduto = med.desconto || 0;
  if (usuarioLogado && descontoProduto > 0) {
    const precoOriginal = document.createElement('p');
    precoOriginal.className = 'mt-1 mb-0 text-secondary';
    precoOriginal.style.fontSize = '15px';
    precoOriginal.style.textDecoration = 'line-through';
    precoOriginal.textContent = formatarPreco(med.preco);
    divInfo.appendChild(precoOriginal);

    const precoComDescontoDiv = document.createElement('div');
    precoComDescontoDiv.className = 'd-flex justify-content-between align-items-center';
    precoComDescontoDiv.style.fontSize = '20px';
    precoComDescontoDiv.style.fontWeight = 'bold';

    const precoFinal = med.preco * (1 - descontoProduto / 100);
    const precoComDesconto = document.createElement('p');
    precoComDesconto.className = 'mb-0';
    precoComDesconto.textContent = formatarPreco(precoFinal);

    const tagDesconto = document.createElement('p');
    tagDesconto.className = 'text-danger mb-0';
    tagDesconto.innerHTML = `<i class="fas fa-tag"></i> -${descontoProduto.toFixed(0)}%`;

    precoComDescontoDiv.appendChild(precoComDesconto);
    precoComDescontoDiv.appendChild(tagDesconto);
    divInfo.appendChild(precoComDescontoDiv);
  } else {
    const precoP = document.createElement('p');
    precoP.className = 'mt-1 mb-0';
    precoP.style.fontSize = '20px';
    precoP.style.fontWeight = 'bold';
    precoP.textContent = formatarPreco(med.preco);
    divInfo.appendChild(precoP);
  }

  // Monta tudo
  divInterno.appendChild(img);
  divInterno.appendChild(divInfo);
  link.appendChild(divInterno);
  divCard.appendChild(link);

  return divCard;
}


/**
 * MODELO 2: Cria o card em formato de lista para resultados de busca.
 * Usado em: resultado-busca.html
 */
function criarCardResultado(med, usuarioLogado) {
    const cardWrapper = document.createElement('div');
    cardWrapper.className = 'col-md-12 mb-3';

    const imgUrl = med.imagem_url ? med.imagem_url.trim() : "/drogaria/assets/images/semimagem.png";
    
    let precoHtml = '';
    if (usuarioLogado) {
        const descontoProduto = med.desconto || 0;
        if (descontoProduto > 0) {
            const precoFinal = med.preco * (1 - (descontoProduto / 100));
            precoHtml = `<p class="card-text text-secondary mb-1">De: <span class="text-secondary"><s>${formatarPreco(med.preco)}</s></span></p>
						<p><strong>${formatarPreco(precoFinal)}</strong> <span class="text-danger"><i class="fas fa-tag"></i> -${descontoProduto.toFixed(0)}%</span></p>`;
        } else {
            precoHtml = `<p class="card-text mb-0">${formatarPreco(med.preco)}</p>`;
        }
    } else {
        precoHtml = `<p class="card-text mb-0"><strong>Preço:</strong> ${formatarPreco(med.preco)}</p>`;
    }
    
    cardWrapper.innerHTML = `
        <a href="/drogaria/medicamento/medicamento.html?id=${med.id}" class="card-link">
            <div class="card flex-row shadow-sm align-items-center p-2 hover-card">
                <div class="p-2">
                    <img src="${imgUrl}" alt="${med.nome}" style="width: 100px; height: 100px; object-fit: cover; border-radius: 6px;" onerror="this.onerror=null;this.src='/drogaria/assets/images/semimagem.png';">
                </div>
                <div class="card-body">
                    <h5 class="card-title mb-2">${med.nome}</h5>
                    <p class="card-text mb-1"><small><strong>Princípio Ativo:</strong> ${med.principio_ativo}</small></p>
                    <p class="card-text mb-1"><small><strong>Dosagem:</strong> ${med.dosagem}</small></p>
                    ${precoHtml}
                </div>
            </div>
        </a>
    `;
    return cardWrapper;
}

/**
 * Cria o modal de EDIÇÃO de um medicamento (usado por admins).
 */
function criarModalMedicamento(med) {
  const modalDiv = document.createElement('div');
  modalDiv.className = 'modal fade';
  modalDiv.id = `modal-${med.id}`;
  modalDiv.tabIndex = -1;

  // Gera os <option> das categorias com o valor selecionado
  const optionsHtml = listaDeCategorias.map(cat =>
    `<option value="${cat.value}" ${med.categoria === cat.value ? 'selected' : ''}>${cat.text}</option>`
  ).join('');

  modalDiv.innerHTML = `
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
      <div class="modal-content">
        <form class="row p-3">
          <div class="modal-header col-12">
            <h5 class="modal-title">Editar Medicamento</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>

          <input type="hidden" name="id" value="${med.id}" />

          <div class="col-md-6 mb-3 mt-3">
            <label for="nome-${med.id}">Nome</label>
            <input type="text" class="form-control" name="nome" id="nome-${med.id}" value="${med.nome}" required>
          </div>

          <div class="col-md-6 mb-3 mt-3">
            <label for="categoria-${med.id}">Categoria</label>
            <select class="form-control" name="categoria" id="categoria-${med.id}" required>
              <option value="">Selecione...</option>
              ${optionsHtml}
            </select>
          </div>

          <div class="col-md-6 mb-3">
            <label for="principio-${med.id}">Princípio Ativo</label>
            <input type="text" class="form-control" name="principio_ativo" id="principio-${med.id}" value="${med.principio_ativo}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="fabricante-${med.id}">Fabricante</label>
            <input type="text" class="form-control" name="fabricante" id="fabricante-${med.id}" value="${med.fabricante}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="validade-${med.id}">Validade</label>
            <input type="date" class="form-control" name="validade" id="validade-${med.id}" value="${med.validade}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="lote-${med.id}">Lote</label>
            <input type="text" class="form-control" name="lote" id="lote-${med.id}" value="${med.lote}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="indicacao-${med.id}">Indicação</label>
            <input type="text" class="form-control" name="indicacao" id="indicacao-${med.id}" value="${med.indicacao}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="dosagem-${med.id}">Dosagem</label>
            <input type="text" class="form-control" name="dosagem" id="dosagem-${med.id}" value="${med.dosagem}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="forma-${med.id}">Forma</label>
            <input type="text" class="form-control" name="forma" id="forma-${med.id}" value="${med.forma}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="preco-${med.id}">Preço</label>
            <input type="number" step="0.01" class="form-control" name="preco" id="preco-${med.id}" value="${med.preco}" required>
          </div>

          <div class="col-md-6 mb-3">
            <label for="desconto-${med.id}">Desconto (%)</label>
            <input type="number" step="0.01" min="0" max="100" class="form-control" name="desconto" id="desconto-${med.id}" value="${med.desconto || ''}">
          </div>

          <div class="col-md-6 mb-3">
            <label for="imagem-${med.id}">URL da Imagem</label>
            <input type="url" class="form-control" name="imagem_url" id="imagem-${med.id}" value="${med.imagem_url || ''}" maxlength="255">
          </div>

          <div class="col-12 d-flex justify-content-between mt-3">
            <a href="#" class="btnExcluirMedicamento btn btn-danger" data-id="${med.id}" data-nome="${med.nome}">Excluir</a>
            <button type="submit" class="btn bg-cyan">Salvar alterações</button>
          </div>
        </form>
      </div>
    </div>
  `;

  return modalDiv;
}

document.addEventListener("footer-carregado", function () {
	  const modaisContainer = document.getElementById('modais-container');
	  if (!modaisContainer) return;

	  modaisContainer.addEventListener('submit', async function (e) {
	    if (e.target.tagName.toLowerCase() !== 'form') return;
	    e.preventDefault();
	    const form = e.target;
	    const formData = new URLSearchParams();
	    for (const element of form.elements) {
	      if (element.name && !element.disabled) {
	        formData.append(element.name, element.value);
	      }
	    }
	    try {
	      const response = await fetch('/drogaria/UpdateMedicamentoServlet', { method: 'POST', body: formData });
	      const json = await response.json();
	      if (json.success) {
	        $(`#${form.closest('.modal').id}`).modal('hide');
	        sessionStorage.setItem("mensagem", json.message);
	        sessionStorage.setItem("mensagem-cor", "alert-success");
	        window.location.reload();
	      } else {
	        exibe_mensagem(json.message, "alert-danger");
	      }
	    } catch (error) {
	      console.error('Erro na atualização:', error);
	      exibe_mensagem("Erro ao atualizar. Tente novamente mais tarde.", "alert-danger");
	    }
	  });
  });