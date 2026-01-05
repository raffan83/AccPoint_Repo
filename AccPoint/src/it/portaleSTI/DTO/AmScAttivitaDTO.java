package it.portaleSTI.DTO;

public class AmScAttivitaDTO {
    public Integer getFrequenza() {
		return frequenza;
	}

	public void setFrequenza(Integer frequenza) {
		this.frequenza = frequenza;
	}

	private Integer id;
    private String descrizione;
    private Integer tipo_attrezzatura;
    private Integer frequenza;

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

	public Integer getTipo_attrezzatura() {
		return tipo_attrezzatura;
	}

	public void setTipo_attrezzatura(Integer tipo_attrezzatura) {
		this.tipo_attrezzatura = tipo_attrezzatura;
	}
    
}

