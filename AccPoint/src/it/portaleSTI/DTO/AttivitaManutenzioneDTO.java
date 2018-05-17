package it.portaleSTI.DTO;

public class AttivitaManutenzioneDTO {
	private int id;
	private String descrizione;
	private  RegistroEventiDTO evento;
	private String esito;
	
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
	public RegistroEventiDTO getEvento() {
		return evento;
	}
	public void setEvento(RegistroEventiDTO evento) {
		this.evento = evento;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}

}
