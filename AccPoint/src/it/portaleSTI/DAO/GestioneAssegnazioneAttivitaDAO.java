package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AgendaMilestoneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.MilestoneOperatoreDTO;
import it.portaleSTI.DTO.SedeDTO;

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

	public static int inserisciAgenda(AgendaMilestoneDTO agenda) throws Exception {
		
	List<ClienteDTO> lista =new ArrayList<ClienteDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		SimpleDateFormat sdf =new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		ResultSet generatedKeys=null;
		
         
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("INSERT INTO [dbo].[BWT_AGENDA]([USERNAME],[STATO],[SOGGETTO],[DESCRIZIONE],[LABEL],"
					+ 				 "[STARTIME],[ENDTIME],[ID_ANAGEN],[ID_COMM],[LOCATION],[GLB_FASE]) VALUES (?,?,?,?,?,?,?,?,?,?,?)",pst.RETURN_GENERATED_KEYS); 

			pst.setString(1, agenda.getUSERNAME());
			pst.setInt(2, agenda.getSTATO());
			pst.setString(3, agenda.getSOGGETTO());
			pst.setString(4, agenda.getNOTA());
			pst.setInt(5,agenda.getLABEL());
			pst.setString(6,sdf.format(agenda.getSTARTDATE()));
			pst.setString(7,sdf.format(agenda.getENDTDATE()));
			pst.setInt(8, agenda.getID_ANAGEN());
			pst.setString(9, agenda.getID_COMMESSA());
			pst.setString(10, agenda.getDESCRIZIONE());
			pst.setString(11, agenda.getFASE());
			pst.executeUpdate();
			
			generatedKeys = pst.getGeneratedKeys();
			
			if (generatedKeys.next()) {
			    int generatedId = generatedKeys.getInt(1);
			    
			 
			   return generatedId;
			}
			
		} catch (Exception e){
			
			e.printStackTrace();
			throw e;
			
		}finally
		{
			generatedKeys.close();
			pst.close();
			con.close();
		}
		return 0;
		
		
	}
	
	public static void eliminaAgenda(int id_agenda) throws Exception {
		
	
		
		Connection con=null;
		PreparedStatement pst = null;
	
	
		
         
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("DELETE FROM [dbo].[BWT_AGENDA] WHERE ID_AGENDA=?"); 

		
			pst.setInt(1, id_agenda);
		
			pst.execute();
			
			
		} catch (Exception e){
			
			e.printStackTrace();
			throw e;
			
		}finally
		{
			
			pst.close();
			con.close();
		}
			
	}

	public static HashMap<String,ArrayList<String>>getListaFasiCommessa(String nomi_utenti,String id_docenti) throws Exception {


		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		ArrayList<String> lista_fasi = new ArrayList<String>();
		HashMap<String,ArrayList<String>> map = new HashMap<String,ArrayList<String>>();
         
		try {
			con=ManagerSQLServer.getConnectionSQL();
			String query = "SELECT K2_RIGA,NOTE,TB_RISORSA FROM [dbo].[BWT_COMMESSA_FASI] WHERE ID_COMMESSA=? AND TB_FASE = 'AM_F9' AND ";
			
			String[] utentiArray = nomi_utenti.split(";");
	        String[] idArray = id_docenti.split(";");
			
	        HashMap<String, String> userIdMap = new HashMap<>();
	        
	        
	        for (int i = 0; i < utentiArray.length; i++) {
	            userIdMap.put(utentiArray[i], idArray[i]);  
	        }
	        
			if(utentiArray.length==1) {
				query += "TB_RISORSA =?";
			}
			else {
				for(int i = 0; i<utentiArray.length;i++) {
					if(i==0) {
						query += "(TB_RISORSA =?";
					}else {
						query += " OR TB_RISORSA =?"; 
					}
					
				}
				query+=")";
			}
			pst=con.prepareStatement(query);
		
			pst.setString(1, "AM_TSC_0118/25");
			//pst.setString(2, docenti.split(";")[0]);
			
			//if(docenti.split(";").length>1) {
				for(int i = 0; i<utentiArray.length;i++) {
					pst.setString(2+i, utentiArray[i]);
				}
				
		//	}
		
			rs=pst.executeQuery();
			int i = 0;
			while(rs.next())
			{
				
				String fase = rs.getString("K2_RIGA");
				String note = rs.getString("NOTE");
				String user = rs.getString("TB_RISORSA");
				
				String userId = userIdMap.get(user);
				
				if(note==null) {
					note = "";
				}
				
				
				if(map.get(userId)==null) {
					lista_fasi = new ArrayList<String>();
					lista_fasi.add(fase+";;"+note);
					map.put(userId, lista_fasi);
				}else {
					lista_fasi = map.get(userId);
					lista_fasi.add(fase+";;"+note);
					map.put(userId, lista_fasi);
				}
				
				
			}
			
			
		} catch (Exception e){
			
			e.printStackTrace();
			throw e;
			
		}finally
		{
			
			pst.close();
			con.close();
		}
		
		return map;
	}

}
