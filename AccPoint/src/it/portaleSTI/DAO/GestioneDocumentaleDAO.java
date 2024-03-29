package it.portaleSTI.DAO;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Iterator;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumDocumentoDipendenteDTO;
import it.portaleSTI.DTO.DocumEmailDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DocumReferenteFornDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.DocumTLStatoDTO;
import it.portaleSTI.DTO.DocumTLStatoDipendenteDTO;
import it.portaleSTI.DTO.DocumTipoDocumentoDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;

public class GestioneDocumentaleDAO {

	public static ArrayList<DocumCommittenteDTO> getListaCommittenti(Session session) {
		
		ArrayList<DocumCommittenteDTO> lista = null;
		
		Query query = session.createQuery("from DocumCommittenteDTO");
		
		lista = (ArrayList<DocumCommittenteDTO>) query.list();
		
		return lista;
	}

	public static DocumCommittenteDTO getCommittenteFromID(int id_committente, Session session) {
		ArrayList<DocumCommittenteDTO> lista = null;
		DocumCommittenteDTO result = null;
		
		Query query = session.createQuery("from DocumCommittenteDTO where id=:_id");
		query.setParameter("_id", id_committente);
		
		lista = (ArrayList<DocumCommittenteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumFornitoreDTO> getListaDocumFornitori(Session session) {

		ArrayList<DocumFornitoreDTO> lista = null;
		
		Query query = session.createQuery("from DocumFornitoreDTO");
		
		lista = (ArrayList<DocumFornitoreDTO>) query.list();
		
		return lista;
	}

	public static DocumFornitoreDTO getFornitoreFromId(int id_fornitore, Session session) {
		
		ArrayList<DocumFornitoreDTO> lista = null;
		DocumFornitoreDTO result = null;
		
		Query query = session.createQuery("from DocumFornitoreDTO where id=:_id");
		query.setParameter("_id", id_fornitore);
		
		lista = (ArrayList<DocumFornitoreDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumReferenteFornDTO> getListaReferenti(int id_fornitore,int id_committente, Session session) {

		ArrayList<DocumReferenteFornDTO> lista = null;
		
		Query query = null;
		
		if(id_committente == 0) {
			if(id_fornitore==0) {
				query = session.createQuery("from DocumReferenteFornDTO");	
			}else {
				query = session.createQuery("from DocumReferenteFornDTO where id_fornitore =:_id_fornitore");
				query.setParameter("_id_fornitore", id_fornitore);
			}
		}else {
			if(id_fornitore==0) {
				query = session.createQuery("from DocumReferenteFornDTO where committente.id = :_id_committente");	
			}else {
				query = session.createQuery("from DocumReferenteFornDTO where id_fornitore =:_id_fornitore and committente.id = :_id_committente");
				query.setParameter("_id_fornitore", id_fornitore);
			}
			query.setParameter("_id_committente", id_committente);
		}
		
		
		lista = (ArrayList<DocumReferenteFornDTO>) query.list();
		
		return lista;
	}

	public static DocumReferenteFornDTO getReferenteFromId(int id_referente, Session session) {

		ArrayList<DocumReferenteFornDTO> lista = null;
		DocumReferenteFornDTO result = null;
		
		Query query = session.createQuery("from DocumReferenteFornDTO where id=:_id");
		query.setParameter("_id", id_referente);
		
		lista = (ArrayList<DocumReferenteFornDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumDipendenteFornDTO> getListaDipendenti(int id_committente, int id_fornitore, Session session) {
	
		ArrayList<DocumDipendenteFornDTO> lista = null;
		
		Query query = null;
		
		if(id_fornitore==0 && id_committente == 0) {
			query = session.createQuery("from DocumDipendenteFornDTO"); 
		}
		else if(id_committente == 0) {
			query = session.createQuery("from DocumDipendenteFornDTO where id_fornitore =:_id_fornitore");
			query.setParameter("_id_fornitore", id_fornitore);
		}
		else if(id_committente!= 0 && id_fornitore == 0) {
			query = session.createQuery("from DocumDipendenteFornDTO where id_committente =:_id_committente");			
			query.setParameter("_id_committente", id_committente);
			
		}else {
			query = session.createQuery("from DocumDipendenteFornDTO where id_committente =:_id_committente and id_fornitore =:_id_fornitore");
			query.setParameter("_id_fornitore", id_fornitore);
			query.setParameter("_id_committente", id_committente);
		}
		
		
		lista = (ArrayList<DocumDipendenteFornDTO>) query.list();
		
		return lista;
	}
	
	public static DocumDipendenteFornDTO getDipendenteFromId(int id_dipendente, Session session) {

		ArrayList<DocumDipendenteFornDTO> lista = null;
		DocumDipendenteFornDTO result = null;
		
		Query query = session.createQuery("from DocumDipendenteFornDTO where id=:_id");
		query.setParameter("_id", id_dipendente);
		
		lista = (ArrayList<DocumDipendenteFornDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumenti(String data_scadenza, int id_fornitore,int  id_committente,  Session session) throws Exception, ParseException {

		ArrayList<DocumTLDocumentoDTO> lista = null;
		
		Query query = null;
		
		if(id_committente == 0) {
			
			if(data_scadenza==null && id_fornitore == 0) {
				query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0 and stato.id != 4 and obsoleto = 0" );
			}
			else if(data_scadenza==null && id_fornitore!=0) {
				
				query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0 and id_fornitore = :_id_fornitore and stato.id != 4 and obsoleto = 0");
				query.setParameter("_id_fornitore", id_fornitore);
				
				
			}
			else if(data_scadenza != null && id_fornitore == 0){
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				query = session.createQuery("from DocumTLDocumentoDTO where data_scadenza = :_data and disabilitato = 0 and stato.id != 4 and obsoleto = 0");
				query.setParameter("_data", sdf.parse(data_scadenza));
			}
			else if(data_scadenza != null && id_fornitore != 0){
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				query = session.createQuery("from DocumTLDocumentoDTO where data_scadenza = :_data and id_fornitore = :_id_fornitore and disabilitato = 0 and stato.id != 4 and obsoleto = 0" );
				query.setParameter("_data", sdf.parse(data_scadenza));
				query.setParameter("_id_fornitore", id_fornitore);
			}
			
			
		}else {
			if(data_scadenza==null && id_fornitore == 0) {
				query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0 and stato.id != 4 and obsoleto = 0 and committente.id = :_committente" );
			}
			else if(data_scadenza==null && id_fornitore!=0) {
				
				query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0 and id_fornitore = :_id_fornitore and stato.id != 4 and obsoleto = 0 and committente.id = :_committente");
				query.setParameter("_id_fornitore", id_fornitore);
				
				
			}
			else if(data_scadenza != null && id_fornitore == 0){
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				query = session.createQuery("from DocumTLDocumentoDTO where data_scadenza = :_data and disabilitato = 0 and stato.id != 4 and obsoleto = 0 and committente.id = :_committente");
				query.setParameter("_data", sdf.parse(data_scadenza));
			}
			else if(data_scadenza != null && id_fornitore != 0){
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				query = session.createQuery("from DocumTLDocumentoDTO where data_scadenza = :_data and id_fornitore = :_id_fornitore and disabilitato = 0 and stato.id != 4 and obsoleto = 0 and committente.id = :_committente" );
				query.setParameter("_data", sdf.parse(data_scadenza));
				query.setParameter("_id_fornitore", id_fornitore);
			}
			
			query.setParameter("_committente", id_committente);
			
		}
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		return lista;
	}

	
	
	
	
	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiScadenzario(String data_start,String data_end, int id_fornitore,int  id_committente,  Session session) throws Exception, ParseException {

		ArrayList<DocumTLDocumentoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String queryStr ="from DocumTLDocumentoDTO where data_scadenza between :_data_start and :_data_end and disabilitato = 0 and stato.id != 4 and obsoleto = 0";

		if(id_committente!=0) {

			queryStr += " and committente.id = :_committente";
		}
		
		if(id_fornitore!=0) {
			
			queryStr += " and id_fornitore = :_fornitore";
		}
		
		Query query = session.createQuery(queryStr);
		query.setParameter("_data_start", sdf.parse(data_start));
		query.setParameter("_data_end", sdf.parse(data_end));
		
		if(id_committente!=0) {
			query.setParameter("_committente", id_committente);
		}
		if(id_fornitore!=0) {
			query.setParameter("_fornitore", id_fornitore);
		}	

		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		return lista;
	}
	
	
	
	
	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiDaApprovare(String data_scadenza, int id_fornitore, Session session) throws Exception, ParseException {
		
ArrayList<DocumTLDocumentoDTO> lista = null;
		
		Query query = null;
		
		if(data_scadenza==null && id_fornitore == 0) {
			query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0 and stato.id = 4 and obsoleto = 0");
		}
		else if(data_scadenza==null && id_fornitore!=0) {
			
			query = session.createQuery("from DocumTLDocumentoDTO where disabilitato = 0 and id_fornitore = :_id_fornitore and stato.id = 4 and obsoleto = 0");
			query.setParameter("_id_fornitore", id_fornitore);
			
			
		}
		else if(data_scadenza != null && id_fornitore == 0){
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			query = session.createQuery("from DocumTLDocumentoDTO where data_scadenza = :_data and disabilitato = 0 and stato.id = 4 and obsoleto = 0");
			query.setParameter("_data", sdf.parse(data_scadenza));
		}
		else if(data_scadenza != null && id_fornitore != 0){
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			query = session.createQuery("from DocumTLDocumentoDTO where data_scadenza = :_data and id_fornitore = :_id_fornitore and disabilitato = 0 and stato.id = 4 and obsoleto = 0" );
			query.setParameter("_data", sdf.parse(data_scadenza));
			query.setParameter("_id_fornitore", id_fornitore);
		}
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		return lista;
		
	}
	
	
	public static DocumTLDocumentoDTO getDocumentoFromId(int id_documento, Session session) {
		
		ArrayList<DocumTLDocumentoDTO> lista = null;
		DocumTLDocumentoDTO result = null;
		
		Query query = session.createQuery("from DocumTLDocumentoDTO where id=:_id");
		query.setParameter("_id", id_documento);
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static HashMap<String, Integer> getDocumentiScadenza(int id_fornitore, int id_committente, Session session) {


		HashMap<String, Integer> mapScadenze = new HashMap<String, Integer>();
		
		List<DocumTLDocumentoDTO> lista =null;
		Query query = null;
		
		if(id_committente == 0) {
			if(id_fornitore==0) {
				
				query =  session.createQuery( "from DocumTLDocumentoDTO where disabilitato = 0 and stato.id != 4 and obsoleto = 0");	
				
			}else {
				
				query =  session.createQuery( "from DocumTLDocumentoDTO where id_fornitore = :_id_fornitore and disabilitato = 0 and stato.id != 4 and obsoleto = 0");
				query.setParameter("_id_fornitore", id_fornitore);
			}
		}else {
			if(id_fornitore==0) {
				
				query =  session.createQuery( "from DocumTLDocumentoDTO where disabilitato = 0 and stato.id != 4 and obsoleto = 0 and id_committente =:_id_committente");	
				
			}else {
				
				query =  session.createQuery( "from DocumTLDocumentoDTO where id_fornitore = :_id_fornitore and disabilitato = 0 and stato.id != 4 and obsoleto = 0 and id_committente =:_id_committente");
				query.setParameter("_id_fornitore", id_fornitore);
			}
			query.setParameter("_id_committente", id_committente);
		}
		
			
		lista=query.list();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (DocumTLDocumentoDTO documento: lista) {
			if(documento.getData_scadenza()!=null) {
				
				int i=1;
				if(mapScadenze.get(sdf.format(documento.getData_scadenza()))!=null) {
					i= mapScadenze.get(sdf.format(documento.getData_scadenza()))+1;
				}
				
				mapScadenze.put(sdf.format(documento.getData_scadenza()), i);	
			}
		}	

		return mapScadenze;
	}

	public static ArrayList<DocumEmailDTO> getStoricoEmail(int id_documento, Session session) {

		ArrayList<DocumEmailDTO> lista_email = null;
		
		Query query = session.createQuery("from DocumEmailDTO where documento.id = :_id_documento");
		query.setParameter("_id_documento", id_documento);
		
		lista_email = (ArrayList<DocumEmailDTO>) query.list();
		
		return lista_email;
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiDaAssociare(int id_committente, int id_fornitore, Session session) {

		ArrayList<DocumTLDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from DocumTLDocumentoDTO where committente.id = :_id_committente and fornitore.id = :_id_fornitore and obsoleto = 0 and disabilitato = 0 and stato.id != 4");
		query.setParameter("_id_committente", id_committente);
		query.setParameter("_id_fornitore", id_fornitore);
		
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		return lista;

	}

	public static void AggiornamentoStatoDocumenti() throws HibernateException, ParseException {
		
 		Session session = SessionFacotryDAO.get().openSession();	    
		session.beginTransaction();
				
		ArrayList<DocumTLDocumentoDTO>lista_documenti = null;
		
		Query query = session.createQuery("from DocumTLDocumentoDTO WHERE data_scadenza < CURDATE() and stato.id !=4 and obsoleto = 0 and disabilitato = 0");
		lista_documenti = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		for (DocumTLDocumentoDTO documento : lista_documenti) {
			documento.setStato(new DocumTLStatoDTO(3, ""));
			session.update(documento);
			
			Iterator<DocumDipendenteFornDTO> iterator = documento.getListaDipendenti().iterator();
			
			while(iterator.hasNext()) {
				DocumDipendenteFornDTO dipendente = iterator.next();
				dipendente.setStato(new DocumTLStatoDipendenteDTO(3,""));
				session.update(dipendente);
			}
			
		}
		
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 10);
		Date nextDate = cal.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		query = session.createQuery("from DocumTLDocumentoDTO WHERE data_scadenza <= :_scadenza and stato.id !=4 and stato.id !=3 and obsoleto = 0 and disabilitato = 0");
		query.setParameter("_scadenza", df.parse(df.format(nextDate)));
		
		lista_documenti = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		for (DocumTLDocumentoDTO documento : lista_documenti) {
			documento.setStato(new DocumTLStatoDTO(6, ""));
			session.update(documento);
			
			Iterator<DocumDipendenteFornDTO> iterator = documento.getListaDipendenti().iterator();
			
			while(iterator.hasNext()) {
				DocumDipendenteFornDTO dipendente = iterator.next();
				dipendente.setStato(new DocumTLStatoDipendenteDTO(4,""));
				session.update(dipendente);
			}
			
		}	
		
		
		
		session.getTransaction().commit();
		session.close();
		
	}

	public static ArrayList<DocumTLDocumentoDTO> getDocumentiObsoleti(Session session) {

		ArrayList<DocumTLDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from DocumTLDocumentoDTO where obsoleto = 1");		
		
		lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		
		return lista;
	}

	public static DocumCommittenteDTO getCommittenteFromIDClienteSede(int idCliente, int idSede, Session session) {

		ArrayList<DocumCommittenteDTO> lista = null;
		DocumCommittenteDTO result = null;
		
		Query query = session.createQuery("from DocumCommittenteDTO where id_cliente =:_id_cliente and id_sede = :_id_sede");	
		query.setParameter("_id_cliente", idCliente);
		query.setParameter("_id_sede", idSede);
		
		lista = (ArrayList<DocumCommittenteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;	
	}

	public static ArrayList<DocumTipoDocumentoDTO> getListaTipoDocumento(Session session) {
		
		ArrayList<DocumTipoDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from DocumTipoDocumentoDTO where disabilitato = 0");	

		
		lista = (ArrayList<DocumTipoDocumentoDTO>) query.list();
		
		return lista;	
	}

	public static DocumTipoDocumentoDTO getTipoDocumentoFromId(int id_tipo, Session session) {
		
		ArrayList<DocumTipoDocumentoDTO> lista = null;
		DocumTipoDocumentoDTO result = null;
		
		Query query = session.createQuery("from DocumTipoDocumentoDTO where id =:_id_tipo");	
		query.setParameter("_id_tipo", id_tipo);
		
		lista = (ArrayList<DocumTipoDocumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;	
	}

	public static ArrayList<DocumDocumentoDipendenteDTO> getDocumentiScadenzarioDipendenti(String dateFrom, String dateTo, int id_fornitore, int id_committente, Session session) throws Exception, ParseException {
		
		ArrayList<DocumDocumentoDipendenteDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String queryStr ="from DocumDocumentoDipendenteDTO d where d.documento.data_scadenza between :_data_start and :_data_end and d.documento.disabilitato = 0 and d.documento.stato.id != 4 and d.documento.obsoleto = 0";

		if(id_committente!=0) {

			queryStr += " and d.documento.committente.id = :_committente";
		}
		
		if(id_fornitore!=0) {
			
			queryStr += " and d.documento.fornitore.id = :_fornitore";
		}
		
		Query query = session.createQuery(queryStr);
		query.setParameter("_data_start", sdf.parse(dateFrom));
		query.setParameter("_data_end", sdf.parse(dateTo));
		
		if(id_committente!=0) {
			query.setParameter("_committente", id_committente);
		}
		if(id_fornitore!=0) {
			query.setParameter("_fornitore", id_fornitore);
		}	

		
		lista = (ArrayList<DocumDocumentoDipendenteDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DocumTLDocumentoDTO> getListaDocumentiStato(int id_stato, Session session) {
		
		 ArrayList<DocumTLDocumentoDTO> lista = null;
		
		 boolean sessionNull = false;
		 if(session==null) {
			 
			 session = 	SessionFacotryDAO.get().openSession();	    
			 session.beginTransaction();
			 sessionNull = true;
		 }
		
		 Query query = session.createQuery("from DocumTLDocumentoDTO where stato.id = :_id_stato");
		 query.setParameter("_id_stato", id_stato);
		 
		 lista = (ArrayList<DocumTLDocumentoDTO>) query.list();
		 if(sessionNull) {
			 
			 session.getTransaction().commit();
			 session.close();
		 }

		return lista;
	}
}
