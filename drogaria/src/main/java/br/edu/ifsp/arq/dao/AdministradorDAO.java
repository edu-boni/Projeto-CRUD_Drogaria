package br.edu.ifsp.arq.dao;

import java.util.ArrayList;

import br.edu.ifsp.arq.model.Administrador;

public class AdministradorDAO {
	private static AdministradorDAO instance;
	private ArrayList<Administrador> listaDeAdministradores;
	
	public AdministradorDAO() {
		this.listaDeAdministradores = new ArrayList<Administrador>();
	}
	
	public static AdministradorDAO getInstance() {
		if(instance==null) {
			instance = new AdministradorDAO();
		}
		return instance;
	}
	
	public boolean adicionarAdministrador(Administrador a) {
		return this.listaDeAdministradores.add(a);
	}
	
	public ArrayList<Administrador> getAdministradores(){
		return this.listaDeAdministradores;
	}	
}