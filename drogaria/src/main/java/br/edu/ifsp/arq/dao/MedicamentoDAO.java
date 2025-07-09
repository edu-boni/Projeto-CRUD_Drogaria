package br.edu.ifsp.arq.dao;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import br.edu.ifsp.arq.model.Categoria;
import br.edu.ifsp.arq.model.Comentario;
import br.edu.ifsp.arq.model.Medicamento;

public class MedicamentoDAO {
    private static MedicamentoDAO instance;
    
	private static final String FILE_PATH; 
	    
	    static {
	        String homeDir = System.getProperty("user.home");
	        
	        String dataDirPath = homeDir + File.separator + "dados_farmacia_app";
	        
	        FILE_PATH = dataDirPath + File.separator + "medicamentos.json";
	        
	        File diretorio = new File(dataDirPath);
	        if (!diretorio.exists()) {
	            diretorio.mkdirs(); 
	        }
	    }
    
    private Gson gson;

    private MedicamentoDAO() {
    	gson = new GsonBuilder().setPrettyPrinting().create();
        
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.createNewFile();
            }
        } catch (IOException e) {
            System.err.println("Erro Crítico ao criar arquivo JSON: " + e.getMessage());
        }
    }

    public static MedicamentoDAO getInstance() {
        if (instance == null) {
            instance = new MedicamentoDAO();
        }
        return instance;
    }

    private List<Medicamento> lerDoArquivo() {
        List<Medicamento> listaDeMedicamentos = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists() || file.length() == 0) {
            return listaDeMedicamentos;
        }

        try (Scanner scanner = new Scanner(file, StandardCharsets.UTF_8.name())) {
            String json = scanner.useDelimiter("\\A").next();
            Type tipoLista = new TypeToken<ArrayList<Medicamento>>() {}.getType();
            listaDeMedicamentos = gson.fromJson(json, tipoLista);
            
            if (listaDeMedicamentos == null) {
                listaDeMedicamentos = new ArrayList<>();
            }
            
        } catch (FileNotFoundException e) {
             System.err.println("Arquivo não encontrado: " + e.getMessage());
        }
        return listaDeMedicamentos;
    }

    private void salvarNoArquivo(List<Medicamento> listaDeMedicamentos) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(FILE_PATH, StandardCharsets.UTF_8))) {
            String json = gson.toJson(listaDeMedicamentos);
            writer.print(json);
        } catch (IOException e) {
            System.err.println("Erro ao salvar no arquivo JSON: " + e.getMessage());
        }
    }
    
    private int getProximoId() {
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        int maxId = 0;
        for (Medicamento m : listaDeMedicamentos) {
            if (m.getId() > maxId) {
                maxId = m.getId();
            }
        }
        return maxId + 1;
    }
    
    public boolean adicionarMedicamento(Medicamento m) {
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        
        m.setId(getProximoId());
        
        listaDeMedicamentos.add(m);
        salvarNoArquivo(listaDeMedicamentos);
        return true;
    }

    public List<Medicamento> getMedicamentos() {
        return lerDoArquivo();
    }

    public Medicamento getMedicamentoPorId(int id) {
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        for (Medicamento m : listaDeMedicamentos) {
            if (m.getId() == id) return m;
        }
        return null;
    }

    public boolean atualizarMedicamento(int id, Medicamento dadosNovos) {
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        for (int i = 0; i < listaDeMedicamentos.size(); i++) {
            Medicamento atual = listaDeMedicamentos.get(i);
            if (atual.getId() == id) {
                atual.setNome(dadosNovos.getNome());
                atual.setPrincipio_ativo(dadosNovos.getPrincipio_ativo());
                atual.setFabricante(dadosNovos.getFabricante());
                atual.setValidade(dadosNovos.getValidade());
                atual.setLote(dadosNovos.getLote());
                atual.setIndicacao(dadosNovos.getIndicacao());
                atual.setDosagem(dadosNovos.getDosagem());
                atual.setForma(dadosNovos.getForma());
                atual.setPreco(dadosNovos.getPreco());
                atual.setImagem_url(dadosNovos.getImagem_url());
                atual.setCategoria(dadosNovos.getCategoria());
                atual.setDesconto(dadosNovos.getDesconto());

                salvarNoArquivo(listaDeMedicamentos); 
                return true;
            }
        }
        return false;
    }

    public boolean removerMedicamentoPorId(int id) {
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        boolean removeu = listaDeMedicamentos.removeIf(m -> m.getId() == id);
        if (removeu) {
            salvarNoArquivo(listaDeMedicamentos);
        }
        return removeu;
    }
    
    public boolean adicionarComentario(int medicamentoId, Comentario comentario) {
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        Medicamento medicamento = null;
        for(Medicamento m : listaDeMedicamentos) {
            if(m.getId() == medicamentoId) {
                medicamento = m;
                break;
            }
        }
        
        if (medicamento != null) {
            medicamento.adicionarComentario(comentario);
            salvarNoArquivo(listaDeMedicamentos);
            return true;
        }
        return false;
    }
    
    public List<Medicamento> buscarPorNome(String nomeBuscado) {
        List<Medicamento> resultados = new ArrayList<>();
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        for (Medicamento m : listaDeMedicamentos) {
            if (m.getNome().toLowerCase().contains(nomeBuscado.toLowerCase())) {
                resultados.add(m);
            }
        }
        return resultados;
    }
    
    public List<Medicamento> buscar(String termo, String categoria) {
        List<Medicamento> resultados = new ArrayList<>();
        List<Medicamento> listaDeMedicamentos = lerDoArquivo();
        
        Categoria categoriaEnum = null;
        if (categoria != null && !categoria.isEmpty() && !"TODOS".equalsIgnoreCase(categoria)) {
            try {
                categoriaEnum = Categoria.valueOf(categoria);
            } catch (IllegalArgumentException e) {
                return resultados;
            }
        }

        for (Medicamento m : listaDeMedicamentos) {
            boolean nomeCorresponde = termo == null || termo.isEmpty() || m.getNome().toLowerCase().contains(termo.toLowerCase());
            boolean categoriaCorresponde = (categoriaEnum == null || m.getCategoria() == categoriaEnum);

            if (nomeCorresponde && categoriaCorresponde) {
                resultados.add(m);
            }
        }
        return resultados;
    }
}