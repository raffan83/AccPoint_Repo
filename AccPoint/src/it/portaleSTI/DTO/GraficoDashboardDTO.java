package it.portaleSTI.DTO;

import java.util.ArrayList;
import java.util.List;

public class GraficoDashboardDTO  implements Cloneable {
	

	private List<Integer> listaCertificatiLAT = new ArrayList<>();
	private List<Integer> listaCertificatiSVT = new ArrayList<>();
	private List<Integer> listaCertificatiRDT = new ArrayList<>();
	private List<Integer> listaCertificatiRDP = new ArrayList<>();
	private List<Integer> listaCertificatiSE = new ArrayList<>();
	private int itemInLavorazione =0;
	private int itemFornitori=0;
	private int itemLavoratiInIngresso=0;
	private int itemLavoratiInSpedizione=0;
	
	
	
	
	public GraficoDashboardDTO() {
		super();
	}


	public GraficoDashboardDTO(List<Integer> listaCertificatiLAT, List<Integer> listaCertificatiSVT,
			List<Integer> listaCertificatiRDT, List<Integer> listaCertificatiRDP, List<Integer> listaCertificatiSE,
			int itemInLavorazione, int itemFornitori, int itemLavoratiInIngresso, int itemLavoratiInSpedizione) {
		super();
		this.listaCertificatiLAT = listaCertificatiLAT;
		this.listaCertificatiSVT = listaCertificatiSVT;
		this.listaCertificatiRDT = listaCertificatiRDT;
		this.listaCertificatiRDP = listaCertificatiRDP;
		this.listaCertificatiSE = listaCertificatiSE;
		this.itemInLavorazione = itemInLavorazione;
		this.itemFornitori = itemFornitori;
		this.itemLavoratiInIngresso = itemLavoratiInIngresso;
		this.itemLavoratiInSpedizione = itemLavoratiInSpedizione;
	}


	public List<Integer> getListaCertificatiLAT() {
		return listaCertificatiLAT;
	}


	public void setListaCertificatiLAT(List<Integer> listaCertificatiLAT) {
		this.listaCertificatiLAT = listaCertificatiLAT;
	}


	public List<Integer> getListaCertificatiSVT() {
		return listaCertificatiSVT;
	}


	public void setListaCertificatiSVT(List<Integer> listaCertificatiSVT) {
		this.listaCertificatiSVT = listaCertificatiSVT;
	}


	public List<Integer> getListaCertificatiRDT() {
		return listaCertificatiRDT;
	}


	public void setListaCertificatiRDT(List<Integer> listaCertificatiRDT) {
		this.listaCertificatiRDT = listaCertificatiRDT;
	}


	public List<Integer> getListaCertificatiRDP() {
		return listaCertificatiRDP;
	}


	public void setListaCertificatiRDP(List<Integer> listaCertificatiRDP) {
		this.listaCertificatiRDP = listaCertificatiRDP;
	}


	public List<Integer> getListaCertificatiSE() {
		return listaCertificatiSE;
	}


	public void setListaCertificatiSE(List<Integer> listaCertificatiSE) {
		this.listaCertificatiSE = listaCertificatiSE;
	}


	public int getItemInLavorazione() {
		return itemInLavorazione;
	}


	public void setItemInLavorazione(int itemInLavorazione) {
		this.itemInLavorazione = itemInLavorazione;
	}


	public int getItemFornitori() {
		return itemFornitori;
	}


	public void setItemFornitori(int itemFornitori) {
		this.itemFornitori = itemFornitori;
	}


	public int getItemLavoratiInIngresso() {
		return itemLavoratiInIngresso;
	}


	public void setItemLavoratiInIngresso(int itemLavoratiInIngresso) {
		this.itemLavoratiInIngresso = itemLavoratiInIngresso;
	}


	public int getItemLavoratiInSpedizione() {
		return itemLavoratiInSpedizione;
	}


	public void setItemLavoratiInSpedizione(int itemLavoratiInSpedizione) {
		this.itemLavoratiInSpedizione = itemLavoratiInSpedizione;
	}
	
	
	
	
}
