package it.portaleSTI.DTO;

import java.util.Date;
import java.util.List;

public class VerMisuraDTO {

	private static final long serialVersionUID = 1L;

	
	private int id;

	private Date dataRiparazione;

	private Date dataScadenza;

	private Date dataVerificazione;

	
	private int idNonConforme;

	
	private UtenteDTO tecnicoVerificatore;


	private VerInterventoDTO verIntervento;

	
	private VerStrumentoDTO verStrumento;
	
	private String nomeRiparatore;

	private String numeroAttestato;

	private String numeroRapporto;

	private String procedura;

	private String registro;

	
	private String seqRisposte;
	

	private List<VerDecentramentoDTO> verDecentramentos;

	private List<VerRipetibilitaDTO> verRipetibilitas;
	
	private List<VerAccuratezzaDTO> verAccuratezzas;
	
	private List<VerMobilitaDTO> verMobilitas;
	
	private List<VerLinearitaDTO> verLinearitas;
	
	private String campioniLavoro;

	public VerMisuraDTO() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDataRiparazione() {
		return this.dataRiparazione;
	}

	public void setDataRiparazione(Date dataRiparazione) {
		this.dataRiparazione = dataRiparazione;
	}

	public Date getDataScadenza() {
		return this.dataScadenza;
	}

	public void setDataScadenza(Date dataScadenza) {
		this.dataScadenza = dataScadenza;
	}

	public Date getDataVerificazione() {
		return this.dataVerificazione;
	}

	public void setDataVerificazione(Date dataVerificazione) {
		this.dataVerificazione = dataVerificazione;
	}

	public int getIdNonConforme() {
		return this.idNonConforme;
	}

	public void setIdNonConforme(int idNonConforme) {
		this.idNonConforme = idNonConforme;
	}

	public UtenteDTO getTecnicoVerificatore() {
		return this.tecnicoVerificatore;
	}

	public void setTecnicoVerificatore(UtenteDTO idTecnicoVerificatore) {
		this.tecnicoVerificatore = idTecnicoVerificatore;
	}

	public VerInterventoDTO getVerIntervento() {
		return this.verIntervento;
	}

	public void setVerIntervento(VerInterventoDTO idVerIntervento) {
		this.verIntervento = idVerIntervento;
	}

	public VerStrumentoDTO getVerStrumento() {
		return this.verStrumento;
	}

	public void setVerStrumento(VerStrumentoDTO idVerStrumento) {
		this.verStrumento = idVerStrumento;
	}

	public String getNomeRiparatore() {
		return this.nomeRiparatore;
	}

	public void setNomeRiparatore(String nomeRiparatore) {
		this.nomeRiparatore = nomeRiparatore;
	}

	public String getNumeroAttestato() {
		return this.numeroAttestato;
	}

	public void setNumeroAttestato(String numeroAttestato) {
		this.numeroAttestato = numeroAttestato;
	}

	public String getNumeroRapporto() {
		return this.numeroRapporto;
	}

	public void setNumeroRapporto(String numeroRapporto) {
		this.numeroRapporto = numeroRapporto;
	}

	public String getProcedura() {
		return this.procedura;
	}

	public void setProcedura(String procedura) {
		this.procedura = procedura;
	}

	public String getRegistro() {
		return this.registro;
	}

	public void setRegistro(String registro) {
		this.registro = registro;
	}

	public String getSeqRisposte() {
		return this.seqRisposte;
	}

	public void setSeqRisposte(String seqRisposte) {
		this.seqRisposte = seqRisposte;
	}

	public List<VerDecentramentoDTO> getVerDecentramentos() {
		return this.verDecentramentos;
	}

	public void setVerDecentramentos(List<VerDecentramentoDTO> verDecentramentos) {
		this.verDecentramentos = verDecentramentos;
	}

	public VerDecentramentoDTO addVerDecentramento(VerDecentramentoDTO verDecentramento) {
		getVerDecentramentos().add(verDecentramento);
		verDecentramento.setVerMisura(this);

		return verDecentramento;
	}

	public VerDecentramentoDTO removeVerDecentramento(VerDecentramentoDTO verDecentramento) {
		getVerDecentramentos().remove(verDecentramento);
		verDecentramento.setVerMisura(null);

		return verDecentramento;
	}

	public List<VerRipetibilitaDTO> getVerRipetibilitas() {
		return this.verRipetibilitas;
	}

	public void setVerRipetibilitas(List<VerRipetibilitaDTO> verRipetibilitas) {
		this.verRipetibilitas = verRipetibilitas;
	}

	public VerRipetibilitaDTO addVerRipetibilita(VerRipetibilitaDTO verRipetibilita) {
		getVerRipetibilitas().add(verRipetibilita);
		verRipetibilita.setVerMisura(this);

		return verRipetibilita;
	}

	public VerRipetibilitaDTO removeVerRipetibilita(VerRipetibilitaDTO verRipetibilita) {
		getVerRipetibilitas().remove(verRipetibilita);
		verRipetibilita.setVerMisura(null);

		return verRipetibilita;
	}

	public List<VerAccuratezzaDTO> getVerAccuratezzas() {
		return verAccuratezzas;
	}

	public void setVerAccuratezzas(List<VerAccuratezzaDTO> verAccuratezzas) {
		this.verAccuratezzas = verAccuratezzas;
	}

	public List<VerMobilitaDTO> getVerMobilitas() {
		return verMobilitas;
	}

	public void setVerMobilitas(List<VerMobilitaDTO> verMobilitas) {
		this.verMobilitas = verMobilitas;
	}

	public List<VerLinearitaDTO> getVerLinearitas() {
		return verLinearitas;
	}

	public void setVerLinearitas(List<VerLinearitaDTO> verLinearitas) {
		this.verLinearitas = verLinearitas;
	}

	public String getCampioniLavoro() {
		return campioniLavoro;
	}

	public void setCampioniLavoro(String campioniLavoro) {
		this.campioniLavoro = campioniLavoro;
	}
}
