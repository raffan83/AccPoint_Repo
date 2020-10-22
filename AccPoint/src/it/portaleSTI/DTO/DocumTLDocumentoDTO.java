package it.portaleSTI.DTO;

import java.util.Date;

public class DocumTLDocumentoDTO {
	
	private int id;
	private String nome_documento;
	private int frequenza_rinnovo_mesi;
	private String rilasciato;
	private Date data_caricamento;
	private int id_fornitore;
	private String nome_fornitore;
	private Date data_scadenza;
	private String nome_file;
	private int disabilitato;
	
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
	public int getId_fornitore() {
		return id_fornitore;
	}
	public void setId_fornitore(int id_fornitore) {
		this.id_fornitore = id_fornitore;
	}
	public String getNome_fornitore() {
		return nome_fornitore;
	}
	public void setNome_fornitore(String nome_fornitore) {
		this.nome_fornitore = nome_fornitore;
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

	
}
