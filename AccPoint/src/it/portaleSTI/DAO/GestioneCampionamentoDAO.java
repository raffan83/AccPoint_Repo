package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

				articolo.setListaAccessori(getListaAccessori(idANAART,company));
			//	articolo.setListaDotazioni(getListaDotazioni());
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

	private static ArrayList<AccessorioDTO> getListaAccessori(String idANAART, CompanyDTO company) throws Exception {
		
		ArrayList<AccessorioDTO> listaAccesori = new ArrayList<AccessorioDTO>();
		
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("SELECT id_accessorio FROM articolo_accessorio WHERE id_articolo=?");
			pst.setString(1, idANAART);
			
			rs=pst.executeQuery();
			
			AccessorioDTO accessorio=null;
			
			while(rs.next())
			{
				accessorio= GestioneAccessorioDAO.getAccessorioById(rs.getString("id_accessorio"));
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

	
}
