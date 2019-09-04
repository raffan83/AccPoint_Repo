package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ProvinciaDTO;
import it.portaleSTI.DTO.VerComunicazioneDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;

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

	public static String checkComunicazionePreventiva(Session session, int id_ver_intervento, int idStrumentoPerComunicazione) {
		String toReturn="N";
		
		VerInterventoStrumentiDTO interventoStrumento=null;
		
		Query query = session.createQuery("from VerInterventoStrumentiDTO WHERE id_intervento = :_id_ver AND verStrumento.id= _idStr");
	    query.setParameter("_id_ver",id_ver_intervento);
	    query.setParameter("_idStr",idStrumentoPerComunicazione);
	    
	    interventoStrumento=(VerInterventoStrumentiDTO)query.list().get(0);
	    
	    if(interventoStrumento!=null)
	    {
	    //	return interventoStrumento.getPreventiva();
	    }
	    
		return toReturn;
	}

}
