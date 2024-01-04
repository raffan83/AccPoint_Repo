package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import com.google.gson.JsonArray;
import java.sql.PreparedStatement;

import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
import it.portaleSTI.DTO.MagAllegatoItemDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaItemDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagNoteDdtDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;
import it.portaleSTI.DTO.MagStatoItemDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoNotaPaccoDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.GestionePacco;
import it.portaleSTI.bo.SendEmailBO;

public class GestioneMagazzinoDAO {
	
	

private static final String queryControlloStrumento = "SELECT a.commessa,c.id_tipo_proprio ,c.id as idItemPacco from mag_pacco a "
		+ "left join mag_item_pacco b on a.id=b.id_pacco  "
		+ "inner join mag_item c on b.id_item=c.id " + 
		"WHERE c.id_tipo_proprio=? AND a.commessa=?";

	
	public static ArrayList<MagPaccoDTO> getPacchi(int id_company, Session session){
		
	
		
		 ArrayList<MagPaccoDTO> lista= null;
		
			Query query  = session.createQuery( "from MagPaccoDTO WHERE id_company= :_id_company");
			
			query.setParameter("_id_company", id_company);
					
			lista=(ArrayList<MagPaccoDTO>) query.list();
			
			
			
			return lista;
	}

	
	public static void savePacco(MagPaccoDTO pacco, Session session) {
		
		
	
		session.save(pacco);
		
	
	}


	public static MagDdtDTO getDDT(String id_ddt, Session session) {
		
		
		MagDdtDTO ddt= null;
		
		 
			Query query  = session.createQuery( "from MagDdtDTO WHERE id= :_id_ddt");
			
			query.setParameter("_id_ddt", Integer.parseInt(id_ddt));
					
			ddt= (MagDdtDTO) query.list().get(0);
			
		
			
			return ddt;
		
	
	}


	public static ArrayList<MagTipoDdtDTO> getTipoDDT(Session session) {
		
		
		
		 ArrayList<MagTipoDdtDTO> lista= null;
		
			Query query  = session.createQuery( "from MagTipoDdtDTO");

	
			lista=(ArrayList<MagTipoDdtDTO>) query.list();
			
		
			
			return lista;
		
		
	}


	public static ArrayList<MagTipoTrasportoDTO> getTipoTrasporto(Session session) {
		
	
		
		 ArrayList<MagTipoTrasportoDTO> lista= null;
			 
		 Query query  = session.createQuery( "from MagTipoTrasportoDTO");			 
	
			lista=(ArrayList<MagTipoTrasportoDTO>) query.list();
			
		
			
			return lista;
			
	}


	public static ArrayList<MagTipoPortoDTO> getTipoPorto(Session session) {
		

		
		 ArrayList<MagTipoPortoDTO> lista= null;
		
				 Query query  = session.createQuery( "from MagTipoPortoDTO");
		
	
			lista=(ArrayList<MagTipoPortoDTO>) query.list();
			
			
			
			return lista;
			
	}


	public static ArrayList<MagAspettoDTO> getTipoAspetto(Session session) {
		
		
		
		ArrayList<MagAspettoDTO> lista= null;
		
			Query query  = session.createQuery( "from MagAspettoDTO");
	
			lista=(ArrayList<MagAspettoDTO>) query.list();
			
		
			
			return lista;
	}




	public static ArrayList<MagTipoItemDTO> getTipoItem(Session session) {
		
		
		ArrayList<MagTipoItemDTO> lista= null;
		
		Query query  = session.createQuery( "from MagTipoItemDTO");
	
			lista=(ArrayList<MagTipoItemDTO>) query.list();
			
			
		
			
			return lista;
	}


	public static ArrayList<MagAccessorioDTO> getGenerico(Session session) {
		
		
		
		ArrayList<MagAccessorioDTO> lista= null;
		
		// session.beginTransaction();
			Query query  = session.createQuery( "from MagAccessorioDTO");
	
			lista=(ArrayList<MagAccessorioDTO>) query.list();
			
						
			return lista;
	}
	
	public static ArrayList<MagStatoLavorazioneDTO> getStatoLavorazione(Session session) {
		
	
		ArrayList<MagStatoLavorazioneDTO> lista= null;
	
			Query query  = session.createQuery( "from MagStatoLavorazioneDTO");
	
			lista=(ArrayList<MagStatoLavorazioneDTO>) query.list();
			
				
			return lista;
		
		
	}


