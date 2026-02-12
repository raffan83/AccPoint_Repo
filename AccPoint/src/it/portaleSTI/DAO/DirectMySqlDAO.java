package it.portaleSTI.DAO;

import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ColonnaDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ControlloOreDTO;
import it.portaleSTI.DTO.DevContrattoDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.DevTipoLicenzaDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.IngIngressoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PRInterventoRisorsaDTO;
import it.portaleSTI.DTO.PRRisorsaDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.GestioneUtenti;
import it.portaleSTI.action.ValoriCampione;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneConfigurazioneClienteBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;
import it.portaleSTI.bo.SendEmailBO;

public class DirectMySqlDAO {

	private static  final String getPassword="SELECT PASSWORD(?)";  

	private static final String sqlDatiStrumento="select strumento.__id,strumento.denominazione,strumento.codice_interno," +
			"strumento.costruttore , strumento.modello, strumento.note," +
			"strumento.id__classificazione_, strumento.matricola , strumento.risoluzione , strumento.campo_misura , scadenza.freq_verifica_mesi," +
			"(SELECT __id FROM tipo_rapporto WHERE scadenza.id__tipo_rapporto_=tipo_rapporto.__id) AS tipoRapporto," +
			"strumento.id__stato_strumento_," +
			"strumento.reparto,utilizzatore," +
			"strumento.procedura," +
			"strumento.id__tipo_strumento_ , scadenza" +
			"FROM strumento LEFT JOIN scadenza on strumento.__id =scadenza.id__strumento_ LEFT JOIN strumento__procedura_ on strumento.__id= strumento__procedura_.id__strumento_ "+
			"WHERE strumento.id_cliente=? and strumento.id__sede_new =? and strumento.id__company_=? AND strumento.id__stato_strumento_<>7227 ";


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

	private static final String sqlDatiCampioneLAT="select campione.__id,campione.codice,campione.matricola,campione.modello, " +
			"campione.numero_certificato , campione.data_verifica , campione.data_scadenza, " +
			"campione.freq_taratura_mesi,valore_campione.parametri_taratura, " +
			"(SELECT simbolo FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM, " +
			"(SELECT simbolo_normalizzato FROM unita_misura WHERE valore_campione.id__unita_misura_=unita_misura.__id) as UM_FOND," +
			"valore_campione.valore_taratura,valore_campione.valore_nominale,valore_campione.divisione_unita_misura," +
			"valore_campione.incertezza_assoluta,valore_campione.incertezza_relativa," +
			"valore_campione.id__tipo_grandezza_,valore_campione.interpolato,valore_campione.__id," +
			"(SELECT nome FROM tipo_grandezza WHERE valore_campione.id__tipo_grandezza_=tipo_grandezza.__id) AS tipoGrandezza ,valore_campione.obsoleto " +
			"FROM campione " +
			"INNER JOIN valore_campione ON valore_campione.id__campione_=campione.__id " +
			"WHERE campione.id_company_utilizzatore=? AND campione.stato_campione='S'";


	private static final String sqlDatiCampionePerStrumento="select Distinct(campione.__id)" +
			"from tipo_strumento__tipo_grandezza_ LEft join strumento  on strumento.id__tipo_strumento_=tipo_strumento__tipo_grandezza_.id__tipo_strumento_ " +
			"right join valore_campione on tipo_strumento__tipo_grandezza_.id__tipo_grandezza_=valore_campione.id__tipo_grandezza_ " +
			"left join taratura on valore_campione.id__campione_=taratura.id__campione_ " +
			"left JOIN campione on taratura.id__campione_=campione.__id " +
			"WHERE strumento.__id = ? and strumento.id__tipo_strumento_=? and campione.id_company_utilizzatore= ?";


	private static final String sqlDatiScheda="SELECT * FROM punto_misura";
	
	private static final String sqlIndicePrestazione="SELECT a.id,a.id_strumento,a.dataMisura,a.indice_prestazione FROM misura a JOIN intervento b ON a.id_intervento=b.id WHERE b.id_cliente=? AND id__sede_=?";

	private static final String sqlDatiStrumentiPerGrafico = "SELECT a.reparto,a.frequenza,c.nome as stato_strumento, d.nome as tipo_strumento, a.denominazione,a.utilizzatore "
			+ "from strumento a " + 
			"left JOIN stato_strumento c on a.id__stato_strumento_=c.__id " + 
			"left join tipo_strumento d on a.id__tipo_strumento_=d.__id " + 
			"where a.id__company_=? AND a.id_cliente=? and id__sede_new=?";
	
	private static final String sqlDatiStrumentiPerGraficoSediAll = "SELECT a.reparto,a.frequenza,c.nome as stato_strumento, d.nome as tipo_strumento, a.denominazione,a.utilizzatore "
			+ "from strumento a " + 
			"left JOIN stato_strumento c on a.id__stato_strumento_=c.__id " + 
			"left join tipo_strumento d on a.id__tipo_strumento_=d.__id " + 
			"where a.id__company_=? AND a.id_cliente=? ";

	private static final String sqlDatiStrumentiPerGraficoTras = "SELECT a.reparto,a.frequenza,c.nome as stato_strumento, d.nome as tipo_strumento,a.denominazione,a.utilizzatore "
			+ "from strumento a " +
			"left JOIN stato_strumento c on a.id__stato_strumento_=c.__id " + 
			"left join tipo_strumento d on a.id__tipo_strumento_=d.__id " + 
			"where a.id_cliente=? and id__sede_new=?";
	
	private static final String sqlDatiStrumentiPerGraficoTrasSediAll = "SELECT a.reparto,a.frequenza,c.nome as stato_strumento, d.nome as tipo_strumento,a.denominazione,a.utilizzatore "
			+ "from strumento a " +
			"left JOIN stato_strumento c on a.id__stato_strumento_=c.__id " + 
			"left join tipo_strumento d on a.id__tipo_strumento_=d.__id " + 
			"where a.id_cliente=? ";


	private static String sqlInsertCampioniAssociati="INSERT INTO tblCampioniAssociati(id_str,camp_ass) VALUES(?,?)";

	private static String sqlDatiTipoGrandezza_TS="SELECT * FROM tipo_strumento__tipo_grandezza_";

	private static String sqlFattoriMoltiplicativi="SELECT * FROM fattori_moltiplicativi";

	private static String sqlConversione="SELECT * FROM conversione";

	private static String resetPwd="UPDATE USERS SET PASSW=PASSWORD(?),reset_token='' WHERE ID=?";


	private static String sqlInterventoDatiCommessa = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id WHERE b.id_company =?";

	private static String sqlInterventoDatiCommessaTras = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id";

	private static String sqlInterventoDatiGeneratiCommessa = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id WHERE b.id_company =? GROUP BY id_intervento  HAVING COUNT(id_intervento)  =1";

	private static String sqlInterventoDatiGeneratiCommessaTras = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id GROUP BY id_intervento  HAVING COUNT(id_intervento)  =1";

	private static String sqlInterventoDatiScaricoCommessa = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id WHERE b.id_company = ? AND id_intervento NOT IN (SELECT id_intervento FROM intervento_dati WHERE id_stato_pack=3 )";

	private static String sqlInterventoDatiScaricoCommessaTras = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id  WHERE id_intervento NOT IN (SELECT id_intervento FROM intervento_dati WHERE id_stato_pack=3 ) ";

	private static String sqlInterventoDatiPerDataTras = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id WHERE a.dataCreazione BETWEEN ? AND ?";

	private static String sqlInterventoDatiPerData = "SELECT a.*, b.id_commessa, b.id_stato_intervento, b.presso_destinatario, b.nome_cliente FROM intervento_dati a LEFT JOIN intervento b ON a.id_intervento = b.id WHERE  b.id_company =? AND a.dataCreazione BETWEEN ? AND ?";

	private static String sqlVerMisurePerDate="select a.id , b.id_cliente,b.id_sede from ver_misura a JOIN ver_intervento b on a.id_ver_intervento=b.id where a.data_verificazione BETWEEN ? AND ?";

	private static String sqlMisurePerDate = "SELECT m.id, m.id_intervento, s.denominazione,s.matricola,s.codice_interno, m.dataMisura, i.id_commessa, i.nome_cliente, i.nome_sede, ms.descrizione, m.lat, m.nCertificato, c.id, m.obsoleto, s.__id, s.modello, s.costruttore, (SELECT nominativo FROM users as u where u.id = m.id_user) , c.data_creazione FROM misura m LEFT JOIN strumento s ON s.__id = m.id_strumento LEFT JOIN intervento i ON i.id = m.id_intervento LEFT JOIN lat_misura l ON l.id = m.idMisura LEFT JOIN lat_master ms ON l.id_misura_lat = ms.id LEFT JOIN certificato c on m.id = c.id_misura WHERE m.dataMisura BETWEEN ? AND ?";
	
	private static String sqlMisurePerDateOperatore = "SELECT m.id, m.id_intervento, s.denominazione,s.matricola,s.codice_interno, m.dataMisura, i.id_commessa, i.nome_cliente, i.nome_sede, ms.descrizione, m.lat, m.nCertificato, c.id, m.obsoleto, s.__id, s.modello, s.costruttore, (SELECT nominativo FROM users as u where u.id = m.id_user) , c.data_creazione FROM misura m LEFT JOIN strumento s ON s.__id = m.id_strumento LEFT JOIN intervento i ON i.id = m.id_intervento LEFT JOIN lat_misura l ON l.id = m.idMisura LEFT JOIN lat_master ms ON l.id_misura_lat = ms.id LEFT JOIN certificato c on m.id = c.id_misura WHERE m.dataMisura BETWEEN ? AND ? AND m.id_user = ?";

	private static String sqlDataStatoCertificatoMisura = "SELECT c.id_stato_certificato, c.data_creazione FROM certificato c LEFT JOIN misura m ON c.id_misura = m.id WHERE c.id_misura = ?"; 
	
	private static String sqlCommittentiPerFornitore = "SELECT a.id_committente, b.nome_cliente, b.indirizzo_cliente FROM docum_committente_fornitore a LEFT JOIN docum_committente b on a.id_committente = b.id WHERE a.id_fornitore = ?";
	
