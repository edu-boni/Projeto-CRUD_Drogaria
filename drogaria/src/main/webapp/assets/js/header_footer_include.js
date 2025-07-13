function popularFiltroDeBusca() {
    const dropdownMenu = document.getElementById('categoria-busca-dropdown');
    if (!dropdownMenu) return;

    const params = new URLSearchParams(window.location.search);
    const categoriaSelecionada = params.get('categoria');

    fetch('/drogaria/CategoriaServlet')
        .then(response => {
            if (!response.ok) {
                throw new Error('Falha ao buscar categorias');
            }
            return response.json();
        })
        .then(categorias => {
            dropdownMenu.innerHTML = '<a class="dropdown-item" href="#" data-value="TODOS">Todos</a>';
            let textoBotao = "Todos";

            categorias.forEach(cat => {
                const link = document.createElement('a');
                link.className = 'dropdown-item';
                link.href = '#';
                link.dataset.value = cat.value;
                link.textContent = cat.text;
                dropdownMenu.appendChild(link);
                
                if (cat.value === categoriaSelecionada) {
                    textoBotao = cat.text;
                }
            });

            document.getElementById('categoria-busca-btn').textContent = textoBotao;
            if (categoriaSelecionada) {
                document.getElementById('categoria-busca-hidden').value = categoriaSelecionada;
            }


            const categoriaAtiva = categoriaSelecionada || 'TODOS'; // Se não houver categoria na URL, 'TODOS' é o padrão
            const linkAtivoInicial = dropdownMenu.querySelector(`a[data-value="${categoriaAtiva}"]`);
            if (linkAtivoInicial) {
                linkAtivoInicial.classList.add('active');
            }
            
            dropdownMenu.addEventListener('click', function(e) {
                if (e.target.classList.contains('dropdown-item')) {
                    e.preventDefault();

                    const itemAtivoAnterior = dropdownMenu.querySelector('.dropdown-item.active');
                    if (itemAtivoAnterior) {
                        itemAtivoAnterior.classList.remove('active');
                    }

                    e.target.classList.add('active');

                    const textoClicado = e.target.textContent;
                    const valorClicado = e.target.dataset.value;
                    document.getElementById('categoria-busca-btn').textContent = textoClicado;
                    document.getElementById('categoria-busca-hidden').value = valorClicado;
                }
            });

        })
        .catch(error => {
            console.error("Erro ao carregar categorias para o filtro de busca:", error);
        });
}


function formatarNomeUsuario(nomeCompleto) {

	if (!nomeCompleto || nomeCompleto.trim() === '') {
        return "Usuário";
    }

    const partes = nomeCompleto.trim().split(' ');
    
    const primeiroNome = partes[0];

    if (partes.length > 1 && partes[1]) {
        const inicialSegundoNome = partes[1].charAt(0);
        return `${primeiroNome} ${inicialSegundoNome.toUpperCase()}.`;
    } else {
        return primeiroNome;
    }
}


document.body.addEventListener('submit', function(e) {
    if (e.target.classList.contains('form-comentario')) {
        e.preventDefault();
        const form = e.target;
        const submitButton = form.querySelector('button[type="submit"]');
        submitButton.disabled = true;

        const formData = new URLSearchParams(new FormData(form));
        formData.append('medicamentoId', form.dataset.medicamentoId);

        fetch('/drogaria/adicionar-comentario', { method: 'POST', body: formData })
        .then(response => response.json().then(data => ({ ok: response.ok, data: data })))
        .then(({ ok, data }) => {
            if (ok) {
                // --- LÓGICA DE ATUALIZAÇÃO CORRIGIDA ---
                const containerComentarios = form.closest('.card-body') || form.closest('.comentarios-section');

                if (containerComentarios) {
                    const listaComentarios = containerComentarios.querySelector('.lista-comentarios');
                    if (listaComentarios) {
                        const novoComentario = data.comentario;
                        
                        // Cria o HTML do novo comentário
                        const comentarioDiv = document.createElement('div');
                        comentarioDiv.className = 'comentario-item';
                        comentarioDiv.innerHTML = `<p><strong>${novoComentario.usuarioNome}</strong> <small class="text-muted">em ${novoComentario.data}</small></p><p class="mb-0 bg-light p-2 rounded">${novoComentario.texto}</p>`;
                        
                        // Cria o separador <hr>
                        const hr = document.createElement('hr');
                        hr.className = 'my-2';

                        // Procura pela mensagem "Nenhum comentário"
                        const pSemComentarios = listaComentarios.querySelector('p.text-muted');
                        if (pSemComentarios) {
                            // Se encontrar, remove apenas a mensagem
                            pSemComentarios.remove();
                        }

                        // Adiciona o novo comentário e o separador no topo da lista
                        listaComentarios.prepend(comentarioDiv);
                        if (listaComentarios.children.length > 1) {
                            // Adiciona um <hr> acima do segundo comentário em diante
                            comentarioDiv.after(hr);
                        }
                    }
                }
                form.reset();
            } else {
                Swal.fire('Erro!', data.message || 'Ocorreu um erro.', 'error');
            }
        })
        .catch(err => Swal.fire('Erro de Conexão', 'Não foi possível enviar seu comentário.', 'error'))
        .finally(() => { submitButton.disabled = false; });
    }
});

