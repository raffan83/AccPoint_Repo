package it.portaleSTI.DTO;

import java.util.Date;


public class AgendaMilestoneDTO {

	private String USERNAME="";
	private int STATO;
	private String SOGGETTO;
	private String NOTA;
	private int LABEL;
	private Date STARTDATE;
	private Date ENDTDATE;
	private int ID_ANAGEN;
	private String ID_COMMESSA;
	private String DESCRIZIONE;
	private String FASE;
	public String getUSERNAME() {
		return USERNAME;
	}
	public void setUSERNAME(String uSERNAME) {
		USERNAME = uSERNAME;
	}
	public int getSTATO() {
		return STATO;
	}
	public void setSTATO(int sTATO) {
		STATO = sTATO;
	}
	public String getSOGGETTO() {
		return SOGGETTO;
	}
	public void setSOGGETTO(String sOGGETTO) {
		SOGGETTO = sOGGETTO;
	}
	public String getDESCRIZIONE() {
		return DESCRIZIONE;
	}
	public void setDESCRIZIONE(String dESCRIZIONE) {
		DESCRIZIONE = dESCRIZIONE;
	}
	public int getLABEL() {
		return LABEL;
	}
	public void setLABEL(int lABEL) {
		LABEL = lABEL;
	}
	public Date getSTARTDATE() {
		return STARTDATE;
	}
	public void setSTARTDATE(Date sTARTDATE) {
		STARTDATE = sTARTDATE;
	}
	public Date getENDTDATE() {
		return ENDTDATE;
	}
	public void setENDTDATE(Date eNDTDATE) {
		ENDTDATE = eNDTDATE;
	}
	public int getID_ANAGEN() {
		return ID_ANAGEN;
	}
	public void setID_ANAGEN(int iD_ANAGEN) {
		ID_ANAGEN = iD_ANAGEN;
	}
	public String getID_COMMESSA() {
		return ID_COMMESSA;
	}
	public void setID_COMMESSA(String iD_COMMESSA) {
		ID_COMMESSA = iD_COMMESSA;
	}
	public String getNOTA() {
		return NOTA;
	}
	public void setNOTA(String nOTA) {
		NOTA = nOTA;
	}
	public String getFASE() {
		return FASE;
	}
	public void setFASE(String fASE) {
		FASE = fASE;
	}
	
	
	
}
