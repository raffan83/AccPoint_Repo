package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;


public class CampioneDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private int id;

	private String codice;

	private String costruttore;
   
	private Date dataScadenza;

	private Date dataVerifica;

	private String descrizione;

	private String filenameCertificato;

	private int freqTaraturaMesi;

	private CompanyDTO company;
	
	private CompanyDTO company_utilizzatore;
	
	private int interpolazionePermessa;

	private String matricola;

	private String modello;

	private String nome;

	private String numeroCertificato;

	private String statoCampione;

	private String tipo_Verifica;

	private String utilizzatore;

	private Date dataInizioPrenotazione;
	
	private Date dataFinePrenotazione;
	
	private TipoCampioneDTO tipo_campione;
	
	private String tipoCampione;
	
	private String statoPrenotazione;
	
	private String note;
	
	public CampioneDTO() 
    {
    }

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCodice() {
		return this.codice;
	}

	public void setCodice(String codice) {
		this.codice = codice;
	}

	public String getCostruttore() {
		return this.costruttore;
	}

	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}

	public Date getDataScadenza() {
		return this.dataScadenza;
	}

	public void setDataScadenza(Date dataScadenza) {
		this.dataScadenza = dataScadenza;
	}

	public Date getDataVerifica() {
		return this.dataVerifica;
	}

	public void setDataVerifica(Date dataVerifica) {
		this.dataVerifica = dataVerifica;
	}

	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getFilenameCertificato() {
		return this.filenameCertificato;
	}

	public void setFilenameCertificato(String filenameCertificato) {
		this.filenameCertificato = filenameCertificato;
	}

	public int getFreqTaraturaMesi() {
		return this.freqTaraturaMesi;
	}

	public void setFreqTaraturaMesi(int freqTaraturaMesi) {
		this.freqTaraturaMesi = freqTaraturaMesi;
	}



	public int getInterpolazionePermessa() {
		return this.interpolazionePermessa;
	}

	public void setInterpolazionePermessa(int interpolazionePermessa) {
		this.interpolazionePermessa = interpolazionePermessa;
	}

	public String getMatricola() {
		return this.matricola;
	}

	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}

	public CompanyDTO getCompany_utilizzatore() {
		return company_utilizzatore;
	}

	public void setCompany_utilizzatore(CompanyDTO company_utilizzatore) {
		this.company_utilizzatore = company_utilizzatore;
	}
	
	public String getModello() {
		return this.modello;
	}

	public void setModello(String modello) {
		this.modello = modello;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getNumeroCertificato() {
		return this.numeroCertificato;
	}

	public void setNumeroCertificato(String numeroCertificato) {
		this.numeroCertificato = numeroCertificato;
	}

	public String getStatoCampione() {
		return this.statoCampione;
	}

	public void setStatoCampione(String statoCampione) {
		this.statoCampione = statoCampione;
	}

	public String getTipo_Verifica() {
		return this.tipo_Verifica;
	}

	public void setTipo_Verifica(String tipo_Verifica) {
		this.tipo_Verifica = tipo_Verifica;
	}


	public Date getDataInizioPrenotazione() {
		return dataInizioPrenotazione;
	}

	public void setDataInizioPrenotazione(Date dataInizioPrenotazione) {
		this.dataInizioPrenotazione = dataInizioPrenotazione;
	}

	public Date getDataFinePrenotazione() {
		return dataFinePrenotazione;
	}

	public void setDataFinePrenotazione(Date dataFinePrenotazione) {
		this.dataFinePrenotazione = dataFinePrenotazione;
	}

	public String getUtilizzatore() {
		return utilizzatore;
	}

	public void setUtilizzatore(String utilizzatore) {
		this.utilizzatore = utilizzatore;
	}


	public CompanyDTO getCompany() {
		return company;
	}

	public void setCompany(CompanyDTO company) {
		this.company = company;
	}

	public TipoCampioneDTO getTipo_campione() {
		return tipo_campione;
	}

	public void setTipo_campione(TipoCampioneDTO tipo_campione) {
		this.tipo_campione = tipo_campione;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getTipoCampione() {
		return tipoCampione;
	}

	public void setTipoCampione(String tipoCampione) {
		this.tipoCampione = tipoCampione;
	}

	public String getStatoPrenotazione() {
		return statoPrenotazione;
	}

	public void setStatoPrenotazione(String statoPrenotazione) {
		this.statoPrenotazione = statoPrenotazione;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}