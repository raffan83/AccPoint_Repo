package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RuoloDTO;

public class GestioneAccessorioDAO {

	public static List<AccessorioDTO> getListaAccessori(CompanyDTO cmp, Session session) {
		Query query  = session.createQuery( "from AccessorioDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		List<AccessorioDTO> result =query.list();
		
		return result;
	}

	public static int saveAccessorio(AccessorioDTO accessorio, String action, Session session) {
		int toRet=0;
		
		try{
		int idAccessorio=0;
		
		if(action.equals("modifica")){
			session.update(accessorio);
			idAccessorio=accessorio.getId();
		}
		else if(action.equals("nuovo")){
			idAccessorio=(Integer) session.save(accessorio);

		}
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
	}

	public static AccessorioDTO getAccessorioById(String id, Session session) {
		Query query  = session.createQuery( "from AccessorioDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<AccessorioDTO> result =query.list();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}

	public static int deleteAccessorio(AccessorioDTO accessorio, Session session) {
		int toRet=0;
		try{
			session.delete(accessorio);
			toRet=0;	
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;

		}
		return toRet;
	}

}
