package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.DTO.UtenteDTO;

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
			pst.setInt(3, idCompany);
			pst.setInt(4, idUser);
			
		
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
			
			pst=con.prepareStatement("DELETE  FROM articolo_dotazione WHERE id_articolo=? AND id_tipologia_dotazioni=?");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idTipoDotazione);		
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		
	}

	public static ArrayList<TipologiaDotazioniDTO> getListaTipologieDotazioniByArticolo(CompanyDTO cmp, String codiceArticolo) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs = null;
		 ArrayList<TipologiaDotazioniDTO> listaTipologiaDotazioni = new  ArrayList<TipologiaDotazioniDTO>();
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("SELECT * FROM tipologia_dotazioni a "
					+ "LEFT JOIN articolo_dotazione b ON a.id = b.id_tipologia_dotazioni "
					+ "WHERE b.id_articolo=? AND b.id_company =?");
			
			pst.setString(1, codiceArticolo);
			pst.setInt(2, cmp.getId());
			
			rs = pst.executeQuery();

			TipologiaDotazioniDTO tipologia = null;
 
			while(rs.next()) {
			
				tipologia = new TipologiaDotazioniDTO();
				tipologia.setId(rs.getInt("a.id"));
				tipologia.setCodice(rs.getString("a.codice"));
				tipologia.setDescrizione(rs.getString("a.descrizione"));
				listaTipologiaDotazioni.add(tipologia);
			}
		} 
		catch (Exception e) 
		{
			throw e;
		}
		finally{
			pst.close();
			con.close();
		}
		return listaTipologiaDotazioni;
	}
	

}
