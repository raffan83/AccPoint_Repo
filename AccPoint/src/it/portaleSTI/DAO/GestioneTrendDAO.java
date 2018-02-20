package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;
 
public class GestioneTrendDAO {
	public static ArrayList<TipoTrendDTO> getListaTipoTrend(Session session) {
 		Query query  = session.createQuery( "from TipoTrendDTO");
		
		ArrayList<TipoTrendDTO> result =(ArrayList<TipoTrendDTO>) query.list();
		
		if(result.size()>0)
		{			
			return result;
		}
		return null;
	}
	
	public static ArrayList<TipoTrendDTO> getListaTipoTrendAttivi(Session session) {
 		Query query  = session.createQuery( "from TipoTrendDTO WHERE attivo = 1");
		
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
	
	public static ArrayList<TrendDTO> getListaTrendUser(String company_id, Session session) {
 		Query query  = session.createQuery( "from TrendDTO WHERE  company.id = :_company_id");
		
		query.setParameter("_company_id", Integer.parseInt(company_id));
 
		ArrayList<TrendDTO> result =(ArrayList<TrendDTO>) query.list();
		
		if(result.size()>0)
		{			
			return result;
		}
		return null;
	}
	public static ArrayList<TrendDTO> getListaTrendAttiviUser(String company_id, Session session) {
 		Query query  = session.createQuery( "from TrendDTO WHERE  company.id = :_company_id AND tipoTrend.attivo = 1");
		
		query.setParameter("_company_id", Integer.parseInt(company_id));
 
		ArrayList<TrendDTO> result =(ArrayList<TrendDTO>) query.list();
		
		if(result.size()>0)
		{			
			return result;
		}
		return null;
	}
	public static TrendDTO getTrendById(String id, Session session) throws HibernateException, Exception {


		Query query  = session.createQuery( "from TrendDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<TrendDTO> result =query.list();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}
	public static int saveTrend(TrendDTO trend, Session session) {
		int toRet=0;
		
		try{

		
	 
		int idTTrend=(Integer) session.save(trend);

		
	 
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
	}

	public static TipoTrendDTO getTipoTrendById(String id, Session session) {
		Query query  = session.createQuery( "from TipoTrendDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<TipoTrendDTO> result =query.list();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}



	
}
