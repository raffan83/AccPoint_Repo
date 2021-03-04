package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class VerLegalizzazioneBilanceDTO {
	
	private int id;

	private String descrizione_strumento;
	private String costruttore;
	private String modello;
	private String classe;
	private VerTipoApprovazioneDTO tipo_approvazione;
	private VerTipoProvvedimentoDTO tipo_provvedimento;
	private String rev;
	private Date data_provvedimento;
	private String numero_provvedimento;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getDescrizione_strumento() {
		return descrizione_strumento;
	}
	public void setDescrizione_strumento(String descrizione_strumento) {
		this.descrizione_strumento = descrizione_strumento;
	}
	public String getCostruttore() {
		return costruttore;
	}
	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public String getClasse() {
		return classe;
	}
	public void setClasse(String classe) {
		this.classe = classe;
	}
	public VerTipoApprovazioneDTO getTipo_approvazione() {
		return tipo_approvazione;
	}
	public void setTipo_approvazione(VerTipoApprovazioneDTO tipo_approvazione) {
		this.tipo_approvazione = tipo_approvazione;
	}
	public VerTipoProvvedimentoDTO getTipo_provvedimento() {
		return tipo_provvedimento;
	}
	public void setTipo_provvedimento(VerTipoProvvedimentoDTO tipo_provvedimento) {
		this.tipo_provvedimento = tipo_provvedimento;
	}
	public String getRev() {
		return rev;
	}
	public void setRev(String rev) {
		this.rev = rev;
	}
	public Date getData_provvedimento() {
		return data_provvedimento;
	}
	public void setData_provvedimento(Date data_provvedimento) {
		this.data_provvedimento = data_provvedimento;
	}
	public String getNumero_provvedimento() {
		return numero_provvedimento;
	}
	public void setNumero_provvedimento(String numero_provvedimento) {
		this.numero_provvedimento = numero_provvedimento;
	}


}
