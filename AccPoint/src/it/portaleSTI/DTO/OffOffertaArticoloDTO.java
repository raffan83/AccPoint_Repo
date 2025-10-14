package it.portaleSTI.DTO;

public class OffOffertaArticoloDTO {
	
	private int id;
	private OffOffertaDTO offerta;
	private String articolo;
	private Double quantita;
	private Double importo;
	private Double sconto;
	private ArticoloMilestoneDTO articoloObj;

	
	
	public OffOffertaDTO getOfferta() {
		return offerta;
	}



	public void setOfferta(OffOffertaDTO offerta) {
		this.offerta = offerta;
	}



	public String getArticolo() {
		return articolo;
	}



	public void setArticolo(String articolo) {
		this.articolo = articolo;
	}



	public Double getQuantita() {
		return quantita;
	}



	public void setQuantita(Double quantita) {
		this.quantita = quantita;
	}



	public Double getImporto() {
		return importo;
	}



	public void setImporto(Double importo) {
		this.importo = importo;
	}



	public Double getSconto() {
		return sconto;
	}



	public void setSconto(Double sconto) {
		this.sconto = sconto;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public ArticoloMilestoneDTO getArticoloObj() {
		return articoloObj;
	}



	public void setArticoloObj(ArticoloMilestoneDTO articoloObj) {
		this.articoloObj = articoloObj;
	}



	public OffOffertaArticoloDTO() {
		// TODO Auto-generated constructor stub
	}

}
