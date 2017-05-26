package it.portaleSTI.DAO;

import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

public class DirectMySqlDAO {
	
	private static  final String getPassword="SELECT PASSWORD(?)";  
	
	private static final String sqlDatiStrumento="select strumento.__id,strumento.denominazione,strumento.codice_interno," +
												 "strumento.costruttore , strumento.modello, strumento.note," +
												 "strumento.id__classificazione_, strumento.matricola , strumento.risoluzione , strumento.campo_misura , scadenza.freq_verifica_mesi," +
												 "(SELECT __id FROM tipo_rapporto WHERE scadenza.id__tipo_rapporto_=tipo_rapporto.__id) AS tipoRapporto," +
												 "strumento.id__stato_strumento_," +
												 "strumento.reparto,utilizzatore," +
												 "(SELECT nome FROM procedura WHERE strumento__procedura_.id__Procedura_=procedura.__id) AS procedura," +
												 "strumento.id__tipo_strumento_ " +
												 "FROM strumento LEFT JOIN scadenza on strumento.__id =scadenza.id__strumento_ LEFT JOIN strumento__procedura_ on strumento.__id= strumento__procedura_.id__strumento_ "+
												 "WHERE strumento.id_cliente=? and strumento.id__sede_new =? and strumento.id__company_=?";

	
	private static final String sqlDatiCampione="select campione.__id,campione.codice,campione.matricola,campione.modello, " +
			"taratura.num_certificato , taratura.data , taratura.data_scadenza," +
			" campione.freq_taratura_mesi,valore_campione.parametri_taratura, " +
			"(SELECT simbolo FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM," +
			"(SELECT simbolo_normalizzato FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM_FOND," +
			" valore_campione.valore_taratura,valore_campione.valore_nominale,valore_campione.divisione_unita_misura," +
			" valore_campione.incertezza_assoluta,valore_campione.incertezza_relativa," +
			" valore_campione.id__tipo_grandezza_,campione.interpolazione_permessa," +
			"(SELECT nome FROM tipo_grandezza WHERE valore_campione.id__tipo_grandezza_=tipo_grandezza.__id) AS tipoGrandezza" +
			" FROM campione INNER join  taratura on campione.__id=taratura.id__campione_ " +
			"INNER JOIN valore_campione ON valore_campione.id__campione_=taratura.id__campione_ " +
			"WHERE campione.id_company_utilizzatore=?";
	
	
	private static final String sqlDatiCampionePerStrumento="select Distinct(campione.__id)" +
			"from tipo_strumento__tipo_grandezza_ LEft join strumento  on strumento.id__tipo_strumento_=tipo_strumento__tipo_grandezza_.id__tipo_strumento_ " +
			"right join valore_campione on tipo_strumento__tipo_grandezza_.id__tipo_grandezza_=valore_campione.id__tipo_grandezza_ " +
			"left join taratura on valore_campione.id__campione_=taratura.id__campione_ " +
			"left JOIN campione on taratura.id__campione_=campione.__id " +
			"WHERE strumento.__id = ? and strumento.id__tipo_strumento_=? and campione.id_company_utilizzatore= ?";
	
	
	private static final String sqlDatiScheda="SELECT * FROM punto_misura";
	
	private static final String sqlDatiSchedaPerStrumento="select tipo_misura.nome,template_rapporto__tipo_misura_.id__tipo_misura_,strumento.id__template_rapporto_ from " +
														  "strumento left join template_rapporto__tipo_misura_ ON strumento.id__template_rapporto_= template_rapporto__tipo_misura_.id__template_rapporto_ " +
														  "left join tipo_misura on tipo_misura.__id=template_rapporto__tipo_misura_.id__tipo_misura_  " +
														  "where strumento.__id=? and strumento.id__sede_=?";

	private static String sqlInsertCampioniAssociati="INSERT INTO tblCampioniAssociati(id_str,camp_ass) VALUES(?,?)";

	private static String sqlDatiTipoGrandezza_TS="SELECT * FROM tipo_strumento__tipo_grandezza_";
	
