package it.portaleSTI.bo;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.DocumentiEsterniStrumentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.StrumentoNoteDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;


public class GestioneStrumentoBO {




	public static List<TipoStrumentoDTO> getListaTipoStrumento() throws HibernateException, Exception
	{
		return GestioneStrumentoDAO.getListaTipoStrumento();
	}

	public static List<TipoRapportoDTO> getListaTipoRapporto() throws HibernateException, Exception
	{
		return GestioneStrumentoDAO.getListaTipoRapporto();
	}

	public static List<StrumentoDTO> getListaStrumentiPerSedi(String idSede, String idCliente) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaStrumentiPerSede(idSede);
	}


	public static ArrayList<StrumentoDTO> getListaStrumentiPerSediAttiviNEW(String idCliente,String idSede, Integer idCompany ,Session session,UtenteDTO utente) throws Exception{

		return GestioneStrumentoDAO.getListaStrumenti(idCliente,idSede,idCompany,session,utente);
		
				
		//return DirectMySqlDAO.getRedordDatiStrumentoAvviviNew(idCliente,idSede,idCompany);

	}
	
	public static ArrayList<StrumentoDTO> getListaStrumentiPerGrafici(String idCliente,String idSede, Integer idCompany,UtenteDTO utente) throws Exception{

		return DirectMySqlDAO.getListaStrumentiPerGrafico(idCliente,idSede,idCompany,utente);
		
				
		//return DirectMySqlDAO.getRedordDatiStrumentoAvviviNew(idCliente,idSede,idCompany);

	}

	public static List<TipoMisuraDTO> getTipiMisura(String tpS) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaTipiMisura(tpS);
	}

	public static String creaPacchetto(int idCliente, int idSede, CompanyDTO cmp, String nomeCliente, Session session,InterventoDTO intervento,CommessaDTO commessa ) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");

		String timeStamp=sdf.format(new Date());
		String nomeFile="CM"+cmp.getId()+""+timeStamp;
		File directory= new File(Costanti.PATH_FOLDER+nomeFile);

		if(!directory.exists())
		{
			directory.mkdir();

		}

		Connection con = SQLLiteDAO.getConnection(directory.getPath(),nomeFile);
		
		SQLLiteDAO.createDB(con);
		
		DirectMySqlDAO.insertFattoriMoltiplicativi(con);
		
		DirectMySqlDAO.insertConversioni(con);

		DirectMySqlDAO.insertListaCampioni(con,cmp);
		
		DirectMySqlDAO.insertRedordDatiStrumento(idCliente,idSede,cmp,nomeCliente,con,intervento.getNome_sede(),intervento.getUser(), session);
		
		DirectMySqlDAO.insertTipoGrandezza_TipoStrumento(con);
		
		DirectMySqlDAO.insertClassificazione(con);
		
		DirectMySqlDAO.insertTipoRapporto(con);
		
		DirectMySqlDAO.insertStatoStrumento(con);
		
		DirectMySqlDAO.insertLuogoVerifica(con);
		
		DirectMySqlDAO.insertTipoStrumento(con);
		
		
		
		if(commessa!=null) 
		{
			DirectMySqlDAO.insertListaAttivita(con,commessa);
		}
		if(intervento.getNome_sede()!=null && intervento.getNome_sede().length()>0)
		{
			ConfigurazioneClienteDTO conf=GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(intervento.getId_cliente(), intervento.getIdSede(),Costanti.ID_TIPO_RAPPORTO_SVT, session);
			
			String formatoData="N";
			
			if(conf!=null) 
			{
			formatoData=conf.getFmt_data_mese_anno();
			}
			DirectMySqlDAO.insertGeneral(con,intervento.getNome_sede(),formatoData);
		}
		
		con.close();
		
		return nomeFile;
	}

	
	
	public static StrumentoDTO getStrumentoById(String id_str, Session session) throws Exception {


		return GestioneStrumentoDAO.getStrumentoById(id_str, session);
	}
	
	public static int saveStrumento(StrumentoDTO strumento,Session session){
		
		try{
			Integer id_strumento = (Integer) session.save(strumento);
			
//			if(id_strumento != 0){
//				 
//					Iterator<ScadenzaDTO> iterator = strumento.getListaScadenzeDTO().iterator(); 
//			      
//				   // check values
//				   while (iterator.hasNext()){
//
//					   ScadenzaDTO scadenza = iterator.next();
//						scadenza.setIdStrumento(id_strumento);
//						Integer id_scadenza = (Integer) session.save(scadenza);
//						
//						if(id_scadenza == 0){
//							session.getTransaction().rollback();
//					 		session.close();
//							return 0;
//						}
//				   }
//				    
//				
//			}else{
//				session.getTransaction().rollback();
//		 		session.close();
//				return 0;
//			}
			
			return id_strumento;
		}catch (Exception ex){
			session.getTransaction().rollback();
	 		session.close();
	 		return 0;
		}
		
	}

	public static Boolean update(StrumentoDTO strumento, Session session){


		try{			
			
			session.update(strumento);
			
			return true;
		
		}catch(Exception ex)
		{
			return false;
		}
		
	}
	public static ArrayList<MisuraDTO> getListaMisureByStrumento(int idStrumento, Session session)throws Exception
	{
		
			return GestioneStrumentoDAO.getListaMirureByStrumento(idStrumento, session);
			
		
	}

	public static boolean exist(int id,Session session) throws Exception {
		
		StrumentoDTO strumento =getStrumentoById(""+id,session);
		
		if(strumento!=null)
		{
			
		}
		return false;
	}

	public static StrumentoDTO createStrumeto(StrumentoDTO strumento, InterventoDTO intervento,Session session) {
		

		strumento.setId_cliente(intervento.getId_cliente());
		strumento.setId__sede_(intervento.getIdSede());
		strumento.setCompany(intervento.getCompany());
		strumento.setUserCreation(intervento.getUser());
		//strumento.setLuogo(new LuogoVerificaDTO(intervento.getPressoDestinatario(),""));
		
		int idStrumento=saveStrumento(strumento,session);

		
		
		strumento.set__id(idStrumento);
		
		return strumento;
	}

