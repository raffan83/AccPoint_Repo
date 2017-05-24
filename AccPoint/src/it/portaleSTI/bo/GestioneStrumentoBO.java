package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Util.Costanti;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;


public class GestioneStrumentoBO {

	/*
	 * Inizio Chiamate creazioni select clienti e sedi
	 * */

	public static List<ClienteDTO> getListaClientiNew(String id_company) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaClientiNew(id_company);
	}

	public static List<SedeDTO> getListaSediNew() throws SQLException {

		return GestioneStrumentoDAO.getListaSediNEW();
	}

	/*
	 * Fine Chiamate creazioni select clienti e sedi
	 * */

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


	public static ArrayList<StrumentoDTO> getListaStrumentiPerSediAttiviNEW(String idCliente,String idSede, Integer idCompany ,Session session) throws Exception{

		return GestioneStrumentoDAO.getListaStrumenti(idCliente,idSede,idCompany,session);
		
				
		//return DirectMySqlDAO.getRedordDatiStrumentoAvviviNew(idCliente,idSede,idCompany);

	}

	public static List<TipoMisuraDTO> getTipiMisura(String tpS) throws HibernateException, Exception {

		return GestioneStrumentoDAO.getListaTipiMisura(tpS);
	}

	public static String creaPacchetto(int idCliente, int idSede, CompanyDTO cmp, Session session) throws Exception {

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
		
		DirectMySqlDAO.insertRedordDatiStrumento(idCliente,idSede,cmp,con);
		
		DirectMySqlDAO.insertTipoGrandezza_TipoStrumento(con);
		
		DirectMySqlDAO.insertClassificazione(con);
		
		DirectMySqlDAO.insertTipoRapporto(con);
		
		DirectMySqlDAO.insertStatoStrumento(con);
		
		DirectMySqlDAO.insertTipoStrumento(con);
		
		
		return nomeFile;
	}

	public static StrumentoDTO getStrumentoById(String id_str, Session session) throws Exception {


		return GestioneStrumentoDAO.getStrumentoById(id_str, session);
	}
	
	public static int saveStrumento(StrumentoDTO strumento,Session session){
		
		try{
			Integer id_strumento = (Integer) session.save(strumento);
			if(id_strumento != 0){
				 
					Iterator<ScadenzaDTO> iterator = strumento.getListaScadenzeDTO().iterator(); 
			      
				   // check values
				   while (iterator.hasNext()){

					   ScadenzaDTO scadenza = iterator.next();
						scadenza.setIdStrumento(id_strumento);
						Integer id_scadenza = (Integer) session.save(scadenza);
						if(id_scadenza == 0){
							session.getTransaction().rollback();
					 		session.close();
							return 0;
						}
				   }
				    
				
			}else{
				session.getTransaction().rollback();
		 		session.close();
				return 0;
			}
			
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
			session.getTransaction().commit();

			return true;
		}catch (Exception ex){
			session.getTransaction().rollback();

	 		return false;
		}
		
	}
	public static ArrayList<MisuraDTO> getListaMisureByStrumento(int idStrumento)throws Exception
	{
		
			return GestioneStrumentoDAO.getListaMirureByStrumento(idStrumento);
			
		
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
		strumento.setLuogo(new LuogoVerificaDTO(intervento.getPressoDestinatario(),""));
		
		int idStrumento=saveStrumento(strumento,session);
		
		
		
		strumento.set__id(idStrumento);
		
		return strumento;
	}

	public static void updateScadenza(ScadenzaDTO scadenza, Session session)throws Exception {
	
		session.update(scadenza);
		
	}

}
