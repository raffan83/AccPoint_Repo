package it.portaleSTI.DTO;

import java.io.File;
import java.util.ArrayList;

public class ObjSavePackDTO {
	
	private int esito;

	private ArrayList<StrumentoDTO> listaStrumentiDuplicati = new ArrayList<StrumentoDTO>();
	
	private ArrayList<VerStrumentoDTO> listaVerStrumentiDuplicati = new ArrayList<VerStrumentoDTO>();

	private String errorMsg="";
	
	private File packNameAssigned;
	
	private boolean duplicati=false;
	
	private InterventoDatiDTO interventoDati;
	
	private boolean isLAT=false;

	public File getPackNameAssigned() {
		return packNameAssigned;
	}

	public void setPackNameAssigned(File packNameAssigned) {
		this.packNameAssigned = packNameAssigned;
	}

	public int getEsito() {
		return esito;
	}

	public void setEsito(int esito) {
		this.esito = esito;
	}

	public ArrayList<StrumentoDTO> getListaStrumentiDuplicati() {
		return listaStrumentiDuplicati;
	}

	public void setListaStrumentiDuplicati(
			ArrayList<StrumentoDTO> listaStrumentiDuplicati) {
		this.listaStrumentiDuplicati = listaStrumentiDuplicati;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public boolean isDuplicati() {
		return duplicati;
	}

	public void setDuplicati(boolean duplicati) {
		this.duplicati = duplicati;
	}

	public InterventoDatiDTO getInterventoDati() {
		return interventoDati;
	}

	public void setInterventoDati(InterventoDatiDTO interventoDati) {
		this.interventoDati = interventoDati;
	}

	public boolean isLAT() {
		return isLAT;
	}

	public void setLAT(boolean isLAT) {
		this.isLAT = isLAT;
	}

	public ArrayList<VerStrumentoDTO> getListaVerStrumentiDuplicati() {
		return listaVerStrumentiDuplicati;
	}

	public void setListaVerStrumentiDuplicati(ArrayList<VerStrumentoDTO> listaVerStrumentiDuplicati) {
		this.listaVerStrumentiDuplicati = listaVerStrumentiDuplicati;
	}
	
	
	
}
