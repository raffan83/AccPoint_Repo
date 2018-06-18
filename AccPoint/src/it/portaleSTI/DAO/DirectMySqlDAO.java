package it.portaleSTI.DAO;

import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Properties;
import java.util.Set;

import org.hibernate.Session;

import it.portaleSTI.DTO.ColonnaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

public class DirectMySqlDAO {
	
	private static  final String getPassword="SELECT PASSWORD(?)";  
	
	private static final String sqlDatiStrumento="select strumento.__id,strumento.denominazione,strumento.codice_interno," +
												 "strumento.costruttore , strumento.modello, strumento.note," +
												 "strumento.id__classificazione_, strumento.matricola , strumento.risoluzione , strumento.campo_misura , scadenza.freq_verifica_mesi," +
												 "(SELECT __id FROM tipo_rapporto WHERE scadenza.id__tipo_rapporto_=tipo_rapporto.__id) AS tipoRapporto," +
												 "strumento.id__stato_strumento_," +
												 "strumento.reparto,utilizzatore," +
												 "(SELECT nome FROM procedura WHERE strumento__procedura_.id__Procedura_=procedura.__id) AS procedura," +
												 "strumento.id__tipo_strumento_ , scadenza" +
												 "FROM strumento LEFT JOIN scadenza on strumento.__id =scadenza.id__strumento_ LEFT JOIN strumento__procedura_ on strumento.__id= strumento__procedura_.id__strumento_ "+
												 "WHERE strumento.id_cliente=? and strumento.id__sede_new =? and strumento.id__company_=?";

	
	private static final String sqlDatiCampione="select campione.__id,campione.codice,campione.matricola,campione.modello, " +
			"campione.numero_certificato , campione.data_verifica , campione.data_scadenza, " +
			"campione.freq_taratura_mesi,valore_campione.parametri_taratura, " +
			"(SELECT simbolo FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM, " +
			"(SELECT simbolo_normalizzato FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM_FOND," +
			"valore_campione.valore_taratura,valore_campione.valore_nominale,valore_campione.divisione_unita_misura," +
			"valore_campione.incertezza_assoluta,valore_campione.incertezza_relativa," +
			"valore_campione.id__tipo_grandezza_,valore_campione.interpolato," +
			"(SELECT nome FROM tipo_grandezza WHERE valore_campione.id__tipo_grandezza_=tipo_grandezza.__id) AS tipoGrandezza " +
			"FROM campione " +
			"INNER JOIN valore_campione ON valore_campione.id__campione_=campione.__id AND valore_campione.obsoleto<>'S'  " +
			"WHERE campione.id_company_utilizzatore=? AND valore_campione.obsoleto='N' AND campione.stato_campione='S'";
	
	
	private static final String sqlDatiCampionePerStrumento="select Distinct(campione.__id)" +
			"from tipo_strumento__tipo_grandezza_ LEft join strumento  on strumento.id__tipo_strumento_=tipo_strumento__tipo_grandezza_.id__tipo_strumento_ " +
			"right join valore_campione on tipo_strumento__tipo_grandezza_.id__tipo_grandezza_=valore_campione.id__tipo_grandezza_ " +
			"left join taratura on valore_campione.id__campione_=taratura.id__campione_ " +
			"left JOIN campione on taratura.id__campione_=campione.__id " +
			"WHERE strumento.__id = ? and strumento.id__tipo_strumento_=? and campione.id_company_utilizzatore= ?";
	
	
	private static final String sqlDatiScheda="SELECT * FROM punto_misura";

