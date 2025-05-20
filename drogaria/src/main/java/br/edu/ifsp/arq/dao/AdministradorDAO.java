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
	
	public ArrayList<Administrador> getAdministrador(){
		return this.listaDeAdministradores;
	}	
	
	public Administrador getAdministradorPorId(int id) {
	    for (Administrador a : listaDeAdministradores) {
	        if (a.getId() == id) return a;
	    }
	    return null;
	}
	
	public boolean atualizarAdministrador(int id, Administrador novo) {
	    for (int i = 0; i < listaDeAdministradores.size(); i++) {
	        Administrador atual = listaDeAdministradores.get(i);
	        if (atual.getId() == id) {
	            novo.setId(id);
	            listaDeAdministradores.set(i, novo);
	            return true;
	        }
	    }
	    return false;
	}
	
	public boolean adicionarAdministrador(Administrador a) {
		return this.listaDeAdministradores.add(a);
	}
	
	public boolean removerAdministradorPorId(int id) {
	    return this.listaDeAdministradores.removeIf(a -> a.getId() == id);
	}
	
	public ArrayList<Administrador> getAdministradores(){
		return this.listaDeAdministradores;
	}
	
	public boolean emailExiste(String email) {
	    for (Administrador a : listaDeAdministradores) {
	        if (a.getEmail().equalsIgnoreCase(email)) {
	            return true;
	        }
	    }
	    return false;
	}
}