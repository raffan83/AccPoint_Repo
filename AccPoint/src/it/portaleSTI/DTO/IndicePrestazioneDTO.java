package it.portaleSTI.DTO;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;



public class IndicePrestazioneDTO {
	
	  private MisuraDTO misura;
	    private BigDecimal indice;
	
	
	public IndicePrestazioneDTO() {
		
	}


	public IndicePrestazioneDTO(MisuraDTO misura, BigDecimal indice) {
		super();
		this.misura = misura;
		this.indice = indice;
	}


	public MisuraDTO getMisura() {
		return misura;
	}


	public void setMisura(MisuraDTO misura) {
		this.misura = misura;
	}


	public BigDecimal getIndice() {
		return indice;
	}


	public void setIndice(BigDecimal indice) {
		this.indice = indice;
	}
	
	
	
	

}
