package br.edu.ifsp.arq.dao;

import java.util.ArrayList;

import br.edu.ifsp.arq.model.Categoria;
import br.edu.ifsp.arq.model.Comentario;
import br.edu.ifsp.arq.model.Medicamento;

public class MedicamentoDAO {
	private static MedicamentoDAO instance;
	private ArrayList<Medicamento> listaDeMedicamentos;
	
	private MedicamentoDAO() {
		this.listaDeMedicamentos = new ArrayList<Medicamento>();
	}
	
	public static MedicamentoDAO getInstance() {
		if(instance==null) {
			instance = new MedicamentoDAO();
		}
		return instance;
	}
	
	public boolean adicionarMedicamento(Medicamento m) {
		return this.listaDeMedicamentos.add(m);
	}
	
	public ArrayList<Medicamento> getMedicamentos(){
		return this.listaDeMedicamentos;
	}	
	
	public Medicamento getMedicamentoPorId(int id) {
	    for (Medicamento m : listaDeMedicamentos) {
	        if (m.getId() == id) return m;
	    }
	    return null;
	}

	/*public boolean atualizarMedicamento(int id, Medicamento novo) {
	    for (int i = 0; i < listaDeMedicamentos.size(); i++) {
	        Medicamento atual = listaDeMedicamentos.get(i);
	        if (atual.getId() == id) {
	            novo.setId(id);
	            listaDeMedicamentos.set(i, novo);
	            return true;
	        }
	    }
	    return false;
	}*/
	
    public boolean atualizarMedicamento(int id, Medicamento dadosNovos) {
        Medicamento medicamentoExistente = getMedicamentoPorId(id);
        if (medicamentoExistente != null) {
            medicamentoExistente.setNome(dadosNovos.getNome());
            medicamentoExistente.setPrincipio_ativo(dadosNovos.getPrincipio_ativo());
            medicamentoExistente.setFabricante(dadosNovos.getFabricante());
            medicamentoExistente.setValidade(dadosNovos.getValidade());
            medicamentoExistente.setLote(dadosNovos.getLote());
            medicamentoExistente.setIndicacao(dadosNovos.getIndicacao());
            medicamentoExistente.setDosagem(dadosNovos.getDosagem());
            medicamentoExistente.setForma(dadosNovos.getForma());
            medicamentoExistente.setPreco(dadosNovos.getPreco());
            medicamentoExistente.setImagem_url(dadosNovos.getImagem_url());
            medicamentoExistente.setCategoria(dadosNovos.getCategoria());
            medicamentoExistente.setDesconto(dadosNovos.getDesconto());
            return true;
        }
        return false;
    }	
	
	public boolean removerMedicamentoPorId(int id) {
	    return this.listaDeMedicamentos.removeIf(m -> m.getId() == id);
	}
	
	public ArrayList<Medicamento> buscarPorNome(String nomeBuscado) {
	    ArrayList<Medicamento> resultados = new ArrayList<>();
	    for (Medicamento m : listaDeMedicamentos) {
	        if (m.getNome().toLowerCase().contains(nomeBuscado.toLowerCase())) {
	            resultados.add(m);
	        }
	    }
	    return resultados;
	}
	
	public ArrayList<Medicamento> buscar(String termo, String categoria) {
	    ArrayList<Medicamento> resultados = new ArrayList<>();
	    
	    Categoria categoriaEnum = null;
	    if (categoria != null && !categoria.isEmpty() && !"TODOS".equalsIgnoreCase(categoria)) {
	        try {
	            categoriaEnum = Categoria.valueOf(categoria);
	        } catch (IllegalArgumentException e) {
	            return resultados;
	        }
	    }

	    for (Medicamento m : listaDeMedicamentos) {
	        boolean nomeCorresponde = m.getNome().toLowerCase().contains(termo.toLowerCase());
	        
	        boolean categoriaCorresponde = (categoriaEnum == null || m.getCategoria() == categoriaEnum);

	        if (nomeCorresponde && categoriaCorresponde) {
	            resultados.add(m);
	        }
	    }
	    return resultados;
	}
	
	public boolean adicionarComentario(int medicamentoId, Comentario comentario) {
        Medicamento medicamento = getMedicamentoPorId(medicamentoId);
        if (medicamento != null) {
            medicamento.adicionarComentario(comentario);
            return true;
        }
        return false;
    }

}