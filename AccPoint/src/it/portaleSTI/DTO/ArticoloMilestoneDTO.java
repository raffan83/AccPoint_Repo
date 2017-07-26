package it.portaleSTI.DTO;

import java.util.ArrayList;

public class ArticoloMilestoneDTO {

	private String ID_ANAART;
	private String DESCR;
	private ArrayList<AccessorioDTO> listaAccessori = new ArrayList<AccessorioDTO>();
	private ArrayList<DotazioneDTO> listaDotazioni = new ArrayList<DotazioneDTO>();
	
	public String getID_ANAART() {
		return ID_ANAART;
	}
	public void setID_ANAART(String iD_ANAART) {
		ID_ANAART = iD_ANAART;
	}
	public String getDESCR() {
		return DESCR;
	}
	public void setDESCR(String dESCR) {
		DESCR = dESCR;
	}
	public ArrayList<AccessorioDTO> getListaAccessori() {
		return listaAccessori;
	}
	public void setListaAccessori(ArrayList<AccessorioDTO> listaAccessori) {
		this.listaAccessori = listaAccessori;
	}
	public ArrayList<DotazioneDTO> getListaDotazioni() {
		return listaDotazioni;
	}
	public void setListaDotazioni(ArrayList<DotazioneDTO> listaDotazioni) {
		this.listaDotazioni = listaDotazioni;
	}
	
	
	
}
