package it.portaleSTI.DTO;

public class LatMasterDTO {
	
	private int id;
	private String sigla;
	private int seq;
	private String rif_tipo_strumento;
	private String sigla_registro;
	private String id_procedura;
	
	public LatMasterDTO(int int1) {
		
		id=int1;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSigla() {
		return sigla;
	}
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getRif_tipo_strumento() {
		return rif_tipo_strumento;
	}
	public void setRif_tipo_strumento(String rif_tipo_strumento) {
		this.rif_tipo_strumento = rif_tipo_strumento;
	}
	public String getSigla_registro() {
		return sigla_registro;
	}
	public void setSigla_registro(String sigla_registro) {
		this.sigla_registro = sigla_registro;
	}
	public String getId_procedura() {
		return id_procedura;
	}
	public void setId_procedura(String id_procedura) {
		this.id_procedura = id_procedura;
	}

}
