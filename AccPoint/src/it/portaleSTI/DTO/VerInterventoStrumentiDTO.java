package it.portaleSTI.DTO;

import java.io.Serializable;

public class VerInterventoStrumentiDTO implements Serializable{

	private VerStrumentoDTO verStrumento;
	private VerInterventoDTO verIntervento;
	private String ora_prevista;
	
	public VerStrumentoDTO getVerStrumento() {
		return verStrumento;
	}
	public void setVerStrumento(VerStrumentoDTO verStrumento) {
		this.verStrumento = verStrumento;
	}	
	public VerInterventoDTO getVerIntervento() {
		return verIntervento;
	}
	public void setVerIntervento(VerInterventoDTO verIntervento) {
		this.verIntervento = verIntervento;
	}
	public String getOra_prevista() {
		return ora_prevista;
	}
	public void setOra_prevista(String ora_prevista) {
		this.ora_prevista = ora_prevista;
	}
	
	
	
}