	private static final String sqlDatiStrumentiPerGrafico = "SELECT a.reparto,b.freq_verifica_mesi,c.nome as stato_strumento, d.nome as tipo_strumento "
			+ "from strumento a " + 
			"left join scadenza b on a.__id=b.id__strumento_ " + 
			"left JOIN stato_strumento c on a.id__stato_strumento_=c.__id " + 
			"left join tipo_strumento d on a.id__tipo_strumento_=d.__id " + 
			"where a.id__company_=? AND a.id_cliente=? and id__sede_new=?";
	
	
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

public static void insertRedordDatiStrumento(int idCliente, int idSede,CompanyDTO cmp, String nomeCliente, Connection conSQLite,String indirizzoSede) throws Exception {
	
	
		Session session = SessionFacotryDAO.get().openSession();
    
		session.beginTransaction();
		
		PreparedStatement pstINS=null;
		
		String sqlInsert="";
		
		int idMisuraSQLite=1;
		
		int idTabella=1;
		
		try
		{
		
			conSQLite.setAutoCommit(false);
		
			
			ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(""+idCliente,""+idSede,cmp.getId(), session); 
			
			HashMap<Integer,Integer> listaMisure=getListaUltimaMisuraStrumento();
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			int i=1;
			
			if(indirizzoSede!=null && indirizzoSede.length()>0)
			{
				indirizzoSede=nomeCliente+" - "+indirizzoSede;
			}else
			{
				indirizzoSede=nomeCliente;
			}
			
			for (int j = 0; j < listaStrumentiPerSede.size(); j++) {
				
				StrumentoDTO strumento = listaStrumentiPerSede.get(j);
				int id=strumento.get__id();
				int tipoStrumento=strumento.getTipo_strumento().getId();
				String dataUltimaVerifica="";
				String dataProssimaVerifica="";
				
				
				if(strumento.getScadenzaDTO()!=null)
				{
				
						if(strumento.getScadenzaDTO().getDataUltimaVerifica()!=null)
						{
							dataUltimaVerifica=sdf.format(strumento.getScadenzaDTO().getDataUltimaVerifica());
						}
						
						if(strumento.getScadenzaDTO().getDataProssimaVerifica()!=null)
						{
							dataProssimaVerifica=sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica());
						}
					
				}else 
				{
					ScadenzaDTO scadenza= new ScadenzaDTO();
					scadenza.setFreq_mesi(0);
					scadenza.setTipo_rapporto(new TipoRapportoDTO(Costanti.ID_TIPO_RAPPORTO_SVT,""));
					
					Set<ScadenzaDTO> listaScadenza = new HashSet<>();
					
					listaScadenza.add(scadenza);
					strumento.setListaScadenzeDTO(listaScadenza);
				}
				
				String luogo="";
				
				if(strumento.getLuogo()!=null)
				{
					luogo=""+strumento.getLuogo().getId();
				}else
				{
					luogo="";
				}

				sqlInsert="INSERT INTO tblStrumenti VALUES(\""+id+"\",\""+indirizzoSede+"\",\""+
															Utility.getVarchar(strumento.getDenominazione())+"\",\""+
															Utility.getVarchar(strumento.getCodice_interno())+"\",\""+
															Utility.getVarchar(strumento.getCostruttore())+"\",\""+
															Utility.getVarchar(strumento.getModello())+"\",\""+
															strumento.getClassificazione().getId()+"\",\""+
															Utility.getVarchar(strumento.getMatricola())+"\",\""+
															Utility.getVarchar(strumento.getRisoluzione())+"\",\""+
															Utility.getVarchar(strumento.getCampo_misura())+"\",\""+
															strumento.getScadenzaDTO().getFreq_mesi()+"\",\""+
															strumento.getScadenzaDTO().getTipo_rapporto().getId()+"\",\""+
															strumento.getStato_strumento().getId()+"\",\""+
															Utility.getVarchar(strumento.getReparto())+"\",\""+
															Utility.getVarchar(strumento.getUtilizzatore())+"\",\""+
															Utility.getVarchar(strumento.getProcedure())+"\",\""+
															tipoStrumento+"\",\""+
															Utility.getVarchar(strumento.getNote())+"\",\"N\",\"N\"," +
															"\""+dataUltimaVerifica+"\",\""+dataProssimaVerifica+"\",\"\",\"N\",\"" +
															luogo+"\");";
				
				
				pstINS=conSQLite.prepareStatement(sqlInsert);
				pstINS.execute();
				
				
				Integer idMisura = listaMisure.get(id);

				if(idMisura!=null && idMisura!=0)
				{
					System.out.println(idMisura);
					MisuraDTO misura =GestioneMisuraDAO.getMiruraByID(idMisura);
					
				
					pstINS=conSQLite.prepareStatement("INSERT INTO tblMisure(id,id_str,statoMisura) VALUES(?,?,?)");
					pstINS.setInt(1, idMisuraSQLite);
					pstINS.setInt(2, id);
					pstINS.setInt(3, 2);
					
					pstINS.execute();
					
					
					Iterator<PuntoMisuraDTO> iterator = misura.getListaPunti().iterator();
				    while(iterator.hasNext()) {
				    	
				    	PuntoMisuraDTO punto = iterator.next();
				        
				    	pstINS=conSQLite.prepareStatement("INSERT INTO tblTabelleMisura(id,id_misura,id_tabella,id_ripetizione,ordine,tipoProva,label,tipoVerifica,val_misura_prec,val_campione_prec,applicabile,dgt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
				    	pstINS.setInt(1, idTabella);
				    	pstINS.setInt(2, idMisuraSQLite);
				    	pstINS.setInt(3, punto.getId_tabella());
				    	pstINS.setInt(4, punto.getId_ripetizione());
				    	pstINS.setInt(5, punto.getOrdine());
				    	pstINS.setString(6, punto.getTipoProva());
				    	pstINS.setString(7, "Punto");
				    	pstINS.setString(8, punto.getTipoVerifica());
				    	pstINS.setString(9, punto.getValoreStrumento().toPlainString());
				    	String descCamp="["+punto.getDesc_Campione()+"] - ["+punto.getDesc_parametro()+"] - "+ punto.getValoreCampione().toPlainString();
				    	pstINS.setString(10, descCamp);
				    	pstINS.setString(11, punto.getApplicabile());
				    	if(punto.getDgt()!=null) 
				    	{
				    		pstINS.setString(12, punto.getDgt().toPlainString());
				    	}
				    	else 
				    	{
				    		pstINS.setString(12, "0");
				    	}
				    	iterator.remove();			
				    	idTabella++;
				    	
				    	pstINS.execute();
				    }
				 idMisuraSQLite++;   
				}
			
				i++;
			}
			System.out.println("INSERT "+i+" STR");
			conSQLite.commit();
			
			session.close();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			session.getTransaction().rollback();
			throw ex;
		}
		
		
	}

public static HashMap<Integer, Integer> getListaUltimaMisuraStrumento() throws Exception {
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	HashMap<Integer, Integer> listaMisure = new HashMap<>();
	
	
	try {
		
		con=getConnection();
		pst=con.prepareStatement("select id_strumento,max(id) from misura group by id_strumento");
		rs=pst.executeQuery();
		
		while(rs.next())
		{
			listaMisure.put(rs.getInt(1), rs.getInt(2));
		}
		
	} 
	catch (Exception e) 
	{
		e.printStackTrace();
		throw e;
	}
	return listaMisure;
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

		 BigDecimal valoreTaratura=rs.getBigDecimal("valore_campione.valore_taratura");
		 BigDecimal valoreNominale=rs.getBigDecimal("valore_campione.valore_nominale");
		 BigDecimal divisione=rs.getBigDecimal("valore_campione.divisione_unita_misura");
		 BigDecimal incertezzaAssoluta=rs.getBigDecimal("valore_campione.incertezza_assoluta");
		 BigDecimal incertezzaRelativa=rs.getBigDecimal("valore_campione.incertezza_relativa");
		
		 if(valoreTaratura!=null)
		 {
			 valoreTaratura.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 valoreTaratura=BigDecimal.ZERO;
		 }
		 
		 if(valoreNominale!=null)
		 {
			 valoreNominale.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 valoreNominale=BigDecimal.ZERO;
		 }
		 
		 if(divisione!=null)
		 {
			 divisione.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 divisione=BigDecimal.ZERO;
		 }
		 
		 if(incertezzaAssoluta!=null)
		 {
			 incertezzaAssoluta.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 incertezzaAssoluta=BigDecimal.ZERO;
		 }
		 
		 if(incertezzaRelativa!=null)
		 {
			 incertezzaRelativa.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 incertezzaRelativa=BigDecimal.ZERO;
		 }
		 
			String sqlInsert="INSERT INTO tblCampioni VALUES("+rs.getInt("__id")+",\""+
			Utility.getVarchar(rs.getString("campione.codice"))+"\",\""+
			Utility.getVarchar( rs.getString("campione.matricola"))+"\",\""+
			Utility.getVarchar(rs.getString("campione.modello"))+"\",\""+
			Utility.getVarchar(rs.getString("campione.numero_certificato"))+"\",\'"+
			rs.getDate("campione.data_verifica")+"\',\'"+
			rs.getDate("campione.data_scadenza")+"\',\'"+
			rs.getInt("campione.freq_taratura_mesi")+"\',\""+
			Utility.getVarchar(rs.getString("valore_campione.parametri_taratura"))+"\",\""+
			Utility.getVarchar(rs.getString("UM"))+"\",\""+
			Utility.getVarchar(rs.getString("UM_FOND"))+"\",\'"+
			valoreTaratura+"\',\'"+
			valoreNominale+"\',\'"+
			divisione+"\',\'"+
			incertezzaAssoluta+"\',\'"+
			incertezzaRelativa+"\',\'"+
			rs.getInt("valore_campione.id__tipo_grandezza_")+"\',\'"+
			rs.getInt("valore_campione.interpolato")+"\',\""+
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

public static void insertLuogoVerifica(Connection conSQLLite) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM luogo_verifica");
		
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_luogoVerifica VALUES(?,?)";

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

public static Boolean checkDataSet(int idMatrice,int idAnalisi) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();

		pst=con.prepareStatement("SELECT * FROM dataset_campionamento WHERE id_tipo_matrice=? AND id_tipoAnalisi=?");
		pst.setInt(1, idMatrice);
		pst.setInt(2, idAnalisi);
		rs=pst.executeQuery();
	
		
		while(rs.next())
		{

			return true;
	
		}
		return false;
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
	
}


public static void insertDataSet(Connection conSQLLite,int idMatrice,int idAnalisi) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM dataset_campionamento WHERE id_tipo_matrice=? AND id_tipoAnalisi=?");
		pst.setInt(1, idMatrice);
		pst.setInt(2, idAnalisi);
		rs=pst.executeQuery();
	
		
	while(rs.next())
		{

			String sqlInsert="INSERT INTO tbl_dataset_campionamento VALUES(?,?,?,?,?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, rs.getInt("id"));
			pstINS.setInt(2, rs.getInt("id_tipo_matrice"));
			pstINS.setString(3, rs.getString("nome_campo"));
			pstINS.setString(4, rs.getString("tipo_campo"));
			pstINS.setString(5, rs.getString("codice_campo"));
			pstINS.setString(6, rs.getString("composite"));
			
			pstINS.execute();	
	
		}

