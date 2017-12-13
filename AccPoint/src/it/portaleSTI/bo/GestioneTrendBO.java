package it.portaleSTI.bo;

import java.util.ArrayList;

import it.portaleSTI.DAO.GestioneTrendDAO;
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;

public class GestioneTrendBO {
	public static ArrayList<TipoTrendDTO> getListaTipoTrend() {
		return GestioneTrendDAO.getListaTipoTrend();
		 
	}
	
	public static ArrayList<TrendDTO> getListaTrend(String company_id, String tipo_trend_id) {
		return GestioneTrendDAO.getListaTrend(company_id, tipo_trend_id);
		 
	}
	public static ArrayList<TrendDTO> getListaTrendUser(String company_id) {
		return GestioneTrendDAO.getListaTrendUser(company_id);
		 
	}
}
