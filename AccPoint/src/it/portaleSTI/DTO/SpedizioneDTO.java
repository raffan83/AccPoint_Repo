package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class SpedizioneDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;
    private String id_pacco;
    private String destinatario;
    private String presso;
    private String corriere;
    private String referente;
    private String telefono;
    private String indirizzo;
    private String cap;
    private String citta;
    private String provincia;
    private String nazione;
    private String note;
    private Date data_spedizione;
    private String codice_tracking;
    private MagDdtDTO ddt;
    private StatoSpedizioneDTO stato;

    public SpedizioneDTO() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getId_pacco() {
        return id_pacco;
    }

    public void setId_pacco(String id_pacco) {
        this.id_pacco = id_pacco;
    }

    public String getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }

    public String getPresso() {
        return presso;
    }

    public void setPresso(String presso) {
        this.presso = presso;
    }

    public String getCorriere() {
        return corriere;
    }

    public void setCorriere(String corriere) {
        this.corriere = corriere;
    }

    public String getReferente() {
        return referente;
    }

    public void setReferente(String referente) {
        this.referente = referente;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getCap() {
        return cap;
    }

    public void setCap(String cap) {
        this.cap = cap;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getNazione() {
        return nazione;
    }

    public void setNazione(String nazione) {
        this.nazione = nazione;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getData_spedizione() {
        return data_spedizione;
    }

    public void setData_spedizione(Date data_spedizione) {
        this.data_spedizione = data_spedizione;
    }

    public String getCodice_tracking() {
        return codice_tracking;
    }

    public void setCodice_tracking(String codice_tracking) {
        this.codice_tracking = codice_tracking;
    }

   public MagDdtDTO getDdt() {
    return ddt;
}
   public void setDdt(MagDdtDTO ddt) {
    this.ddt = ddt;
}

public StatoSpedizioneDTO getStato() {
	return stato;
}

public void setStato(StatoSpedizioneDTO stato) {
	this.stato= stato;
}
   
   
}
