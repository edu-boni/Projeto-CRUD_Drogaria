package br.edu.ifsp.arq.model;

import java.io.Serializable;

public class Administrador implements Serializable{
	private static final long serialVersionUID = 1L;
    private static int proximo_id = 0;
    private int id;
    private String nome;
    private String email;
    private String cpf;
    private String senha;
    
    public Administrador() {
    	this.id = ++proximo_id;
    }

	public Administrador(String nome, String email, String cpf, String senha) {
		this();
		this.nome = nome;
		this.email = email;
		this.cpf = cpf;
		this.senha = senha;
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
	
	@Override
	public String toString() {
	    return "Administrador{id=" + id + ", nome=" + nome + ", email=" + email + "}";
	}

}