	public static void saveDdt(MagDdtDTO ddt, Session session) {
		
		
		
		session.save(ddt);
		
	}


	public static void saveItem(MagItemDTO mag_item, Session session) {
		
		
	
		session.save(mag_item);
		
		
	}


	public static void saveItemPacco(MagItemPaccoDTO item_pacco, Session session) {
		
	
		session.saveOrUpdate(item_pacco);
		
	
	}


	public static MagPaccoDTO getPaccoId(int id_pacco, Session session) throws Exception {
		
		
		MagPaccoDTO pacco= null;		
		 
		Query query  = session.createQuery( "from MagPaccoDTO WHERE id= :_id_pacco");
		
		query.setParameter("_id_pacco", id_pacco);
		
		List<MagPaccoDTO> result =query.list();
		

		
		if(result.size()>0)
		{			
			return result.get(0);
		}
				
		
		
		return pacco;
	
	}


	public static ArrayList<MagItemPaccoDTO> getItemPaccoByPacco(int id_pacco, Session session) {
		
	
	
		ArrayList<MagItemPaccoDTO> item_pacco= null;		
		 
		Query query  = session.createQuery( "from MagItemPaccoDTO WHERE id_pacco= :_id order by id_item");
		
		query.setParameter("_id", id_pacco);
				
		item_pacco= (ArrayList<MagItemPaccoDTO>) query.list();
		
		
		
		return item_pacco;
		
	}
	
	public static ArrayList<MagItemPaccoDTO> getListaItemPacco( Session session) {
		
		
		
		ArrayList<MagItemPaccoDTO> item_pacco= null;		
		 
		Query query  = session.createQuery( "from MagItemPaccoDTO");

		item_pacco= (ArrayList<MagItemPaccoDTO>) query.list();
		
		
		
		return item_pacco;
		
	}
	
	public static MagItemPaccoDTO getItemPaccoByIdItem(int id_item, Session session) {
		
		

		MagItemPaccoDTO item_pacco= null;		
		 
		Query query  = session.createQuery( "from MagItemPaccoDTO where id_item= :_id_item");
		query.setParameter("_id_item", id_item);

		List<MagItemPaccoDTO> result =query.list();
		if(result.size()>0)
		{	
			int max_pacco=0;
			for (MagItemPaccoDTO magItemPaccoDTO : result) {
				
			
				if(magItemPaccoDTO.getPacco().getId()>max_pacco) {
					item_pacco =  magItemPaccoDTO;
					max_pacco = magItemPaccoDTO.getPacco().getId();
				}
			}
			
			
		
			
			if(item_pacco.getPacco().getStato_lavorazione().getId()==4)
			{
				return item_pacco;
			}else 
			{
				item_pacco=null;
				return item_pacco;
			}
		}
		
		
		return item_pacco;
		
	}
	
	public static MagItemPaccoDTO getItemPaccoByIdPacco(int id_pacco, Session session) {
		
		
		MagItemPaccoDTO item_pacco= null;		
		 
		Query query  = session.createQuery( "from MagItemPaccoDTO where id_item= :_id_pacco");
		query.setParameter("_id_item", id_pacco);

		List<MagItemPaccoDTO> result =query.list();

		if(result.size()>0)
		{	
			int max_pacco=0;
			for (MagItemPaccoDTO magItemPaccoDTO : result) {
				
			
				if(magItemPaccoDTO.getPacco().getId()>max_pacco) {
					item_pacco =  magItemPaccoDTO;
					max_pacco = magItemPaccoDTO.getPacco().getId();
				}
			}
		
		
			
			if(item_pacco.getPacco().getStato_lavorazione().getId()==4)
			{
				return item_pacco;
			}else 
			{
				item_pacco=null;
				return item_pacco;
			}
		}

		
		return item_pacco;
		
	}


	public static void updatePacco(MagPaccoDTO pacco, Session session) {	
	
		session.update(pacco);
	}


	public static void updateDdt(MagDdtDTO ddt, Session session) {
		
	
		session.update(ddt);
	
	}


	public static void deleteItemPacco(int pacco, Session session) {
		
	
	
		String hql = "delete from MagItemPaccoDTO where id_pacco= :_id";
		session.createQuery(hql).setInteger("_id", pacco).executeUpdate();
	
		
	}


	public static MagPaccoDTO getPaccoByDDT(int id, Session session) {
		
		
		
		MagPaccoDTO pacco= null;		
		 
		Query query  = session.createQuery( "from MagPaccoDTO WHERE id_ddt= :_id");		
		query.setParameter("_id", id);
				
		pacco= (MagPaccoDTO) query.list().get(0);
		
		
		return pacco;
		
	}