	private static String sqlInsertDocumentoDocumentale = "INSERT INTO  docum_tl_documento(id_committente, id_fornitore, nome_documento, numero_documento, data_caricamento, frequenza_rinnovo_mesi, rilasciato, data_scadenza, nome_file, stato, documento_sostituito) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	
	private static String sqlInsertIngresso="INSERT INTO ing_ingresso(tipo_registrazione,nome_ditta, nominativo_visitatore, data_ingresso, data_uscita, id_reparto, id_area, modalita_ingresso, telefono, tipo_merce, targa) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	
	//private static String sqlOrePrevisteOreScaricate ="SELECT a.USERNAME,a.ID_COMM,format((select DT_COMMESSA from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA c WHERE c.ID_COMMESSA=a.ID_COMM  ),'dd/MM/yyyy') AS DATA_COMMESSA,(select TB_FASE from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA_FASI b WHERE a.GLB_FASE=b.SYS_CHIAVEGLOBALE) as CODICE_FASE,   (select ORE_PREVISTE from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA_FASI b WHERE a.GLB_FASE=b.SYS_CHIAVEGLOBALE) as ORE_PREVISTE,  sum(a.OREINT) as ORE_SCARICATE, a.GLB_FASE FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_AGENDA] a  WHERE a.ID_COMM like '%AM%' group by a.GLB_FASE,a.ID_COMM,a.USERNAME";
	private static String sqlOrePrevisteOreScaricate = "SELECT a.USERNAME, a.ID_COMM, format((select DT_COMMESSA from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA c WHERE c.ID_COMMESSA=a.ID_COMM  ),'dd/MM/yyyy') AS DATA_COMMESSA, (select DESCR from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA c WHERE c.ID_COMMESSA=a.ID_COMM  ) as DESCRIZIONE_COMMESSA, (select NOME from [BTOMEN_CRESCO_DATI].[dbo].BWT_ANAGEN d where ID_ANAGEN = (select ID_ANAGEN from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA c WHERE c.ID_COMMESSA=a.ID_COMM  )) as NOME_CLIENTE, (select TB_FASE from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA_FASI b WHERE a.GLB_FASE=b.SYS_CHIAVEGLOBALE) as CODICE_FASE,(select DESCR_FASE from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA_FASI b WHERE a.GLB_FASE=b.SYS_CHIAVEGLOBALE) as DESCRIZIONE_FASE,(select ORE_PREVISTE from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA_FASI b WHERE a.GLB_FASE=b.SYS_CHIAVEGLOBALE) as ORE_PREVISTE,sum(a.OREINT) as ORE_SCARICATE,a.GLB_FASE, (select e.DESCR from [BTOMEN_CRESCO_DATI].[dbo].BWT_COMMESSA_AVANZ e WHERE e.SYS_CHIAVEGLOBALE= (select GLB_MILESTONE from [BTOMEN_CRESCO_DATI].[dbo].BWV_COMMESSA_FASI f where a.ID_COMM = f.ID_COMMESSA and f.SYS_CHIAVEGLOBALE = a.GLB_FASE) and e.TB_TIPO_MILE = 'MILE') as MILESTONE  FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_AGENDA] a  WHERE a.ID_COMM like '%AM%' group by a.GLB_FASE,a.ID_COMM,a.USERNAME order by a.USERNAME ASC";

	private static String sqlOrePrevisteTotali="SELECT SUM (ORE_PREVISTE),ID_COMMESSA FROM [BTOMEN_CRESCO_DATI].[dbo].[BWT_COMMESSA_FASI] WHERE ID_COMMESSA like 'AM%' GROUP BY(ID_COMMESSA)";
	
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
	
	
//
//	public static String getPassword(String pwd) throws Exception
//	{
//		String toReturn="";
//		PreparedStatement pst=null;
//		ResultSet rs= null;
//		Connection con=null;
//		try{
////			con = getConnection();	
////			pst=con.prepareStatement(getPassword);
////			pst.setString(1,pwd);
////			rs=pst.executeQuery();
////			rs.next();
////			toReturn=rs.getString(1);
//			 MessageDigest sha1 = MessageDigest.getInstance("SHA-1");
//	            
//	            // 1  passaggio SHA1
//	            byte[] stage1 = sha1.digest(pwd.getBytes("UTF-8"));
//	            
//	            // 2  passaggio SHA1 sull'hash del primo passo
//	            byte[] stage2 = sha1.digest(stage1);
//	            
//	            StringBuilder sb = new StringBuilder();
//	            for (byte b : stage2) {
//	                // & 0xFF per trattare byte come unsigned
//	                sb.append(String.format("%02x", b & 0xFF));
//	            }
//	            
//	            // Converti in esadecimale maiuscolo con prefisso *
//	            return "*" + sb.toString().toUpperCase();
//			
//			
//		}catch(Exception ex)
//		{
//			ex.printStackTrace();
//			throw ex;
//
//		}finally
//		{
//			//pst.close();
//			//con.close();
//		}
//
//		
//		
//		//return toReturn;
//	}
	
	

