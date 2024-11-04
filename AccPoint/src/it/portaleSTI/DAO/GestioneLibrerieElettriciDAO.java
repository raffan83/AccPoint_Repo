package it.portaleSTI.DAO;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.LibreriaElettriciDTO;

public class GestioneLibrerieElettriciDAO {

	public static ArrayList<LibreriaElettriciDTO> getListaLibrerieElettrici(Session session) {
		
		
		ArrayList<LibreriaElettriciDTO> lista = null;
	
		Query query = session.createQuery("from LibreriaElettriciDTO where disabilitato = 0");
	
		
		lista = (ArrayList<LibreriaElettriciDTO>) query.list();
		
		return lista;
	}

	public static LibreriaElettriciDTO getLibreriaElettriciFromID(int id_libreria, Session session) {
		ArrayList<LibreriaElettriciDTO> lista = null;
		LibreriaElettriciDTO result = null;
		
		Query query = session.createQuery("from LibreriaElettriciDTO where id = :_id");
		query.setParameter("_id", id_libreria);
	
		
		lista = (ArrayList<LibreriaElettriciDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
