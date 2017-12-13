package it.portaleSTI.DTO;

import java.util.Date;

public class TrendDTO {
	int id;
	TipoTrendDTO tipoTrend;
	CompanyDTO company;
	Date data;
	int val;
	
	public TrendDTO() {
		
	}
	public TrendDTO(int id, TipoTrendDTO tipoTrend, CompanyDTO company, Date data, int val) {
		super();
		this.id = id;
		this.tipoTrend = tipoTrend;
		this.company = company;
		this.data = data;
		this.val = val;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TipoTrendDTO getTipoTrend() {
		return tipoTrend;
	}
	public void setTipoTrend(TipoTrendDTO tipoTrend) {
		this.tipoTrend = tipoTrend;
	}
	public CompanyDTO getCompany() {
		return company;
	}
	public void setCompany(CompanyDTO company) {
		this.company = company;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public int getVal() {
		return val;
	}
	public void setVal(int val) {
		this.val = val;
	}

}
