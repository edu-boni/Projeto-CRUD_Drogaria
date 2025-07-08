package br.edu.ifsp.arq.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Medicamento implements Serializable {
	private static final long serialVersionUID = 1L;
    private static int proximo_id = 0;
    private int id;
	private String nome;
	private String principio_ativo;
	private String fabricante;
	private String validade;
	private String lote;
	private String indicacao;
	private String dosagem;
	private String forma;
	private double preco;
	private String imagem_url;
	private Categoria categoria;
	private double desconto; 
	private List<Comentario> comentarios;
	
	public Medicamento() {
		this.id = ++proximo_id;
		this.comentarios = new ArrayList<>(); 
	}

	public Medicamento(String nome, String principio_ativo, String fabricante, String validade, String lote, String indicacao, String dosagem, String forma, double preco, String imagem_url, Categoria categoria, double desconto) {
		this();
		this.nome = nome;
		this.principio_ativo = principio_ativo;
		this.fabricante = fabricante;
		this.validade = validade;
		this.lote = lote;
		this.indicacao = indicacao;
		this.dosagem = dosagem;
		this.forma = forma;
		this.preco = preco;
		this.imagem_url = imagem_url;
		this.categoria = categoria;
        this.desconto = desconto;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getPrincipio_ativo() {
		return principio_ativo;
	}

	public void setPrincipio_ativo(String principio_ativo) {
		this.principio_ativo = principio_ativo;
	}

	public String getFabricante() {
		return fabricante;
	}

	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}

	public String getValidade() {
		return validade;
	}

	public void setValidade(String validade) {
		this.validade = validade;
	}

	public String getLote() {
		return lote;
	}

	public void setLote(String lote) {
		this.lote = lote;
	}

	public String getIndicacao() {
		return indicacao;
	}

	public void setIndicacao(String indicacao) {
		this.indicacao = indicacao;
	}

	public String getDosagem() {
		return dosagem;
	}

	public void setDosagem(String dosagem) {
		this.dosagem = dosagem;
	}

	public String getForma() {
		return forma;
	}

	public void setForma(String forma) {
		this.forma = forma;
	}	
	
	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}

	public String getImagem_url() {
		return imagem_url;
	}

	public void setImagem_url(String imagem_url) {
		this.imagem_url = imagem_url;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
	    this.id = id;
	}
	
	public Categoria getCategoria() {
		 return categoria;
   }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public double getDesconto() {
        return desconto;
    }

    public void setDesconto(double desconto) {
        this.desconto = desconto;
    }
    
    public List<Comentario> getComentarios() {
        return comentarios;
    }
    public void adicionarComentario(Comentario comentario) {
        this.comentarios.add(comentario);
    }

}
