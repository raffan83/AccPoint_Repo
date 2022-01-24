package it.portaleSTI.DTO;

import java.io.Serializable;


public class ConfigurazioneClienteDTO implements Serializable{
	
	private int id_cliente;
	private int id_sede;
	private String nome_cliente;
	private String nome_sede;
	private TipoRapportoDTO tipo_rapporto;
	private int id_firma;
	private String nome_file_logo;
	private String modello_certificato;
	private String revisione_certificato;
	private String modello_lista_strumenti;
	private String revisione_lista_strumenti;
	
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	public int getId_sede() {
		return id_sede;
	}
	public void setId_sede(int id_sede) {
		this.id_sede = id_sede;
	}
	public String getNome_cliente() {
		return nome_cliente;
	}
	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}
	public String getNome_sede() {
		return nome_sede;
	}
	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}
	public TipoRapportoDTO getTipo_rapporto() {
		return tipo_rapporto;
	}
	public void setTipo_rapporto(TipoRapportoDTO tipo_rapporto) {
		this.tipo_rapporto = tipo_rapporto;
	}
	public int getId_firma() {
		return id_firma;
	}
	public void setId_firma(int id_firma) {
		this.id_firma = id_firma;
	}
	public String getNome_file_logo() {
		return nome_file_logo;
	}
	public void setNome_file_logo(String nome_file_logo) {
		this.nome_file_logo = nome_file_logo;
	}

	public String getModello_lista_strumenti() {
		return modello_lista_strumenti;
	}
	public void setModello_lista_strumenti(String modello_lista_strumenti) {
		this.modello_lista_strumenti = modello_lista_strumenti;
	}
	public String getRevisione_lista_strumenti() {
		return revisione_lista_strumenti;
	}
	public void setRevisione_lista_strumenti(String revisione_lista_strumenti) {
		this.revisione_lista_strumenti = revisione_lista_strumenti;
	}
	public String getModello_certificato() {
		return modello_certificato;
	}
	public void setModello_certificato(String modello_certificato) {
		this.modello_certificato = modello_certificato;
	}
	public String getRevisione_certificato() {
		return revisione_certificato;
	}
	public void setRevisione_certificato(String revisione_certificato) {
		this.revisione_certificato = revisione_certificato;
	}

}
