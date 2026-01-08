package it.portaleSTI.DAO;

import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LatMasterDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import java.sql.Blob;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.type.BlobType;

public class GestioneMisuraDAO {

	public static int getTabellePerMisura(int idMisura) {
		
		Session session=SessionFacotryDAO.get().openSession();
		
			
		session.beginTransaction();
		Query query  = session.createQuery( "from InterventoDTO WHERE id_commessa= :_id_commessa");
		
	//	query.setParameter("_id_commessa", idCommessa);
				
	//	lista=query.list();
		
		session.getTransaction().commit();
		session.close();
		
		return 0;
	}
	
	public static MisuraDTO getMiruraByID(int idMisura, Session session) {
		
		MisuraDTO misura=null;
		try {
			//Session session =SessionFacotryDAO.get().openSession();
			misura =  (MisuraDTO) session.get(MisuraDTO.class, idMisura);
			//session.close();
	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}
	public static int getMaxMisuraDaStrumento(int id, Session session) {
		
		
		Query query  = session.createQuery( "select max(id) from MisuraDTO as misuradto where id_strumento=:_id_str");
		query.setParameter("_id_str", id);
		
		
		List currentSeq = query.list();
		
        if(currentSeq.get(0) == null)
        {
            return 0;
        }
        else
        {
        	return (int)currentSeq.get(0);
        
        }
        
	
	}

	public static PuntoMisuraDTO getPuntoMisuraById(String id) {
		PuntoMisuraDTO punto=null;
		try {
			Session session =SessionFacotryDAO.get().openSession();
			punto =  (PuntoMisuraDTO) session.get(PuntoMisuraDTO.class, Integer.parseInt(id));
	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return punto;
	}

	public static ArrayList<PuntoMisuraDTO> getListaPuntiByIdTabellaERipetizione(int idMisura, int idTabella, int idRipetizione) {
		Query query=null;
		
		ArrayList<PuntoMisuraDTO> lista=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "from PuntoMisuraDTO WHERE id_misura = :_id_misura AND id_tabella = :_id_tabella AND id_ripetizione = :_id_ripetizione";

	    query = session.createQuery(s_query);
	    query.setParameter("_id_misura", idMisura);
	    query.setParameter("_id_tabella", idTabella);
	    query.setParameter("_id_ripetizione", idRipetizione);
	   
	    
	    lista=(ArrayList<PuntoMisuraDTO>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return lista;
	}

	public static byte[] getFileFromPuntoMisura(int id_punto)throws Exception {

		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("select file_att from PuntoMisuraDTO WHERE id = :_id");

	    query.setParameter("_id", id_punto);
		byte[] blob = (byte[]) query.list().get(0);
		session.close();
		
		return blob;
	}
	
	public static MisuraDTO getMisuraByID(int idMisura, Session session) {
		
		MisuraDTO misura=null;
		try {
			
			misura =  (MisuraDTO) session.get(MisuraDTO.class, idMisura);
			
	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}

	public static void eliminaAllegato(int id_misura, Session session) {

		
		Query query = session.createQuery("update MisuraDTO set file_allegato = null, note_allegato = null where id = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		query.executeUpdate();
		
	}

	public static ArrayList<LatMasterDTO> getListaLatMaster() {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		ArrayList<LatMasterDTO> lista = null;
		
		Query query = session.createQuery("from LatMasterDTO ");

		lista = (ArrayList<LatMasterDTO>) query.list();
		
		session.close();
		
		return lista;
	}

	public static ArrayList<MisuraDTO> getListaMisurePerData(Date start, Date now, boolean lat, Session session) {
		
			
		ArrayList<MisuraDTO> lista = null;
			
		Query query = null;
		if(lat) {
			query = session.createQuery("from MisuraDTO where dataMisura between :dateFrom and :dateTo  and lat = 'S' and (nCertificato like '%00283LAT%' or nCertificato like '%LAT172%')");	
			query.setParameter("dateFrom", start);
			query.setParameter("dateTo", now);
		}else {
			query = session.createQuery("from MisuraDTO where dataMisura between :dateFrom and :dateTo  ");
			query.setParameter("dateFrom", start);
			query.setParameter("dateTo", now);
		}
		
		

		lista = (ArrayList<MisuraDTO>) query.list();
		
				
		return lista;
	}

	public static ArrayList<MisuraDTO> getListaMisure(Session session) {
		
		ArrayList<MisuraDTO> lista = null;
		
		Query query = session.createQuery("from MisuraDTO order by id asc");	
		
		lista = (ArrayList<MisuraDTO>) query.list();
		
				
		return lista;
	}
	
}
