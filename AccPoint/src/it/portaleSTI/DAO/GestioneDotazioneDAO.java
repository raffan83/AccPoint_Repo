package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;

public class GestioneDotazioneDAO {

	public static ArrayList<DotazioneDTO> getListaDotazioni(CompanyDTO cmp, Session session) {
		
		Query query  = session.createQuery( "from DotazioneDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		
		ArrayList<DotazioneDTO> result =(ArrayList<DotazioneDTO>) query.list();
		
		return result;
	}

	public static ArrayList<TipologiaDotazioniDTO> getListaTipologieDotazioni(Session session) {
			Query query  = session.createQuery( "from TipologiaDotazioniDTO");
		
		ArrayList<TipologiaDotazioniDTO> result =(ArrayList<TipologiaDotazioniDTO>) query.list();
		
		return result;
	}

	public static void saveDotazione(DotazioneDTO dotazione, Session session) throws Exception {

		session.save(dotazione);
		
	}

	public static void updateDotazione(DotazioneDTO dotazione, Session session) throws Exception {
		 
		session.update(dotazione);
		
	}

	public static DotazioneDTO getDotazioneById(String id, Session session) {
		Query query  = session.createQuery( "from DotazioneDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<DotazioneDTO> result =query.list();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}

	public static void deleteDotazione(DotazioneDTO dotazione, Session session) throws Exception{
		
		session.delete(dotazione);
		
	}

	public static TipologiaDotazioniDTO getTipoDotazioneById(int idTipologia) {
		Session	session = SessionFacotryDAO.get().openSession();    
		session.beginTransaction();
		
		Query query  = session.createQuery( "from TipologiaDotazioniDTO WHERE id= :_id");
		
		query.setParameter("_id",idTipologia);
		List<TipologiaDotazioniDTO> result =query.list();
		
		
		session.getTransaction().commit();
		session.close();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}

	public static void inserisciAssociazioneArticoloDotazione(String idArticolo, int idTipoDotazione, int idCompany, int idUser) throws Exception {
	
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("INSERT INTO articolo_dotazione VALUES(?,?,?,?)");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idTipoDotazione);					
			pst.setInt(3, idUser);
			pst.setInt(4, idCompany);
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		
	}

	public static void deleteAssociazioneArticoloDotazione(String idArticolo,int idTipoDotazione) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("DELETE  FROM articolo_accessorio WHERE id_articolo=? AND id_tipo_dotazione=?");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idTipoDotazione);		
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		
	}
	

}
