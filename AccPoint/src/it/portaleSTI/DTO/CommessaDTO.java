package it.portaleSTI.DTO;

import java.io.Serializable;
import java.sql.Date;

public class CommessaDTO implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int ID_COMMESSA;
	private Date DT_COMMESSA;
	private int ID_ANAGEN;
	private String DESCR;
	private String SYS_STATO;
	private int ID_ANAGEN_COMM;
	public int getID_COMMESSA() {
		return ID_COMMESSA;
	}
	public void setID_COMMESSA(int iD_COMMESSA) {
		ID_COMMESSA = iD_COMMESSA;
	}
	public Date getDT_COMMESSA() {
		return DT_COMMESSA;
	}
	public void setDT_COMMESSA(Date dT_COMMESSA) {
		DT_COMMESSA = dT_COMMESSA;
	}
	public int getID_ANAGEN() {
		return ID_ANAGEN;
	}
	public void setID_ANAGEN(int iD_ANAGEN) {
		ID_ANAGEN = iD_ANAGEN;
	}
	public String getDESCR() {
		return DESCR;
	}
	public void setDESCR(String dESCR) {
		DESCR = dESCR;
	}
	public String getSYS_STATO() {
		return SYS_STATO;
	}
	public void setSYS_STATO(String sYS_STATO) {
		SYS_STATO = sYS_STATO;
	}
	public int getID_ANAGEN_COMM() {
		return ID_ANAGEN_COMM;
	}
	public void setID_ANAGEN_COMM(int iD_ANAGEN_COMM) {
		ID_ANAGEN_COMM = iD_ANAGEN_COMM;
	}
	
	
	
}
