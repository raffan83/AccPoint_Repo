package it.portaleSTI.DAO;

import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

public class GestionePrenotazioneDAO {

	private static final String sqlPrenotazioneRichieste="SELECT pc.*,ca.nome,ca.matricola, ca.id_company, ca.id_company_utilizzatore " +
			"FROM prenotazioni_campione pc " +
			"LEFT JOIN campione ca on pc.id_campione=ca.__id " +
			"WHERE ca.id_company=? AND pc.stato=0";
	
	private static final String sqlPrenotazione="SELECT pc.*,ca.nome,ca.matricola, ca.id_company, ca.id_company_utilizzatore " +
			"FROM prenotazioni_campione pc " +
			"LEFT JOIN campione ca on pc.id_campione=ca.__id " +
			"WHERE ca.id_company=? ";

	private static String sqlUpdatePrenotazione="UPDATE prenotazioni_campione SET stato=?, dataGestione=now(),noteApprovazione=? WHERE id=?";
	
	public static ArrayList<PrenotazioneDTO> getListaPrenotazioniRichieste(int myId) throws Exception {
		
		
		ArrayList<PrenotazioneDTO> listaPrenotazioneDTO= new ArrayList<>();
		
		Connection con =null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement(sqlPrenotazioneRichieste);
			pst.setInt(1, myId);
			
			rs=pst.executeQuery();
			
			PrenotazioneDTO prenotazione=null;
			
			while(rs.next())
			{
				prenotazione=new PrenotazioneDTO();
				prenotazione.setId(rs.getInt("id"));
				prenotazione.setId_campione(rs.getInt("id_campione"));
				prenotazione.setId_companyRichiedente(rs.getInt("id_company_richiesta"));
				prenotazione.setId_userRichiedente(rs.getInt("id_user_richiesta"));
				prenotazione.setDataRichiesta(rs.getDate("dataRichiesta"));
				prenotazione.setDataGestione(rs.getDate("dataGestione"));
				prenotazione.setStato(rs.getInt("stato"));
				prenotazione.setPrenotatoDal(rs.getDate("prenotatoDal"));
				prenotazione.setPrenotatoAl(rs.getDate("prenotatoAl"));
				prenotazione.setNote(rs.getString("note"));
				prenotazione.setNomeCampione(rs.getString("ca.nome"));
				prenotazione.setMatricolaCampione(rs.getString("ca.matricola"));
				prenotazione.setId_company(rs.getInt("ca.id_Company"));
				prenotazione.setId_company_utilizzatrice(rs.getInt("ca.id_company_utilizzatore"));
				
				
				listaPrenotazioneDTO.add(prenotazione);
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
		
		return listaPrenotazioneDTO;
	}
		
		public static ArrayList<PrenotazioneDTO> getListaPrenotazioni(int myId) throws Exception {
			
			
			ArrayList<PrenotazioneDTO> listaPrenotazioneDTO= new ArrayList<>();
			
			Connection con =null;
			PreparedStatement pst=null;
			ResultSet rs=null;
			
			try 
			{
				con=DirectMySqlDAO.getConnection();
				pst=con.prepareStatement(sqlPrenotazione);
				pst.setInt(1, myId);
				
				rs=pst.executeQuery();
				
				PrenotazioneDTO prenotazione=null;
				
				while(rs.next())
				{
					prenotazione=new PrenotazioneDTO();
					prenotazione.setId(rs.getInt("id"));
					prenotazione.setId_campione(rs.getInt("id_campione"));
					prenotazione.setId_companyRichiedente(rs.getInt("id_company_richiesta"));
					prenotazione.setId_userRichiedente(rs.getInt("id_user_richiesta"));
					prenotazione.setDataRichiesta(rs.getDate("dataRichiesta"));
					prenotazione.setDataGestione(rs.getDate("dataGestione"));
					prenotazione.setStato(rs.getInt("stato"));
					prenotazione.setPrenotatoDal(rs.getDate("prenotatoDal"));
					prenotazione.setPrenotatoAl(rs.getDate("prenotatoAl"));
					prenotazione.setNote(rs.getString("note"));
					prenotazione.setNomeCampione(rs.getString("ca.nome"));
					prenotazione.setMatricolaCampione(rs.getString("ca.matricola"));
					prenotazione.setId_company(rs.getInt("ca.id_Company"));
					prenotazione.setId_company_utilizzatrice(rs.getInt("ca.id_company_utilizzatore"));
					
					
					listaPrenotazioneDTO.add(prenotazione);
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
		
		
		return listaPrenotazioneDTO;
	}

		public static void updatePrenotazione(int idPrenotazione, String note, int stato) throws Exception {
			
			Connection con =null;
			PreparedStatement pst =null;
			
			try 
			{
				con=DirectMySqlDAO.getConnection();
				
				pst=con.prepareStatement(sqlUpdatePrenotazione);
				
				pst.setInt(1,stato);
			
				pst.setString(2, note);
				pst.setInt(3, idPrenotazione);
				pst.execute();
				
				
			} catch (Exception e) 
			{
				throw e;	
			}
			
		}

		public static PrenotazioneDTO getPrenotazione(int idPrenotazione) {
			
			Query query=null;
			PrenotazioneDTO prenotazione=null;
			try {
				
			Session session = SessionFacotryDAO.get().openSession();
		    
			session.beginTransaction();
			
			String s_query = "from PrenotazioneDTO WHERE id = :_id";
		    query = session.createQuery(s_query);
		    query.setParameter("_id",idPrenotazione);
			
		    prenotazione=(PrenotazioneDTO)query.list().get(0);
			session.getTransaction().commit();
			session.close();

		     } catch(Exception e)
		     {
		    	 e.printStackTrace();
		     }
			return prenotazione;
		}

}
