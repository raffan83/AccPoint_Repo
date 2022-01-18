package it.portaleSTI.DAO;

import java.math.BigDecimal;
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
import java.util.LinkedHashSet;
import java.util.Set;

import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LatMasterDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;

import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StatoRicezioneStrumentoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerFamigliaStrumentoDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerMotivoVerificaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;
import it.portaleSTI.DTO.VerTipoVerificaDTO;
import it.portaleSTI.DTO.VerTipologiaStrumentoDTO;
import it.portaleSTI.Util.Costanti;


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
																		"reparto varchar(255),"+
																		"utilizzatore varchar(255),"+
																		"procedura varchar(255),"+
																		"id_tipo_strumento Integer," +
																		"note varchar(255)," +
																		"creato varcar(1)," +
																		"importato varchar(1)," +
																		"dataUltimaVerifica Date," +
																		"dataProssimaVerifica Date," +
																		"nCertificato varchar(255)," +
																		"strumentoModificato varchar(1)," +
																		"luogo_verifica varchar(255));";

private static String sqlCreateStrumentTableVER="CREATE TABLE ver_strumento ( id Integer primary key autoincrement," + 
													"  denominazione varchar(255) NOT NULL," + 
													"  costruttore varchar(50) default NULL," + 
													"  modello varchar(50) default NULL," + 
													"  matricola varchar(50) NOT NULL," + 
													"  classe int(1) NOT NULL default '0'," + 
													"  id_ver_tipo_strumento int(11) NOT NULL default '0'," + 
													"  um varchar(4) NOT NULL," + 
													"  data_ultima_verifica varchar(50) default NULL," + 
													"  data_prossima_verifica varchar(50) default NULL," + 
													"  portata_min_C1 decimal(10,5) ," + 
													"  portata_max_C1 decimal(10,5) ," + 
													"  div_ver_C1 decimal(10,5) ," + 
													"  div_rel_C1 decimal(10,5) ," + 
													"  numero_div_C1 decimal(10,5) ," + 
													"  portata_min_C2 decimal(10,5) ," + 
													"  portata_max_C2 decimal(10,5)," + 
													"  div_ver_C2 decimal(10,5) ," + 
													"  div_rel_C2 decimal(10,5)," + 
													"  numero_div_C2 decimal(10,5) ," + 
													"  portata_min_C3 decimal(10,5)," + 
													"  portata_max_C3 decimal(10,5) ," + 
													"  div_ver_C3 decimal(10,5) ," + 
													"  div_rel_C3 decimal(10,5) ," + 
													"  numero_div_C3 decimal(10,5)," + 
													"  id_cliente int(11) default NULL," + 
													"  id_sede int(11) default NULL," + 
													"  nome_cliente int(11) default NULL," + 
													"  nome_sede int(11) default NULL,"
													+ "anno_marcatura_CE int(4) default NULL,"
													+ "data_ms  varchar(50) default NULL,"
													+ "id_tipologia int(11) default NULL,"
													+ "freq_mesi int(11) default NULL,"
													+ "creato varchar(1) default NULL,"
													+ "famiglia_strumento varchar(5) default NULL);";

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
		    													  "valore_taratura decimal(30,15),"+
		    													  "valore_nominale decimal(30,15),"+
		    													  "divisione_unita_misura decimal(30,15),"+
		    													  "incertezza_assoluta decimal(30,15),"+
		    													  "incertezza_relativa decimal(30,15),"+
		    													  "id_tipo_grandezza Integer,"+
		    													  "interpolazione_permessa Integer,"+
		    													  "tipoGrandezza varchar(255)," +
		    													  "abilitato varchar(1));";

private static String sqlCreateCMPTableLAT="CREATE TABLE tblCampioni(id_camp Integer," +
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
																	  "valore_taratura decimal(30,15),"+
																	  "valore_nominale decimal(30,15),"+
																	  "valore_scostamento_precedente decimal(30,15),"+
																	  "divisione_unita_misura decimal(30,15),"+
																	  "incertezza_assoluta decimal(30,15),"+
																	  "incertezza_relativa decimal(30,15),"+
																	  "id_tipo_grandezza Integer,"+
																	  "interpolazione_permessa Integer,"+
																	  "tipoGrandezza varchar(255)," +
																	  "abilitato varchar(1));";

private static String sqlCreateMISTab="CREATE TABLE tblMisure(id Integer primary key autoincrement , id_str Integer, dataMisura Date, temperatura decimal(30,15) , umidita decimal(30,15),tipoFirma Integer ,statoRicezione Intgeger,statoMisura Integer);";

/*private static String sqlCreateMisOpt="CREATE TABLE tblTabelleMisura(id Integer primary key autoincrement,id_misura Integer," +
																	 "id_tabella Integer," +
																	 "id_ripetizione Integer," +
																	 "ordine Integer," +
																	 "tipoProva char(1)," +
																	 "label varchar(255)," +
																	 "tipoVerifica varchar(255)," +
																	 "um varchar(50)," +
																	 "valoreCampione decimal(30,15)," +
																	 "valoreMedioCampione decimal(30,15)," +
																	 "valoreStrumento decimal(30,15)," +
																	 "valoreMedioStrumento decimal(30,15)," +
																	 "scostamento decimal(30,15)," +
																	 "accettabilita decimal(30,15)," +
																	 "incertezza decimal(30,15)," +
																	 "esito varchar(10)," +
																	 "desc_campione varchar(255)," +
																	 "desc_parametro varchar(255)," +
																	 "misura decimal(30,15)," +
																	 "um_calc varchar(50)," +
																	 "risoluzione_misura decimal(30,15)," +
																	 "risoluzione_campione decimal(30,15)," +
																	 "fondo_scala decimal(30,15)," +
																	 "interpolazione Integer," +
																	 "fm varchar(255)," +
																	 "selConversione Integer," +
																	 "selTolleranza Integer," +
																	 "letturaCampione decimal(30,15) , " +
																	 "calibrazione varchar(50) ," +
																	 "perc_util decimal(30,15)," +
																	 "val_misura_prec decimal(30,15)," +
																	 "val_campione_prec decimal(30,15)," +
																	 "applicabile varchar(1)," +
																	 "dgt varchar(255));";*/

private static String sqlCreateMisOpt="CREATE TABLE tblTabelleMisura(id Integer primary key autoincrement,id_misura Integer," +
										 "id_tabella Integer," +
										 "id_ripetizione Integer," +
										 "ordine Integer," +
										 "tipoProva char(1)," +
										 "label varchar(255)," +
										 "tipoVerifica varchar(255)," +
										 "um varchar(50)," +
										 "valoreCampione varchar(255)," +
										 "valoreMedioCampione varchar(255)," +
										 "valoreStrumento varchar(255)," +
										 "valoreMedioStrumento varchar(255)," +
										 "scostamento varchar(255)," +
										 "accettabilita varchar(255)," +
										 "incertezza varchar(255)," +
										 "esito varchar(10)," +
										 "desc_campione varchar(255)," +
										 "desc_parametro varchar(255)," +
										 "misura varchar(255)," +
										 "um_calc varchar(50)," +
										 "risoluzione_misura varchar(255)," +
										 "risoluzione_campione varchar(255)," +
										 "fondo_scala varchar(255)," +
										 "interpolazione Integer," +
										 "fm varchar(255)," +
										 "selConversione Integer," +
										 "selTolleranza Integer," +
										 "letturaCampione varchar(255) , " +
										 "calibrazione varchar(50) ," +
										 "perc_util varchar(255)," +
										 "val_misura_prec varchar(255)," +
										 "val_campione_prec varchar(255)," +
										 "val_esito_prec varchar(255),"+
										 "val_descrizione_prec varchar(255),"+
										 "applicabile varchar(1)," +
										 "dgt varchar(255)," +
										 "file_att blob,"+
										 "file_att_prec blob);";

private static String sqlCreateTipoStr_tipoGra="CREATE TABLE tbl_ts_tg(id_tipo_grandezza Integer ," +
																	 "id_tipo_strumento Integer);";

private static String sqlCreateClassificazione="CREATE TABLE tbl_classificazione(id Integer ," +
		 															   "descrizione Varchar(255));";

private static String sqlCreateLuogoVerifica="CREATE TABLE tbl_luogoVerifica(id Integer ," +
		   									 "descrizione Varchar(255));";

private static String sqlCreateTipoRapporto="CREATE TABLE tbl_tipoRapporto(id Integer ," +
		   															"descrizione Varchar(255));";

private static String sqlCreateStatoStumento="CREATE TABLE tbl_statoStrumento(id Integer ," +
		   															"descrizione Varchar(255));";

private static String sqlCreateTipoStumento="CREATE TABLE tbl_tipoStrumento(id Integer ," +
																			"descrizione Varchar(255));";
			
private static String sqlCreateGeneral="CREATE TABLE tbl_general(id Integer ," +
																	"sede varchar(255),upload varchar(1));";

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


private static String sqlCreateGeneralCampionamento="CREATE TABLE tbl_general(commessa varchar(255),cliente varchar(255)," +
																			 "temp_tras decimal(5,2)," +
																			 "data_prelievo date," +
																			 "tipoMatrice varchar(255), tipologiaCampionamento varchar(255), tipoAnalisi varchar(255),upload varchar(1))";

