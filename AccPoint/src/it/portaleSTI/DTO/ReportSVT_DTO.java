package it.portaleSTI.DTO;

import java.util.List;
import java.util.Map;

public class ReportSVT_DTO {
	private List<Map<String, Object>> tipoVerifica;
	private List<Map<String, Object>> unitaDiMisura;
	private List<Map<String, Object>> valoreCampione;
	private String valoreMedioCampione = "";
	private List<Map<String, Object>> valoreStrumento;
	private String valoreMedioStrumento = "";
	private String scostamento_correzione = "";
	private String accettabilita = "";
	private String incertezza = "";
	private String esito = "";
	private String tipoProva = "";
	private String asLeftAsFound = "";
	private boolean nonApplicabile;
	private String descrizioneCampione;
	
	public List<Map<String, Object>> getTipoVerifica() {
		return tipoVerifica;
	}
	public void setTipoVerifica(List<Map<String, Object>> tipoVerifica) {
		this.tipoVerifica = tipoVerifica;
	}
	public List<Map<String, Object>> getUnitaDiMisura() {
		return unitaDiMisura;
	}
	public void setUnitaDiMisura(List<Map<String, Object>> unitaDiMisura) {
		this.unitaDiMisura = unitaDiMisura;
	}
	public List<Map<String, Object>> getValoreCampione() {
		return valoreCampione;
	}
	public void setValoreCampione(List<Map<String, Object>> valoreCampione) {
		this.valoreCampione = valoreCampione;
	}
	public String getValoreMedioCampione() {
		return valoreMedioCampione;
	}
	public void setValoreMedioCampione(String valoreMedioCampione) {
		this.valoreMedioCampione = valoreMedioCampione;
	}
	public List<Map<String, Object>> getValoreStrumento() {
		return valoreStrumento;
	}
	public void setValoreStrumento(List<Map<String, Object>> valoreStrumento) {
		this.valoreStrumento = valoreStrumento;
	}
	public String getValoreMedioStrumento() {
		return valoreMedioStrumento;
	}
	public void setValoreMedioStrumento(String valoreMedioStrumento) {
		this.valoreMedioStrumento = valoreMedioStrumento;
	}
	public String getScostamento_correzione() {
		return scostamento_correzione;
	}
	public void setScostamento_correzione(String scostamento_correzione) {
		this.scostamento_correzione = scostamento_correzione;
	}
	public String getAccettabilita() {
		return accettabilita;
	}
	public void setAccettabilita(String accettabilita) {
		this.accettabilita = accettabilita;
	}
	public String getIncertezza() {
		return incertezza;
	}
	public void setIncertezza(String incertezza) {
		this.incertezza = incertezza;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	public String getTipoProva() {
		return tipoProva;
	}
	public void setTipoProva(String tipoProva) {
		this.tipoProva = tipoProva;
	}
	public String getAsLeftAsFound() {
		return asLeftAsFound;
	}
	public void setAsLeftAsFound(String asLeftAsFound) {
		this.asLeftAsFound = asLeftAsFound;
	}
	public boolean isNonApplicabile() {
		return nonApplicabile;
	}
	public void setNonApplicabile(boolean nonApplicabile) {
		this.nonApplicabile = nonApplicabile;
	}
	public String getDescrizioneCampione() {
		return descrizioneCampione;
	}
	public void setDescrizioneCampione(String descrizioneCampione) {
		this.descrizioneCampione = descrizioneCampione;
	}

	
}