	public static ArrayList<MagCategoriaDTO> getListaCategorie(Session session) {
	

		ArrayList<MagCategoriaDTO> lista= null;

			Query query  = session.createQuery( "from MagCategoriaDTO");
	
			lista=(ArrayList<MagCategoriaDTO>) query.list();
			
						
			return lista;
	}


	public static void updateAllegati(MagPaccoDTO pacco, Session session) {
		
			session.update(pacco);
	
	}


	public static ArrayList<MagAllegatoDTO> getAllegatiFromPacco(String id_pacco, Session session) {
		
		
		
		ArrayList<MagAllegatoDTO> lista= null;
		
			Query query  = session.createQuery( "from MagAllegatoDTO where pacco.id= :_id");
	
			query.setParameter("_id", Integer.parseInt(id_pacco));
			lista=(ArrayList<MagAllegatoDTO>) query.list();
	
			return lista;
	}


	public static void deleteAllegato(int id_allegato, Session session) {
		
	
		MagAllegatoDTO allegato = null;
		Query query  = session.createQuery( "from MagAllegatoDTO where id= :_id");
		
		query.setParameter("_id", id_allegato);

		allegato=(MagAllegatoDTO) query.list().get(0);
		
		session.delete(allegato);
		
		
	}


	public static void cambiaStatoStrumento(int id_strumento, int stato, Session session) {
		
		
		
		Query query = session.createQuery("update MagItemDTO set stato= :_stato where id= :_id_strumento");
		MagStatoItemDTO new_stato = new MagStatoItemDTO();
		new_stato.setId(stato);
		query.setParameter("_id_strumento", id_strumento);
		query.setParameter("_stato", new_stato);

		query.executeUpdate();
	}


	public static ArrayList<MagPaccoDTO> getPaccoByCommessa(String id_commessa, Session session) {
		

		ArrayList<MagPaccoDTO> lista= null;
		
		
			Query query  = session.createQuery( "select distinct item_pacco.pacco from MagItemPaccoDTO item_pacco where item_pacco.pacco.commessa= :_commessa");
	
			query.setParameter("_commessa", id_commessa);
			lista=(ArrayList<MagPaccoDTO>) query.list();
			

			return lista;
	}

	public static ArrayList<MagPaccoDTO> getListaPacchiByCommessa(String id_commessa, Session session) {
		
		
		
		ArrayList<MagPaccoDTO> lista= null;
		
		
			Query query  = session.createQuery( "from MagPaccoDTO where commessa= :_commessa");
	
			query.setParameter("_commessa", id_commessa);
			lista=(ArrayList<MagPaccoDTO>) query.list();
			
			
			return lista;
	}


	public static ArrayList<MagItemDTO> getListaItemByPacco(int id_pacco, Session session) {
		

		ArrayList<MagItemDTO> lista= null;
		
	
			Query query  = session.createQuery( "select item from MagItemPaccoDTO where id_pacco= :_id_pacco");
	
			query.setParameter("_id_pacco", id_pacco);
			lista=(ArrayList<MagItemDTO>) query.list();
			
			
			return lista;
	}


	public static ArrayList<MagAttivitaItemDTO> getListaAttivitaItem(Session session) {
		

		
		ArrayList<MagAttivitaItemDTO> lista= null;
				
		Query query  = session.createQuery( "from MagAttivitaItemDTO");

	
		lista=(ArrayList<MagAttivitaItemDTO>) query.list();
		
		return lista;
	}


