package it.portaleSTI.DTO;

import java.util.Date;

public class AMCampioneDTO {

    public int id;
    public AMTipoCampioneDTO tipoCampione;
    public String codiceInterno;
    public String denominazione;
    public String matricola;
    public String modello;
    public String costruttore;
    public String nCertificato;
    public Date dataTaratura;
    public int frequenza;
    public Date dataScadenzaCertifica;
    public String rilevatoreOut;
    public String mezzoAccoppiante;
    public String bloccoRiferimento;
    public String sondaCostruttore;
    public String sondaModello;
    public String sondaMatricola;
    public String sondaFrequenza;
    public String sondaDimensione;
    public String sondaAngolo;
    public String sondaVelocita;

    public String spessorePunta;
    public String larghezzaManico;
    public String misurazioneMassima;
    
    // Getter e Setter
    
    

    public int getId() {
        return id;
    }

    public String getSpessorePunta() {
		return spessorePunta;
	}

	public void setSpessorePunta(String spessorePunta) {
		this.spessorePunta = spessorePunta;
	}

	public String getLarghezzaManico() {
		return larghezzaManico;
	}

	public void setLarghezzaManico(String larghezzaManico) {
		this.larghezzaManico = larghezzaManico;
	}

	public String getMisurazioneMassima() {
		return misurazioneMassima;
	}

	public void setMisurazioneMassima(String misurazioneMassima) {
		this.misurazioneMassima = misurazioneMassima;
	}

	public void setId(int id) {
        this.id = id;
    }

    public AMTipoCampioneDTO getTipoCampione() {
		return tipoCampione;
	}

	public void setTipoCampione(AMTipoCampioneDTO tipoCampione) {
		this.tipoCampione = tipoCampione;
	}

	public String getCodiceInterno() {
        return codiceInterno;
    }

    public void setCodiceInterno(String codiceInterno) {
        this.codiceInterno = codiceInterno;
    }

    public String getDenominazione() {
        return denominazione;
    }

    public void setDenominazione(String denominazione) {
        this.denominazione = denominazione;
    }

    public String getMatricola() {
        return matricola;
    }

    public void setMatricola(String matricola) {
        this.matricola = matricola;
    }

    public String getModello() {
        return modello;
    }

    public void setModello(String modello) {
        this.modello = modello;
    }

    public String getCostruttore() {
        return costruttore;
    }

    public void setCostruttore(String costruttore) {
        this.costruttore = costruttore;
    }

    public String getnCertificato() {
        return nCertificato;
    }

    public void setnCertificato(String nCertificato) {
        this.nCertificato = nCertificato;
    }

    public Date getDataTaratura() {
        return dataTaratura;
    }

    public void setDataTaratura(Date dataTaratura) {
        this.dataTaratura = dataTaratura;
    }

    public int getFrequenza() {
        return frequenza;
    }

    public void setFrequenza(int frequenza) {
        this.frequenza = frequenza;
    }

    public Date getDataScadenzaCertifica() {
        return dataScadenzaCertifica;
    }

    public void setDataScadenzaCertifica(Date dataScadenzaCertifica) {
        this.dataScadenzaCertifica = dataScadenzaCertifica;
    }

    public String getRilevatoreOut() {
        return rilevatoreOut;
    }

    public void setRilevatoreOut(String rilevatoreOut) {
        this.rilevatoreOut = rilevatoreOut;
    }

    public String getMezzoAccoppiante() {
        return mezzoAccoppiante;
    }

    public void setMezzoAccoppiante(String mezzoAccoppiante) {
        this.mezzoAccoppiante = mezzoAccoppiante;
    }

    public String getBloccoRiferimento() {
        return bloccoRiferimento;
    }

    public void setBloccoRiferimento(String bloccoRiferimento) {
        this.bloccoRiferimento = bloccoRiferimento;
    }

    public String getSondaCostruttore() {
        return sondaCostruttore;
    }

    public void setSondaCostruttore(String sondaCostruttore) {
        this.sondaCostruttore = sondaCostruttore;
    }

    public String getSondaModello() {
        return sondaModello;
    }

    public void setSondaModello(String sondaModello) {
        this.sondaModello = sondaModello;
    }

    public String getSondaMatricola() {
        return sondaMatricola;
    }

    public void setSondaMatricola(String sondaMatricola) {
        this.sondaMatricola = sondaMatricola;
    }

    public String getSondaFrequenza() {
        return sondaFrequenza;
    }

    public void setSondaFrequenza(String sondaFrequenza) {
        this.sondaFrequenza = sondaFrequenza;
    }

    public String getSondaDimensione() {
        return sondaDimensione;
    }

    public void setSondaDimensione(String sondaDimensione) {
        this.sondaDimensione = sondaDimensione;
    }

    public String getSondaAngolo() {
        return sondaAngolo;
    }

    public void setSondaAngolo(String sondaAngolo) {
        this.sondaAngolo = sondaAngolo;
    }

    public String getSondaVelocita() {
        return sondaVelocita;
    }

    public void setSondaVelocita(String sondaVelocita) {
        this.sondaVelocita = sondaVelocita;
    }
}
