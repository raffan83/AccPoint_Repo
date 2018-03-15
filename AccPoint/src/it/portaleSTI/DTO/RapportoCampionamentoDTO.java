package it.portaleSTI.DTO;

import java.sql.Date;

public class RapportoCampionamentoDTO {

	private int id;
	private RelazioneCampionamentoDTO tipoRelazione;
	private String nomeFile;
 	private String idsInterventi;
	private  UtenteDTO userCreation;
	private Date dataCreazione;
	private String idCommessa;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public RelazioneCampionamentoDTO getTipoRelazione() {
		return tipoRelazione;
	}
	public void setTipoRelazione(RelazioneCampionamentoDTO tipoRelazione) {
		this.tipoRelazione = tipoRelazione;
	}
	public String getNomeFile() {
		return nomeFile;
	}
	public void setNomeFile(String nomeFile) {
		this.nomeFile = nomeFile;
	}
	public String getIdsInterventi() {
		return idsInterventi;
	}
	public void setIdsInterventi(String idsInterventi) {
		this.idsInterventi = idsInterventi;
	}
	public UtenteDTO getUserCreation() {
		return userCreation;
	}
	public void setUserCreation(UtenteDTO userCreation) {
		this.userCreation = userCreation;
	}
	public Date getDataCreazione() {
		return dataCreazione;
	}
	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}
	public String getIdCommessa() {
		return idCommessa;
	}
	public void setIdCommessa(String idCommessa) {
		this.idCommessa = idCommessa;
	}


	
}
