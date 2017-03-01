package it.portaleSTI.DAO;

import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class DirectMySqlDAO {
	
	private static  final String getPassword="SELECT PASSWORD(?)";  
	private static final String sqlDatiStrumento="select strumento.__id, sede.indirizzo, strumento.denominazione,strumento.codice_interno, " +
												 "strumento.costruttore , strumento.modello, " +
												 "(SELECT descrizione FROM classificazione WHERE __id=strumento.id__classificazione_) AS classificazione, strumento.matricola , strumento.risoluzione , strumento.campo_misura , scadenza.freq_verifica_mesi, " +
												 "(SELECT nome FROM tipo_rapporto WHERE scadenza.id__tipo_rapporto_=tipo_rapporto.__id) AS tipoRapporto,(SELECT nome FROM stato_strumento WHERE  strumento.id__stato_strumento_=stato_strumento.__id) AS StatoStrumento, " +
												 "(SELECT nome FROM template_rapporto WHERE strumento.id__template_rapporto_=template_rapporto.__id) as TempRapp,strumento.reparto,utilizzatore, " +
												 "(SELECT nome FROM procedura WHERE strumento__procedura_.id__Procedura_=procedura.__id) AS procedura, " +
												 "(SELECT file FROM versione_template_rapporto WHERE id__template_rapporto_=strumento.id__template_rapporto_ AND  versione_template_rapporto.__id=(SELECT MAX(__ID) from versione_template_rapporto WHERE versione_template_rapporto.id__template_rapporto_=strumento.id__template_rapporto_)) AS file, " +
												 "strumento.id__tipo_strumento_," +
												 "strumento.id__template_rapporto_ " +
												 "FROM (strumento LEFT JOIN sede ON strumento.id__sede_=sede.__id) INNER JOIN cliente on sede.id__cliente_=cliente.__id  " +
												 "INNER JOIN scadenza on strumento.__id =scadenza.id__strumento_ LEFT JOIN strumento__procedura_ on strumento.__id= strumento__procedura_.id__strumento_ " +
												 "WHERE strumento.id__sede_=? and strumento.__id=?";
	
	private static final String sqlDatiStrumentoAttivo="select strumento.__id,"+
													   "strumento.denominazione,strumento.codice_interno,"+
													   "strumento.costruttore , strumento.modello,"+
													   "strumento.matricola , strumento.risoluzione , strumento.campo_misura ,"+
													   "(SELECT nome FROM tipo_strumento WHERE __id=strumento.id__tipo_strumento_) as TipoStrumento,"+
													   "scadenza.freq_verifica_mesi,scadenza.data_ultima_verifica,scadenza.data_prossima_verifica,"+ 
													   "(SELECT nome FROM tipo_rapporto WHERE __id=scadenza.id__tipo_rapporto_) as TipoRapporto ,"+ 
													   "(SELECT nome FROM stato_strumento WHERE __id=strumento.id__stato_strumento_) as statoStrumento "+ 
													   "FROM strumento "+ 
													   "LEFT join Scadenza on strumento.__id=scadenza.id__strumento_ "+
													   "WHERE strumento.id__sede_=? AND id__company_=?"; 
	
	private static final String sqlDatiStrumentoAttivoNEW="select strumento.__id,"+
			   											  "strumento.denominazione,strumento.codice_interno,"+
			   											  "strumento.costruttore , strumento.modello,"+
			   											  "strumento.matricola , strumento.risoluzione , strumento.campo_misura ,"+
			   											  "(SELECT nome FROM tipo_strumento WHERE __id=strumento.id__tipo_strumento_) as TipoStrumento,"+
			   											  "scadenza.freq_verifica_mesi,scadenza.data_ultima_verifica,scadenza.data_prossima_verifica,"+ 
			   											  "(SELECT nome FROM tipo_rapporto WHERE __id=scadenza.id__tipo_rapporto_) as TipoRapporto ,"+ 
			   											  "(SELECT nome FROM stato_strumento WHERE __id=strumento.id__stato_strumento_) as statoStrumento "+ 
			   											  "FROM strumento "+ 
			   											  "LEFT join Scadenza on strumento.__id=scadenza.id__strumento_ "+
			   											  "WHERE strumento.id_cliente=? AND strumento.id__sede_new=? AND id__company_=?"; 
	
	
	private static final String sqlDatiCampione="select campione.codice,campione.matricola,campione.modello," +
														"taratura.num_certificato , taratura.data , taratura.data_scadenza," +
														"campione.freq_taratura_mesi,valore_campione.parametri_taratura," +
														"(SELECT simbolo FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM," +
														"(SELECT simbolo_normalizzato FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM_FOND," +
														"valore_campione.valore_taratura,valore_campione.valore_nominale,valore_campione.divisione_unita_misura," +
														"valore_campione.incertezza_assoluta,valore_campione.incertezza_relativa," +
														"valore_campione.id__tipo_grandezza_,campione.interpolazione_permessa," +
														"(SELECT nome FROM tipo_grandezza WHERE valore_campione.id__tipo_grandezza_=tipo_grandezza.__id) AS tipoGrandezza " +
														"FROM campione INNER join  taratura on campione.__id=taratura.id__campione_  " +
														"INNER JOIN valore_campione ON valore_campione.id__taratura_=taratura.__id";
	
	private static final String sqlDatiCampionePerStrumento="select Distinct(campione.codice) " +
												"from tipo_strumento__tipo_grandezza_ LEft join strumento  on strumento.id__tipo_strumento_=tipo_strumento__tipo_grandezza_.id__tipo_strumento_ " +
												"right join valore_campione on tipo_strumento__tipo_grandezza_.id__tipo_grandezza_=valore_campione.id__tipo_grandezza_ " +
												"left join taratura on valore_campione.id__taratura_=taratura.__id  " +
												"left JOIN campione on taratura.id__campione_=campione.__id " +
												"WHERE strumento.__id = ? and strumento.id__tipo_strumento_=?";
	
	
	private static final String sqlDatiScheda="SELECT * FROM punto_misura";
	
	private static final String sqlDatiSchedaPerStrumento="select tipo_misura.nome,template_rapporto__tipo_misura_.id__tipo_misura_,strumento.id__template_rapporto_ from " +
														  "strumento left join template_rapporto__tipo_misura_ ON strumento.id__template_rapporto_= template_rapporto__tipo_misura_.id__template_rapporto_ " +
														  "left join tipo_misura on tipo_misura.__id=template_rapporto__tipo_misura_.id__tipo_misura_  " +
														  "where strumento.__id=? and strumento.id__sede_=?";
	public static Connection getConnection()throws Exception {
		Connection con = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gtv_db?user=root&password=root");
		}
		catch(Exception e)
		{
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
			throw e;
		}
		return con;
	}
		
	public static Connection getConnectionSQL()throws Exception
		{
			Connection con=null;
			
			try
			{
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.200:1283;databaseName=ACSystem","sa","ionsByar79");
				
			}
			catch(Exception e)
			{
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
			throw ex;
		}finally
		{
			pst.close();
			con.close();
		}

		return toReturn;
	}
	
	public static List<StrumentoDTO> getRedordDatiStrumentoAvvivi(String idSede, int idCompany) throws Exception 
	{
		Connection con =null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		List<StrumentoDTO> listaStrumenti = new ArrayList<>();
		
		try
		{
			con=getConnection();
			pst=con.prepareStatement(sqlDatiStrumentoAttivo);
			pst.setString(1,idSede);
			pst.setInt(2,idCompany);
			
			
			rs=pst.executeQuery();
			StrumentoDTO strumento = null;
			ScadenzaDTO scadenza=null;
			while(rs.next())
			{
				strumento= new StrumentoDTO();
				scadenza= new ScadenzaDTO();
				
				strumento.set__id(rs.getInt("__id"));
				strumento.setDenominazione(rs.getString("denominazione"));
				strumento.setCodice_interno(rs.getString("codice_interno"));
				strumento.setCostruttore(rs.getString("costruttore"));
				strumento.setModello(rs.getString("modello"));
				strumento.setMatricola(rs.getString("matricola"));
				strumento.setRisoluzione(rs.getString("risoluzione"));
				strumento.setCampo_misura(rs.getString("campo_misura"));
				strumento.setRef_tipo_strumento(rs.getString("TipoStrumento"));
				scadenza.setFreq_mesi(rs.getInt("scadenza.freq_verifica_mesi"));
				scadenza.setDataUltimaVerifica(rs.getDate("scadenza.data_ultima_verifica"));
				scadenza.setDataProssimaVerifica(rs.getDate("scadenza.data_prossima_verifica"));
				scadenza.setRef_tipo_rapporto(rs.getString("tipoRapporto"));
				strumento.setRef_stato_strumento(rs.getString("statoStrumento"));
				
				strumento.setScadenzaDto(scadenza);
				
				listaStrumenti.add(strumento);
			}
			
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
		
		
		return listaStrumenti;
	}
	
	public static ArrayList<StrumentoDTO> getRedordDatiStrumentoAvviviNew(String id_cliente,String idSede, Integer idCompany) throws SQLException {
		Connection con =null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		ArrayList<StrumentoDTO> listaStrumenti = new ArrayList<StrumentoDTO>();
		
		try
		{
			con=getConnection();
			pst=con.prepareStatement(sqlDatiStrumentoAttivoNEW);
			pst.setString(1, id_cliente);
			pst.setString(2,idSede);
			pst.setInt(3,idCompany);
			
			
			rs=pst.executeQuery();
			StrumentoDTO strumento = null;
			ScadenzaDTO scadenza=null;
			while(rs.next())
			{
				strumento= new StrumentoDTO();
				scadenza= new ScadenzaDTO();
				
				strumento.set__id(rs.getInt("__id"));
				strumento.setDenominazione(rs.getString("denominazione"));
				strumento.setCodice_interno(rs.getString("codice_interno"));
				strumento.setCostruttore(rs.getString("costruttore"));
				strumento.setModello(rs.getString("modello"));
				strumento.setMatricola(rs.getString("matricola"));
				strumento.setRisoluzione(rs.getString("risoluzione"));
				strumento.setCampo_misura(rs.getString("campo_misura"));
				strumento.setRef_tipo_strumento(rs.getString("TipoStrumento"));
				scadenza.setFreq_mesi(rs.getInt("scadenza.freq_verifica_mesi"));
				scadenza.setDataUltimaVerifica(rs.getDate("scadenza.data_ultima_verifica"));
				scadenza.setDataProssimaVerifica(rs.getDate("scadenza.data_prossima_verifica"));
				scadenza.setRef_tipo_rapporto(rs.getString("tipoRapporto"));
				strumento.setRef_stato_strumento(rs.getString("statoStrumento"));
				
				strumento.setScadenzaDto(scadenza);
				
				listaStrumenti.add(strumento);
			}
			
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
		
		
		return  listaStrumenti;
	}
	
public static String getRedordDatiStrumento(String id, String idSede) throws Exception {
		
		Connection con =null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		String recordDati="";
		try
		{
			con=getConnection();
			pst=con.prepareStatement(sqlDatiStrumento);
			pst.setString(1,idSede);
			pst.setString(2,id);
			
			rs=pst.executeQuery();
			
			while(rs.next())
			{
				recordDati=rs.getString("__id")+";"+
				replace(rs.getString("indirizzo"))+";"+
				replace(rs.getString("denominazione"))+";"+
				replace(rs.getString("codice_interno"))+";"+
				replace(rs.getString("costruttore"))+";"+
				replace(rs.getString("modello"))+";"+
				replace(rs.getString("classificazione"))+";"+
				replace(rs.getString("matricola"))+";"+
				replace(rs.getString("risoluzione"))+";"+
				replace(rs.getString("campo_misura"))+";"+
				replace(rs.getString("freq_verifica_mesi"))+";"+
				replace(rs.getString("tipoRapporto"))+";"+
				replace(rs.getString("StatoStrumento"))+";"+
				replace(rs.getString("TempRapp"))+";"+
				replace(rs.getString("reparto"))+";"+
				replace(rs.getString("utilizzatore"))+";"+
				replace(rs.getString("procedura"))+";"+replace(Utility.getNomeFile(rs.getString("file")))+";"+
				replace(rs.getString("strumento.id__tipo_strumento_"));
							
			}
			
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
		
		
		return recordDati;
	}

public static ArrayList<String> getLiscaCampioni() throws SQLException {
	Connection con =null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	ArrayList<String> listaRecord= new ArrayList<String>();
	try
	{
		con=getConnection();
		pst=con.prepareStatement(sqlDatiCampione);
		
		rs=pst.executeQuery();
		
		String recordDati="";
		while(rs.next())
		{
			recordDati=replace(rs.getString("campione.codice"))+";"+
		    replace(rs.getString("campione.matricola"))+";"+
			replace(rs.getString("campione.modello"))+";"+
			replace(rs.getString("taratura.num_certificato"))+";"+
			replace(rs.getString("taratura.data"))+";"+
			replace(rs.getString("taratura.data_scadenza"))+";"+
			replace(rs.getString("campione.freq_taratura_mesi"))+";"+
			replace(rs.getString("valore_campione.parametri_taratura"))+";"+
			replace(rs.getString("UM"))+";"+
			replace(rs.getString("UM_FOND"))+";"+
			replace(rs.getString("valore_campione.valore_taratura"))+";"+
			replace(rs.getString("valore_campione.valore_nominale"))+";"+
			replace(rs.getString("valore_campione.divisione_unita_misura"))+";"+
			replace(rs.getString("valore_campione.incertezza_assoluta"))+";"+
			replace(rs.getString("valore_campione.incertezza_relativa"))+";"+
			replace(rs.getString("valore_campione.id__tipo_grandezza_"))+";"+
			replace(rs.getString("campione.interpolazione_permessa"))+";"+
			replace(rs.getString("tipoGrandezza"));
			listaRecord.add(recordDati);
						
		}
		
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
	
	
	return listaRecord;
}

private static String replace(String string) {
	
	if(string!=null)
	{
		string=string.replace(";"," ");
	}
	return string;
}

public static ArrayList<String> getCodiciCampioni(String codice_interno,String id_tipo_strumento) throws SQLException {
	Connection con =null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	ArrayList<String> listaCampioniPerStrumento= new ArrayList<String>();
	try
	{
		con=getConnection();
		pst=con.prepareStatement(sqlDatiCampionePerStrumento);
		pst.setString(1,codice_interno);
		pst.setString(2, id_tipo_strumento);
		
		rs=pst.executeQuery();
		
		while(rs.next())
		{
			
			listaCampioniPerStrumento.add(rs.getString(1));
						
		}
		
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
	return listaCampioniPerStrumento;
}

public static ArrayList<String> getLiscaSchede() throws SQLException {
	
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
		throw ex;
	}
	finally
	{
		pst.close();
		con.close();
		
	}
	
	
	return listaRecord;
}
}
