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
       const liRemedios = document.createElement("li");
       liRemedios.className = "nav-item dropdown mx-1";
       liRemedios.innerHTML = `
         <a class="nav-link dropdown-toggle text-white font-weight-bold" href="#" id="navbarDropdownRemedio"
           role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
           <i class="fas fa-pills mr-1"></i> Medicamentos
         </a>
         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownRemedio">
           <a class="dropdown-item" href="/drogaria/medicamento/form-medicamento.html">Adicionar novo remédio</a>
           <div class="dropdown-divider"></div>
           <a class="dropdown-item" href="/drogaria/medicamento/lista-medicamentos.html">Ver todos</a>
         </div>
       `;
       menu.appendChild(liRemedios);

       const liUsuario = document.createElement("li");
       liUsuario.className = "nav-item dropdown mx-1";
       liUsuario.innerHTML = `
         <a class="nav-link dropdown-toggle text-white font-weight-bold" href="#" id="navbarDropdownUsuario"
           role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
           <i class="fas fa-user mr-1"></i> <span id="span-nome-usuario">${usuarioLogado.nome || "Usuário"}</span>
         </a>
         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownUsuario">
           <a class="dropdown-item" href="/drogaria/adm/editar-adm.jsp">Meus dados</a>
           <div class="dropdown-divider"></div>
           <a class="dropdown-item text-danger" href="#" id="btnLogout">Sair</a>
         </div>
       `;
       menu.appendChild(liUsuario);
       formBusca.style.maxWidth = "300px";
     } else {
       menu.appendChild(criarItemMenu("/drogaria/public/login.html", "fas fa-user", "Login"));
       formBusca.style.maxWidth = "600px";
     }
   });