package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AmScAttivitaDTO;
import it.portaleSTI.DTO.AmScAttrezzaturaDTO;
import it.portaleSTI.DTO.AmScScadenzarioDTO;

public class GestioneAM_ScadenzarioDAO {

	public GestioneAM_ScadenzarioDAO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<AmScAttrezzaturaDTO> getListaAttrezzature(int id_cliente, int id_sede,Session session) {


		ArrayList<AmScAttrezzaturaDTO> lista = null;
		
		Query query = session.createQuery("from AmScAttrezzaturaDTO where id_cliente = :_id_cliente and id_sede = :_id_sede");
		query.setParameter("_id_cliente", id_cliente);
		query.setParameter("_id_sede", id_sede);
		
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
		
		Query query = session.createQuery("from AmScScadenzarioDTO as a where a.attrezzatura.idCliente  = :_id_cliente and a.attrezzatura.idSede = :_id_sede and  a.dataProssimaAttivita between :start and :end");
		query.setParameter("_id_cliente", id_cliente);
		query.setParameter("_id_sede", id_sede);
		query.setParameter("start", start);
		query.setParameter("end", end);
		
		lista = (ArrayList<AmScScadenzarioDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScScadenzarioDTO> getListaScadenzeAttrezzatura(int id_attrezzatura, int numeroMese,
			int anno, Session session) {
		
ArrayList<AmScScadenzarioDTO> lista = null;
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, anno);
		cal.set(Calendar.MONTH, numeroMese);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		Date start = cal.getTime();

		cal.set(Calendar.MONTH, numeroMese);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		Date end = cal.getTime();
		
		Query query = session.createQuery("from AmScScadenzarioDTO as a where a.attrezzatura.id  = :_id_attrezzatura and  a.dataProssimaAttivita between :start and :end");
		query.setParameter("_id_attrezzatura", id_attrezzatura);
		query.setParameter("start", start);
		query.setParameter("end", end);
		
		lista = (ArrayList<AmScScadenzarioDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<AmScAttivitaDTO> getListaAttivita(Session session) {
		
ArrayList<AmScAttivitaDTO> lista = null;
		
		Query query = session.createQuery("from AmScAttivitaDTO");
		
		lista = (ArrayList<AmScAttivitaDTO>) query.list();
		
		
		return lista;
	}

}
