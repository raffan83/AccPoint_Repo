package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMProgressivoDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMTipoCampioneDTO;
import it.portaleSTI.DTO.AMTipoProvaDTO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;

public class GestioneAM_DAO {

	public static ArrayList<AMInterventoDTO> getListaInterventi(UtenteDTO utente, String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
		ArrayList<AMInterventoDTO> lista = null;
		Query query = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		query = session.createQuery("from AMInterventoDTO where data_intervento between :_dateFrom and :_dateTo");
			
		
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
		
		lista = (ArrayList<AMInterventoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<AMOperatoreDTO> getListaOperatoriAll(Session session) throws HibernateException, ParseException {
		
		
		ArrayList<AMOperatoreDTO> lista = null;
		

		Query query = session.createQuery("from AMOperatoreDTO");
	  
	    		
	    lista = (ArrayList<AMOperatoreDTO>)query.list();
	    
	    
		return lista;
	}

	public static ArrayList<AMCampioneDTO> getListaCampioni(Session session) {
		
		ArrayList<AMCampioneDTO> lista = null;
		

		Query query = session.createQuery("from AMCampioneDTO");
	  
	    		
	    return lista = (ArrayList<AMCampioneDTO>)query.list();
	    
	}
	
	
public static AMInterventoDTO getInterventoFromID(int id_intervento, Session session) {
		
		ArrayList<AMInterventoDTO> lista = null;
		AMInterventoDTO res = new AMInterventoDTO();
		Query query = null;
		
		
		query = session.createQuery("from AMInterventoDTO where id = :_id");			
		
		query.setParameter("_id", id_intervento);
		
		lista = (ArrayList<AMInterventoDTO>) query.list();
		
		if(lista.size()>0) {
			res = lista.get(0);
		}
		
		return res;


	}

public static ArrayList<AMOggettoProvaDTO> getListaStrumenti(Session session) {


	ArrayList<AMOggettoProvaDTO> lista = null;
	

	Query query = session.createQuery("from AMOggettoProvaDTO");
  
    		
    return lista = (ArrayList<AMOggettoProvaDTO>)query.list();
}

public static AMOggettoProvaDTO getOggettoProvaFromID(int id_strumento, Session session) {

	ArrayList<AMOggettoProvaDTO> lista = null;
	AMOggettoProvaDTO res = new AMOggettoProvaDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMOggettoProvaDTO where id = :_id");			
	
	query.setParameter("_id", id_strumento);
	
	lista = (ArrayList<AMOggettoProvaDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static AMCampioneDTO getCampioneFromID(int id_campione, Session session) {
	ArrayList<AMCampioneDTO> lista = null;
	AMCampioneDTO res = new AMCampioneDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMCampioneDTO where id = :_id");			
	
	query.setParameter("_id", id_campione);
	
	lista = (ArrayList<AMCampioneDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static ArrayList<AMTipoCampioneDTO> getListaTipiCampione(Session session) {

	ArrayList<AMTipoCampioneDTO> lista = null;
	Query query = null;
	
	
	query = session.createQuery("from AMTipoCampioneDTO");			

	
	lista = (ArrayList<AMTipoCampioneDTO>) query.list();
	

	return lista;
}

public static AMTipoCampioneDTO getTipoCampioneFromID(int id_tipo, Session session) {
	ArrayList<AMTipoCampioneDTO> lista = null;
	AMTipoCampioneDTO res = new AMTipoCampioneDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMTipoCampioneDTO where id = :_id");			
	
	query.setParameter("_id", id_tipo);
	
	lista = (ArrayList<AMTipoCampioneDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static ArrayList<AMProvaDTO> getListaProveIntervento(int id_intervento, Session session) {
	ArrayList<AMProvaDTO> lista = null;
	Query query = null;
	
	
	query = session.createQuery("from AMProvaDTO where intervento.id = :_id_intervento");			
	query.setParameter("_id_intervento", id_intervento);

	
	lista = (ArrayList<AMProvaDTO>) query.list();
	

	return lista;
}

public static ArrayList<AMTipoProvaDTO> getListaTipiProva(Session session) {
	ArrayList<AMTipoProvaDTO> lista = null;
	Query query = null;
	
	
	query = session.createQuery("from AMTipoProvaDTO");

	
	lista = (ArrayList<AMTipoProvaDTO>) query.list();
	

	return lista;
}

public static AMOperatoreDTO getOperatoreFromID(int id_operatore, Session session) {
	ArrayList<AMOperatoreDTO> lista = null;
	AMOperatoreDTO res = new AMOperatoreDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMOperatoreDTO where id = :_id");			
	
	query.setParameter("_id", id_operatore);
	
	lista = (ArrayList<AMOperatoreDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static AMTipoProvaDTO getTipoProvaFromID(int id_tipo_prova, Session session) {
	ArrayList<AMTipoProvaDTO> lista = null;
	AMTipoProvaDTO res = new AMTipoProvaDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMTipoProvaDTO where id = :_id");			
	
	query.setParameter("_id", id_tipo_prova);
	
	lista = (ArrayList<AMTipoProvaDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static AMProvaDTO getProvaFromID(int id_prova, Session session) {
	ArrayList<AMProvaDTO> lista = null;
	AMProvaDTO res = new AMProvaDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMProvaDTO where id = :_id");			
	
	query.setParameter("_id", id_prova);
	
	lista = (ArrayList<AMProvaDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static AMProgressivoDTO getProgressivo(String idCommessa, Session session) {

	ArrayList<AMProgressivoDTO> lista = null;
	AMProgressivoDTO res = null;
	Query query = null;
	
	
	query = session.createQuery("from AMProgressivoDTO where commessa = :_commessa");			
	
	query.setParameter("_commessa",idCommessa);
	
	lista = (ArrayList<AMProgressivoDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}

public static ArrayList<AMOggettoProvaDTO> getListaStrumentiClienteSede(Integer id_cliente, Integer id_sede,
		Session session) {
	
	ArrayList<AMOggettoProvaDTO> lista = null;
	Query query = null;
	
	
	query = session.createQuery("from AMOggettoProvaDTO where id_cliente =:_id_cliente and id_sede =:_id_sede");			
	
	query.setParameter("_id_cliente",id_cliente);
	query.setParameter("_id_sede",id_sede);
	
	lista = (ArrayList<AMOggettoProvaDTO>) query.list();
	
	return lista;
}

public static ArrayList<AMProvaDTO> getListaProve(Session session) {
	ArrayList<AMProvaDTO> lista = null;
	
	Query query = null;
	
	
	query = session.createQuery("from AMProvaDTO ");			

	lista = (ArrayList<AMProvaDTO>) query.list();
	
	
	return lista;
}

}
