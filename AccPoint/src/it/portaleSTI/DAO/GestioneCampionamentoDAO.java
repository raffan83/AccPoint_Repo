package it.portaleSTI.DAO;

import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestioneCampionamentoDAO {

	private static final String query = "SELECT ID_ANAART , DESCR FROM dbo.BWT_ANAART WHERE ID_ANAGEN_COMPANY=?";

	public static ArrayList<ArticoloMilestoneDTO> getListaArticoli(CompanyDTO company) throws Exception {
		
			Connection con=null;
			PreparedStatement pst=null;
			PreparedStatement pstA=null;
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
			    articolo.setID_ANAART(rs.getString("ID_ANAART"));
				articolo.setDESCR(rs.getString("DESCR"));

				listaArticoli.add(articolo);
				
			}
			
			}catch (Exception e) 
			{
			throw e;
			}
			return listaArticoli;
		
	}

	public static ArrayList<ArticoloMilestoneDTO> getListaAccessoriArticolo(ArticoloMilestoneDTO articolo) {
		// TODO Auto-generated method stub
		return null;
	}

}
