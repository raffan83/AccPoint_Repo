package it.portaleSTI.DTO;

import java.util.ArrayList;
import java.util.Iterator;

public class ArticoloMilestoneDTO {

	private String ID_ANAART="";
	private String DESCR="";
	private Double importo;
	private ArrayList<AccessorioDTO> listaAccessori = new ArrayList<AccessorioDTO>();
	private ArrayList<TipologiaDotazioniDTO> listaDotazioni = new ArrayList<TipologiaDotazioniDTO>();
	
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
	public ArrayList<TipologiaDotazioniDTO> getListaDotazioni() {
		return listaDotazioni;
	}
	public void setListaDotazioni(ArrayList<TipologiaDotazioniDTO> listaDotazioni) {
		this.listaDotazioni = listaDotazioni;
	}
	
	
	
	public Double getImporto() {
		return importo;
	}
	public void setImporto(Double importo) {
		this.importo = importo;
	}
	public int checkAccessorio(String accessorio_id)
	{

	      
		   for (AccessorioDTO accessorio : listaAccessori) {
	  			
			if(accessorio_id.equals(""+accessorio.getId()))
			{
				return accessorio.getQuantitaNecessaria();
			}
		   }
		   
		return 0;
	}
	public boolean checkTipoDotazione(String tipologia_dotazione_id)
	{
		  for (TipologiaDotazioniDTO tipologia : listaDotazioni) {
	  			
				if(tipologia_dotazione_id.equals(""+tipologia.getId()))
				{
					return true;
				}
			   }
			   
			return false;
	}
	
	
}
