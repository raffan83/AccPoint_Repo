package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneTrendDAO;
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;

public class GestioneTrendBO {
	public static ArrayList<TipoTrendDTO> getListaTipoTrend(Session session) {
		return GestioneTrendDAO.getListaTipoTrend(session);
		 
	}
	public static ArrayList<TipoTrendDTO> getListaTipoTrendAttivi(Session session) {
		return GestioneTrendDAO.getListaTipoTrendAttivi(session);
		 
	}
	public static ArrayList<TrendDTO> getListaTrend(String company_id, String tipo_trend_id) {
		return GestioneTrendDAO.getListaTrend(company_id, tipo_trend_id);
		 
	}
	public static ArrayList<TrendDTO> getListaTrendUser(String company_id, Session session) {
		return GestioneTrendDAO.getListaTrendUser(company_id, session);
		 
	}
	
	public static ArrayList<TrendDTO> getListaTrendAttiviUser(String company_id, Session session) {
		return GestioneTrendDAO.getListaTrendAttiviUser(company_id, session);
		 
	}

	public static int saveTrend(TrendDTO trend, String action, Session session) {
		int toRet=0;
		
		try{
		int idTrend=0;
		
		if(action.equals("modifica")){
			session.update(trend);
			idTrend=trend.getId();
		}
		else if(action.equals("nuovo")){
			idTrend=(Integer) session.save(trend);

		}
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
		
	}

	public static TrendDTO getTrendById(String id, Session session) throws HibernateException, Exception {
		// TODO Auto-generated method stub
		return GestioneTrendDAO.getTrendById(id,session);
	}

	public static int saveTipoTrend(TipoTrendDTO tipoTrend, String action, Session session) {
		int toRet=0;
		
		try{
			int idTipoTrend=0;
			if(action.equals("toggleTipoTrend")){
				session.update(tipoTrend);
				idTipoTrend=tipoTrend.getId();
			}
			else if(action.equals("nuovoTipoTrend")){
				idTipoTrend=(Integer) session.save(tipoTrend);

			}
	 
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
	}

	public static TipoTrendDTO getTipoTrendById(String id, Session session) {
		// TODO Auto-generated method stub
		return GestioneTrendDAO.getTipoTrendById(id,session);
	}
}