private static String sqlCreateDataSetCampionamento="CREATE TABLE tbl_dataset_campionamento (id int(11),id_tipo_matrice int(11) ,nome_campo varchar(100)," +
																						"tipo_campo varchar(100)," +
																						"codice_campo varchar(100),composite varcaher(255))";

private static String sqlCreatePlayLoadCampionamento="CREATE TABLE tbl_playload_campionamento (id Integer primary key autoincrement," +
																							"id_dataset_campionamento int(11),id_punto Integer," +
																							"valore_misurato varchar(50))";

private static String sqlCreatePuntoCampionamento="CREATE TABLE tbl_punto_campionamento (id Integer primary key autoincrement ," +
																	"nome_punto varchar(50)," +
																	"data date, ora varchar(5))";

private static String sqlCreateMasterLAT="CREATE TABLE lat_master (Id Integer primary key autoincrement,"+
																	"sigla varchar(10)," + 
																	"seq int(11)," + 
																	"rif_tipoStrumento varchar(255)," + 
																	"siglaRegistro varchar(20)," + 
																	"id_procedura varchar(50))";

private static String sqlMisuraLAT="CREATE TABLE lat_misura (Id Integer primary key autoincrement," + 
									"id_strumento int(11) ," + 
									"dataMisura date NOT NULL," +
									"id_misura_lat int(11) ," + 
									"incertezzaRif decimal(12,6) ," + 
									"incertezzaRif_sec decimal(12,6) ," +
									"incertezzaEstesa decimal(12,6) ," + 
									"incertezzaEstesa_sec decimal(12,6) ," + 
									"incertezzaMedia decimal(12,6) ," + 
									"campo_misura decimal(12,6) ," + 
									"unita_formato decimal(12,6) ," + 
									"campo_misura_sec decimal(12,6) ," + 
									"sensibilita decimal(12,6) ," + 
									"stato varchar(255) ," + 
									"ammaccature char(1) ," + 
									"bolla_trasversale char(1) ," + 
									"regolazione char(1) ," + 
									"centraggio char(1) ," + 
									"nCertificato varchar(50) ," + 
									"temperatura decimal(60,30) ," + 
									"umidita decimal(60,30) ," + 
									"note varchar(512) ," + 
									"id_rif_campione int(11),"
									+"id_rif_campione_lavoro int(11))";

