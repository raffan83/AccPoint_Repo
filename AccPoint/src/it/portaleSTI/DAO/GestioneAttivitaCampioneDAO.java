package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;


public class GestioneAttivitaCampioneDAO {

	public static ArrayList<AcAttivitaCampioneDTO> getListaAttivita(int idC, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione");
		query.setParameter("_id_campione", idC);
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();
		
		return lista;
	}


	public static ArrayList<AcTipoAttivitaCampioniDTO> getListaTipoAttivitaCampione(Session session) {

		ArrayList<AcTipoAttivitaCampioniDTO> lista=null;

		Query query = session.createQuery("from AcTipoAttivitaCampioniDTO");		
		lista= (ArrayList<AcTipoAttivitaCampioniDTO>)query.list();
		
		return lista;
	}


	public static AcAttivitaCampioneDTO getAttivitaFromId(int id_attivita, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;
		AcAttivitaCampioneDTO result = null;
		Query query = session.createQuery("from AcAttivitaCampioneDTO where id = :_id_attivita");		
		query.setParameter("_id_attivita", id_attivita);
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();
		
		if(lista.size()>0) {
			result = lista.get(0); 
		}
		
		return result;
	}


	public static ArrayList<AcAttivitaCampioneDTO> getListaManutenzioniCampione(int id_campione, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and tipo_attivita.id = 1");		
		query.setParameter("_id_campione", id_campione);
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
		
		return lista;
	
	}

}