	public static ArrayList<MagTipoNotaPaccoDTO> getListaTipoNotaPacco(Session session) {

		ArrayList<MagTipoNotaPaccoDTO> lista= null;
		
		Query query  = session.createQuery( "from MagTipoNotaPaccoDTO");

	
		lista=(ArrayList<MagTipoNotaPaccoDTO>) query.list();
		
		
		return lista;
	}

	
public static ArrayList<MagPaccoDTO> getListaPacchiByOrigine(String origine, Session session) {
	

		ArrayList<MagPaccoDTO> lista= null;
		
		
			Query query  = session.createQuery( "from MagPaccoDTO where origine= :_origine order by id asc");

			query.setParameter("_origine", origine);
			lista=(ArrayList<MagPaccoDTO>) query.list();
			
			
			return lista;
	}

public static ArrayList<MagPaccoDTO> getListaPacchiByOrigineAndItem(String origine, String id_item, String matricola, Session session) {
	
	ArrayList<MagPaccoDTO> lista= null;
		
	Query query  = null;
		if(id_item!=null && !id_item.equals("")) {
			query  = session.createQuery( "select a.pacco from MagItemPaccoDTO a where a.pacco.origine= :_origine and a.item.id_tipo_proprio = :_id_item order by a.pacco.id asc");
		}else{
			query  = session.createQuery( "select a.pacco from MagItemPaccoDTO a where a.pacco.origine= :_origine and a.item.matricola = :_matricola order by a.pacco.id asc");
		}
		query.setParameter("_origine", origine);
		if(id_item!=null && !id_item.equals("")) {
			query.setParameter("_id_item", Integer.parseInt(id_item));
		}
		if((id_item==null || id_item.equals("")) && matricola!=null && !matricola.equals("")) {
			query.setParameter("_matricola", matricola);
		}
		lista=(ArrayList<MagPaccoDTO>) query.list();
		

		return lista;
}

	public static void chiudiPacchiOrigine(ArrayList<MagPaccoDTO> lista_pacchi, Session session) {
		

		for(int i=0; i<lista_pacchi.size();i++) {
			lista_pacchi.get(i).setChiuso(1);
			lista_pacchi.get(i).setTipo_nota_pacco(null);
			session.update(lista_pacchi.get(i));
		}
		

	}


	public static void accettaItem(JsonArray acc, JsonArray non_acc, JsonArray note_acc,JsonArray note_non_acc, String id_pacco, Session session) {
		
		
		for(int i=0; i<acc.size();i++) {
	
			Query query = session.createQuery("select distinct item_pacco.item.id from MagItemPaccoDTO item_pacco where  item_pacco.pacco.id = :_id_pacco and item_pacco.item.id_tipo_proprio = :_id_strumento");
			query.setParameter("_id_strumento", Integer.parseInt(acc.get(i).getAsString()));
			query.setParameter("_id_pacco", Integer.parseInt(id_pacco));
		
			int id_item=(int) query.list().get(0);
		
			query = session.createQuery("update MagItemPaccoDTO set accettato=1, note_accettazione= :note where item.id= :_item and pacco.id= :_id_pacco");
			query.setParameter("_item", id_item);
			query.setParameter("_id_pacco", Integer.parseInt(id_pacco));
			query.setParameter("note", note_acc.get(i).getAsString());
			query.executeUpdate();
		}
		
		for(int i=0; i<non_acc.size();i++) {
			Query query = session.createQuery("select distinct item_pacco.item.id from MagItemPaccoDTO item_pacco where  item_pacco.pacco.id = :_id_pacco and item_pacco.item.id_tipo_proprio = :_id_strumento");
			query.setParameter("_id_strumento", Integer.parseInt(non_acc.get(i).getAsString()));
			query.setParameter("_id_pacco", Integer.parseInt(id_pacco));
		
			int id_item=(int) query.list().get(0);
		
			query = session.createQuery("update MagItemPaccoDTO set accettato=0, note_accettazione= :note where item.id= :_item and pacco.id= :_id_pacco");
			query.setParameter("_item", id_item);
			query.setParameter("_id_pacco", Integer.parseInt(id_pacco));
			query.setParameter("note", note_non_acc.get(i).getAsString());
			query.executeUpdate();
			
		}
		

		
			
	}


	public static ArrayList<MagPaccoDTO> getListPacchiPerData(String dateFrom, String dateTo, String tipo_data, int stato, Session session) throws HibernateException, ParseException {
		
	
		ArrayList<MagPaccoDTO> lista=null;
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
		Query query = null;
		if(stato==0) {
			query = session.createQuery("from MagPaccoDTO as pacco where pacco."+tipo_data+" "+"between :dateFrom and :dateTo");	
		}else {
			query = session.createQuery("from MagPaccoDTO as pacco where pacco.chiuso = 1 and pacco."+tipo_data+" "+"between :dateFrom and :dateTo");
		}
						
		query.setParameter("dateFrom",df.parse(dateFrom));
		query.setParameter("dateTo",df.parse(dateTo));
		
		lista= (ArrayList<MagPaccoDTO>)query.list();
		
	
		
		return lista;
	}


	public static MagItemDTO getItemById(int id, Session session) {
		
	
		
		MagItemDTO item = null;
				
		Query query = session.createQuery("from MagItemDTO where id =:_id");
		query.setParameter("_id", id);
		
		item = (MagItemDTO)query.list().get(0);
		
		return item;
	}


