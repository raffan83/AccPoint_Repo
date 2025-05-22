package it.portaleSTI.DTO;

import java.util.ArrayList;

public class AMReportDTO {

	
	private String indicazione;
	private ArrayList<String> lista_colonne;
	
	
	public AMReportDTO() {
		
		
		
	}


	public String getIndicazione() {
		return indicazione;
	}


	public void setIndicazione(String indicazione) {
		this.indicazione = indicazione;
	}


	public ArrayList<String> getLista_colonne() {
		return lista_colonne;
	}


	public void setLista_colonne(ArrayList<String> lista_colonne) {
		this.lista_colonne = lista_colonne;
	}
	
	

}
