package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class InterventoDTO {

	
	private int id;
	private Date dataCreazione;
	private int idSede;
	private int id_cliente;
	private String nome_sede;
	private UtenteDTO user;
	private String idCommessa;
	StatoInterventoDTO statoIntervento;
	private int pressoDestinatario;
	private CompanyDTO company;
	private String nomePack;
	private int nStrumentiGenerati;
	private int nStrumentiMisurati;
	private int nStrumentiNuovi;
	private Set<InterventoDatiDTO> listaInterventoDatiDTO = new HashSet<InterventoDatiDTO>(0);
	
	
	public Date getDataCreazione() {
		return dataCreazione;
	}
	
	
	public String getNome_sede() {
		return nome_sede;
	}


	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}
	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdSede() {
		return idSede;
	}
	public void setIdSede(int idSede) {
		this.idSede = idSede;
	}
	public String getIdCommessa() {
		return idCommessa;
	}
	public void setIdCommessa(String idCommessa) {
		this.idCommessa = idCommessa;
	}
	public int getPressoDestinatario() {
		return pressoDestinatario;
	}
	public void setPressoDestinatario(int pressoDestinatario) {
		this.pressoDestinatario = pressoDestinatario;
	}


	public int getId_cliente() {
		return id_cliente;
	}


	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}


	public StatoInterventoDTO getStatoIntervento() {
		return statoIntervento;
	}


	public void setStatoIntervento(StatoInterventoDTO statoIntervento) {
		this.statoIntervento = statoIntervento;
	}


	public UtenteDTO getUser() {
		return user;
	}


	public void setUser(UtenteDTO user) {
		this.user = user;
	}


	public CompanyDTO getCompany() {
		return company;
	}


	public void setCompany(CompanyDTO company) {
		this.company = company;
	}


	public String getNomePack() {
		return nomePack;
	}


	public void setNomePack(String nomePack) {
		this.nomePack = nomePack;
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


	public Set<InterventoDatiDTO> getListaInterventoDatiDTO() {
		return listaInterventoDatiDTO;
	}


	public void setListaInterventoDatiDTO(
			Set<InterventoDatiDTO> listaInterventoDatiDTO) {
		this.listaInterventoDatiDTO = listaInterventoDatiDTO;
	}
	
	
}
