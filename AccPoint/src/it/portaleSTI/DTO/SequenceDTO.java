package it.portaleSTI.DTO;

import java.io.Serializable;

public class SequenceDTO implements Serializable{
	
	private int seq_sti_campione;
	private int seq_cdt_campione;
	
	public int getSeq_sti_campione() {
		return seq_sti_campione;
	}
	public void setSeq_sti_campione(int seq_sti_campione) {
		this.seq_sti_campione = seq_sti_campione;
	}
	public int getSeq_cdt_campione() {
		return seq_cdt_campione;
	}
	public void setSeq_cdt_campione(int seq_cdt_campione) {
		this.seq_cdt_campione = seq_cdt_campione;
	}
	
	

}