//	public static void updateScadenza(ScadenzaDTO scadenza, Session session)throws Exception {
//	
//		session.update(scadenza);
//		
//	}

//	public static void saveScadenza(ScadenzaDTO scadenza, Session session) {
//	
//		session.save(scadenza);
//	}
	
	public static String creaPacchettoConNome(int idCliente,int idSede, CompanyDTO cmp,String nomeCliente, Session session,InterventoDTO intervento,CommessaDTO com) throws Exception, SQLException {

		Connection con=null;
		
		String nomeFile=intervento.getNomePack();
		
		try 
		{
		File directory= new File(Costanti.PATH_FOLDER+nomeFile+"\\"+nomeFile+".db");

		FileOutputStream fos = new FileOutputStream(directory);
		
		fos.close();
		
		directory.delete();
	
		File directory1= new File(Costanti.PATH_FOLDER+nomeFile+"\\"+nomeFile+".db");
	
		
		con = SQLLiteDAO.getConnection(directory1.getPath());
		
		SQLLiteDAO.createDB(con);
		
		DirectMySqlDAO.insertFattoriMoltiplicativi(con);
		
		DirectMySqlDAO.insertConversioni(con);

		DirectMySqlDAO.insertListaCampioni(con,cmp);
		
		DirectMySqlDAO.insertRedordDatiStrumento(idCliente,idSede,cmp,nomeCliente,con,intervento.getNome_sede(),intervento.getUser(), session);
		
		DirectMySqlDAO.insertTipoGrandezza_TipoStrumento(con);
		
		DirectMySqlDAO.insertClassificazione(con);
		
		DirectMySqlDAO.insertTipoRapporto(con);
		
		DirectMySqlDAO.insertStatoStrumento(con);
		
		DirectMySqlDAO.insertTipoStrumento(con);
		
		ConfigurazioneClienteDTO conf=GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(intervento.getId_cliente(), intervento.getIdSede(),Costanti.ID_TIPO_RAPPORTO_SVT, session);
		
		String formatoData="N";
		
		if(conf!=null) 
		{
		formatoData=conf.getFmt_data_mese_anno();
		}
		DirectMySqlDAO.insertGeneral(con,intervento.getNome_sede(),formatoData);
		
		DirectMySqlDAO.insertLuogoVerifica(con);
		
		DirectMySqlDAO.insertListaAttivita(con,com);
		
		con.close();
		}catch (Exception e) {
			throw e;
		}
		finally 
		{
			con.close();
		}
		return nomeFile;
	}
	
	public static String creaPacchettoConNomeLAT(int idCliente,int idSede, CompanyDTO cmp,String nomeCliente, Session session,InterventoDTO intervento) throws Exception, SQLException {

		String nomeFile=intervento.getNomePack();
		
		File directory= new File(Costanti.PATH_FOLDER+nomeFile+"\\"+"LAT"+nomeFile+".db");

		FileOutputStream fos = new FileOutputStream(directory);
		
		fos.close();
		
		directory.delete();
	
		File directory1= new File(Costanti.PATH_FOLDER+nomeFile+"\\"+"LAT"+nomeFile+".db");
	
		
		Connection con = SQLLiteDAO.getConnection(directory1.getPath());
		
		SQLLiteDAO.createDBLAT(con);
		
		DirectMySqlDAO.insertFattoriMoltiplicativi(con);
		
		DirectMySqlDAO.insertConversioni(con);

		DirectMySqlDAO.insertListaCampioniLAT(con,cmp);
		
		DirectMySqlDAO.insertRedordDatiStrumento(idCliente,idSede,cmp,nomeCliente,con,intervento.getNome_sede(),intervento.getUser(), session);
		
		DirectMySqlDAO.insertTipoGrandezza_TipoStrumento(con);
		
		DirectMySqlDAO.insertClassificazione(con);
		
		DirectMySqlDAO.insertTipoRapporto(con);
		
		DirectMySqlDAO.insertStatoStrumento(con);
		
		DirectMySqlDAO.insertTipoStrumento(con);
		
		DirectMySqlDAO.insertGeneral(con,intervento.getNome_sede(),"N");
		
		DirectMySqlDAO.insertLuogoVerifica(con);
		
		DirectMySqlDAO.insertMasterTableLAT(con);
		
	    DirectMySqlDAO.insert_massa_classe(con);
	    
	    DirectMySqlDAO.insert_massa_scarti_tipo(con);
	    
	    DirectMySqlDAO.insert_massa_amb_sonde(con);
		
		con.close();
		
		return nomeFile;
	}


	public static ArrayList<StrumentoDTO> getListaStrumentiFromDate(UtenteDTO user, String dateFrom, String dateTo, int tipo_rapporto) throws ParseException {

		List<StrumentoDTO> lista = GestioneStrumentoDAO.getListaStrumentiFromUser(user,dateFrom,dateTo);
		
		ArrayList<StrumentoDTO> listaFiltrata= new ArrayList<StrumentoDTO>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
		
		if(dateFrom==null && dateTo!=null)
		{
		
			for (StrumentoDTO strumento : lista) 
			{
				if(strumento!=null && strumento.getDataProssimaVerifica()!=null)
				{
					Date prossimaVerifica=strumento.getDataProssimaVerifica();
					if(tipo_rapporto == 0) {
						if(prossimaVerifica!=null && sdf.format(prossimaVerifica).equals(dateTo))
						{
							listaFiltrata.add(strumento);
						}
					}else {
						if(prossimaVerifica!=null && sdf.format(prossimaVerifica).equals(dateTo) && strumento.getTipoRapporto().getId()==tipo_rapporto)
						{
							listaFiltrata.add(strumento);
						}
					}					
					
				}
			}
		}
		if(dateFrom!=null && dateTo!=null)
		{
		
			for (StrumentoDTO strumento : lista) 
			{
				if(strumento!=null && strumento.getDataProssimaVerifica()!=null)
				{
					Date prossimaVerifica=strumento.getDataProssimaVerifica();
					
					if(tipo_rapporto == 0) {
						if(prossimaVerifica!=null && prossimaVerifica.after(sdf.parse(dateFrom))&& (prossimaVerifica.before(sdf.parse(dateTo)) || prossimaVerifica.equals(sdf.parse(dateTo))))
						{
							if(nonContieneStrumento(listaFiltrata,strumento))
							{
								listaFiltrata.add(strumento);
							}
						}
					}else {
						if(strumento.getTipoRapporto().getId() == tipo_rapporto && prossimaVerifica!=null && prossimaVerifica.after(sdf.parse(dateFrom))&& (prossimaVerifica.before(sdf.parse(dateTo)) || prossimaVerifica.equals(sdf.parse(dateTo))))
						{
							if(nonContieneStrumento(listaFiltrata,strumento))
							{
								listaFiltrata.add(strumento);
							}
						}
					}
					
					
				}
			}
		}
		
		return listaFiltrata;
		
	}
	
	private static boolean nonContieneStrumento(ArrayList<StrumentoDTO> listaFiltrata, StrumentoDTO strumento) {
		
		boolean toReturn =true;
		
		for(StrumentoDTO str :listaFiltrata)
		{
			if(str.get__id()==strumento.get__id())
				return false;
		}
		
		return toReturn;
		
	}

	public static HashMap<String, Integer> getListaStrumentiScadenziario(UtenteDTO user) {
		
		//return GestioneStrumentoDAO.getListaStrumentiScadenziario(user);
		
		return DirectMySqlDAO.getListaStrumentiScadenziario(user);

	}



	public static ArrayList<StrumentoDTO> getListaStrumentiIntervento(InterventoDTO intervento, Session session) {
		// TODO Auto-generated method stub
		return GestioneStrumentoDAO.getListaStrumentiIntervento(intervento, session);
	}

	public static DocumentiEsterniStrumentoDTO getDocumentoEsterno(String idDocumento, Session session) {
		// TODO Auto-generated method stub
		return GestioneStrumentoDAO.getDocumentoEsterno(idDocumento,session);
	}

	public static void deleteDocumentoEsterno(String idDocumento, Session session) {
		// TODO Auto-generated method stub

		GestioneStrumentoDAO.deleteDocumentoEsterno(idDocumento,session);
	}

	public static ObjSavePackDTO saveDocumentoEsterno(FileItem fileUploaded, StrumentoDTO strumento, String dataVerifica, Session session) {

		return GestioneStrumentoDAO.saveDocumentoEsterno(fileUploaded,strumento,dataVerifica,session);
		
	}
	public static ArrayList<Integer> getListaClientiStrumenti() {
		// TODO Auto-generated method stub
		return GestioneStrumentoDAO.getListaClientiStrumenti();
	}

	public static ArrayList<Integer> getListaSediStrumenti() {
		// TODO Auto-generated method stub
		return GestioneStrumentoDAO.getListaSediStrumenti();
	}

	public static ArrayList<StrumentoDTO> getStrumentiByIds(String idsStrumenti, Session session) throws HibernateException, Exception {
		String[] idsStrumentiArray = idsStrumenti.split(";");
		
		ArrayList<StrumentoDTO> arrayStrumenti = new ArrayList<StrumentoDTO>();
		for (String strumentoId : idsStrumentiArray) {
			StrumentoDTO strumento = GestioneStrumentoDAO.getStrumentoById(strumentoId, session);
			arrayStrumenti.add(strumento);
		}
		
		return arrayStrumenti;
	}

	public static ArrayList<StrumentoDTO> getStrumentiFiltrati(String nome, String marca, String modello, String matricola, String codice_interno, int id_company) throws Exception {
		
		//return GestioneStrumentoDAO.getStrumentiFiltrati(nome, marca, modello, matricola, codice_interno, id_company);
		return DirectMySqlDAO.getStrumentiFiltrati(nome, marca, modello, matricola, codice_interno, id_company);
	}

	public static ArrayList<StrumentoDTO> getlistaStrumentiFromCompany(Integer id_company, Session session) {
		
		return GestioneStrumentoDAO.getlistaStrumentiFromCompany(id_company, session);
	}

	public static ArrayList<StrumentoDTO> getListaStrumentiInFuoriServizio(String idCliente, String idSede, Integer idCompany,
			Session session, UtenteDTO utente, int stato) throws Exception {
		
		return GestioneStrumentoDAO.getListaStrumentiInFuoriServizio(idCliente, idSede, idCompany, session,utente, stato);
	}

	public static ArrayList<StrumentoDTO> getStrumentiFiltratiGenerale(int id, String nome, String marca, String modello, String matricola, String codice_interno, Integer id_company, UtenteDTO user) {

		return GestioneStrumentoDAO.getStrumentiFiltratiGenerale(id,nome, marca, modello, matricola, codice_interno, id_company, user);
	}

	public static boolean saveNote(StrumentoNoteDTO noteStrumento, Session session) {
		
	try{			
			
			session.save(noteStrumento);
			
			return true;
		
		}catch(Exception ex)
		{
			return false;
		}
	}

	public static boolean updateStatoIp(String idStr, int stato) throws Exception {
		
		
		return GestioneStrumentoDAO.updateStatoIp(idStr,stato) ;
	}



}
