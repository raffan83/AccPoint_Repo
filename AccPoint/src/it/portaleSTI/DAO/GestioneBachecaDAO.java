package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.BachecaDTO;
import it.portaleSTI.DTO.MagPaccoDTO;

public class GestioneBachecaDAO {

	
	public static void saveMessaggio(BachecaDTO messaggio, Session session) {
		session.save(messaggio);
	}

	public static ArrayList<BachecaDTO> getListaMessaggi( Session session) {
		
		 ArrayList<BachecaDTO> lista = null;
		 
			Query query  = session.createQuery( "from BachecaDTO");
			
			lista= (ArrayList<BachecaDTO>) query.list();
			
			return lista;

	}

	public static BachecaDTO getMessaggioFromId(int id_messaggio, Session session) {

		BachecaDTO messaggio = null;
		 
		Query query  = session.createQuery( "from BachecaDTO where Id= :_id_messaggio");
		query.setParameter("_id_messaggio", id_messaggio);
		messaggio= (BachecaDTO) query.list().get(0);
		
		return messaggio;

	}
	
}
