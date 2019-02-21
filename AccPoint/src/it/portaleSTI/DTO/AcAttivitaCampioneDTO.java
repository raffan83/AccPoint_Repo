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
	private MisuraDTO taratura;
	private MisuraDTO verifica_interna;
	private String sigla;
	private String campo_sospesi;
	
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
	public MisuraDTO getTaratura() {
		return taratura;
	}
	public void setTaratura(MisuraDTO taratura) {
		this.taratura = taratura;
	}
	public MisuraDTO getVerifica_interna() {
		return verifica_interna;
	}
	public void setVerifica_interna(MisuraDTO verifica_interna) {
		this.verifica_interna = verifica_interna;
	}
	public String getSigla() {
		return sigla;
	}
	public void setSigla(String sigla) {
		this.sigla = sigla;
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
	
}
