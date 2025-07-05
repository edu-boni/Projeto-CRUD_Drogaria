document.addEventListener("footer-carregado", function () {
  const form = document.getElementById('form-cadastro-usuario');
  if (!form) return;

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    handleFormSubmit(e);
  });
});

function handleFormSubmit(e) {
  const form = e.target;
  const formData = new URLSearchParams();
  formData.append('nome', form.nome.value);
  formData.append('cpf', form.cpf.value);
  formData.append('email', form.email.value);
  formData.append('senha', form.senha.value);

  fetch('/drogaria/CreateUserServlet', {
    method: 'POST',
    body: formData
  })
    .then(response => response.json().then(data => ({ ok: response.ok, body: data })))
    .then(({ ok, body }) => {
      const message = body.message;

      if (ok) {
        sessionStorage.setItem("mensagem", message);
        sessionStorage.setItem("mensagem-cor", "alert-success");
        window.location.href = '/drogaria/public/login.html';
      } else {
        exibe_mensagem(message, "alert-danger");
      }
    })
    .catch(error => {
      console.error("Erro inesperado:", error);
      exibe_mensagem("Erro ao cadastrar. Tente novamente mais tarde.", "alert-danger");
    });
}
