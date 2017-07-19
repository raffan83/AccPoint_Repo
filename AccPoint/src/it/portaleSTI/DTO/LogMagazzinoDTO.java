package it.portaleSTI.DTO;

public class LogMagazzinoDTO {
	private int id;
	private AccessorioDTO accessorio;
	private String operazione;
	private int quantita_prima;
	private int quantita_dopo;
	private String note;
	private UtenteDTO user;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public AccessorioDTO getAccessorio() {
		return accessorio;
	}
	public void setAccessorio(AccessorioDTO accessorio) {
		this.accessorio = accessorio;
	}
	public String getOperazione() {
		return operazione;
	}
	public void setOperazione(String operazione) {
		this.operazione = operazione;
	}
	public int getQuantita_prima() {
		return quantita_prima;
	}
	public void setQuantita_prima(int quantita_prima) {
		this.quantita_prima = quantita_prima;
	}
	public int getQuantita_dopo() {
		return quantita_dopo;
	}
	public void setQuantita_dopo(int quantita_dopo) {
		this.quantita_dopo = quantita_dopo;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}

}
