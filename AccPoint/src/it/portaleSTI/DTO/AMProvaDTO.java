package it.portaleSTI.DTO;

import java.util.Date;

public class AMProvaDTO {

	private int id;
	private AMTipoProvaDTO tipoProva;
	private AMInterventoDTO intervento;
	private Date data;
	private String esito;
	private String note;
	private AMOperatoreDTO operatore;
	private String nRapporto;
	private String matrixSpess;
	private AMOggettoProvaDTO strumento;
	private AMCampioneDTO campione;
	private String filename_excel;
	private String filename_img;
	
	
	
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
	public AMOggettoProvaDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(AMOggettoProvaDTO strumento) {
		this.strumento = strumento;
	}
	public AMCampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(AMCampioneDTO campione) {
		this.campione = campione;
	}
	public String getFilename_excel() {
		return filename_excel;
	}
	public void setFilename_excel(String filename_excel) {
		this.filename_excel = filename_excel;
	}
	public String getFilename_img() {
		return filename_img;
	}
	public void setFilename_img(String filename_img) {
		this.filename_img = filename_img;
	}
	public AMOperatoreDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(AMOperatoreDTO operatore) {
		this.operatore = operatore;
	}
	
	
}
