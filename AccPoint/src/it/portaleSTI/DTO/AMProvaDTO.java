package it.portaleSTI.DTO;

import java.util.Date;

public class AMProvaDTO {

	private int id;
	private AMTipoProvaDTO tipoProva;
	private AMInterventoDTO intervento;
	private Date data;
	private String esito;
	private String note;
	private UtenteDTO utente;
	private String nRapporto;
	private String matrixSpess;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	
	public AMInterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(AMInterventoDTO intervento) {
		this.intervento = intervento;
	}
	public AMTipoProvaDTO getTipoProva() {
		return tipoProva;
	}
	public void setTipoProva(AMTipoProvaDTO tipoProva) {
		this.tipoProva = tipoProva;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public String getnRapporto() {
		return nRapporto;
	}
	public void setnRapporto(String nRapporto) {
		this.nRapporto = nRapporto;
	}
	public String getMatrixSpess() {
		return matrixSpess;
	}
	public void setMatrixSpess(String matrixSpess) {
		this.matrixSpess = matrixSpess;
	}
	
	
}
