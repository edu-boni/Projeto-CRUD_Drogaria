<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="header.jsp"></c:import>

<main class="container mt-5">
    <section>
        <h1>Bem-vindo à Farmácia Online</h1>
        <p>Escolha um medicamento para mais informações.</p>

        <!-- Catálogo de Medicamentos -->
        <div class="row">
            <!-- Card 1 -->
            <div class="col-md-4 mb-4">
                <div class="card hover-shadow">
                    <img src="https://storage.googleapis.com/sicompra-files/uploads/catalogos/produtos/imagens/jpg/7891058017507.jpg"" class="card-img-top" alt="Dorflex">
                    <div class="card-body">
                        <h5 class="card-title">Dorflex</h5>
                        <p class="card-text">Analgesico e Relaxante Muscular.</p>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#loginModal">Acessar Medicamento</button>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-md-4 mb-4">
                <div class="card hover-shadow">
                    <img src="https://storage.googleapis.com/sicompra-files/uploads/catalogos/produtos/imagens/jpg/7891058017507.jpg" class="card-img-top" alt="Medicamento 2">
                    <div class="card-body">
                        <h5 class="card-title">Medicamento 2</h5>
                        <p class="card-text">Descrição breve do medicamento.</p>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#loginModal">Acessar Medicamento</button>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-4 mb-4">
                <div class="card hover-shadow">
                    <img src="https://storage.googleapis.com/sicompra-files/uploads/catalogos/produtos/imagens/jpg/7891058017507.jpg" class="card-img-top" alt="Medicamento 3">
                    <div class="card-body">
                        <h5 class="card-title">Medicamento 3</h5>
                        <p class="card-text">Descrição breve do medicamento.</p>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#loginModal">Acessar Medicamento</button>
                    </div>
                </div>
            </div>
        </div>

    </section>
	<%if (session.getAttribute("usuarioLogado") == null){ %>
    <!-- Modal de Login/Cadastro -->
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Acesso Restrito</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <p>Para acessar informações sobre este medicamento, por favor, faça login ou se cadastre.</p>
                    <a href="login.jsp" class="btn btn-primary">Fazer Login</a>
                    <a href="cadastrarADM.jsp" class="btn btn-secondary">Cadastrar-se</a>
                </div>
              
            </div>
        </div>
    </div>
    <%} %>
</main>

<c:import url="footer.jsp"></c:import>
