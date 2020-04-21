package it.portaleSTI.DTO;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

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

	private String seqRisposte;
	
	private int numeroSigilli;
	
	private Set<VerDecentramentoDTO> listaPuntiDecentramento = new LinkedHashSet<VerDecentramentoDTO>(0);
	
	private Set<VerRipetibilitaDTO> listaPuntiRipetibilita = new LinkedHashSet<VerRipetibilitaDTO>(0);
	
	private Set<VerLinearitaDTO> listaPuntiLinearita = new LinkedHashSet<VerLinearitaDTO>(0);
	
	private Set<VerAccuratezzaDTO> listaPuntiAccuratezza = new LinkedHashSet<VerAccuratezzaDTO>(0);
	
	private Set<VerMobilitaDTO> listaPuntiMobilita = new LinkedHashSet<VerMobilitaDTO>(0);
	
	private String campioniLavoro;
	
	private VerTipoVerificaDTO tipo_verifica;
	
	private VerMotivoVerificaDTO motivo_verifica;
		
	private String is_difetti;
	
	private byte[] file_inizio_prova;
	
	private String nomeFile_inizio_prova;
	
	private byte[] file_fine_prova;
	
	
	private String nomeFile_fine_prova;
	
	private String comunicazione_preventiva;
	
	private String comunicazione_esito;
	
	private String note_obsolescenza;
	
	private String obsoleta;
	
	private int esito;
	
		public String getNote_obsolescenza() {
		return note_obsolescenza;
	}

	public void setNote_obsolescenza(String note_obsolescenza) {
		this.note_obsolescenza = note_obsolescenza;
	}

	public String getObsoleta() {
		return obsoleta;
	}

	public void setObsoleta(String obsoleta) {
		this.obsoleta = obsoleta;
	}

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

	public String getSeqRisposte() {
		return this.seqRisposte;
	}

	public void setSeqRisposte(String seqRisposte) {
		this.seqRisposte = seqRisposte;
	}

	public String getCampioniLavoro() {
		return campioniLavoro;
	}

	public void setCampioniLavoro(String campioniLavoro) {
		this.campioniLavoro = campioniLavoro;
	}
	
	public VerTipoVerificaDTO getTipo_verifica() {
		return tipo_verifica;
	}

	public void setTipo_verifica(VerTipoVerificaDTO tipo_verifica) {
		this.tipo_verifica = tipo_verifica;
	}

	public VerMotivoVerificaDTO getMotivo_verifica() {
		return motivo_verifica;
	}

	public void setMotivo_verifica(VerMotivoVerificaDTO motivo_verifica) {
		this.motivo_verifica = motivo_verifica;
	}

	public String getIs_difetti() {
		return is_difetti;
	}

	public void setIs_difetti(String is_difetti) {
		this.is_difetti = is_difetti;
	}

	public Set<VerDecentramentoDTO> getListaPuntiDecentramento() {
		return listaPuntiDecentramento;
	}

	public void setListaPuntiDecentramento(Set<VerDecentramentoDTO> listaPuntiDecentramento) {
		this.listaPuntiDecentramento = listaPuntiDecentramento;
	}

	public Set<VerRipetibilitaDTO> getListaPuntiRipetibilita() {
		return listaPuntiRipetibilita;
	}

	public void setListaPuntiRipetibilita(Set<VerRipetibilitaDTO> listaPuntiRipetibilita) {
		this.listaPuntiRipetibilita = listaPuntiRipetibilita;
	}

	public Set<VerLinearitaDTO> getListaPuntiLinearita() {
		return listaPuntiLinearita;
	}

	public void setListaPuntiLinearita(Set<VerLinearitaDTO> listaPuntiLinearita) {
		this.listaPuntiLinearita = listaPuntiLinearita;
	}

	public Set<VerAccuratezzaDTO> getListaPuntiAccuratezza() {
		return listaPuntiAccuratezza;
	}

	public void setListaPuntiAccuratezza(Set<VerAccuratezzaDTO> listaPuntiAccuratezza) {
		this.listaPuntiAccuratezza = listaPuntiAccuratezza;
	}

	public Set<VerMobilitaDTO> getListaPuntiMobilita() {
		return listaPuntiMobilita;
	}

	public void setListaPuntiMobilita(Set<VerMobilitaDTO> listaPuntiMobilita) {
		this.listaPuntiMobilita = listaPuntiMobilita;
	}

	public byte[] getFile_inizio_prova() {
		return file_inizio_prova;
	}

	public void setFile_inizio_prova(byte[] file_inizio_prova) {
		this.file_inizio_prova = file_inizio_prova;
	}


	public int getNumeroSigilli() {
		return numeroSigilli;
	}

	public void setNumeroSigilli(int numeroSigiilli) {
		this.numeroSigilli = numeroSigiilli;
	}

	public byte[] getFile_fine_prova() {
		return file_fine_prova;
	}

	public void setFile_fine_prova(byte[] file_fine_prova) {
		this.file_fine_prova = file_fine_prova;
	}

	public String getNomeFile_inizio_prova() {
		return nomeFile_inizio_prova;
	}

	public void setNomeFile_inizio_prova(String nomeFile_inizio_prova) {
		this.nomeFile_inizio_prova = nomeFile_inizio_prova;
	}

	public String getNomeFile_fine_prova() {
		return nomeFile_fine_prova;
	}

	public void setNomeFile_fine_prova(String nomeFile_fine_prova) {
		this.nomeFile_fine_prova = nomeFile_fine_prova;
	}

	public String getComunicazione_preventiva() {
		return comunicazione_preventiva;
	}

	public void setComunicazione_preventiva(String comunicazione_preventiva) {
		this.comunicazione_preventiva = comunicazione_preventiva;
	}

	public String getComunicazione_esito() {
		return comunicazione_esito;
	}

	public void setComunicazione_esito(String comunicazione_esito) {
		this.comunicazione_esito = comunicazione_esito;
	}

	public int getEsito() {
		return esito;
	}

	public void setEsito(int esito) {
		this.esito = esito;
	}
	
	
	
}