	public static ArrayList<Integer> getListaStrumentiEsterni() throws Exception {
	
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		ArrayList<Integer> listaid= new ArrayList<Integer>();
		
		try {
			
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("select max(id_pacco) , id_item ,b.codice_pacco, b.chiuso, b.id_stato_lavorazione " + 
					",(select id_tipo_proprio from mag_item m where m.id=a.id_item ) " + 
					"from mag_item_pacco a " + 
					"left join mag_pacco b on a.id_pacco  =b.id " + 
					"group by id_item " + 
					"having b.id_stato_lavorazione=4 and b.chiuso=0 " + 
					"order by id_item desc");		
			
			rs=pst.executeQuery();
			
			while(rs.next()) 
			{
				listaid.add(rs.getInt("id_item"));
			}
			
		}catch (Exception e) {
			throw e;
		} finally {
			pst.close();
			con.close();
		}
		
		
		
		return listaid;
	}


	public static ArrayList<MagPaccoDTO> getOriginiFromItem(String id_item, String matricola, Session session) {
		
		
		ArrayList<MagPaccoDTO> lista = null;		
		
		Query query = null;
		if(id_item!=null && !id_item.equals("")) {
			query = session.createQuery("select a.pacco from MagItemPaccoDTO a where a.item.id_tipo_proprio = :_id_item group by a.pacco.origine");	
		}else {
			query = session.createQuery("select a.pacco from MagItemPaccoDTO a where a.item.matricola = :_matricola group by a.pacco.origine");
		}
		if(id_item!=null && !id_item.equals("")) {
			query.setParameter("_id_item", Integer.parseInt(id_item));
		}
		if(id_item==null || id_item.equals("") &&  matricola!=null && !matricola.equals("")) {
			query.setParameter("_matricola", matricola);	
		}		
		
		lista = (ArrayList<MagPaccoDTO>)query.list();
		
		
		
		return lista;
		
	
	}


	public static ArrayList<MagNoteDdtDTO> getListaNoteDDT(Session session) {
				
		ArrayList<MagNoteDdtDTO> lista = null;
		
		
		Query query = session.createQuery("from MagNoteDdtDTO");
		
		
		lista = (ArrayList<MagNoteDdtDTO>)query.list();
		
		
		return lista;
	}


	public static void updateStrumento(StrumentoDTO strumento, Session session) {
		

		
		String descrizione = strumento.getDenominazione();
		String cod_interno = strumento.getCodice_interno();
		String matricola = strumento.getMatricola();
		int id = strumento.get__id();
		
		Query query = session.createQuery("update MagItemDTO a SET a.descrizione = :_descrizione, a.codice_interno = :_codice_interno, a.matricola = :_matricola "
				+ "where a.id_tipo_proprio = :_id");
		query.setParameter("_descrizione", descrizione);
		query.setParameter("_codice_interno", cod_interno);
		query.setParameter("_matricola", matricola);
		query.setParameter("_id", id);
		

		query.executeUpdate();
	}


	public static ArrayList<MagCausaleDTO> getListaCausali(Session session) {
		
		
		ArrayList<MagCausaleDTO> lista = null;		
		
		Query query = session.createQuery("from MagCausaleDTO");		
		
		lista = (ArrayList<MagCausaleDTO>)query.list();
		
				
		return lista;
	}


	public static ArrayList<MagDdtDTO> getListaDDT(Session session) {
		
	
		
		ArrayList<MagDdtDTO> lista = null;
				
		Query query = session.createQuery("from MagDdtDTO");
		
		lista = (ArrayList<MagDdtDTO>)query.list();

		
		return lista;
	}


	public static int checkStrumentoInMagazzino(int id, String idCommessa) throws Exception {
		
				
		int toReturn=0;
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		
		try{
			con = DirectMySqlDAO.getConnection();	
			pst=con.prepareStatement(queryControlloStrumento);
			pst.setInt(1,id);
			pst.setString(2,idCommessa);
			
			rs=pst.executeQuery();
			
			while(rs.next())
			{
				return rs.getInt("idItemPacco");
			}
		
		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
			
		}finally
		{
			pst.close();
			con.close();
		}
		
		return toReturn;
	}