private static String sqlPuntoLivellaLAT="CREATE TABLE lat_punto_livella (id Integer primary key autoincrement,id_misura int(11)," + 
		"rif_tacca int(2) ," + 
		"semisc char(1) ," + 
		"valore_nominale_tratto decimal(12,6) ," + 
		"valore_nominale_tratto_sec decimal(12,6) ," + 
		"p1_andata decimal(12,6) ," + 
		"p1_ritorno decimal(12,6) ," + 
		"p1_media decimal(12,6) ," + 
		"p1_diff decimal(12,6) ," + 
		"p2_andata decimal(12,6) ," + 
		"p2_ritorno decimal(12,6) ," + 
		"p2_media decimal(12,6) ," + 
		"p2_diff decimal(12,6) ," + 
		"media decimal(12,6) ," + 
		"errore_cum decimal(12,6) ," + 
		"media_corr_sec decimal(12,6) ," + 
		"media_corr_mm decimal(12,6) ," + 
		"div_dex decimal(12,6) ," + 
		"valore_nominale_tacca varchar(255),"
		+ "corr_boll_mm decimal(12,6),"
		+ "corr_boll_sec decimal(12,6))";
		
		
	private static String sqlPuntoLivellaElettronicaLAT="CREATE TABLE lat_punto_livella_elettronica (id Integer primary key autoincrement,id_misura int(11),"+ 
			"punto int(2)," + 
			"tipo_prova varchar(1),"+
			"numero_prova int(2)," + 
			"indicazione_iniziale decimal(12,6)," +
			"indicazione_iniziale_corr decimal(12,6)," +
			"valore_nominale decimal(12,6)," + 
			"valore_andata_taratura decimal(12,6)," + 
			"valore_andata_campione decimal(12,6)," + 
			"valore_ritorno_taratura decimal(12,6)," + 
			"valore_ritorno_campione decimal(12,6)," + 
			"andata_scostamento_campione decimal(12,6) ," + 
			"andata_correzione_campione decimal(12,6) ," + 
			"ritorno_scostamento_campione decimal(12,6) ," +
			"ritorno_correzione_campione decimal(12,6) ," +
			"inclinazione_cmp_campione decimal(12,6) ," +
			"scostamentoA decimal(12,6) ," +
			"scostamentoB decimal(12,6) ," +
			"scostamentoMed decimal(12,6) ," +
			"scostamentoOff decimal(12,6) ," +
			"scarto_tipo decimal(12,6),"+
			"inc_ris decimal(12,6),"+
			"inc_rip decimal(12,6),"+
			"inc_cmp decimal(12,6),"+
			"inc_stab decimal(12,6),"+
			"inc_est decimal(12,6))";
	
	private static String sqlMassaAMB_DATA="CREATE TABLE lat_massa_amb_data (ID Integer primary key autoincrement,ID_MISURA int(11),"+ 
			"TEMPERATURA decimal(19,10) ," + 
			"UMIDITA decimal(19,10) ," + 
			"PRESSIONE decimal(19,10) ," + 
			"INCERTEZZATEMPERATURA decimal(19,10) ," + 
			"INCERTEZZAUMINIDTA decimal(19,10) ," + 
			"INCERTEZZAPRESSIONE decimal(19,10) ," + 
			"MEDIA_TEMPERATURA decimal(19,10) ," + 
			"MEDIA_UMIDITA decimal(19,10) ," + 
			"MEDIA_PRESSIONE decimal(19,10) ," + 
			"MEDIA_TEMPERATURA_MARGINE decimal(19,10) ," + 
			"MEDIA_UMIDITA_MARGINE decimal(19,10) ," + 
			"MEDIA_PRESSIONE_MARGINE decimal(19,10) ," + 
			"DENSITA_ARIA_CIMP decimal(19,10) ," + 
			"DERIVATA_TEMPERATURA_CIMP decimal(19,10) ," + 
			"DERIVATA_PRESSIONE_CIMP decimal(19,10) ," + 
			"DERIVATA_UMIDITA_CIMP decimal(19,10) ," + 
			"INCERTEZZA_DENSITA_ARIA_CIMP decimal(19,10) ," + 
			"INCERTEZZA_FORM_DENSITA_ARIA_CIMP decimal(19,10) ," + 
			"DENSITA_ARIA_P0 decimal(19,10) ," + 
			"DENSITA_ARIA decimal(19,10) ," + 
			"DELTA_TEMPERATURA decimal(19,10) ," + 
			"DELTA_UMIDITA decimal(19,10) ," + 
			"DELTA_PRESSIONE decimal(19,10) ," + 
			"INCERETZZA_SONDA_CAMPIONE decimal(19,10) ," + 
			"INCERTEZZA_SONDA_UMIDITA decimal(19,10) ," + 
			"INCERTEZZA_SONDA_PRESSIONE decimal(19,10))";
	
	private static String sqlMassaAMB="CREATE TABLE lat_massa_amb (ID Integer primary key autoincrement,ID_MISURA int(11),"+  
			"DATA_ORA varchar(255) ," + 
			"CH1_TEMPERATURA decimal(19,10) ," + 
			"CH2_TEMPERATURA decimal(19,10) ," + 
			"CH3_TEMPERATURA decimal(19,10) ," + 
			"CH1_TEMPERATURA_CORR decimal(19,10) ," + 
			"CH2_TEMPERATURA_CORR decimal(19,10) ," + 
			"CH3_TEMPERATURA_CORR decimal(19,10) ," + 
			"UMIDITA decimal(19,10) ," + 
			"UMIDITA_CORR decimal(19,10) ," + 
			"PRESSIONE decimal(19,10) ," + 
			"PRESSIONE_CORRETTA decimal(19,10))";
	
	private static String sqlMassaData="CREATE TABLE lat_massa_data (" + 
			"  id Integer primary key autoincrement," + 
			"  id_misura int(11) NOT NULL ," + 
			"  ripetizione int(11) NOT NULL ," + 
			"  comparatore varchar(50) NOT NULL," + 
			"  campione varchar(50) NOT NULL," + 
			"  parametro varchar(50) NOT NULL," + 
			"  campioneL1 decimal(14,7) NOT NULL ," + 
			"  misurandoL1 decimal(14,7) NOT NULL ," + 
			"  misurandoL2 decimal(14,7) NOT NULL ," + 
			"  campioneL2 decimal(14,7) NOT NULL ," + 
			"  i_esima_diff decimal(14,7) NOT NULL ," + 
			"  i_esima_diff_media decimal(14,7) NOT NULL ," + 
			"  sc1 decimal(14,7) NOT NULL ," + 
			"  vc1 int(11) NOT NULL ," + 
			"  sc2 decimal(14,7) NOT NULL ," + 
			"  sd decimal(14,7) NOT NULL ," + 
			"  esito_conferma varchar(10) NOT NULL," + 
			"  ud decimal(14,7) NOT NULL ," + 
			"  uuf decimal(14,7) NOT NULL ," + 
			"  correzione_eff_mag decimal(14,7)," +
			"  u_correzione_eff_mag decimal(14,7) ,"+
			"  caso int(1) NOT NULL ," + 
			"  mX decimal(14,7) NOT NULL ," + 
			"  uMx decimal(14,7) NOT NULL)";
	
	private static String sqlMassaAMB_SONDE="CREATE TABLE lat_massa_amb_sonde (ID_TIPO int(11),"
											+ "NUMERO int(11) ,"+
											  "INDICAZIONE decimal(19,10) ,"+
											  "ERRORE decimal(19,10) ,"+
											  "REG_LIN_M decimal(19,10) ,"+
											  "REG_LIN_Q decimal(19,10))";
	
	private static String sqlMassa_CLASSE="CREATE TABLE lat_massa_classe (ID Integer primary key, "+
											 "val_nominale varchar(50), "+
											 "mg decimal(10,6), "+
											 "dens_min decimal(10,6), "+
											 "dens_max decimal(10,2))";
	
	
	private static String sqlMassa_SCARTI_TIPO="CREATE TABLE lat_massa_scarti_tipo(ID Integer primary key, "+
												 "id_comparatore int(11), "+
												 "descrizione varchar(50), "+
												 "scarto decimal(12,10), "+
												 "gradi_lib int(3),"+
												 "uf decimal(12,10))";
	
	private static final String sqlMassa_EFF_MAG = "CREATE TABLE lat_massa_eff_mag (" + 
			"  id Integer primary key autoincrement," + 
			"  id_misura int(11) ," + 
			"  comparatore varchar(50) ," + 
			"  campione varchar(50) ," + 
			"  valore_nominale_campione varchar(50) ," +
			"  classe_OIML varchar(10) ," + 
			"  segno_distintivo varchar(1) ," + 
			"  eff_mag_L1 decimal(19,10) ," + 
			"  eff_mag_L2 decimal(19,10) ," + 
			"  eff_mag_esito varchar(50) ," +
			"  mc decimal(19,10) ," + 
			"  uMc decimal(19,10) ," + 
			"  classe_campione varchar(50) ," + 
			"  classe_campione_u decimal(19,10) ," + 
			"  classe_campione_min decimal(10,2) ," + 
			"  classe_campione_pc decimal(10,2) ," + 
			"  classe_campione_max decimal(10,2) ," + 
			"  classe_taratura varchar(50) ," + 
			"  classe_taratura_u decimal(19,10) ," + 
			"  classe_taratura_min decimal(10,2) ," + 
			"  classe_taratura_pc decimal(10,2) ," + 
			"  classe_taratura_max decimal(10,2))";
	
	
	private static String sqlCreateSicurezzaElettrica="CREATE TABLE tblMisuraSicurezzaElettrica(id Integer primary key, "+ 
													 "  id_strumento int(11),"+
													 "  stato int(1) default 0, "+
													 "  ID_PROVA varchar(255) ," + 
													 "  DATA varchar(255) ," + 
													 "  ORA varchar(255) ," + 
													 "  SK varchar(255) ," + 
													 "  R_SL varchar(255) ," + 
													 "  R_SL_GW varchar(255) ," + 
													 "  R_ISO varchar(255) ," + 
													 "  R_ISO_GW varchar(255) ," + 
													 "  U_ISO varchar(255) ," + 
													 "  U_ISO_GW varchar(255) ," + 
													 "  I_DIFF varchar(255) ," + 
													 "  I_DIFF_GW varchar(255) ," + 
													 "  I_EGA varchar(255) ," + 
													 "  I_EGA_GW varchar(255) ," + 
													 "  I_EPA varchar(255) ," + 
													 "  I_EPA_GW varchar(255) ," + 
													 "  I_GA varchar(255) ," + 
													 "  I_GA_GW varchar(255) ," + 
													 "  I_GA_SFC varchar(255) ," + 
													 "  I_GA_SFC_GW varchar(255) ," + 
													 "  I_PA_AC varchar(255) ," + 
													 "  I_PA_AC_GW varchar(255) ," + 
													 "  I_PA_DC varchar(255) ," + 
													 "  I_PA_DC_GW varchar(255) ," + 
													 "  PSPG varchar(255) ," + 
													 "  UBEZ_GW varchar(255),"
													 + "COND_PROT varchar(2),"
													 + "INVOLUCRO varchar(2),"
													 + "FUSIBILI varchar(2),"
													 + "CONNETTORI varchar(2),"
													 + "MARCHIATURE varchar(2),"
													 + "ALTRO varchar(2),"
													 + "PARTI_APPLICATE varchar(255))";

	
	private static String sqlCreateMisuraVER="CREATE TABLE ver_misura (id Integer primary key autoincrement," + 
												"  id_ver_strumento int(11) NOT NULL default '0'," + 
												"  data_verificazione varchar(50) NOT NULL," + 
												"  data_scadenza varchar(50) default NULL," + 
												"  numero_rapporto varchar(50) default NULL," + 
												"  numero_attestato varchar(50) default NULL," + 
												"  tipo_verifica int(1) default NULL," + 
												"  motivo_verifica int(1) default NULL," +
												"  isDifetti varchar(1) default NULL," +
												"  nome_riparatore varchar(100) default NULL," + 
												"  data_riparazione varchar(50) default NULL," + 
												"  tipo_risposta int(1) default NULL," + 
												"  seq_risposte varchar(255) default NULL," + 
												"  id_non_conforme int(1) default NULL,"+
												"  campioni_lavoro varchar(512) default NULL,"+
												" stato int(1),"+
												" file_inizio_prova blob,"+
												" nomefile_inizio_prova varchar(255),"+
												" file_fine_prova blob,"+
												" nomefile_fine_prova varchar(255),"+
												" tInizio decimal(10,2),"+
												" tFine decimal(10,2),"+
												" altezza_org decimal(10,2),"+
												" altezza_util decimal(10,2),"+
												" latitudine_org decimal(10,2),"+
												" latitudine_util decimal(10,2),"+
												" gOrg decimal(10,2),"+
												" gUtil decimal(10,2),"+
												" gFactor decimal(10,2),"+
												" numeroSigilli int(1));";
									
			
	private static String sqlCreateAccuratezzaVER="CREATE TABLE ver_accuratezza (id Integer primary key autoincrement," + 
													"  id_misura int(11) ," + 
													"  tipo_tara int(1)  ," + 
													"  campo int(11)  ," + 
													"  posizione int(1)  ," + 
													"  massa decimal(10,5)  ," + 
													"  indicazione decimal(10,5)," + 
													"  carico_agg decimal(10,5)," + 
													"  errore decimal(10,5)," + 
													"  errore_cor decimal(10,5)," + 
													"  mpe decimal(10,5)," + 
													"  esito varchar(10));";
	
	private static String sqlCreateClassiVER="CREATE TABLE ver_classi (classe int(1)  ," + 
												"  limite_inferiore int(6) ," + 
												"  limite_superiore int(6) ," + 
												"  errore decimal(10,6));";
	
	private static String sqlCreateDecentramentoVER="CREATE TABLE ver_decentramento ( id Integer primary key autoincrement," + 
														"  id_misura int(11)  ," + 
														"  tipo_ricettore int(1) ," + 
														"  punti_appoggio int(11)," + 
														"  campo int(11),"+
														"  carico decimal(10,5)," +
														"  speciale varchar(1)," +
														"  posizione int(2)," + 
														"  massa decimal(10,5)," + 
														"  indicazione decimal(10,5)," + 
														"  carico_agg decimal(10,5)," + 
														"  errore decimal(10,5)," + 
														"  errore_cor decimal(10,5)," + 
														"  mpe decimal(10,5)," + 
														"  esito varchar(10));";
	
	private static String sqlCreateLinearitaVER="CREATE TABLE ver_linearita (id Integer primary key autoincrement," + 
													"  id_misura int(11)," + 
													"  tipo_azzeramento int(1)," + 
													"  campo int(11)," + 
													"  riferimento int(1)," + 
													"  massa decimal(10,5)," + 
													"  indicazione_salita decimal(10,5)," + 
													"  indicazione_discesa decimal(10,5)," + 
													"  carico_agg_salita decimal(10,5)," + 
													"  carico_agg_discesa decimal(10,5)," + 
													"  errore_salita decimal(10,5)," +
													"  errore_discesa decimal(10,5)," + 
													"  errore_cor_salita decimal(10,5)," + 
													"  errore_cor_discesa decimal(10,5)," + 
													"  mpe decimal(10,5)," + 
													"  divisione decimal(10,5)," + 
													"  esito varchar(10));" ;
	
	private static String sqlCreateRipetibilitaVER="CREATE TABLE ver_ripetibilita (id Integer primary key autoincrement," + 
													"  id_misura int(11)," + 
													"  campo int(1)," + 
													"  numero_ripetizione int(1)," + 
													"  massa decimal(10,5)," + 
													"  indicazione decimal(10,5)," + 
													"  carico_agg decimal(10,5)," + 
													"  portata decimal(10,5)," + 
													"  delta_portata decimal(10,5)," + 
													"  mpe decimal(10,5)," + 
													"  esito varchar(10));" ;
	
	private static String sqlCreateMobilitaVER="CREATE TABLE ver_mobilita (id Integer primary key autoincrement," + 
																		"  id_misura int(11)," + 
																		"  campo int(11)," + 
																		"  caso int(1)," + 
																		"  carico int(1)," + 
																		"  massa decimal(10,5)," + 
																		"  indicazione decimal(10,5)," + 
																		"  carico_agg decimal(10,5)," + 
																		"  post_indicazione decimal(10,5)," + 
																		"  differenziale decimal(10,5)," + 
																		"  divisione decimal(10,5)," + 
																		"  check_stato varchar(255) , " + 
																		"  esito varchar(10));";
	
	private static  String sqlCreatStrListVER = "CREATE TABLE ver_lista_matricole(matricola varchar(255))";
	
	private static String sqlMassa_tabAttivita="CREATE TABLE tbAttivita(ID Integer primary key, "+
			 "descrizione varchar(2048), "+
			 "note varchar(2048), "+
			 "um varchar(48), "+
			 "quantita int(8))";
	
	
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
	
	PreparedStatement pstgeneral=con.prepareStatement(sqlCreateGeneral);
	pstgeneral.execute();
	
	PreparedStatement pstLuogoVerifica=con.prepareStatement(sqlCreateLuogoVerifica);
	pstLuogoVerifica.execute();
	
	PreparedStatement pstSicurezzaElettrica=con.prepareStatement(sqlCreateSicurezzaElettrica);
	pstSicurezzaElettrica.execute();
	
	PreparedStatement pstAttivita=con.prepareStatement(sqlMassa_tabAttivita);
	pstAttivita.execute();
	
	}
	
	catch 
	(Exception e) 
	{
		throw e;
	}
}

