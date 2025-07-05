//Determina saudação com base na hora
document.addEventListener("footer-carregado", function () {
	 const divSaudacao = document.getElementById("saudacao");
	 if (!divSaudacao) return;
	
	 divSaudacao.innerHTML = "";
	
	 const usuarioLogadoJSON = sessionStorage.getItem("usuarioLogado");
	 const usuarioLogado = usuarioLogadoJSON ? JSON.parse(usuarioLogadoJSON) : null;
	
	 if (!usuarioLogado || !usuarioLogado.nome) {
	   return;
	 }
	
	 const agora = new Date();
	 const hora = agora.getHours();
	 let saudacao = "Boa noite";
	 if (hora >= 5 && hora < 12) {
	   saudacao = "Bom dia";
	 } else if (hora >= 12 && hora < 18) {
	   saudacao = "Boa tarde";
	 }
	
	 const h2 = document.createElement("h2");
	 h2.append(`${saudacao}, `);
	
	 const span = document.createElement("span");
	 span.className = "txt-cyan";
	 span.textContent = usuarioLogado.nome;
	
	 h2.appendChild(span);
	 h2.append("!");
	
	 divSaudacao.appendChild(h2);
	
	 if(usuarioLogado.isAdmin === true){
		 //Cria o botão cadastro medicamentos
		 const botao = document.createElement("a");
		 botao.href = "/drogaria/medicamento/form-medicamento.html";
		 botao.className = "btn w-100 bg-cyan custom-gradient p-3 text-right font-weight-bold mb-4 mt-1";
		 botao.innerHTML = `<i class="fas fa-plus-circle"></i> Cadastrar medicamento`;
		 divSaudacao.appendChild(botao);
	 }else{
		h2.classList.add("mb-4");
	 }
	
});
	
//Conteúdo da seção vantagens
document.addEventListener("footer-carregado", function () {
	 const sectionVantagens = document.getElementById("vantagens");
	 if (!sectionVantagens) return;
	
	 const usuarioLogadoJSON = sessionStorage.getItem("usuarioLogado");
	 const usuarioLogado = usuarioLogadoJSON ? JSON.parse(usuarioLogadoJSON) : null;
	
	 if (usuarioLogado && usuarioLogado.nome) {
	   sectionVantagens.innerHTML = "";
	   return;
	 }
	
	 const row = document.createElement("div");
	 row.className = "row align-items-center";
	
	 const colImagem = document.createElement("div");
	 colImagem.className = "col-md-3 text-center d-none d-md-block";
	 colImagem.innerHTML = `
	   <img src="/drogaria/assets/images/medico.png" alt="Médico"
	        class="img-fluid" style="max-height: 300px;">
	 `;
	
	 const colVantagens = document.createElement("div");
	 colVantagens.className = "col-md-4 text-center";
	 colVantagens.innerHTML = `
	   <h5 class="mb-3 txt-cyan">Vantagens do cadastro</h5>
	   <button class="btn btn-light rounded-circle w-100 h-100 vantagem m-2 text-white bg-cyan"
	           data-toggle="modal" data-target="#loginModal">
	     <b><i class="fas fa-solid fa-tag"></i><br>Ofertas exclusivas</b>
	   </button>
	   <button class="btn btn-light rounded-circle w-100 h-100 vantagem m-2 text-white bg-cyan"
	           data-toggle="modal" data-target="#loginModal">
	     <b><i class="fas fa-solid fa-plus"></i><br>Cadastrar remédios</b>
	   </button>
	   <button class="btn btn-light rounded-circle w-100 h-100 vantagem m-2 text-white bg-cyan"
	   	           data-toggle="modal" data-target="#loginModal">
	   	 <b><i class="fas fa-solid fa-comments"></i><br>Leia e comente</b>
	   </button>
	 `;
	
	 const colCadastro = document.createElement("div");
	 colCadastro.className = "col-md-5";
	 colCadastro.innerHTML = `
	   <h5 class="m-3 text-center txt-cyan">Cadastre-se</h5>
	   <form id="form-cadastro-usuario">
	     <div class="form-row">
	       <div class="form-group col-6">
	         <input type="text" name="nome" class="form-control" placeholder="Nome completo" required>
	       </div>
	       <div class="form-group col-6">
	         <input type="text" name="cpf" class="form-control" placeholder="CPF">
	       </div>
	     </div>
	     <div class="form-group">
	       <input type="email" name="email" class="form-control" placeholder="e-mail" required>
	     </div>
	     <div class="form-group">
	       <input type="password" name="senha" class="form-control" placeholder="Senha" required>
	     </div>
	     <button type="submit" class="btn bg-cyan btn-block mt-2">Cadastrar</button>
	   </form>
	 `;
	
	 row.appendChild(colImagem);
	 row.appendChild(colVantagens);
	 row.appendChild(colCadastro);
	
	 sectionVantagens.innerHTML = "";
	 sectionVantagens.appendChild(row);
});