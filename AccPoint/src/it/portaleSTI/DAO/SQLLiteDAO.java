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
																		"id_tipo_strumento Integer);";

private static String sqlCreateCMPTable="CREATE TABLE tblCampioni(codice Integer ,"+
		    													  "matricola varchar(255)"+
		    													  "modello varchar(255)"+
		    													  "dataVerifica Date"+
		    													  "data_scadenza Date,"+
		    													  "freq_taratura_mesi Integer"+
		    													  "parametri_taratura varchar(255)"+
		    													  "UM varchar(255)"+
		    													  "UM_FOND varchar(255)"+
			replace(rs.getString("valore_campione.valore_taratura"))+";"+
			replace(rs.getString("valore_campione.valore_nominale"))+";"+
			replace(rs.getString("valore_campione.divisione_unita_misura"))+";"+
			replace(rs.getString("valore_campione.incertezza_assoluta"))+";"+
			replace(rs.getString("valore_campione.incertezza_relativa"))+";"+
			replace(rs.getString("valore_campione.id__tipo_grandezza_"))+";"+
			replace(rs.getString("campione.interpolazione_permessa"))+";"+
			replace(rs.getString("tipoGrandezza"));

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
	pst.execute();
	}
	catch 
	(Exception e) 
	{
		throw e;
	}
}
}
