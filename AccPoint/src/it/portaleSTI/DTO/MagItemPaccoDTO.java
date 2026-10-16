package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class MagItemPaccoDTO implements Serializable {
	
	private MagPaccoDTO pacco;
	private MagItemDTO item;
	private int quantita;
	private String note;
	private Integer accettato;
	private String note_accettazione;
	private UtenteDTO user_accettato;
	private Date data_accettato;
	
	private int gia_spediti;
	
	private Integer check_controllo_uscita = 0;
	private UtenteDTO user_check_uscita;
	private  Date data_check_uscita;
	
	private Integer check_fornitore = 0;
	private UtenteDTO user_fornitore;
	private  Date data_fornitore;
	
	
	public MagPaccoDTO getPacco() {
		return pacco;
	}
	public void setPacco(MagPaccoDTO pacco) {
		this.pacco = pacco;
	}
	public MagItemDTO getItem() {
		return item;
	}
	public void setItem(MagItemDTO item) {
		this.item = item;
	}
	public int getQuantita() {
		return quantita;
	}
	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Integer getAccettato() {
		return accettato;
	}
	public void setAccettato(Integer accettato) {
		this.accettato = accettato;
	}
	public String getNote_accettazione() {
		return note_accettazione;
	}
	public void setNote_accettazione(String note_accettazione) {
		this.note_accettazione = note_accettazione;
	}
	public int getGia_spediti() {
		return gia_spediti;
	}
	public void setGia_spediti(int gia_spediti) {
		this.gia_spediti = gia_spediti;
	}
	public Integer getCheck_controllo_uscita() {
		return check_controllo_uscita;
	}
	public void setCheck_controllo_uscita(Integer check_controllo_uscita) {
		this.check_controllo_uscita = check_controllo_uscita;
	}
	public UtenteDTO getUser_check_uscita() {
		return user_check_uscita;
	}
	public void setUser_check_uscita(UtenteDTO user_check_uscita) {
		this.user_check_uscita = user_check_uscita;
	}
	public Date getData_check_uscita() {
		return data_check_uscita;
	}
	public void setData_check_uscita(Date data_check_uscita) {
		this.data_check_uscita = data_check_uscita;
	}
	public UtenteDTO getUser_accettato() {
		return user_accettato;
	}
	public void setUser_accettato(UtenteDTO user_accettato) {
		this.user_accettato = user_accettato;
	}
	public Date getData_accettato() {
		return data_accettato;
	}
	public void setData_accettato(Date data_accettato) {
		this.data_accettato = data_accettato;
	}
	public Integer getCheck_fornitore() {
		return check_fornitore;
	}
	public void setCheck_fornitore(Integer check_fornitore) {
		this.check_fornitore = check_fornitore;
	}
	public UtenteDTO getUser_fornitore() {
		return user_fornitore;
	}
	public void setUser_fornitore(UtenteDTO user_fornitore) {
		this.user_fornitore = user_fornitore;
	}
	public Date getData_fornitore() {
		return data_fornitore;
	}
	public void setData_fornitore(Date data_fornitore) {
		this.data_fornitore = data_fornitore;
	}
	
    
	
	
}
