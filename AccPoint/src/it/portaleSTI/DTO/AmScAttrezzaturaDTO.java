package it.portaleSTI.DTO;

import java.util.HashMap;
import java.util.Map;

public class AmScAttrezzaturaDTO {
    private Integer id;
    private String descrizione;
    private Integer idCliente;
    private Integer idSede;
    private String costruttore;
    private String matricola;
    private Integer disabilitato;
    private AmScTipoAttrezzaturaDTO tipo_attrezzatura;
    private String nome_cliente;
    public String getNome_sede() {
		return nome_sede;
	}

	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}

	private String nome_sede;
    public String getNome_cliente() {
		return nome_cliente;
	}

	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}

	

	public AmScTipoAttrezzaturaDTO getTipo_attrezzatura() {
		return tipo_attrezzatura;
	}

	public void setTipo_attrezzatura(AmScTipoAttrezzaturaDTO tipo_attrezzatura) {
		this.tipo_attrezzatura = tipo_attrezzatura;
	}

	Map<String, Integer> mapScadenze = new HashMap<String, Integer>();

    // Getter e Setter
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public Integer getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public Integer getIdSede() {
        return idSede;
    }

    public void setIdSede(Integer idSede) {
        this.idSede = idSede;
    }

    public String getCostruttore() {
        return costruttore;
    }

    public void setCostruttore(String costruttore) {
        this.costruttore = costruttore;
    }

    public String getMatricola() {
        return matricola;
    }

    public void setMatricola(String matricola) {
        this.matricola = matricola;
    }

    public Integer getDisabilitato() {
        return disabilitato;
    }

    public void setDisabilitato(Integer disabilitato) {
        this.disabilitato = disabilitato;
    }

	public Map<String, Integer> getMapScadenze() {
		return mapScadenze;
	}

	public void setMapScadenze(Map<String, Integer> mapScadenze) {
		this.mapScadenze = mapScadenze;
	}
    
    
}

