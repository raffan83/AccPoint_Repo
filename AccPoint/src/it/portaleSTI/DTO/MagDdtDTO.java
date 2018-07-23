package it.portaleSTI.DTO;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

public class MagDdtDTO implements Serializable{
	
	private int id;
	private String spedizioniere;
	private MagTipoDdtDTO tipo_ddt;
	private String link_pdf;
	private String nome_destinazione;
	private Date data_ddt;
	private String numero_ddt;
	//private String causale_ddt;
	private String note;
	private MagTipoTrasportoDTO tipo_trasporto;
	private MagTipoPortoDTO tipo_porto;
	private MagAspettoDTO aspetto;
	private String annotazioni;
	private Date data_trasporto;
	private Time ora_trasporto;
	private int colli;
	private String operatore_trasporto;
	private Double peso;
	private String magazzino;
	
	private ClienteDTO cliente;
	private String cortese_attenzione;
	private Integer id_destinatario;
	private Integer id_sede_destinatario;
	private Integer id_destinazione;
	private Integer id_sede_destinazione;
	private MagCausaleDTO causale;

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSpedizioniere() {
		return spedizioniere;
	}
	public void setSpedizioniere(String spedizioniere) {
		this.spedizioniere = spedizioniere;
	}
	public MagTipoDdtDTO getTipo_ddt() {
		return tipo_ddt;
	}
	public void setTipo_ddt(MagTipoDdtDTO tipo_ddt) {
		this.tipo_ddt = tipo_ddt;
	}
	public String getLink_pdf() {
		return link_pdf;
	}
	public void setLink_pdf(String link_pdf) {
		this.link_pdf = link_pdf;
	}
	public String getNome_destinazione() {
		return nome_destinazione;
	}
	public void setNome_destinazione(String nome_destinazione) {
		this.nome_destinazione = nome_destinazione;
	}

	public Date getData_ddt() {
		return data_ddt;
	}
	public void setData_ddt(Date data_ddt) {
		this.data_ddt = data_ddt;
	}
	public String getNumero_ddt() {
		return numero_ddt;
	}
	public void setNumero_ddt(String numero_ddt) {
		this.numero_ddt = numero_ddt;
	}

	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public MagTipoTrasportoDTO getTipo_trasporto() {
		return tipo_trasporto;
	}
	public void setTipo_trasporto(MagTipoTrasportoDTO tipo_trasporto) {
		this.tipo_trasporto = tipo_trasporto;
	}
	public MagTipoPortoDTO getTipo_porto() {
		return tipo_porto;
	}
	public void setTipo_porto(MagTipoPortoDTO tipo_porto) {
		this.tipo_porto = tipo_porto;
	}
	public MagAspettoDTO getAspetto() {
		return aspetto;
	}
	public void setAspetto(MagAspettoDTO aspetto) {
		this.aspetto = aspetto;
	}
	public String getAnnotazioni() {
		return annotazioni;
	}
	public void setAnnotazioni(String annotazioni) {
		this.annotazioni = annotazioni;
	}
	public Date getData_trasporto() {
		return data_trasporto;
	}
	public void setData_trasporto(Date data_trasporto) {
		this.data_trasporto = data_trasporto;
	}
	public Time getOra_trasporto() {
		return ora_trasporto;
	}
	public void setOra_trasporto(Time ora_trasporto) {
		this.ora_trasporto = ora_trasporto;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public int getColli() {
		return colli;
	}
	public void setColli(int colli) {
		this.colli = colli;
	}
	public String getOperatore_trasporto() {
		return operatore_trasporto;
	}
	public void setOperatore_trasporto(String operatore_trasporto) {
		this.operatore_trasporto = operatore_trasporto;
	}
	public Integer getId_destinatario() {
		return id_destinatario;
	}
	public void setId_destinatario(Integer id_destinatario) {
		this.id_destinatario = id_destinatario;
	}
	public Integer getId_sede_destinatario() {
		return id_sede_destinatario;
	}
	public void setId_sede_destinatario(Integer id_sede_destinatario) {
		this.id_sede_destinatario = id_sede_destinatario;
	}
	public Integer getId_destinazione() {
		return id_destinazione;
	}
	public void setId_destinazione(Integer id_destinazione) {
		this.id_destinazione = id_destinazione;
	}
	public Integer getId_sede_destinazione() {
		return id_sede_destinazione;
	}
	public void setId_sede_destinazione(Integer id_sede_destinazione) {
		this.id_sede_destinazione = id_sede_destinazione;
	}
	public String getCortese_attenzione() {
		return cortese_attenzione;
	}
	public void setCortese_attenzione(String cortese_attenzione) {
		this.cortese_attenzione = cortese_attenzione;
	}
	public MagCausaleDTO getCausale() {
		return causale;
	}
	public void setCausale(MagCausaleDTO causale) {
		this.causale = causale;
	}
	public Double getPeso() {
		return peso;
	}
	public void setPeso(Double peso) {
		this.peso = peso;
	}
	public String getMagazzino() {
		return magazzino;
	}
	public void setMagazzino(String magazzino) {
		this.magazzino = magazzino;
	}




}