public static void createDBLAT(Connection con) throws SQLException {
	
	try
	{
	PreparedStatement pst =con.prepareStatement(sqlCreateStrumentTable);
	pst.execute();
	
	PreparedStatement pstCM =con.prepareStatement(sqlCreateCMPTableLAT);
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
	
	PreparedStatement pstgeneral=con.prepareStatement(sqlCreateGeneral);
	pstgeneral.execute();
	
	PreparedStatement pstLuogoVerifica=con.prepareStatement(sqlCreateLuogoVerifica);
	pstLuogoVerifica.execute();
	
	PreparedStatement pstMasterLAT=con.prepareStatement(sqlCreateMasterLAT);
	pstMasterLAT.execute();
	
	PreparedStatement pstMisuraLAT=con.prepareStatement(sqlMisuraLAT);
	pstMisuraLAT.execute();
	
	PreparedStatement pstPuntoLivellaLAT=con.prepareStatement(sqlPuntoLivellaLAT);
	pstPuntoLivellaLAT.execute();
	
	PreparedStatement pstPuntoLivellaElettronicaLAT=con.prepareStatement(sqlPuntoLivellaElettronicaLAT);
	pstPuntoLivellaElettronicaLAT.execute();
	
	PreparedStatement pstMassaAMB=con.prepareStatement(sqlMassaAMB);
	pstMassaAMB.execute();
	
	PreparedStatement pstMassaData=con.prepareStatement(sqlMassaData);
	pstMassaData.execute();
	
	PreparedStatement pstMassaAMB_DATA=con.prepareStatement(sqlMassaAMB_DATA);
	pstMassaAMB_DATA.execute();

	PreparedStatement pstMassaAMB_SONDE=con.prepareStatement(sqlMassaAMB_SONDE);
	pstMassaAMB_SONDE.execute();
	
	PreparedStatement pstMassa_CLASSE=con.prepareStatement(sqlMassa_CLASSE);
	pstMassa_CLASSE.execute();
	
	PreparedStatement pstMassa_SCARTI_TIPO=con.prepareStatement(sqlMassa_SCARTI_TIPO);
	pstMassa_SCARTI_TIPO.execute();
	
	PreparedStatement pstMassa_EFF_MAG=con.prepareStatement(sqlMassa_EFF_MAG);
	pstMassa_EFF_MAG.execute();
	
	}
	
	catch(Exception e) 
	{
		throw e;
	}
}

public static void cerateDBCampionamento(Connection con) throws Exception {
	
	try
	{
	
		PreparedStatement pstGen =con.prepareStatement(sqlCreateGeneralCampionamento);
		pstGen.execute();
		
		PreparedStatement pstDataSet =con.prepareStatement(sqlCreateDataSetCampionamento);
		pstDataSet.execute();
		
		PreparedStatement pstPlayLoad =con.prepareStatement(sqlCreatePlayLoadCampionamento);
		pstPlayLoad.execute();
		
		PreparedStatement punto =con.prepareStatement(sqlCreatePuntoCampionamento);
		punto.execute();
	
	}
	
	catch (Exception e) 
	
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
	
	try
	{
	
	pst=con.prepareStatement("SELECT a.id as idMisura, a.id_Str as idStr,dataMisura,temperatura,umidita,tipoFirma,statoRicezione, b.* FROM tblMisure a " +
							 "join tblStrumenti b on a.id_str=b.id " +
							 "WHERE a.statoMisura=1");
	
	rs=pst.executeQuery();
	
	while(rs.next())
	{
		misura= new MisuraDTO();
		misura.setId(rs.getInt("idMisura"));
		misura.setIntervento(intervento);
		StrumentoDTO strumento = new StrumentoDTO();
		strumento.set__id(rs.getInt("idStr"));
		strumento.setDenominazione(rs.getString("denominazione"));
		strumento.setCodice_interno(rs.getString("codice_interno"));
		strumento.setCostruttore(rs.getString("costruttore"));
		strumento.setModello(rs.getString("modello"));
		strumento.setClassificazione(new ClassificazioneDTO(rs.getInt("classificazione"),""));
		strumento.setMatricola(rs.getString("matricola"));
		strumento.setRisoluzione(rs.getString("risoluzione"));
		strumento.setCampo_misura(rs.getString("campo_misura"));
		strumento.setLuogo(new LuogoVerificaDTO(rs.getInt("luogo_verifica"),""));
		
		
		strumento.setFrequenza(rs.getInt("freq_verifica_mesi"));
		strumento.setTipoRapporto(new TipoRapportoDTO(rs.getInt("tipoRapporto"), ""));
		
		if(strumento.getTipoRapporto().getId()==Costanti.ID_TIPO_RAPPORTO_SVT)
		{
			Date date = new Date();
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			
			strumento.setDataUltimaVerifica(sqlDate);
			
			Calendar data = Calendar.getInstance();
			
			data.setTime(date);
			data.add(Calendar.MONTH,strumento.getFrequenza());
			
			java.sql.Date sqlDateProssimaVerifica = new java.sql.Date(data.getTime().getTime());
				
			strumento.setDataProssimaVerifica(sqlDateProssimaVerifica);
			
		}
		
	
		strumento.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		strumento.setReparto(rs.getString("reparto"));
		strumento.setUtilizzatore(rs.getString("utilizzatore"));
		strumento.setTipo_strumento(new TipoStrumentoDTO(rs.getInt("id_tipo_strumento"),""));
		strumento.setNote(rs.getString("note"));
		strumento.setCreato(rs.getString("creato"));
		strumento.setImportato(rs.getString("importato"));
		strumento.setStrumentoModificato(rs.getString("strumentoModificato"));
		strumento.setIdTipoRapporto(rs.getInt("tipoRapporto"));
		strumento.setIdClassificazione(rs.getInt("classificazione"));
		strumento.setFrequenza(rs.getInt("freq_verifica_mesi"));
		strumento.setProcedura(rs.getString("procedura"));
		
		misura.setStrumento(strumento);
		misura.setDataMisura(sdf.parse(rs.getString("dataMisura")));
		misura.setTemperatura(rs.getBigDecimal("temperatura"));
		misura.setUmidita(rs.getBigDecimal("umidita"));
		misura.setTipoFirma(rs.getInt("tipoFirma"));
		
		
		misura.setStatoRicezione(new StatoRicezioneStrumentoDTO(rs.getInt("statoRicezione")));
		misura.setObsoleto("N");
		misura.setnCertificato(rs.getString("nCertificato"));
	
		listaMisure.add(misura);
	}
	 
	
	return listaMisure;
	
	}catch (Exception e) {
		throw e;
	}
}

