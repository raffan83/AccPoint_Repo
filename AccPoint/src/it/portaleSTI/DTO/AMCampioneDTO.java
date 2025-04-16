package it.portaleSTI.DTO;

import java.util.Date;

public class AMCampioneDTO {

    private int id;
    private String rilevatoreOut;
    private String matricolaRilevatoreOut;
    private String mezzoAccoppiante;
    private String bloccoRiferimento;
    private String sondaCostruttore;
    private String sondaModello;
    private String sondaMatricola;
    private String sondaFrequenza;
    private String sondaDimensione;
    private String sondaAngolo;
    private String sondaVelocita;
    private String certificato;
    private Date dataScadenzaCertifica;

    // Getter e Setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRilevatoreOut() {
        return rilevatoreOut;
    }

    public void setRilevatoreOut(String rilevatoreOut) {
        this.rilevatoreOut = rilevatoreOut;
    }

    public String getMatricolaRilevatoreOut() {
        return matricolaRilevatoreOut;
    }

    public void setMatricolaRilevatoreOut(String matricolaRilevatoreOut) {
        this.matricolaRilevatoreOut = matricolaRilevatoreOut;
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

    public String getCertificato() {
        return certificato;
    }

    public void setCertificato(String certificato) {
        this.certificato = certificato;
    }

    public Date getDataScadenzaCertifica() {
        return dataScadenzaCertifica;
    }

    public void setDataScadenzaCertifica(Date dataScadenzaCertifica) {
        this.dataScadenzaCertifica = dataScadenzaCertifica;
    }
}
