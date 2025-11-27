package it.portaleSTI.DTO;
import java.util.Date;

public class AmScScadenzarioDTO {
    private Integer id;
    private AmScAttrezzaturaDTO attrezzatura;
    private AmScAttivitaDTO attivita;
    private Integer frequenza;
    private Date dataAttivita;
    private Date dataProssimaAttivita;
    private String esito;
    private String note;
    private UtenteDTO utente;

    private int tipo;
    // Getter e Setter
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public AmScAttrezzaturaDTO getAttrezzatura() {
        return attrezzatura;
    }

    public void setAttrezzatura(AmScAttrezzaturaDTO attrezzatura) {
        this.attrezzatura = attrezzatura;
    }

    public AmScAttivitaDTO getAttivita() {
        return attivita;
    }

    public void setAttivita(AmScAttivitaDTO attivita) {
        this.attivita = attivita;
    }

    public Integer getFrequenza() {
        return frequenza;
    }

    public void setFrequenza(Integer frequenza) {
        this.frequenza = frequenza;
    }

    public Date getDataAttivita() {
        return dataAttivita;
    }

    public void setDataAttivita(Date dataAttivita) {
        this.dataAttivita = dataAttivita;
    }

    public Date getDataProssimaAttivita() {
        return dataProssimaAttivita;
    }

    public void setDataProssimaAttivita(Date dataProssimaAttivita) {
        this.dataProssimaAttivita = dataProssimaAttivita;
    }

    public String getEsito() {
        return esito;
    }

    public void setEsito(String esito) {
        this.esito = esito;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

	public UtenteDTO getUtente() {
		return utente;
	}

	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
    
    
}
