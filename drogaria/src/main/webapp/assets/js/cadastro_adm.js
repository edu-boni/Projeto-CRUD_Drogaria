document.addEventListener("footer-carregado", function () {
  const form = document.getElementById('form-cadastro-adm');
  if (!form) return;
  
  form.addEventListener('submit', async function (e) {
    e.preventDefault();

    const formData = new URLSearchParams();
    formData.append('nome', form.nome.value);
    formData.append('cpf', form.cpf.value);
    formData.append('email', form.email.value);
    formData.append('senha', form.senha.value);

    try {
      const response = await fetch('/drogaria/CreateAdminServlet', {
        method: 'POST',
        body: formData
      });

      const { message } = await response.json();

      if (response.ok) {
        sessionStorage.setItem("mensagem", message);
        sessionStorage.setItem("mensagem-cor", "alert-success");
        window.location.href = '/drogaria/public/login.html';
      } else {
        exibe_mensagem(message, "alert-danger");
      }
    } catch (error) {
      console.error("Erro inesperado:", error);
      exibe_mensagem("Erro ao cadastrar. Tente novamente mais tarde.", "alert-danger");
    }
  });
});
