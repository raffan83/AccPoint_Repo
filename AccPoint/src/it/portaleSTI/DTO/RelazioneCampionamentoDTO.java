package it.portaleSTI.DTO;

public class RelazioneCampionamentoDTO {

	private int id;
	private TipoMatriceDTO matrice;
	private TipologiaCampionamentoDTO tipologiaCampionamento;
	private String nomeRelazione;
	private String procedura;
	private String scheda;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TipoMatriceDTO getMatrice() {
		return matrice;
	}
	public void setMatrice(TipoMatriceDTO matrice) {
		this.matrice = matrice;
	}
	public TipologiaCampionamentoDTO getTipologiaCampionamento() {
		return tipologiaCampionamento;
	}
	public void setTipologiaCampionamento(TipologiaCampionamentoDTO tipologiaCampionamento) {
		this.tipologiaCampionamento = tipologiaCampionamento;
	}
	public String getNomeRelazione() {
		return nomeRelazione;
	}
	public void setNomeRelazione(String nomeRelazione) {
		this.nomeRelazione = nomeRelazione;
	}
	public String getProcedura() {
		return procedura;
	}
	public void setProcedura(String procedura) {
		this.procedura = procedura;
	}
	public String getScheda() {
		return scheda;
	}
	public void setScheda(String scheda) {
		this.scheda = scheda;
	}
	
	
}
