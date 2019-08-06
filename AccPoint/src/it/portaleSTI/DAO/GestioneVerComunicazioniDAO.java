package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerComunicazioneDTO;

public class GestioneVerComunicazioniDAO {

	public static ArrayList<VerComunicazioneDTO> getListaComunicazioni(Session session) {
		
		ArrayList<VerComunicazioneDTO> lista = null;
		
		Query query = session.createQuery("from VerComunicazioneDTO");
		
		lista = (ArrayList<VerComunicazioneDTO>) query.list();
		
		return lista;
	}

}
