package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.DocumentiEsterniStrumentoDTO;
import it.portaleSTI.DTO.DocumentoCampioneDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.SequenceDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.DTO.TipoEventoRegistroDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ValoriCampione;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;



public class GestioneCampioneDAO {

	private static String updateCompanyUtilizzatoreCampione="UPDATE campione set id_company_utilizzatore=? WHERE __id=?";

	public static ArrayList<CampioneDTO> getListaCampioni(String date, int idCompany, Session session) {
		Query query=null;
		ArrayList<CampioneDTO> list=null;
		try {
			
//		Session session = SessionFacotryDAO.get().openSession();
//	    
//		session.beginTransaction();
		
		if(idCompany==0)
		{
		
		
				if(date!=null)
				{
				String s_query = "from CampioneDTO WHERE data_scadenza = :date and stato_campione != 'F'  and codice not like '%CDT%'";
			    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		        Date dt = df.parse(date);
			    query = session.createQuery(s_query);
			    query.setParameter("date",dt);
				}
				else
				{
			     query  = session.createQuery( "from CampioneDTO");
				}
		}
		else
		{
			if(date!=null)
			{
			String s_query = "from CampioneDTO WHERE data_scadenza = :date AND id_Company=:_idc and stato_campione != 'F'  and codice not like '%CDT%'";
		    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	        Date dt = df.parse(date);
		    query = session.createQuery(s_query);
		    query.setParameter("date",dt);
		    query.setParameter("_idc", idCompany);
			}
			else
			{
		     query  = session.createQuery( "from CampioneDTO WHERE id_Company=:_idc");
		     query.setParameter("_idc", idCompany);
			}
		}
		
		list = (ArrayList<CampioneDTO>)query.list();
		
//		session.getTransaction().commit();
//		session.close();
	
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

	}
	
	

	
	public static ArrayList<ValoreCampioneDTO> getListaValori(int id){
	Query query=null;
	ArrayList<ValoreCampioneDTO> list=null;
	try {
		
	Session session = SessionFacotryDAO.get().openSession();
    
	session.beginTransaction();
	
	String s_query = "from ValoreCampioneDTO WHERE id__campione_ = :_id AND obsoleto='N'";
    query = session.createQuery(s_query);
    query.setParameter("_id",id);
	
	list = (ArrayList<ValoreCampioneDTO>)query.list();
	
	session.getTransaction().commit();
	session.close();

     } catch(Exception e)
     {
    	 e.printStackTrace();
     } 
	return list;

	}




	
	
	public static void updateStatoCampione(PrenotazioneDTO prenotazione) throws Exception {
		
		Connection con =null;
		PreparedStatement pst =null;
		
		try 
		{
		 con =DirectMySqlDAO.getConnection();
		 pst=con.prepareStatement(updateCompanyUtilizzatoreCampione);
		 
	//	 pst.setInt(1, prenotazione.getId_companyRichiedente());
	//	 pst.setInt(2, prenotazione.getId_campione());
		 
		 pst.execute();
		} 
		catch (Exception e) {
			throw e;
		}
		
		}
	public static CampioneDTO getCampioneFromId(String campioneId) throws Exception{
		try 
		{
			Session session = SessionFacotryDAO.get().openSession();	    
			session.beginTransaction();
			
			CampioneDTO campione = (CampioneDTO) session.get(CampioneDTO.class, Integer.parseInt(campioneId));
			session.getTransaction().commit();
			session.close();
			
			return campione;
		}catch (Exception e){
			throw e;
		}

	}
	public static ValoreCampioneDTO getValoreFromId(String valoreC) throws Exception{
		try 
		{
			Session session = SessionFacotryDAO.get().openSession();	    
			session.beginTransaction();
			
			ValoreCampioneDTO valoreCampione = (ValoreCampioneDTO) session.get(ValoreCampioneDTO.class, Integer.parseInt(valoreC));
			session.close();
			
			return valoreCampione;
		}catch (Exception e){
			throw e;
		}

	}

	public static CampioneDTO getCampioneFromCodice(String codice) {
		Query query=null;
		CampioneDTO campione=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from CampioneDTO WHERE codice = :_codice ";
	    query = session.createQuery(s_query);
	    query.setParameter("_codice",codice);

	    
	    
	    if(query.list().size()>0)
	    {
	    	campione = (CampioneDTO)query.list().get(0);
	    }
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return campione;
	}

	public static CampioneDTO getCampioneFromCodiceCertificato(String codice) {
		Query query=null;
		CampioneDTO campione=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from CampioneDTO cp JOIN cp.listaCertificatiCampione ccp WHERE codice = :_codice AND ccp.obsoleto='N'";
	    query = session.createQuery(s_query);
	    query.setParameter("_codice",codice);

	    
	    
	    if(query.list().size()>0)
	    {
	    	campione = (CampioneDTO)query.list().get(0);
	    }
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return campione;
	}



	public static int saveCertifiactoCampione(
		CertificatoCampioneDTO certificatoCampioneDTO, Session session) {
		
		
		return (Integer) session.save(certificatoCampioneDTO);
	}


	public static void updateCertificatoCampione(
			CertificatoCampioneDTO certificatoCampioneDTO, Session session) {
	
		session.update(certificatoCampioneDTO);
		
	}




	public static void rendiObsoletiValoriCampione(Session session, int id) {
		
		Query query=null;
		try {
	    
		session.beginTransaction();
		
		String s_query = "UPDATE ValoreCampioneDTO set obsoleto = 'S' WHERE campione.id = :_id";

		query = session.createQuery(s_query);
	
		query.setParameter("_id", id);

	    query.executeUpdate();
		
	  
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     } 
		
	}




	public static void saveValoreCampione(Session session,ValoreCampioneDTO valoreCampioneDTO)throws Exception {
		
		session.save(valoreCampioneDTO);
		
	}




	public static CertificatoCampioneDTO getCertifiactoCampioneById(String idCert) throws Exception{
		Query query=null;
		CertificatoCampioneDTO campione=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from CertificatoCampioneDTO WHERE id = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idCert));
		
