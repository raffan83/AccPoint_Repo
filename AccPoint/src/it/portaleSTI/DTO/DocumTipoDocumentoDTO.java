package it.portaleSTI.DTO;

public class DocumTipoDocumentoDTO {
	
	private int id;
	private String descrizione;
	private int aggiornabile_cl_default;
	private int disabilitato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	public DocumTipoDocumentoDTO() {
		super();
	}
	
	public DocumTipoDocumentoDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
			
	}
	public int getAggiornabile_cl_default() {
		return aggiornabile_cl_default;
	}
	public void setAggiornabile_cl_default(int aggiornabile_cl_default) {
		this.aggiornabile_cl_default = aggiornabile_cl_default;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}

}
