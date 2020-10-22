package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Set;

public class DocumFornitoreDTO {
	
	private int id;
	private DocumCommittenteDTO committente;
	private String ragione_sociale;
	private String p_iva;
	private String cf;
	private String indirizzo;
	private String comune;
	private String cap;
	private String provincia;
	private String nazione;
	private String abilitato;
	private String email;
	private DocumTLStatoDTO stato;
	
	private Set<DocumDipendenteFornDTO> listaDipendenti = new HashSet<DocumDipendenteFornDTO>(0);
	private Set<DocumReferenteFornDTO> listaReferenti = new HashSet<DocumReferenteFornDTO>(0);
	private Set<DocumTLDocumentoDTO> listaDocumenti = new HashSet<DocumTLDocumentoDTO>(0);
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public DocumCommittenteDTO getCommittente() {
		return committente;
	}
	public void setCommittente(DocumCommittenteDTO committente) {
		this.committente = committente;
	}
	public String getRagione_sociale() {
		return ragione_sociale;
	}
	public void setRagione_sociale(String ragione_sociale) {
		this.ragione_sociale = ragione_sociale;
	}
	public String getP_iva() {
		return p_iva;
	}
	public void setP_iva(String p_iva) {
		this.p_iva = p_iva;
	}
	public String getCf() {
		return cf;
	}
	public void setCf(String cf) {
		this.cf = cf;
	}
	public String getIndirizzo() {
		return indirizzo;
	}
	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
	public String getComune() {
		return comune;
	}
	public void setComune(String comune) {
		this.comune = comune;
	}
	public String getCap() {
		return cap;
	}
	public void setCap(String cap) {
		this.cap = cap;
	}
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getNazione() {
		return nazione;
	}
	public void setNazione(String nazione) {
		this.nazione = nazione;
	}
	public String getAbilitato() {
		return abilitato;
	}
	public void setAbilitato(String abilitato) {
		this.abilitato = abilitato;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public DocumTLStatoDTO getStato() {
		return stato;
	}
	public void setStato(DocumTLStatoDTO stato) {
		this.stato = stato;
	}
	public Set<DocumDipendenteFornDTO> getListaDipendenti() {
		return listaDipendenti;
	}
	public void setListaDipendenti(Set<DocumDipendenteFornDTO> listaDipendenti) {
		this.listaDipendenti = listaDipendenti;
	}
	public Set<DocumReferenteFornDTO> getListaReferenti() {
		return listaReferenti;
	}
	public void setListaReferenti(Set<DocumReferenteFornDTO> listaReferenti) {
		this.listaReferenti = listaReferenti;
	}
	public Set<DocumTLDocumentoDTO> getListaDocumenti() {
		return listaDocumenti;
	}
	public void setListaDocumenti(Set<DocumTLDocumentoDTO> listaDocumenti) {
		this.listaDocumenti = listaDocumenti;
	}
	
	

}
