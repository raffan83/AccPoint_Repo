package it.portaleSTI.DTO;

public class AttivitaManutenzioneDTO {
	private int id;
	//private TipoAttivitaManutenzioneDTO tipo_attivita;
	private  RegistroEventiDTO evento;
	private String esito;
	private String descrizione;
	
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
//	public TipoAttivitaManutenzioneDTO getTipo_attivita() {
//		return tipo_attivita;
//	}
//	public void setTipo_attivita(TipoAttivitaManutenzioneDTO tipo_attivita) {
//		this.tipo_attivita = tipo_attivita;
//	}
	

}
