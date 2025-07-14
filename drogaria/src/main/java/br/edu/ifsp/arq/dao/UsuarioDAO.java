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

import br.edu.ifsp.arq.model.Usuario;

public class UsuarioDAO {
    private static UsuarioDAO instance;

    private static final String FILE_PATH; 
    
    static {
        String homeDir = System.getProperty("user.home");
        
        String dataDirPath = homeDir + File.separator + "dados_farmacia_app";
        
        FILE_PATH = dataDirPath + File.separator + "usuarios.json";
        
        File diretorio = new File(dataDirPath);
        if (!diretorio.exists()) {
            diretorio.mkdirs(); 
        }
    }
    
    private Gson gson;

    private UsuarioDAO() {
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

    public static UsuarioDAO getInstance() {
        if (instance == null) {
            instance = new UsuarioDAO();
        }
        return instance;
    }

    private List<Usuario> lerDoArquivo() {
        List<Usuario> listaDeUsuarios = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists() || file.length() == 0) {
            return listaDeUsuarios;
        }

        try (Scanner scanner = new Scanner(file, StandardCharsets.UTF_8.name())) {
            String json = scanner.useDelimiter("\\A").next();
            Type tipoLista = new TypeToken<ArrayList<Usuario>>() {}.getType();
            listaDeUsuarios = gson.fromJson(json, tipoLista);
            if (listaDeUsuarios == null) {
                listaDeUsuarios = new ArrayList<>();
            }
        } catch (FileNotFoundException e) {
            System.err.println("Arquivo não encontrado: " + e.getMessage());
        }
        return listaDeUsuarios;
    }

    private void salvarNoArquivo(List<Usuario> listaDeUsuarios) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(FILE_PATH, StandardCharsets.UTF_8))) {
            String json = gson.toJson(listaDeUsuarios);
            writer.print(json);
        } catch (IOException e) {
            System.err.println("Erro ao salvar no arquivo JSON: " + e.getMessage());
        }
    }
    
    private int getProximoId() {
        List<Usuario> listaDeUsuarios = lerDoArquivo();
        int maxId = 0;
        for (Usuario u : listaDeUsuarios) {
            if (u.getId() > maxId) {
                maxId = u.getId();
            }
        }
        return maxId + 1;
    }
    
    public boolean adicionarUsuario(Usuario u) {
        List<Usuario> listaDeUsuarios = lerDoArquivo();
        
        u.setId(getProximoId());
        
        listaDeUsuarios.add(u);
        salvarNoArquivo(listaDeUsuarios);
        return true;
    }
    
    public List<Usuario> getUsuarios() {
        return lerDoArquivo();
    }

    public Usuario getUsuariosPorId(int id) {
        List<Usuario> listaDeUsuarios = lerDoArquivo();
        for (Usuario u : listaDeUsuarios) {
            if (u.getId() == id) return u;
        }
        return null;
    }

    public boolean atualizarUsuario(int id, Usuario novo) {
        List<Usuario> listaDeUsuarios = lerDoArquivo();
        for (int i = 0; i < listaDeUsuarios.size(); i++) {
            Usuario atual = listaDeUsuarios.get(i);
            if (atual.getId() == id) {
                novo.setId(id);
                listaDeUsuarios.set(i, novo);
                salvarNoArquivo(listaDeUsuarios);
                return true;
            }
        }
        return false;
    }

    public boolean removerUsuarioPorId(int id) {
        List<Usuario> listaDeUsuarios = lerDoArquivo();
        boolean removeu = listaDeUsuarios.removeIf(u -> u.getId() == id);
        if (removeu) {
            salvarNoArquivo(listaDeUsuarios);
        }
        return removeu;
    }

    public boolean emailExiste(String email) {
        List<Usuario> listaDeUsuarios = lerDoArquivo();
        for (Usuario u : listaDeUsuarios) {
            if (u.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }
}