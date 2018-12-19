package it.portaleSTI.DTO;

import java.io.Serializable;

public class PermessoDTO implements Serializable {
	
	int idPermesso;
	String descrizione="";
	String chiave_permesso="";
	int statoPermesso;
	String pagina;
	String sottopagina;
	String percorso;
	
	
	public int getIdPermesso() {
		return idPermesso;
	}
	public void setIdPermesso(int idPermesso) {
		this.idPermesso = idPermesso;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getChiave_permesso() {
		return chiave_permesso;
	}
	public void setChiave_permesso(String chiave_permesso) {
		this.chiave_permesso = chiave_permesso;
	}
	public int getStatoPermesso() {
		return statoPermesso;
	}
	public void setStatoPermesso(int statoPermesso) {
		this.statoPermesso = statoPermesso;
	}
	public String getPagina() {
		return pagina;
	}
	public void setPagina(String pagina) {
		this.pagina = pagina;
	}
	public String getSottopagina() {
		return sottopagina;
	}
	public void setSottopagina(String sottoPagina) {
		this.sottopagina = sottoPagina;
	}
	public String getPercorso() {
		return percorso;
	}
	public void setPercorso(String percorso) {
		this.percorso = percorso;
	}

}
