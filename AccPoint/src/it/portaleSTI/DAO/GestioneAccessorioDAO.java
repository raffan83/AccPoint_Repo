package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


public class GestioneAccessorioDAO {

	public static ArrayList<AccessorioDTO> getListaAccessori(CompanyDTO cmp, Session session) {
		Query query  = session.createQuery( "from AccessorioDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		ArrayList<AccessorioDTO> result =(ArrayList<AccessorioDTO>) query.list();
		
		return result;
	}

	public static int saveAccessorio(AccessorioDTO accessorio, String action, Session session) {
		int toRet=0;
		
		try{
		int idAccessorio=0;
		
		if(action.equals("modifica") || action.equals("caricoscarico")){
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
	
	public static AccessorioDTO getAccessorioById(String id) {
		
	
		Session	session = SessionFacotryDAO.get().openSession();
		    
		session.beginTransaction();
			
		
		
		Query query  = session.createQuery( "from AccessorioDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<AccessorioDTO> result =query.list();
		
		session.getTransaction().commit();
		session.close();
		
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

	public static ArrayList<TipologiaAccessoriDTO> getListaTipologieAccessori(Session session) {
		Query query  = session.createQuery( "from TipologiaAccessoriDTO");
		
		ArrayList<TipologiaAccessoriDTO> result =(ArrayList<TipologiaAccessoriDTO>) query.list();
		
		return result;
	}

	public static void inserisciAssociazioneArticoloAccessorio(String idArticolo, int idAccessorio,int quantita,int idCompany,int idUser) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("INSERT INTO articolo_accessorio VALUES(?,?,?,?,?)");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idAccessorio);		
			pst.setInt(3, quantita);
			pst.setInt(4, idUser);
			pst.setInt(5, idCompany);
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		
	}

	public static void deleteAssociazioneArticoloAccessorio(String idArticolo,int idAccessorio) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("DELETE  FROM articolo_accessorio WHERE id_articolo=? AND id_accessorio=?");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idAccessorio);		
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		
	}

}
