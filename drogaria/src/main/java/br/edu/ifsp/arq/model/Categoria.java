package br.edu.ifsp.arq.model;

public enum Categoria {
	ANALGESICO("Analgésico"),
	ANTIBIOTICO("Antibiótico"),
	ANTI_INFLAMATORIO("Anti-inflamatório"),
	ANTITERMICO("Antitérmico"),
	ANTIALERGICO("Antialérgico"),
	ANTIFUNGICO("Antifúngico"),
	ANSIOLITICO("Ansiolítico"),
	ANTIDEPRESSIVO("Antidepressivo"),
	ANTICONCEPCIONAL("Anticoncepcional"),
	ANTIPARASITARIO("Antiparasitário"),
	EXPECTORANTE("Expectorante"),
	ANTITUSSIGENO("Antitussígeno"),
	ANTIACIDO("Antiácido"),
	ANTIESPASMODICO("Antiespasmódico");

    private final String descricao;

    Categoria(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }
}