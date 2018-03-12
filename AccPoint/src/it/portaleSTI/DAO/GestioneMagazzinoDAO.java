package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;

public class GestioneMagazzinoDAO {

//	public static void save(LogMagazzinoDTO logMagazzino, Session session) throws Exception{
//		
//		session.save(logMagazzino);
//		
//	}
	
	
	public static ArrayList<MagPaccoDTO> getPacchi(int id_company, Session session){
		
		
		 ArrayList<MagPaccoDTO> lista= null;
		
		 session.beginTransaction();
			Query query  = session.createQuery( "from MagPaccoDTO WHERE id_company= :_id_company");
			
			query.setParameter("_id_company", id_company);
					
			lista=(ArrayList<MagPaccoDTO>) query.list();
			
			return lista;
	}

	
	
	
	
}