	public static void insertRedordDatiStrumento(int idCliente, int idSede,CompanyDTO cmp, String nomeCliente, Connection conSQLite,String indirizzoSede,UtenteDTO utente, Session session) throws Exception {


		//Session session = SessionFacotryDAO.get().openSession();

		//session.beginTransaction();

		PreparedStatement pstINS=null;

		String sqlInsert="";

		int idMisuraSQLite=1;

		int idTabella=1;

		try
		{

			conSQLite.setAutoCommit(false);


			ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(""+idCliente,""+idSede,cmp.getId(), session,utente); 

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
				String dataProssimaVerifica = "";





				if(strumento.getDataUltimaVerifica()!=null)
				{
					dataUltimaVerifica=sdf.format(strumento.getDataUltimaVerifica());
				}

				if(strumento.getDataProssimaVerifica()!=null)
				{
					dataProssimaVerifica=sdf.format(strumento.getDataProssimaVerifica());
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
						strumento.getFrequenza()+"\",\""+
						strumento.getTipoRapporto().getId()+"\",\""+
						strumento.getStato_strumento().getId()+"\",\""+
						Utility.getVarchar(strumento.getReparto())+"\",\""+
						Utility.getVarchar(strumento.getUtilizzatore())+"\",\""+
						Utility.getVarchar(strumento.getProcedura())+"\",\""+
						tipoStrumento+"\",\""+
						Utility.getVarchar(strumento.getNote())+"\",\"N\",\"N\"," +
						"\""+dataUltimaVerifica+"\",\""+dataProssimaVerifica+"\",\"\",\"N\",\"" +
						luogo+"\",\""+Utility.getVarchar(strumento.getNote_tecniche())+"\");";


				pstINS=conSQLite.prepareStatement(sqlInsert);

				if(strumento.getStato_strumento().getId()!=7227) 
				{
					pstINS.execute();
				}

				Integer idMisura = listaMisure.get(id);

				if(idMisura!=null && idMisura!=0)
				{
					System.out.println(idMisura);
					MisuraDTO misura =GestioneMisuraDAO.getMiruraByID(idMisura, session);


					
					pstINS=conSQLite.prepareStatement("INSERT INTO tblMisure(id,id_str,tipoFirma,statoMisura,indicePrestazione) VALUES(?,?,?,?,?)");
					pstINS.setInt(1, idMisuraSQLite);
					pstINS.setInt(2, id);
					pstINS.setInt(3, misura.getTipoFirma());
					pstINS.setInt(4, 2);
					pstINS.setString(5, misura.getIndice_prestazione());

					pstINS.execute();


					Iterator<PuntoMisuraDTO> iterator = misura.getListaPunti().iterator();
					while(iterator.hasNext()) {

						PuntoMisuraDTO punto = iterator.next();

						pstINS=conSQLite.prepareStatement("INSERT INTO tblTabelleMisura(id,id_misura,id_tabella,id_ripetizione,ordine,tipoProva,label,tipoVerifica,val_misura_prec,val_campione_prec,val_esito_prec, val_descrizione_prec,applicabile,dgt,file_att_prec,perc_util,SelTolleranza,fondo_scala,risoluzione_misura,interpolazione,calibrazione) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						pstINS.setInt(1, idTabella);
						pstINS.setInt(2, idMisuraSQLite);
						pstINS.setInt(3, punto.getId_tabella());
						pstINS.setInt(4, punto.getId_ripetizione());
						pstINS.setInt(5, punto.getOrdine());
						pstINS.setString(6, punto.getTipoProva());
						pstINS.setString(7, "Punto");
						pstINS.setString(8, punto.getTipoVerifica());
						if(punto.getValoreStrumento()!=null) 
						{
							pstINS.setString(9, punto.getValoreStrumento().stripTrailingZeros().toPlainString());
						}
						else
						{
							pstINS.setString(9, null);
						}
						String descCamp="";

						if(punto.getDesc_parametro()!=null) 
						{
							descCamp="["+punto.getDesc_Campione()+"] - ["+punto.getDesc_parametro()+"] - "+ punto.getValoreCampione().stripTrailingZeros().toPlainString();
						}
						else 
						{
							descCamp="["+punto.getDesc_Campione()+"]";
						}
						pstINS.setString(10, descCamp);
						pstINS.setString(11, punto.getEsito());
						pstINS.setString(12, punto.getTipoVerifica());
						pstINS.setString(13, punto.getApplicabile());
						if(punto.getDgt()!=null) 
						{
							pstINS.setString(14, punto.getDgt().toPlainString());
						}
						else 
						{
							pstINS.setString(14, "0");
						}

						pstINS.setBytes(15, punto.getFile_att());


						pstINS.setString(16, ""+punto.getPer_util());
						pstINS.setInt(17, punto.getSelTolleranza());

						if(punto.getFondoScala()!=null) 
						{
							pstINS.setString(18, punto.getFondoScala().toPlainString());
						}
						else 
						{
							pstINS.setString(18, "0");
						}
						
						if(punto.getRisoluzione_misura()!=null) 
						{
							pstINS.setString(19, punto.getRisoluzione_misura().toPlainString());
						}
						
						pstINS.setInt(20, punto.getInterpolazione());
						pstINS.setString(21, punto.getCalibrazione());

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

			//session.close();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			//session.getTransaction().rollback();
			
			//session.close();
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

	public static void insertListaAttivita(Connection conSQLLite, CommessaDTO commessa)  throws Exception {

		PreparedStatement pstINS=null;

		try
		{
			conSQLLite.setAutoCommit(false);

			for ( AttivitaMilestoneDTO attivita : commessa.getListaAttivita()) {

				String descrizione=attivita.getDescrizioneAttivita();if(descrizione==null)descrizione="";
				String note=attivita.getNoteAttivita();if(note==null)note="";
				String um=attivita.getUnitaMisura();if(um==null)um="";
				String quantita=attivita.getQuantita();if(quantita==null)quantita="";
				
				
				String sqlInsert="INSERT INTO tbAttivita(descrizione,note,um,quantita) VALUES("
						+ "\""+descrizione.replaceAll("\"", "\"\"")+"\",\""+note.replaceAll("\"", "\"\"")+"\",\""+um.replaceAll("\"", "\"\"")+"\",\""+quantita.replaceAll("\"", "\"\"")+"\")";

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
			if(pstINS!=null) 
			{
				pstINS.close();
			}
		}	
	}
	public static void insertListaCampioniLAT(Connection conSQLLite, CompanyDTO cmp)  throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;
		ArrayList<ValoreCampioneDTO> listaValori= new ArrayList<>();

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement(sqlDatiCampioneLAT);
			pst.setInt(1,cmp.getId());

			rs=pst.executeQuery();

			ValoreCampioneDTO valore;

			while(rs.next())
			{
				valore= new ValoreCampioneDTO();
				valore.setCampione(new CampioneDTO());
				valore.setId(rs.getInt("valore_campione.__id"));
				valore.getCampione().setId(rs.getInt("campione.__id"));
				valore.setValore_taratura(rs.getBigDecimal("valore_campione.valore_taratura"));
				valore.setValore_nominale(rs.getBigDecimal("valore_campione.valore_nominale"));	
				valore.setDivisione_UM(rs.getBigDecimal("valore_campione.divisione_unita_misura"));
				valore.setIncertezza_assoluta(rs.getBigDecimal("valore_campione.incertezza_assoluta"));
				valore.setIncertezza_relativa(rs.getBigDecimal("valore_campione.incertezza_relativa"));
				valore.getCampione().setCodice(rs.getString("campione.codice"));
				valore.getCampione().setMatricola(rs.getString("campione.matricola"));
				valore.getCampione().setModello(rs.getString("campione.modello"));
				valore.getCampione().setNumeroCertificato(rs.getString("campione.numero_certificato"));
				valore.getCampione().setDataVerifica(rs.getDate("campione.data_verifica"));
				valore.getCampione().setDataScadenza(rs.getDate("campione.data_scadenza"));
				valore.setParametri_taratura(rs.getString("valore_campione.parametri_taratura"));
				UnitaMisuraDTO unita= new UnitaMisuraDTO();
				unita.setSimbolo(rs.getString("UM"));
				unita.setSimbolo_normalizzato(rs.getString("UM_FOND"));
				valore.setUnita_misura(unita);
				TipoGrandezzaDTO tipoGrandezza = new TipoGrandezzaDTO();
				tipoGrandezza.setId(rs.getInt("valore_campione.id__tipo_grandezza_"));
				tipoGrandezza.setNome(rs.getString("tipoGrandezza"));
				valore.setTipo_grandezza(tipoGrandezza);
				valore.setInterpolato(	rs.getInt("valore_campione.interpolato"));
				valore.setObsoleto(rs.getString("valore_campione.obsoleto"));


				listaValori.add(valore);
			}


			for (ValoreCampioneDTO val : listaValori) {


				BigDecimal valoreTaratura=val.getValore_taratura();
				BigDecimal valoreNominale=val.getValore_nominale();
				BigDecimal divisione=val.getDivisione_UM();
				BigDecimal incertezzaAssoluta=val.getIncertezza_assoluta();
				BigDecimal incertezzaRelativa=val.getIncertezza_relativa();

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


				String sqlInsert="INSERT INTO tblCampioni VALUES("+val.getCampione().getId()+",\""+
						Utility.getVarchar(val.getCampione().getCodice())+"\",\""+
						Utility.getVarchar(val.getCampione().getMatricola())+"\",\""+
						Utility.getVarchar(val.getCampione().getModello())+"\",\""+
						Utility.getVarchar(val.getCampione().getNumeroCertificato())+"\",\'"+
						val.getCampione().getDataVerifica()+"\',\'"+
						val.getCampione().getDataScadenza()+"\',\'"+
						val.getCampione().getFreqTaraturaMesi()+"\',\""+
						Utility.getVarchar(val.getParametri_taratura())+"\",\""+
						Utility.getVarchar(val.getUnita_misura().getSimbolo())+"\",\""+
						Utility.getVarchar(val.getUnita_misura().getSimbolo_normalizzato())+"\",\'"+
						valoreTaratura+"\',\'"+
						valoreNominale+"\',\'"+
						getScostamentoPrecedente(val,listaValori)+"\',\'"+
						divisione+"\',\'"+
						incertezzaAssoluta+"\',\'"+
						incertezzaRelativa+"\',\'"+
						val.getTipo_grandezza().getId()+"\',\'"+
						val.getInterpolato()+"\',\""+
						Utility.getVarchar(val.getTipo_grandezza().getNome())+"\",\"N\")";

				if(val.getObsoleto().equals("N")) 
				{
					pstINS=conSQLLite.prepareStatement(sqlInsert);
					pstINS.execute();
				}
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


	private static BigDecimal getScostamentoPrecedente(ValoreCampioneDTO val, ArrayList<ValoreCampioneDTO> listaValori) {

		BigDecimal scostamentoPrecedente=BigDecimal.ZERO;
		
		if(val.getCampione().getCodice().equals("CDT054")) 
		{
			System.out.println("stop");
		}
		
		if(val.getObsoleto().equals("N") ) 
		{
			int maxID=0;

			for (ValoreCampioneDTO valoreCampione : listaValori) {


				if(val.getCampione().getCodice().equals(valoreCampione.getCampione().getCodice()))
				{

					if(valoreCampione.getValore_nominale().compareTo(val.getValore_nominale())==0 && valoreCampione.getId()>maxID && valoreCampione.getId()!=val.getId()) 
					{
						scostamentoPrecedente=valoreCampione.getValore_taratura().subtract(valoreCampione.getValore_nominale());
					}
				}
			}

		}

		return scostamentoPrecedente;
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

	public static void insertMasterTableLAT(Connection conSQLLite) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM lat_master");

			rs=pst.executeQuery();


			while(rs.next())
			{

				String sqlInsert="INSERT INTO lat_master VALUES(?,?,?,?,?,?)";

				pstINS=conSQLLite.prepareStatement(sqlInsert);

				pstINS.setInt(1, rs.getInt("id"));
				pstINS.setString(2, rs.getString("sigla"));
				pstINS.setInt(3, rs.getInt("seq"));
				pstINS.setString(4, rs.getString("rif_tipoStrumento"));
				pstINS.setString(5, rs.getString("siglaRegistro"));
				pstINS.setString(6, rs.getString("id_procedura"));

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

	public static void insertGeneral(Connection conSQLLite, String nome_sede,String formatoData) throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM tipo_strumento");

			String sqlInsert="INSERT INTO tbl_general VALUES(?,?,?,?)";

			pstINS=conSQLLite.prepareStatement(sqlInsert);

			pstINS.setInt(1, 1);
			pstINS.setString(2, nome_sede);
			pstINS.setString(3,"N");
			pstINS.setString(4,formatoData);

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

	public static ArrayList<StrumentoDTO> getListaStrumentiPerGrafico(String idCliente,String idSede, Integer idCompany,UtenteDTO user) throws Exception {


		ArrayList<StrumentoDTO> lista =new ArrayList<StrumentoDTO>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();

			if(!user.isTras()) 
			{
				
				if(idSede.equals("0")) {
					pst=con.prepareStatement(sqlDatiStrumentiPerGraficoSediAll);
					pst.setInt(1,idCompany);
					pst.setString(2, idCliente);
					
				}else {

pst=con.prepareStatement(sqlDatiStrumentiPerGrafico);
					pst.setInt(1,idCompany);
					pst.setString(2, idCliente);
					pst.setString(3, idSede);
				}
				
				
				
				
			}
			else 
			{
				if(idSede.equals("0")) {
					pst=con.prepareStatement(sqlDatiStrumentiPerGraficoTrasSediAll);
			
					pst.setString(1, idCliente);
					
				}else {
					pst=con.prepareStatement(sqlDatiStrumentiPerGraficoTras);
					pst.setString(1, idCliente);
					pst.setString(2, idSede);
				}
			}


			rs=pst.executeQuery();

			StrumentoDTO strumento= null;

			while(rs.next()) 
			{
				strumento= new StrumentoDTO();
				strumento.setReparto(rs.getString("reparto"));
				String freq = rs.getString("frequenza");
				if(freq!=null && freq.length()>0) 
				{
					strumento.setFrequenza(Integer.parseInt(freq));
				}else 
				{
					strumento.setFrequenza(0);
				}
				strumento.setDenominazione(rs.getString("denominazione"));
				strumento.setUtilizzatore(rs.getString("utilizzatore"));
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

	public static void updateStatoCampioneScheduler() throws Exception {


		String query = "update campione set stato_campione='N' where stato_campione!='F' and id_tipo_campione!=3 and (campione.data_Scadenza<now() or campione.data_scadenza is null)";

		Connection con=null;
		PreparedStatement pst=null;

		con=getConnection();
		pst=con.prepareStatement(query);

		pst.executeUpdate();

		pst.close();
		con.close();
	}


	public static void savePwdutente(int id, String passw) throws Exception {

		String query = "update users set PASSW =  (select PASSWORD('"+passw+"')) where id="+id+"";

		Connection con=null;
		PreparedStatement pst=null;

		con=getConnection();
		pst=con.prepareStatement(query);

		pst.executeUpdate();

		pst.close();
		con.close();

	}

	public static void resPwd(UtenteDTO utente, String passwordUser) throws Exception {

		String toReturn="";
		PreparedStatement pst=null;
		Connection con=null;
		try{
			con = getConnection();	
			pst=con.prepareStatement(resetPwd);
			pst.setString(1,passwordUser);
			pst.setInt(2, utente.getId());

			pst.executeUpdate();

		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;

		}finally
		{
			pst.close();
			con.close();
		}


	}

	public static ArrayList<InterventoDatiDTO> getListaInterventiDati(UtenteDTO user, Session session) throws Exception {

		ArrayList<InterventoDatiDTO> lista =new ArrayList<InterventoDatiDTO>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();

			if(user.isTras()) {
				pst=con.prepareStatement(sqlInterventoDatiCommessaTras);	
			}else {
				pst=con.prepareStatement(sqlInterventoDatiCommessa);	
				pst.setInt(1, user.getCompany().getId());
			}


			rs=pst.executeQuery();

			InterventoDatiDTO intervento_dati= null;

			while(rs.next()) 
			{
				intervento_dati= new InterventoDatiDTO();
				intervento_dati.setId(rs.getInt("Id"));
				intervento_dati.setId_intervento(rs.getInt("id_intervento"));
				intervento_dati.setDataCreazione(rs.getDate("dataCreazione"));
				intervento_dati.setNomePack(rs.getString("nomePack"));
				intervento_dati.setStato(new StatoPackDTO(rs.getInt("id_stato_pack")));				
				intervento_dati.setNumStrMis(rs.getInt("numStrMis"));
				intervento_dati.setNumStrNuovi(rs.getInt("numStrNuovi"));
				//intervento_dati.setUtente(new UtenteDTO(rs.getInt("id_user_resp"),"", "", "", "", "", "", "", "", "", "", new CompanyDTO(), ""));				
				intervento_dati.setUtente(GestioneUtenteBO.getUtenteById(String.valueOf(rs.getInt("id_user_resp")),session));
				intervento_dati.setId_commessa(rs.getString("id_commessa"));
				intervento_dati.setStato_intervento(rs.getInt("id_stato_intervento"));
				intervento_dati.setPresso_destinatario(rs.getInt("presso_destinatario"));
				intervento_dati.setCliente(rs.getString("nome_cliente"));

				lista.add(intervento_dati);
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

	public static ArrayList<InterventoDatiDTO> getListaInterventiDatiGenerati(UtenteDTO user, Session session) throws Exception {

		ArrayList<InterventoDatiDTO> lista =new ArrayList<InterventoDatiDTO>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();

			if(user.isTras()) {
				pst=con.prepareStatement(sqlInterventoDatiGeneratiCommessaTras);					
			}else {
				pst=con.prepareStatement(sqlInterventoDatiGeneratiCommessa);		
				pst.setInt(1, user.getCompany().getId());
			}


			rs=pst.executeQuery();

			InterventoDatiDTO intervento_dati= null;

			while(rs.next()) 
			{
				intervento_dati= new InterventoDatiDTO();
				intervento_dati.setId(rs.getInt("Id"));
				intervento_dati.setId_intervento(rs.getInt("id_intervento"));
				intervento_dati.setDataCreazione(rs.getDate("dataCreazione"));
				intervento_dati.setNomePack(rs.getString("nomePack"));
				intervento_dati.setStato(new StatoPackDTO(rs.getInt("id_stato_pack")));				
				intervento_dati.setNumStrMis(rs.getInt("numStrMis"));
				intervento_dati.setNumStrNuovi(rs.getInt("numStrNuovi"));
				//intervento_dati.setUtente(new UtenteDTO(rs.getInt("id_user_resp"),"", "", "", "", "", "", "", "", "", "", new CompanyDTO(), ""));				
				intervento_dati.setUtente(GestioneUtenteBO.getUtenteById(String.valueOf(rs.getInt("id_user_resp")),session));
				intervento_dati.setId_commessa(rs.getString("id_commessa"));
				intervento_dati.setStato_intervento(rs.getInt("id_stato_intervento"));
				intervento_dati.setPresso_destinatario(rs.getInt("presso_destinatario"));
				intervento_dati.setCliente(rs.getString("nome_cliente"));


				lista.add(intervento_dati);
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

	public static ArrayList<InterventoDatiDTO> getListaInterventiDatiScarico(UtenteDTO user, Session session) throws Exception {

		ArrayList<InterventoDatiDTO> lista =new ArrayList<InterventoDatiDTO>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();

			if(user.isTras()) {
				pst=con.prepareStatement(sqlInterventoDatiScaricoCommessaTras);					
			}else {
				pst=con.prepareStatement(sqlInterventoDatiScaricoCommessa);		
				pst.setInt(1, user.getCompany().getId());
			}


			rs=pst.executeQuery();

			InterventoDatiDTO intervento_dati= null;

			while(rs.next()) 
			{
				intervento_dati= new InterventoDatiDTO();
				intervento_dati.setId(rs.getInt("Id"));
				intervento_dati.setId_intervento(rs.getInt("id_intervento"));
				intervento_dati.setDataCreazione(rs.getDate("dataCreazione"));
				intervento_dati.setNomePack(rs.getString("nomePack"));
				intervento_dati.setStato(new StatoPackDTO(rs.getInt("id_stato_pack")));				
				intervento_dati.setNumStrMis(rs.getInt("numStrMis"));
				intervento_dati.setNumStrNuovi(rs.getInt("numStrNuovi"));
				//intervento_dati.setUtente(new UtenteDTO(rs.getInt("id_user_resp"),"", "", "", "", "", "", "", "", "", "", new CompanyDTO(), ""));				
				intervento_dati.setUtente(GestioneUtenteBO.getUtenteById(String.valueOf(rs.getInt("id_user_resp")),session));
				intervento_dati.setId_commessa(rs.getString("id_commessa"));
				intervento_dati.setStato_intervento(rs.getInt("id_stato_intervento"));
				intervento_dati.setPresso_destinatario(rs.getInt("presso_destinatario"));
				intervento_dati.setCliente(rs.getString("nome_cliente"));

				lista.add(intervento_dati);
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

	public static ArrayList<InterventoDatiDTO> getListaInterventiDatiPerData(UtenteDTO user, String dateFrom, String dateTo, Session session) throws Exception{

		ArrayList<InterventoDatiDTO> lista =new ArrayList<InterventoDatiDTO>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
		java.sql.Date sql1 = new java.sql.Date(df.parse(dateFrom).getTime());
		java.sql.Date sql2 = new java.sql.Date(df.parse(dateTo).getTime());
		try
		{
			con=getConnection();


			if(user.isTras()) {
				pst=con.prepareStatement(sqlInterventoDatiPerDataTras);		
				pst.setDate(1, sql1);
				pst.setDate(2, sql2);
			}else {
				pst=con.prepareStatement(sqlInterventoDatiPerData);		
				pst.setInt(1, user.getCompany().getId());				
				pst.setDate(2, sql1);
				pst.setDate(3, sql2);
			}			

			rs=pst.executeQuery();

			InterventoDatiDTO intervento_dati= null;

			while(rs.next()) 
			{
				intervento_dati= new InterventoDatiDTO();
				intervento_dati.setId(rs.getInt("Id"));
				intervento_dati.setId_intervento(rs.getInt("id_intervento"));
				intervento_dati.setDataCreazione(rs.getDate("dataCreazione"));
				intervento_dati.setNomePack(rs.getString("nomePack"));
				intervento_dati.setStato(new StatoPackDTO(rs.getInt("id_stato_pack")));				
				intervento_dati.setNumStrMis(rs.getInt("numStrMis"));
				intervento_dati.setNumStrNuovi(rs.getInt("numStrNuovi"));
				//intervento_dati.setUtente(new UtenteDTO(rs.getInt("id_user_resp"),"", "", "", "", "", "", "", "", "", "", new CompanyDTO(), ""));				
				intervento_dati.setUtente(GestioneUtenteBO.getUtenteById(String.valueOf(rs.getInt("id_user_resp")),session));
				intervento_dati.setId_commessa(rs.getString("id_commessa"));
				intervento_dati.setStato_intervento(rs.getInt("id_stato_intervento"));
				intervento_dati.setPresso_destinatario(rs.getInt("presso_destinatario"));
				intervento_dati.setCliente(rs.getString("nome_cliente"));

				lista.add(intervento_dati);
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

	public static void insert_massa_classe(Connection conSQLLite) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM lat_massa_classe");

			rs=pst.executeQuery();


			while(rs.next())
			{

				String sqlInsert="INSERT INTO lat_massa_classe VALUES(?,?,?,?,?)";

				pstINS=conSQLLite.prepareStatement(sqlInsert);

				pstINS.setInt(1, rs.getInt("id"));
				pstINS.setString(2, rs.getString("val_nominale"));
				pstINS.setBigDecimal(3, rs.getBigDecimal("mg"));
				pstINS.setBigDecimal(4, rs.getBigDecimal("dens_min"));
				pstINS.setBigDecimal(5, rs.getBigDecimal("dens_mas"));

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


	public static void insert_massa_amb_sonde(Connection conSQLLite) throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM lat_massa_amb_sonde");

			rs=pst.executeQuery();


			while(rs.next())
			{

				String sqlInsert="INSERT INTO lat_massa_amb_sonde VALUES(?,?,?,?,?,?)";

				pstINS=conSQLLite.prepareStatement(sqlInsert);

				pstINS.setInt(1, rs.getInt("id_tipo"));
				pstINS.setInt(2, rs.getInt("numero"));
				pstINS.setBigDecimal(3, rs.getBigDecimal("indicazione"));
				pstINS.setBigDecimal(4, rs.getBigDecimal("errore"));
				pstINS.setBigDecimal(5, rs.getBigDecimal("reg_lin_m"));
				pstINS.setBigDecimal(6, rs.getBigDecimal("reg_lin_q"));

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


	public static void insert_massa_scarti_tipo(Connection conSQLLite) throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM lat_massa_scarti_tipo");

			rs=pst.executeQuery();


			while(rs.next())
			{

				String sqlInsert="INSERT INTO lat_massa_scarti_tipo VALUES(?,?,?,?,?,?)";

				pstINS=conSQLLite.prepareStatement(sqlInsert);

				pstINS.setInt(1, rs.getInt("id"));
				pstINS.setInt(2, rs.getInt("id_comparatore"));
				pstINS.setString(3, rs.getString("descrizione"));
				pstINS.setBigDecimal(4, rs.getBigDecimal("scarto"));
				pstINS.setInt(5, rs.getInt("gradi_lib"));
				pstINS.setBigDecimal(6, rs.getBigDecimal("uf"));

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

	public static void insertClasseMasse(Connection conSQLLite) throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM ver_classi");

			rs=pst.executeQuery();


			while(rs.next())
			{

				String sqlInsert="INSERT INTO ver_classi VALUES(?,?,?,?)";

				pstINS=conSQLLite.prepareStatement(sqlInsert);

				pstINS.setInt(1, rs.getInt("classe"));
				pstINS.setBigDecimal(2, rs.getBigDecimal("limite_inferiore"));
				pstINS.setBigDecimal(3, rs.getBigDecimal("limite_superiore"));
				pstINS.setBigDecimal(4, rs.getBigDecimal("errore"));

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

	public static void insertStrumentiVerificazione(VerInterventoDTO intervento, Connection conSQLLite, Session session) throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		PreparedStatement pstINS=null;
		PreparedStatement pstMatricola=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();
			conSQLLite.setAutoCommit(false);
			pst=con.prepareStatement("SELECT * FROM ver_strumento WHERE id_cliente=? AND id_sede=?");
			pst.setInt(1, intervento.getId_cliente());
			pst.setInt(2, intervento.getId_sede());

			rs=pst.executeQuery();

			while(rs.next())
			{

				String sqlInsert="INSERT INTO ver_strumento (id,denominazione,costruttore,modello,matricola,"
						+"classe,id_ver_tipo_strumento,um,data_ultima_verifica,data_prossima_verifica,"
						+ "portata_min_C1,portata_max_C1,div_ver_C1,div_rel_C1,numero_div_C1,"
						+ "portata_min_C2,portata_max_C2,div_ver_C2,div_rel_C2,numero_div_C2,"
						+ "portata_min_C3,portata_max_C3,div_ver_C3,div_rel_C3,numero_div_C3,"
						+ "id_cliente,id_sede,anno_marcatura_CE,data_ms,id_tipologia,freq_mesi,creato,famiglia_strumento,tipo_legalizzazione,luogo_verifica) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";

				pstINS=conSQLLite.prepareStatement(sqlInsert);
				pstMatricola=conSQLLite.prepareStatement("INSERT INTO ver_lista_matricole(matricola) VALUES(?)");


				int id =rs.getInt("id");
				String matricola=rs.getString("matricola");
				pstINS.setInt(1, id);
				pstINS.setString(2, rs.getString("denominazione"));
				pstINS.setString(3, rs.getString("costruttore"));
				pstINS.setString(4, rs.getString("modello"));
				pstINS.setString(5, matricola);
				pstINS.setInt(6, rs.getInt("classe"));
				pstINS.setInt(7, rs.getInt("id_ver_tipo_strumento"));
				pstINS.setString(8, rs.getString("um"));
				pstINS.setString(9, getDate(rs.getDate("data_ultima_verifica")));
				pstINS.setString(10, getDate(rs.getDate("data_prossima_verifica")));
				pstINS.setBigDecimal(11, rs.getBigDecimal("portata_min_C1"));
				pstINS.setBigDecimal(12, rs.getBigDecimal("portata_max_C1"));
				pstINS.setBigDecimal(13, rs.getBigDecimal("div_ver_C1"));
				pstINS.setBigDecimal(14, rs.getBigDecimal("div_rel_C1"));
				pstINS.setBigDecimal(15, rs.getBigDecimal("numero_div_C1"));
				pstINS.setBigDecimal(16, rs.getBigDecimal("portata_min_C2"));
				pstINS.setBigDecimal(17, rs.getBigDecimal("portata_max_C2"));
				pstINS.setBigDecimal(18, rs.getBigDecimal("div_ver_C2"));
				pstINS.setBigDecimal(19, rs.getBigDecimal("div_rel_C2"));
				pstINS.setBigDecimal(20, rs.getBigDecimal("numero_div_C2"));
				pstINS.setBigDecimal(21, rs.getBigDecimal("portata_min_C3"));
				pstINS.setBigDecimal(22, rs.getBigDecimal("portata_max_C3"));
				pstINS.setBigDecimal(23, rs.getBigDecimal("div_ver_C3"));
				pstINS.setBigDecimal(24, rs.getBigDecimal("div_rel_C3"));
				pstINS.setBigDecimal(25, rs.getBigDecimal("numero_div_C3"));
				pstINS.setInt(26, rs.getInt("id_cliente"));
				pstINS.setInt(27, rs.getInt("id_sede"));
				pstINS.setInt(28, rs.getInt("anno_marcatura_CE"));
				pstINS.setString(29, getDate(rs.getDate("data_messa_in_servizio")));
				pstINS.setInt(30, rs.getInt("id_tipologia"));
				pstINS.setInt(31, rs.getInt("freq_mesi"));
				pstINS.setString(32, "N");
				pstINS.setString(33,rs.getString("id_famiglia_strumento"));

				VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(id, session); 
				
				Iterator<VerLegalizzazioneBilanceDTO> iter =strumento.getLista_legalizzazione_bilance().iterator();
				
				int indiceLegalizzazione=0;
				
				 while (iter.hasNext()) {
					 VerLegalizzazioneBilanceDTO leg=iter.next();
					 
					 indiceLegalizzazione=leg.getTipo_approvazione().getId();
					 
					 if(leg.getTipo_approvazione().getId()==1) 
					 {
						 indiceLegalizzazione=0;
					 }
					 else 
					 {
						 indiceLegalizzazione=1;
					 }
					 break;
			        }
				
				 pstINS.setInt(34,indiceLegalizzazione);
				 
				 pstINS.setInt(35,intervento.getIn_sede_cliente());
				 
				if(controlloID(id,intervento.getInterventoStrumenti()))
				{
					pstINS.execute();
				}

				pstMatricola.setString(1, matricola);
				pstMatricola.execute();
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
			pstINS.close();
			pstMatricola.close();
			con.close();

		}

	}

	private static boolean controlloID(int id, Set<VerInterventoStrumentiDTO> interventoStrumenti) {

		Iterator<VerInterventoStrumentiDTO> lista =interventoStrumenti.iterator();

		while(lista.hasNext()) 
		{
			VerInterventoStrumentiDTO str=lista.next();

			if(str.getVerStrumento().getId()==id) 
			{
				return true;
			}
		}
		return false;
	}

	private static String getDate(Date date) {

		if(date!=null)
		{
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			return sdf.format(date);
		}else 
		{
			return "";
		}

	}



	public static ArrayList<String> getListaVerMisureFromDate(String dateFrom, String dateTo) throws Exception {
		ArrayList<String> lista =new ArrayList<String>();

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
		java.sql.Date sql1 = new java.sql.Date(df.parse(dateFrom).getTime());
		java.sql.Date sql2 = new java.sql.Date(df.parse(dateTo).getTime());

		try
		{
			con=getConnection();



			pst=con.prepareStatement(sqlVerMisurePerDate);		
			pst.setDate(1, sql1);
			pst.setDate(2, sql2);


			rs=pst.executeQuery();

			while(rs.next())
			{
				String s =rs.getString(1)+";"+rs.getString(2)+";"+rs.getString(3);
				lista.add(s);
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



	public static ArrayList<String> getListaMisureFromDate(String dateFrom, String dateTo, UtenteDTO utente) throws Exception {
		ArrayList<String> lista =new ArrayList<String>();

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
		java.sql.Date sql1 = new java.sql.Date(df.parse(dateFrom).getTime());
		java.sql.Date sql2 = new java.sql.Date(df.parse(dateTo).getTime());

		try
		{
			con=getConnection();


			if(!utente.isTras() && utente.checkRuolo("FR")) {
				pst=con.prepareStatement(sqlMisurePerDateOperatore);		
			}else {
				pst=con.prepareStatement(sqlMisurePerDate);		
			}
			
			

			pst.setDate(1, sql1);
			pst.setDate(2, sql2);
			if(!utente.isTras() && utente.checkRuolo("FR")) {
				pst.setInt(3, utente.getId());
			}


			rs=pst.executeQuery();
			df = new SimpleDateFormat("dd/MM/yyyy");
			while(rs.next())
			{


				String s =rs.getString(1)+";;"+rs.getString(2)+";;"+rs.getString(3)+";;"+rs.getString(4)+";;"+rs.getString(5)+";;"+df.format(rs.getDate(6))+";;"+rs.getString(7)+";;"+rs.getString(8)+";;"+rs.getString(9)+";;"+rs.getString(10)+";;"+rs.getString(11)+";;"+rs.getString(12)+";;"+rs.getString(13)+";;"+rs.getString(14)+";;"+rs.getString(15)+";;"+rs.getString(16)+";;"+rs.getString(17)+";;"+rs.getString(18)+";;";

				if(rs.getDate(19)!=null) {
					s = s + df.format(rs.getDate(19));
				}

				
				
				lista.add(s);
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

	public static ArrayList<String> getCertificatoFromMisura(MisuraDTO misura) throws Exception {

		ArrayList<String> lista =new ArrayList<String>();

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		

		try
		{
			con=getConnection();


			pst=con.prepareStatement(sqlDataStatoCertificatoMisura);		
			pst.setInt(1, misura.getId());

			rs=pst.executeQuery();


			while(rs.next())
			{

				
				String stato = rs.getString(1);
				String data =rs.getDate(2)+"";
				lista.add(stato);
				lista.add(data);
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




	public static void insertTipoStrumentoTipoGrandezzaDirect(int id_grandezza, int id_tipo_strumento) throws Exception {

		String query = "insert into tipo_strumento__tipo_grandezza_ values(?,?)"
				;
		Connection con=null;
		PreparedStatement pst=null;

		con=getConnection();
		pst=con.prepareStatement(query);
		pst.setInt(1, id_grandezza);
		pst.setInt(2, id_tipo_strumento);

		pst.execute();

		pst.close();
		con.close();
	}

	public static ArrayList<Integer> getGrandezzeFromTipoStrumento(int id_tipo_strumento) throws Exception {

		ArrayList<Integer> lista =new ArrayList<Integer>();

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();


			pst=con.prepareStatement("SELECT id__tipo_grandezza_ FROM tipo_strumento__tipo_grandezza_ WHERE id__tipo_strumento_ = ?");		
			pst.setInt(1, id_tipo_strumento);

			rs=pst.executeQuery();


			while(rs.next())
			{

				lista.add(rs.getInt(1));

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

	public static void updateUltimoAccesso(int id) throws Exception {

		PreparedStatement pst=null;
		Connection con=null;
		try{
			con = getConnection();	

			pst=con.prepareStatement("UPDATE users SET ultimo_accesso=? WHERE id=?");
			pst.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			pst.setInt(2,id);
			pst.execute();

		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;

		}finally
		{
			pst.close();
			con.close();
		}

	}

	public static void updateConatoreUtente(UtenteDTO utente) throws Exception {

		PreparedStatement pst=null;
		ResultSet rs= null;
		Connection con=null;
		try{
			con = getConnection();	

			pst=con.prepareStatement("UPDATE contatore_user SET count_se=? WHERE id_user=?");
			pst.setInt(1, utente.getContatoreUtente().getContatoreSE());
			pst.setInt(2,utente.getId());
			pst.execute();

		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;

		}finally
		{
			pst.close();
			con.close();
		}

	}
	
	
	
	public static ArrayList<DocumCommittenteDTO> getIdCommittentiFromFornitore(int id_fornitore) throws Exception {

		ArrayList<DocumCommittenteDTO> lista =new ArrayList<DocumCommittenteDTO>();

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();


			pst=con.prepareStatement(sqlCommittentiPerFornitore);		
			pst.setInt(1, id_fornitore);
			

			rs=pst.executeQuery();


			while(rs.next())
			{
				DocumCommittenteDTO committente = new DocumCommittenteDTO();
				
				committente.setId(rs.getInt(1));
				committente.setNome_cliente(rs.getString(2));
				committente.setIndirizzo_cliente(rs.getString(3));
				lista.add(committente);

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

	
	public static ArrayList<DocumCommittenteDTO> insertDocumento(DocumTLDocumentoDTO documento) throws Exception {

		ArrayList<DocumCommittenteDTO> lista =new ArrayList<DocumCommittenteDTO>();

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=getConnection();


			pst=con.prepareStatement(sqlInsertDocumentoDocumentale);		

			pst.setInt(1, documento.getCommittente().getId());
			pst.setInt(2, documento.getFornitore().getId());
			pst.setString(3, documento.getNome_documento());
			pst.setString(4, documento.getNumero_documento());
			pst.setDate(5, new java.sql.Date(documento.getData_caricamento().getTime()));
			pst.setInt(6, documento.getFrequenza_rinnovo_mesi());
			pst.setString(7, documento.getRilasciato());
			pst.setDate(8, new java.sql.Date(documento.getData_scadenza().getTime()));
			pst.setString(9, documento.getNome_file());
			pst.setInt(10, documento.getStato().getId());
			pst.setInt(11, documento.getDocumento_sostituito());

			pst.execute();



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

	public static void updateStatoStrumentoScheduler() throws Exception {

		String query = "update strumento set id__stato_strumento_ = 7225 WHERE  id_tipo_rapporto = 7201 AND (data_prossima_verifica IS NULL OR data_prossima_verifica < NOW())";

		Connection con=null;
		PreparedStatement pst=null;

		con=getConnection();
		pst=con.prepareStatement(query);

		pst.executeUpdate();

		pst.close();
		con.close();
		
	}

	public static HashMap<Integer, Integer> getListaClientiConStrumenti() throws Exception {
		
		
		HashMap<Integer, Integer> listaClietiConStrumenti= new HashMap<Integer,Integer>();
		
		String query="select distinct(id_cliente) from strumento ";
		
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs = null;
		
		
		con=getConnection();
		pst=con.prepareStatement(query);

		rs=pst.executeQuery();
		
		while(rs.next()) 
		{
			int id_cliente=rs.getInt(1);
			
			listaClietiConStrumenti.put(id_cliente, id_cliente);
		}
		
		return listaClietiConStrumenti;
	}
	
	
	
public static ArrayList<ForPartecipanteDTO> getListaPartecipantiDirect(Session session) throws Exception {
		
		
	ArrayList<ForPartecipanteDTO> lista =new ArrayList<ForPartecipanteDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			pst=con.prepareStatement("SELECT * FROM FOR_PARTECIPANTE");
			rs=pst.executeQuery();
			
			ForPartecipanteDTO partecipante=null;
			
			while(rs.next())
			{
				partecipante= new ForPartecipanteDTO();
				partecipante.setId(rs.getInt("id"));
				partecipante.setCf(rs.getString("cf"));
				partecipante.setCognome(rs.getString("cognome"));
				partecipante.setData_nascita(rs.getDate("data_nascita"));
				partecipante.setId_azienda(rs.getInt("id_azienda"));
				partecipante.setId_sede(rs.getInt("id_sede"));
				partecipante.setLuogo_nascita(rs.getString("luogo_nascita"));
				partecipante.setNome(rs.getString("nome"));
				partecipante.setNome_azienda(rs.getString("nome_azienda"));
				partecipante.setNome_sede(rs.getString("nome_sede"));
				partecipante.setNote(rs.getString("note"));
				partecipante.setEmail(rs.getString("email"));
				
				
				lista.add(partecipante);
			}
			
		} catch (Exception e) {
			
			throw e;
		//	e.printStackTrace();
			
		}finally
		{
			pst.close();
			con.close();
		}
		
		return lista;
		
	}


public static ArrayList<ForCorsoDTO> getListaCorsiDirect(Session session) throws Exception {
	
	
	ArrayList<ForCorsoDTO> lista =new ArrayList<ForCorsoDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			pst=con.prepareStatement("SELECT * FROM FOR_CORSO WHERE DISABILITATO = 0");
			rs=pst.executeQuery();
			
			ForCorsoDTO corso=null;
			
			while(rs.next())
			{
				corso= new ForCorsoDTO();
				corso.setId(rs.getInt("id"));
				corso.setDescrizione(rs.getString("descrizione"));
				corso.setCommessa(rs.getString("commessa"));
				corso.setData_corso(rs.getDate("data_corso"));

				
				lista.add(corso);
			}
			
		} catch (Exception e) {
			
			throw e;
		//	e.printStackTrace();
			
		}finally
		{
			pst.close();
			con.close();
		}
		
		return lista;
		
	}
	
	



public static ArrayList<StrumentoDTO> getStrumentiFiltrati(String nome, String marca, String modello, String matricola, String codice_interno, int id_company) throws Exception {
	
	ArrayList<StrumentoDTO> lista = new ArrayList<StrumentoDTO>();
	
	
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=getConnection();

		

	String query = "select distinct id_strumento, id__stato_strumento_, denominazione, codice_interno, matricola, costruttore, modello, frequenza, campo_misura, risoluzione, tipo.nome from misura mis join strumento str on mis.id_strumento = str.__id join tipo_strumento tipo on tipo.__id = str.id__tipo_strumento_ where str.denominazione like ? "
			+ "and str.costruttore like ? "
			+ "and str.modello like ? "
			+ "and str.matricola like ? "
			+ "and str.codice_interno like ? "
			+ "and str.id__company_ = ?";
	
	pst=con.prepareStatement(query);
	
	pst.setString(1, "%"+nome+"%");
	pst.setString(2, "%"+marca+"%");
	pst.setString(3, "%"+modello+"%");
	pst.setString(4, "%"+matricola+"%");
	pst.setString(5, "%"+codice_interno+"%");
	pst.setInt(6, id_company);
	
	
	rs=pst.executeQuery();
	
	StrumentoDTO strumento = null;
	
	while(rs.next())
	{
		strumento = new StrumentoDTO();
		
		strumento.set__id(rs.getInt(1));
		strumento.setStato_strumento(new StatoStrumentoDTO(rs.getInt(2), ""));		
		strumento.setDenominazione(rs.getString(3));
		strumento.setCodice_interno(rs.getString(4));
		strumento.setMatricola(rs.getString(5));
		strumento.setCostruttore(rs.getString(6));
		strumento.setModello(rs.getString(7));
		strumento.setFrequenza(rs.getInt(8));
		strumento.setCampo_misura(rs.getString(9));
		strumento.setRisoluzione(rs.getString(10));
		strumento.setTipo_strumento(new TipoStrumentoDTO(0, rs.getString(11)));
		
		lista.add(strumento);

		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}

public static HashMap<String, Integer> getListaStrumentiScadenziario(UtenteDTO user) {
	String query="";
	HashMap<String, Integer> listMap= new HashMap<String, Integer>();
	try {
		
	Connection  con =getConnection();
    PreparedStatement pst=null;
    ResultSet rs=null;
	
	
	if(user.isTras())
	{
		query  = "select data_prossima_verifica from strumento  WHERE data_prossima_verifica IS NOT NULL";
		pst=con.prepareStatement(query);
		rs=pst.executeQuery();
	}
	else
	{
			if(user.getIdSede() != 0 && user.getIdCliente() != 0) {
				query  = "select data_prossima_verifica from strumento  WHERE data_prossima_verifica IS NOT NULL AND id__company_=?  AND id__sede_new =? AND id_cliente=?";
				pst=con.prepareStatement(query);
				
				pst.setInt(1, user.getCompany().getId());
				pst.setInt(2,user.getIdSede());
				pst.setInt(3, user.getIdCliente());
				
				rs=pst.executeQuery();
		
			}else if(user.getIdSede() == 0 && user.getIdCliente() != 0) {
				query  = "select data_prossima_verifica from strumento  WHERE data_prossima_verifica IS NOT NULL AND id__company_=? AND id_cliente=?";
				pst=con.prepareStatement(query);
				
				pst.setInt(1, user.getCompany().getId());
				pst.setInt(2, user.getIdCliente());
				
				rs=pst.executeQuery();
		
			}else {
				
				query  = "select data_prossima_verifica from strumento  WHERE data_prossima_verifica IS NOT NULL AND id__company_=?";
				pst=con.prepareStatement(query);
				
				pst.setInt(1, user.getCompany().getId());
				
				rs=pst.executeQuery();
			}
	}
	
	while(rs.next()) {
	
		String data=rs.getString(1);
		
			int i=1;
			
			if(listMap.get(data)!=null)
			{
				i= listMap.get(data)+1;
			}
			
				listMap.put(data,i);
			}

    } 
	catch(Exception e)
     {
    	 e.printStackTrace();
     } 
	return listMap;
}

public static void saveIngresso(IngIngressoDTO ingresso) throws Exception {

	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;
	try
	{
		con = getConnection();
		con.setAutoCommit(false);
		pst=con.prepareStatement(sqlInsertIngresso);
		if(ingresso.getTipo_registrazione()!=null) {
			pst.setInt(1, ingresso.getTipo_registrazione());
		}else {
			pst.setInt(1, 0);
		}
		
		pst.setString(2, ingresso.getNome_ditta());
		pst.setString(3, ingresso.getNominativo());
		if(ingresso.getId_reparto()!=null) {
			pst.setDate(4, new java.sql.Date(ingresso.getData_ingresso().getTime()));
		}else {
			pst.setDate(4,null);
		}
		if(ingresso.getId_reparto()!=null) {
			pst.setDate(5, new java.sql.Date(ingresso.getData_uscita().getTime()));
		}else {
			pst.setDate(5, null);
		}
		
		
		if(ingresso.getId_reparto()!=null) {
			pst.setInt(6, ingresso.getId_reparto());
		}else {
			pst.setInt(6, 0);
		}
		
		if(ingresso.getId_area()!=null) {
			pst.setInt(7, ingresso.getId_area());
		}else {
			pst.setInt(7, 0);
		}
	
		if(ingresso.getModalita_ingresso()!=null) {
			pst.setInt(8, ingresso.getModalita_ingresso());
		}else {
			pst.setInt(8, 0);
		}
	
		pst.setString(9, ingresso.getTelefono());
		
		if(ingresso.getTipo_merce()!=null) {
			pst.setInt(10, ingresso.getTipo_merce());
		}else {
			pst.setInt(10, 0);
		}
		
	
		pst.setString(11, ingresso.getTarga());

		pst.execute();

		con.commit();
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

public static ArrayList<IngIngressoDTO> getListaIngressi() throws Exception {
	
	ArrayList<IngIngressoDTO> lista = new ArrayList<IngIngressoDTO>();
		
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=getConnection();

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	String query = "select distinct id, tipo_registrazione, nome_ditta, nominativo_visitatore, data_ingresso, data_uscita, id_reparto, id_area, modalita_ingresso, telefono, tipo_merce, targa from ing_ingresso";
	
	pst=con.prepareStatement(query);
	

	rs=pst.executeQuery();
	
	IngIngressoDTO ingresso = null;
	
	while(rs.next())
	{
		ingresso = new IngIngressoDTO();
		
		ingresso.setId(rs.getInt(1));
		ingresso.setTipo_registrazione(rs.getInt(2));
		ingresso.setNome_ditta(rs.getString(3));
		ingresso.setNominativo(rs.getString(4));
		ingresso.setData_ingresso(rs.getDate(5));
		ingresso.setData_uscita(rs.getDate(6));
		ingresso.setId_reparto(rs.getInt(7));
		ingresso.setId_area(rs.getInt(8));
		ingresso.setModalita_ingresso(rs.getInt(9));
		ingresso.setTelefono(rs.getString(10));
		ingresso.setTipo_merce(rs.getInt(11));
		ingresso.setTarga(rs.getString(12));
		

		lista.add(ingresso);

		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}




public static ArrayList<ControlloOreDTO> getOrePrevisteOreScaricate() throws Exception {
	
	ArrayList<ControlloOreDTO> lista = new ArrayList<ControlloOreDTO>();
		
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=ManagerSQLServer.getConnectionSQL();

		
	pst=con.prepareStatement(sqlOrePrevisteOreScaricate);
	
	SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	rs=pst.executeQuery();
	
	ControlloOreDTO result = null;
	
	while(rs.next())
	{
		result = new ControlloOreDTO();
		
		if(rs.getString(1)!=null) {
			result.setUsername(rs.getString(1));
		}
		if(rs.getString(2)!=null) {
			result.setId_commessa(rs.getString(2));	
		}
		if(rs.getString(3)!=null) {
			result.setData_commessa(df.parse(rs.getString(3)));
		}
		if(rs.getString(4)!=null) {
			result.setOggetto_commessa(rs.getString(4));
		}
		if(rs.getString(5)!=null) {
			result.setCliente(rs.getString(5));
		}
		if(rs.getString(6)!=null) {			
			result.setFase(rs.getString(6) +" - "+ rs.getString(7));
		}
		
		if(rs.getString(8)!=null && !rs.getString(8).equals("")) {
			result.setOre_previste(Double.parseDouble(rs.getString(8)));
		}else {
			result.setOre_previste(0.0);
		}
		if(rs.getString(9)!=null && !rs.getString(9).equals("")) {
			result.setOre_scaricate(Double.parseDouble(rs.getString(9)));
		}else {
			result.setOre_scaricate(0.0);
		}
		if(rs.getString(10)!=null) {
			result.setGlb_fase(rs.getString(10));
		}
		if(rs.getString(11)!=null) {
			result.setMilestone(rs.getString(11));
		}
		
		result.setScostamento(result.getOre_previste() - result.getOre_scaricate());
				
		lista.add(result);

		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}

public static void updateOrigineDashboard(String origine, int stato, String utente,boolean fornitore) throws Exception {


	Connection con=null;
	PreparedStatement pst = null;
	 ResultSet rs = null;
	
	 String table="";
	 if(fornitore) 
	 {
		 table="mag_pacco_dashboard_for";
	 }else 
	 {
		 table="mag_pacco_dashboard";
	 }
	try {
		con=getConnection();

		  String checkQuery = "SELECT COUNT(*) FROM "+table+" WHERE origine = ?";
	        pst = con.prepareStatement(checkQuery);
	        pst.setString(1, origine);
	        rs = pst.executeQuery();
	        rs.next();
	        int count = rs.getInt(1);
	        rs.close();
	        pst.close();

	        if (count > 0) {
	            // Se esiste, esegui un UPDATE
	            String updateQuery = "UPDATE "+table+" SET stato = ?, utente = ? WHERE origine = ?";
	            pst = con.prepareStatement(updateQuery);
	            pst.setInt(1, stato);
	            pst.setString(2, utente);
	            pst.setString(3, origine);
	        } else {
	            // Se non esiste, esegui un INSERT
	            String insertQuery = "INSERT INTO "+table+" (origine, stato, utente) VALUES (?, ?, ?)";
	            pst = con.prepareStatement(insertQuery);
	            pst.setString(1, origine);
	            pst.setInt(2, stato);
	            pst.setString(3, utente);
	        }

			pst.executeUpdate();
	
	} catch (Exception e) {
		
		e.printStackTrace();
		throw e;
		
		
	}finally
	{
		pst.close();
		con.close();
	}
}


public static ArrayList<String> getItemInRitardoDashboard(Session session) throws Exception {

	ArrayList<String> lista = new ArrayList<String>();
	 List<Object[]> results = new ArrayList<Object[]>();
	
	Connection con=null;
	PreparedStatement pst = null;
	 ResultSet rs = null;
	
	try {
		con=getConnection();

		  String query = "SELECT distinct b.commessa,b.data_arrivo, b.data_lavorazione,b.origine,b.nome_cliente, d.stato, d.utente, c.priorita FROM mag_item_pacco a JOIN mag_pacco b ON a.id_pacco = b.id JOIN mag_item c ON a.id_item = c.id LEFT JOIN  mag_pacco_dashboard d ON b.origine = d.origine WHERE b.id_stato_lavorazione = 1 AND c.stato = 1 AND b.chiuso = 0";
	        pst = con.prepareStatement(query);
	       
	        rs = pst.executeQuery();
	        
	        rs=pst.executeQuery();

			MagPaccoDTO pacco_res= null;
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			while(rs.next()) 
			{
				pacco_res = new MagPaccoDTO();
				pacco_res.setCommessa(rs.getString(1));
				pacco_res.setData_arrivo(rs.getDate(2));
				pacco_res.setData_lavorazione(rs.getDate(3));
				pacco_res.setOrigine(rs.getString(4));
				pacco_res.setNome_cliente(rs.getString(5));
				Object[] result = new Object[4];
				result[0] = pacco_res;
				result[1] = rs.getInt(6);
				result[2] = rs.getString(7);
				result[3] = rs.getInt(8);
				results.add(result);
			}
	        
	
			
			for (Object[] result : results) {
		        MagPaccoDTO pacco = (MagPaccoDTO) result[0];
		        Integer stato = (Integer) result[1];
		        String utente = (String) result[2];
		        Integer urgente = (Integer) result[3];

				
				java.util.Date utilDate = null;
				java.util.Date dataCommessa = null;
				if(pacco.getCommessa()!=null && !pacco.getCommessa().equals("")) {
					CommessaDTO commessa = GestioneCommesseDAO.getCommessaById(pacco.getCommessa());
					if(commessa!=null) {
						dataCommessa = commessa.getDT_COMMESSA();
					}
				}
				

				if(dataCommessa!=null && pacco.getData_arrivo().before(dataCommessa)) {
					utilDate = new java.util.Date(dataCommessa.getTime());
				}else {
					utilDate = new java.util.Date(pacco.getData_arrivo().getTime());
				}
					 
					Instant instant = utilDate.toInstant();
					
					LocalDate date10 = Utility.sommaGiorniLavorativi(instant.atZone(ZoneId.systemDefault()).toLocalDate(), 6);
					
					LocalDate date15 = Utility.sommaGiorniLavorativi(instant.atZone(ZoneId.systemDefault()).toLocalDate(), 14);
					
					
					
					//if(Utility.getRapportoLavorati(pacco)!=1 && (date10.isBefore(LocalDate.now()) || date10.equals(LocalDate.now()))) {
					if(Utility.getRapportoLavorati(pacco)!=1) {

						
						String toAdd = pacco.getOrigine()+";"+pacco.getNome_cliente();
						
						if(pacco.getCommessa()!=null) {
							toAdd = toAdd +";"+pacco.getCommessa();
							if(!pacco.getCommessa().equals("")) {
								toAdd = toAdd +";"+df.format(dataCommessa);
							}else {
								toAdd = toAdd +";";
							}
						}
						if(pacco.getData_arrivo()!=null) {
							toAdd = toAdd +";"+df.format(pacco.getData_arrivo()); 
						}
						if(pacco.getData_lavorazione()!=null) {
							toAdd = toAdd +";"+df.format(pacco.getData_lavorazione()); 
						}
						
						
						long giorniMancanti = Utility.giorniLavorativiTraDate(LocalDate.now(), date15);
						
											
						if(giorniMancanti>0) {
							toAdd = toAdd +";"+" - "+giorniMancanti;
						}else {
							toAdd = toAdd +";"+" + "+Math.abs(giorniMancanti);
						}
						
						ArrayList<MagPaccoDTO> lista_pacchi_origine = GestioneMagazzinoDAO.getListaPacchiByOrigine(pacco.getOrigine(), session);
						
						String note_pacco = "";

						for (MagPaccoDTO magPaccoDTO : lista_pacchi_origine) {
							
							if(date10.isBefore(LocalDate.now()) || date10.equals(LocalDate.now())){
								magPaccoDTO.setRitardo(1);	
							}
							
					
							
							if(magPaccoDTO.getTipo_nota_pacco()!=null) {
								note_pacco = note_pacco + magPaccoDTO.getTipo_nota_pacco().getDescrizione() +" - ";
							}
							
						}		
					
						
						if(stato!=null) {
							toAdd = toAdd+";"+stato;
						}else {
							toAdd = toAdd+";";
						}
						if(utente!=null) {
							toAdd = toAdd+";"+utente;
						}else {
							toAdd = toAdd+";";
						}
						
						if(urgente!=null) {
							toAdd = toAdd+";"+urgente;
						}else {
							toAdd = toAdd+";";
						}
						
						if(!note_pacco.equals("")) {
							note_pacco = note_pacco.substring(0, note_pacco.length()-3).replace("\r\n", "").replace("\n", "");
							toAdd = toAdd+";"+note_pacco;
						}else {
							toAdd = toAdd+";";
						}
					
						lista.add(toAdd);

					}
				
			}
		
	       
	        rs.close();
	        pst.close();
	    	
			return lista;
			

	     
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	
}

public static ArrayList<String> getItemPresso_Fornitori(Session session) throws Exception {

	ArrayList<String> lista = new ArrayList<String>();
	 List<Object[]> results = new ArrayList<Object[]>();
	
	Connection con=null;
	PreparedStatement pst = null;
	 ResultSet rs = null;
	
	try {
		con=getConnection();

		//  String query = "SELECT distinct b.commessa,b.data_arrivo, b.data_lavorazione,b.origine,b.nome_cliente, d.stato, d.utente, c.priorita FROM mag_item_pacco a JOIN mag_pacco b ON a.id_pacco = b.id JOIN mag_item c ON a.id_item = c.id LEFT JOIN  mag_pacco_dashboard d ON b.origine = d.origine WHERE b.id_stato_lavorazione = 1 AND c.stato = 1 AND b.chiuso = 0";
	     String query="SELECT p.id,p.data_spedizione,p.chiuso," + 
	     		"p.commessa,p.data_arrivo, p.data_lavorazione,p.origine,p.nome_cliente, d.stato,d.utente,p.fornitore,p.id_ddt  "+ 
	     		"FROM mag_pacco p " + 
	     		"LEFT JOIN  mag_pacco_dashboard_for d ON p.id = d.origine " + 
	     		"WHERE p.id_stato_lavorazione = 4 " + 
	     		"AND p.chiuso=0 " + 
	     		"   " + 
	     		"  AND EXISTS ( " + 
	     		"    SELECT 1 " + 
	     		"    FROM mag_item_pacco ip " + 
	     		"    JOIN mag_item i ON i.id = ip.id_item " + 
	     		"    WHERE ip.id_pacco = p.id " + 
	     		"      AND i.stato = 1)";
		  pst = con.prepareStatement(query);
	       
	        rs = pst.executeQuery();
	        
	        rs=pst.executeQuery();

			MagPaccoDTO pacco_res= null;
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			while(rs.next()) 
			{
				pacco_res = new MagPaccoDTO();
				pacco_res.setId(rs.getInt("p.id"));
				pacco_res.setCommessa(rs.getString("p.commessa"));
				pacco_res.setData_arrivo(rs.getDate("p.data_arrivo"));
				pacco_res.setData_spedizione(rs.getDate("p.data_spedizione"));
				pacco_res.setData_lavorazione(rs.getDate("p.data_lavorazione"));
				pacco_res.setOrigine(rs.getString("p.origine"));
				pacco_res.setNome_cliente(rs.getString("p.nome_cliente"));
				pacco_res.setFornitore(rs.getString("fornitore"));
				
				Object[] result = new Object[4];
				result[0] = pacco_res;
				result[1] = rs.getInt(9);
				result[2] = rs.getString(10);
				result[3] = rs.getInt("id_ddt");
				results.add(result);
			}
	        
	
			
			for (Object[] result : results) {
		        MagPaccoDTO pacco = (MagPaccoDTO) result[0];
		        Integer stato = (Integer) result[1];
		        String utente = (String) result[2];

				java.util.Date dataCommessa = null;
				if(pacco.getCommessa()!=null && !pacco.getCommessa().equals("")) {
					CommessaDTO commessa = GestioneCommesseDAO.getCommessaById(pacco.getCommessa());
					if(commessa!=null) {
						dataCommessa = commessa.getDT_COMMESSA();
					}
				}
		
						
						String toAdd = pacco.getOrigine()+";"+pacco.getId()+";"+pacco.getNome_cliente();
						
						if(pacco.getCommessa()!=null) {
							toAdd = toAdd +";"+pacco.getCommessa();
							if(!pacco.getCommessa().equals("")) {
								toAdd = toAdd +";"+df.format(dataCommessa);
							}else {
								toAdd = toAdd +";";
							}
						}
						
						MagPaccoDTO origine= GestioneMagazzinoDAO.getPaccoId(Integer.parseInt(pacco.getOrigine().split("_")[1]), session);
						
						if(origine.getData_arrivo()!=null) {
							toAdd = toAdd +";"+df.format(origine.getData_arrivo()); 
						}
						if(pacco.getData_spedizione()!=null) {
							toAdd = toAdd +";"+df.format(pacco.getData_spedizione()); 
						}
						
						LocalDate dateSped = Instant.ofEpochMilli(
						        pacco.getData_spedizione().getTime()
						).atZone(ZoneId.systemDefault())
						 .toLocalDate();
						
						long giorniMancanti = Utility.giorniLavorativiTraDate(LocalDate.now(), dateSped);
						
						//long giorniMancanti = 10;
											
						if(giorniMancanti>0) {
							toAdd = toAdd +";"+" - "+giorniMancanti;
						}else {
							toAdd = toAdd +";"+" + "+Math.abs(giorniMancanti);
						}

						String note_pacco = "";

						if(utente!=null) {
							toAdd = toAdd+";"+utente;
						}else {
							toAdd = toAdd+";";
						}
						
						if(stato!=null) {
							toAdd = toAdd+";"+stato;
						}else {
							toAdd = toAdd+";";
						}
						
						if(!note_pacco.equals("")) {
							note_pacco = note_pacco.substring(0, note_pacco.length()-3).replace("\r\n", "").replace("\n", "");
							toAdd = toAdd+";"+note_pacco;
						}else {
							toAdd = toAdd+";";
						}
						
						if(pacco.getFornitore()!=null) {
							toAdd = toAdd +";"+pacco.getFornitore(); 
						}else 
						{
							toAdd = toAdd+";";
						}
						toAdd=toAdd+";"+result[3];
					
						lista.add(toAdd);

			//		}
				
			}
		
	       
	        rs.close();
	        pst.close();
	    	
			return lista;
			

	     
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	
}

public static Map<String, String> getOrePrevisteTotali() throws Exception {
	
	
	Map<String, String> lista = new HashMap<>();
	
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=ManagerSQLServer.getConnectionSQL();

		
	pst=con.prepareStatement(sqlOrePrevisteTotali);
	

	rs=pst.executeQuery();
	
	
	while(rs.next())
	{
		lista.put(rs.getString(2), rs.getString(1));
		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}

public static ArrayList<DevSoftwareDTO> getListaSoftwareFiltro(int id_company) throws Exception {
	
	ArrayList<DevSoftwareDTO> lista = new ArrayList<DevSoftwareDTO>();
	
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=getConnection();

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");


		String query = "SELECT " + 
				"    d.ragione_sociale AS company, " + 
				"    e.nome AS nome_utente, " + 
				"    e.cognome, " + 
				"    b.*, " + 
				"    a.id AS id_device, " + 
				"    a.codice_interno, " + 
				"    a.denominazione,  " + 
				"    f.descrizione AS descr_tipo_licenza, "+
				"    g.id AS id_contratto, "+
				"    g.fornitore AS fornitore_contratto, "+
				"    g.data_scadenza AS data_scadenza_contratto, "+
				"    g.subscription "+
				"FROM dev_software b " + 
				"LEFT JOIN dev_device_software c ON b.id = c.id_software " + 
				"LEFT JOIN dev_device a ON c.id_device = a.id " + 
				"LEFT JOIN docum_fornitore d ON a.id_company_util = d.id " + 
				"LEFT JOIN docum_dipendente_forn e ON a.id_docum_dipendente_forn = e.id "+
				"LEFT JOIN dev_tipo_licenza f on b.id_tipo_licenza = f.id "+
				"LEFT JOIN dev_contratto g on b.id_contratto = g.id "+
				"WHERE b.disabilitato = 0";
	
	if(id_company != 0) {
		query += " AND a.id_company_util = "+id_company;
	}
	
	pst=con.prepareStatement(query);
	

	rs=pst.executeQuery();
	
	DevSoftwareDTO software = null;
	
	while(rs.next())
	{
		software = new DevSoftwareDTO();
		
		software.setId(rs.getInt("Id"));
		software.setNome(rs.getString("nome"));
		software.setProduttore(rs.getString("produttore"));
		software.setVersione(rs.getString("versione"));
		software.setData_acquisto(rs.getDate("data_acquisto"));
		software.setData_scadenza(rs.getDate("data_scadenza"));
		software.setEmail_responsabile(rs.getString("email_responsabile"));
		software.setObsoleto(rs.getString("obsoleto"));
		software.setDisabilitato(rs.getInt("disabilitato"));
		Integer tipo_licenza = rs.getInt("id_tipo_licenza");
		if(tipo_licenza!=null && tipo_licenza!=0) {
			software.setTipo_licenza(new DevTipoLicenzaDTO(tipo_licenza, rs.getString("descr_tipo_licenza")));	
		}
		if(rs.getString("nome_utente")!=null) {
			software.setUtente(rs.getString("nome_utente")+ " "+ rs.getString("cognome"));
		}else {
			software.setUtente(null);
		}
		
		software.setCompany(rs.getString("company"));
		
		Integer id_device = rs.getInt("id_device");
		
		if(id_device!=null && id_device!=0) {			
			DevDeviceDTO device = new DevDeviceDTO();
			device.setId(id_device);
			device.setDenominazione(rs.getString("denominazione"));
			device.setCodice_interno(rs.getString("codice_interno"));
		
			software.setDevice(device);
		}
		
		Integer id_contratto = rs.getInt("id_contratto");
		
		if(id_contratto!=null && id_contratto!=0) {			
			DevContrattoDTO contratto = new DevContrattoDTO();
			contratto.setId(id_contratto);
			contratto.setData_scadenza(rs.getDate("data_scadenza_contratto"));
			contratto.setFornitore(rs.getString("fornitore_contratto"));
			contratto.setSubscription(rs.getString("subscription"));
			
		
			software.setContratto(contratto);;
		}
		

		lista.add(software);

		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}

public static Map<Integer, Integer> getListaRelazioni() throws Exception {
	Map<Integer, Integer> map= new HashMap<Integer, Integer>();
	
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=getConnection();

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");


		String query = "SELECT * from pr_req_relazioni";
	
	
	pst=con.prepareStatement(query);
	

	rs=pst.executeQuery();
	
	while(rs.next())
	{
		
		
		Integer id_req_doc = rs.getInt("id_req_documentale");
		Integer id_req_san = rs.getInt("id_req_sanitario");
		
		map.put(id_req_doc, id_req_san);
		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return map;
}

public static ArrayList<PRInterventoRisorsaDTO> getListaInterventoRisorseAll(Session session) throws Exception {


	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	ArrayList<PRInterventoRisorsaDTO> lista = new ArrayList<PRInterventoRisorsaDTO>();
	try {
		con=getConnection();

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

		
		String query = "SELECT a.*, b.nome_cliente, b.nome_sede, b.id_commessa from pr_intervento_risorsa a left join intervento b on a.id_intervento = b.id";
	
	
	pst=con.prepareStatement(query);
	

	rs=pst.executeQuery();
	
	while(rs.next())
	{
		PRInterventoRisorsaDTO res = new PRInterventoRisorsaDTO();
		res.setId(rs.getInt("a.id"));
		res.setIntervento(rs.getInt("id_intervento"));
		PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, rs.getInt("id_risorsa"));
		res.setData_inizio(rs.getDate("data_inizio"));
		res.setData_fine(rs.getDate("data_fine"));
		res.setCella_inizio(rs.getInt("cella_inizio"));
		res.setCella_fine(rs.getInt("cella_fine"));
		
		res.setRisorsa(risorsa);
		res.setAssenza(rs.getInt("assenza"));
		res.setPermesso(rs.getInt("permesso"));
		
		if(res.getAssenza()==1) {
			res.setTesto_riquadro("ASSENZA");
		}
		else if(res.getPermesso()==1) {
			res.setTesto_riquadro("PERMESSO");
		}
		else {
			res.setTesto_riquadro(rs.getString("id_commessa") + " - " +rs.getString("nome_cliente")+" - "+rs.getString("nome_sede"));
		}
		
		lista.add(res);
		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}

public static ArrayList<InterventoDTO> getListainterventiAperti() throws Exception {
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	ArrayList<InterventoDTO> lista = new ArrayList<InterventoDTO>();
	try {
		con=getConnection();


		String query = "SELECT * from intervento where id_stato_intervento = 1";
	
	
	pst=con.prepareStatement(query);
//	pst.setDate(1, java.sql.Date.valueOf(inizio));
//	pst.setDate(2, java.sql.Date.valueOf(fine));

	rs=pst.executeQuery();
	
	while(rs.next())
	{
		InterventoDTO res = new InterventoDTO();
		res.setId(rs.getInt("id"));
		res.setPressoDestinatario(rs.getInt("presso_destinatario"));
		//UtenteDTO user = GestioneUtenteBO.getUtenteById(""+rs.getInt("id__user_creation"), session);
		//res.setUser(user);
		
        res.setIdSede(rs.getInt("id__sede_"));
        res.setId_cliente(rs.getInt("id_cliente"));
        res.setNome_cliente(rs.getString("nome_cliente"));
        res.setNome_sede(rs.getString("nome_sede"));
        res.setIdCommessa(rs.getString("id_commessa"));
        res.setDataCreazione(rs.getDate("data_creazione"));
        StatoInterventoDTO stato = new StatoInterventoDTO();
        int id_stato = rs.getInt("id_stato_intervento");
        stato.setId(id_stato);
        if(id_stato == 1) {
        	stato.setDescrizione("APERTO");
        }else if(id_stato == 2) {
        	stato.setDescrizione("CHIUSO");
        }else if(id_stato ==3) {
        	stato.setDescrizione("GENERATO");
        }
        res.setStatoIntervento(stato);
       // res.setNomePack(rs.getString("nomePack"));

        lista.add(res);
		
	}
	
	} catch (Exception e) {
		
		throw e;
	//	e.printStackTrace();
		
	}finally
	{
		pst.close();
		con.close();
	}
	

	return lista;
}

public static ForCorsoDTO getCorsoFromIdDirect(int id_corso) throws Exception {
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    ForCorsoDTO res = null;

    try {
        con = getConnection();

        String query = "SELECT * FROM for_corso WHERE id = ?";
        pst = con.prepareStatement(query);
        pst.setInt(1, id_corso);

        rs = pst.executeQuery();

        if (rs.next()) {
            res = new ForCorsoDTO();

            res.setId(rs.getInt("id"));
         
            res.setDescrizione(rs.getString("descrizione"));
          
        }

    } catch (Exception e) {
        throw e;
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }

    return res;
}

public static ForPartecipanteRuoloCorsoDTO getAttestato(String cf, int id_corso) throws Exception {
	Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    ForPartecipanteRuoloCorsoDTO res = null;

    try {
        con = getConnection();

        String query = "SELECT attestato, id_partecipante FROM for_partecipante_ruolo_corso WHERE id_corso = ? and id_partecipante =(SELECT id from for_partecipante where cf = ?)";
        pst = con.prepareStatement(query);
        pst.setInt(1, id_corso);
        pst.setString(2, cf);

        rs = pst.executeQuery();

        if (rs.next()) {
            res =new ForPartecipanteRuoloCorsoDTO();
            ForPartecipanteDTO p = new ForPartecipanteDTO();
            p.setId(rs.getInt("id_partecipante"));
            res.setPartecipante(p);		
            res.setAttestato(rs.getString("attestato"));

         
          
        }

    } catch (Exception e) {
        throw e;
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }

    return res;
}



public static Map<Integer, List<Integer>> getListaCorsiSuccessiviCategoria(String date,
		int id_categoria, int id_corso, Session session) throws Exception {
	Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    ArrayList<ForPartecipanteRuoloCorsoDTO> res =  new ArrayList<ForPartecipanteRuoloCorsoDTO>();
    Map<Integer, List<Integer>> corsoPartecipantiMap = new HashMap<>();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    try {
        con = getConnection();
        
        java.sql.Date sql1 = new java.sql.Date(sdf.parse(date).getTime());
        //String query = "SELECT * FROM for_partecipante_ruolo_corso JOIN for_corso on for_partecipante_ruolo_corso.id_corso = for_corso.id WHERE for_corso.data_scadenza > ? and for_corso.id_corso = ? and for_corso.disabilitato = 0";
        
        

//        String query = "SELECT for_partecipante_ruolo_corso.id_partecipante FROM for_partecipante_ruolo_corso JOIN for_corso ON for_partecipante_ruolo_corso.id_corso = for_corso.id WHERE for_corso.data_scadenza > ?"+
//			"AND for_corso.disabilitato = 0 "+
//			"AND for_corso.id_corso = ? "+
//			"AND id_partecipante IN (SELECT id_partecipante FROM for_partecipante_ruolo_corso WHERE id_corso = ?) "+
//			"AND for_partecipante_ruolo_corso.id_corso != ?";
        
        String query = " SELECT DISTINCT p1.id_partecipante, p1.id_corso "+
        "FROM for_partecipante_ruolo_corso p1 "+
       " JOIN for_corso c1 ON p1.id_corso = c1.id "+
       " JOIN for_partecipante_ruolo_corso p2 ON p1.id_partecipante = p2.id_partecipante "+
       " JOIN for_corso c2 ON p2.id_corso = c2.id "+
       " WHERE c1.id_corso = c2.id_corso "+
       " AND c1.id <> c2.id"+
       "   AND c2.data_scadenza > c1.data_scadenza "+
       "   AND c2.data_scadenza > ? "+  
        "  AND c1.disabilitato = 0 "+
       "   AND c2.disabilitato = 0 ";
        
        pst = con.prepareStatement(query);
        pst.setDate(1, sql1);
        //pst.setInt(2, id_categoria);
      //  pst.setInt(3, id_corso);
       // pst.setInt(4, id_corso);

        rs = pst.executeQuery();

        while (rs.next()) {
//        	ForPartecipanteRuoloCorsoDTO prc = new ForPartecipanteRuoloCorsoDTO();
//            ForPartecipanteDTO p = new ForPartecipanteDTO();
//        	ForCorsoDTO c = new ForCorsoDTO();
//            p.setId(rs.getInt("p1.id_partecipante"));
//           c.setId(rs.getInt("p1.id_corso"));
//            ForCorsoCatDTO cat = new ForCorsoCatDTO();
//           cat.setId(rs.getInt("c1.id_corso"));
//            c.setCorso_cat(cat);
////            c.setData_scadenza(rs.getDate("data_scadenza"));
//            prc.setPartecipante(p);		
//            prc.setCorso(c);
//            
//        	//int id = rs.getInt("id_partecipante");
//            res.add(prc);
//            
            int idCorso = rs.getInt("p1.id_corso");
            int idPartecipante = rs.getInt("p1.id_partecipante");
            corsoPartecipantiMap
            .computeIfAbsent(idCorso, k -> new ArrayList<>())
            .add(idPartecipante);
          
        }

    } catch (Exception e) {
        throw e;
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }

    return corsoPartecipantiMap;
}

public static void insertIndicePrestazione(Connection conSQLLite, int idCliente, int idSede) throws Exception {
	
	Connection con=null;
	PreparedStatement pst=null;
	PreparedStatement pstINS=null;
	ResultSet rs= null;

	try
	{
		con=getConnection();
		conSQLLite.setAutoCommit(false);
		pst=con.prepareStatement(sqlIndicePrestazione);
		pst.setInt(1,idCliente);
		pst.setInt(2,idSede);

		rs=pst.executeQuery();

		String sqlInsert = "INSERT INTO tbl_indici_prestazione (id, id_str, dataMisura, ip) VALUES (?, ?, ?, ?)";
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		while(rs.next())
		{

			int id=rs.getInt(1);
			int id_strumento=rs.getInt(2);
			Date dataMisura=rs.getDate(3);
			String ip=rs.getString(4);
	
			pstINS=conSQLLite.prepareStatement(sqlInsert);
			pstINS.setInt(1, id);
			pstINS.setInt(2, id_strumento);
			pstINS.setString(3, sdf.format(dataMisura));          
			pstINS.setString(4, ip);  

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

}