	private static String sqlFattoriMoltiplicativi="SELECT * FROM fattori_moltiplicativi";
	
	private static String sqlConversione="SELECT * FROM conversione";
	
	public static Connection getConnection()throws Exception {
		Connection con = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(Costanti.CON_STR_MYSQL);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		return con;
	}

	public static Connection getConnectionLocal(String path)throws Exception {
		Connection con = null;
		
		Properties prop = System.getProperties();

		prop.put("jdbc.drivers","sun.jdbc.odbc.JdbcOdbcDriver");

		
		System.setProperties(prop); 
		try
		{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			con = DriverManager.getConnection("jdbc:odbc:;DRIVER=Microsoft Access Driver (*.mdb);DBQ="+path);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		return con;
	}


	public static String getPassword(String pwd) throws Exception
	{
		String toReturn="";
		PreparedStatement pst=null;
		ResultSet rs= null;
		Connection con=null;
		try{
			con = getConnection();	
			pst=con.prepareStatement(getPassword);
			pst.setString(1,pwd);
			rs=pst.executeQuery();
			rs.next();
			toReturn=rs.getString(1);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
			
		}finally
		{
			pst.close();
			con.close();
		}

		return toReturn;
	}

public static ArrayList<String> insertRedordDatiStrumento(int idCliente, int idSede,CompanyDTO cmp, Connection conSQLite,String indirizzoSede) throws Exception {
		
		Connection con =null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;
		String sqlInsert="";
		ArrayList<String> listaRecordDati= new ArrayList<>();
		try
		{
			con=getConnection();
			conSQLite.setAutoCommit(false);
			pst=con.prepareStatement(sqlDatiStrumento);
			
			pst.setInt(1,idCliente);
			pst.setInt(2,idSede);
			pst.setInt(3, cmp.getId());
			
			rs=pst.executeQuery();
		
			int i=1;
			while(rs.next())
			{
				int id=rs.getInt("__id");
				int tipoStrumento=rs.getInt("strumento.id__tipo_strumento_");
				
				sqlInsert="INSERT INTO tblStrumenti VALUES(\""+id+"\",\""+indirizzoSede+"\",\""+
															Utility.getVarchar(rs.getString("denominazione"))+"\",\""+
															Utility.getVarchar(rs.getString("codice_interno"))+"\",\""+
															Utility.getVarchar(rs.getString("costruttore"))+"\",\""+
															Utility.getVarchar(rs.getString("modello"))+"\",\""+
															Utility.getVarchar(rs.getString("id__classificazione_"))+"\",\""+
															Utility.getVarchar(rs.getString("matricola"))+"\",\""+
															Utility.getVarchar(rs.getString("risoluzione"))+"\",\""+
															Utility.getVarchar(rs.getString("campo_misura"))+"\",\""+
															Utility.getVarchar(rs.getString("freq_verifica_mesi"))+"\",\""+
															Utility.getVarchar(rs.getString("tipoRapporto"))+"\",\""+
															Utility.getVarchar(rs.getString("id__stato_strumento_"))+"\",\""+
															Utility.getVarchar(rs.getString("reparto"))+"\",\""+
															Utility.getVarchar(rs.getString("utilizzatore"))+"\",\""+
															Utility.getVarchar(rs.getString("procedura"))+"\",\""+
															tipoStrumento+"\",\""+
															Utility.getVarchar(rs.getString("note"))+"\",\"N\",\"N\")";
				
				listaRecordDati.add(id+";"+tipoStrumento);
			
				System.out.println(sqlInsert);
				pstINS=conSQLite.prepareStatement(sqlInsert);
				
				pstINS.execute();
				
				i++;
			}
			System.out.println("INSERT "+i+" STR");
			conSQLite.commit();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
		finally
		{
			pst.close();
			con.close();
			
		}
		
		
		return listaRecordDati;
	}

public static void insertListaCampioni(Connection conSQLLite, CompanyDTO cmp)  throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement(sqlDatiCampione);
		pst.setInt(1,cmp.getId());
		
		rs=pst.executeQuery();
	
		int i=1;
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tblCampioni VALUES("+rs.getInt("__id")+",\""+
			Utility.getVarchar(rs.getString("campione.codice"))+"\",\""+
			Utility.getVarchar( rs.getString("campione.matricola"))+"\",\""+
			Utility.getVarchar(rs.getString("campione.modello"))+"\",\""+
			Utility.getVarchar(rs.getString("taratura.num_certificato"))+"\",\'"+
			rs.getDate("taratura.data")+"\',\'"+
			rs.getDate("taratura.data_scadenza")+"\',\'"+
			rs.getInt("campione.freq_taratura_mesi")+"\',\""+
			Utility.getVarchar(rs.getString("valore_campione.parametri_taratura"))+"\",\""+
			Utility.getVarchar(rs.getString("UM"))+"\",\""+
			Utility.getVarchar(rs.getString("UM_FOND"))+"\",\'"+
			rs.getFloat("valore_campione.valore_taratura")+"\',\'"+
			rs.getFloat("valore_campione.valore_nominale")+"\',\'"+
			rs.getFloat("valore_campione.divisione_unita_misura")+"\',\'"+
			rs.getFloat("valore_campione.incertezza_assoluta")+"\',\'"+
			rs.getFloat("valore_campione.incertezza_relativa")+"\',\'"+
			rs.getInt("valore_campione.id__tipo_grandezza_")+"\',\'"+
			rs.getInt("campione.interpolazione_permessa")+"\',\""+
			Utility.getVarchar(rs.getString("tipoGrandezza"))+"\",\"N\")";
			
			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.execute();	
			i++;
		}
		System.out.println("INSERT "+i+" CMP");
		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}	
}

private static String replace(String string) {
	
	if(string!=null)
	{
		string=string.replace(";"," ");
	}
	return string;
}

public static String getCodiciCampioni(String id_str,String id_tipo_strumento,CompanyDTO cmp) throws Exception {
	Connection con =null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	String listaCampioniPerStrumento="";
	try
	{
		con=getConnection();
		pst=con.prepareStatement(sqlDatiCampionePerStrumento);
		pst.setString(1,id_str);
		pst.setString(2, id_tipo_strumento);
		pst.setInt(3, cmp.getId());
		
		rs=pst.executeQuery();
		
		while(rs.next())
		{
			
			listaCampioniPerStrumento=listaCampioniPerStrumento+";"+(rs.getString(1));
						
		}
		
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}
	return listaCampioniPerStrumento;
}

public static ArrayList<String> getListaSchede() throws Exception {
	
	Connection con =null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	ArrayList<String> listaRecord= new ArrayList<String>();
	try
	{
		con=getConnection();
		pst=con.prepareStatement(sqlDatiScheda);
		
		rs=pst.executeQuery();
		
		String recordDati="";
		while(rs.next())
		{
			recordDati=replace(rs.getString("id__tipo_misura_"))+";"+
					   replace(rs.getString("descrizione"))+";"+
					   replace(rs.getString("ordinamento"));
					 
			listaRecord.add(recordDati);
						
		}
		
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}
	
	
	return listaRecord;
}

public static ArrayList<String> getSchede(String id, String idSede) throws Exception {
	Connection con =null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	ArrayList<String> listaRecord= new ArrayList<String>();
	try
	{
		con=getConnection();
		
		pst=con.prepareStatement(sqlDatiSchedaPerStrumento);
		pst.setString(1, id);
		pst.setString(2, idSede);
		
		rs=pst.executeQuery();
		
		String recordDati="";
		while(rs.next())
		{
			recordDati=id+";"+
					replace(rs.getString("template_rapporto__tipo_misura_.id__tipo_misura_"))+";"+
					replace(rs.getString("tipo_misura.nome"));
					 
			listaRecord.add(recordDati);
						
		}
		
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}
	
	
	return listaRecord;
}

public static void insertCampioniAssociati(Connection conSQLLite, String id_str, String listaCamp) throws SQLException {
	
	PreparedStatement pst=null;
	conSQLLite.setAutoCommit(false);
	try
	{
		conSQLLite.setAutoCommit(false);
		pst=conSQLLite.prepareStatement(sqlInsertCampioniAssociati);
		pst.setString(1, id_str);
		pst.setString(2, listaCamp);
	
		pst.execute();
		
	conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
	//	conSQLLite.close();
		
	}	
	
}

public static void insertTipoGrandezza_TipoStrumento(Connection conSQLLite) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement(sqlDatiTipoGrandezza_TS);
		rs=pst.executeQuery();	
	
