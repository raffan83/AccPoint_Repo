package it.portaleSTI.DTO;

public class RilPuntoDTO {
	
	private int id;
	private RilMisuraRilievoDTO misura_rilievo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public RilMisuraRilievoDTO getMisura_rilievo() {
		return misura_rilievo;
	}
	public void setMisura_rilievo(RilMisuraRilievoDTO misura_rilievo) {
		this.misura_rilievo = misura_rilievo;
	}

}