fetch('/drogaria/include/header.html')
  .then(response => response.text())
  .then(html => {
    document.getElementById('header-placeholder').innerHTML = html;
	document.dispatchEvent(new Event("header-carregado"));
  })
  .catch(error => {
    console.error('Erro ao carregar o header:', error);
  });

fetch('/drogaria/include/footer.html')
   .then(response => response.text())
   .then(html => {
     document.getElementById('footer-placeholder').innerHTML = html;
     document.dispatchEvent(new Event("footer-carregado"));
})
   .catch(error => {
     console.error('Erro ao carregar o footer:', error);
   });


   //Carrega conteúdo da navbar
   document.addEventListener("header-carregado", function () {
     const navbarContent = document.getElementById("navbarContent");
     if (!navbarContent) return;

     const menu = navbarContent.querySelector("ul.navbar-nav.ml-auto");
     if (!menu) return;

     const formBusca = navbarContent.querySelector("#form-busca");
     if (!formBusca) return;
	 
	 popularFiltroDeBusca();
	 
	 const campoTextoBusca = formBusca.querySelector('input[name="search"]');
	 
     if (campoTextoBusca) {
         const params = new URLSearchParams(window.location.search);
         const termoBusca = params.get('search');
         if (termoBusca) {
             campoTextoBusca.value = termoBusca;
         }
     }

     const usuarioLogadoJSON = sessionStorage.getItem("usuarioLogado");
     const usuarioLogado = usuarioLogadoJSON ? JSON.parse(usuarioLogadoJSON) : null;

     menu.innerHTML = "";

     function criarItemMenu(href, icone, texto) {
       const li = document.createElement("li");
       li.className = "nav-item mx-1";
       li.innerHTML = `
         <a class="nav-link text-white font-weight-bold" href="${href}">
           <i class="${icone}"></i> ${texto}
         </a>
       `;
       return li;
     }

     menu.appendChild(criarItemMenu("/drogaria/index.html", "fas fa-home", "Início"));
     menu.appendChild(criarItemMenu("/drogaria/public/sobre.html", "fas fa-info-circle", "Sobre"));

     if (usuarioLogado) {
		if(usuarioLogado.isAdmin === true){
	       const liRemedios = document.createElement("li");
	       liRemedios.className = "nav-item dropdown mx-1";
	       liRemedios.innerHTML = `
	         <a class="nav-link dropdown-toggle text-white font-weight-bold" href="#" id="navbarDropdownRemedio"
	           role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	           <i class="fas fa-pills mr-1"></i> Medicamentos
	         </a>
	         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownRemedio">
	           <a class="dropdown-item" href="/drogaria/medicamento/form-medicamento.html">Adicionar novo medicamento</a>
	           <div class="dropdown-divider"></div>
	           <a class="dropdown-item" href="/drogaria/medicamento/lista-medicamentos.html">Ver todos</a>
	         </div>
	       `;
	       menu.appendChild(liRemedios);
	   }else{
		   const li = document.createElement("li");
		   li.className = "nav-item mx-1";
		   li.innerHTML = `
	         <a class="nav-link text-white font-weight-bold" href="/drogaria/medicamento/lista-medicamentos.html">
	           <i class="fas fa-pills mr-1"></i> Medicamentos
	         </a>
	       `;
		   menu.appendChild(li);
	   }

       const liUsuario = document.createElement("li");
       liUsuario.className = "nav-item dropdown mx-1";
       liUsuario.innerHTML = `
         <a class="nav-link dropdown-toggle text-white font-weight-bold" href="#" id="navbarDropdownUsuario"
           role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
           <i class="fas fa-user mr-1"></i> <span id="span-nome-usuario">${formatarNomeUsuario(usuarioLogado.nome)}</span>
         </a>
         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownUsuario">
           <a class="dropdown-item" href="/drogaria/user/editar-usuario.html">Meus dados</a>
           <div class="dropdown-divider"></div>
           <a class="dropdown-item text-danger" href="#" id="btnLogout">Sair</a>
         </div>
       `;
       menu.appendChild(liUsuario);
       formBusca.style.maxWidth = "350px";
     } else {
       menu.appendChild(criarItemMenu("/drogaria/public/login.html", "fas fa-user", "Login"));
       formBusca.style.maxWidth = "600px";
     }
   });