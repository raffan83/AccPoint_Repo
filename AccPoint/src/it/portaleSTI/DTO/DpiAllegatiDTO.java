package it.portaleSTI.DTO;

import java.util.Date;

public class DpiAllegatiDTO {

	private int id;
	private int id_manuale;
	private int id_dpi;
	private String nome_file;
	private int disabilitato;
	private Date data_caricamento;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_manuale() {
		return id_manuale;
	}
	public void setId_manuale(int id_manuale) {
		this.id_manuale = id_manuale;
	}
	public String getNome_file() {
		return nome_file;
	}
	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public int getId_dpi() {
		return id_dpi;
	}
	public void setId_dpi(int id_dpi) {
		this.id_dpi = id_dpi;
	}
	public Date getData_caricamento() {
		return data_caricamento;
	}
	public void setData_caricamento(Date data_caricamento) {
		this.data_caricamento = data_caricamento;
	}
	
	
	
}
