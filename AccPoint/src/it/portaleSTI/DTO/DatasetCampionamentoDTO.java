package it.portaleSTI.DTO;




public class DatasetCampionamentoDTO {
	
	private int id=0;
	private int idTipoMatrice=0;
	private int idTipoAnalisi=0;
	private String nomeCampo="";
	private String tipoCampo="";
	private String codiceCampo="";
	
public DatasetCampionamentoDTO() {}
	public DatasetCampionamentoDTO(int int1) {
		
		id=int1;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getNomeCampo() {
		return nomeCampo;
	}
	public void setNomeCampo(String nomeCampo) {
		this.nomeCampo = nomeCampo;
	}
	public String getTipoCampo() {
		return tipoCampo;
	}
	public void setTipoCampo(String tipoCampo) {
		this.tipoCampo = tipoCampo;
	}
	public String getCodiceCampo() {
		return codiceCampo;
	}
	public int getIdTipoMatrice() {
		return idTipoMatrice;
	}
	public void setIdTipoMatrice(int idTipoMatrice) {
		this.idTipoMatrice = idTipoMatrice;
	}
	public int getIdTipoAnalisi() {
		return idTipoAnalisi;
	}
	public void setIdTipoAnalisi(int idTipoAnalisi) {
		this.idTipoAnalisi = idTipoAnalisi;
	}
	public void setCodiceCampo(String codiceCampo) {
		this.codiceCampo = codiceCampo;
	}


	
}