	public static MagSaveStatoDTO getMagSaveStato(int id_cliente, int id_sede, Session session) {
		
		
		
		MagSaveStatoDTO stato = null;		
		
		Query query = session.createQuery("from MagSaveStatoDTO where id_cliente = :_id_cliente and id_sede = :_id_sede");
		query.setParameter("_id_cliente", id_cliente);
		query.setParameter("_id_sede", id_sede);
		
		List<MagSaveStatoDTO> result = (List<MagSaveStatoDTO>)query.list();
		

		if(result.size()>0)
		{			
			return result.get(0);
		}
			
		
		
		return stato;
	}
	
	public static ArrayList<MagSaveStatoDTO> getListaMagSaveStato(Session session) {
		
		
		ArrayList<MagSaveStatoDTO> lista = null;
		
		Query query = session.createQuery("from MagSaveStatoDTO");

		lista = (ArrayList<MagSaveStatoDTO>)query.list();
		
	
		return lista;
	}


	public static ArrayList<MagItemDTO> getListaitemSpediti(int id_pacco, Session session) throws Exception {
		
	
		ArrayList<MagItemDTO> lista = null;
		
		MagPaccoDTO pacco = getPaccoId(id_pacco, session);
		
		Query query = session.createQuery("select a.item from MagItemPaccoDTO a where a.pacco.origine = :_origine and (a.pacco.stato_lavorazione.id = 3 or a.pacco.stato_lavorazione.id = 4)");
		query.setParameter("_origine", pacco.getOrigine());

		lista = (ArrayList<MagItemDTO>)query.list();	
		
	

		return lista;
		
		
	}


	public static Object[] getRiferimentoDDT(String origine, Session session) throws Exception{
		
			
		Object[] riferimento =null;		
		
		Query query = session.createQuery("select a.ddt.numero_ddt, a.ddt.data_ddt from MagPaccoDTO a where a.origine = :_origine and a.stato_lavorazione.id=1");
		query.setParameter("_origine", origine);
		
		List<Object[]> result = (List<Object[]>)query.list();
		
		if(result.size()>0){
			riferimento =  (Object[])query.list().get(0);
		}
		

		return riferimento;
	}


	public static int getProgressivoDDT(Session session) throws Exception {
		
		
		Query query = session.createQuery("select a.ddt.numero_ddt from MagPaccoDTO a where  (a.stato_lavorazione.id = 3 or a.stato_lavorazione.id = 4) and a.ddt.numero_ddt like '%STI_%'"
				+ "and YEAR(a.ddt.data_ddt)=YEAR(CURDATE()) order by a.id desc");
	
		List<String> result = (List<String>)query.list();
		
		int max = 0;
		if(result.size()>0) {
			for (String s : result) {
				if(s!=null && Integer.parseInt(s.split("_")[1])>max) {
					max = Integer.parseInt(s.split("_")[1]);
				}
			}
		}
		
			
		return max;
	}



	public static ArrayList<MagDdtDTO> getListaDDTPerData(String dateFrom, String dateTo, Session session) throws Exception {
		
	ArrayList<MagDdtDTO> lista=new ArrayList<MagDdtDTO>();
	ArrayList<Object[]> res = null;
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
	
	Query query = session.createQuery("select a.ddt, a.commessa from MagPaccoDTO a where a.ddt.data_ddt between :dateFrom and :dateTo");
	
	
	query.setParameter("dateFrom",df.parse(dateFrom));
	query.setParameter("dateTo",df.parse(dateTo));
	
	res = (ArrayList<Object[]>) query.list();
	
	for (Object[] objects : res) {
		MagDdtDTO ddt = null;
		
		if(objects[0]!=null) {
			 ddt = (MagDdtDTO) objects[0];	
		}
		
		if(objects[1]!=null) {
			ddt.setCommessa((String) objects[1]);	
		}
		
		if(objects[0]!=null) {
			lista.add(ddt);
		}
	}

	
	return lista;
}

	public static ArrayList<Integer> getListaAllegati(Session session) {
		

		ArrayList<MagAllegatoDTO> lista=null;
		ArrayList<Integer> lista_id=new ArrayList<Integer>();
		
		Query query = session.createQuery("from MagAllegatoDTO");
		
		lista= (ArrayList<MagAllegatoDTO>)query.list();
		for (MagAllegatoDTO allegato : lista) {
			if(!lista_id.contains(allegato.getPacco().getId())) {
				lista_id.add(allegato.getPacco().getId());
			}
		}

		return lista_id;
	}


