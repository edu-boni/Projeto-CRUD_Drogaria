<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>

<c:import url="/include/header.jsp"></c:import>

<main class="container mt-5 d-flex justify-content-center align-items-center flex-column" style="min-height: 80vh">

    <div class="bg-light shadow-sm rounded p-4 mb-5 w-100">
        <h3 class="txt-cyan">Projeto Farmácia Bem-estar</h3>
        <p class="text-secondary">
            Este sistema foi desenvolvido com o objetivo de gerenciar o cadastro e a manipulação de medicamentos em uma farmácia. Ele permite que administradores realizem operações de cadastro, consulta, atualização e exclusão de medicamentos.
        </p>
        <p class="text-secondary">
            O projeto é um trabalho acadêmico do 3° semestre do curso de Tecnologia de Sistemas para internet para a disciplina de Desenvolvimento de Sistemas Web 1 (WEB1). O objetivo é desenvolver uma estrutura que abranja os conteúdos aprendidos em sala de aula em um sistema web com CRUD e padrão MVC.
        </p>
    </div>
	
	<div class="w-100">
	    <!-- Título da equipe -->
	    <div class="text-center mb-2">
	        <h4 class="txt-cyan">Conheça a equipe por trás do projeto</h4>
	        <p class="text-secondary">Selecione as pílulas para conhecer um pouco de cada um através de bulas.</p>
	    </div>
		
        <div class="d-flex flex-wrap justify-content-center pill-wrapper mb-4">
		    <div class="pill pill-blue pill-fixed" onclick="showContent('content1')"></div>
		    <div class="pill pill-cyan pill-fixed" onclick="showContent('content2')"></div>
		    <div class="pill pill-red pill-fixed" onclick="showContent('content3')"></div>
		</div>
		
		<!-- Conteúdos ocultos -->
		<div id="content1" class="pill-content d-none mt-5 position-relative">
		    <div class="card p-4 mb-3 position-relative">
		        <p class="text-muted position-absolute m-0 d-flex align-items-center"
		           style="top: 15px; left: 20px; cursor: pointer; font-family: 'Inter', sans-serif"
		           onclick="hideContent('content1')">
		            <i class="fas fa-times mr-2"></i> <b>Fechar</b>
		        </p>
		        <img src="<%= contextPath %>/images/eduardo.png" alt="Eduardo Ferreira Bonifacio"
		             class="rounded-circle position-absolute"
		             style="top: 15px; right: 20px; width: 150px; height: 150px; object-fit: cover; border: 2px solid #ddd;">
		        <div class="mt-3 pt-3">
		            <h4>IDENTIFICAÇÃO DO DESENVOLVEDOR</h4>
		            <h2><b>Eduardo Ferreira</b></h2>
		            <p>"Medicamente genérico Lei n° 9.787, de 1999"</p>
		            <h5>VIA ORAL<br>USO ADULTO</h5>
		            <h4>APRESENTAÇÕES</h4>
		            <p>[Texto descritivo de Eduardo aqui]</p>
		            <h4>MEDICAMENTO FAVORITO</h4>
		            <p>[Nome do medicamento favorito]</p>
		        </div>
		    </div>
		</div>
		
		<!-- Conteúdo Gabriel -->
		<div id="content2" class="pill-content d-none mt-5 position-relative">
		    <div class="card p-4 mb-3 position-relative">
		        <p class="text-muted position-absolute m-0 d-flex align-items-center"
		           style="top: 15px; left: 20px; cursor: pointer; font-family: 'Inter', sans-serif"
		           onclick="hideContent('content2')">
		            <i class="fas fa-times mr-2"></i> <b>Fechar</b>
		        </p>
		        <img src="<%= contextPath %>/images/gabriel.png" alt="Gabriel Albino"
		             class="rounded-circle position-absolute"
		             style="top: 15px; right: 20px; width: 150px; height: 150px; object-fit: cover; border: 2px solid #ddd;">
		        <div class="mt-3 pt-3">
		            <h4>IDENTIFICAÇÃO DO DESENVOLVEDOR</h4>
		            <h2><b>Gabriel Albino</b></h2>
		            <p>"Medicamente genérico Lei n° 9.787, de 1999"</p>
		            <h5>VIA ORAL<br>USO ADULTO</h5>
		            <h4>APRESENTAÇÕES</h4>
		            <p>Tenho 20 anos e atuo na área de informática como suporte, em contato frequente com SQL. Amo desenhar, cozinhar e fazer coisas bonitas e diferentes através do design.</p>
		            <h4>MEDICAMENTO FAVORITO</h4>
		            <p>Adenosina ................................................. 6mg</p>
		        </div>
		    </div>
		</div>
		
		<!-- Conteúdo Gabrielle -->
		<div id="content3" class="pill-content d-none mt-5 position-relative">
		    <div class="card p-4 mb-3 position-relative">
		        <p class="text-muted position-absolute m-0 d-flex align-items-center"
		           style="top: 15px; left: 20px; cursor: pointer; font-family: 'Inter', sans-serif"
		           onclick="hideContent('content3')">
		            <i class="fas fa-times mr-2"></i> <b>Fechar</b>
		        </p>
		        <img src="<%= contextPath %>/images/gabrielle.png" alt="Gabrielle Ulisses da Silva"
		             class="rounded-circle position-absolute"
		             style="top: 15px; right: 20px; width: 150px; height: 150px; object-fit: cover; border: 2px solid #ddd;">
		        <div class="mt-3 pt-3">
		            <h4>IDENTIFICAÇÃO DO DESENVOLVEDOR</h4>
		            <h2><b>Gabrielle Ulisses</b></h2>
		            <p>"Medicamente genérico Lei n° 9.787, de 1999"</p>
		            <h5>VIA ORAL<br>USO ADULTO</h5>
		            <h4>APRESENTAÇÕES</h4>
		            <p>[Texto descritivo de Gabrielle aqui]</p>
		            <h4>MEDICAMENTO FAVORITO</h4>
		            <p>[Nome do medicamento favorito]</p>
		        </div>
		    </div>
		</div>
	</div>

</main>
<script>
	function showContent(id) {
	    document.querySelectorAll('.pill-content').forEach(el => el.classList.add('d-none'));	    
	    document.getElementById(id).classList.remove('d-none');
	}
	
	function hideContent(id) {
	    document.getElementById(id).classList.add('d-none');
	}
</script>

<c:import url="/include/footer.jsp"></c:import>