package it.portaleSTI.DAO;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.ItServizioItDTO;
import it.portaleSTI.DTO.ItTipoRinnovoDTO;
import it.portaleSTI.DTO.ItTipoServizioDTO;

public class GestioneScadenzarioItDAO {



	public static ArrayList<ItServizioItDTO> getListaServizi(Session session) {
		
		ArrayList<ItServizioItDTO> lista = null;
		
		Query query = session.createQuery("from ItServizioItDTO");
		
		lista = (ArrayList<ItServizioItDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<ItTipoRinnovoDTO> getListaTipiRinnovo(Session session) {
		ArrayList<ItTipoRinnovoDTO> lista = null;
		
		Query query = session.createQuery("from ItTipoRinnovoDTO");
		
		lista = (ArrayList<ItTipoRinnovoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<ItTipoServizioDTO> getListaTipiServizi(Session session) {
		
		ArrayList<ItTipoServizioDTO> lista = null;
		
		Query query = session.createQuery("from ItTipoServizioDTO");
		
		lista = (ArrayList<ItTipoServizioDTO>) query.list();
		
		return lista;
	}

	public static <E> E getElement(E type, int id,Session session) {
		
			
		E element = null;

		
		element = (E) session.get(type.getClass(), id);
		
		return  element;
	}

	public static void updateStatoServizi() {


		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		  LocalDate today = LocalDate.now();
	      java.sql.Date sqlToday = java.sql.Date.valueOf(today);
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<ItServizioItDTO> lista = null;

		Query query = session.createQuery("from ItServizioItDTO where data_scadenza <= :_date");
		query.setParameter("_date", sqlToday);
		
		lista = (ArrayList<ItServizioItDTO>) query.list();
		for (ItServizioItDTO servizio : lista) {
			servizio.setStato(2);
			session.update(servizio);
		}
		
		

		session.getTransaction().commit();
		session.close();
		
	}

	public static ArrayList<ItServizioItDTO> getListaremindServizi(String date, Session session) throws HibernateException, ParseException {
		
		ArrayList<ItServizioItDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		
		String str = "from ItServizioItDTO where data_remind = :_date and disabilitato = 0";

		
		Query query = session.createQuery(str);
		query.setParameter("_date", sdf.parse(date));


		lista = (ArrayList<ItServizioItDTO>) query.list();
		
		return lista;
	}

}
