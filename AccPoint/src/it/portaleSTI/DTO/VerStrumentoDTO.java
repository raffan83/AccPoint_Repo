package it.portaleSTI.DTO;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class VerStrumentoDTO {
	
	private int id;
	private String denominazione;
	private String costruttore;
	private String modello;
	private String matricola;
	private int classe;
	private VerTipoStrumentoDTO tipo;
	private String um;
	private Date data_ultima_verifica;
	private Date data_prossima_verifica;
	private BigDecimal portata_min_C1;
	private BigDecimal portata_max_C1;
	private BigDecimal div_ver_C1;
	private BigDecimal div_rel_C1;
	private BigDecimal numero_div_C1;
	private BigDecimal portata_min_C2;
	private BigDecimal portata_max_C2;
	private BigDecimal div_ver_C2;
	private BigDecimal div_rel_C2;
	private BigDecimal numero_div_C2;
	private BigDecimal portata_min_C3;
	private BigDecimal portata_max_C3;
	private BigDecimal div_ver_C3;
	private BigDecimal div_rel_C3;
	private BigDecimal numero_div_C3;
	private int id_cliente;
	private int id_sede;
	private int anno_marcatura_ce;
	private Date data_messa_in_servizio;
	private VerTipologiaStrumentoDTO tipologia;
	private int freqMesi;
	private String creato;
	private String nome_cliente;
	private String nome_sede;
	private VerFamigliaStrumentoDTO famiglia_strumento;
	private Set<VerLegalizzazioneBilanceDTO> lista_legalizzazione_bilance= new HashSet<VerLegalizzazioneBilanceDTO>(0);;
	private String ultimo_verificatore;
	private int posizione_cambio;
	private String masse_corredo;
	private int tipo_indicazione;
	
	public String getCreato() {
		return creato;
	}
	public void setCreato(String creato) {
		this.creato = creato;
	}
	public int getFreqMesi() {
		return freqMesi;
	}
	public void setFreqMesi(int freqMesi) {
		this.freqMesi = freqMesi;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDenominazione() {
		return denominazione;
	}
	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}
	public String getCostruttore() {
		return costruttore;
	}
	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public String getMatricola() {
		return matricola;
	}
	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}
	public int getClasse() {
		return classe;
	}
	public void setClasse(int classe) {
		this.classe = classe;
	}
	public VerTipoStrumentoDTO getTipo() {
		return tipo;
	}
	public void setTipo(VerTipoStrumentoDTO tipo) {
		this.tipo = tipo;
	}
	public String getUm() {
		return um;
	}
	public void setUm(String um) {
		this.um = um;
	}
	public Date getData_ultima_verifica() {
		return data_ultima_verifica;
	}
	public void setData_ultima_verifica(Date data_ultima_verifica) {
		this.data_ultima_verifica = data_ultima_verifica;
	}
	public Date getData_prossima_verifica() {
		return data_prossima_verifica;
	}
	public void setData_prossima_verifica(Date data_prossima_verifica) {
		this.data_prossima_verifica = data_prossima_verifica;
	}
	public BigDecimal getPortata_min_C1() {
		return portata_min_C1;
	}
	public void setPortata_min_C1(BigDecimal portata_min_C1) {
		this.portata_min_C1 = portata_min_C1;
	}
	public BigDecimal getPortata_max_C1() {
		return portata_max_C1;
	}
	public void setPortata_max_C1(BigDecimal portata_max_C1) {
		this.portata_max_C1 = portata_max_C1;
	}
	public BigDecimal getDiv_ver_C1() {
		return div_ver_C1;
	}
	public void setDiv_ver_C1(BigDecimal div_ver_C1) {
		this.div_ver_C1 = div_ver_C1;
	}
	public BigDecimal getDiv_rel_C1() {
		return div_rel_C1;
	}
	public void setDiv_rel_C1(BigDecimal div_rel_C1) {
		this.div_rel_C1 = div_rel_C1;
	}
	public BigDecimal getNumero_div_C1() {
		return numero_div_C1;
	}
	public void setNumero_div_C1(BigDecimal numero_div_C1) {
		this.numero_div_C1 = numero_div_C1;
	}
	public BigDecimal getPortata_min_C2() {
		return portata_min_C2;
	}
	public void setPortata_min_C2(BigDecimal portata_min_C2) {
		this.portata_min_C2 = portata_min_C2;
	}
	public BigDecimal getPortata_max_C2() {
		return portata_max_C2;
	}
	public void setPortata_max_C2(BigDecimal portata_max_C2) {
		this.portata_max_C2 = portata_max_C2;
	}
	public BigDecimal getDiv_ver_C2() {
		return div_ver_C2;
	}
	public void setDiv_ver_C2(BigDecimal div_ver_C2) {
		this.div_ver_C2 = div_ver_C2;
	}
	public BigDecimal getDiv_rel_C2() {
		return div_rel_C2;
	}
	public void setDiv_rel_C2(BigDecimal div_rel_C2) {
		this.div_rel_C2 = div_rel_C2;
	}
	public BigDecimal getNumero_div_C2() {
		return numero_div_C2;
	}
	public void setNumero_div_C2(BigDecimal numero_div_C2) {
		this.numero_div_C2 = numero_div_C2;
	}
	public BigDecimal getPortata_min_C3() {
		return portata_min_C3;
	}
	public void setPortata_min_C3(BigDecimal portata_min_C3) {
		this.portata_min_C3 = portata_min_C3;
	}
	public BigDecimal getPortata_max_C3() {
		return portata_max_C3;
	}
	public void setPortata_max_C3(BigDecimal portata_max_C3) {
		this.portata_max_C3 = portata_max_C3;
	}
	public BigDecimal getDiv_ver_C3() {
		return div_ver_C3;
	}
	public void setDiv_ver_C3(BigDecimal div_ver_C3) {
		this.div_ver_C3 = div_ver_C3;
	}
	public BigDecimal getDiv_rel_C3() {
		return div_rel_C3;
	}
	public void setDiv_rel_C3(BigDecimal div_rel_C3) {
		this.div_rel_C3 = div_rel_C3;
	}
	public BigDecimal getNumero_div_C3() {
		return numero_div_C3;
	}
	public void setNumero_div_C3(BigDecimal numero_div_C3) {
		this.numero_div_C3 = numero_div_C3;
	}
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	public int getId_sede() {
		return id_sede;
	}
	public void setId_sede(int id_sede) {
		this.id_sede = id_sede;
	}
	public int getAnno_marcatura_ce() {
		return anno_marcatura_ce;
	}
	public void setAnno_marcatura_ce(int anno_marcatura_ce) {
		this.anno_marcatura_ce = anno_marcatura_ce;
	}
	public Date getData_messa_in_servizio() {
		return data_messa_in_servizio;
	}
	public void setData_messa_in_servizio(Date data_messa_in_servizio) {
		this.data_messa_in_servizio = data_messa_in_servizio;
	}
	public VerTipologiaStrumentoDTO getTipologia() {
		return tipologia;
	}
	public void setTipologia(VerTipologiaStrumentoDTO tipologia) {
		this.tipologia = tipologia;
	}
	public String getNome_cliente() {
		return nome_cliente;
	}
	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}
	public String getNome_sede() {
		return nome_sede;
	}
	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}
	public VerFamigliaStrumentoDTO getFamiglia_strumento() {
		return famiglia_strumento;
	}
	public void setFamiglia_strumento(VerFamigliaStrumentoDTO famiglia_strumento) {
		this.famiglia_strumento = famiglia_strumento;
	}

	public Set<VerLegalizzazioneBilanceDTO> getLista_legalizzazione_bilance() {
		return lista_legalizzazione_bilance;
	}
	public void setLista_legalizzazione_bilance(Set<VerLegalizzazioneBilanceDTO> lista_legalizzazione_bilance) {
		this.lista_legalizzazione_bilance = lista_legalizzazione_bilance;
	}
	public String getUltimo_verificatore() {
		return ultimo_verificatore;
	}
	public void setUltimo_verificatore(String ultimo_verificatore) {
		this.ultimo_verificatore = ultimo_verificatore;
	}
	public int getPosizione_cambio() {
		return posizione_cambio;
	}
	public void setPosizione_cambio(int posizione_cambio) {
		this.posizione_cambio = posizione_cambio;
	}
	public String getMasse_corredo() {
		return masse_corredo;
	}
	public void setMasse_corredo(String masse_corredo) {
		this.masse_corredo = masse_corredo;
	}
	public int getTipo_indicazione() {
		return tipo_indicazione;
	}
	public void setTipo_indicazione(int tipo_indicazione) {
		this.tipo_indicazione = tipo_indicazione;
	}
	
}
