package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class MagPaccoDTO {

	private int id;
	private Date data_lavorazione;
	private MagStatoLavorazioneDTO stato_lavorazione;
	private int id_cliente;
	private String nome_cliente;
	private int id_sede;
	private String nome_sede;
	private CompanyDTO company;
	private UtenteDTO utente;
	private String codice_pacco;
	private MagDdtDTO ddt;
	private Set<MagItemPaccoDTO> item_pacco = new HashSet<MagItemPaccoDTO>(0);
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getData_lavorazione() {
		return data_lavorazione;
	}
	public void setData_lavorazione(Date data_lavorazione) {
		this.data_lavorazione = data_lavorazione;
	}
	public MagStatoLavorazioneDTO getStato_lavorazione() {
		return stato_lavorazione;
	}
	public void setStato_lavorazione(MagStatoLavorazioneDTO stato_lavorazione) {
		this.stato_lavorazione = stato_lavorazione;
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
	public CompanyDTO getCompany() {
		return company;
	}
	public void setCompany(CompanyDTO company) {
		this.company = company;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public String getCodice_pacco() {
		return codice_pacco;
	}
	public void setCodice_pacco(String codice_pacco) {
		this.codice_pacco = codice_pacco;
	}
	public MagDdtDTO getDdt() {
		return ddt;
	}
	public void setDdt(MagDdtDTO ddt) {
		this.ddt = ddt;
	}
	public Set<MagItemPaccoDTO> getItem_pacco() {
		return item_pacco;
	}
	public void setItem_pacco(Set<MagItemPaccoDTO> item_pacco) {
		this.item_pacco = item_pacco;
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
	
}
