package it.portaleSTI.DTO;


import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class MagPaccoDTO  implements Serializable{

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
	private transient Set<MagItemPaccoDTO> item_pacco = new HashSet<MagItemPaccoDTO>(0);
	private ClienteDTO cliente;
	private String origine;
	private String commessa;
	private String link_testa_pacco;
	private String note_pacco;	
	private String fornitore;
	private Date data_arrivo;
	private transient Set<MagAllegatoDTO> allegato = new HashSet<MagAllegatoDTO>(0);
	private int chiuso;
	private MagTipoNotaPaccoDTO tipo_nota_pacco;
	private Date data_spedizione;
	private int hasAllegato;
	private String nome_cliente_util;
	private String nome_sede_util;
	private Integer id_cliente_util;
	private Integer id_sede_util;
	private int ritardo;
	private int segnalato;

	
	public int getRitardo() {
		return ritardo;
	}
	public void setRitardo(int ritardo) {
		this.ritardo = ritardo;
	}
	public int getSegnalato() {
		return segnalato;
	}
	public void setSegnalato(int segnalato) {
		this.segnalato = segnalato;
	}
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
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public String getOrigine() {
		return origine;
	}
	public void setOrigine(String origine) {
		this.origine = origine;
	}

	public String getLink_testa_pacco() {
		return link_testa_pacco;
	}
	public void setLink_testa_pacco(String link_testa_pacco) {
		this.link_testa_pacco = link_testa_pacco;
	}
	public Set<MagAllegatoDTO> getAllegato() {
		return allegato;
	}
	public void setAllegato(Set<MagAllegatoDTO> allegato) {
		this.allegato = allegato;
	}
	public String getNote_pacco() {
		return note_pacco;
	}
	public void setNote_pacco(String note_pacco) {
		this.note_pacco = note_pacco;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}

	public String getFornitore() {
		return fornitore;
	}
	public void setFornitore(String fornitore) {
		this.fornitore = fornitore;
	}
	public Date getData_arrivo() {
		return data_arrivo;
	}
	public void setData_arrivo(Date data_arrivo) {
		this.data_arrivo = data_arrivo;
	}
	public int getChiuso() {
		return chiuso;
	}
	public void setChiuso(int chiuso) {
		this.chiuso = chiuso;
	}
	public MagTipoNotaPaccoDTO getTipo_nota_pacco() {
		return tipo_nota_pacco;
	}
	public void setTipo_nota_pacco(MagTipoNotaPaccoDTO tipo_nota_pacco) {
		this.tipo_nota_pacco = tipo_nota_pacco;
	}
	public Date getData_spedizione() {
		return data_spedizione;
	}
	public void setData_spedizione(Date data_spedizione) {
		this.data_spedizione = data_spedizione;
	}
	public int getHasAllegato() {
		return hasAllegato;
	}
	public void setHasAllegato(int hasAllegato) {
		this.hasAllegato = hasAllegato;
	}
	public String getNome_cliente_util() {
		return nome_cliente_util;
	}
	public void setNome_cliente_util(String nome_cliente_util) {
		this.nome_cliente_util = nome_cliente_util;
	}
	public String getNome_sede_util() {
		return nome_sede_util;
	}
	public void setNome_sede_util(String nome_sede_util) {
		this.nome_sede_util = nome_sede_util;
	}
	public int getId_sede_util() {
		return id_sede_util;
	}
	public void setId_sede_util(int id_sede_util) {
		this.id_sede_util = id_sede_util;
	}
	public int getId_cliente_util() {
		return id_cliente_util;
	}
	public void setId_cliente_util(int id_cliente_util) {
		this.id_cliente_util = id_cliente_util;
	}


	
}
