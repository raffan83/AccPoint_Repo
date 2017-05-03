package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class CommessaDTO implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String ID_COMMESSA;
	private Date DT_COMMESSA;
	private Date FIR_CHIUSURA_DT;
	private int ID_ANAGEN;
	private String ID_ANAGEN_NOME;
	private String DESCR;
	private String SYS_STATO;
	private int ID_ANAGEN_COMM;
	private int K2_ANAGEN_INDR;
	private String ANAGEN_INDR_DESCR;
	private String ANAGEN_INDR_INDIRIZZO;
	
	public String getID_COMMESSA() {
		return ID_COMMESSA;
	}
	public void setID_COMMESSA(String iD_COMMESSA) {
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
	public Date getFIR_CHIUSURA_DT() {
		return FIR_CHIUSURA_DT;
	}
	public void setFIR_CHIUSURA_DT(Date fIR_CHIUSURA_DT) {
		FIR_CHIUSURA_DT = fIR_CHIUSURA_DT;
	}
	public String getID_ANAGEN_NOME() {
		return ID_ANAGEN_NOME;
	}
	public void setID_ANAGEN_NOME(String iD_ANAGEN_NOME) {
		ID_ANAGEN_NOME = iD_ANAGEN_NOME;
	}
	public int getK2_ANAGEN_INDR() {
		return K2_ANAGEN_INDR;
	}
	public void setK2_ANAGEN_INDR(int k2_ANAGEN_INDR) {
		K2_ANAGEN_INDR = k2_ANAGEN_INDR;
	}
	public String getANAGEN_INDR_DESCR() {
		return ANAGEN_INDR_DESCR;
	}
	public void setANAGEN_INDR_DESCR(String aNAGEN_INDR_DESCR) {
		ANAGEN_INDR_DESCR = aNAGEN_INDR_DESCR;
	}
	public String getANAGEN_INDR_INDIRIZZO() {
		return ANAGEN_INDR_INDIRIZZO;
	}
	public void setANAGEN_INDR_INDIRIZZO(String aNAGEN_INDR_INDIRIZZO) {
		ANAGEN_INDR_INDIRIZZO = aNAGEN_INDR_INDIRIZZO;
	}
	
	
	
}
