package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GestioneCommesseDAO {

	private static String querySqlServerCom="SELECT ID_COMMESSA,DT_COMMESSA,FIR_CHIUSURA_DT, B.ID_ANAGEN,b.NOME," +
			"a.DESCR,a.SYS_STATO,C.K2_ANAGEN_INDIR,C.DESCR,C.INDIR " +
			"FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_COMMESSA]AS a " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN] AS b ON  a.ID_ANAGEN=b.ID_ANAGEN " +
			"LEFT JOIN [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAGEN_INDIR] AS c on a.K2_ANAGEN_INDIR=c.K2_ANAGEN_INDIR AND a.ID_ANAGEN=c.ID_ANAGEN " +
			"WHERE ID_ANAGEN_COMM=?";
	
	private static String querySqlAttivitaCom="SELECT a.descr as DESC_ATT,a.note AS NOTE_ATT,b.DESCR as DESC_ART,a.QTA AS QUANTITA " +
										"from [BTOMEN_CRESCO_DATI].[dbo].[BWT_COMMESSA_AVANZ] AS a " +
										"Left join [BTOMEN_CRESCO_DATI].[dbo].[BWT_ANAART] AS b ON a.ID_ANAART =b.ID_ANAART " +
										"where ID_COMMESSA=?";

	public static ArrayList<CommessaDTO> getListaCommesse(CompanyDTO company) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstA=null;
		ResultSet rs=null;
		ResultSet rsA=null;
		
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
			String idCommessa=rs.getString(1);
			commessa.setID_COMMESSA(idCommessa);
			commessa.setDT_COMMESSA(rs.getDate(2));
			commessa.setFIR_CHIUSURA_DT(rs.getDate(3));
			commessa.setID_ANAGEN(rs.getInt(4));
			commessa.setID_ANAGEN_NOME(rs.getString(5));
			commessa.setDESCR(rs.getString(6));
			commessa.setID_ANAGEN_COMM(company.getId());
			commessa.setSYS_STATO(rs.getString(7));
			commessa.setK2_ANAGEN_INDR(rs.getInt(8));
			commessa.setANAGEN_INDR_DESCR(rs.getString(9));
			commessa.setANAGEN_INDR_INDIRIZZO(rs.getString(10));
			
			pstA=con.prepareStatement(querySqlAttivitaCom);
			pstA.setString(1,idCommessa );
			rsA=pstA.executeQuery();
			
			while(rsA.next())
			{
				AttivitaMilestoneDTO attivita = new AttivitaMilestoneDTO();
				attivita.setDescrizioneAttivita(rsA.getString("DESC_ATT"));
				attivita.setNoteAttivita(rsA.getString("NOTE_ATT"));
				attivita.setDescrizioneArticolo(rsA.getString("DESC_ART"));
				attivita.setQuantita(rsA.getString("QUANTITA"));
				
				commessa.getListaAttivita().add(attivita);
			}
			rsA.close();
			pstA.close();
			
			listaCommesse.add(commessa);
			
		}
		
		}catch (Exception e) 
		{
		throw e;
		}
		return listaCommesse;
	}

}
