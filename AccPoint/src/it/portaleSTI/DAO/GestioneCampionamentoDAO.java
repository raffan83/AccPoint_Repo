package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.TipoCampionamentoDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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

	
}
