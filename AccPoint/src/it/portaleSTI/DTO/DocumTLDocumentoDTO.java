package it.portaleSTI.DTO;

import java.util.Date;

public class DocumTLDocumentoDTO {
	
	private int id;
	private String nome_documento;
	private int frequenza_rinnovo_mesi;
	private String rilasciato;
	private Date data_caricamento;
	private DocumCommittenteDTO committente;
	private DocumFornitoreDTO fornitore;
	
	private Date data_scadenza;
	private String nome_file;
	private int disabilitato;
	private String numero_documento;
	
	private DocumTLStatoDTO stato;
	private int obsoleto;
	private int email_inviata;
	private int documento_sostituito;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome_documento() {
		return nome_documento;
	}
	public void setNome_documento(String nome_documento) {
		this.nome_documento = nome_documento;
	}
	public int getFrequenza_rinnovo_mesi() {
		return frequenza_rinnovo_mesi;
	}
	public void setFrequenza_rinnovo_mesi(int frequenza_rinnovo_mesi) {
		this.frequenza_rinnovo_mesi = frequenza_rinnovo_mesi;
	}
	public String getRilasciato() {
		return rilasciato;
	}
	public void setRilasciato(String rilasciato) {
		this.rilasciato = rilasciato;
	}
	public Date getData_caricamento() {
		return data_caricamento;
	}
	public void setData_caricamento(Date data_caricamento) {
		this.data_caricamento = data_caricamento;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
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
	public DocumCommittenteDTO getCommittente() {
		return committente;
	}
	public void setCommittente(DocumCommittenteDTO committente) {
		this.committente = committente;
	}
	public DocumFornitoreDTO getFornitore() {
		return fornitore;
	}
	public void setFornitore(DocumFornitoreDTO fornitore) {
		this.fornitore = fornitore;
	}
	public DocumTLStatoDTO getStato() {
		return stato;
	}
	public void setStato(DocumTLStatoDTO stato) {
		this.stato = stato;
	}
	public int getObsoleto() {
		return obsoleto;
	}
	public void setObsoleto(int obsoleto) {
		this.obsoleto = obsoleto;
	}
	public int getEmail_inviata() {
		return email_inviata;
	}
	public void setEmail_inviata(int email_inviata) {
		this.email_inviata = email_inviata;
	}
	public String getNumero_documento() {
		return numero_documento;
	}
	public void setNumero_documento(String numero_documento) {
		this.numero_documento = numero_documento;
	}
	public int getDocumento_sostituito() {
		return documento_sostituito;
	}
	public void setDocumento_sostituito(int documento_sostituito) {
		this.documento_sostituito = documento_sostituito;
	}

	
}
