package it.portaleSTI.DTO;

import java.sql.Date;

public class ScadenzaDTO {
	
	private int id;
	private int freq_mesi;
	private Date dataUltimaVerifica;
	private Date dataProssimaVerifica;
	private int id_strumento;
	private int id_tipo_rapporto;
	private String ref_tipo_rapporto;
	
	
	public ScadenzaDTO(){}
	
	public ScadenzaDTO(int id, int freq_mesi, Date dataUltimaVerifica,
			Date dataProssimaVerifica, int id_strumento, int id_tipo_rapporto) {
		super();
		this.id = id;
		this.freq_mesi = freq_mesi;
		this.dataUltimaVerifica = dataUltimaVerifica;
		this.dataProssimaVerifica = dataProssimaVerifica;
		this.id_strumento = id_strumento;
		this.id_tipo_rapporto = id_tipo_rapporto;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFreq_mesi() {
		return freq_mesi;
	}
	public void setFreq_mesi(int freq_mesi) {
		this.freq_mesi = freq_mesi;
	}
	public Date getDataUltimaVerifica() {
		return dataUltimaVerifica;
	}
	public void setDataUltimaVerifica(Date dataUltimaVerifica) {
		this.dataUltimaVerifica = dataUltimaVerifica;
	}
	public Date getDataProssimaVerifica() {
		return dataProssimaVerifica;
	}
	public void setDataProssimaVerifica(Date dataProssimaVerifica) {
		this.dataProssimaVerifica = dataProssimaVerifica;
	}
	public int getId_strumento() {
		return id_strumento;
	}
	public void setId_strumento(int id_strumento) {
		this.id_strumento = id_strumento;
	}
	public int getId_tipo_rapporto() {
		return id_tipo_rapporto;
	}
	public void setId_tipo_rapporto(int id_tipo_rapporto) {
		this.id_tipo_rapporto = id_tipo_rapporto;
	}

	public String getRef_tipo_rapporto() {
		return ref_tipo_rapporto;
	}

	public void setRef_tipo_rapporto(String ref_tipo_rapporto) {
		this.ref_tipo_rapporto = ref_tipo_rapporto;
	}

}
