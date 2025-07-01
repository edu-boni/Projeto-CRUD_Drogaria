function incluiuHeaderFooter() {
  const btnExcluir = document.getElementById("btnExcluirConta");
  if (btnExcluir) {
    btnExcluir.addEventListener("click", function (e) {
      e.preventDefault();
      const id = btnExcluir.dataset.id;

      Swal.fire({
        title: "Deseja deletar a sua conta?",
        text: "Essa ação não pode ser desfeita!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#dc143c",
        cancelButtonColor: "#a9a9a9",
        confirmButtonText: "Excluir conta",
        cancelButtonText: "Cancelar"
      }).then((result) => {
        if (result.isConfirmed) {
          window.location.href = "/drogaria/DeleteADMServlet?id=" + id;
        }
      });
    });
  }

  document.querySelectorAll(".btnExcluirMedicamento").forEach(btn => {
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      const id = btn.dataset.id;

      Swal.fire({
        title: "Deseja excluir o medicamento?",
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
		window.location.href = "/drogaria/index.jsp";
      }
    });
  });
}

document.addEventListener("header-carregado", incluiuHeaderFooter);
