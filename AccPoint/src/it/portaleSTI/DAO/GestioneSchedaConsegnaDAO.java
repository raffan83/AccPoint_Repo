package it.portaleSTI.DAO;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.GestioneIntervento;
import it.portaleSTI.bo.GestioneInterventoBO;

public class GestioneSchedaConsegnaDAO {


	public static List<SchedaConsegnaDTO> getListaSchedeConsegna(int id_intervento, Session session) {
		
		Query query  = session.createQuery( "from SchedaConsegnaDTO WHERE id_intervento= :_id");

		query.setParameter("_id", id_intervento);
		List<SchedaConsegnaDTO> result =query.list();
		
		return result;
	}
	

	public static boolean saveDB(String id_intervento, String nome_file, String data, Session session) {
		
		boolean esito=false;
		

	    SchedaConsegnaDTO scheda = new SchedaConsegnaDTO();
	    InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento);
	    scheda.setIntervento(intervento);
	    scheda.setNome_file(nome_file);
	    scheda.setData_caricamento(data);
	    scheda.setAbilitato(1);

	    session.save(scheda);
		
		return esito;
	}
	
	
	
	public static boolean deleteScheda(int id_scheda, Session session) {
		
		boolean esito= false;
		int zero=0;
		
		Query query  = session.createQuery( "UPDATE SchedaConsegnaDTO set abilitato= :zero "+ "WHERE Id= :_id");
	
		query.setParameter("zero", zero);
		query.setParameter("_id", id_scheda);

		int result = query.executeUpdate();
		if(result==1) {
			esito=true;
		}
		
		return esito;
	}



	public static int getUltimaScheda(Session session) {
				
		Query query = session.createQuery("select numero_scheda from RilMisuraRilievoDTO where disabilitato = 0 order by id desc");
	
		List<String> result = (List<String>)query.list();
		
		int max = 0;
		for (String s : result) {
			if(s!=null && Integer.parseInt(s.split("_")[1])>max) {
				max = Integer.parseInt(s.split("_")[1]);
			}
		}
		
		return max;
	}



	public static ArrayList<SchedaConsegnaRilieviDTO> getListaSchedeConsegnaRilievi(Session session) {

		ArrayList<SchedaConsegnaRilieviDTO>  lista = null;
		
		Query query = session.createQuery("from SchedaConsegnaRilieviDTO");

		lista = (ArrayList<SchedaConsegnaRilieviDTO>)query.list();	

		return lista;
	}



	public static SchedaConsegnaRilieviDTO getSchedaConsegnaRilievoFromId(int id, Session session) {

		ArrayList<SchedaConsegnaRilieviDTO>  lista = null;
		SchedaConsegnaRilieviDTO result = null;
		
		Query query = session.createQuery("from SchedaConsegnaRilieviDTO where id = :_id");
		query.setParameter("_id", id);
		
		lista = (ArrayList<SchedaConsegnaRilieviDTO>)query.list();	
		
		
		if(lista.size()>0) {
			result = lista.get(0);
		}		

		return result;

	}



	public static ArrayList<SchedaConsegnaDTO> getListaSchedeConsegnaAll(Session session) {
		
		ArrayList<SchedaConsegnaDTO> lista = null;
		Query query  = session.createQuery( "from SchedaConsegnaDTO");

		lista =(ArrayList<SchedaConsegnaDTO>) query.list();
		
		return lista;
		
	}


	public static SchedaConsegnaDTO getSchedaConsegnaFromId(int id_scheda, Session session) {

		ArrayList<SchedaConsegnaDTO>  lista = null;
		SchedaConsegnaDTO result = null;
		
		Query query = session.createQuery("from SchedaConsegnaDTO where id = :_id");
		query.setParameter("_id", id_scheda);
		
		lista = (ArrayList<SchedaConsegnaDTO>)query.list();	
		
		
		if(lista.size()>0) {
			result = lista.get(0);
		}		

		return result;
	}
	
	
	
}