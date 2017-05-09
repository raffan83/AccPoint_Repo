package it.portaleSTI.DTO;

import java.sql.Date;

public class ScadenzaDTO {
	
	private int id;
	private int freq_mesi;
	private Date dataUltimaVerifica;
	private Date dataProssimaVerifica;
	private TipoRapportoDTO tipo_rapporto;
	private StrumentoDTO strumento;
	
	public ScadenzaDTO(){}
	

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

	public TipoRapportoDTO getTipo_rapporto() {
		return tipo_rapporto;
	}

	public void setTipo_rapporto(TipoRapportoDTO tipo_rapporto) {
		this.tipo_rapporto = tipo_rapporto;
	}
	public StrumentoDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(StrumentoDTO strumento) {
		this.strumento = strumento;
	}
}
