package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestioneCommesseDAO {

	private static String querySqlServerCom="SELECT * FROM BWT_COMMESSA WHERE ID_ANAGEN_COMM=?";

	public static ArrayList<CommessaDTO> getListaCommesse(CompanyDTO company) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		ArrayList<CommessaDTO> listaCommesse = new ArrayList<>();
		
		try
		{
		con =ManagerSQLServer.getConnectionSQL();
		pst=con.prepareStatement(querySqlServerCom);
		pst.setInt(1, company.getId());
		rs=pst.executeQuery();
		
		CommessaDTO commessa=null;
		while(rs.next())
		{
			commessa= new CommessaDTO();
			commessa.setID_COMMESSA(rs.getInt("ID_COMMESSA"));
			commessa.setDT_COMMESSA(rs.getDate("DT_COMMESSA"));
			commessa.setID_ANAGEN(rs.getInt("ID_ANAGEN"));
			commessa.setDESCR(rs.getString("DESCR"));
			commessa.setID_ANAGEN_COMM(rs.getInt("ID_ANAGEN_COMM"));
			commessa.setSYS_STATO(rs.getString("SYS_STATO"));
			
			listaCommesse.add(commessa);
			
		}
		
		}catch (Exception e) 
		{
		throw e;
		}
		return listaCommesse;
	}

}
