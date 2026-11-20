package it.portaleSTI.DAO;


import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CorriereDTO;
import it.portaleSTI.DTO.SessioneDTO;
import it.portaleSTI.DTO.SpedizioneDTO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneSpedizioneDAO {
	
	public static List<CorriereDTO> getListaCorrieri(Session session){
		Query query = session.createQuery(
                 "from CorriereDTO c "
	    );
	    
	    List<CorriereDTO> result =query.list();
		if(result.size()>0)
		{			
			return (ArrayList) result;
		}
	
		return null;
	}
	


	public static SpedizioneDTO getSpedizioneByIdDdt(int idDdt, Session session) {
        Query query = session.createQuery(
                "from SpedizioneDTO s "
                + "where s.ddt.id = :idDdt "
                + "order by s.id desc"
        );

        query.setInteger("idDdt", idDdt);
        query.setMaxResults(1);

        return (SpedizioneDTO) query.uniqueResult();
    }
	
	
	public static SpedizioneDTO getSpedizioneById(int id_spedizione, Session session) {
        Query query = session.createQuery(
                "from SpedizioneDTO s "
                + "where s.id = :id_spedizione "
        );

        query.setInteger("id_spedizione", id_spedizione);
        query.setMaxResults(1);

        return (SpedizioneDTO) query.uniqueResult();
    }
	


	public static List<SpedizioneDTO> getListaSpedizioniPacchiAperti(Session session) {
		Query query = session.createQuery(
	            "select s "
	            + "from SpedizioneDTO s, MagPaccoDTO m "
	            + "where s.id_pacco = m.codice_pacco "
	            + "and m.chiuso = 0 "
	            + "order by s.id desc"
	    );
	    
	    List<SpedizioneDTO> result =query.list();
		if(result.size()>0)
		{			
			return (ArrayList) result;
		}
	
		return null;
	}
	
}
