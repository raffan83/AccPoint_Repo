package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;



public class SessioneDTO {
	
	private Integer id=0;
	private String username;
	private String password;
	private Date dataCreazione;
	private Date dataScadenza;
	private Integer id_cliente;
	private String nome_cliente;
	private Integer id_sede;
	private String nome_sede;
	private String session_id;
	private Set<MisuraDTO> lista_misure_inviate= new HashSet<MisuraDTO>(0);;
	private Integer id_intervento;
	private UtenteDTO user;
	private String email_cliente;
	private Integer abilitato;
	private UtenteDTO user_modifica;
	private Date data_modifica;
	
	
	public SessioneDTO() {
		
	}
	
	public SessioneDTO(Integer id, String username, String password, Date dataCreazione, Date dataScadenza,
			Integer id_cliente, String nome_cliente, Integer id_sede, String nome_sede, String session_id, Integer id_intervento) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.dataCreazione = dataCreazione;
		this.dataScadenza = dataScadenza;
		this.id_cliente = id_cliente;
		this.nome_cliente = nome_cliente;
		this.id_sede = id_sede;
		this.nome_sede = nome_sede;
		this.session_id = session_id;
		this.id_intervento = id_intervento;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public Date getDataCreazione() {
		return dataCreazione;
	}


	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}


	public Date getDataScadenza() {
		return dataScadenza;
	}


	public void setDataScadenza(Date dataScadenza) {
		this.dataScadenza = dataScadenza;
	}


	public Integer getId_cliente() {
		return id_cliente;
	}


	public void setId_cliente(Integer id_cliente) {
		this.id_cliente = id_cliente;
	}


	public String getNome_cliente() {
		return nome_cliente;
	}


	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}


	public Integer getId_sede() {
		return id_sede;
	}


	public void setId_sede(Integer id_sede) {
		this.id_sede = id_sede;
	}


	public String getNome_sede() {
		return nome_sede;
	}


	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}

	

	public Set<MisuraDTO> getLista_misure_inviate() {
		return lista_misure_inviate;
	}

	public void setLista_misure_inviate(Set<MisuraDTO> lista_misure_inviate) {
		this.lista_misure_inviate = lista_misure_inviate;
	}

	public String getSession_id() {
		return session_id;
	}

	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}

	public Integer getId_intervento() {
		return id_intervento;
	}

	public void setId_intervento(Integer id_intervento) {
		this.id_intervento = id_intervento;
	}


	public UtenteDTO getUser() {
		return user;
	}

	public void setUser(UtenteDTO user) {
		this.user = user;
	}

	public String getEmail_cliente() {
		return email_cliente;
	}

	public void setEmail_cliente(String email_cliente) {
		this.email_cliente = email_cliente;
	}

	
	
	
	public Integer getAbilitato() {
		return abilitato;
	}

	public void setAbilitato(Integer abilitato) {
		this.abilitato = abilitato;
	}

	public UtenteDTO getUser_modifica() {
		return user_modifica;
	}

	public void setUser_modifica(UtenteDTO user_modifica) {
		this.user_modifica = user_modifica;
	}

	public Date getData_modifica() {
		return data_modifica;
	}

	public void setData_modifica(Date data_modifica) {
		this.data_modifica = data_modifica;
	}
	
	
	

}
