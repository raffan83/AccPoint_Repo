package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;


public class CampioneDTO implements Serializable {
	

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3058672505028475488L;

	private int id=0;

	private String codice="";

	private String costruttore="";
   
	private Date dataScadenza;

	private Date dataVerifica;

	private String descrizione="";

	private String filenameCertificato="";

	private int freqTaraturaMesi=0;

	private CompanyDTO company;
	
	private CompanyDTO company_utilizzatore;
	
	private int interpolazionePermessa=0;

	private String matricola="";

	private String modello="";

	private String nome="";

	private String numeroCertificato="";

	private String statoCampione="";

	private String tipo_Verifica="";

	private String utilizzatore="";

	private Date dataInizioPrenotazione;
	
	private Date dataFinePrenotazione;
	
	private TipoCampioneDTO tipo_campione;
	
	private String note="";
	
	private String prenotabile;
	

	public  Set<CertificatoCampioneDTO> listaCertificatiCampione = new HashSet<CertificatoCampioneDTO>(0);
	
//	private Set<DocumentoCampioneDTO> listaDocumentiEsterni = new HashSet<DocumentoCampioneDTO>(0);
	

	private String distributore;
	private Date data_acquisto;
	private String campo_accettabilita;
	private String attivita_di_taratura;
	
	
	private String ubicazione;
	private String unita_formato;
	private int frequenza_manutenzione;
	private int frequenza_verifica_intermedia;
	private String campo_misura;
	private String note_attivita;
	private Integer id_strumento;
	private String descrizione_manutenzione;
	private String descrizione_verifica_intermedia;
	private int settore;
	private Date data_messa_in_servizio;
	private int campione_verificazione;
	private String numeroCertificatoPunto;
	private Date dataScadenzaManutenzione;

	private Date dataManutenzione;
	private Date dataScadenzaVerificaIntermedia;

	private Date dataVerificaIntermedia;
	
	
	public Integer getId_strumento() {
		return id_strumento;
	}

	public void setId_strumento(Integer id_strumento) {
		this.id_strumento = id_strumento;
	}

	public String getUbicazione() {
		return ubicazione;
	}

	public void setUbicazione(String ubicazione) {
		this.ubicazione = ubicazione;
	}

	public String getUnita_formato() {
		return unita_formato;
	}

	public void setUnita_formato(String unita_formato) {
		this.unita_formato = unita_formato;
	}

	public int getFrequenza_manutenzione() {
		return frequenza_manutenzione;
	}

	public void setFrequenza_manutenzione(int frequenza_manutenzione) {
		this.frequenza_manutenzione = frequenza_manutenzione;
	}

	public int getFrequenza_verifica_intermedia() {
		return frequenza_verifica_intermedia;
	}

	public void setFrequenza_verifica_intermedia(int frequenza_verifica_intermedia) {
		this.frequenza_verifica_intermedia = frequenza_verifica_intermedia;
	}

	public String getCampo_misura() {
		return campo_misura;
	}

	public void setCampo_misura(String campo_misura) {
		this.campo_misura = campo_misura;
	}

	public Set<CertificatoCampioneDTO> getListaCertificatiCampione() {
		return listaCertificatiCampione;
	}

	public void setListaCertificatiCampione(
			Set<CertificatoCampioneDTO> listaCertificatiCampione) {
		this.listaCertificatiCampione = listaCertificatiCampione;
	}

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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public static  CertificatoCampioneDTO getCertificatoCorrente(Set<CertificatoCampioneDTO> listaCertificatiCampione)
	{
		CertificatoCampioneDTO certificato=null;
		
		 Iterator iterator = listaCertificatiCampione.iterator();
	      
		   int id=0;
		   while (iterator.hasNext()){
			   
			CertificatoCampioneDTO certificatoTmp= (CertificatoCampioneDTO) iterator.next(); 
			  
			 if(certificatoTmp.getId()>id)
			 {
				 certificato=certificatoTmp;
				 id=certificatoTmp.getId();
			 }
		   
		   }
		
		
		return certificato;
	}

	
	
