package it.portaleSTI.DAO;

import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoRicezioneStrumentoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Util.Costanti;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class SQLLiteDAO {

private static String sqlCreateStrumentTable="CREATE TABLE tblStrumenti(id Integer primary key autoincrement , " +
																		"indirizzo varchar(255),"+
																		"denominazione varchar(255),"+
																		"codice_interno varchar(255),"+
																		"costruttore varchar(255),"+
																		"modello varchar(255),"+
																		"classificazione varchar(255),"+
																		"matricola varchar(255),"+
																		"risoluzione varchar(255),"+
																		"campo_misura varchar(255),"+
																		"freq_verifica_mesi varchar(255),"+
																		"tipoRapporto varchar(255),"+
																		"StatoStrumento varchar(255),"+
																		"TempRapp varchar(255),"+
																		"reparto varchar(255),"+
																		"utilizzatore varchar(255),"+
																		"procedura varchar(255),"+
																		"id_tipo_strumento Integer," +
																		"note varchar(255)," +
																		"creato varcar(1)," +
																		"importato varchar(1));";

private static String sqlCreateCMPTable="CREATE TABLE tblCampioni(id_camp Integer," +
																  "codice varchar(255) ,"+
		    													  "matricola varchar(255),"+
		    													  "modello varchar(255),"+
		    													  "num_certificato varchar(255),"+
		    													  "dataVerifica Date,"+
		    													  "data_scadenza Date,"+
		    													  "freq_taratura_mesi Integer,"+
		    													  "parametri_taratura varchar(255),"+
		    													  "UM varchar(255),"+
		    													  "UM_FOND varchar(255),"+
		    													  "valore_taratura Float,"+
		    													  "valore_nominale Float,"+
		    													  "divisione_unita_misura Float,"+
		    													  "incertezza_assoluta Float,"+
		    													  "incertezza_relativa Float,"+
		    													  "id_tipo_grandezza Integer,"+
		    													  "interpolazione_permessa Integer,"+
		    													  "tipoGrandezza varchar(255));";

private static String sqlCreateMISTab="CREATE TABLE tblMisure(id Integer primary key autoincrement , id_str Integer, dataMisura Date, temperatura Float , umidita Float, statoRicezione Intgeger,statoMisura Integer);";

private static String sqlCreateMisOpt="CREATE TABLE tblTabelleMisura(id Integer primary key autoincrement,id_misura Integer," +
																	 "id_tabella Integer," +
																	 "ordine Integer," +
																	 "tipoProva char(1)," +
																	 "tipoVerifica varchar(255)," +
																	 "um varchar(50)," +
																	 "valoreCampione Float," +
																	 "valoreMedioCampione Float," +
																	 "valoreStrumento Float," +
																	 "valoreMedioStrumento Float," +
																	 "scostamento Float," +
																	 "accettabilita Float," +
																	 "incertezza Float," +
																	 "esito varchar(10)," +
																	 "desc_campione varchar(255)," +
																	 "desc_parametro varchar(255)," +
																	 "misura_prec Float," +
																	 "um_calc varchar(50)," +
																	 "risoluzione_misura Float," +
																	 "risoluzione_campione Float," +
																	 "fondo_scala Float," +
																	 "interpolazione Integer," +
																	 "fm varchar(255)," +
																	 "selConversione Integer," +
																	 "letturaCampione Float , " +
																	 "perc_util Float);";

private static String sqlCreateTipoStr_tipoGra="CREATE TABLE tbl_ts_tg(id_tipo_grandezza Integer ," +
																	 "id_tipo_strumento Integer);";

private static String sqlCreateClassificazione="CREATE TABLE tbl_classificazione(id Integer ," +
		 															   "descrizione String);";

private static String sqlCreateTipoRapporto="CREATE TABLE tbl_tipoRapporto(id Integer ," +
		   															"descrizione String);";

private static String sqlCreateStatoStumento="CREATE TABLE tbl_statoStrumento(id Integer ," +
		   															"descrizione String);";

private static String sqlCreateTipoStumento="CREATE TABLE tbl_tipoStrumento(id Integer ," +
												"descrizione String);";
			

private static String sqlCreateFattoriMoltiplicativi="CREATE TABLE tbl_fattori_moltiplicativi (descrizione varchar(20)," +
																							   "sigla varchar(2)," +
																							   "potenza double(2,0)," +
																							   "fm decimal(60,30))";


private static String sqlCreateTableConversione="CREATE TABLE tbl_conversione (id int(11) ,um_da varchar(100) ,um_a varchar(100) , " +
											"fattoreConversione decimal(60,30) ,um varchar(100) ,tipo_misura varchar(100) ," +
											"validita varchar(20) ,potenza Integer(5));"; 

private static String sqlCreateTableCampioniUtilizzati="CREATE TABLE tblCampioniUtilizzati(id Integer primary key autoincrement,id_misura Integer," +
																	 "id_tabellaMisura Integer,"+
																	  "desc_parametro varchar(100)," +
																	  "desc_campione varchar(100));"; 

public static Connection getConnection(String path, String nomeFile) throws ClassNotFoundException, SQLException {
		
		Class.forName("org.sqlite.JDBC");
		
		Connection con=DriverManager.getConnection("jdbc:sqlite:"+path+"/"+nomeFile+".db");
		
		return con;
	}

public static Connection getConnection(String nameFile) throws ClassNotFoundException, SQLException {
	
	Class.forName("org.sqlite.JDBC");
	
	Connection con=DriverManager.getConnection("jdbc:sqlite:"+nameFile);
	
	return con;
}

public static void createDB(Connection con) throws SQLException {
	
	try
	{
	PreparedStatement pst =con.prepareStatement(sqlCreateStrumentTable);
	pst.execute();
	
	PreparedStatement pstCM =con.prepareStatement(sqlCreateCMPTable);
	pstCM.execute();
	
	PreparedStatement pstMisure=con.prepareStatement(sqlCreateMISTab);
	pstMisure.execute();
	
	
	PreparedStatement pstMis =con.prepareStatement(sqlCreateMisOpt);
	pstMis.execute();
	
	PreparedStatement pstCampAss =con.prepareStatement(sqlCreateTipoStr_tipoGra);
	pstCampAss.execute();
	
	PreparedStatement pstFatMolt =con.prepareStatement(sqlCreateFattoriMoltiplicativi);
	pstFatMolt.execute();
	
	PreparedStatement pstConversione =con.prepareStatement(sqlCreateTableConversione);
	pstConversione.execute();
	
	PreparedStatement pstCampioniUtilizzati =con.prepareStatement(sqlCreateTableCampioniUtilizzati);
	pstCampioniUtilizzati.execute();
	
	PreparedStatement pstClass =con.prepareStatement(sqlCreateClassificazione);
	pstClass.execute();
	
	PreparedStatement psttipoRapporto =con.prepareStatement(sqlCreateTipoRapporto);
	psttipoRapporto.execute();
	
	PreparedStatement pstStatoStrumento =con.prepareStatement(sqlCreateStatoStumento);
	pstStatoStrumento.execute();
	
	PreparedStatement psttipoStrumento=con.prepareStatement(sqlCreateTipoStumento);
	psttipoStrumento.execute();
	}
	catch 
	(Exception e) 
	{
		throw e;
	}
}

public static ArrayList<MisuraDTO> getListaMisure(Connection con, InterventoDTO intervento) throws Exception {
	
	ArrayList<MisuraDTO> listaMisure = new ArrayList<MisuraDTO>();
	PreparedStatement pst=null;
	ResultSet rs= null;
	MisuraDTO misura = new MisuraDTO(); 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	
	
	pst=con.prepareStatement("SELECT a.*, b.* as importato FROM tblMisure a " +
							 "join tblStrumenti b on a.id_str=b.id " +
							 "WHERE statoMisura=1");
	
	rs=pst.executeQuery();
	
	while(rs.next())
	{
		misura= new MisuraDTO();
		misura.setId(rs.getInt("id"));
		misura.setIntervento(intervento);
		StrumentoDTO strumento = new StrumentoDTO();
		strumento.set__id(rs.getInt("id_str"));
		strumento.setDenominazione(rs.getString("denominazione"));
		strumento.setCodice_interno(rs.getString("codice_interno"));
		strumento.setCostruttore(rs.getString("costruttore"));
		strumento.setModello(rs.getString("modello"));
		strumento.setClassificazione(new ClassificazioneDTO(rs.getInt("classificazione"),""));
		strumento.setMatricola(rs.getString("matricola"));
		strumento.setRisoluzione(rs.getString("risoluzione"));
		strumento.setCampo_misura(rs.getString("campo_misura"));
		ScadenzaDTO scadenza = new ScadenzaDTO();
		scadenza.setFreq_mesi(rs.getInt(rs.getInt("freq_verifica_mesi")));
		scadenza.setTipo_rapporto(new TipoRapportoDTO(rs.getInt("tipoRapporto"), ""));
		
		if(scadenza.getTipo_rapporto().getNoneRapporto().equals("SVT"))
		{
			Date date = new Date();
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			
			scadenza.setDataUltimaVerifica(sqlDate);
			
			Calendar data = Calendar.getInstance();
			
			data.setTime(date);
			data.add(Calendar.MONTH,scadenza.getFreq_mesi());
			
			java.sql.Date sqlDateProssimaVerifica = new java.sql.Date(date.getTime());
			
			scadenza.setDataProssimaVerifica(sqlDateProssimaVerifica);
			
		}
		
		Set<ScadenzaDTO> listaScadenze =new HashSet<ScadenzaDTO>();
		listaScadenze.add(scadenza);
		strumento.setListaScadenzeDTO(listaScadenze);
		strumento.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		strumento.setReparto(rs.getString("reparto"));
		strumento.setUtilizzatore(rs.getString("utilizzatore"));
		strumento.setTipo_strumento(new TipoStrumentoDTO(rs.getInt("id_tipo_strumento"),""));
		strumento.setNote(rs.getString("note"));
		strumento.setCreato(rs.getString("creato"));
		strumento.setImportato(rs.getString("importato"));
		
		misura.setStrumento(strumento);
		misura.setDataMisura(sdf.parse(rs.getString("dataMisura")));
		misura.setTemperatura(rs.getFloat("temperatura"));
		misura.setTemperatura(rs.getFloat("umidita"));
		misura.setStatoRicezione(new StatoRicezioneStrumentoDTO(rs.getInt("statoRicezione")));
		misura.setObsoleto("N");
	
		listaMisure.add(misura);
	}
	 
	
	return listaMisure;
}

public static ArrayList<PuntoMisuraDTO> getListaPunti(Connection con, int idTemp, int idMisura) throws SQLException {
	
	ArrayList<PuntoMisuraDTO> listaPuntoMisura = new ArrayList<PuntoMisuraDTO>();
	
	PreparedStatement pst=null;
	ResultSet rs= null;
	PuntoMisuraDTO punto ; 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	
	
	pst=con.prepareStatement("SELECT * FROM tblTabelleMisura WHERE id_misura=?");
	pst.setInt(1, idTemp);
	
	rs=pst.executeQuery();
	
	while(rs.next())
	{
		punto= new PuntoMisuraDTO();
		
		punto.setId_misura(idMisura);
		punto.setId_tabella(rs.getInt("id_tabella"));
		punto.setOrdine(rs.getInt("ordine"));
		punto.setTipoProva(rs.getString("tipoProva"));
		punto.setTipoVerifica(rs.getString("tipoVerifica"));
		punto.setUm(rs.getString("um"));
		punto.setValoreCampione(rs.getBigDecimal("valoreCampione"));
		punto.setValoreMedioCampione(rs.getBigDecimal("valoreMedioCampione"));
		punto.setValoreStrumento(rs.getBigDecimal("valoreStrumento"));
		punto.setValoreMedioStrumento(rs.getBigDecimal("valoreMedioStrumento"));
		punto.setScostamento(rs.getBigDecimal("scostamento"));
		punto.setAccettabilita(rs.getBigDecimal("accettabilita"));
		punto.setIncertezza(rs.getBigDecimal("incertezza"));
		punto.setEsito(rs.getString("esito"));
		punto.setDesc_Campione(rs.getString("desc_campione"));
		punto.setDesc_parametro(rs.getString("desc_parametro"));
		punto.setMisura_prec(rs.getBigDecimal("misura_prec"));
		punto.setUm_calc(rs.getString("um_calc"));
		punto.setRisoluzione_misura(rs.getBigDecimal("risoluzione_misura"));
		punto.setRisoluzione_campione(rs.getBigDecimal("fondo_scala"));
		punto.setInterpolazione(rs.getInt("interpolazione"));
		punto.setFm(rs.getString("fm"));
		punto.setSelConversione(rs.getInt("selConversione"));
		punto.setLetturaCampione(rs.getBigDecimal("letturaCampione"));
		punto.setObsoleto("N");
		listaPuntoMisura.add(punto);
		
	}
	 
	
	return listaPuntoMisura;
}


}
