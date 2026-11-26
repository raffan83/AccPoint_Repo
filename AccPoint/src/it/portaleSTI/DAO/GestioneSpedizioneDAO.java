package it.portaleSTI.DAO;


import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.MagCorriereDTO;
import it.portaleSTI.DTO.SessioneDTO;
import it.portaleSTI.DTO.MagSpedizioneDTO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneSpedizioneDAO {
	
	public static List<MagCorriereDTO> getListaCorrieri(Session session){
		Query query = session.createQuery(
                 "from MagCorriereDTO c "
	    );
	    
	    List<MagCorriereDTO> result =query.list();
		if(result.size()>0)
		{			
			return (ArrayList) result;
		}
	
		return null;
	}
	


	public static MagSpedizioneDTO getSpedizioneByIdDdt(int idDdt, Session session) {
        Query query = session.createQuery(
                "from MagSpedizioneDTO s "
                + "where s.ddt.id = :idDdt "
                + "order by s.id desc"
        );

        query.setInteger("idDdt", idDdt);
        query.setMaxResults(1);

        return (MagSpedizioneDTO) query.uniqueResult();
    }
	
	
	public static MagSpedizioneDTO getSpedizioneById(int id_spedizione, Session session) {
        Query query = session.createQuery(
                "from MagSpedizioneDTO s "
                + "where s.id = :id_spedizione "
        );

        query.setInteger("id_spedizione", id_spedizione);
        query.setMaxResults(1);

        return (MagSpedizioneDTO) query.uniqueResult();
    }
	


	public static List<MagSpedizioneDTO> getListaSpedizioniPacchiAperti(Session session) {
		Query query = session.createQuery(
	            "select s "
	            + "from MagSpedizioneDTO s, MagPaccoDTO m "
	            + "where s.id_pacco = m.codice_pacco "
	            + "and m.chiuso = 0 "
	            + "order by s.id desc"
	    );
	    
	    List<MagSpedizioneDTO> result =query.list();
		if(result.size()>0)
		{			
			return (ArrayList) result;
		}
	
		return null;
	}
	
}
