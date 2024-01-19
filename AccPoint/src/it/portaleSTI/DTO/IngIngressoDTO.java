package it.portaleSTI.DTO;

import java.util.Date;

public class IngIngressoDTO {

	private Integer id; 
	private String nominativo;
	private String targa;
	private Integer tipo_merce;
	private Integer tipo_registrazione;
	private String nome_ditta;
	private Date data_ingresso;
	private Date data_uscita;
	private Integer id_reparto;
	private Integer modalita_ingresso;
	private String telefono;
	private Integer id_area;
	public Integer getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNominativo() {
		return nominativo;
	}
	public void setNominativo(String nominativo) {
		this.nominativo = nominativo;
	}
	public String getTarga() {
		return targa;
	}
	public void setTarga(String targa) {
		this.targa = targa;
	}
	public Integer getTipo_merce() {
		return tipo_merce;
	}
	public void setTipo_merce(Integer tipo_merce) {
		this.tipo_merce = tipo_merce;
	}
	public Integer getTipo_registrazione() {
		return tipo_registrazione;
	}
	public void setTipo_registrazione(Integer tipo_registrazione) {
		this.tipo_registrazione = tipo_registrazione;
	}
	public String getNome_ditta() {
		return nome_ditta;
	}
	public void setNome_ditta(String nome_ditta) {
		this.nome_ditta = nome_ditta;
	}
	public Date getData_ingresso() {
		return data_ingresso;
	}
	public void setData_ingresso(Date data_ingresso) {
		this.data_ingresso = data_ingresso;
	}
	public Date getData_uscita() {
		return data_uscita;
	}
	public void setData_uscita(Date data_uscita) {
		this.data_uscita = data_uscita;
	}
	public Integer getId_reparto() {
		return id_reparto;
	}
	public void setId_reparto(Integer id_reparto) {
		this.id_reparto = id_reparto;
	}
	public Integer getModalita_ingresso() {
		return modalita_ingresso;
	}
	public void setModalita_ingresso(Integer modalita_ingresso) {
		this.modalita_ingresso = modalita_ingresso;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public Integer getId_area() {
		return id_area;
	}
	public void setId_area(Integer id_area) {
		this.id_area = id_area;
	}
	
	
}
