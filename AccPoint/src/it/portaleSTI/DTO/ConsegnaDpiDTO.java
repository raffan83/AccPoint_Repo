package it.portaleSTI.DTO;

import java.util.Date;

public class ConsegnaDpiDTO {

	private int id;
	private DpiDTO dpi;
	private Date data_consegna;
	private Date data_accettazione;
	private DocumDipendenteFornDTO lavoratore;
	private int ricevuto;
	private int riconsegnato;
	private ConsegnaDpiDTO restituzione;
	private int is_restituzione;
	private String motivazione;
	private String commessa;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public DocumDipendenteFornDTO getLavoratore() {
		return lavoratore;
	}
	public void setLavoratore(DocumDipendenteFornDTO lavoratore) {
		this.lavoratore = lavoratore;
	}
	public int getRicevuto() {
		return ricevuto;
	}
	public void setRicevuto(int ricevuto) {
		this.ricevuto = ricevuto;
	}
	public int getRiconsegnato() {
		return riconsegnato;
	}
	public void setRiconsegnato(int riconsegnato) {
		this.riconsegnato = riconsegnato;
	}
	public ConsegnaDpiDTO getRestituzione() {
		return restituzione;
	}
	public void setRestituzione(ConsegnaDpiDTO restituzione) {
		this.restituzione = restituzione;
	}
	public Date getData_consegna() {
		return data_consegna;
	}
	public void setData_consegna(Date data_consegna) {
		this.data_consegna = data_consegna;
	}
	public int getIs_restituzione() {
		return is_restituzione;
	}
	public void setIs_restituzione(int is_restituzione) {
		this.is_restituzione = is_restituzione;
	}
	public String getMotivazione() {
		return motivazione;
	}
	public void setMotivazione(String motivazione) {
		this.motivazione = motivazione;
	}
	public Date getData_accettazione() {
		return data_accettazione;
	}
	public void setData_accettazione(Date data_accettazione) {
		this.data_accettazione = data_accettazione;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public DpiDTO getDpi() {
		return dpi;
	}
	public void setDpi(DpiDTO dpi) {
		this.dpi = dpi;
	}
	
	
}
