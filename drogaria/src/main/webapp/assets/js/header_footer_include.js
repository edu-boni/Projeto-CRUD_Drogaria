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
   
//-----

document.addEventListener("header-carregado", () => {
  const usuarioLogado = JSON.parse(sessionStorage.getItem("usuarioLogado"));

  document.querySelectorAll(".area-logado").forEach(el => {
    el.style.display = usuarioLogado ? "block" : "none";
  });

  document.querySelectorAll(".area-nao-logado").forEach(el => {
    el.style.display = usuarioLogado ? "none" : "block";
  });

  const nomeSpan = document.getElementById("span-nome-usuario");
  if (usuarioLogado && nomeSpan) {
    nomeSpan.textContent = usuarioLogado.nome;
  }

  const formBusca = document.getElementById("form-busca");
  if (formBusca) {
    formBusca.style.maxWidth = usuarioLogado ? "300px" : "600px";
  }
});
