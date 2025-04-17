package it.portaleSTI.DTO;

public class AM_CertificatoWrapper {
	
	
	
	public AM_CertificatoWrapper(AMCampioneDTO campione, AMOggettoProvaDTO strumento) {
		super();
		this.campione = campione;
		this.strumento = strumento;
	}
	
	public AMCampioneDTO campione;
	public AMOggettoProvaDTO strumento;
	
	
	public AMCampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(AMCampioneDTO campione) {
		this.campione = campione;
	}
	public AMOggettoProvaDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(AMOggettoProvaDTO strumento) {
		this.strumento = strumento;
	}
	
	
}
