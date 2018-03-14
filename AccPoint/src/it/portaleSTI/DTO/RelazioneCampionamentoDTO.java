package it.portaleSTI.DTO;

public class RelazioneCampionamentoDTO {

	private int id;
	private int id_matrice;
	private int id_tipologia_campionamento;
	private String nomeRelazione;
	private String procedura;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_matrice() {
		return id_matrice;
	}
	public void setId_matrice(int id_matrice) {
		this.id_matrice = id_matrice;
	}
	public int getId_tipologia_campionamento() {
		return id_tipologia_campionamento;
	}
	public void setId_tipologia_campionamento(int id_tipologia_campionamento) {
		this.id_tipologia_campionamento = id_tipologia_campionamento;
	}
	public String getNomeRelazione() {
		return nomeRelazione;
	}
	public void setNomeRelazione(String nomeRelazione) {
		this.nomeRelazione = nomeRelazione;
	}
	public String getProcedura() {
		return procedura;
	}
	public void setProcedura(String procedura) {
		this.procedura = procedura;
	}
	
	
}
