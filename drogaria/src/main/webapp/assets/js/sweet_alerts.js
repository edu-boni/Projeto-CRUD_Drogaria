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

