package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import it.portaleSTI.DTO.CoAllegatoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaTipoControlloDTO;
import it.portaleSTI.DTO.CoControlloDTO;

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

}
