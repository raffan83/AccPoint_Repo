package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagAllegatoDTO  implements Serializable{
	private int id;
	private MagPaccoDTO  pacco;
	private String allegato;
	

	public String getAllegato() {
		return allegato;
	}
	public void setAllegato(String allegato) {
		this.allegato = allegato;
	}
	public MagPaccoDTO getPacco() {
		return pacco;
	}
	public void setPacco(MagPaccoDTO pacco) {
		this.pacco = pacco;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}



}
