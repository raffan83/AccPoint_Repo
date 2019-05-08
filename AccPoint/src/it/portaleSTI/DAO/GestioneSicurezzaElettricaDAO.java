package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.RilAllegatiDTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;

public class GestioneSicurezzaElettricaDAO {

	public static SicurezzaElettricaDTO getMisuraSeFormIdMisura(int id_misura, Session session) {
	
		ArrayList<SicurezzaElettricaDTO>  lista = null;
		SicurezzaElettricaDTO result = null;
		Query query = session.createQuery("from SicurezzaElettricaDTO where id_misura = :_id_misura");
		query.setParameter("_id_misura", id_misura);

		lista = (ArrayList<SicurezzaElettricaDTO>)query.list();
				
		if(lista.size()>0) {
			result = lista.get(0);
		}		

		return result;
	}

}
