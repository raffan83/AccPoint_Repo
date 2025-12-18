package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AmScAllegatoDTO;
import it.portaleSTI.DTO.AmScAttivitaDTO;
import it.portaleSTI.DTO.AmScAttrezzaturaDTO;
import it.portaleSTI.DTO.AmScScadenzarioDTO;
import it.portaleSTI.DTO.AmScTipoAttrezzaturaDTO;
import it.portaleSTI.DTO.ForCorsoDTO;

public class GestioneAM_ScadenzarioDAO {

	public GestioneAM_ScadenzarioDAO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<AmScAttrezzaturaDTO> getListaAttrezzature(int id_cliente, int id_sede,Session session) {


		ArrayList<AmScAttrezzaturaDTO> lista = null;
		
		String q = "from AmScAttrezzaturaDTO";
		
		if(id_cliente!=0) {
			q +=" where id_cliente = :_id_cliente and id_sede = :_id_sede";
		}
		
		Query query = session.createQuery(q);
		if(id_cliente!=0) {
			query.setParameter("_id_cliente", id_cliente);
			query.setParameter("_id_sede", id_sede);
		}
		lista = (ArrayList<AmScAttrezzaturaDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScScadenzarioDTO> getListaScadenze(int id_cliente, int id_sede, int anno, Session session) {

		ArrayList<AmScScadenzarioDTO> lista = null;
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, anno);
		cal.set(Calendar.MONTH, 0);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		Date start = cal.getTime();

		cal.set(Calendar.MONTH, 11);
		cal.set(Calendar.DAY_OF_MONTH, 31);
		Date end = cal.getTime();
		
		String q = "from AmScScadenzarioDTO as a where a.dataProssimaAttivita between :start and :end";
		
		if(id_cliente!=0) {
			q += " and a.attrezzatura.idCliente  = :_id_cliente and a.attrezzatura.idSede = :_id_sede";
		}
		
		Query query = session.createQuery(q);
		if(id_cliente!=0) {
			query.setParameter("_id_cliente", id_cliente);
			query.setParameter("_id_sede", id_sede);
		}
		query.setParameter("start", start);
		query.setParameter("end", end);
		
		lista = (ArrayList<AmScScadenzarioDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScScadenzarioDTO> getListaScadenzeAttrezzatura(int id_attrezzatura, int numeroMese,
			int anno, boolean interoAnno, Session session) {
		
		ArrayList<AmScScadenzarioDTO> lista = null;
		Date start = null;
		Date end = null;
		Calendar cal = Calendar.getInstance();
		
		if(interoAnno) {
			cal.set(Calendar.YEAR, anno);
			cal.set(Calendar.MONTH, 0);
			cal.set(Calendar.DAY_OF_MONTH, 1);
			start = cal.getTime();

			cal.set(Calendar.MONTH, 11);
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			end = cal.getTime();
		}else {
			cal.set(Calendar.YEAR, anno);
			cal.set(Calendar.MONTH, numeroMese);
			cal.set(Calendar.DAY_OF_MONTH, 1);
			start = cal.getTime();

			cal.set(Calendar.MONTH, numeroMese);
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			end = cal.getTime();
		}
		
		
		String str = "from AmScScadenzarioDTO as a where a.attrezzatura.id  = :_id_attrezzatura and  a.dataProssimaAttivita between :start and :end";
		
		if(numeroMese == 0 && anno == 0) {
			str = "from AmScScadenzarioDTO as a where a.attrezzatura.id  = :_id_attrezzatura";
		}
		
		Query query = session.createQuery(str);
		query.setParameter("_id_attrezzatura", id_attrezzatura);
		if(anno != 0) {
			query.setParameter("start", start);
			query.setParameter("end", end);
		}
		
		lista = (ArrayList<AmScScadenzarioDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScAttivitaDTO> getListaAttivita(Session session) {
		
ArrayList<AmScAttivitaDTO> lista = null;
		
		Query query = session.createQuery("from AmScAttivitaDTO");
		
		lista = (ArrayList<AmScAttivitaDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScAllegatoDTO> getListaAllegatiScadenza(int id, Session session) {
		
ArrayList<AmScAllegatoDTO> lista = null;
		
		Query query = session.createQuery("from AmScAllegatoDTO where id_attivita = :_id and disabilitato = 0");
		query.setParameter("_id", id);
		
		lista = (ArrayList<AmScAllegatoDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScScadenzarioDTO> getListaAttivitaDate(String dateFrom, String dateTo, int id_cliente,
			int id_sede, Session session) throws HibernateException, ParseException {
		
ArrayList<AmScScadenzarioDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String q = "from AmScScadenzarioDTO where dataAttivita between :_dateFrom and :_dateTo";
		
			
		if(id_cliente!=0) {
			q =  "from AmScScadenzarioDTO where dataAttivita between :_dateFrom and :_dateTo and attrezzatura.idCliente = :_id_cliente and attrezzatura.idSede = :_id_sede";
		}

		Query query = session.createQuery(q); 
				
					
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
		if(id_cliente!=0) {
			query.setParameter("_id_cliente",id_cliente);	
			query.setParameter("_id_sede",id_sede);	
		}

			
		lista = (ArrayList<AmScScadenzarioDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<AmScTipoAttrezzaturaDTO> getListaTipiAttrezzatura(Session session) {
ArrayList<AmScTipoAttrezzaturaDTO> lista = null;
		
		Query query = session.createQuery("from AmScTipoAttrezzaturaDTO ");
		
		lista = (ArrayList<AmScTipoAttrezzaturaDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScAttivitaDTO> getListaAttivitaTipo(int id_tipo, Session session) {
ArrayList<AmScAttivitaDTO> lista = null;
		
		Query query = session.createQuery("from AmScAttivitaDTO  where tipo_attrezzatura = :_tipo");
		query.setParameter("_tipo", id_tipo);
		
		lista = (ArrayList<AmScAttivitaDTO>) query.list();
		
		
		return lista;
	}

	public static int getMaxIdAttivita(Session session) {

		ArrayList<Integer> result = null;
		
		Query query = session.createQuery("select MAX(id) from AmScAttivitaDTO");
		
		result =  (ArrayList<Integer>) query.list();
		
		if(result.size()>0) {
			return result.get(0);
		}else {
			return 0;
		}
		
	}

}
