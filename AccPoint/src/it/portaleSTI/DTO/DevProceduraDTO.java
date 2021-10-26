package it.portaleSTI.DTO;

public class DevProceduraDTO {
	
	private int id;
	private String descrizione;
	private String frequenza;
	private DevTipoProceduraDTO tipo_procedura;
	int id_device;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getFrequenza() {
		return frequenza;
	}
	public void setFrequenza(String frequenza) {
		this.frequenza = frequenza;
	}
	public DevTipoProceduraDTO getTipo_procedura() {
		return tipo_procedura;
	}
	public void setTipo_procedura(DevTipoProceduraDTO tipo_procedura) {
		this.tipo_procedura = tipo_procedura;
	}
	public int getId_device() {
		return id_device;
	}
	public void setId_device(int id_device) {
		this.id_device = id_device;
	}
	
	
	
}
