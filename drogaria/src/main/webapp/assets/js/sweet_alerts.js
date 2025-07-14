function incluiuHeaderFooter() {
  const btnLogout = document.getElementById("btnLogout");
  btnLogout.addEventListener("click", function(e) {
    e.preventDefault();
    Swal.fire({
      title: "Deseja realmente sair?",
      text: "Sua sessão será encerrada.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#dc143c",
      cancelButtonColor: "#6c757d",
      confirmButtonText: "Sair",
      cancelButtonText: "Cancelar"
    }).then((result) => {
      if (result.isConfirmed) {
		sessionStorage.removeItem("usuarioLogado");
		window.location.href = "/drogaria/index.html";
      }
    });
  });
}

document.addEventListener("header-carregado", incluiuHeaderFooter);

function configurarBotoesExcluirMedicamento() {
  document.querySelectorAll(".btnExcluirMedicamento").forEach(btn => {
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      const id = btn.dataset.id;
      const nome = btn.dataset.nome;

      Swal.fire({
        title: `Deseja excluir o medicamento "${nome}"?`,
        text: "Essa ação não poderá ser desfeita!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#dc143c",
        cancelButtonColor: "#a9a9a9",
        confirmButtonText: "Excluir",
        cancelButtonText: "Cancelar"
      }).then((result) => {
        if (result.isConfirmed) {
          window.location.href = "/drogaria/DeleteMedicamentoServlet?id=" + id;
        }
      });
    });
  });
}

function configurarBotoesExcluirComentario() {
  document.querySelectorAll(".btn-excluir-comentario").forEach(btn => {
    // Adiciona um listener de clique para cada botão de excluir
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      
      const medicamentoId = this.dataset.medicamentoId;
	  const comentarioId = this.dataset.comentarioId;

      Swal.fire({
        title: 'Deseja realmente excluir este comentário?',
        text: "Essa ação não poderá ser desfeita!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#dc143c",
        cancelButtonColor: "#a9a9a9",
        confirmButtonText: "Excluir",
        cancelButtonText: "Cancelar"
      }).then((result) => {
        if (result.isConfirmed) {
          const formData = new URLSearchParams();
          formData.append('medicamentoId', medicamentoId);
		  formData.append('comentarioId', comentarioId);

          fetch('/drogaria/delete-comentario', {
              method: 'POST',
              body: formData
          })
          .then(response => response.json().then(data => ({ok: response.ok, data: data})))
          .then(({ok, data}) => {
              if (ok) {
					Swal.fire({
					    title: 'Excluído!',
					    text: data.message,
					    icon: 'success',
					    confirmButtonColor: "#6FB2A4"
					});
                  const comentarioItem = this.closest('.comentario-item');
                  const hrSeparador = comentarioItem.nextElementSibling; // Pega o <hr> depois do comentário
                  if(hrSeparador && hrSeparador.tagName === 'HR') {
                      hrSeparador.remove();
                  }
                  comentarioItem.remove();
              } else {
                  Swal.fire('Erro!', data.message, 'error');
              }
          }).catch(err => Swal.fire('Erro de Conexão!', 'Não foi possível excluir o comentário.', 'error'));
        }
      });
    });
  });
}
