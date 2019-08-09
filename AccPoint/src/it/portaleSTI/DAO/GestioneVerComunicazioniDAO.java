package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ProvinciaDTO;
import it.portaleSTI.DTO.VerComunicazioneDTO;

public class GestioneVerComunicazioniDAO {

	public static ArrayList<VerComunicazioneDTO> getListaComunicazioni(Session session) {
		
		ArrayList<VerComunicazioneDTO> lista = null;
		
		Query query = session.createQuery("from VerComunicazioneDTO");
		
		lista = (ArrayList<VerComunicazioneDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<ProvinciaDTO> getListaProvince(Session session) {
		
		ArrayList<ProvinciaDTO> lista = null;
		
		Query query = session.createQuery("from ProvinciaDTO order by nome");
		
		lista = (ArrayList<ProvinciaDTO>) query.list();
		
		return lista;
	}

}