		conSQLLite.commit();
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
	
}

public static void insertStatoStrumento(Connection conSQLLite) throws Exception {
	
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
		throw ex;
		
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

public static void insertGeneral(Connection conSQLLite, String nome_sede) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement("SELECT * FROM tipo_strumento");

		String sqlInsert="INSERT INTO tbl_general VALUES(?,?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			pstINS.setInt(1, 1);
			pstINS.setString(2, nome_sede);
			pstINS.setString(3,"N");
			
			pstINS.execute();	
	

		conSQLLite.commit();
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
}

public static void insertGeneralCMP(Connection conSQLLite, String id_COMMESSA,String cliente, String tipoMatrice, String tipologiaCampionamento, String tipoAnalisi) throws SQLException {
	
	PreparedStatement pstINS=null;
	
	try
	{
		conSQLLite.setAutoCommit(false);
									 
		String sqlInsert="INSERT INTO tbl_general(commessa,cliente,tipoMatrice,tipologiaCampionamento,tipoAnalisi,upload) VALUES(?,?,?,?,?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);
			
			
			pstINS.setString(1, id_COMMESSA);
			pstINS.setString(2, cliente);
			pstINS.setString(3,tipoMatrice);
			pstINS.setString(4,tipologiaCampionamento);
			pstINS.setString(5,tipoAnalisi);
			pstINS.setString(6, "N");
			
			pstINS.execute();	
	

		conSQLLite.commit();
	}
	catch(Exception ex)
	{
		throw ex;
	}
	finally
	{
		pstINS.close();
	//	conSQLLite.close();
		
	}
	
}

