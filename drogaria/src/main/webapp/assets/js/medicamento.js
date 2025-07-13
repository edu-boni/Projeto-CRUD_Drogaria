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
    const col = document.createElement("div");
    col.className = "col-md-3 col-sm-6 mb-4";

    // O card inteiro é um link
    const link = document.createElement('a');
    link.href = `/drogaria/medicamento/medicamento.html?id=${med.id}`;
    link.className = 'card-link';

    // O contêiner do card
    const divCard = document.createElement('div');
    divCard.className = 'card h-100 hover-card d-flex flex-column';

    // A imagem
    const img = document.createElement('img');
    img.className = 'card-img-top';
    img.style.height = '150px';
    img.style.objectFit = 'contain';
    img.style.padding = '1rem';
    img.src = med.imagem_url ? med.imagem_url.trim() : "/drogaria/assets/images/semimagem.png";
    img.onerror = function() { this.src = '/drogaria/assets/images/semimagem.png'; };

    // Os estilos do card
    const divInfo = document.createElement('div');
    divInfo.className = 'p-3 w-100 bg-cyan-light d-flex flex-column';
    divInfo.style.flexGrow = '1';
    divInfo.style.borderRadius = '0 0 .25rem .25rem';

    // Nome e Dosagem
    const nomeP = document.createElement('p');
    nomeP.className = 'txt-cyan';
    nomeP.style.fontSize = '1.1rem';
    nomeP.style.fontWeight = 'bold';
    nomeP.style.margin = '0';
    nomeP.textContent = med.nome;

    const dosagemP = document.createElement('p');
    dosagemP.className = 'txt-cyan small';
    dosagemP.style.margin = '0';
    dosagemP.textContent = med.dosagem;
    
    // Contêiner do preço para alinhar embaixo
    const precoWrapper = document.createElement('div');
    precoWrapper.className = 'mt-auto pt-2';

    // Lógica de preço COM a etiqueta de desconto
    const descontoProduto = med.desconto || 0;
    if (usuarioLogado && descontoProduto > 0) {
        const precoFinal = med.preco * (1 - (descontoProduto / 100));
        precoWrapper.innerHTML = `
            <p class="mb-0 text-secondary" style="font-size: 0.8rem; text-decoration: line-through;">${formatarPreco(med.preco)}</p>
            <div class="d-flex justify-content-between align-items-center" style="font-size: 1.1rem; font-weight: bold;">
              <p class="mb-0 txt-cyan">${formatarPreco(precoFinal)}</p>
              <p class="text-danger mb-0"><i class="fas fa-tag"></i> -${descontoProduto.toFixed(0)}%</p>
            </div>`;
    } else {
        precoWrapper.innerHTML = `<p class="mb-0 txt-cyan" style="font-size: 1.1rem; font-weight: bold;">${formatarPreco(med.preco)}</p>`;
    }
    
    // Monta a seção de informações
    divInfo.appendChild(nomeP);
    divInfo.appendChild(dosagemP);
    divInfo.appendChild(precoWrapper);
    
    // Monta o card final
    divCard.appendChild(img);
    divCard.appendChild(divInfo);
    
    // Coloca o card dentro do link
    link.appendChild(divCard);

    col.appendChild(link);
    return col;
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
            precoHtml = `<p class="card-text mb-0"><strong>Preço:</strong> <span class="text-secondary" style="text-decoration: line-through;">${formatarPreco(med.preco)}</span> <strong class="ml-2">${formatarPreco(precoFinal)}</strong> <span class="badge badge-danger ml-2"><i class="fas fa-tag"></i> -${descontoProduto.toFixed(0)}%</span></p>`;
        } else {
            precoHtml = `<p class="card-text mb-0"><strong>Preço:</strong> ${formatarPreco(med.preco)}</p>`;
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
                    <p class="card-text mb-1"><small><strong>Fabricante:</strong> ${med.fabricante}</small></p>
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
    
    // A variável global 'listaDeCategorias' precisa estar disponível na página que chama esta função
    let optionsHtml = listaDeCategorias.map(cat => {
        const selected = med.categoria === cat.value ? 'selected' : '';
        return `<option value="${cat.value}" ${selected}>${cat.text}</option>`;
    }).join('');

    modalDiv.innerHTML = `
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
          <form class="row p-4">
            <div class="modal-header col-12">
              <h5 class="modal-title">Editar Medicamento</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Fechar"><span aria-hidden="true">&times;</span></button>
            </div>
            <input type="hidden" name="id" value="${med.id}" />
            <div class="col-md-6 mb-3 mt-3"><label class="form-label">Nome</label><input type="text" class="form-control" name="nome" value="${med.nome}" required></div>
            <div class="col-md-6 mb-3 mt-3"><label class="form-label">Categoria</label><select class="form-control" name="categoria" required><option value="">Selecione...</option>${optionsHtml}</select></div>
            <div class="col-md-6 mb-3"><label class="form-label">Princípio Ativo</label><input type="text" class="form-control" name="principio_ativo" value="${med.principio_ativo}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Fabricante</label><input type="text" class="form-control" name="fabricante" value="${med.fabricante}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Validade</label><input type="date" class="form-control" name="validade" value="${med.validade}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Lote</label><input type="text" class="form-control" name="lote" value="${med.lote}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Indicação</label><input type="text" class="form-control" name="indicacao" value="${med.indicacao}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Dosagem</label><input type="text" class="form-control" name="dosagem" value="${med.dosagem}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Forma</label><input type="text" class="form-control" name="forma" value="${med.forma}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Preço</label><input type="number" step="0.01" class="form-control" name="preco" value="${med.preco}" required></div>
            <div class="col-md-6 mb-3"><label class="form-label">Desconto (%)</label><input type="number" step="0.01" class="form-control" name="desconto" value="${med.desconto || ''}"  min='0' max='100'></div>
            <div class="col-md-6 mb-3"><label class="form-label">URL da Imagem</label><input type="url" class="form-control" name="imagem_url" value="${med.imagem_url || ''}" maxlength="255"></div>
            <div class="col-12 d-flex justify-content-between mt-3">
              <a href="#" data-id="${med.id}" data-nome="${med.nome}" class="btnExcluirMedicamento btn btn-danger">Excluir</a>
              <button type="submit" class="btn bg-cyan">Salvar alterações</button>
            </div>
          </form>
        </div>
      </div>`;
    return modalDiv;
}