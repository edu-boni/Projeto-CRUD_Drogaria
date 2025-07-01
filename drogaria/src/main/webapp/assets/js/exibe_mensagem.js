function exibe_mensagem(msg = null, cor = null) {
  const alerta = document.getElementById("alerta-mensagem");
  if (!alerta) return;

  if (msg && cor) {
    carregarMensagem(msg, cor, alerta);
    return;
  }

  msg = sessionStorage.getItem("mensagem");
  cor = sessionStorage.getItem("mensagem-cor");

  if (msg && cor) {
    carregarMensagem(msg, cor, alerta);
    sessionStorage.removeItem("mensagem");
    sessionStorage.removeItem("mensagem-cor");
  }
}

function carregarMensagem(msg, cor, alerta) {
  const p = document.createElement("p");
  p.innerText = msg;
  alerta.appendChild(p);
  alerta.classList.add(cor, "p-2")

  setTimeout(() => {
    alerta.removeChild(p);
	if (alerta.childElementCount === 0) {
	  alerta.classList.remove(cor, "p-2");
	}
  }, 5000);
}

document.addEventListener("header-carregado", exibe_mensagem);