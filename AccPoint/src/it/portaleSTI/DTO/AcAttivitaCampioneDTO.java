package it.portaleSTI.DTO;

import java.util.Date;

public class AcAttivitaCampioneDTO {

	private int id;
	private Date data;
	private CampioneDTO campione;
	private AcTipoAttivitaCampioniDTO tipo_attivita;
	private String descrizione_attivita;
	private int tipo_manutenzione;
	private String ente;
	private Date data_scadenza;
	private String etichettatura;
	private String stato;
	private CertificatoDTO certificato;
	private String sigla;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public CampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(CampioneDTO campione) {
		this.campione = campione;
	}
	public AcTipoAttivitaCampioniDTO getTipo_attivita() {
		return tipo_attivita;
	}
	public void setTipo_attivita(AcTipoAttivitaCampioniDTO tipo_attivita) {
		this.tipo_attivita = tipo_attivita;
	}
	public String getDescrizione_attivita() {
		return descrizione_attivita;
	}
	public void setDescrizione_attivita(String descrizione_attivita) {
		this.descrizione_attivita = descrizione_attivita;
	}
	public int getTipo_manutenzione() {
		return tipo_manutenzione;
	}
	public void setTipo_manutenzione(int tipo_manutenzione) {
		this.tipo_manutenzione = tipo_manutenzione;
	}
	
}
