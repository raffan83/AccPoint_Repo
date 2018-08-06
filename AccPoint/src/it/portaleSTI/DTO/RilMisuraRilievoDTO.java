package it.portaleSTI.DTO;

import java.util.Date;

public class RilMisuraRilievoDTO {
	
	private int id;
	private Date data_rilievo;
	private int id_cliente_util;
	private int id_sede_util;
	private String nome_cliente_util;
	private String nome_sede_util;
	private int n_quote;
	private String commessa;
	private RilPezzoDTO pezzo;
	private UtenteDTO utente;
	private RilTipoRilievoDTO tipo_rilievo;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getData_rilievo() {
		return data_rilievo;
	}
	public void setData_rilievo(Date data_rilievo) {
		this.data_rilievo = data_rilievo;
	}
	public int getId_cliente_util() {
		return id_cliente_util;
	}
	public void setId_cliente_util(int id_cliente_util) {
		this.id_cliente_util = id_cliente_util;
	}
	public int getId_sede_util() {
		return id_sede_util;
	}
	public void setId_sede_util(int id_sede_util) {
		this.id_sede_util = id_sede_util;
	}
	public int getN_quote() {
		return n_quote;
	}
	public void setN_quote(int n_quote) {
		this.n_quote = n_quote;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public RilPezzoDTO getPezzo() {
		return pezzo;
	}
	public void setPezzo(RilPezzoDTO pezzo) {
		this.pezzo = pezzo;
	}
	public RilTipoRilievoDTO getTipo_rilievo() {
		return tipo_rilievo;
	}
	public void setTipo_rilievo(RilTipoRilievoDTO tipo_rilievo) {
		this.tipo_rilievo = tipo_rilievo;
	}
	public String getNome_cliente_util() {
		return nome_cliente_util;
	}
	public void setNome_cliente_util(String nome_cliente_util) {
		this.nome_cliente_util = nome_cliente_util;
	}
	public String getNome_sede_util() {
		return nome_sede_util;
	}
	public void setNome_sede_util(String nome_sede_util) {
		this.nome_sede_util = nome_sede_util;
	}

}
