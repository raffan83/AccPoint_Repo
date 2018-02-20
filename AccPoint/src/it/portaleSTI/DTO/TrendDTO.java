package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class TrendDTO  implements Serializable {
	private static final long serialVersionUID = 1L;
	int id = 0;
	TipoTrendDTO tipoTrend;
	CompanyDTO company;
	Date data;
	int val = 0;
	String asse_x;
		
	public TrendDTO() {
		
	}
	public TrendDTO(int id, TipoTrendDTO tipoTrend, CompanyDTO company, Date data, int val,String asse_x) {
		super();
		this.id = id;
		this.tipoTrend = tipoTrend;
		this.company = company;
		this.data = data;
		this.val = val;
		this.asse_x=asse_x;
	
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
	public String getAsse_x() {
		return asse_x;
	}
	public void setAsse_x(String asse_x) {
		this.asse_x = asse_x;
	}
	


}
