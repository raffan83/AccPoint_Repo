package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SQLLiteDAO {

private static String sqlCreateStrumentTable="CREATE TABLE tblStrumenti(id Integer , " +
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
																		"note varchar(255));";

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
																	 "id_par_taratura Integer," +
																	 "misura_prec Float," +
																	 "um_calc varchar(50)," +
																	 "risoluzione Float," +
																	 "fondo_scala Float," +
																	 "interpolazione Integer," +
																	 "val_cer_uti Float," +
																	 "um_val_cert_util varchar(50));";

private static String sqlCreateTipoStr_tipoGra="CREATE TABLE tbl_ts_tg(id_tipo_grandezza Integer ," +
																	 "id_tipo_strumento Integer);";
			




public static Connection getConnection(String path, String nomeFile) throws ClassNotFoundException, SQLException {
		
		Class.forName("org.sqlite.JDBC");
		
		Connection con=DriverManager.getConnection("jdbc:sqlite:"+path+"/"+nomeFile+".db");
		
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
	
	}
	catch 
	(Exception e) 
	{
		throw e;
	}
}
}
