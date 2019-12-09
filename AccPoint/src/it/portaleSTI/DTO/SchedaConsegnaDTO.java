package it.portaleSTI.DTO;

public class SchedaConsegnaDTO {
	
	private int id;
	private InterventoDTO intervento;
	private String nome_file;
	private String data_caricamento;
	private int abilitato;
	private int stato; 
	private VerInterventoDTO ver_intervento;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome_file() {
		return nome_file;
	}
	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}
//	public int getId_intervento() {
//		return id_intervento;
//	}
//	public void setId_intervento(int id_intervento) {
//		this.id_intervento = id_intervento;
//	}
	public String getData_caricamento() {
		return data_caricamento;
	}
	public void setData_caricamento(String data_caricamento) {
		this.data_caricamento = data_caricamento;
	}
	public int getAbilitato() {
		return abilitato;
	}
	public void setAbilitato(int abilitato) {
		this.abilitato = abilitato;
	}
	public int getStato() {
		return stato;
	}
	public void setStato(int stato) {
		this.stato = stato;
	}
	public InterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}
	public VerInterventoDTO getVer_intervento() {
		return ver_intervento;
	}
	public void setVer_intervento(VerInterventoDTO ver_intervento) {
		this.ver_intervento = ver_intervento;
	}
	
	
	

}
