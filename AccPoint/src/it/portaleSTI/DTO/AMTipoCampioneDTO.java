package it.portaleSTI.DTO;

public class AMTipoCampioneDTO {
	
	private int id;
	private String denominazione;
	private String visibilitaColonne;
	
	

	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getDenominazione() {
		return denominazione;
	}



	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}






	public String getVisibilitaColonne() {
		return visibilitaColonne;
	}



	public void setVisibilitaColonne(String visibilitaColonne) {
		this.visibilitaColonne = visibilitaColonne;
	}



	public AMTipoCampioneDTO() {
		// TODO Auto-generated constructor stub
	}

	public AMTipoCampioneDTO(int id, String denominazione, String visibilitaColonne) {
		this.id = id;
		this.denominazione = denominazione;
		this.visibilitaColonne = visibilitaColonne;
	}
}