public static ArrayList<SicurezzaElettricaDTO> getListaMisureElettriche(Connection con, InterventoDTO intervento) throws Exception {
	ArrayList<SicurezzaElettricaDTO> listaMisure = new ArrayList<SicurezzaElettricaDTO>();
	PreparedStatement pst=null;
	ResultSet rs= null;
	SicurezzaElettricaDTO sicurezza = new SicurezzaElettricaDTO(); 
	try
	{
	
	pst=con.prepareStatement("SELECT a.*, b.* FROM tblMisuraSicurezzaElettrica a " +
							 "join tblStrumenti b on a.id_strumento=b.id " +
							 "WHERE a.stato=1");
	
	rs=pst.executeQuery();
	
	while(rs.next())
	{
		sicurezza= new SicurezzaElettricaDTO();
		
		StrumentoDTO strumento = new StrumentoDTO();
		strumento.set__id(rs.getInt("id_strumento"));
		strumento.setDenominazione(rs.getString("denominazione"));
		strumento.setCodice_interno(rs.getString("codice_interno"));
		strumento.setCostruttore(rs.getString("costruttore"));
		strumento.setModello(rs.getString("modello"));
		strumento.setClassificazione(new ClassificazioneDTO(rs.getInt("classificazione"),""));
		strumento.setMatricola(rs.getString("matricola"));
		strumento.setRisoluzione(rs.getString("risoluzione"));
		strumento.setCampo_misura(rs.getString("campo_misura"));
		strumento.setLuogo(new LuogoVerificaDTO(rs.getInt("luogo_verifica"),""));
				
		strumento.setFrequenza(rs.getInt("freq_verifica_mesi"));
		strumento.setTipoRapporto(new TipoRapportoDTO(rs.getInt("tipoRapporto"), ""));
		
	
//			Date date = new Date();
//			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
//			
//			strumento.setDataUltimaVerifica(sqlDate);
//			
//			Calendar data = Calendar.getInstance();
//			
//			data.setTime(date);
//			data.add(Calendar.MONTH,strumento.getFrequenza());
//			
//			java.sql.Date sqlDateProssimaVerifica = new java.sql.Date(data.getTime().getTime());
//				
//			strumento.setDataProssimaVerifica(sqlDateProssimaVerifica);
//			
		
		
		
		strumento.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		strumento.setReparto(rs.getString("reparto"));
		strumento.setUtilizzatore(rs.getString("utilizzatore"));
		strumento.setTipo_strumento(new TipoStrumentoDTO(rs.getInt("id_tipo_strumento"),""));
		strumento.setNote(rs.getString("note"));
		strumento.setCreato(rs.getString("creato"));
		strumento.setImportato(rs.getString("importato"));
		strumento.setStrumentoModificato(rs.getString("strumentoModificato"));
		strumento.setIdTipoRapporto(rs.getInt("tipoRapporto"));
		strumento.setIdClassificazione(rs.getInt("classificazione"));
		strumento.setFrequenza(rs.getInt("freq_verifica_mesi"));
		strumento.setProcedura(rs.getString("procedura"));
		
		sicurezza.setStrumento(strumento);
		
		
		sicurezza.setID_PROVA(rs.getString("ID_PROVA"));
		sicurezza.setSK(rs.getString("SK"));
		sicurezza.setDATA(rs.getString("DATA"));
		sicurezza.setORA(rs.getString("ORA"));
		sicurezza.setR_SL(rs.getString("R_SL"));
		sicurezza.setR_SL_GW(rs.getString("R_SL_GW"));
		sicurezza.setR_ISO(rs.getString("R_ISO"));
		sicurezza.setR_ISO_GW(rs.getString("R_ISO_GW"));
		sicurezza.setU_ISO(rs.getString("U_ISO"));
		sicurezza.setU_ISO_GW(rs.getString("U_ISO_GW"));
		sicurezza.setI_DIFF(rs.getString("I_DIFF"));
		sicurezza.setI_DIFF_GW(rs.getString("I_DIFF_GW"));
		sicurezza.setI_EGA(rs.getString("I_EGA"));
		sicurezza.setI_EGA_GW(rs.getString("I_EGA_GW"));
		sicurezza.setI_EPA(rs.getString("I_EPA"));
		sicurezza.setI_EPA_GW(rs.getString("I_EPA_GW"));
		sicurezza.setI_GA(rs.getString("I_GA"));
		sicurezza.setI_GA_GW(rs.getString("I_GA_GW"));
		sicurezza.setI_GA_SFC(rs.getString("I_GA_SFC"));
		sicurezza.setI_GA_SFC_GW(rs.getString("I_GA_SFC_GW"));
		sicurezza.setI_PA_AC(rs.getString("I_PA_AC"));
		sicurezza.setI_PA_AC_GW(rs.getString("i_PA_AC_GW"));
		sicurezza.setI_PA_DC(rs.getString("I_PA_DC"));
		sicurezza.setI_PA_DC_GW(rs.getString("I_PA_DC_GW"));
		sicurezza.setPSPG(rs.getString("PSPG"));
		sicurezza.setUBEZ_GW(rs.getString("UBEZ_GW"));
		sicurezza.setCOND_PROT(rs.getString("COND_PROT"));
		sicurezza.setINVOLUCRO(rs.getString("INVOLUCRO"));
		sicurezza.setFUSIBILI(rs.getString("FUSIBILI"));
		sicurezza.setCONNETTORI(rs.getString("CONNETTORI"));
		sicurezza.setMARCHIATURE(rs.getString("MARCHIATURE"));
		sicurezza.setALTRO(rs.getString("ALTRO"));
		sicurezza.setPARTI_APPLICATE(rs.getString("PARTI_APPLICATE"));
	
		listaMisure.add(sicurezza);
	}
	 
	
	return listaMisure;
	
	}catch (Exception e) {
		throw e;
	}
}



public static ArrayList<PuntoMisuraDTO> getListaPunti(Connection con, int idTemp, int idMisura) throws SQLException {
	
	ArrayList<PuntoMisuraDTO> listaPuntoMisura = new ArrayList<PuntoMisuraDTO>();
	
	PreparedStatement pst=null;
	ResultSet rs= null;
	PuntoMisuraDTO punto ; 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	
	
//	pst=con.prepareStatement("SELECT * FROM tblTabelleMisura WHERE id_misura=?");
	pst=con.prepareStatement("SELECT a.* ,(SELECT num_certificato from tblCampioni where codice=a.desc_campione) numero_certificato  FROM tblTabelleMisura a WHERE id_misura=?");
	pst.setInt(1, idTemp);
	
	rs=pst.executeQuery();
	
	while(rs.next())
	{
		punto= new PuntoMisuraDTO();
		
		punto.setId_misura(idMisura);
		punto.setId_tabella(rs.getInt("id_tabella"));
		punto.setId_ripetizione(rs.getInt("id_ripetizione"));
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
		punto.setMisura(rs.getBigDecimal("misura"));
		punto.setUm_calc(rs.getString("um_calc"));
		punto.setRisoluzione_misura(rs.getBigDecimal("risoluzione_misura"));
		punto.setDgt(rs.getBigDecimal("dgt"));
		punto.setCalibrazione(rs.getString("calibrazione"));
		punto.setNumeroCertificatoCampione(rs.getString("numero_certificato"));
		
		
		byte[] byteArr = rs.getBytes("file_att");
		//Blob blob = new javax.sql.rowset.serial.SerialBlob(byteArr);
		punto.setFile_att(byteArr);
		

		String fs=rs.getString("fondo_scala");
		
		if(fs!=null && fs.length()>0)
		{
			punto.setFondoScala(new BigDecimal(fs));
		}else
		{
			punto.setFondoScala(null);
		}
		
		String perc=rs.getString("perc_util");
		
		if(perc!=null && perc.length()>0)
		{
			punto.setPer_util(new BigDecimal(perc).doubleValue());
		}else
		{
			punto.setPer_util(0);
		}
		
		punto.setRisoluzione_campione(rs.getBigDecimal("risoluzione_campione"));
		
		punto.setInterpolazione(rs.getInt("interpolazione"));
		punto.setFm(rs.getString("fm"));
		punto.setSelConversione(rs.getInt("selConversione"));
		punto.setSelTolleranza(rs.getInt("selTolleranza"));
		punto.setLetturaCampione(rs.getBigDecimal("letturaCampione"));
		punto.setObsoleto("N");
		punto.setApplicabile(rs.getString("applicabile"));
		listaPuntoMisura.add(punto);
		
	}
	 
	
	return listaPuntoMisura;
}

public static void updateNuovoStrumento(Connection con,StrumentoDTO nuovoStrumento, int idMisura, int vecchioId) throws Exception {
	
	PreparedStatement pstUpdateStrumento=null;
	PreparedStatement pstUpdateMisura=null;
	
	try 
	{
		pstUpdateStrumento=con.prepareStatement("UPDATE tblStrumenti SET id=?,creato=?,importato=? WHERE id=?");
		pstUpdateStrumento.setInt(1,nuovoStrumento.get__id());
		pstUpdateStrumento.setString(2, "N");
		pstUpdateStrumento.setString(3,"S");
		pstUpdateStrumento.setInt(4, vecchioId);
		
		pstUpdateStrumento.execute();
		
		pstUpdateMisura=con.prepareStatement("UPDATE tblMisure SET id_Str=? WHERE id=?");
		pstUpdateMisura.setInt(1, nuovoStrumento.get__id());
		pstUpdateMisura.setInt(2, idMisura);
		
		pstUpdateMisura.execute();
		
	} catch (Exception e) {
		e.printStackTrace();
		throw e;
	}
}

public static boolean checkFile(String path) throws Exception {
	
	boolean toReturn =true;
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs = null;
	
	try
	{
		con=getConnection(path);
		pst=con.prepareStatement("select * FROM tbl_general WHERE upload='N'");
		
		rs=pst.executeQuery();
		while(rs.next())
		{
			toReturn=false;
		}
		
	} catch 
	(Exception e) 
	{
		e.printStackTrace();
		throw e;
	}
	
	
	return toReturn;
}

