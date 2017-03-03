package it.portaleSTI.DAO;

import it.portaleSTI.DTO.PrenotazioneDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestionePrenotazioneDAO {

	private static final String sqlPrenotazione="SELECT pc.*,ca.nome,ca.matricola, ca.id_company, ca.id_company_utilizzatore " +
			"FROM prenotazioni_campione pc " +
			"LEFT JOIN campione ca on pc.id_campione=ca.__id " +
			"WHERE ca.id_company=?";
	
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
				prenotazione.setDataApprovazione(rs.getDate("dataApprovazione"));
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

}
