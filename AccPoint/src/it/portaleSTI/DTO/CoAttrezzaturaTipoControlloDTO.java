package it.portaleSTI.DTO;

import java.io.Serializable;

public class CoAttrezzaturaTipoControlloDTO implements Serializable{
	
	private CoAttrezzaturaDTO attrezzatura;
	private CoTipoControlloDTO tipo_controllo;
	private String esito;
	public CoAttrezzaturaDTO getAttrezzatura() {
		return attrezzatura;
	}
	public void setAttrezzatura(CoAttrezzaturaDTO attrezzatura) {
		this.attrezzatura = attrezzatura;
	}
	public CoTipoControlloDTO getTipo_controllo() {
		return tipo_controllo;
	}
	public void setTipo_controllo(CoTipoControlloDTO tipo_controllo) {
		this.tipo_controllo = tipo_controllo;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	
	

}
