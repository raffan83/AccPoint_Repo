package it.portaleSTI.DTO;

public class ForCorsoCatDTO {
	
	private int id;
	private String codice;
	private String descrizione;
	private int frequenza;
	
	
	
	public ForCorsoCatDTO(int id) {
		this.id = id;
		
	}
	
	public ForCorsoCatDTO() {
		super();
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodice() {
		return codice;
	}
	public void setCodice(String codice) {
		this.codice = codice;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public int getFrequenza() {
		return frequenza;
	}
	public void setFrequenza(int frequenza) {
		this.frequenza = frequenza;
	}

	
}
