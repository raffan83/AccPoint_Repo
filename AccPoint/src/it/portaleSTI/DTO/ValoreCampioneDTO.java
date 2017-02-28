package it.portaleSTI.DTO;

public class ValoreCampioneDTO {
	
	private int id;
	private Float valore_nominale;
	private Float valore_taratura;
	private Float incertezza_assoluta;
	private Float incertezza_relativa;
	private String parametri_taratura;
	private int id_campione;
	private int id_unita_misura;
	private String unita_misura;
	private int interpolato;
	private Integer valore_composto;
	private float divisione_UM;
	private int id_tipo_grandezza;
	private String tipo_grandezza;
	
	
	
	public String getUnita_misura() {
		return unita_misura;
	}


	public void setUnita_misura(String unita_misura) {
		this.unita_misura = unita_misura;
	}


	public String getTipo_grandezza() {
		return tipo_grandezza;
	}


	public void setTipo_grandezza(String tipo_grandezza) {
		this.tipo_grandezza = tipo_grandezza;
	}


	public ValoreCampioneDTO(){}


	public ValoreCampioneDTO(int id, Float valore_nominale,
			Float valore_taratura, Float incertezza_assoluta,
			Float incertezza_relativa, String parametri_taratura,
			int id_campione, int id_unita_misura, int interpolato,
			Integer valore_composto, float divisione_UM, int id_tipo_grandezza) {
		super();
		this.id = id;
		this.valore_nominale = valore_nominale;
		this.valore_taratura = valore_taratura;
		this.incertezza_assoluta = incertezza_assoluta;
		this.incertezza_relativa = incertezza_relativa;
		this.parametri_taratura = parametri_taratura;
		this.id_campione = id_campione;
		this.id_unita_misura = id_unita_misura;
		this.interpolato = interpolato;
		this.valore_composto = valore_composto;
		this.divisione_UM = divisione_UM;
		this.id_tipo_grandezza = id_tipo_grandezza;
	}


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


	public int getId_campione() {
		return id_campione;
	}


	public void setId_campione(int id_campione) {
		this.id_campione = id_campione;
	}


	public int getId_unita_misura() {
		return id_unita_misura;
	}


	public void setId_unita_misura(int id_unita_misura) {
		this.id_unita_misura = id_unita_misura;
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


	public int getId_tipo_grandezza() {
		return id_tipo_grandezza;
	}


	public void setId_tipo_grandezza(int id_tipo_grandezza) {
		this.id_tipo_grandezza = id_tipo_grandezza;
	};
	
	
	
	
	
}
