package br.edu.ifsp.arq.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.edu.ifsp.arq.dao.AdministradorDAO;
import br.edu.ifsp.arq.model.Administrador;

@WebServlet("/CreateAdminServlet")
public class CreateAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AdministradorDAO dao;
       
   
    public CreateAdminServlet() {
        super();
        dao = AdministradorDAO.getInstance();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nome = request.getParameter("nome");
		String cpf = request.getParameter("cpf");
		String email = request.getParameter("email");
		String senha = request.getParameter("senha");
		
		String msg = "";
		if(nome.isEmpty() || email.isEmpty() || senha.isEmpty()){
			msg = "Nome, email e senha obrigatórios" ;
			request.setAttribute("mensagem", msg);
			request.setAttribute("classAlert","alert alert-danger");
			getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
		}else{
			Administrador a = new Administrador(nome, email, cpf, senha);
			if(dao.adicionarAdministrador(a)) {
				msg = "Perfil criado com sucesso. Novo administrador: "+nome;
				request.setAttribute("mensagem", msg);
				request.setAttribute("classAlert","alert alert-success");
			};
			
			getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
		}
	}

}
