package it.portaleSTI.DTO;



public class ContattoDTO {

	private String Name;
	private String Cognome;
	private String Email;
	
	
	public ContattoDTO() {
		
	}


	public ContattoDTO(String name, String cognome, String email) {
		super();
		Name = name;
		Cognome = cognome;
		Email = email;
	}


	public String getName() {
		return Name;
	}


	public void setName(String name) {
		Name = name;
	}


	public String getCognome() {
		return Cognome;
	}


	public void setCognome(String cognome) {
		Cognome = cognome;
	}


	public String getEmail() {
		return Email;
	}


	public void setEmail(String email) {
		Email = email;
	}
	


}
