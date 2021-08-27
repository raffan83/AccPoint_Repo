package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.TipoDpiDTO;

public class GestioneDpiDAO {

	public static ArrayList<TipoDpiDTO> getListaTipoDPI(Session session) {
		
		ArrayList<TipoDpiDTO> lista = null;
		
		Query query = session.createQuery("from TipoDpiDTO");
		
		lista = (ArrayList<TipoDpiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpi(Session session) {

		ArrayList<ConsegnaDpiDTO> lista = null;
		
		Query query = session.createQuery("from ConsegnaDpiDTO");
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		return lista;
	}

	public static ConsegnaDpiDTO getCosegnaFromID(int id_consegna, Session session) {

		ArrayList<ConsegnaDpiDTO> lista = null;
		ConsegnaDpiDTO result = null;
		
		Query query = session.createQuery("from ConsegnaDpiDTO where id =:_id_consegna");
		query.setParameter("_id_consegna", id_consegna);
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static TipoDpiDTO getTipoDPIFromId(int id_tipo, Session session) {
		
		ArrayList<TipoDpiDTO> lista = null;
		TipoDpiDTO result = null;
		
		Query query = session.createQuery("from TipoDpiDTO where id =:_id_tipo");
		query.setParameter("_id_tipo", id_tipo);
		
		lista = (ArrayList<TipoDpiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegnaRiconsegnaDPI(DocumDipendenteFornDTO lavoratore,int tipo_scheda, Session session) {
	
		ArrayList<ConsegnaDpiDTO> lista = null;
		
		Query query = null;
		
		if(tipo_scheda == 0) {
			query = session.createQuery("from ConsegnaDpiDTO where is_restituzione = 0 and lavoratore.id = :_id_lavoratore");
			query.setParameter("_id_lavoratore", lavoratore.getId());
		}else if(tipo_scheda == 1) {
			query = session.createQuery("from ConsegnaDpiDTO where is_restituzione = 1 and lavoratore.id = :_id_lavoratore");
			query.setParameter("_id_lavoratore", lavoratore.getId());
		}else if(tipo_scheda == 2) {
			query = session.createQuery("from ConsegnaDpiDTO where tipo.collettivo = 1");
		}
	
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DpiDTO> getListaDpi(Session session) {
		ArrayList<DpiDTO> lista = null;
		
		Query query = session.createQuery("from DpiDTO");
		
		lista = (ArrayList<DpiDTO>) query.list();
		
		return lista;
	}

	public static DpiDTO getDpiFormId(int id_dpi, Session session) {
		
		ArrayList<DpiDTO> lista = null;
		DpiDTO result = null;
		
		Query query = session.createQuery("from DpiDTO where id =:_id");
		query.setParameter("_id", id_dpi);
		
		lista = (ArrayList<DpiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ConsegnaDpiDTO> getListaEventiFromDPI(int id_dpi, Session session) {

		ArrayList<ConsegnaDpiDTO> lista = null;
		
		Query query = session.createQuery("from ConsegnaDpiDTO where dpi.id = :_id_dpi");
		query.setParameter("_id_dpi", id_dpi);
		
		lista = (ArrayList<ConsegnaDpiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DpiDTO> getListaDpiScadenzario(String dateFrom, String dateTo, Session session) throws Exception, ParseException {

		ArrayList<DpiDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		

		Query query = session.createQuery("from DpiDTO where data_scadenza between :_data_start and :_data_end");
		query.setParameter("_data_start", sdf.parse(dateFrom));
		query.setParameter("_data_end", sdf.parse(dateTo));
		

		lista = (ArrayList<DpiDTO>) query.list();
		
		return lista;
	}

}
