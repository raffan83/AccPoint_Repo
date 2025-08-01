package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;


public class ForCorsoDTO {

	private int id;
	private ForCorsoCatDTO corso_cat;
	private ForDocenteDTO docente;
	private Date data_corso;
	private Date data_scadenza;
	private String documento_test;
	private String descrizione;
	private String tipologia;
	private String commessa;
	private ForQuestionarioDTO questionario;
	private int e_learning;
	private int visibile;
	private int disabilitato;
	private int scheda_consegna_inviata;
	private int durata;
	private int in_scadenza;
	
	private Set<ForPartecipanteDTO> listaPartecipanti = new HashSet<ForPartecipanteDTO>(0);
	private Set<ForReferenteDTO> listaReferenti = new HashSet<ForReferenteDTO>(0);
	private Set<ForDocenteDTO> listaDocenti = new HashSet<ForDocenteDTO>(0);
	
	private int email_inviata;
	private int efei;
	private int n_attestati;
	private int frequenza_remind;
	private Date data_remind;
	
	
	public ForCorsoDTO() {
		super();
	}
	public ForCorsoDTO(int id) {
		this.id = id;

	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public ForCorsoCatDTO getCorso_cat() {
		return corso_cat;
	}
	public void setCorso_cat(ForCorsoCatDTO corso_cat) {
		this.corso_cat = corso_cat;
	}
	public ForDocenteDTO getDocente() {
		return docente;
	}
	public void setDocente(ForDocenteDTO docente) {
		this.docente = docente;
	}

	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public String getDocumento_test() {
		return documento_test;
	}
	public void setDocumento_test(String documento_test) {
		this.documento_test = documento_test;
	}	
	public Date getData_corso() {
		return data_corso;
	}
	public void setData_corso(Date data_corso) {
		this.data_corso = data_corso;
	}

	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public Set<ForPartecipanteDTO> getListaPartecipanti() {
		return listaPartecipanti;
	}
	public void setListaPartecipanti(Set<ForPartecipanteDTO> listaPartecipanti) {
		this.listaPartecipanti = listaPartecipanti;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public ForQuestionarioDTO getQuestionario() {
		return questionario;
	}
	public void setQuestionario(ForQuestionarioDTO questionario) {
		this.questionario = questionario;
	}
	public int getE_learning() {
		return e_learning;
	}
	public void setE_learning(int e_learning) {
		this.e_learning = e_learning;
	}
	public int getVisibile() {
		return visibile;
	}
	public void setVisibile(int visibile) {
		this.visibile = visibile;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public Set<ForReferenteDTO> getListaReferenti() {
		return listaReferenti;
	}
	public void setListaReferenti(Set<ForReferenteDTO> listaReferenti) {
		this.listaReferenti = listaReferenti;
	}
	public int getScheda_consegna_inviata() {
		return scheda_consegna_inviata;
	}
	public void setScheda_consegna_inviata(int scheda_consegna_inviata) {
		this.scheda_consegna_inviata = scheda_consegna_inviata;
	}
	public int getDurata() {
		return durata;
	}
	public void setDurata(int durata) {
		this.durata = durata;
	}

	public String getTipologia() {
		return tipologia;
	}
	public void setTipologia(String tipologia) {
		this.tipologia = tipologia;
	}
	public int getIn_scadenza() {
		return in_scadenza;
	}
	public void setIn_scadenza(int in_scadenza) {
		this.in_scadenza = in_scadenza;
	}
	public Set<ForDocenteDTO> getListaDocenti() {
		return listaDocenti;
	}
	public void setListaDocenti(Set<ForDocenteDTO> listaDocenti) {
		this.listaDocenti = listaDocenti;
	}

	public JsonObject getDocentiCorsoJson() {
	
		JsonObject jobj = new JsonObject();
		
	
		if(this.listaDocenti!=null) {
			JsonArray docenti = new JsonArray();

			for (ForDocenteDTO docente : this.listaDocenti) {
				
				JsonObject json = new JsonObject();
				
				json.addProperty("id", docente.getId());
				json.addProperty("nome", docente.getNome());
				json.addProperty("cognome", docente.getCognome());
				json.addProperty("formatore", docente.getFormatore());
				
				docenti.add(json);
			}
			jobj.add("lista_docenti",docenti);
		}
		
		return jobj;
	}
	public int getEmail_inviata() {
		return email_inviata;
	}
	public void setEmail_inviata(int email_inviata) {
		this.email_inviata = email_inviata;
	}
	public int getN_attestati() {
		return n_attestati;
	}
	public void setN_attestati(int n_attestati) {
		this.n_attestati = n_attestati;
	}
	public int getEfei() {
		return efei;
	}
	public void setEfei(int efei) {
		this.efei = efei;
	}
	public int getfrequenza_remind() {
		return frequenza_remind;
	}
	public void setfrequenza_remind(int frequenza_remind) {
		this.frequenza_remind = frequenza_remind;
	}
	public Date getData_remind() {
		return data_remind;
	}
	public void setData_remind(Date data_remind) {
		this.data_remind = data_remind;
	}

	
}
