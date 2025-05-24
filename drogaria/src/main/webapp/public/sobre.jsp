<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>

<c:import url="/include/header.jsp"></c:import>

<main class="container mt-5 d-flex justify-content-center align-items-center flex-column" style="min-height: 80vh">

    <div class="bg-light shadow-sm rounded p-4 mb-5 w-100" style="max-width: 900px;">
        <h3 class="txt-cyan">Projeto Farmácia Bem Estar</h3>
        <p class="text-secondary">
            Este sistema foi desenvolvido com o objetivo de gerenciar o cadastro e a manipulação de medicamentos em uma farmácia. Ele permite que administradores realizem operações de cadastro, consulta, atualização e exclusão de medicamentos.
        </p>
        <p class="text-secondary">
            O projeto é ideal para fins acadêmicos e pode servir como base para sistemas comerciais simples, oferecendo uma estrutura clara para o aprendizado de conceitos de CRUD e MVC em aplicações web.
        </p>
    </div>

    <!-- Título da equipe -->
    <div class="text-center mb-5">
        <h4 class="txt-cyan">Conheça a equipe por trás do projeto</h4>
        <p class="text-secondary">Trabalho colaborativo e dedicado ao desenvolvimento de soluções práticas para o setor farmacêutico.</p>
    </div>

    <!-- Cards da Equipe -->
    <div class="row justify-content-center w-100">

        <!-- Card 1 -->
        <div class="col-md-4 mb-4">
            <div class="card shadow text-center h-100">
                <img src="<%= contextPath %>/images/eduardo.png" class="card-img-top" alt="Foto Eduardo" style="object-fit: cover; height: 300px;">
                <div class="card-body">
                    <h5 class="card-title txt-cyan">Eduardo Ferreira Bonifacio</h5>
                    <p class="text-secondary">Idade: 20 anos</p>
                    <p><strong>Remédio favorito:</strong> <img src="<%= contextPath %>/images/dorflex.png" alt="Dorflex" style="height: 20px; vertical-align: middle;"></p>
                </div>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="col-md-4 mb-4">
            <div class="card shadow text-center h-100">
                <img src="<%= contextPath %>/images/gabriel.png" class="card-img-top" alt="Foto Gabriel" style="object-fit: cover; height: 300px;">
                <div class="card-body">
                    <h5 class="card-title txt-cyan">Gabriel Albino</h5>
                    <p class="text-secondary">Idade: 20 anos</p>
                    <p><strong>Remédio favorito:</strong> <img src="<%= contextPath %>/images/dorflex.png" alt="Dorflex" style="height: 20px; vertical-align: middle;"></p>
                </div>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="col-md-4 mb-4">
            <div class="card shadow text-center h-100">
                <img src="<%= contextPath %>/images/gabrielle.png" class="card-img-top" alt="Foto Gabrielle" style="object-fit: cover; height: 300px;">
                <div class="card-body">
                    <h5 class="card-title txt-cyan">Gabrielle Ulisses</h5>
                    <p class="text-secondary">Idade: 20 anos</p>
                    <p><strong>Remédio favorito:</strong> <img src="<%= contextPath %>/images/dorflex.png" alt="Dorflex" style="height: 20px; vertical-align: middle;"></p>
                </div>
            </div>
        </div>

    </div>

</main>

<c:import url="/include/footer.jsp"></c:import>