public static ArrayList<String> getListaCampioniString(CompanyDTO cmp)  throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
 		pst=con.prepareStatement(sqlDatiCampione);
		pst.setInt(1,cmp.getId());
		
		rs=pst.executeQuery();
	
		int i=1;
		
		ArrayList<String> rows = new ArrayList<String>();
		 String rowIntestazione="\"ID\";\"CODICE\";\"MATRICOLA\";\"MODELLO\";\"NUMERO CERTIFICATO\";\"DATA VERIFICA\";"+
				 	"\"DATA SCADENZA\";\"FREQUENZA TARATURA\";\"PARAMETRI TARATURA\";\"UNITA DI MISURA\";\"UNITA DI MISURA FONDAMENTALE\";"+
				 	"\"VALORE TARATURA\";\"VALORE NOMINALE\";\"DIVISIONE\";\"INCERTEZZA ASSOLUTA\";\"INCERTEZZA RELATIVA\";"+
				 	"\"ID TIPO GRANDEZZA\";\"INTERPOLAZIONE PERMESSA\";\"TIPO GRANDEZZA\";\"OBSOLETO\"";


		rows.add(rowIntestazione);
		while(rs.next())
		{

		 BigDecimal valoreTaratura=rs.getBigDecimal("valore_campione.valore_taratura");
		 BigDecimal valoreNominale=rs.getBigDecimal("valore_campione.valore_nominale");
		 BigDecimal divisione=rs.getBigDecimal("valore_campione.divisione_unita_misura");
		 BigDecimal incertezzaAssoluta=rs.getBigDecimal("valore_campione.incertezza_assoluta");
		 BigDecimal incertezzaRelativa=rs.getBigDecimal("valore_campione.incertezza_relativa");
		
		 if(valoreTaratura!=null)
		 {
			 valoreTaratura.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 valoreTaratura=BigDecimal.ZERO;
		 }
		 
		 if(valoreNominale!=null)
		 {
			 valoreNominale.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 valoreNominale=BigDecimal.ZERO;
		 }
		 
		 if(divisione!=null)
		 {
			 divisione.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 divisione=BigDecimal.ZERO;
		 }
		 
		 if(incertezzaAssoluta!=null)
		 {
			 incertezzaAssoluta.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 incertezzaAssoluta=BigDecimal.ZERO;
		 }
		 
		 if(incertezzaRelativa!=null)
		 {
			 incertezzaRelativa.setScale(Costanti.CIFRE_SIGNIFICATIVE, RoundingMode.HALF_UP);
		 }
		 else
		 {
			 incertezzaRelativa=BigDecimal.ZERO;
		 }
		 String row="\""+rs.getInt("__id")+"\";\""+
					Utility.getVarchar(rs.getString("campione.codice"))+"\";\""+
					Utility.getVarchar( rs.getString("campione.matricola"))+"\";\""+
					Utility.getVarchar(rs.getString("campione.modello"))+"\";\""+
					Utility.getVarchar(rs.getString("campione.numero_certificato"))+"\";\""+
					rs.getDate("campione.data_verifica")+"\";\""+
					rs.getDate("campione.data_scadenza")+"\";\""+
					rs.getInt("campione.freq_taratura_mesi")+"\";\""+
					Utility.getVarchar(rs.getString("valore_campione.parametri_taratura"))+"\";\""+
					Utility.getVarchar(rs.getString("UM"))+"\";\""+
					Utility.getVarchar(rs.getString("UM_FOND"))+"\";\""+
					valoreTaratura+"\";\""+
					valoreNominale+"\";\""+
					divisione+"\";\""+
					incertezzaAssoluta+"\";\""+
					incertezzaRelativa+"\";\""+
					rs.getInt("valore_campione.id__tipo_grandezza_")+"\";\""+
					rs.getInt("valore_campione.interpolato")+"\";\""+
					Utility.getVarchar(rs.getString("tipoGrandezza"))+"\";\"N\"";

		rows.add(row);
				
			i++;
		}
