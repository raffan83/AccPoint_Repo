package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CertificatoDTO;

public class GestioneModificheAdminDAO {

	public static ArrayList<CertificatoDTO> getElementiRicerca(String tipo_ricerca, String id, Session session) {
		
		ArrayList<CertificatoDTO> lista = null;
		

		String ricerca = "id";
		if(tipo_ricerca.equals("id_strumento")) {
			ricerca= "misura.strumento.__id";
		}else if(tipo_ricerca.equals("id_misura")) {
			ricerca= "misura.id";
		}
		
		
		String q = "from CertificatoDTO where "+ricerca+" = :_id";
		
		
		Query query = session.createQuery(q);
		query.setParameter("_id", Integer.parseInt(id));
		
		
		lista = (ArrayList<CertificatoDTO>) query.list();
		
		
		return lista;
	}

}