	public CertificatoCampioneDTO getCertificatoFromPunto(Set<CertificatoCampioneDTO> listaCertificatiCampione, String numeroCertificatoPunto) {
		
		CertificatoCampioneDTO certificato=null;
		
		 Iterator iterator = listaCertificatiCampione.iterator();
	      
		   while (iterator.hasNext()){
			   
			CertificatoCampioneDTO certificatoTmp= (CertificatoCampioneDTO) iterator.next(); 
			  
			 if(certificatoTmp.getNumero_certificato().equals(numeroCertificatoPunto))
			 {
				 return certificatoTmp;
			 }
		   
		   }
		
		
		return certificato;
	}
	
	
//	public Set<DocumentoCampioneDTO> getListaDocumentiEsterni() {
//		return listaDocumentiEsterni;
//	}
//
//	public void setListaDocumentiEsterni(Set<DocumentoCampioneDTO> listaDocumentiEsterni) {
//		this.listaDocumentiEsterni = listaDocumentiEsterni;
//	}

	public String getDistributore() {
		return distributore;
	}

	public void setDistributore(String distributore) {
		this.distributore = distributore;
	}

	public Date getData_acquisto() {
		return data_acquisto;
	}

	public void setData_acquisto(Date data_acquisto) {
		this.data_acquisto = data_acquisto;
	}

	public String getCampo_accettabilita() {
		return campo_accettabilita;
	}

	public void setCampo_accettabilita(String campo_accettabilita) {
		this.campo_accettabilita = campo_accettabilita;
	}

	public String getAttivita_di_taratura() {
		return attivita_di_taratura;
	}

	public void setAttivita_di_taratura(String attivita_di_taratura) {
		this.attivita_di_taratura = attivita_di_taratura;
	}
	public String getPrenotabile() {
		return prenotabile;
	}

	public void setPrenotabile(String prenotabile) {
		this.prenotabile = prenotabile;
	}

	public String getNote_attivita() {
		return note_attivita;
	}

	public void setNote_attivita(String note_attivita) {
		this.note_attivita = note_attivita;
	}

	public String getDescrizione_verifica_intermedia() {
		return descrizione_verifica_intermedia;
	}

	public void setDescrizione_verifica_intermedia(String descrizione_verifica_intermedia) {
		this.descrizione_verifica_intermedia = descrizione_verifica_intermedia;
	}

	public String getDescrizione_manutenzione() {
		return descrizione_manutenzione;
	}

	public void setDescrizione_manutenzione(String descrizione_manutenzione) {
		this.descrizione_manutenzione = descrizione_manutenzione;
	}

	public int getSettore() {
		return settore;
	}

	public void setSettore(int settore) {
		this.settore = settore;
	}

	public Date getData_messa_in_servizio() {
		return data_messa_in_servizio;
	}

	public void setData_messa_in_servizio(Date data_messa_in_servizio) {
		this.data_messa_in_servizio = data_messa_in_servizio;
	}

	public int getCampione_verificazione() {
		return campione_verificazione;
	}

	public void setCampione_verificazione(int campione_verificazione) {
		this.campione_verificazione = campione_verificazione;
	}

	public String getNumeroCertificatoPunto() {
		return numeroCertificatoPunto;
	}

	public void setNumeroCertificatoPunto(String numeroCertificatoPunto) {
		this.numeroCertificatoPunto = numeroCertificatoPunto;
	}

	public Date getDataScadenzaManutenzione() {
		return dataScadenzaManutenzione;
	}

	public void setDataScadenzaManutenzione(Date dataScadenzaManutenzione) {
		this.dataScadenzaManutenzione = dataScadenzaManutenzione;
	}

	public Date getDataManutenzione() {
		return dataManutenzione;
	}

	public void setDataManutenzione(Date dataManutenzione) {
		this.dataManutenzione = dataManutenzione;
	}

	public Date getDataScadenzaVerificaIntermedia() {
		return dataScadenzaVerificaIntermedia;
	}

	public void setDataScadenzaVerificaIntermedia(Date dataScadenzaVerificaIntermedia) {
		this.dataScadenzaVerificaIntermedia = dataScadenzaVerificaIntermedia;
	}

	public Date getDataVerificaIntermedia() {
		return dataVerificaIntermedia;
	}

	public void setDataVerificaIntermedia(Date dataVerificaIntermedia) {
		this.dataVerificaIntermedia = dataVerificaIntermedia;
	}

	

}