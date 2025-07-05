package br.edu.ifsp.arq.model;

import java.io.Serializable;

public class Usuario implements Serializable{
	private static final long serialVersionUID = 1L;
    private static int proximo_id = 0;
    private int id;
    private String nome;
    private String email;
    private String cpf;
    private String senha;
    private Boolean admin;
    
    public Usuario() {
    	this.id = ++proximo_id;
    }

	public Usuario(String nome, String email, String cpf, String senha, Boolean admin) {
		this();
		this.nome = nome;
		this.email = email;
		this.cpf = cpf;
		this.senha = senha;
		this.admin = admin;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
	    this.id = id;
	}
	
	public Boolean isAdmin() {
		return admin;
	}
	
	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}
	
	@Override
	public String toString() {
	    return "Usuario{id="+getId()+", nome="+getNome()+", email="+getEmail()+", admin ="+isAdmin()+"}";
	}
}