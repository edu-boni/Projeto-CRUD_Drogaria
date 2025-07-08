package br.edu.ifsp.arq.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Comentario implements Serializable {
    private static final long serialVersionUID = 1L;

    private String usuarioNome;
    private String texto;
    private int avaliacao; 
    private String data;

    public Comentario(String usuarioNome, String texto, int avaliacao) {
        this.usuarioNome = usuarioNome;
        this.texto = texto;
        this.avaliacao = avaliacao;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy 'às' HH:mm");
        this.data = LocalDateTime.now().format(formatter);
    }

    public String getUsuarioNome() { 
    	return usuarioNome; 
	}
    
    public String getTexto() { 
    	return texto; 
	}
    
    public int getAvaliacao() { 
    	return avaliacao; 
	}
    
    public String getData() { 
    	return data; 
	}

}