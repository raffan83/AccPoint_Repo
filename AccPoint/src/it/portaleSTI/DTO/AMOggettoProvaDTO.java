package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class AMOggettoProvaDTO {

 

	private int id;

    private String tipo;
    private String volume;
    private String pressione;
    private String costruttore;
    private String nFabbrica;
    private int anno;
    private String matricola;
    private String descrizione;
    private Date dataVerifica;
    private Date dataProssimaVerifica;
    private int frequenza;
    private Integer id_cliente;
	private Integer id_sede;
    private String sondaVelocita;
    private String nomeClienteUtilizzatore;
    private String nomeSedeUtilizzatore;
    private String filename_img;
    private int numero_porzioni;
    private  Set<AMOggettoProvaZonaRifDTO> listaZoneRiferimento = new HashSet<AMOggettoProvaZonaRifDTO>(0);
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getVolume() {
		return volume;
	}
	public void setVolume(String volume) {
		this.volume = volume;
	}
	public String getPressione() {
		return pressione;
	}
	public void setPressione(String pressione) {
		this.pressione = pressione;
	}
	public String getCostruttore() {
		return costruttore;
	}
	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}
	public String getnFabbrica() {
		return nFabbrica;
	}
	public void setnFabbrica(String nFabbrica) {
		this.nFabbrica = nFabbrica;
	}
	public int getAnno() {
		return anno;
	}
	public void setAnno(int anno) {
		this.anno = anno;
	}
	public String getMatricola() {
		return matricola;
	}
	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public Date getDataVerifica() {
		return dataVerifica;
	}
	public void setDataVerifica(Date dataVerifica) {
		this.dataVerifica = dataVerifica;
	}
	public Date getDataProssimaVerifica() {
		return dataProssimaVerifica;
	}
	public void setDataProssimaVerifica(Date dataProssimaVerifica) {
		this.dataProssimaVerifica = dataProssimaVerifica;
	}
	public int getFrequenza() {
		return frequenza;
	}
	public void setFrequenza(int frequenza) {
		this.frequenza = frequenza;
	}
	public Integer getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(Integer id_cliente) {
		this.id_cliente = id_cliente;
	}
	public Integer getId_sede() {
		return id_sede;
	}
	public void setId_sede(Integer id_sede) {
		this.id_sede = id_sede;
	}
	public String getSondaVelocita() {
		return sondaVelocita;
	}
	public void setSondaVelocita(String sondaVelocita) {
		this.sondaVelocita = sondaVelocita;
	}
	public String getNomeClienteUtilizzatore() {
		return nomeClienteUtilizzatore;
	}
	public void setNomeClienteUtilizzatore(String nomeClienteUtilizzatore) {
		this.nomeClienteUtilizzatore = nomeClienteUtilizzatore;
	}
	public String getNomeSedeUtilizzatore() {
		return nomeSedeUtilizzatore;
	}
	public void setNomeSedeUtilizzatore(String nomeSedeUtilizzatore) {
		this.nomeSedeUtilizzatore = nomeSedeUtilizzatore;
	}
	public String getFilename_img() {
		return filename_img;
	}
	public void setFilename_img(String filename_img) {
		this.filename_img = filename_img;
	}
	public int getNumero_porzioni() {
		return numero_porzioni;
	}
	public void setNumero_porzioni(int numero_porzioni) {
		this.numero_porzioni = numero_porzioni;
	}
	public Set<AMOggettoProvaZonaRifDTO> getListaZoneRiferimento() {
		return listaZoneRiferimento;
	}
	public void setListaZoneRiferimento(Set<AMOggettoProvaZonaRifDTO> listaZoneRiferimento) {
		this.listaZoneRiferimento = listaZoneRiferimento;
	}
    
    
    
}
