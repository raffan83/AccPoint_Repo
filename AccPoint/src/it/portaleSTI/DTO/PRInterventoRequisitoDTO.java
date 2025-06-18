package it.portaleSTI.DTO;

public class PRInterventoRequisitoDTO {

	private int id;
	private Integer id_intervento;
	private PRRequisitoDocumentaleDTO requisito_documentale;
	private PRRequisitoSanitarioDTO requisito_sanitario;
	
	
	
	
	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public Integer getId_intervento() {
		return id_intervento;
	}




	public void setId_intervento(Integer id_intervento) {
		this.id_intervento = id_intervento;
	}







	public PRRequisitoDocumentaleDTO getRequisito_documentale() {
		return requisito_documentale;
	}




	public void setRequisito_documentale(PRRequisitoDocumentaleDTO requisito_documentale) {
		this.requisito_documentale = requisito_documentale;
	}




	public PRRequisitoSanitarioDTO getRequisito_sanitario() {
		return requisito_sanitario;
	}




	public void setRequisito_sanitario(PRRequisitoSanitarioDTO requisito_sanitario) {
		this.requisito_sanitario = requisito_sanitario;
	}




	public PRInterventoRequisitoDTO() {
		// TODO Auto-generated constructor stub
	}

}
