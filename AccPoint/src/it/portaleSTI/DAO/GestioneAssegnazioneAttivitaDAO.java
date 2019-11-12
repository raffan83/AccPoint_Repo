package it.portaleSTI.DAO;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.MilestoneOperatoreDTO;

public class GestioneAssegnazioneAttivitaDAO {

	public static ArrayList<MilestoneOperatoreDTO> getListaMilestoneOperatore(Session session) {
		
		ArrayList<MilestoneOperatoreDTO> lista = null;
		
		Query query = session.createQuery("from MilestoneOperatoreDTO where abilitato = 1");
		
		lista = (ArrayList<MilestoneOperatoreDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<String> getListaCommesse(int id_utente, Session session) {
		
		ArrayList<String> lista = null;
		String s_query = "select distinct a.intervento.idCommessa from MilestoneOperatoreDTO a";
		
		if(id_utente!=0) {
			s_query = s_query+" where a.user.id = :_id_user";
		}
		
		Query query = session.createQuery(s_query);
		if(id_utente!=0) {
			query.setParameter("_id_user", id_utente);
		}
		
		lista = (ArrayList<String>) query.list();
		
		return lista;
	}

	public static ArrayList<MilestoneOperatoreDTO> getListaMilestoneFiltrata(String id_utente, String commessa, String dateFrom, String dateTo, Session session) throws Exception, ParseException {
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");			
		
		ArrayList<MilestoneOperatoreDTO> lista = null;
		
		String str_query = "from MilestoneOperatoreDTO where abilitato = 1";
		
		if(!id_utente.equals("")) {
			str_query = str_query + " and user.id = :_utente";
		}
		if(!commessa.equals("")) {
			if(id_utente!=null && !id_utente.equals("")) {
				str_query = str_query + " and intervento.idCommessa = :_commessa";
			}else {
				str_query = str_query + " and intervento.idCommessa = :_commessa";
			}
		}
		
		if(!dateFrom.equals("")) {
			if((id_utente!=null && !id_utente.equals("")) || (commessa!=null && !commessa.equals(""))) {
				str_query = str_query + " and data between :dateFrom and :dateTo";
			}else {
				str_query = str_query + " and data between :dateFrom and :dateTo";
			}
		}
		
		Query query = session.createQuery(str_query);
		if(!id_utente.equals("")) {
			query.setParameter("_utente",Integer.parseInt(id_utente));
		}
		if(!commessa.equals("")) {
			query.setParameter("_commessa",commessa);
		}
		if(!dateFrom.equals("")) {
			query.setParameter("dateFrom",df.parse(dateFrom));
			query.setParameter("dateTo",df.parse(dateTo));
		}		
		
		lista = (ArrayList<MilestoneOperatoreDTO>) query.list();
		
		return lista;
	}

	public static MilestoneOperatoreDTO getMilestone(int id_assegnazione, Session session) {
		
		ArrayList<MilestoneOperatoreDTO> lista = null;
		MilestoneOperatoreDTO result = null;
		
		Query query = session.createQuery("from MilestoneOperatoreDTO where id = :_id");
		
		query.setParameter("_id", id_assegnazione);
	
		lista = (ArrayList<MilestoneOperatoreDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
