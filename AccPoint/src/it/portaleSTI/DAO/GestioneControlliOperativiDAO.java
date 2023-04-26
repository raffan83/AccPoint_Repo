package it.portaleSTI.DAO;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import it.portaleSTI.DTO.CoAllegatoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaTipoControlloDTO;
import it.portaleSTI.DTO.CoControlloDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevTestoEmailDTO;
import it.portaleSTI.bo.SendEmailBO;

public class GestioneControlliOperativiDAO {

	public static <E> ArrayList<E> getLista(E type, Session session) {
		
		ArrayList<E> lista = null;		

		
		lista =(ArrayList<E>) session.createCriteria(type.getClass()).list();
		
	
		
		return  lista;
	}

	public static <E> E getElement(E type, int id,Session session) {
		
		//ArrayList<E> lista = null;	
		E element = null;

		
		element = (E) session.get(type.getClass(), id);
		
		return  element;
	}

	public static <E> ArrayList<E> getListaWithParam(E type, String field, E param, Session session) {


		ArrayList<E> lista = null;		

		
		lista =(ArrayList<E>) session.createCriteria(type.getClass()).add(Restrictions.eq(field, param)).list();
		
	
		
		return  lista;
	}

	public static ArrayList<CoAttrezzaturaTipoControlloDTO> getListaAttrezzaturaTipoControllo(int id_attrezzatura,  Session session) {
		
		ArrayList<CoAttrezzaturaTipoControlloDTO> lista = null;		

		Query query = session.createQuery("from CoAttrezzaturaTipoControlloDTO where attrezzatura.id =:_id_attrezzatura");
		query.setParameter("_id_attrezzatura", id_attrezzatura);
		
		lista =(ArrayList<CoAttrezzaturaTipoControlloDTO>) query.list();
		
	
		
		return  lista;
	}

	public static CoAttrezzaturaTipoControlloDTO getAttrezzaturaTipoControllo(int id_attrezzatura, int id_controllo,	Session session) {
		ArrayList<CoAttrezzaturaTipoControlloDTO> lista = null;		
		CoAttrezzaturaTipoControlloDTO result = null;

		Query query = session.createQuery("from CoAttrezzaturaTipoControlloDTO where attrezzatura.id =:_id_attrezzatura and tipo_controllo.id =:_id_controllo");
		query.setParameter("_id_attrezzatura", id_attrezzatura);
		query.setParameter("_id_controllo", id_controllo);
		
		lista =(ArrayList<CoAttrezzaturaTipoControlloDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return  result;
	}

	public static ArrayList<CoAllegatoAttrezzaturaDTO> getListaAllegatiAttrezzatura(int id_attrezzatura, Session session) {
	
		ArrayList<CoAllegatoAttrezzaturaDTO> lista = null;	

		Query query = session.createQuery("from CoAllegatoAttrezzaturaDTO where id_attrezzatura =:_id_attrezzatura and disabilitato = 0");
		query.setParameter("_id_attrezzatura", id_attrezzatura);
		
		lista =(ArrayList<CoAllegatoAttrezzaturaDTO>) query.list();
		

		return  lista;
	}

	public static ArrayList<CoControlloDTO> getListaControlliAttrezzatura(int id_attrezzatura, Session session) {

		ArrayList<CoControlloDTO> lista = null;	

		Query query = session.createQuery("from CoControlloDTO where id_attrezzatura =:_id_attrezzatura and disabilitato = 0");
		query.setParameter("_id_attrezzatura", id_attrezzatura);
		
		lista =(ArrayList<CoControlloDTO>) query.list();
		

		return  lista;
			
	}

	public static ArrayList<CoControlloDTO> getControlliScadenza(String data, Session session) throws HibernateException, ParseException {
		
		ArrayList<CoControlloDTO> lista = null;	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Query query = session.createQuery("from CoControlloDTO where data_prossimo_controllo = '"+data+"' and disabilitato = 0 and obsoleto = 0");
		
		//query.setParameter("_data", sdf.parseObject(data));
		
		lista =(ArrayList<CoControlloDTO>) query.list();
		

		return  lista;
	}

	public static ArrayList<CoAttrezzaturaDTO> getAttrezzatureScadenza(String data, Session session) throws HibernateException, ParseException {
		ArrayList<CoAttrezzaturaDTO> lista = null;	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Query query = session.createQuery("from CoAttrezzaturaDTO where data_scadenza = '"+data+"'  and disabilitato = 0");
		//query.setParameter("_data", sdf.parseObject(data));
		
		lista =(ArrayList<CoAttrezzaturaDTO>) query.list();
		

		return  lista;
	}

	public static void aggiornaStatoControlli() throws HibernateException, ParseException {
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		ArrayList<CoControlloDTO> lista = null;	
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 10);
		Date nextDate = cal.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		Query query = session.createQuery("update CoControlloDTO set co_stato_controllo = 3 where data_prossimo_controllo < :_today");
		query.setParameter("_today",df.parse(df.format(today)));
		query.executeUpdate();
		query = session.createQuery("update CoControlloDTO set co_stato_controllo = 2 where data_prossimo_controllo between :_today and :_data");
		query.setParameter("_data", df.parse(df.format(nextDate)));
		query.setParameter("_today",df.parse( df.format(today)));
		
		
		query.executeUpdate();
	//	lista =(ArrayList<CoControlloDTO>) query.list();
		

		session.getTransaction().commit();
		session.close();
		
		
	}


}
