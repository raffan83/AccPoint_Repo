package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;


public class ForPiaPianificazioneDTO {

	private int id;
	private ForPiaStatoDTO stato;
	private ForPiaTipoDTO tipo;
	private String id_commessa;
	private Date data;
	private String ora_inizio;
	private String ora_fine;
	private int nUtenti;
	private String note;
	private int nCella;
	private Date data_reminder;
	private String pausa_pranzo;

	private Set<ForDocenteDTO> listaDocenti = new HashSet<ForDocenteDTO>(0);
	


	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public ForPiaStatoDTO getStato() {
		return stato;
	}



	public void setStato(ForPiaStatoDTO stato) {
		this.stato = stato;
	}



	public ForPiaTipoDTO getTipo() {
		return tipo;
	}



	public void setTipo(ForPiaTipoDTO tipo) {
		this.tipo = tipo;
	}



	public String getId_commessa() {
		return id_commessa;
	}



	public void setId_commessa(String id_commessa) {
		this.id_commessa = id_commessa;
	}



	public Date getData() {
		return data;
	}



	public void setData(Date data) {
		this.data = data;
	}



	public String getOra_inizio() {
		return ora_inizio;
	}



	public void setOra_inizio(String ora_inizio) {
		this.ora_inizio = ora_inizio;
	}



	public String getOra_fine() {
		return ora_fine;
	}



	public void setOra_fine(String ora_fine) {
		this.ora_fine = ora_fine;
	}



	public int getnUtenti() {
		return nUtenti;
	}



	public void setnUtenti(int nUtenti) {
		this.nUtenti = nUtenti;
	}



	public String getNote() {
		return note;
	}



	public void setNote(String note) {
		this.note = note;
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



	public int getnCella() {
		return nCella;
	}



	public void setnCella(int nCella) {
		this.nCella = nCella;
	}



	public Date getData_reminder() {
		return data_reminder;
	}



	public void setData_reminder(Date data_reminder) {
		this.data_reminder = data_reminder;
	}



	public String getPausa_pranzo() {
		return pausa_pranzo;
	}



	public void setPausa_pranzo(String pausa_pranzo) {
		this.pausa_pranzo = pausa_pranzo;
	}
	
}
