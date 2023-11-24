package it.portaleSTI.DTO;

import java.util.Date;

public class AMInterventoDTO {
	private int id;
	private AMAttivitaManutenzioneDTO attivita;
	private AMTipoManutenzioneDTO tipoMAnutenzione;
	private Date dataIntervento;
	private String esito;
	private String descrizione_intervento;
	private String operatore;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public AMAttivitaManutenzioneDTO getAttivita() {
		return attivita;
	}
	public void setAttivita(AMAttivitaManutenzioneDTO attivita) {
		this.attivita = attivita;
	}
	public AMTipoManutenzioneDTO getTipoMAnutenzione() {
		return tipoMAnutenzione;
	}
	public void setTipoMAnutenzione(AMTipoManutenzioneDTO tipoMAnutenzione) {
		this.tipoMAnutenzione = tipoMAnutenzione;
	}
	public Date getDataIntervento() {
		return dataIntervento;
	}
	public void setDataIntervento(Date dataIntervento) {
		this.dataIntervento = dataIntervento;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	public String getDescrizione_intervento() {
		return descrizione_intervento;
	}
	public void setDescrizione_intervento(String descrizione_intervento) {
		this.descrizione_intervento = descrizione_intervento;
	}
	public String getOperatore() {
		return operatore;
	}
	public void setOperatore(String operatore) {
		this.operatore = operatore;
	}

	
}
