package it.portaleSTI.DTO;

import java.util.Date;

public class PRRequisitoRisorsaDTO {
	
	private int id;
	private Integer risorsa;
	private PRRequisitoDocumentaleDTO req_documentale;
	private PRRequisitoSanitarioDTO req_sanitario;
	private int stato;
	private Date req_san_data_inizio;
	private Date req_san_data_fine;
	
	

	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public Integer getRisorsa() {
		return risorsa;
	}



	public void setRisorsa(Integer risorsa) {
		this.risorsa = risorsa;
	}



	public PRRequisitoDocumentaleDTO getReq_documentale() {
		return req_documentale;
	}



	public void setReq_documentale(PRRequisitoDocumentaleDTO req_documentale) {
		this.req_documentale = req_documentale;
	}



	public PRRequisitoSanitarioDTO getReq_sanitario() {
		return req_sanitario;
	}



	public void setReq_sanitario(PRRequisitoSanitarioDTO req_sanitario) {
		this.req_sanitario = req_sanitario;
	}



	public int getStato() {
		return stato;
	}



	public void setStato(int stato) {
		this.stato = stato;
	}



	public Date getReq_san_data_inizio() {
		return req_san_data_inizio;
	}



	public void setReq_san_data_inizio(Date req_san_data_inizio) {
		this.req_san_data_inizio = req_san_data_inizio;
	}



	public Date getReq_san_data_fine() {
		return req_san_data_fine;
	}



	public void setReq_san_data_fine(Date req_san_data_fine) {
		this.req_san_data_fine = req_san_data_fine;
	}



	public PRRequisitoRisorsaDTO() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String toString() {
	    return "PRRequisitoRisorsaDTO{" +
	            "id=" + id +
	            ", risorsa=" + risorsa +
	            ", req_documentale=" + (req_documentale != null ? req_documentale.toString() : "null") +
	            ", req_sanitario=" + (req_sanitario != null ? req_sanitario.toString() : "null") +
	            ", stato=" + stato +
	            ", req_san_data_inizio=" + (req_san_data_inizio != null ? req_san_data_inizio.toString() : "null") +
	            ", req_san_data_fine=" + (req_san_data_fine != null ? req_san_data_fine.toString() : "null") +
	            '}';
	}

}
