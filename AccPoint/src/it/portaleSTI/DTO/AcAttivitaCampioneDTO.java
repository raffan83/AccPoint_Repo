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
	private UtenteDTO operatore;
	private String campo_sospesi;
	private String allegato;
	private String obsoleta;
	private int disabilitata;
	private int pianificata;
	private String numero_certificato;
	
	public String getCampo_sospesi() {
		return campo_sospesi;
	}
	public void setCampo_sospesi(String campo_sospesi) {
		this.campo_sospesi = campo_sospesi;
	}
	public String getEnte() {
		return ente;
	}
	public void setEnte(String ente) {
		this.ente = ente;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public String getEtichettatura() {
		return etichettatura;
	}
	public void setEtichettatura(String etichettatura) {
		this.etichettatura = etichettatura;
	}
	public String getStato() {
		return stato;
	}
	public void setStato(String stato) {
		this.stato = stato;
	}
	public CertificatoDTO getCertificato() {
		return certificato;
	}
	public void setCertificato(CertificatoDTO certificato) {
		this.certificato = certificato;
	}
	public UtenteDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(UtenteDTO operatore) {
		this.operatore = operatore;
	}
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
	public String getAllegato() {
		return allegato;
	}
	public void setAllegato(String allegato) {
		this.allegato = allegato;
	}
	public String getObsoleta() {
		return obsoleta;
	}
	public void setObsoleta(String obsoleta) {
		this.obsoleta = obsoleta;
	}
	public int getDisabilitata() {
		return disabilitata;
	}
	public void setDisabilitata(int disabilitata) {
		this.disabilitata = disabilitata;
	}
	public int getPianificata() {
		return pianificata;
	}
	public void setPianificata(int pianificata) {
		this.pianificata = pianificata;
	}
	public String getNumero_certificato() {
		return numero_certificato;
	}
	public void setNumero_certificato(String numero_certificato) {
		this.numero_certificato = numero_certificato;
	}
	
}