	    if(query.list().size()>0)
	    {
	    	campione = (CertificatoCampioneDTO)query.list().get(0);
	    }
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     } 
		return campione;
	}




	public static ArrayList<RegistroEventiDTO> getListaRegistroEventi(String id_campione, Session session) {
		
		ArrayList<RegistroEventiDTO> evento = null;
		
		Query query = session.createQuery("from RegistroEventiDTO where campione.id = :_campione");
		
		query.setParameter("_campione", Integer.parseInt(id_campione));
		
		evento = (ArrayList<RegistroEventiDTO>) query.list();
		
		return evento;
	}




	public static void saveEventoRegistro(RegistroEventiDTO evento, Session session) {
		session.save(evento);
		
	}
	

	public static void saveAttivitaManutenzione(AttivitaManutenzioneDTO attivita, Session session) {
		session.save(attivita);
		
	}

	public static ArrayList<AttivitaManutenzioneDTO> getListaAttivitaManutenzione(int id_evento, Session session_) throws HibernateException{
		
		
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		ArrayList<AttivitaManutenzioneDTO> lista = null;
		
		Query query = session.createQuery("from AttivitaManutenzioneDTO where evento.id = :_id_evento");
		
		query.setParameter("_id_evento", id_evento);
		
		lista = (ArrayList<AttivitaManutenzioneDTO>) query.list();
		
		session.getTransaction().commit();
		session.close();
		
		return lista;
	}




	public static CertificatoCampioneDTO getCertificatoFromCampione(int id_campione, Session session) {
		
		CertificatoCampioneDTO lista = null;
		
		Query query = session.createQuery("from CertificatoCampioneDTO where id_campione = :_id_campione");
		
		query.setParameter("_id_campione", id_campione);
		
		lista = (CertificatoCampioneDTO) query.list().get(0);
		
		return lista;
	}




	public static ArrayList<TipoManutenzioneDTO> getListaTipoManutenzione(Session session) {

		ArrayList<TipoManutenzioneDTO> lista = null;
		
		Query query = session.createQuery("from TipoManutenzioneDTO");
		
		lista = (ArrayList<TipoManutenzioneDTO>) query.list();
		
		return lista;
	}




	public static ArrayList<TipoAttivitaManutenzioneDTO> getListaTipoAttivitaManutenzione(Session session) {
		ArrayList<TipoAttivitaManutenzioneDTO> lista = null;
		
		Query query = session.createQuery("from TipoAttivitaManutenzioneDTO");
		
		lista = (ArrayList<TipoAttivitaManutenzioneDTO>) query.list();
		
		return lista;
	}




	public static RegistroEventiDTO getEventoFromId(int id_evento, Session session) {

		
		RegistroEventiDTO evento = null;
		
		Query query = session.createQuery("from RegistroEventiDTO where id = :_id_evento");
		
		query.setParameter("_id_evento", id_evento);
		
		evento = (RegistroEventiDTO) query.list().get(0);
		
		return evento;	
	}




	public static ArrayList<CampioneDTO> getListaCampioniPrenotabili() {
		Query query=null;
		ArrayList<CampioneDTO> list=new ArrayList<CampioneDTO>();
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		
	   String s_query = "from CampioneDTO WHERE prenotabile = 'S'";

       query = session.createQuery(s_query);
			  
		
		
		list = (ArrayList<CampioneDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();
	
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;
	}





	public static DocumentoCampioneDTO getDocumentoCampione(String idDocumento, Session session) {
		
		ArrayList<DocumentoCampioneDTO> lista = null;
		
		Query query = session.createQuery("from DocumentoCampioneDTO where id =:_id_documento");
		query.setParameter("_id_documento", Integer.parseInt(idDocumento));
		
		lista = (ArrayList<DocumentoCampioneDTO>) query.list();
		
		if(lista.size()>0) {
			return lista.get(0);
		}
		
		return null;
	}




	public static ArrayList<DocumentoCampioneDTO> getListaDocumentiEsterni(int id_campione, Session session) {
		
		ArrayList<DocumentoCampioneDTO> lista = null;
		
		Query query = session.createQuery("from DocumentoCampioneDTO where campione.id = :_id_campione and categoria.id = 2");
		query.setParameter("_id_campione", id_campione);
				
		lista = (ArrayList<DocumentoCampioneDTO>) query.list();
				
		return lista;
	}




	public static ArrayList<TipoEventoRegistroDTO> getListaTipoEventoRegistro(Session session) {

		ArrayList<TipoEventoRegistroDTO> lista = null;
		
		Query query = session.createQuery("from TipoEventoRegistroDTO");
						
		lista = (ArrayList<TipoEventoRegistroDTO>) query.list();
				
		return lista;
	}




	public static ArrayList<RegistroEventiDTO> getListaEvento(int id_campione, int  tipo, Session session) {
		
		ArrayList<RegistroEventiDTO> lista = null;
		
		Query query = session.createQuery("from RegistroEventiDTO a where a.campione.id = :_id_campione and a.tipo_evento.id = :_tipo");
		query.setParameter("_tipo",tipo);
		query.setParameter("_id_campione",id_campione);
						
		lista = (ArrayList<RegistroEventiDTO>) query.list();
				
		return lista;
	}




	public static ArrayList<DocumentoCampioneDTO> getListaDocumentazioneTecnica(int id_campione, Session session) {
	
		ArrayList<DocumentoCampioneDTO> lista = null;
		
		Query query = session.createQuery("from DocumentoCampioneDTO where campione.id = :_id_campione and categoria.id = 1");
		query.setParameter("_id_campione", id_campione);
				
		lista = (ArrayList<DocumentoCampioneDTO>) query.list();
				
		return lista;
	}




	public static ArrayList<RegistroEventiDTO> getListaManutenzioni() {

		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		ArrayList<RegistroEventiDTO> lista = null;
		
		Query query = session.createQuery("from RegistroEventiDTO where tipo_evento.id = 1 and campione.statoCampione != 'F'");
		
				
		lista = (ArrayList<RegistroEventiDTO>) query.list();
		session.close();
				
		return lista;
	}



	
	public static JsonArray getCampioniScadenzaDate(String data_start, String data_end, boolean lat, int id_company, int verificazione) throws Exception {

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Session session = SessionFacotryDAO.get().openSession();
		    
		session.beginTransaction();

		ArrayList<AcAttivitaCampioneDTO> attivita = null;
		ArrayList<RegistroEventiDTO> registro = null;
			
		ArrayList<CampioneDTO> lista = new ArrayList<CampioneDTO>();			
		ArrayList<Integer> lista_tipo = new ArrayList<Integer>();
		ArrayList<String> lista_date = new ArrayList<String>();
		JsonArray list = new JsonArray();
			
		Query query = null;
			
		if(lat) {
			
			
			query = session.createQuery("from CampioneDTO WHERE data_scadenza between :_date_start and :_date_end and id_Company=:_id_company and statoCampione != 'F' and codice LIKE  '%CDT%' ");
			query.setParameter("_date_start", df.parse(data_start));
			query.setParameter("_date_end", df.parse(data_end));
			query.setParameter("_id_company", id_company);	
			
			lista = (ArrayList<CampioneDTO>) query.list();				
			
			for (CampioneDTO campioneDTO : lista) {
				lista_tipo.add(3);
				lista_date.add(df.format(campioneDTO.getDataScadenza()));
			}

				
			query = session.createQuery("from AcAttivitaCampioneDTO where tipo_attivita.id != 3 and (data_scadenza=null or data_scadenza between :_date_start and :_date_end) and disabilitata = 0");	
			query.setParameter("_date_start", df.parse(data_start));
			query.setParameter("_date_end", df.parse(data_end));
				
			attivita = (ArrayList<AcAttivitaCampioneDTO>) query.list();
				
			if(attivita!=null) {
				for (AcAttivitaCampioneDTO a : attivita) {
					if(a.getTipo_attivita().getId()==2) {
						lista.add(a.getCampione());	
						lista_tipo.add(a.getTipo_attivita().getId());
						lista_date.add(df.format(a.getData_scadenza()));
							
					}else {
						if(a.getCampione().getFrequenza_manutenzione()!=0) {	
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(a.getData());
						calendar.add(Calendar.MONTH, a.getCampione().getFrequenza_manutenzione());
							
						Date date = calendar.getTime();
						if(date.after(df.parse(data_start)) && date.before(df.parse(data_end))) {
							lista.add(a.getCampione());
							lista_tipo.add(1);
							lista_date.add(df.format(date));
						}
							
					}
				}
						
				}
			}
			
		}else {
			
//			if(verificazione!=0) {
//				query = session.createQuery("from CampioneDTO WHERE data_scadenza between :_date_start and :_date_end and id_Company=:_id_company and statoCampione != 'F' and codice NOT LIKE  '%CDT%' and campione_verificazione = :_verificazione");	
//			}else {
//				query = session.createQuery("from CampioneDTO WHERE data_scadenza between :_date_start and :_date_end and id_Company=:_id_company and statoCampione != 'F' and codice NOT LIKE  '%CDT%'");
//			}
//			
//			query.setParameter("_date_start", df.parse(data_start));
//			query.setParameter("_date_end", df.parse(data_end));
//			query.setParameter("_id_company", id_company);		
//			if(verificazione!=0) {
//				query.setParameter("_verificazione", verificazione);	
//			}
//				
//				
//			lista = (ArrayList<CampioneDTO>) query.list();				
//				
//			for (CampioneDTO campioneDTO : lista) {
//				lista_tipo.add(3);
//				lista_date.add(df.format(campioneDTO.getDataScadenza()));
//			}

				
			Query query_reg =	null;
			
			if(verificazione!=0) {
				query_reg = session.createQuery("from RegistroEventiDTO where  campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N')  and campione.campione_verificazione = :_verificazione");
				query_reg.setParameter("_verificazione", verificazione);
			}else {
				query_reg = session.createQuery("from RegistroEventiDTO where  campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N')");
			}
			
			
				
			registro = (ArrayList<RegistroEventiDTO>) query_reg.list();
				
			if(registro!=null) {
				for (RegistroEventiDTO r : registro) {
					if(r.getTipo_evento().getId()== 1 && r.getCampione().getFrequenza_manutenzione()!=0) {						
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(r.getData_evento());
						calendar.add(Calendar.MONTH, r.getCampione().getFrequenza_manutenzione());
							
						Date date = calendar.getTime();
						if(df.format(date).equals(data_start) || ( date.after(df.parse(data_start)) && date.before(df.parse(data_end)))) {
							lista.add(r.getCampione());
							lista_tipo.add(1);
							lista_date.add(df.format(date));
								
						}
					}else {
						if(r.getData_scadenza()!=null && (df.format(r.getData_scadenza()).equals(data_start) || ( r.getData_scadenza().after(df.parse(data_start)) && r.getData_scadenza().before(df.parse(data_end))))) {
							lista.add(r.getCampione());
							lista_tipo.add(r.getTipo_evento().getId());
							lista_date.add(df.format(r.getData_scadenza()));
								
						}
					}
				}
			}
		}	
			
		Gson gson = new Gson(); 
		      
		JsonElement obj = gson.toJsonTree(lista);
		JsonElement obj_tipo = gson.toJsonTree(lista_tipo);
		JsonElement obj_date = gson.toJsonTree(lista_date);
			
		list.add(obj);
		list.add(obj_tipo);
		list.add(obj_date);
		session.close();
			
		return list;		
	}




//	public static String[] getProgressivoCampione() {
//		
//		int prog_sti = 0;
//		int prog_cdt = 0;
//		//int prog_sti_slash = 0;
//		//int prog_cdt_slash = 0;
//		
//		String[] ret =  new String[2];
//		
//		Session session = SessionFacotryDAO.get().openSession();
//	    
//		session.beginTransaction();
//		
//				
//		Query query = session.createQuery("select codice from CampioneDTO where codice like '%STI%' ");
//			
//		List<String> result = (List<String>)query.list();
//				
//		int max = 0;
//		int max_slash = 0;
//		if(result.size()>0) {
//			for (String s : result) {
//				if(s!=null && org.apache.commons.lang3.StringUtils.isNumeric(s.split("STI")[1])  && Integer.parseInt(s.split("STI")[1])>max) {
//					max = Integer.parseInt(s.split("STI")[1]);
//				}
//			}
//		}
//		
//		prog_sti = max;
//		//prog_sti_slash = max_slash;
//		
//		query = session.createQuery("select codice from CampioneDTO where codice like '%CDT%' ");
//		
//		result = (List<String>)query.list();
//				
//		max = 0;
//		max_slash = 0;
//		if(result.size()>0) {
//			for (String s : result) {
//				if(s!=null && org.apache.commons.lang3.StringUtils.isNumeric(s.split("CDT")[1]) && Integer.parseInt(s.split("CDT")[1])>max) {
//					max = Integer.parseInt(s.split("CDT")[1]);
//				}
//			}
//		}
//		
//		
//		prog_cdt = max;
//		//prog_cdt_slash = max_slash;
//		
//		
//		ret[0] = String.valueOf(prog_sti);
//		ret[1] = String.valueOf(prog_cdt);
//		//ret[2] = String.valueOf(prog_sti_slash);
//		//ret[3] = String.valueOf(prog_cdt_slash);
//		session.close();
//		return ret;
//	}

	
	
public static Integer[] getProgressivoCampione() {
		
		int prog_sti = 0;
		int prog_cdt = 0;
		
		Integer[] ret =  new Integer[2];
		
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
				
		Query query = session.createQuery("select seq_sti_campione from SequenceDTO");
			
		List<Integer> result = (List<Integer>)query.list();
				
		if(result.size()>0) {
			prog_sti = result.get(0);
		}
		
		
		query = session.createQuery("select seq_cdt_campione from SequenceDTO");
		
		result = (List<Integer>)query.list();
		
		if(result.size()>0) {
			prog_cdt = result.get(0);
		}
		
		ret[0] = prog_sti;
		ret[1] = prog_cdt;

		session.close();
		return ret;
	}




public static SequenceDTO getSequence(Session session) {
	
	List<SequenceDTO> list = null;
	SequenceDTO result = null;	
			
	Query query = session.createQuery("from SequenceDTO");
		
	list = (List<SequenceDTO>)query.list();
			
	if(list.size()>0) {
		result = list.get(0);
	}
	
	
	return result;
}




public static void updateManutenzioniObsolete(CampioneDTO campione, Session session) {

	Query query = session.createQuery("update RegistroEventiDTO set obsoleta='S' where id_campione =:_id_campione and tipo_evento=1 and tipo_manutenzione=1 ");
	
	query.setParameter("_id_campione", campione.getId());
	
	query.executeUpdate();
	
}


public static void updateTaratureObsolete(CampioneDTO campione, Session session) {

	Query query = session.createQuery("update RegistroEventiDTO set obsoleta='S' where id_campione =:_id_campione and tipo_evento=2  ");
	
	query.setParameter("_id_campione", campione.getId());
	
	query.executeUpdate();
	
}


public static ArrayList<RegistroEventiDTO> getListaManutenzioniNonObsolete(Session session, String verificazione) {
	
	session.beginTransaction();
	ArrayList<RegistroEventiDTO> lista = null;
	
	Query query = null;
	
	if(verificazione!=null) {
		query = session.createQuery("from RegistroEventiDTO where tipo_evento.id = 1 and campione.statoCampione != 'F' and campione.campione_verificazione = 1 and (obsoleta = null or obsoleta = 'N')");
	}else {
		query = session.createQuery("from RegistroEventiDTO where tipo_evento.id = 1 and campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N')");
	}
	
	
			
	lista = (ArrayList<RegistroEventiDTO>) query.list();

	return lista;
}




public static ArrayList<CampioneDTO> getListaCampioniInServizio(Session session, String verificazione) {
	

	ArrayList<CampioneDTO> lista = null;
	String q = "from CampioneDTO where stato_campione!='F' and codice not like '%CDT%'";
	
	
	if(verificazione!=null) {
		q += " and campione_verificazione = 1";
	}
	
	Query query = session.createQuery(q);
			
	lista = (ArrayList<CampioneDTO>) query.list();
	
			
	return lista;
}



public static void updateCampioneScheduler() {
	
	Session session = SessionFacotryDAO.get().openSession();
    
	session.beginTransaction();
	
	Query query = session.createQuery("select a.campione, a.data from AcAttivitaCampioneDTO a where a.campione.tipo_campione.id = 3 and a.tipo_attivita.id = 1 and a.campione.statoCampione!='F' and a.obsoleta!='S'");	

	List<Object[]> result = (List<Object[]>)query.list();

	if(result.size()>0 ) {		
	
		for (Object[] object : result) {
			CampioneDTO campione =  (CampioneDTO) object[0];
			Date data = (Date) object[1];
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(data);
			calendar.add(Calendar.MONTH, campione.getFrequenza_manutenzione());

			Date date = calendar.getTime();
			
			if(date.before(new Date())) {
				campione.setStatoCampione("N");
				session.update(campione);
			}
			
		}
	}
	
	query = session.createQuery("select a.campione, a.data_evento from RegistroEventiDTO a where a.campione.tipo_campione.id = 3 and (a.tipo_evento.id = 1 or a.tipo_evento.id = 5) and a.campione.statoCampione!='F'  and a.obsoleta!='S'");
	
	
	result = (List<Object[]>)query.list();

  
	if(result.size()>0 ) {		
	
		for (Object[] object : result) {
			CampioneDTO campione =  (CampioneDTO) object[0];
			Date data = (Date) object[1];
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(data);
			calendar.add(Calendar.MONTH, campione.getFrequenza_manutenzione());

			Date date = calendar.getTime();
			
			if(date.before(new Date())) {
				campione.setStatoCampione("N");
				session.update(campione);
			}
			
		}
	}

	session.getTransaction().commit();
	session.close();
			

}




public static ArrayList<RegistroEventiDTO> getListaEventiNonSti(Session session) {

	ArrayList<RegistroEventiDTO> lista = null;
	
	Query query = session.createQuery("from RegistroEventiDTO where campione.codice like '%NAS%' or campione.codice like '%TAB%' or campione.codice like '%TEC%'");
	
	
	 lista = (ArrayList<RegistroEventiDTO>) query.list();

	 return lista;
}




public static ArrayList<CampioneDTO> getListaCampioniVerificazione(Session session) {
	
	ArrayList<CampioneDTO> lista = null;
	
	Query query = session.createQuery("from CampioneDTO where campione_verificazione = 1");
	
	
	 lista = (ArrayList<CampioneDTO>) query.list();

	 return lista;
	
}
	
	
}



