package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForCorsoMoodleDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForEmailDTO;
import it.portaleSTI.DTO.ForGruppoMoodleDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.ForPiaStatoDTO;
import it.portaleSTI.DTO.ForPiaTipoDTO;
import it.portaleSTI.DTO.ForQuestionarioDTO;
import it.portaleSTI.DTO.ForReferenteDTO;
import it.portaleSTI.DTO.ForRuoloDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneFormazioneDAO {

	public static ArrayList<ForDocenteDTO> getListaDocenti(Session session) {
		
		ArrayList<ForDocenteDTO> lista = null;
		
		Query query = session.createQuery("from ForDocenteDTO");
		
		lista = (ArrayList<ForDocenteDTO>) query.list();
		
		return lista;
	}

	public static ForDocenteDTO getDocenteFromId(int id_docente, Session session) {
		
		ArrayList<ForDocenteDTO> lista = null;
		ForDocenteDTO result = null;
		
		Query query = session.createQuery("from ForDocenteDTO where id = :_id_docente");
		query.setParameter("_id_docente", id_docente);
		
		lista = (ArrayList<ForDocenteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForCorsoCatDTO> getListaCategorieCorsi(Session session) {
		
		ArrayList<ForCorsoCatDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoCatDTO");
		
		lista = (ArrayList<ForCorsoCatDTO>) query.list();
		
		return lista;
	}

	public static ForCorsoCatDTO getCategoriaCorsoFromId(int id_categoria, Session session) {
		
		ArrayList<ForCorsoCatDTO> lista = null;
		ForCorsoCatDTO result = null;
		
		Query query = session.createQuery("from ForCorsoCatDTO where id = :_id_categoria");
		query.setParameter("_id_categoria", id_categoria);
		
		lista = (ArrayList<ForCorsoCatDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsi(Session session) {
		
		ArrayList<ForCorsoDTO> lista = null;
				
		Query query = session.createQuery("from ForCorsoDTO where disabilitato = 0");
				
		lista = (ArrayList<ForCorsoDTO>) query.list();		
			
		return lista;
	}

	public static ForCorsoDTO getCorsoFromId(int id_corso, Session session) {

		ArrayList<ForCorsoDTO> lista = null;
		ForCorsoDTO result = null;
		
		Query query = session.createQuery("from ForCorsoDTO where id = :_id_corso");
		query.setParameter("_id_corso", id_corso);
		
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}


	public static ArrayList<ForCorsoAllegatiDTO>  getAllegatiCorso(int id_corso, Session session) {
		
		ArrayList<ForCorsoAllegatiDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoAllegatiDTO where corso.id = :_id_corso");
		query.setParameter("_id_corso", id_corso);
				
		lista = (ArrayList<ForCorsoAllegatiDTO>) query.list();		
			
		return lista;
	}

	public static ArrayList<ForCorsoCatAllegatiDTO> getAllegatiCategoria(int id_categoria, Session session) {

		ArrayList<ForCorsoCatAllegatiDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoCatAllegatiDTO where corso.id = :_id_categoria");
		query.setParameter("_id_categoria", id_categoria);
				
		lista = (ArrayList<ForCorsoCatAllegatiDTO>) query.list();		
			
		return lista;
	}

	public static ForCorsoAllegatiDTO getAllegatoCorsoFormId(int id_allegato, Session session) {

		ArrayList<ForCorsoAllegatiDTO> lista = null;
		ForCorsoAllegatiDTO result = null;
		
		Query query = session.createQuery("from ForCorsoAllegatiDTO where id = :_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<ForCorsoAllegatiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}
	
	public static ForCorsoCatAllegatiDTO getAllegatoCategoriaFormId(int id_allegato, Session session) {

		ArrayList<ForCorsoCatAllegatiDTO> lista = null;
		ForCorsoCatAllegatiDTO result = null;
		
		Query query = session.createQuery("from ForCorsoCatAllegatiDTO where id = :_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<ForCorsoCatAllegatiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForPartecipanteDTO> getListaPartecipanti(Session session) {
		
		ArrayList<ForPartecipanteDTO> lista = null;
		
		Query query = session.createQuery("from ForPartecipanteDTO");
				
		lista = (ArrayList<ForPartecipanteDTO>) query.list();
					
		return lista;
	}
	
	
	

	public static ForPartecipanteDTO getPartecipanteFromId(int id_partecipante, Session session) {
		
		ArrayList<ForPartecipanteDTO> lista = null;
		ForPartecipanteDTO result = null;
		
		Query query = session.createQuery("from ForPartecipanteDTO where id = :_id_partecipante");
		query.setParameter("_id_partecipante", id_partecipante);
		
		lista = (ArrayList<ForPartecipanteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForRuoloDTO> getListaRuoli(Session session) {

		ArrayList<ForRuoloDTO> lista = null;
		
		Query query = session.createQuery("from ForRuoloDTO");
				
		lista = (ArrayList<ForRuoloDTO>) query.list();
					
		return lista;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorso(int id_corso, Session session) {

		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO where corso.id = :_id_corso");
		query.setParameter("_id_corso", id_corso);
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
		
		return lista;
	}

	public static ForPartecipanteRuoloCorsoDTO getPartecipanteFromCorso(int id_corso, int id_partecipante,int id_ruolo, Session session) {
		
		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		ForPartecipanteRuoloCorsoDTO result = null;
		
		Query query = null;
		if(id_ruolo!=0) {
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO where partecipante.id = :_id_partecipante and corso.id = :_id_corso and ruolo.id = :_id_ruolo");
			
			query.setParameter("_id_ruolo", id_ruolo);
		}else {
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO where partecipante.id = :_id_partecipante and corso.id = :_id_corso");
		}
		query.setParameter("_id_partecipante", id_partecipante);
		query.setParameter("_id_corso", id_corso);
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaCorsiFromPartecipante(int id_partecipante, Session session) {

		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
				
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id = :_id_partecipante and p.corso.disabilitato = 0");
		query.setParameter("_id_partecipante", id_partecipante);		
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static HashMap<String, Integer> getListaScadenzeCorsi(int id_partecipante, Session session) {

		Query query=null;
		
		HashMap<String, Integer> mapScadenze = new HashMap<String, Integer>();
				
		List<ForCorsoDTO> lista =null;
		
		query  = session.createQuery( "select p.corso from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id = :_id_partecipante and p.corso.disabilitato = 0");	
		query.setParameter("_id_partecipante", id_partecipante);
		
		lista=query.list();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (ForCorsoDTO corso: lista) {
			
			int i=1;
			if(mapScadenze.get(sdf.format(corso.getData_scadenza()))!=null) {					
						
				i= mapScadenze.get(sdf.format(corso.getData_scadenza()))+1;
			}
					
			mapScadenze.put(sdf.format(corso.getData_scadenza()), i);
							
		}
		
		return mapScadenze;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiPartecipanteScadenza(int id_partecipante, String data_scadenza, Session session) throws Exception {		
		
		ArrayList<ForCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = session.createQuery("select p.corso from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id = :_id_partecipante and p.corso.data_scadenza = :_data_scadenza and p.corso.disabilitato = 0");
		query.setParameter("_id_partecipante", id_partecipante);
		query.setParameter("_data_scadenza", sdf.parse(data_scadenza));		
		
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
				
		return lista;
		
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorso(String dateFrom, String dateTo, String tipo_data,String id_azienda, String id_sede,  Session session) throws Exception {
		
		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = null;
		
		if(dateFrom !=null && dateTo!=null && tipo_data!=null) {
			
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso."+tipo_data+" between :_dateFrom and :_dateTo and p.corso.disabilitato = 0");	
			query.setParameter("_dateFrom", sdf.parse(dateFrom));
			query.setParameter("_dateTo", sdf.parse(dateTo));
			
		}else {
			
			if(id_azienda!=null && !id_azienda.equals("0")) {
				query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso.disabilitato = 0 and p.partecipante.id_azienda = :_id_azienda and p.partecipante.id_sede = :_id_sede");
				query.setParameter("_id_azienda", Integer.parseInt(id_azienda));
				query.setParameter("_id_sede", Integer.parseInt(id_sede));
			}else {
				query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso.disabilitato = 0"); 	
			}
			
			
		}				
			
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<ForPartecipanteDTO> getListaPartecipantiCliente(int idCliente, int idSede, Session session) {

		ArrayList<ForPartecipanteDTO> lista = null;		

		Query query =  session.createQuery("from ForPartecipanteDTO where id_azienda =:_id_cliente and id_sede = :_id_sede"); 
		query.setParameter("_id_cliente", idCliente);	
		query.setParameter("_id_sede", idSede);
			
		lista = (ArrayList<ForPartecipanteDTO>) query.list();		
				
		return lista;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiCliente(int idCliente, int idSede, Session session) {

		ArrayList<ForCorsoDTO> lista = null;		

		Query query =  session.createQuery("select distinct corso from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id_azienda =:_id_cliente and p.partecipante.id_sede = :_id_sede and visibile='1' and disabilitato = 0"); 
		query.setParameter("_id_cliente", idCliente);	
		query.setParameter("_id_sede", idSede);
			
		lista = (ArrayList<ForCorsoDTO>) query.list();		
				
		return lista;
		
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorsoCliente(String dateFrom, String dateTo, String tipo_data, int idCliente, int idSede, Session session) throws Exception, ParseException {

	ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = null;
		
		if(dateFrom !=null && dateTo!=null && tipo_data!=null) {
			
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso."+tipo_data+" between :_dateFrom and :_dateTo and p.partecipante.id_azienda =:_id_cliente and p.partecipante.id_sede =:_id_sede and p.corso.disabilitato = 0 and p.corso.visibile = 1");	
			query.setParameter("_dateFrom", sdf.parse(dateFrom));
			query.setParameter("_dateTo", sdf.parse(dateTo));
			
		}else {
			
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where  p.partecipante.id_azienda =:_id_cliente and p.partecipante.id_sede =:_id_sede and p.corso.disabilitato = 0  and p.corso.visibile = 1"); 
			
		}		
		query.setParameter("_id_cliente", idCliente);	
		query.setParameter("_id_sede", idSede);
			
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorsoCliente(int id_corso, int idCliente, int idSede, Session session) {

		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso.id = :_id_corso and p.partecipante.id_azienda =:_id_cliente and p.partecipante.id_sede =:_id_sede and p.corso.disabilitato = 0");
		query.setParameter("_id_corso", id_corso);
		query.setParameter("_id_cliente", idCliente);	
		query.setParameter("_id_sede", idSede);
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<String> getListaCodiciFiscali(Session session) {
		
		ArrayList<String> lista = null;		
		
		Query query = session.createQuery("select cf from ForPartecipanteDTO");

		
		lista = (ArrayList<String>) query.list();
		
		
		return lista;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaCorsiConsuntivo(String dateFrom, String dateTo, int id_cliente, int id_sede, Session session) throws Exception {
	
	ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	Query query = null;
	
	if(id_cliente!=0) {
		query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id_azienda = :_id_cliente and p.partecipante.id_sede = :_id_sede and p.corso.data_corso between :_dateFrom and :_dateTo and  p.corso.disabilitato = 0 and p.corso.visibile = 1 group by p.corso");
		query.setParameter("_id_cliente", id_cliente);
		query.setParameter("_id_sede", id_sede);
	}else {
		query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso.data_corso between :_dateFrom and :_dateTo and  p.corso.disabilitato = 0 group by p.corso"); 
	}			
				
	query.setParameter("_dateFrom", sdf.parse(dateFrom));
	query.setParameter("_dateTo", sdf.parse(dateTo));
		
		
	lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
	
			
	return lista;
}

	public static ForQuestionarioDTO GestioneFormazioneDAO(int id_questionario, Session session) {

		ArrayList<ForQuestionarioDTO> lista = null;
		ForQuestionarioDTO result = null;

		Query query =  session.createQuery("from ForQuestionarioDTO where id = :_id");	
		query.setParameter("_id", id_questionario);
		
		lista = (ArrayList<ForQuestionarioDTO>) query.list();
		
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
		
	}

	public static ArrayList<String> getListaAziendeConPartecipanti(Session session) {

		ArrayList<Object[]> res = null;
		ArrayList<String> lista = new ArrayList<String>();

		Query query =  session.createQuery("select distinct id_azienda, nome_azienda,id_sede, nome_sede from ForPartecipanteDTO");	

		
		res = (ArrayList<Object[]>) query.list();
		
		for (Object[] objects : res) {
		
		String azienda = null;	
			if(objects[0]!=null && objects[1]!=null) {
				 azienda =  objects[0]+"!"+objects[1]+"!"+objects[2]+"!"+objects[3];	
				 lista.add(azienda);
			}

		}

		return lista;
	}

	public static ForPartecipanteDTO getPartecipanteFromCf(String cf, Session session) {
		
		ForPartecipanteDTO res = null;
		ArrayList<ForPartecipanteDTO> lista = new ArrayList<ForPartecipanteDTO>();

		Query query =  session.createQuery("from ForPartecipanteDTO where cf = :_cf");	
		query.setParameter("_cf", cf);
		
		lista = (ArrayList<ForPartecipanteDTO>) query.list();
		
		if(lista.size()>0) {
			res = lista.get(0);
		}

		return res;
	}

	public static ForRuoloDTO getRuoloFromId(int id_ruolo, Session session) {

		ForRuoloDTO res = null;
		ArrayList<ForRuoloDTO> lista = new ArrayList<ForRuoloDTO>();

		Query query =  session.createQuery("from ForRuoloDTO where id = :_id");	
		query.setParameter("_id", id_ruolo);
		
		lista = (ArrayList<ForRuoloDTO>) query.list();
		
		if(lista.size()>0) {
			res = lista.get(0);
		}

		return res;
	}

	public static ArrayList<ForReferenteDTO> getListaReferenti(Session session) {

		ArrayList<ForReferenteDTO> lista = null;

		Query query =  session.createQuery("from ForReferenteDTO");	

		
		lista = (ArrayList<ForReferenteDTO>) query.list();
		
		return lista;
	}

	public static ForReferenteDTO getReferenteFromID(int id_referente, Session session) {

		ArrayList<ForReferenteDTO> lista = null;
		ForReferenteDTO res = null;

		Query query =  session.createQuery("from ForReferenteDTO where id = :_id_referente");
		query.setParameter("_id_referente", id_referente);

		
		lista = (ArrayList<ForReferenteDTO>) query.list();
		if(lista.size()>0) {
			res = lista.get(0);
		}
		
		return res;
			
	}

	public static ArrayList<ForEmailDTO> getStoricoEmail(int id_corso, Session session) {
		
		ArrayList<ForEmailDTO> lista = null;

		Query query =  session.createQuery("from ForEmailDTO where corso.id = :_id_corso");
		query.setParameter("_id_corso", id_corso);

		
		lista = (ArrayList<ForEmailDTO>) query.list();
	
		
		return lista;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiSuccessivi(String date, Session session) throws Exception, ParseException {

		ArrayList<ForCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = session.createQuery("from ForCorsoDTO where data_scadenza > :_date and disabilitato = 0");	
		query.setParameter("_date", sdf.parse(date));
			
			
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiDocente(String dateFrom, String dateTo, int id_docente,Session session) throws Exception, ParseException{
		
	ArrayList<ForCorsoDTO> lista = null;
	ArrayList<ForCorsoDTO> result = new ArrayList<ForCorsoDTO>();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	

	Query query = session.createQuery("from ForCorsoDTO  where data_corso between :_dateFrom and :_dateTo and disabilitato = 0"); 
				
	query.setParameter("_dateFrom", sdf.parse(dateFrom));
	query.setParameter("_dateTo", sdf.parse(dateTo));
		
		
	lista = (ArrayList<ForCorsoDTO>) query.list();
	
	for (ForCorsoDTO corso : lista) {
		for (ForDocenteDTO docente : corso.getListaDocenti()) {
			if(docente.getId()==id_docente) {
				result.add(corso);
			}
		}
		
	}
			
	return result;
	
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiClienteSupervisore(int idCliente, Session session) {
		ArrayList<ForCorsoDTO> lista = null;		

		Query query =  session.createQuery("select distinct corso from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id_azienda =:_id_cliente and visibile='1' and disabilitato = 0"); 
		query.setParameter("_id_cliente", idCliente);	
			
		lista = (ArrayList<ForCorsoDTO>) query.list();		
				
		return lista;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorsoClienteSupervisore(int id_corso,int idCliente, Session session) {

		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso.id = :_id_corso and p.partecipante.id_azienda =:_id_cliente and p.corso.disabilitato = 0");
		query.setParameter("_id_corso", id_corso);
		query.setParameter("_id_cliente", idCliente);	
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<ForPartecipanteDTO> getListaPartecipantiClienteSupervisore(int idCliente, Session session) {
		
		ArrayList<ForPartecipanteDTO> lista = null;		

		Query query =  session.createQuery("from ForPartecipanteDTO where id_azienda =:_id_cliente "); 
		query.setParameter("_id_cliente", idCliente);	
			
		lista = (ArrayList<ForPartecipanteDTO>) query.list();		
				
		return lista;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorsoClienteSupervisore(
			String dateFrom, String dateTo, String tipo_data, int idCliente, Session session) throws HibernateException, ParseException {
ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = null;
		
		if(dateFrom !=null && dateTo!=null && tipo_data!=null) {
			
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.corso."+tipo_data+" between :_dateFrom and :_dateTo and p.partecipante.id_azienda =:_id_cliente  and p.corso.disabilitato = 0 and p.corso.visibile = 1");	
			query.setParameter("_dateFrom", sdf.parse(dateFrom));
			query.setParameter("_dateTo", sdf.parse(dateTo));
			
		}else {
			
			query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where  p.partecipante.id_azienda =:_id_cliente  and p.corso.disabilitato = 0  and p.corso.visibile = 1"); 
			
		}		
		query.setParameter("_id_cliente", idCliente);	
			
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static boolean controllaDuplicato(String nome, String cognome, String cf, Session session) {
		
		ArrayList<ForPartecipanteDTO> lista = null;
		boolean result = false;
		
		Query query = session.createQuery("from ForPartecipanteDTO where (nome =:_nome and cognome =:_cognome) or (cognome =:_nome and nome =:_cognome)"); 
				
		query.setParameter("_nome", nome);			
		query.setParameter("_cognome", cognome);	
		
		
		lista = (ArrayList<ForPartecipanteDTO>) query.list();
		
		
		for(int i = 0; i<lista.size();i++) {
			if(!lista.get(i).getCf().equals(cf)) {
				result =  true;
				break;
			}
		}
			
		return result;
		
		
		
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiCategoria(int id_categoria, Session session) {


		ArrayList<ForCorsoDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoDTO where corso_cat.id = :_id_categoria and disabilitato = 0"); 
				
		query.setParameter("_id_categoria", id_categoria);			
	
		
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiInScadenza(String date, Session session) throws Exception, ParseException {

		ArrayList<ForCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = session.createQuery("from ForCorsoDTO a where data_scadenza = :_date and disabilitato = 0 and email_inviata = 0");	
		query.setParameter("_date", sdf.parse(date));
			
			
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiDate(String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
		ArrayList<ForCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = null;
		
		query = session.createQuery("from ForCorsoDTO where data_corso between :_dateFrom and :_dateTo and  disabilitato = 0"); 
				
					
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
			
			
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
				
		return lista;
		
	}

	public static ForPiaPianificazioneDTO getPianificazioneFromId(int id, Session session) {
		
		ArrayList<ForPiaPianificazioneDTO> lista = null;
		ForPiaPianificazioneDTO result = null;
		
		Query query = session.createQuery("from ForPiaPianificazioneDTO where id = :_id");
		query.setParameter("_id", id);
		
		lista = (ArrayList<ForPiaPianificazioneDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioni(String anno, String filtro_tipo,Session session) {
		ArrayList<ForPiaPianificazioneDTO> lista = null;
		
		String filtro="";
		if(filtro_tipo!=null && !filtro_tipo.equals("0")) {
			filtro = " and tipo.id = 3";
		}
		
		Query query = session.createQuery("from ForPiaPianificazioneDTO where YEAR(data) = :_anno"+filtro);
		query.setParameter("_anno", Integer.parseInt(anno));
		
		
		lista = (ArrayList<ForPiaPianificazioneDTO>) query.list();
		
		
		
		return lista;
	}

	public static ArrayList<ForPiaStatoDTO> getListaStati(Session session) {
		ArrayList<ForPiaStatoDTO> lista = null;
		
		Query query = session.createQuery("from ForPiaStatoDTO");
		
		
		lista = (ArrayList<ForPiaStatoDTO>) query.list();
		
		
		
		return lista;
	}
	
	public static ArrayList<ForPiaTipoDTO> getListaTipi(Session session) {
		ArrayList<ForPiaTipoDTO> lista = null;
		
		Query query = session.createQuery("from ForPiaTipoDTO");
		
		
		lista = (ArrayList<ForPiaTipoDTO>) query.list();
		
		
		
		return lista;
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioniStato(int stato, Session session) {
		
		ArrayList<ForPiaPianificazioneDTO> lista = null;
		
		Query query = session.createQuery("from ForPiaPianificazioneDTO where stato.id =:_stato");
		query.setParameter("_stato", stato);
		
		lista = (ArrayList<ForPiaPianificazioneDTO>) query.list();
		
		
		
		return lista;
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioniDocente(String dateFrom, String dateTo,	int id_docente, Session session) throws HibernateException, ParseException {
		
		ArrayList<ForPiaPianificazioneDTO> lista = null;
		ArrayList<ForPiaPianificazioneDTO> result = new ArrayList<ForPiaPianificazioneDTO>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		

		Query query = session.createQuery("from ForPiaPianificazioneDTO  where data between :_dateFrom and :_dateTo"); 
					
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
			
			
		lista = (ArrayList<ForPiaPianificazioneDTO>) query.list();
		
		for (ForPiaPianificazioneDTO pianificazione : lista) {
			for (ForDocenteDTO docente : pianificazione.getListaDocenti()) {
				if(docente.getId()==id_docente) {
					result.add(pianificazione);
				}
			}
			
		}
				
		return result;
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioniData(String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
	ArrayList<ForPiaPianificazioneDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = null;
		
		query = session.createQuery("from ForPiaPianificazioneDTO where data between :_dateFrom and :_dateTo"); 
				
					
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
			
			
		lista = (ArrayList<ForPiaPianificazioneDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<ForConfInvioEmailDTO> getListaConfigurazioniInvioEmail(Session session) {
		
		ArrayList<ForConfInvioEmailDTO> lista = null;
		

		Query query =  session.createQuery("from ForConfInvioEmailDTO where disabilitato = 0"); 
			
		lista = (ArrayList<ForConfInvioEmailDTO>) query.list();
		
				
		return lista;
	}

	
	public static Connection getConnection()throws Exception {
		Connection con = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://85.94.217.202:3306/crescosrl_db2?user=crescosrl_user1&password=h98mShTz6");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		return con;
	}
	
	public static ArrayList<ForCorsoMoodleDTO> getListaCorsiInvioEmail() throws Exception {
		
		ArrayList<ForCorsoMoodleDTO> lista = new ArrayList<ForCorsoMoodleDTO>();
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			

		String query = "select id, fullname from mdl_course";
		
		pst=con.prepareStatement(query);
		
		
		rs=pst.executeQuery();
		
	
		
		while(rs.next())
		{
			ForCorsoMoodleDTO corso = new ForCorsoMoodleDTO();
			
			corso.setId(rs.getInt(1));
			corso.setDescrizione(rs.getString(2));
			
	
			
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

	public static ArrayList<ForGruppoMoodleDTO> getGruppiFromCorso(int corso) throws Exception {
		
		ArrayList<ForGruppoMoodleDTO> lista = new ArrayList<ForGruppoMoodleDTO>();
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			

		String query = "select id, name from mdl_groups where courseid = ?";
		
		pst=con.prepareStatement(query);
		
		pst.setInt(1, corso);
		
		
		rs=pst.executeQuery();
		
	
		
		while(rs.next())
		{
			ForGruppoMoodleDTO gruppo = new ForGruppoMoodleDTO();
			
			gruppo.setId(rs.getInt(1));
			gruppo.setDescrizione(rs.getString(2));
			
	
			
			lista.add(gruppo);

			
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

	public static ArrayList<ForMembriGruppoDTO> getMembriGruppo(int gruppo, int corso) throws Exception {
		
		ArrayList<ForMembriGruppoDTO> lista = new ArrayList<ForMembriGruppoDTO>();
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			

		String query = "";
		
		if(gruppo == 0) {
			query = "SELECT a.id, a.firstname, a.lastname, a.email, b.enrolid, (SELECT data from mdl_user_info_data where userid = a.id and fieldid=3) AS cf FROM mdl_user AS a JOIN mdl_user_enrolments AS b ON a.id = b.userid JOIN mdl_enrol AS c ON c.id = b.enrolid WHERE c.courseid = ?";
		}else {
			query = "SELECT a.id, a.firstname, a.lastname, a.email,  (SELECT data from mdl_user_info_data where userid = a.id and fieldid=3) AS cf FROM mdl_user AS a JOIN mdl_groups_members AS b ON a.id = b.userid WHERE b.groupid = ?";
		}
		
		
		
		pst=con.prepareStatement(query);
		if(gruppo == 0) {
			pst.setInt(1, corso);
		}else {
			pst.setInt(1, gruppo);
		}
		
		
		
		rs=pst.executeQuery();
		
	
		
		while(rs.next())
		{
			ForMembriGruppoDTO membro = new ForMembriGruppoDTO();
			
			membro.setId(rs.getInt(1));
			membro.setNome(rs.getString(2));
			membro.setCognome(rs.getString(3));
			membro.setEmail(rs.getString(4));
			membro.setCf(rs.getString(5));
	
			
			lista.add(membro);

			
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


	public static ArrayList<ForMembriGruppoDTO> getMembriGruppoVittoria(int gruppo, int corso) throws Exception {
		
		ArrayList<ForMembriGruppoDTO> lista = new ArrayList<ForMembriGruppoDTO>();
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			
// module = 16 --> quiz effettuato; module = 45 --> attestato scaricato
		String query = "SELECT a.id, a.firstname, a.lastname, a.email," + 
				"(SELECT timemodified FROM mdl_course_modules_completion c WHERE a.id = c.userid AND coursemoduleid = " + 
				"(SELECT id FROM mdl_course_modules WHERE course = ? AND module = 16)) AS data_esecuzione,  (SELECT data from mdl_user_info_data where userid = a.id and fieldid=3) AS cf FROM mdl_user AS a JOIN mdl_groups_members AS b ON a.id = b.userid WHERE b.groupid = ?";
		
		
		
		
		pst=con.prepareStatement(query);
	
		pst.setInt(1, corso);
	
		pst.setInt(2, gruppo);
		
		
		
		
		rs=pst.executeQuery();
		
	
		
		while(rs.next())
		{
			ForMembriGruppoDTO membro = new ForMembriGruppoDTO();
			
			membro.setId(rs.getInt(1));
			membro.setNome(rs.getString(2));
			membro.setCognome(rs.getString(3));
			membro.setEmail(rs.getString(4));
			membro.setCf(rs.getString(6));
			membro.setDataEsecuzione(rs.getLong(5));
	
			
			lista.add(membro);

			
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

	
	
	public static ForConfInvioEmailDTO getConfigurazioneInvioEmail(int id,Session session) {
	
			
			ArrayList<ForConfInvioEmailDTO> lista = null;
			ForConfInvioEmailDTO res = null;
			
			Query query = session.createQuery("from ForConfInvioEmailDTO where id = :_id"); 
						
							
			query.setParameter("_id", id);
				
					
					
			lista = (ArrayList<ForConfInvioEmailDTO>) query.list();
			
			if(lista.size()>0) {
				res = lista.get(0);
			}
				
						
			return res;
			

	}

	public static ArrayList<ForMembriGruppoDTO>  getListaUtentiNonCompleti(int id_corso, int id_gruppo) throws Exception {
		
		
		ArrayList<ForMembriGruppoDTO> lista = new ArrayList<ForMembriGruppoDTO>();
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=getConnection();

			

		String query = "";
		
		if(id_gruppo!=0) {
			//query = "SELECT a.id, a.firstname, a.lastname, a.email, a.username, b.enrolid FROM mdl_user AS a JOIN mdl_user_enrolments AS b ON a.id = b.userid JOIN mdl_enrol AS c ON c.id = b.enrolid WHERE c.courseid = ? AND a.id NOT IN (SELECT userid FROM `mdl_course_modules_completion` WHERE coursemoduleid = (SELECT id FROM mdl_course_modules WHERE course = ? AND module = 16)) AND a.id IN (SELECT userid FROM mdl_groups_members WHERE groupid = ?)";
			query = "SELECT a.id, a.firstname, a.lastname, a.email, a.username, b.enrolid FROM mdl_user AS a JOIN mdl_user_enrolments AS b ON a.id = b.userid JOIN mdl_enrol AS c ON c.id = b.enrolid WHERE c.courseid = ? AND a.id NOT IN (SELECT userid FROM `mdl_course_modules_completion` WHERE coursemoduleid = (SELECT id FROM mdl_course_modules WHERE course = ? AND module = 45 AND deletioninprogress = 0)) AND a.id IN (SELECT userid FROM mdl_groups_members WHERE groupid = ?)";
		}else {
			//query = "SELECT a.id, a.firstname, a.lastname, a.email, a.username, b.enrolid FROM mdl_user AS a JOIN mdl_user_enrolments AS b ON a.id = b.userid JOIN mdl_enrol AS c ON c.id = b.enrolid WHERE c.courseid = ? AND a.id NOT IN (SELECT userid FROM `mdl_course_modules_completion` WHERE coursemoduleid = (SELECT id FROM mdl_course_modules WHERE course = ? AND module = 16))";
			query = "SELECT a.id, a.firstname, a.lastname, a.email, a.username, b.enrolid FROM mdl_user AS a JOIN mdl_user_enrolments AS b ON a.id = b.userid JOIN mdl_enrol AS c ON c.id = b.enrolid WHERE c.courseid = ? AND a.id NOT IN (SELECT userid FROM `mdl_course_modules_completion` WHERE coursemoduleid = (SELECT id FROM mdl_course_modules WHERE course = ? AND module = 45 AND deletioninprogress = 0))";
		}
		

		
		pst=con.prepareStatement(query);
		
		pst.setInt(1, id_corso);
		pst.setInt(2, id_corso);
		if(id_gruppo!=0) {
			pst.setInt(3, id_gruppo);
		}
		
		
		rs=pst.executeQuery();
		
	
		
		while(rs.next())
		{
			ForMembriGruppoDTO membro = new ForMembriGruppoDTO();
			
			membro.setId(rs.getInt(1));
			membro.setNome(rs.getString(2));
			membro.setCognome(rs.getString(3));
			membro.setEmail(rs.getString(4));
			membro.setUsername(rs.getString(5));
			
	
			
			lista.add(membro);

			
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

	public static ArrayList<ForConfInvioEmailDTO> getListaConfigurazioniInvioEmailScadenza(Date date, Session session) {
		
		
		ArrayList<ForConfInvioEmailDTO> lista = null;
	
		
		Query query = session.createQuery("from ForConfInvioEmailDTO where data_scadenza = :_date and disabilitato = 0"); 
					
						
		query.setParameter("_date",date);			
				
				
		lista = (ArrayList<ForConfInvioEmailDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<ForConfInvioEmailDTO> getListaConfigurazioniInvioEmailData(Date date, Session session) {
		
	ArrayList<ForConfInvioEmailDTO> lista = null;
	
	Query query = null;
	
		if(date!=null) {
			query = session.createQuery("from ForConfInvioEmailDTO where data_prossimo_invio = :_date and disabilitato = 0 and stato_invio = 0");
			query.setParameter("_date",date);	
		}else {
			query = session.createQuery("from ForConfInvioEmailDTO where disabilitato = 0 and stato_invio = 0");
		}
		
					
						
				
				
				
		lista = (ArrayList<ForConfInvioEmailDTO>) query.list();
		
		
		return lista;
	}

}