	public static ArrayList<MagPaccoDTO> getListaPacchiApertiChiusi(int id_company, int stato, Session session) {
		
		 ArrayList<MagPaccoDTO> lista= null;
		
			Query query  = session.createQuery( "from MagPaccoDTO WHERE id_company= :_id_company and chiuso= :_stato");
			
			query.setParameter("_id_company", id_company);
			query.setParameter("_stato", stato);
					
			lista=(ArrayList<MagPaccoDTO>) query.list();
			
			return lista;
	}


	public static ArrayList<Integer> getPaccoFromStrumento(String id_strumento, Session session) {
		
		 ArrayList<Integer> lista= null;
			
			Query query  = session.createQuery( "select pacco.id from MagItemPaccoDTO WHERE item.id_tipo_proprio= :_id_strumento and pacco.chiuso= 0");
			
			query.setParameter("_id_strumento", Integer.parseInt(id_strumento));
								
			lista=(ArrayList<Integer>) query.list();
			
			
			return lista;
	}


	public static ArrayList<MagItemPaccoDTO> getListaItemPaccoApertiChiusi(int stato, Session session) {
		

		ArrayList<MagItemPaccoDTO> lista= null;
		
		Query query  = session.createQuery( "from MagItemPaccoDTO a WHERE a.pacco.chiuso = :_stato");		
		query.setParameter("_stato", stato);
				
		lista=(ArrayList<MagItemPaccoDTO>) query.list();
		

		return lista;
	}


	public static ArrayList<MagPaccoDTO> getListaPacchiInMagazzino(Session session) {
		

		ArrayList<MagPaccoDTO> lista= null;
		
		Query query  = session.createQuery( "from MagPaccoDTO GROUP BY origine HAVING (COUNT(origine)=1 AND stato_lavorazione.id = 1 and chiuso = 0)");
				
		lista=(ArrayList<MagPaccoDTO>) query.list();
		
	
		return lista;
	}


	public static void riapriOrigine(String origine, Session session) {
		

		Query query  = session.createQuery( "update MagPaccoDTO set chiuso = 0 where origine =:_origine");
		query.setParameter("_origine", origine);
		
		query.executeUpdate();
		
	}


	public static String getDataRicevimentoItem(StrumentoDTO strumento, Session session) {
		

		ArrayList<Date> lista = null;
		String result = ""; 
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = session.createQuery("select a.pacco.data_arrivo from MagItemPaccoDTO a where a.item.id_tipo_proprio = :_id_strumento and a.pacco.stato_lavorazione = 1 order by a.pacco.id desc");
		query.setParameter("_id_strumento",strumento.get__id());
		
		lista = (ArrayList<Date>) query.list();
		
		if(lista.size()>0 && lista.get(0)!=null) {
			
			result = df.format(lista.get(0));
		}
		
		
		return result;
	}


	public static void getItemInRitardo() throws Exception {
		
		
 		Session session = SessionFacotryDAO.get().openSession();	    
		session.beginTransaction();
		
		ArrayList<String> lista_origini = new ArrayList<String>();
		
		ArrayList<MagPaccoDTO> lista = null;
		
		Query query = session.createQuery("select distinct a.pacco from MagItemPaccoDTO a where a.pacco.chiuso = 0 and a.item.stato = 1");
				
		//lista = (ArrayList<MagItemPaccoDTO>) query.list();
		lista = (ArrayList<MagPaccoDTO>) query.list();
		
		
		ArrayList<String> lista_non_segnalati = new ArrayList<String>();
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

		for (MagPaccoDTO pacco : lista) {
			
			Date data_creazione = pacco.getData_lavorazione();
			if(data_creazione!=null) {
							
				java.util.Date utilDate = new java.util.Date(data_creazione.getTime());
				Instant instant = utilDate.toInstant();
				
				LocalDate date10 = Utility.sommaGiorniLavorativi(instant.atZone(ZoneId.systemDefault()).toLocalDate(), 9);
				
				
				if(pacco.getStato_lavorazione().getId()==1 && Utility.getRapportoLavorati(pacco)!=1 && date10.isBefore(LocalDate.now())) {

					
					String toAdd = pacco.getOrigine()+";"+pacco.getNome_cliente();
					
					if(pacco.getCommessa()!=null) {
						toAdd = toAdd +";"+pacco.getCommessa();
					}
					if(pacco.getData_arrivo()!=null) {
						toAdd = toAdd +";"+df.format(pacco.getData_arrivo()); 
					}
					if(pacco.getData_lavorazione()!=null) {
						toAdd = toAdd +";"+df.format(pacco.getData_lavorazione()); 
					}
					
					ArrayList<MagPaccoDTO> lista_pacchi_origine = GestioneMagazzinoDAO.getListaPacchiByOrigine(pacco.getOrigine(), session);
					
					String note_pacco = "";

					for (MagPaccoDTO magPaccoDTO : lista_pacchi_origine) {
						
						magPaccoDTO.setRitardo(1);
						
						if(magPaccoDTO.getTipo_nota_pacco()!=null) {
							note_pacco = note_pacco + magPaccoDTO.getTipo_nota_pacco().getDescrizione() +" - ";
						}
						//magPaccoDTO.setSegnalato(1);						
						
						session.update(magPaccoDTO);
					}			
					
					
					
					if(!note_pacco.equals("")) {
						note_pacco = note_pacco.substring(0, note_pacco.length()-3).replace("\r\n", "").replace("\n", "");
						toAdd = toAdd+";"+note_pacco;
					}
					
					lista_origini.add(toAdd);

				}
			}			
		}

		if(lista_origini.size()>0 && Costanti.MAIL_DEST_ALERT_PACCO.split(";").length>0) {
		
			SendEmailBO.sendEmailPaccoInRitardo(lista_origini, Costanti.MAIL_DEST_ALERT_PACCO);
			
			
		}
		
		session.getTransaction().commit();
		session.close();
		
	}