public static ArrayList<PlayloadCampionamentoDTO> getListaPlayLoad(Connection con, InterventoCampionamentoDTO intervento) throws Exception {
	
	PreparedStatement pst=null;
	ResultSet rs=null;
	ArrayList<PlayloadCampionamentoDTO> listaPlay= new ArrayList<>();
	try 
	{
		pst=con.prepareStatement("SELECT * FROM tbl_playload_campionamento");
		rs=pst.executeQuery();
		PlayloadCampionamentoDTO play = null;
		while (rs.next()) {
			play=new PlayloadCampionamentoDTO();
			play.setIntervento(intervento);
			play.setIdInterventoCampionamento(intervento.getId());
			play.setDataset(new DatasetCampionamentoDTO(rs.getInt("id_dataset_campionamento")));
			play.setId_punto(rs.getInt("id_punto"));
			play.setValore_misurato(rs.getString("valore_misurato"));
			
			listaPlay.add(play);
			
		}
	} 
	
	catch (Exception e) 
	{
		e.printStackTrace();
		throw e;
	}
	return listaPlay;
}

public static Date getDataChiusura(Connection con) throws Exception {
	
	
	PreparedStatement pst=null;
	ResultSet rs=null;
	Date dateReturn=null;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	try 
	{
		pst=con.prepareStatement("SELECT data_prelievo FROM tbl_general");
		rs=pst.executeQuery();
		while (rs.next()) {
			
			dateReturn=sdf.parse(rs.getString(1));
			
		}
	} 
	
	catch (Exception e) 
	{
		e.printStackTrace();
		throw e;
	}
	return dateReturn;
	
}

public static LatMisuraDTO getMisuraLAT(Connection con, StrumentoDTO str,int id_str) throws Exception {
	
	LatMisuraDTO misuraLAT=null;
	PreparedStatement pst= null;
	ResultSet rs=null;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	try {
		
		pst=con.prepareStatement("SELECT * from lat_misura WHERE id_strumento=?");
		pst.setInt(1, id_str);
		
		rs=pst.executeQuery();
		
		while(rs.next()) 
		{
			misuraLAT=new LatMisuraDTO();
			misuraLAT.setId(rs.getInt("id"));
			misuraLAT.setStrumento(str);
			misuraLAT.setData_misura(sdf.parse(rs.getString("dataMisura")));
			LatMasterDTO master = new LatMasterDTO();
			master.setId(rs.getInt("id_misura_lat"));
			misuraLAT.setMisura_lat(master);
			misuraLAT.setIncertezza_rif(rs.getBigDecimal("incertezzaRif"));
			misuraLAT.setIncertezza_rif_sec(rs.getBigDecimal("incertezzaRif_sec"));
			misuraLAT.setIncertezza_estesa(rs.getBigDecimal("incertezzaEstesa"));
			misuraLAT.setIncertezza_estesa_sec(rs.getBigDecimal("incertezzaEstesa_sec"));
			misuraLAT.setIncertezza_media(rs.getBigDecimal("incertezzaMedia"));
			misuraLAT.setCampo_misura(rs.getBigDecimal("campo_misura"));
			misuraLAT.setUnita_formato(rs.getBigDecimal("unita_formato"));
			misuraLAT.setCampo_misura_sec(rs.getBigDecimal("campo_misura_sec"));
			misuraLAT.setSensibilita(rs.getBigDecimal("sensibilita"));
			misuraLAT.setStato(rs.getString("stato"));
			misuraLAT.setAmmaccature(rs.getString("ammaccature"));
			misuraLAT.setBolla_trasversale(rs.getString("bolla_trasversale"));
			misuraLAT.setRegolazione(rs.getString("regolazione"));
			misuraLAT.setCentraggio(rs.getString("centraggio"));
			misuraLAT.setNote(rs.getString("note"));
			misuraLAT.setRif_campione(GestioneCampioneDAO.getCampioneFromCodice(rs.getString("id_rif_campione")));
			misuraLAT.setRif_campione_lavoro(GestioneCampioneDAO.getCampioneFromCodice(rs.getString("id_rif_campione_lavoro")));
			misuraLAT.setTemperatura(rs.getBigDecimal("temperatura"));
			misuraLAT.setUmidita(rs.getBigDecimal("umidita"));
		
		}
		
	}catch (Exception e) 
	{
		e.printStackTrace();
		throw e;
	}
	return misuraLAT;
}