		while(rs.next())
		{
			
			String sqlInsert="INSERT INTO tbl_ts_tg VALUES(?,?)";
			pstINS=conSQLLite.prepareStatement(sqlInsert);
			pstINS.setInt(1,rs.getInt("id__tipo_grandezza_"));
			pstINS.setInt(2,rs.getInt("id__tipo_strumento_"));
			
			pstINS.execute();	
			
		}
		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}	
	
}
public static void insertFattoriMoltiplicativi(Connection conSQLLite) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement(sqlFattoriMoltiplicativi);
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_fattori_moltiplicativi VALUES(\""+Utility.getVarchar(rs.getString("descrizione"))+"\",\""+
			Utility.getVarchar(rs.getString("sigla"))+"\","+
			rs.getDouble("potenza")+","+
			rs.getBigDecimal("fm")+");";
			
			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.execute();	
	
		}

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}	
	
}

public static void insertConversioni(Connection conSQLLite) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement(sqlConversione);
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_conversione VALUES("+rs.getInt("Id")+",\""+Utility.getVarchar(rs.getString("um_da"))+"\",\""+
			Utility.getVarchar(rs.getString("um_a"))+"\","+
			rs.getBigDecimal("fattoreConversione")+",\""+
			Utility.getVarchar(rs.getString("um"))+"\",\""+
			Utility.getVarchar(rs.getString("tipo_misura"))+"\",\""+
			Utility.getVarchar(rs.getString("validita"))+"\","+
			rs.getInt("potenza")+");";
			
			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.execute();	
		}

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}	
	
}