	public static ArrayList<MagItemPaccoDTO> getListaStrumentiInMagazzino(Session session) {

		ArrayList<MagItemPaccoDTO> lista= null;
				
		Query query  = session.createQuery( "from MagItemPaccoDTO where pacco.id IN (SELECT id from MagPaccoDTO GROUP BY origine HAVING (COUNT(origine)=1 AND stato_lavorazione.id = 1 and chiuso = 0))");
		
		lista=(ArrayList<MagItemPaccoDTO>) query.list();
		

		return lista;
	}

	
	public static ArrayList<MagItemPaccoDTO> getListaItemPaccoPerData(String dateFrom, String dateTo, String tipo_data, int stato, Session session) throws Exception {
		

	ArrayList<MagItemPaccoDTO> lista=null;
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
		Query query = null;
		if(stato==0) {
			query = session.createQuery("from MagItemPaccoDTO as item_pacco where item_pacco.pacco."+tipo_data+" "+"between :dateFrom and :dateTo");	
		}else {
			query = session.createQuery("from MagItemPaccoDTO as item_pacco where item_pacco.pacco.chiuso = 1 and item_pacco.pacco."+tipo_data+" "+"between :dateFrom and :dateTo");
		}
						
		query.setParameter("dateFrom",df.parse(dateFrom));
		query.setParameter("dateTo",df.parse(dateTo));
		
		lista= (ArrayList<MagItemPaccoDTO>)query.list();
		
		return lista;
	}


	public static ArrayList<MagAllegatoItemDTO> getListaAllegatiItem(MagPaccoDTO pacco, Session session) throws Exception {
		
		ArrayList<MagAllegatoItemDTO> result=new ArrayList<MagAllegatoItemDTO>();
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;
		
		try{
			con = DirectMySqlDAO.getConnection();	
			pst=con.prepareStatement("SELECT a.id_item, a.nome_file FROM mag_allegato_item AS a JOIN mag_item_pacco AS b ON a.id_item = b.id_item WHERE b.id_pacco=?");
			pst.setInt(1,pacco.getId());
			
			rs=pst.executeQuery();
			
			while(rs.next())
			{
				MagAllegatoItemDTO allegato = new MagAllegatoItemDTO();
				allegato.setId_item(rs.getInt("id_item"));
				allegato.setNome_file(rs.getString("nome_file"));
				result.add(allegato);
			}
		
		}catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
			
		}finally
		{
			pst.close();
			con.close();
		}
		

			
			return result;
	}


	public static ArrayList<MagItemDTO> getListaRilieviSpediti(String origine, int id_tipo_proprio, Session session) {
		
		ArrayList<MagItemDTO> lista = null;
		
		
		
		Query query = session.createQuery("select a.item from MagItemPaccoDTO a where a.pacco.origine = :_origine and a.item.id_tipo_proprio = :_id_tipo_proprio and (a.pacco.stato_lavorazione.id = 3 or a.pacco.stato_lavorazione.id = 4)");
		query.setParameter("_origine", origine);
		query.setParameter("_id_tipo_proprio", id_tipo_proprio);

		lista = (ArrayList<MagItemDTO>)query.list();	
		
	

		return lista;
	}



}
