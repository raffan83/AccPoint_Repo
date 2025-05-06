package it.portaleSTI.DTO;

import java.util.Date;

public class ItServizioItDTO {
	
	private int id;
	private String descrizione;
	private ItTipoServizioDTO tipo_servizio;
	private ItTipoRinnovoDTO tipo_rinnovo;
	private Date data_scadenza;
	private Date data_acquisto;
	private Date data_sollecito;
	private Date data_remind;
	private String fornitore;
	private String email_referenti;
	private String modalita_pagamento;
	private int disabilitato;
	private int stato;
	private DocumFornitoreDTO id_company;
	private int rinnovo_automatico;
	private int frequenza_rinnovo; 
	
	
	

	public int getRinnovo_automatico() {
		return rinnovo_automatico;
	}




	public void setRinnovo_automatico(int rinnovo_automatico) {
		this.rinnovo_automatico = rinnovo_automatico;
	}




	public int getFrequenza_rinnovo() {
		return frequenza_rinnovo;
	}




	public void setFrequenza_rinnovo(int frequenza_rinnovo) {
		this.frequenza_rinnovo = frequenza_rinnovo;
	}




	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public String getDescrizione() {
		return descrizione;
	}




	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}




	public ItTipoServizioDTO getTipo_servizio() {
		return tipo_servizio;
	}




	public void setTipo_servizio(ItTipoServizioDTO tipo_servizio) {
		this.tipo_servizio = tipo_servizio;
	}




	public ItTipoRinnovoDTO getTipo_rinnovo() {
		return tipo_rinnovo;
	}




	public void setTipo_rinnovo(ItTipoRinnovoDTO tipo_rinnovo) {
		this.tipo_rinnovo = tipo_rinnovo;
	}




	public Date getData_scadenza() {
		return data_scadenza;
	}




	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}




	public Date getData_acquisto() {
		return data_acquisto;
	}




	public void setData_acquisto(Date data_acquisto) {
		this.data_acquisto = data_acquisto;
	}




	public String getFornitore() {
		return fornitore;
	}




	public void setFornitore(String fornitore) {
		this.fornitore = fornitore;
	}




	public String getEmail_referenti() {
		return email_referenti;
	}




	public void setEmail_referenti(String email_referenti) {
		this.email_referenti = email_referenti;
	}




	public String getModalita_pagamento() {
		return modalita_pagamento;
	}




	public void setModalita_pagamento(String modalita_pagamento) {
		this.modalita_pagamento = modalita_pagamento;
	}




	public Date getData_sollecito() {
		return data_sollecito;
	}




	public void setData_sollecito(Date data_sollecito) {
		this.data_sollecito = data_sollecito;
	}




	public Date getData_remind() {
		return data_remind;
	}




	public void setData_remind(Date data_remind) {
		this.data_remind = data_remind;
	}




	public int getDisabilitato() {
		return disabilitato;
	}




	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}




	public int getStato() {
		return stato;
	}




	public void setStato(int stato) {
		this.stato = stato;
	}




	public DocumFornitoreDTO getId_company() {
		return id_company;
	}




	public void setId_company(DocumFornitoreDTO id_company) {
		this.id_company = id_company;
	}




	public ItServizioItDTO() {
		// TODO Auto-generated constructor stub
	}

}
