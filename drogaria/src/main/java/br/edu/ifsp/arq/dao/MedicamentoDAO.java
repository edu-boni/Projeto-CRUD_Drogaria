package br.edu.ifsp.arq.dao;

import java.util.ArrayList;
import br.edu.ifsp.arq.model.Medicamento;

public class MedicamentoDAO {
	private static MedicamentoDAO instance;
	private ArrayList<Medicamento> listaDeMedicamentos;
	
	public MedicamentoDAO() {
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
}