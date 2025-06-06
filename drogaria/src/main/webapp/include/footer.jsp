<% String contextPath = request.getContextPath(); %>

<footer class="container-fluid p-4 mt-5 bg-cyan w-100 text-center">
	<img src="<%= contextPath %>/images/logo.png" alt="Logo" style="height: 50px;">
	<p class="mt-3 mb-0">Farm�cia Bem-Estar &copy; 2025 - Todos os direitos reservados - TSI IFSP Araraquara</p>
</footer>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
const btn = document.getElementById("btnExcluirConta");
btn?.addEventListener("click", function (e) {
  e.preventDefault();
  const id = btn.dataset.id;

  Swal.fire({
    title: "Deseja deletar a sua conta?",
    text: "Essa a��o n�o pode ser desfeita!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#dc143c",
    cancelButtonColor: "#a9a9a9",
    confirmButtonText: "Excluir conta",
    cancelButtonText: "Cancelar"
  }).then((result) => {
    if (result.isConfirmed) {
    	window.location.href = "<%= request.getContextPath() %>/DeleteADMServlet?id=" + id;

    }
  });
});

document.querySelectorAll(".btnExcluirMedicamento").forEach(btn => {
  btn.addEventListener("click", function (e) {
    e.preventDefault();

    const id = btn.dataset.id;

    Swal.fire({
      title: "Deseja excluir o medicamento?",
      text: "Essa a��o n�o poder� ser desfeita!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#dc143c",
      cancelButtonColor: "#a9a9a9",
      confirmButtonText: "Excluir",
      cancelButtonText: "Cancelar"
    }).then((result) => {
      if (result.isConfirmed) {
        window.location.href = "<%= request.getContextPath() %>/DeleteMedicamentoServlet?id=" + id;
      }
    });
  });
});

  document.getElementById("btnLogout")?.addEventListener("click", function(e) {
    e.preventDefault(); 

    Swal.fire({
      title: "Deseja realmente sair?",
      text: "Sua sess�o ser� encerrada.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#dc143c",
      cancelButtonColor: "#6c757d",
      confirmButtonText: "Sair",
      cancelButtonText: "Cancelar"
    }).then((result) => {
      if (result.isConfirmed) {
        window.location.href = "<%= contextPath %>/adm/logout.jsp";
      }
    });
  });
</script>



<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
</body>
</html>