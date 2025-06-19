package it.portaleSTI.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import it.portaleSTI.DTO.ControlloAttivitaDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneInterventoDAO {
	
	private final static String sqlQuery_Inervento="select a.id,presso_destinatario,id__SEDE_, nome_sede , data_creazione , b.descrizione, u.NOMINATIVO " +
			"from intervento  a " +
			"Left join stato_intervento  b  ON a.id_stato_intervento=b.id  " +
			"left join users u on a.id__user_creation=u.ID " +
			"where id_Commessa=?";

	

	public static List<InterventoDTO> getListaInterventi(String idCommessa, Session session) throws Exception {
		
		List<InterventoDTO> lista =null;
			
		session.beginTransaction();
		Query query  = session.createQuery( "from InterventoDTO WHERE id_commessa= :_id_commessa");
		
		query.setParameter("_id_commessa", idCommessa);
				
		lista=query.list();
		
		return lista;
		}



	public static InterventoDTO  getIntervento(String idIntervento) {
		
		Query query=null;
		InterventoDTO intervento=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from InterventoDTO WHERE id = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idIntervento));
		
	    intervento=(InterventoDTO)query.list().get(0);
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     }
		return intervento;
		
	}

	
public static InterventoDTO  getIntervento(String idIntervento, Session session) {
		
		Query query=null;
		InterventoDTO intervento=null;
		try {
			

		
		String s_query = "from InterventoDTO WHERE id = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idIntervento));
		
	    intervento=(InterventoDTO)query.list().get(0);

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     }
		return intervento;
		
	}


	public static boolean isPresentStrumento(int id, StrumentoDTO strumento, Session session) {
		
		if(strumento.getCreato().equals("S")) 
		{
			return false;
		}
		
		Query query=null;
		boolean isPresent=false;
		List<MisuraDTO> misura=null;
		try {
			Session session1=SessionFacotryDAO.get().openSession();	
			session1.beginTransaction();
			
		String s_query = "from MisuraDTO WHERE intervento.id = :_intervento AND strumento.__id =:_strumento";
						  
	    query = session1.createQuery(s_query);
	    query.setParameter("_intervento",id);
	    query.setParameter("_strumento",strumento.get__id());
		
	    misura=(List<MisuraDTO>)query.list();
		
	    session1.getTransaction().commit();
		session1.close();
		
	    if(misura.size()>0)
	    {
	    	return true;
	    }
	    	else
	    {
	    	return false;
	    }
	    
	    
		
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     }
		
		
		return isPresent;
		
	}



	public static void misuraObsoleta(MisuraDTO misura,String note, Session session) throws Exception
	{
		
		Query query=null;
		
	
		
		String s_query = "update MisuraDTO SET obsoleto='S' , note_obsolescenza = :_note WHERE id = :_id";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_id",misura.getId());
	    query.setParameter("_note",note);
		
	   query.executeUpdate();	
	     	
	}



	public static void puntoMisuraObsoleto(int idTemp, Session session)throws Exception {
		
		Query query=null;
		
		String s_query = "update PuntoMisuraDTO SET obsoleto='S' WHERE id_misura =:_idMisura";
					  
	    query = session.createQuery(s_query);
	    query.setParameter("_idMisura",idTemp);
	   
	   query.executeUpdate();
		

	

	     	
	}



	public static ArrayList<MisuraDTO> getMisuraObsoleta(int id, String idStr)throws Exception {
		
		Query query=null;
		ArrayList<MisuraDTO> misura=new ArrayList<MisuraDTO>();

			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from MisuraDTO WHERE intervento.id = :_idIntervento AND strumento.__id=:_idStrumento AND obsoleto='N'";
					  //  from MisuraDTO WHERE intervento.id =36              
	    query = session.createQuery(s_query);
	    query.setParameter("_idIntervento",id);
	    query.setParameter("_idStrumento",Integer.parseInt(idStr));
		
	    misura=(ArrayList<MisuraDTO>)query.list();
		session.getTransaction().commit();
		session.close();

	     
		return misura;
	}



	public static void update(InterventoDTO intervento, Session session) {
	
		session.update(intervento);
		
	}



	public static ArrayList<MisuraDTO> getListaMirureByInterventoDati(int idInterventoDati) {
		Query query=null;
		
		ArrayList<MisuraDTO> misura=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "from MisuraDTO WHERE interventoDati.id = :_interventoDati";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_interventoDati",idInterventoDati);
		
	    misura=(ArrayList<MisuraDTO>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}

	public static ArrayList<MisuraDTO> getListaMirureByIntervento(int idIntervento, Session session) {
		Query query=null;
		
		ArrayList<MisuraDTO> misura=null;
		try {
		//Session session =SessionFacotryDAO.get().openSession();
		//session.beginTransaction();
		
		
		String s_query = "from MisuraDTO WHERE intervento.id = :_idIntervento";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_idIntervento",idIntervento);
		
	    misura=(ArrayList<MisuraDTO>)query.list();
	//    session.close();
	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}
	
	public static ArrayList<MisuraDTO> getListaMirureNonObsoleteByIntervento(int idIntervento) {
		Query query=null;
		
		ArrayList<MisuraDTO> misura=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "from MisuraDTO WHERE intervento.id = :_idIntervento AND obsoleto='N' ";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_idIntervento",idIntervento);
		
	    misura=(ArrayList<MisuraDTO>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}


	public static void update(InterventoDTO intervento) {
		Session s = SessionFacotryDAO.get().openSession();
		s.getTransaction().begin();
		
		s.update(intervento);
		
		s.getTransaction().commit();
		s.close();
		
	}



	public static void updateInterventoDati(InterventoDatiDTO interventoDati,Session session) {
		
		session.update(interventoDati);
	}



	public static ArrayList<InterventoDTO> getListaInterventiDaSede(String idCliente, String idSede,  Integer idCompany,UtenteDTO user, Session session) {
		ArrayList<InterventoDTO> lista =null;
		
		
		Query query  = null;
		if(user.isTras()) {
			query = session.createQuery( "from InterventoDTO WHERE id__sede_= :_idSede AND id_cliente=:_idcliente");
			query.setParameter("_idSede", Integer.parseInt(idSede));			
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
		}else {
			query = session.createQuery( "from InterventoDTO WHERE id__sede_= :_idSede AND company.id=:_idCompany AND id_cliente=:_idcliente");
			query.setParameter("_idSede", Integer.parseInt(idSede));
			query.setParameter("_idCompany", idCompany);
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
		}
		
		lista=(ArrayList<InterventoDTO>) query.list();
		
		return lista;
	}



	public static ArrayList<Integer> getListaClientiInterventi(int id_company) {
		Query query=null;
		
		ArrayList<Integer> lista=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query ="";
		
		if(id_company!=0) {
			s_query = "select DISTINCT(int.id_cliente) from InterventoDTO as int where int.company.id = :_id_company";
		}else {
			s_query = "select DISTINCT(int.id_cliente) from InterventoDTO as int";
		}
				
						  
	    query = session.createQuery(s_query);
	    if(id_company!=0) {
	    	query.setParameter("_id_company", id_company);
	    }
 		
	    lista=(ArrayList<Integer>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return lista;
	}



	public static ArrayList<Integer> getListaSediInterventi() {
		Query query=null;
		
		ArrayList<Integer> lista=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "select DISTINCT(int.idSede) from InterventoDTO as int";
						  
	    query = session.createQuery(s_query);
 		
	    lista=(ArrayList<Integer>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return lista;
	}



	public static void updateNStrumenti(int id, int numStrMis) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("UPDATE intervento_dati SET numStrMis=? WHERE id=?");
			pst.setInt(1, id);
			pst.setInt(2, numStrMis);
			pst.execute();
			
		} catch (Exception e) 
		{
			e.printStackTrace();
			throw e;
		}finally 
		{
			pst.close();
			con.close();
		}
		
	}



	public static ArrayList<UtenteDTO> getListaUtentiInterventoDati(Session session) {

		ArrayList<UtenteDTO> lista=null;

	    Query query = session.createQuery("select distinct utente from InterventoDatiDTO");
 		
	    lista=(ArrayList<UtenteDTO>)query.list();

		
		return lista;
	}



	public static ArrayList<InterventoDTO> getListaInterventoUtente(int id_utente,String dateFrom,String dateTo, Session session) throws Exception{
		
		
		ArrayList<InterventoDTO> lista=null;

	    Query query = null;
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
	    

	    if(dateFrom!=null && dateTo!=null && !dateFrom.equals("") && !dateTo.equals("")) {
	    	query = session.createQuery("select distinct intervento from MilestoneOperatoreDTO m where m.user.id = :_id_utente and m.intervento.dataCreazione between :dateFrom and :dateTo and m.abilitato = 1");
	  		query.setParameter("_id_utente", id_utente);
	  		query.setParameter("dateFrom",df.parse(dateFrom));
			query.setParameter("dateTo",df.parse(dateTo));
	    }else {
	    	query = session.createQuery("select distinct intervento from MilestoneOperatoreDTO m where m.user.id = :_id_utente and m.abilitato = 1");
	  		query.setParameter("_id_utente", id_utente);
	    }
	    
	    lista=(ArrayList<InterventoDTO>)query.list();
		
		return lista;
	}

	public static ControlloAttivitaDTO getStrumentiAssegnatiUtente(int id_utente, int id_intervento, Session session) {
	
		ControlloAttivitaDTO controlloAttivita = new ControlloAttivitaDTO();
	    
		Query query = session.createQuery("SELECT quantitaAssegnata,controllato,unita_misura,note_operatore FROM MilestoneOperatoreDTO WHERE user.id =:_id_utente AND intervento.id=:_id_intervento and abilitato = 1");
 		query.setParameter("_id_utente", id_utente);
 		query.setParameter("_id_intervento", id_intervento);
	
 		List<Object[]> result = (List<Object[]>)query.list();

	    BigDecimal qta = BigDecimal.ZERO;

		if(result.size()>0 ) {	
			
			int controllo = 0;
			String um = "";
			String note_operatore = "";
			for (Object[] object : result) {
				qta = qta.add((BigDecimal) object[0]);
				if(object[1].equals(1)) {
					controllo = 1;
				}
				if(object[2]!=null) {
					um = (String) object[2];
				}
				if(object[3]!=null) {
					note_operatore = (String) object[3];
				}
			}
			
			controlloAttivita.setControllato(controllo);
			controlloAttivita.setStrumentiAss(qta.intValue());
			controlloAttivita.setUnita_misura(um);
			controlloAttivita.setNote_operatore(note_operatore);			
		}
		return controlloAttivita;
		
		
	}
	
	
//	public static Object[] getStrumentiAssegnatiUtente(int id_utente, int id_intervento, Session session) {
//		
//		Object[] obj = new Object[3];		
//	    
//		Query query = session.createQuery("SELECT quantitaAssegnata,controllato,unita_misura FROM MilestoneOperatoreDTO WHERE user.id =:_id_utente AND intervento.id=:_id_intervento and abilitato = 1");
// 		query.setParameter("_id_utente", id_utente);
// 		query.setParameter("_id_intervento", id_intervento);
//	
// 		List<Object[]> result = (List<Object[]>)query.list();
//
//	    BigDecimal qta = BigDecimal.ZERO;
//
//		if(result.size()>0 ) {	
//			
//			int controllo = 0;
//			String um = "";
//			for (Object[] object : result) {
//				qta = qta.add((BigDecimal) object[0]);
//				if(object[1].equals(1)) {
//					controllo = 1;
//				}
//				if(object[2]!=null) {
//					um = (String) object[2];
//				}
//			}
//			
//			obj[0]= qta;
//			obj[1]=controllo;
//			obj[2]= um;
//		}
//		return obj;
//		
//		
//	}



	public static void setControllato(int id_intervento, int id_utente, int tipo, Session session) {
		
		Query query = session.createQuery("update MilestoneOperatoreDTO set controllato =:_tipo WHERE user.id =:_id_utente AND intervento.id=:_id_intervento");
 		query.setParameter("_id_utente", id_utente);
 		query.setParameter("_id_intervento", id_intervento);
 		query.setParameter("_tipo", tipo);
 		
 		query.executeUpdate();
		
	}



	public static void salvaNota(int id_intervento, int id_utente, String nota, Session session) {
		
		Query query = session.createQuery("update MilestoneOperatoreDTO set note_operatore =:_nota_operatore WHERE user.id =:_id_utente AND intervento.id=:_id_intervento");
 		query.setParameter("_id_utente", id_utente);
 		query.setParameter("_id_intervento", id_intervento);
 		query.setParameter("_nota_operatore", nota);
 		
 		query.executeUpdate();
		
	}



	public static ArrayList<InterventoDTO> getListaInterventiConsegna(Session session) {
			
		ArrayList<InterventoDTO> lista=null;


	    Query query = session.createQuery("from InterventoDTO a where a.statoIntervento.id = 2 AND NOT EXISTS (SELECT b.intervento.id  from SchedaConsegnaDTO b where a.id = b.intervento.id)");

	    lista=(ArrayList<InterventoDTO>)query.list();
		
		return lista;
		
		
	}



	public static InterventoDTO getUltimoIntervento(Integer id_cliente, Integer id_sede, Session session) {
	//	ArrayList<InterventoDTO> lista=null;
		InterventoDTO result = null;

	    Query query = session.createQuery("from InterventoDTO where id_cliente = :_id_cliente and id__sede_ = :_id_sede order by id desc");
	    query.setParameter("_id_cliente", id_cliente);
	    query.setParameter("_id_sede", id_sede);
	    query.setMaxResults(1);

	    result=(InterventoDTO)query.uniqueResult();
		
		return result;
	}



	public static ArrayList<InterventoDTO> getListaInterventiUtente(int id_utente, int id_cliente, int id_sede, Session session) {

		ArrayList<InterventoDTO> lista=null;

	    Query query = session.createQuery("from InterventoDTO where user.id = :_id_utente and id_cliente = :_id_cliente and id__sede_ = :_id_sede order by id desc");
	    query.setParameter("_id_utente", id_utente);
	    query.setParameter("_id_cliente", id_cliente);
	    query.setParameter("_id_sede", id_sede);

	    lista=(ArrayList<InterventoDTO>)query.list();
		
		return lista;
	}



	public static ArrayList<InterventoDTO> getListainterventiDate(LocalDate inizioBimestre, LocalDate fineBimestre,
			Session session) {
		ArrayList<InterventoDTO> lista=null;

	    Query query = session.createQuery("from InterventoDTO where dataCreazione BETWEEN :startDate AND :endDate");
	    query.setParameter("startDate", java.sql.Date.valueOf(inizioBimestre));
	    query.setParameter("endDate", java.sql.Date.valueOf(fineBimestre));

	    lista=(ArrayList<InterventoDTO>)query.list();
		
		return lista;
	}




}
