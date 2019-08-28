package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class VerInterventoDTO {

	private int id;
	private UtenteDTO user_creation;
	private UtenteDTO user_verificazione;
	private int id_sede;
	private int id_cliente;
	private String nome_sede;
	private String nome_cliente;
	private String commessa;
	private Date data_creazione;
	private Date data_chiusura;
	private int id_stato_intervento;
	private String nome_pack;
	private int id_company;
	private int nStrumentiGenerati;
	private int nStrumentiMisurati;
	private int nStrumentiNuovi;
	private UtenteDTO user_riparatore;
	private Date data_prevista;
	private int in_sede_cliente;
	private Set<VerInterventoStrumentiDTO> interventoStrumenti = new HashSet<VerInterventoStrumentiDTO>(0);
	
		public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public UtenteDTO getUser_creation() {
		return user_creation;
	}
	public void setUser_creation(UtenteDTO user_creation) {
		this.user_creation = user_creation;
	}
	public UtenteDTO getUser_verificazione() {
		return user_verificazione;
	}
	public void setUser_verificazione(UtenteDTO user_verificazione) {
		this.user_verificazione = user_verificazione;
	}
	public int getId_sede() {
		return id_sede;
	}
	public void setId_sede(int id_sede) {
		this.id_sede = id_sede;
	}
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	public String getNome_sede() {
		return nome_sede;
	}
	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}
	public String getNome_cliente() {
		return nome_cliente;
	}
	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public Date getData_creazione() {
		return data_creazione;
	}
	public void setData_creazione(Date data_creazione) {
		this.data_creazione = data_creazione;
	}
	public Date getData_chiusura() {
		return data_chiusura;
	}
	public void setData_chiusura(Date data_chiusura) {
		this.data_chiusura = data_chiusura;
	}
	public int getId_stato_intervento() {
		return id_stato_intervento;
	}
	public void setId_stato_intervento(int id_stato_intervento) {
		this.id_stato_intervento = id_stato_intervento;
	}
	public String getNome_pack() {
		return nome_pack;
	}
	public void setNome_pack(String nome_pack) {
		this.nome_pack = nome_pack;
	}
	public int getId_company() {
		return id_company;
	}
	public void setId_company(int id_company) {
		this.id_company = id_company;
	}
	public int getnStrumentiGenerati() {
		return nStrumentiGenerati;
	}
	public void setnStrumentiGenerati(int nStrumentiGenerati) {
		this.nStrumentiGenerati = nStrumentiGenerati;
	}
	public int getnStrumentiMisurati() {
		return nStrumentiMisurati;
	}
	public void setnStrumentiMisurati(int nStrumentiMisurati) {
		this.nStrumentiMisurati = nStrumentiMisurati;
	}
	public int getnStrumentiNuovi() {
		return nStrumentiNuovi;
	}
	public void setnStrumentiNuovi(int nStrumentiNuovi) {
		this.nStrumentiNuovi = nStrumentiNuovi;
	}
	
	
	public UtenteDTO getUser_riparatore() {
		return user_riparatore;
	}
	public void setUser_riparatore(UtenteDTO user_riparatore) {
		this.user_riparatore = user_riparatore;
	}
	public Date getData_prevista() {
		return data_prevista;
	}
	public void setData_prevista(Date data_prevista) {
		this.data_prevista = data_prevista;
	}
	public int getIn_sede_cliente() {
		return in_sede_cliente;
	}
	public void setIn_sede_cliente(int in_sede_cliente) {
		this.in_sede_cliente = in_sede_cliente;
	}
	public Set<VerInterventoStrumentiDTO> getInterventoStrumenti() {
		return interventoStrumenti;
	}
	public void setInterventoStrumenti(Set<VerInterventoStrumentiDTO> interventoStrumenti) {
		this.interventoStrumenti = interventoStrumenti;
	}
}
