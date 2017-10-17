package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;

import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.TipoCampionamentoDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneCampionamentoDAO {

	private static final String query = "SELECT ID_ANAART , DESCR FROM dbo.BWT_ANAART WHERE ID_ANAGEN_COMPANY=?";

	public static ArrayList<ArticoloMilestoneDTO> getListaArticoli(CompanyDTO company) throws Exception {
		
			Connection con=null;
			PreparedStatement pst=null;
			ResultSet rs=null;

			ArrayList<ArticoloMilestoneDTO> listaArticoli = new ArrayList<>();
			
			try
			{
			con =ManagerSQLServer.getConnectionSQL();
	        
			
			pst=con.prepareStatement(query);
			
			
			pst.setInt(1, company.getId());

			rs=pst.executeQuery();
			
			ArticoloMilestoneDTO articolo=null;
			while(rs.next())
			{
				articolo= new ArticoloMilestoneDTO();
				String idANAART=rs.getString("ID_ANAART");
			    articolo.setID_ANAART(idANAART);
				articolo.setDESCR(rs.getString("DESCR"));

				articolo.setListaAccessori(getListaAccessori(idANAART));
				articolo.setListaDotazioni(getListaDotazioni(idANAART));
				listaArticoli.add(articolo);
				
			}
			
			}catch (Exception e) 
			{
			throw e;
			}
			finally
			{
				pst.close();
				con.close();
			}
			return listaArticoli;
		
	}

	

	private static ArrayList<AccessorioDTO> getListaAccessori(String idANAART) throws Exception {
		
		ArrayList<AccessorioDTO> listaAccesori = new ArrayList<AccessorioDTO>();
		
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("SELECT id_accessorio, quantita FROM articolo_accessorio WHERE id_articolo=?");
			pst.setString(1, idANAART);
			
			rs=pst.executeQuery();
			
			AccessorioDTO accessorio=null;
			
			while(rs.next())
			{
				accessorio= GestioneAccessorioDAO.getAccessorioById(rs.getString("id_accessorio"));
				accessorio.setQuantitaNecessaria(rs.getInt("quantita"));
				listaAccesori.add(accessorio);
			}
		} 
		catch (Exception e) 
		{
			throw e;
		}finally
		{
			pst.close();
			con.close();
		}
		
		return listaAccesori;
	}

	private static ArrayList<TipologiaDotazioniDTO> getListaDotazioni(String idANAART) throws Exception {
		
		ArrayList<TipologiaDotazioniDTO> listaTipologiaDotazioni = new ArrayList<TipologiaDotazioniDTO>();
		
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("SELECT id_tipologia_dotazioni FROM articolo_dotazione WHERE id_articolo=?");
			pst.setString(1, idANAART);
			
			rs=pst.executeQuery();
			
			TipologiaDotazioniDTO tipoDotazione=null;
			
			while(rs.next())
			{
				tipoDotazione= GestioneDotazioneDAO.getTipoDotazioneById(rs.getInt("id_tipologia_dotazioni"));
				listaTipologiaDotazioni.add(tipoDotazione);
			}
		} 
		catch (Exception e) 
		{
			throw e;
		}finally
		{
			pst.close();
			con.close();
		}
		
		return listaTipologiaDotazioni;
	}



	public static void saveIntervento(InterventoCampionamentoDTO intervento, Session session)throws Exception {
		
		session.save(intervento);
		
	}



	public static List<InterventoCampionamentoDTO> getListaInterventi(String idCommessa, Session session) {
		
		List<InterventoCampionamentoDTO> lista =null;
			
		session.beginTransaction();
		Query query  = session.createQuery( "from InterventoCampionamentoDTO WHERE id_commessa= :_id_commessa");
		
		query.setParameter("_id_commessa", idCommessa);
				
		lista=query.list();
		
		return lista;
	}



	public static ArrayList<TipoCampionamentoDTO> getListaTipoCampionamento(Session session) {
		
		ArrayList<TipoCampionamentoDTO> lista =null;
		
		session.beginTransaction();
		Query query  = session.createQuery( "from TipoCampionamentoDTO");
						
		lista=(ArrayList<TipoCampionamentoDTO>) query.list();
		
		return lista;
	}



	public static InterventoCampionamentoDTO getIntervento(String idIntervento) {
		Query query=null;
		InterventoCampionamentoDTO intervento=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from InterventoCampionamentoDTO WHERE id = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idIntervento));
		
	    intervento=(InterventoCampionamentoDTO)query.list().get(0);
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     }
		return intervento;
	}



	public static ArrayList<PrenotazioneAccessorioDTO> getListaPrenotazioniAccessori(String idIntervento, Session session) {
		ArrayList<PrenotazioneAccessorioDTO> lista =null;
		

		session.beginTransaction();
		Query query=null;
		String s_query = "from PrenotazioneAccessorioDTO WHERE id_intervento_campionamento = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idIntervento));
						
		lista=(ArrayList<PrenotazioneAccessorioDTO>) query.list();
		
		return lista;
	}



	public static ArrayList<PrenotazioniDotazioneDTO> getListaPrenotazioniDotazione(String idIntervento, Session session) {
		ArrayList<PrenotazioniDotazioneDTO> lista =null;
		
		session.beginTransaction();

		Query query=null;
		String s_query = "from PrenotazioniDotazioneDTO WHERE id_intervento_campionamento = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idIntervento));				
		lista=(ArrayList<PrenotazioniDotazioneDTO>) query.list();
		
		return lista;
	}



	public static ArrayList<DatasetCampionamentoDTO> getListaDataset(int idTipoCampionamento) {
		ArrayList<DatasetCampionamentoDTO> lista =null;
		
		try {
			
			Session session = SessionFacotryDAO.get().openSession();
		    
			session.beginTransaction();

			Query query=null;
			String s_query = "from DatasetCampionamentoDTO WHERE id_tipo_campionamento = :_id";
		    query = session.createQuery(s_query);
		    query.setParameter("_id",idTipoCampionamento);				
			lista=(ArrayList<DatasetCampionamentoDTO>) query.list();
			session.getTransaction().commit();
			session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     }
		return lista;
	}



	public static ArrayList<PlayloadCampionamentoDTO> getListaPayload(int idInterventoCampionamento, Session session) {
		ArrayList<PlayloadCampionamentoDTO> lista =null;
		
		try {
			
	
			Query query=null;
			String s_query = "from PlayloadCampionamentoDTO WHERE id_intervento_campionamento = :_id";
		    query = session.createQuery(s_query);
		    query.setParameter("_id",idInterventoCampionamento);				
			lista=(ArrayList<PlayloadCampionamentoDTO>) query.list();


	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		return lista;
	}



	public static void deleteOldPlayLoad(InterventoCampionamentoDTO intervento,Session session) {
		

		try {
			
	
			Query query=null;
			String s_query = "delete PlayloadCampionamentoDTO WHERE id_intervento_campionamento = :_id";
		    query = session.createQuery(s_query);
		    query.setParameter("_id",intervento.getId());				
			query.executeUpdate();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
	}



	public static ArrayList<PrenotazioniDotazioneDTO> getListaPrenotazioniDotazioneRange(String idDotazione,
			Date data, Session session) {
		
		ArrayList<PrenotazioniDotazioneDTO> lista =null;

		try {

			Query query=null;
			String s_query = "from PrenotazioniDotazioneDTO WHERE dotazione_id = :_id AND prenotato_dal >= :_data AND prenotato_al <= :_data ";
		    query = session.createQuery(s_query);
		    query.setParameter("_id",Integer.parseInt(idDotazione));	
		    query.setParameter("_data",data);		
			lista=(ArrayList<PrenotazioniDotazioneDTO>) query.list();


	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		return lista;

	}

	
}
