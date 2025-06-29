fetch('/drogaria/include/header.jsp')
  .then(response => response.text())
  .then(html => {
    document.getElementById('header-placeholder').innerHTML = html;
	document.dispatchEvent(new Event("header-carregado")); // ✅ dispara evento global
  })
  .catch(error => {
    console.error('Erro ao carregar o header:', error);
  });

fetch('/drogaria/include/footer.html')
  .then(response => response.text())
  .then(html => {
    document.getElementById('footer-placeholder').innerHTML = html;
  })
  .catch(error => {
    console.error('Erro ao carregar o footer:', error);
  });