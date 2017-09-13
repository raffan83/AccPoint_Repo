package it.portaleSTI.DTO;

import java.io.Serializable;

public class CampionamentoDatasetDTO implements Serializable {
	
	private int id;
	private TipoCampionamentoDTO tipo_campionamento;
	private String nome_campo;
	private String tipo_campo;	
	private String codice_campo;	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TipoCampionamentoDTO getTipo_campionamento() {
		return tipo_campionamento;
	}
	public void setTipo_campionamento(TipoCampionamentoDTO tipo_campionamento) {
		this.tipo_campionamento = tipo_campionamento;
	}
	public String getNome_campo() {
		return nome_campo;
	}
	public void setNome_campo(String nome_campo) {
		this.nome_campo = nome_campo;
	}
	public String getTipo_campo() {
		return tipo_campo;
	}
	public void setTipo_campo(String tipo_campo) {
		this.tipo_campo = tipo_campo;
	}
	public String getCodice_campo() {
		return codice_campo;
	}
	public void setCodice_campo(String codice_campo) {
		this.codice_campo = codice_campo;
	}
	

	

}
