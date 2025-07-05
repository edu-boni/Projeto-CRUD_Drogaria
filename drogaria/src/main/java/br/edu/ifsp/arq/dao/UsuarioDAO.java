package br.edu.ifsp.arq.dao;

import java.util.ArrayList;

import br.edu.ifsp.arq.model.Usuario;

public class UsuarioDAO {
	private static UsuarioDAO instance;
	private ArrayList<Usuario> listaDeUsuarios;
	
	public UsuarioDAO() {
		this.listaDeUsuarios = new ArrayList<Usuario>();
	}
	
	public static UsuarioDAO getInstance() {
		if(instance==null) {
			instance = new UsuarioDAO();
		}
		return instance;
	}
	
	public ArrayList<Usuario> getUsuarios(){
		return this.listaDeUsuarios;
	}	
	
	public Usuario getUsuariosPorId(int id) {
	    for (Usuario u : listaDeUsuarios) {
	        if (u.getId() == id) return u;
	    }
	    return null;
	}
	
	public boolean atualizarUsuario(int id, Usuario novo) {
	    for (int i = 0; i < listaDeUsuarios.size(); i++) {
	        Usuario atual = listaDeUsuarios.get(i);
	        if (atual.getId() == id) {
	            novo.setId(id);
	            listaDeUsuarios.set(i, novo);
	            return true;
	        }
	    }
	    return false;
	}
	
	public boolean adicionarUsuario(Usuario u) {
		return this.listaDeUsuarios.add(u);
	}
	
	public boolean removerUsuarioPorId(int id) {
	    return this.listaDeUsuarios.removeIf(u -> u.getId() == id);
	}
	
	public boolean emailExiste(String email) {
	    for (Usuario u : listaDeUsuarios) {
	        if (u.getEmail().equalsIgnoreCase(email)) {
	            return true;
	        }
	    }
	    return false;
	}
}