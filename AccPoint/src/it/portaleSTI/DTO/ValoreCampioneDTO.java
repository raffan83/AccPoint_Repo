package it.portaleSTI.DTO;

public class ValoreCampioneDTO {
	
	private int id;
	private Float valore_nominale;
	private Float valore_taratura;
	private Float incertezza_assoluta;
	private Float incertezza_relativa;
	private String parametri_taratura;
	private CampioneDTO campione;
	private UnitaMisuraDTO unita_misura;
	private int interpolato;
	private Integer valore_composto;
	private float divisione_UM;
	private TipoGrandezzaDTO tipo_grandezza;
	private String obsoleto;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Float getValore_nominale() {
		return valore_nominale;
	}
	public void setValore_nominale(Float valore_nominale) {
		this.valore_nominale = valore_nominale;
	}
	public Float getValore_taratura() {
		return valore_taratura;
	}
	public void setValore_taratura(Float valore_taratura) {
		this.valore_taratura = valore_taratura;
	}
	public Float getIncertezza_assoluta() {
		return incertezza_assoluta;
	}
	public void setIncertezza_assoluta(Float incertezza_assoluta) {
		this.incertezza_assoluta = incertezza_assoluta;
	}
	public Float getIncertezza_relativa() {
		return incertezza_relativa;
	}
	public void setIncertezza_relativa(Float incertezza_relativa) {
		this.incertezza_relativa = incertezza_relativa;
	}
	public String getParametri_taratura() {
		return parametri_taratura;
	}
	public void setParametri_taratura(String parametri_taratura) {
		this.parametri_taratura = parametri_taratura;
	}
	public CampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(CampioneDTO campione) {
		this.campione = campione;
	}
	public UnitaMisuraDTO getUnita_misura() {
		return unita_misura;
	}
	public void setUnita_misura(UnitaMisuraDTO unita_misura) {
		this.unita_misura = unita_misura;
	}
	public int getInterpolato() {
		return interpolato;
	}
	public void setInterpolato(int interpolato) {
		this.interpolato = interpolato;
	}
	public Integer getValore_composto() {
		return valore_composto;
	}
	public void setValore_composto(Integer valore_composto) {
		this.valore_composto = valore_composto;
	}
	public float getDivisione_UM() {
		return divisione_UM;
	}
	public void setDivisione_UM(float divisione_UM) {
		this.divisione_UM = divisione_UM;
	}
	public TipoGrandezzaDTO getTipo_grandezza() {
		return tipo_grandezza;
	}
	public void setTipo_grandezza(TipoGrandezzaDTO tipo_grandezza) {
		this.tipo_grandezza = tipo_grandezza;
	}
	public String getObsoleto() {
		return obsoleto;
	}
	public void setObsoleto(String obsoleto) {
		this.obsoleto = obsoleto;
	}
	
	
	
	
}
