package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Set;

public class DocumDipendenteFornDTO {

	private int id;
	//private int id_fornitore;
	//private String nome_fornitore;
	private DocumCommittenteDTO committente;
	private DocumFornitoreDTO fornitore;
	private String cognome;
	private String nome;
	private String qualifica;
	private String note;
	private DocumTLStatoDipendenteDTO stato;
	
	
	private Set<DocumTLDocumentoDTO> listaDocumenti = new HashSet<DocumTLDocumentoDTO>(0);
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getQualifica() {
		return qualifica;
	}
	public void setQualifica(String qualifica) {
		this.qualifica = qualifica;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
//	public int getId_fornitore() {
//		return id_fornitore;
//	}
//	public void setId_fornitore(int id_fornitore) {
//		this.id_fornitore = id_fornitore;
//	}
//	public String getNome_fornitore() {
//		return nome_fornitore;
//	}
//	public void setNome_fornitore(String nome_fornitore) {
//		this.nome_fornitore = nome_fornitore;
//	}
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
	public Set<DocumTLDocumentoDTO> getListaDocumenti() {
		return listaDocumenti;
	}
	public void setListaDocumenti(Set<DocumTLDocumentoDTO> listaDocumenti) {
		this.listaDocumenti = listaDocumenti;
	}
	public DocumTLStatoDipendenteDTO getStato() {
		return stato;
	}
	public void setStato(DocumTLStatoDipendenteDTO stato) {
		this.stato = stato;
	}
	
	
}
