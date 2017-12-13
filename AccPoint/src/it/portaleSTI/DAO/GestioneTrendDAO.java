package it.portaleSTI.DAO;

import java.util.ArrayList;
 
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;
 
public class GestioneTrendDAO {
	public static ArrayList<TipoTrendDTO> getListaTipoTrend() {
		Session session=SessionFacotryDAO.get().openSession();
		Query query  = session.createQuery( "from TipoTrendDTO");
		
		ArrayList<TipoTrendDTO> result =(ArrayList<TipoTrendDTO>) query.list();
		
		if(result.size()>0)
		{			
			return result;
		}
		return null;
	}
	
	public static ArrayList<TrendDTO> getListaTrend(String company_id, String tipo_trend_id) {
		Session session=SessionFacotryDAO.get().openSession();
		Query query  = session.createQuery( "from TrendDTO WHERE tipoTrend.id =:_tipo_trend_id AND company.id = :_company_id");
		
		query.setParameter("_company_id", Integer.parseInt(company_id));
		query.setParameter("_tipo_trend_id", Integer.parseInt(tipo_trend_id));

		ArrayList<TrendDTO> result =(ArrayList<TrendDTO>) query.list();
		
		if(result.size()>0)
		{			
			return result;
		}
		return null;
	}
	
	public static ArrayList<TrendDTO> getListaTrendUser(String company_id) {
		Session session=SessionFacotryDAO.get().openSession();
		Query query  = session.createQuery( "from TrendDTO WHERE  company.id = :_company_id");
		
		query.setParameter("_company_id", Integer.parseInt(company_id));
 
		ArrayList<TrendDTO> result =(ArrayList<TrendDTO>) query.list();
		
		if(result.size()>0)
		{			
			return result;
		}
		return null;
	}
	
}
