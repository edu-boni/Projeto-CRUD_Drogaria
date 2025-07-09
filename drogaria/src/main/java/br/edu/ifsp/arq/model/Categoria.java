package br.edu.ifsp.arq.model;

public enum Categoria {
    ANALGESICO("Analgésico"),
    ANESTESICO("Anestésico"),
    ANTIACIDO("Antiácido"),
    ANTIAGREGANTE("Antiagregante plaquetário"),
    ANTIALERGICO("Antialérgico"),
    ANTIBIOTICO("Antibiótico"),
    ANTICONCEPCIONAL("Anticoncepcional"),
    ANTICONVULSIVANTE("Anticonvulsivante"),
    ANTIDEPRESSIVO("Antidepressivo"),
    ANTIDIABETICO("Antidiabético"),
    ANTIDIARREICO("Antidiarreico"),
    ANTIEMETICO("Antiemético"),
    ANTIESPASMODICO("Antiespasmódico"),
    ANTIFUNGICO("Antifúngico"),
    ANTIGLAUCOMATOSO("Antiglaucomatoso"),
    ANTIHIPERTENSOR("Antihipertensor"),
    ANTIINFLAMATORIO("Anti-inflamatório"),
    ANTIMALARICO("Antimalárico"),
    ANTIPARASITARIO("Antiparasitário"),
    ANTIPSICOTICO("Antipsicótico"),
    ANTIREFLUXO("Antirrefluxo"),
    ANTITERMICO("Antitérmico"),
    ANTITUSSIGENO("Antitussígeno"),
    ANSIOLITICO("Ansiolítico"),
    BRONCODILATADOR("Broncodilatador"),
    CORTICOIDE("Corticoide"),
    EXPECTORANTE("Expectorante"),
    HIPERTENSOR("Hipertensor"),
    HIPOLIPEMIANTE("Hipolipemiante"),
    HORMONAL("Hormonal"),
    LAXANTE("Laxante"),
    MINERAL("Mineral"),
    MUCOLITICO("Mucolítico"),
    PROBIOTICO("Probiótico"),
    VASOCONSTRITOR("Vasoconstritor"),
    VASODILATADOR("Vasodilatador"),
    VITAMINA("Vitamina");

    private final String descricao;

    Categoria(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }
}