return rows;

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

public static ArrayList<StrumentoDTO> getListaStrumentiPerGrafico(String idCliente,String idSede, Integer idCompany) throws Exception {

	
	ArrayList<StrumentoDTO> lista =new ArrayList<StrumentoDTO>();
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs= null;
	
	try
	{
		con=getConnection();
 		pst=con.prepareStatement(sqlDatiStrumentiPerGrafico);
		pst.setInt(1,idCompany);
		pst.setString(2, idCliente);
		pst.setString(3, idSede);
		
		rs=pst.executeQuery();
		
		StrumentoDTO strumento= null;
		
		while(rs.next()) 
		{
			strumento= new StrumentoDTO();
			strumento.setReparto(rs.getString("reparto"));
			String freq = rs.getString("freq_verifica_mesi");
			if(freq!=null && freq.length()>0) 
			{
				strumento.setFrequenza(Integer.parseInt(freq));
			}else 
			{
				strumento.setFrequenza(0);
			}
			strumento.setTipo_strumento(new TipoStrumentoDTO(0, rs.getString("tipo_Strumento")));
			strumento.setStato_strumento(new StatoStrumentoDTO(0, rs.getString("stato_strumento")));
			
			lista.add(strumento);
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
	return lista;
}


	public static ArrayList<String> getListaTabelle(String[] tab) throws Exception {
		Connection conn = null;
		DatabaseMetaData md;
		
		ArrayList<String> lista = new ArrayList<String>();
		ArrayList<String> lista_to_return = new ArrayList<String>();
			conn=getConnection();
			md = conn.getMetaData();
			
			ResultSet rs = md.getTables(null, null, "%", null);
			
			while (rs.next()) {

			 
				  lista.add(rs.getString("TABLE_NAME"));

			}
			for(int i=0; i<lista.size();i++) {
				for(int j=0; j<tab.length;j++) {
					if(lista.get(i).equals(tab[j])) {
						lista_to_return.add(lista.get(i));
					}
				}
			}

			return lista_to_return;
	}

	
	public static ArrayList<ColonnaDTO> getListaColonne(String tabella) throws Exception {				
		
		ArrayList<ColonnaDTO> listaColonne= new ArrayList<ColonnaDTO>();
		
		
		ResultSet rs = getConnection().getMetaData().getColumns(null, null, tabella, null);
		
			while (rs.next()) {
				
				String res = rs.getString("COLUMN_NAME");
				if(tabella.equals("users")) {
					if(!res.equals("PASSW") && !res.equals("id_firma")
							&& !res.equals("reset_token")) {
						ColonnaDTO col = new ColonnaDTO();
						col.setName(res);
						
						listaColonne.add(col);
					}

				}
				else if(tabella.equals("company")) {
					if(!res.equals("email_pec") && !res.equals("pwd_pec")
							&& !res.equals("host_pec") && !res.equals("porta_pec")) {
						ColonnaDTO col = new ColonnaDTO();
						col.setName(res);
						
						listaColonne.add(col);
					}
					
				}else {
					ColonnaDTO col = new ColonnaDTO();
					col.setName(res);
					
					listaColonne.add(col);
						
					}
				
			}
			
			ResultSet rs3 = getConnection().getMetaData().getColumns(null, null, tabella, null);
			int index=0;
			while (rs3.next() && index<listaColonne.size()) {
				//ColonnaDTO col=new ColonnaDTO();
				//Class<?> x = ;
				//col.setTipo_dato(Utility.toClass(Integer.parseInt(rs3.getString("DATA_TYPE"))));
		
				listaColonne.get(index).setTipo_dato(Utility.toClass(Integer.parseInt(rs3.getString("DATA_TYPE"))));
			index++;
			}
			
			getConnection().close();;
		return listaColonne;
	}
	
	public static ArrayList<ArrayList<String>> getDatiTabella(String tabella, ArrayList<ColonnaDTO> colonne) throws Exception {				
		
		ArrayList<ArrayList<String>> lista =new ArrayList<ArrayList<String>>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		
		try
		{
			int index = colonne.size();
			con=getConnection();
			if(tabella.equals("users")) {
				pst=con.prepareStatement("select ID, USER, NOMINATIVO, Nome, Cognome, Indirizzo, Comune, cap, "
						+ "e_mail, telefono, id_company, TIPOUTENTE, id_cliente, id_sede, "
						+ "trasversale, cv, descrizione_company, abilitato from "+tabella);

			}else if(tabella.equals("company")) {
				pst=con.prepareStatement("select id, Denominazione, pIva, Indirizzo, Comune, Cap, mail, telefono, "
						+ "cod_affiliato, nome_logo from "+tabella);

			}
			else {
				pst=con.prepareStatement("select * from "+tabella);
			}
			
			rs=pst.executeQuery();
		
			while(rs.next()) 
			{
				ArrayList<String> riga = new ArrayList<String>();
				for(int i = 1; i<= index;i++) {	
					
					riga.add(rs.getString(i));
				}
				lista.add(riga);
				
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
		return lista;
	}
	

	public static ArrayList<ColonnaDTO> getListaNoK(String tabella, ArrayList<ColonnaDTO> colonne) throws Exception {				

		ArrayList<ColonnaDTO> lista = new ArrayList<ColonnaDTO>();
		ResultSet rs = getConnection().getMetaData().getImportedKeys(null, null, tabella);
		
		while (rs.next()) {
			ColonnaDTO col=new ColonnaDTO();
			col.setName(rs.getString("FKCOLUMN_NAME"));
			col.setFKTable(rs.getString("PKTABLE_NAME"));
			col.setFKTableColumn(rs.getString("PKCOLUMN_NAME"));
			col.setFkey(true);

			lista.add(col);
		
		}
		
		ResultSet rs2 = getConnection().getMetaData().getPrimaryKeys(null, null, tabella);
		
		while (rs2.next()) {
			
			ColonnaDTO col=new ColonnaDTO();
			col.setName(rs2.getString("COLUMN_NAME"));
			col.setPKey(true);
			lista.add(col);
			
		}
		
		
		for(int i = 0;i<colonne.size();i++) {
			for(int j= 0;j<lista.size();j++) {
				if(colonne.get(i).getName().equals(lista.get(j).getName())) {
					lista.get(j).setTipo_dato(colonne.get(i).getTipo_dato());
					colonne.set(i, lista.get(j));
					//colonne.get(i).setPKey(lista.get(j).getIsPKey());
					//colonne.get(i).setFkey(lista.get(j).getIsFkey());
					//colonne.get(i).
				}
			}
		}
		

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs4= null;
		
			con=getConnection();
	 		pst=con.prepareStatement("select * from "+tabella);
					
			rs4=pst.executeQuery();
			
		ResultSetMetaData rsMetaData = rs4.getMetaData();

		for(int i = 0;i<colonne.size();i++) {
			colonne.get(i).setNullable(rsMetaData.isNullable(i+1));
		}
		
		pst.close();
		con.close();
	
		return colonne;	

	}
	
	
	public static void updateTabellaDB(String tabella, ArrayList<String> valori, ArrayList<ColonnaDTO> colonne) throws Exception {
		 
		String query = "update "+tabella + " set ";
		String val = "";
		for(int i = 0; i<colonne.size(); i++) {
			if(valori.get(i)==null||valori.get(i).equals("null")) {
				val =val+ colonne.get(i).getName()+ " = "+ null+", ";
			}else {
			val =val+ colonne.get(i).getName()+ " = '"+ valori.get(i)+"', ";
			}
			
		}
		
		val=val.substring(0, val.length()-2);
		query = query + val + " where "+colonne.get(0).getName()+"= "+valori.get(0);
		Connection con=null;
		PreparedStatement pst=null;
	
			con=getConnection();
	 		pst=con.prepareStatement(query);
					
			pst.executeUpdate();
			
			pst.close();
			con.close();
		
	}

	public static void nuovaRigaTabellaDB(String tabella, ArrayList<String> valori,ArrayList<ColonnaDTO> colonne) throws Exception {
		
		String query = "insert into "+tabella + " values(default, '";
		String val = "";
		
		for(int i = 1; i<colonne.size(); i++) {
			if(valori.get(i)==null||valori.get(i).equals("null")) {
				val=val.substring(0, val.length()-1);
				val =val+ null+", '";
			}else {
				val =val+ valori.get(i)+"', '";
			}
			
		}
		
		val=val.substring(0, val.length()-3);
		val=val + ")";
		query = query + val;
		Connection con=null;
		PreparedStatement pst=null;
	
			con=getConnection();
	 		pst=con.prepareStatement(query);
					
			pst.executeUpdate();
			
			pst.close();
			con.close();
		
	}

		
	
	
}
