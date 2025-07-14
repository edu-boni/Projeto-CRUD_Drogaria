package br.edu.ifsp.arq.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Comentario implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String usuarioNome;
    private String texto;
    private String data;

    public Comentario() {}

    public Comentario(String usuarioNome, String texto) {
        this.usuarioNome = usuarioNome;
        this.texto = texto;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy 'às' HH:mm");
        this.data = LocalDateTime.now().format(formatter);
    }
    
    public Comentario(int id, String usuarioNome, String texto) {
        this.id = id;
        this.usuarioNome = usuarioNome;
        this.texto = texto;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy 'às' HH:mm");
        this.data = LocalDateTime.now().format(formatter);
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsuarioNome() { return usuarioNome; }
    public String getTexto() { return texto; }
    public String getData() { return data; }
}