public static ArrayList<LatPuntoLivellaDTO> getListaPuntiLivella(Connection con, int idMisuraLAT, int idTemp) throws Exception {
	
	
	PreparedStatement pst=null;
	ResultSet rs=null;
	ArrayList<LatPuntoLivellaDTO> listaPunti= new ArrayList<LatPuntoLivellaDTO>();
	
	try 
	{		
		pst=con.prepareStatement("SELECT * FROM lat_punto_livella where id_misura=? order by rif_tacca ASC");
		
		pst.setInt(1,idTemp);
		rs=pst.executeQuery();
		
		LatPuntoLivellaDTO punto= null;
		while(rs.next())
		{
			punto= new LatPuntoLivellaDTO();
			punto.setId(rs.getInt("id"));
			punto.setId_misura(idMisuraLAT);
			punto.setRif_tacca(rs.getInt("rif_tacca"));
			punto.setValore_nominale_tratto(rs.getBigDecimal("valore_nominale_tratto"));
			punto.setValore_nominale_tratto_sec(rs.getBigDecimal("valore_nominale_tratto_sec"));
			punto.setSemisc(rs.getString("semisc"));
			punto.setP1_andata(rs.getBigDecimal("p1_andata"));
			punto.setP1_ritorno(rs.getBigDecimal("p1_ritorno"));
			punto.setP1_media(rs.getBigDecimal("p1_media"));
			punto.setP1_diff(rs.getBigDecimal("p1_diff"));
			punto.setP2_andata(rs.getBigDecimal("p2_andata"));
			punto.setP2_ritorno(rs.getBigDecimal("p2_ritorno"));
			punto.setP2_media(rs.getBigDecimal("p2_media"));
			punto.setP2_diff(rs.getBigDecimal("p2_diff"));
			punto.setMedia(rs.getBigDecimal("media"));
			punto.setErrore_cum(rs.getBigDecimal("errore_cum"));
			punto.setMedia_corr_sec(rs.getBigDecimal("media_corr_sec"));
			punto.setMedia_corr_mm(rs.getBigDecimal("media_corr_mm"));
			punto.setDiv_dex(rs.getBigDecimal("div_dex"));
		//	punto.setValore_nominale_tacca(rs.getString("valore_nominale_tacca"));
			punto.setCorr_boll_mm(rs.getBigDecimal("corr_boll_mm"));
			punto.setCorr_boll_sec(rs.getBigDecimal("corr_boll_sec"));
			
			listaPunti.add(punto);
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
		//con.close();
	}

	return listaPunti;
}

public static ArrayList<LatPuntoLivellaElettronicaDTO> getListaPuntiLivellaElettronica(Connection con, int idMisuraLAT,int idTemp) throws Exception {
	PreparedStatement pst=null;
	ResultSet rs=null;
	ArrayList<LatPuntoLivellaElettronicaDTO> listaPunti= new ArrayList<LatPuntoLivellaElettronicaDTO>();
	
	try 
	{		
		pst=con.prepareStatement("SELECT * FROM lat_punto_livella_elettronica where id_misura=? order by id ASC");
		
		pst.setInt(1,idTemp);
		rs=pst.executeQuery();
		
		LatPuntoLivellaElettronicaDTO punto= null;
		while(rs.next())
		{
			punto= new LatPuntoLivellaElettronicaDTO();
			punto.setId(rs.getInt("id"));
			punto.setId_misura(idMisuraLAT);
			punto.setPunto(rs.getInt("punto"));
			punto.setTipo_prova(rs.getString("tipo_prova"));
			punto.setNumero_prova(rs.getInt("numero_prova"));
			punto.setIndicazione_iniziale(rs.getBigDecimal("indicazione_iniziale"));
			punto.setIndicazione_iniziale_corr(rs.getBigDecimal("indicazione_iniziale_corr"));
			punto.setValore_nominale(rs.getBigDecimal("valore_nominale"));
			punto.setValore_andata_taratura(rs.getBigDecimal("valore_andata_taratura"));
			punto.setValore_andata_campione(rs.getBigDecimal("valore_andata_campione"));
			punto.setValore_ritorno_taratura(rs.getBigDecimal("valore_ritorno_taratura"));
			punto.setValore_ritorno_campione(rs.getBigDecimal("valore_ritorno_campione"));
			punto.setAndata_scostamento_campione(rs.getBigDecimal("andata_scostamento_campione"));
			punto.setAndata_correzione_campione(rs.getBigDecimal("andata_correzione_campione"));
			punto.setRitorno_scostamento_campione(rs.getBigDecimal("ritorno_scostamento_campione"));
			punto.setRitorno_correzione_campione(rs.getBigDecimal("ritorno_correzione_campione"));
			punto.setInclinazione_cmp_campione(rs.getBigDecimal("inclinazione_cmp_campione"));
			punto.setScostamentoA(rs.getBigDecimal("scostamentoA"));
			punto.setScostamentoB(rs.getBigDecimal("scostamentoB"));
			punto.setScostamentoMed(rs.getBigDecimal("scostamentoMed"));
			punto.setScostamentoOff(rs.getBigDecimal("scostamentoOff"));
			punto.setScarto_tipo(rs.getBigDecimal("scarto_tipo"));
			punto.setInc_ris(rs.getBigDecimal("inc_ris"));
			punto.setInc_rip(rs.getBigDecimal("inc_rip"));
			punto.setInc_cmp(rs.getBigDecimal("inc_cmp"));
			punto.setInc_stab(rs.getBigDecimal("inc_stab"));
			punto.setInc_est(rs.getBigDecimal("inc_est"));
			
			listaPunti.add(punto);
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
	
	}

	return listaPunti;
}

public static boolean isElectric(Connection con) throws SQLException {
	PreparedStatement pst=null;
	ResultSet rs=null;
	
	try 
	
	{
		pst=con.prepareStatement("SELECT * FROM tblMisuraSicurezzaElettrica");
		
		rs=pst.executeQuery();
		
		while(rs.next()) 
		{
			return true;
		}
		
	}
	catch (SQLException e) 
	{
		return false;
	}
	catch (Exception e) 
	{
	 
	e.printStackTrace();
	}
	finally
	{
		if(pst!=null) 
		{
			pst.close();
		}
		con.close();
		
	}
	return false;
}

public static void createDBVER(Connection con) throws SQLException {

	PreparedStatement pst =con.prepareStatement(sqlCreateStrumentTableVER);
	pst.execute();
	
	PreparedStatement pstCM =con.prepareStatement(sqlCreateCMPTable);
	pstCM.execute();
	
	PreparedStatement pstMisure=con.prepareStatement(sqlCreateMisuraVER);
	pstMisure.execute();
	
	PreparedStatement pstMis =con.prepareStatement(sqlCreateAccuratezzaVER);
	pstMis.execute();
	
	PreparedStatement pstCampAss =con.prepareStatement(sqlCreateClassiVER);
	pstCampAss.execute();
	
	PreparedStatement pstFatMolt =con.prepareStatement(sqlCreateDecentramentoVER);
	pstFatMolt.execute();
	
	PreparedStatement pstConversione =con.prepareStatement(sqlCreateLinearitaVER);
	pstConversione.execute();
	
	PreparedStatement pstCampioniUtilizzati =con.prepareStatement(sqlCreateRipetibilitaVER);
	pstCampioniUtilizzati.execute();
	
	PreparedStatement pstClass =con.prepareStatement(sqlCreateMobilitaVER);
	pstClass.execute();
	
	PreparedStatement pstStrList =con.prepareStatement(sqlCreatStrListVER);
	pstStrList.execute();
	
}

public static ArrayList<VerMisuraDTO> getListaMisure(Connection con, VerInterventoDTO ver_intervento) throws Exception {


	
	PreparedStatement pst=null;
	ResultSet rs=null;
	ArrayList<VerMisuraDTO> listaMisura= new ArrayList<VerMisuraDTO>();
	
	try 
	{		
		pst=con.prepareStatement("SELECT a.id as idMis, a.* ,b.id as idStr,b.* FROM ver_misura a JOIN ver_strumento b ON a.id_ver_strumento=b.id where stato=1 ");
		rs=pst.executeQuery();
		
		VerMisuraDTO misura =null;
		VerStrumentoDTO strumento=null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		while(rs.next())
		{
		
			int idMisura=rs.getInt("idMis");
			
			misura= new VerMisuraDTO();
			strumento = new VerStrumentoDTO();
			misura.setDataVerificazione(sdf.parse(rs.getString("data_verificazione")));
			misura.setDataScadenza(sdf.parse(rs.getString("data_scadenza")));
			misura.setTipoRisposta(rs.getInt("tipo_risposta"));
			misura.setTipo_verifica(new VerTipoVerificaDTO(rs.getInt("tipo_verifica"),""));
			misura.setMotivo_verifica(new VerMotivoVerificaDTO(rs.getInt("motivo_verifica"),""));
			misura.setIs_difetti(rs.getString("isDifetti"));
			misura.setNomeRiparatore(rs.getString("nome_riparatore"));
			misura.setVerIntervento(ver_intervento);
			misura.setTecnicoVerificatore(ver_intervento.getUser_verificazione());
			misura.setCampioniLavoro(rs.getString("campioni_lavoro"));
			misura.setSeqRisposte(rs.getString("seq_risposte"));
			
			misura.setFile_inizio_prova(rs.getBytes("file_inizio_prova"));
			if(rs.getString("nomefile_inizio_prova")!=null) {
				misura.setNomeFile_inizio_prova(rs.getString("nomefile_inizio_prova").replace("'","_"));
			}else {
				misura.setNomeFile_inizio_prova(rs.getString("nomefile_inizio_prova"));
			}
			
			misura.setFile_fine_prova(rs.getBytes("file_fine_prova"));

			if(rs.getString("nomefile_fine_prova")!=null) {
				misura.setNomeFile_fine_prova(rs.getString("nomefile_fine_prova").replace("'","_"));
			}else {
				misura.setNomeFile_fine_prova(rs.getString("nomefile_fine_prova"));
			}
			
			misura.settInizio(rs.getDouble("tInizio"));
			misura.settFine(rs.getDouble("tFine"));
			misura.setAltezza_org(rs.getDouble("altezza_org"));
			misura.setAltezza_util(rs.getDouble("altezza_util"));
			misura.setLatitudine_org(rs.getDouble("latitudine_org"));
			misura.setLatitudine_util(rs.getDouble("latitudine_util"));
			misura.setgOrg(rs.getDouble("gOrg"));
			misura.setgUtil(rs.getDouble("gUtil"));
			misura.setgFactor(rs.getDouble("gFactor"));
			
			
			misura.setNumeroSigilli(rs.getInt("numeroSigilli"));

			String dataRiparazione=rs.getString("data_riparazione");

			if(dataRiparazione!=null && dataRiparazione.length()>0) 
			{
				misura.setDataRiparazione(sdf.parse(dataRiparazione));
			}
			
			misura.setListaPuntiRipetibilita(getListaProvaRipetibilita(con,idMisura,misura));
			
			misura.setListaPuntiDecentramento(getListaProvaDecentramento(con,idMisura));
			
			misura.setListaPuntiLinearita(getListaProvaLinearita(con,idMisura));
			
			
			misura.setListaPuntiAccuratezza(getListaProvaAccuratezza(con,idMisura));
			
			misura.setListaPuntiMobilita(getListaProvaMobilita(con,idMisura));
			
			strumento.setId(rs.getInt("idStr"));//
			strumento.setDenominazione(rs.getString("denominazione"));//
			strumento.setCostruttore(rs.getString("costruttore"));
			strumento.setModello(rs.getString("modello"));
			strumento.setMatricola(rs.getString("matricola"));
			strumento.setClasse(rs.getInt("classe"));
			strumento.setTipo(new VerTipoStrumentoDTO(rs.getInt("id_ver_tipo_strumento"),""));
			strumento.setUm(rs.getString("um"));
			strumento.setTipologia(new VerTipologiaStrumentoDTO(rs.getInt("id_tipologia"),""));
			
			String dataUltimaVerifica=rs.getString("data_ultima_verifica");
		
			if(dataUltimaVerifica!=null && dataUltimaVerifica.length()>0) 
			{
				strumento.setData_ultima_verifica(sdf.parse(dataUltimaVerifica));
			}
			
			String dataProssimaVerifica=rs.getString("data_prossima_verifica");
			
			if(dataProssimaVerifica!=null && dataProssimaVerifica.length()>0) 
			{
				strumento.setData_prossima_verifica(sdf.parse(dataProssimaVerifica));
			}
			
			
			strumento.setPortata_min_C1(rs.getBigDecimal("portata_min_C1"));
			strumento.setPortata_max_C1(rs.getBigDecimal("portata_max_C1"));
			strumento.setDiv_ver_C1(rs.getBigDecimal("div_ver_C1"));
			strumento.setDiv_rel_C1(rs.getBigDecimal("div_rel_C1"));
			strumento.setNumero_div_C1(rs.getBigDecimal("numero_div_C1"));
			strumento.setPortata_min_C2(rs.getBigDecimal("portata_min_C2"));
			strumento.setPortata_max_C2(rs.getBigDecimal("portata_max_C2"));
			strumento.setDiv_ver_C2(rs.getBigDecimal("div_ver_C2"));
			strumento.setDiv_rel_C2(rs.getBigDecimal("div_rel_C2"));
			strumento.setNumero_div_C2(rs.getBigDecimal("numero_div_C2"));
			strumento.setPortata_min_C3(rs.getBigDecimal("portata_min_C3"));
			strumento.setPortata_max_C3(rs.getBigDecimal("portata_max_C3"));
			strumento.setDiv_ver_C3(rs.getBigDecimal("div_ver_C3"));
			strumento.setDiv_rel_C3(rs.getBigDecimal("div_rel_C3"));
			strumento.setNumero_div_C3(rs.getBigDecimal("numero_div_C3"));
			strumento.setAnno_marcatura_ce(rs.getInt("anno_marcatura_CE"));
			
			String dataMs=rs.getString("data_ms");
			if(dataMs!=null && dataMs.length()>0) 
			{
				strumento.setData_messa_in_servizio(sdf.parse(dataMs));
			}
			strumento.setTipologia(new VerTipologiaStrumentoDTO(rs.getInt("id_tipologia"),""));
			strumento.setFreqMesi(rs.getInt("freq_mesi"));
			strumento.setCreato(rs.getString("creato"));
			strumento.setFamiglia_strumento(new VerFamigliaStrumentoDTO(rs.getString("famiglia_strumento"),""));
			misura.setVerStrumento(strumento);
			
			listaMisura.add(misura);
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
		con.close();
	}
	return listaMisura;
	
}

private static LinkedHashSet<VerMobilitaDTO> getListaProvaMobilita(Connection con, int idMisura) throws Exception {
	PreparedStatement pst=null;
	ResultSet rs=null;
	LinkedHashSet<VerMobilitaDTO> listaMobilita= new LinkedHashSet<>();
	
	VerMobilitaDTO ver_mob = null;
	
	try 
	{
	
		pst=con.prepareStatement("SELECT * FROM ver_mobilita WHERE id_misura=? ORDER BY id ASC");
		pst.setInt(1, idMisura);
		
		rs=pst.executeQuery();			
		
		while(rs.next())
		{
			ver_mob=new VerMobilitaDTO();
			ver_mob.setId(rs.getInt("id"));
		    ver_mob.setCampo(rs.getInt("campo"));
		    ver_mob.setCaso(rs.getInt("caso"));
		    ver_mob.setCarico(rs.getInt("carico"));
		    ver_mob.setMassa(rs.getBigDecimal("massa"));
		    ver_mob.setIndicazione(rs.getBigDecimal("indicazione"));
		    ver_mob.setCaricoAgg(rs.getBigDecimal("carico_agg"));
		    ver_mob.setPostIndicazione(rs.getBigDecimal("post_indicazione"));
		    ver_mob.setDifferenziale(rs.getBigDecimal("differenziale"));
		    ver_mob.setDivisione(rs.getBigDecimal("divisione"));
		    ver_mob.setCheck_punto(rs.getString("check_stato"));
		    ver_mob.setEsito(rs.getString("esito"));
		    
		    listaMobilita.add(ver_mob);
		    
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
	}

	return listaMobilita;
	
}

private static LinkedHashSet<VerAccuratezzaDTO> getListaProvaAccuratezza(Connection con, int idMisura) throws Exception {
	PreparedStatement pst=null;
	ResultSet rs=null;
	LinkedHashSet<VerAccuratezzaDTO> listaAccuratezza= new LinkedHashSet<>();
	
	VerAccuratezzaDTO ver_acc = null;
	
	try 
	{
		pst=con.prepareStatement("SELECT * FROM ver_accuratezza WHERE id_misura=? ORDER BY id ASC");
		pst.setInt(1, idMisura);
		
		rs=pst.executeQuery();
		
		
		while(rs.next())
		{
			ver_acc=new VerAccuratezzaDTO();
			ver_acc.setId(rs.getInt("id"));
			ver_acc.setTipoTara(rs.getInt("tipo_tara"));
		    ver_acc.setCampo(rs.getInt("campo"));
		    ver_acc.setPosizione(rs.getInt("posizione"));
		    ver_acc.setMassa(rs.getBigDecimal("massa"));
		    ver_acc.setIndicazione(rs.getBigDecimal("indicazione"));
		    ver_acc.setCaricoAgg(rs.getBigDecimal("carico_agg"));
		    ver_acc.setErrore(rs.getBigDecimal("errore"));
		    ver_acc.setErroreCor(rs.getBigDecimal("errore_cor"));
		    ver_acc.setMpe(rs.getBigDecimal("mpe"));
		    ver_acc.setEsito(rs.getString("esito"));
		    
		    listaAccuratezza.add(ver_acc);
		    
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
	}

	return listaAccuratezza;
}

private static LinkedHashSet<VerLinearitaDTO> getListaProvaLinearita(Connection con, int idMisura) throws Exception {
	PreparedStatement pst=null;
	ResultSet rs=null;
	LinkedHashSet<VerLinearitaDTO> listaLinearita= new LinkedHashSet<>();
	
	VerLinearitaDTO ver_lin = null;
	
	try 
	{
		pst=con.prepareStatement("SELECT * FROM ver_linearita WHERE id_misura=? ORDER BY id ASC");
		pst.setInt(1, idMisura);
		
		rs=pst.executeQuery();
		
		
		while(rs.next())
		{
			ver_lin=new VerLinearitaDTO();
			ver_lin.setId(rs.getInt("id"));
			ver_lin.setTipoAzzeramento(rs.getInt("tipo_azzeramento"));
		    ver_lin.setCampo(rs.getInt("campo"));
		    ver_lin.setRiferimento(rs.getInt("riferimento"));
		    ver_lin.setMassa(rs.getBigDecimal("massa"));
		    ver_lin.setIndicazioneSalita(rs.getBigDecimal("indicazione_salita"));
		    ver_lin.setIndicazioneDiscesa(rs.getBigDecimal("indicazione_discesa"));
		    ver_lin.setCaricoAggSalita(rs.getBigDecimal("carico_agg_salita"));
		    ver_lin.setCaricoAggDiscesa(rs.getBigDecimal("carico_agg_discesa"));		    
		    ver_lin.setErroreSalita(rs.getBigDecimal("errore_salita"));
		    ver_lin.setErroreDiscesa(rs.getBigDecimal("errore_discesa"));
		    ver_lin.setErroreCorSalita(rs.getBigDecimal("errore_cor_salita"));
		    ver_lin.setErroreCorDiscesa(rs.getBigDecimal("errore_cor_discesa"));
		    ver_lin.setMpe(rs.getBigDecimal("mpe"));
		    ver_lin.setDivisione(rs.getBigDecimal("divisione"));
		    ver_lin.setEsito(rs.getString("esito"));
		    
		    listaLinearita.add(ver_lin);
		    
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();

	}

	return listaLinearita;
}

private static LinkedHashSet<VerDecentramentoDTO> getListaProvaDecentramento(Connection con, int idMisura) throws Exception {
	PreparedStatement pst=null;
	ResultSet rs=null;
	LinkedHashSet<VerDecentramentoDTO> listaDecentraento= new LinkedHashSet<>();
	
	VerDecentramentoDTO ver_dec = null;
	
	try 
	{

		pst=con.prepareStatement("SELECT * FROM ver_decentramento WHERE id_misura=? ORDER BY id ASC");
		pst.setInt(1, idMisura);
		
		rs=pst.executeQuery();
		
		
		while(rs.next())
		{
			ver_dec=new VerDecentramentoDTO();
			ver_dec.setId(rs.getInt("id"));
			ver_dec.setTipoRicettore(rs.getInt("tipo_ricettore"));
			ver_dec.setPuntiAppoggio(rs.getInt("punti_appoggio"));
		    ver_dec.setCampo(rs.getInt("campo"));
		    ver_dec.setPosizione(rs.getInt("posizione"));
		    ver_dec.setMassa(rs.getBigDecimal("massa"));
		    ver_dec.setIndicazione(rs.getBigDecimal("indicazione"));
		    ver_dec.setCaricoAgg(rs.getBigDecimal("carico_agg"));
		    ver_dec.setErrore(rs.getBigDecimal("errore"));
		    ver_dec.setErroreCor(rs.getBigDecimal("errore_cor"));
		    ver_dec.setMpe(rs.getBigDecimal("mpe"));
		    ver_dec.setEsito(rs.getString("esito"));
		    ver_dec.setCarico(rs.getBigDecimal("carico"));
		    ver_dec.setSpeciale(rs.getString("speciale"));
		    
		    listaDecentraento.add(ver_dec);
		    
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
		
	}

	return listaDecentraento;
}

private static LinkedHashSet<VerRipetibilitaDTO> getListaProvaRipetibilita(Connection con, int idMisura, VerMisuraDTO misura) throws Exception {
	PreparedStatement pst=null;
	ResultSet rs=null;
	LinkedHashSet<VerRipetibilitaDTO> listaRipetibilita= new LinkedHashSet<>();
	
	VerRipetibilitaDTO ver_rip = null;
	
	try 
	{
		pst=con.prepareStatement("SELECT * FROM ver_ripetibilita WHERE id_misura=? ORDER BY id ASC");
		pst.setInt(1, idMisura);
		
		rs=pst.executeQuery();
		
		
		while(rs.next())
		{
			ver_rip=new VerRipetibilitaDTO(); 
			ver_rip.setId(rs.getInt("id"));
		
		    ver_rip.setCampo(rs.getInt("campo"));
		    ver_rip.setNumeroRipetizione(rs.getInt("numero_ripetizione"));
		    ver_rip.setMassa(rs.getBigDecimal("massa"));
		    ver_rip.setIndicazione(rs.getBigDecimal("indicazione"));
		    ver_rip.setCaricoAgg(rs.getBigDecimal("carico_agg"));
		    ver_rip.setPortata(rs.getBigDecimal("portata"));
		    ver_rip.setDeltaPortata(rs.getBigDecimal("delta_portata"));
		    ver_rip.setMpe(rs.getBigDecimal("mpe"));
		    ver_rip.setEsito(rs.getString("esito"));
		    
		    listaRipetibilita.add(ver_rip);
		    
		}
		
	}
	catch (Exception e) 
	{
	 e.printStackTrace();	
	 throw e;
	}
	finally
	{
		pst.close();
	}

	return listaRipetibilita;
}




}
