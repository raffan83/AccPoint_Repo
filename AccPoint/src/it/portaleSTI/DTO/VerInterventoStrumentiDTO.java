package it.portaleSTI.DTO;

import java.io.Serializable;

public class VerInterventoStrumentiDTO implements Serializable{

	private VerStrumentoDTO verStrumento;
	private int id_intervento;
	private String ora_prevista;
	private String via;
	private String civico;
	private ComuneDTO comune;
	private String preventiva;
	
	public VerStrumentoDTO getVerStrumento() {
		return verStrumento;
	}
	public void setVerStrumento(VerStrumentoDTO verStrumento) {
		this.verStrumento = verStrumento;
	}	
//	public VerInterventoDTO getVerIntervento() {
//		return verIntervento;
//	}
//	public void setVerIntervento(VerInterventoDTO verIntervento) {
//		this.verIntervento = verIntervento;
//	}
	public String getOra_prevista() {
		return ora_prevista;
	}
	public void setOra_prevista(String ora_prevista) {
		this.ora_prevista = ora_prevista;
	}
	public int getId_intervento() {
		return id_intervento;
	}
	public void setId_intervento(int id_intervento) {
		this.id_intervento = id_intervento;
	}
	public String getVia() {
		return via;
	}
	public void setVia(String via) {
		this.via = via;
	}
	public String getCivico() {
		return civico;
	}
	public void setCivico(String civico) {
		this.civico = civico;
	}
	public ComuneDTO getComune() {
		return comune;
	}
	public void setComune(ComuneDTO comune) {
		this.comune = comune;
	}
	public String getPreventiva() {
		return preventiva;
	}
	public void setPreventiva(String preventiva) {
		this.preventiva = preventiva;
	}
	
	
	
}
