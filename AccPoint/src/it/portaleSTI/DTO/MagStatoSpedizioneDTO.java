package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagStatoSpedizioneDTO {


	    private Integer id;
	    private String descrizione;
	    
	    
		public MagStatoSpedizioneDTO() {
			super();
		}
		
		public MagStatoSpedizioneDTO(int i) {
			id=i;
		}
		


		public Integer getId() {
			return id;
		}


		public void setId(Integer id) {
			this.id = id;
		}


		public String getDescrizione() {
			return descrizione;
		}


		public void setDescrizione(String descrizione) {
			this.descrizione = descrizione;
		}
	    
		
	    
}
