package it.portaleSTI.DTO;

public class ForDocenteDTO {
	
	private int id;
	private String nome;
	private String cognome;
	private int formatore;
	private String cv;
	private String email;
	private String utenteMilestone;
	private String fase;
	
	
	public ForDocenteDTO(int id) {
		this.id = id;
	}
	
	public ForDocenteDTO() {
		super();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getCv() {
		return cv;
	}
	public void setCv(String cv) {
		this.cv = cv;
	}

	public int getFormatore() {
		return formatore;
	}

	public void setFormatore(int formatore) {
		this.formatore = formatore;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUtenteMilestone() {
		return utenteMilestone;
	}

	public void setUtenteMilestone(String utenteMilestone) {
		this.utenteMilestone = utenteMilestone;
	}

	public String getFase() {
		return fase;
	}

	public void setFase(String fase) {
		this.fase = fase;
	}
	
	
	

}