public static void insertClassificazione(Connection conSQLLite) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM Classificazione");
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_classificazione VALUES(?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, rs.getInt("__id"));
			pstINS.setString(2, rs.getString("descrizione"));
			
			pstINS.execute();	
		}

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}
	
}

public static void insertTipoRapporto(Connection conSQLLite) throws SQLException {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM tipo_Rapporto");
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_tipoRapporto VALUES(?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, rs.getInt("__id"));
			pstINS.setString(2, rs.getString("nome"));
			
			pstINS.execute();	
		}

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
	}
	finally
	{
		pst.close();
		con.close();
		
	}
	
}

public static void insertStatoStrumento(Connection conSQLLite) throws SQLException {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM stato_strumento");
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_statoStrumento VALUES(?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, rs.getInt("__id"));
			pstINS.setString(2, rs.getString("nome"));
			
			pstINS.execute();	
		}

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
	}
	finally
	{
		pst.close();
		con.close();
		
	}

}

public static void insertTipoStrumento(Connection conSQLLite) throws SQLException {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM tipo_strumento");
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_tipoStrumento VALUES(?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, rs.getInt("__id"));
			pstINS.setString(2, rs.getString("nome"));
			
			pstINS.execute();	
		}

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
	}
	finally
	{
		pst.close();
		con.close();
		
	}

}

public static void insertGeneral(Connection conSQLLite, String nome_sede) throws SQLException {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM tipo_strumento");

		String sqlInsert="INSERT INTO tbl_general VALUES(?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, 1);
			pstINS.setString(2, nome_sede);
			
			pstINS.execute();	
	

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
	}
	finally
	{
		pst.close();
		con.close();
		
	}
}

}
