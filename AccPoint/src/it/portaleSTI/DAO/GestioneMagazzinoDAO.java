package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;

import com.google.gson.JsonArray;

import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaPaccoDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagStatoItemDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoNotaPaccoDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;

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
		 
		 session.beginTransaction();
			
			Query query  = session.createQuery( "from MagTipoDdtDTO");

	
			lista=(ArrayList<MagTipoDdtDTO>) query.list();
			
			return lista;
		
		
	}


	public static ArrayList<MagTipoTrasportoDTO> getTipoTrasporto(Session session) {
		
		 ArrayList<MagTipoTrasportoDTO> lista= null;
			
		 session.beginTransaction();
		 
		 Query query  = session.createQuery( "from MagTipoTrasportoDTO");
			 
	
			lista=(ArrayList<MagTipoTrasportoDTO>) query.list();
			
			return lista;
			
	}


	public static ArrayList<MagTipoPortoDTO> getTipoPorto(Session session) {
		
		 ArrayList<MagTipoPortoDTO> lista= null;
		
			
		 session.beginTransaction();
		
				 Query query  = session.createQuery( "from MagTipoPortoDTO");
		
	
			lista=(ArrayList<MagTipoPortoDTO>) query.list();
			
			return lista;
			
	}


	public static ArrayList<MagAspettoDTO> getTipoAspetto(Session session) {
		
		ArrayList<MagAspettoDTO> lista= null;
		
		 session.beginTransaction();
			Query query  = session.createQuery( "from MagAspettoDTO");
	
			lista=(ArrayList<MagAspettoDTO>) query.list();
			
			return lista;
	}




	public static ArrayList<MagTipoItemDTO> getTipoItem(Session session) {
		
		ArrayList<MagTipoItemDTO> lista= null;
		
		 session.beginTransaction();
			Query query  = session.createQuery( "from MagTipoItemDTO");
	
			lista=(ArrayList<MagTipoItemDTO>) query.list();
			
			return lista;
	}


	public static ArrayList<MagAccessorioDTO> getGenerico(Session session) {
		
		ArrayList<MagAccessorioDTO> lista= null;
		
		 session.beginTransaction();
			Query query  = session.createQuery( "from MagAccessorioDTO");
	
			lista=(ArrayList<MagAccessorioDTO>) query.list();
			
			return lista;
	}
	
	public static ArrayList<MagStatoLavorazioneDTO> getStatoLavorazione(Session session) {
		
		ArrayList<MagStatoLavorazioneDTO> lista= null;
		
		 session.beginTransaction();
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
				
		pacco= (MagPaccoDTO) query.list().get(0);
		
		return pacco;
	
	}


	public static ArrayList<MagItemPaccoDTO> getItemPaccoByPacco(int id_pacco, Session session) {
	
		ArrayList<MagItemPaccoDTO> item_pacco= null;		
		 
		Query query  = session.createQuery( "from MagItemPaccoDTO WHERE id_pacco= :_id order by id_item");
		//Query query = session.createQuery("select magitempaccodto from MagItemPaccoDTO as magitempaccodto where magitempaccodto.pacco.id = 5")
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
		//Query query = session.createQuery("select magitempaccodto from MagItemPaccoDTO as magitempaccodto where magitempaccodto.pacco.id = 5")
		query.setParameter("_id", id);
				
		pacco= (MagPaccoDTO) query.list().get(0);
		
		return pacco;
		
	}


	public static ArrayList<MagCategoriaDTO> getListaCategorie(Session session) {

		ArrayList<MagCategoriaDTO> lista= null;
		
		 session.beginTransaction();
			Query query  = session.createQuery( "from MagCategoriaDTO");
	
			lista=(ArrayList<MagCategoriaDTO>) query.list();
			
			return lista;
	}


	public static void updateAllegati(MagPaccoDTO pacco, Session session) {
		session.update(pacco);
		
	}


	public static ArrayList<MagAllegatoDTO> getAllegatiFromPacco(String id_pacco, Session session) {
		
		ArrayList<MagAllegatoDTO> lista= null;
		
		 session.beginTransaction();
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
	
//			Criteria criteria = session.createCriteria( MagItemPaccoDTO.class );
//			criteria.setProjection( Projections.distinct( Projections.property( "pacco" ) ) );
			query.setParameter("_commessa", id_commessa);
			lista=(ArrayList<MagPaccoDTO>) query.list();
			
			return lista;
	}

	public static ArrayList<MagPaccoDTO> getListaPacchiByCommessa(String id_commessa, Session session) {
		
		ArrayList<MagPaccoDTO> lista= null;
		
		
			Query query  = session.createQuery( "from MagPaccoDTO where commessa= :_commessa");
	
//			Criteria criteria = session.createCriteria( MagItemPaccoDTO.class );
//			criteria.setProjection( Projections.distinct( Projections.property( "pacco" ) ) );
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


	public static ArrayList<MagAttivitaPaccoDTO> getListaAttivitaPacco(Session session) {
		
		ArrayList<MagAttivitaPaccoDTO> lista= null;
				
		Query query  = session.createQuery( "from MagAttivitaPaccoDTO");

	
		lista=(ArrayList<MagAttivitaPaccoDTO>) query.list();
		
		return lista;
	}


	public static ArrayList<MagTipoNotaPaccoDTO> getListaTipoNotaPacco(Session session) {

		ArrayList<MagTipoNotaPaccoDTO> lista= null;
		
		Query query  = session.createQuery( "from MagTipoNotaPaccoDTO");

	
		lista=(ArrayList<MagTipoNotaPaccoDTO>) query.list();
		
		return lista;
	}


	public static void chiudiPacchiCommessa(ArrayList<MagPaccoDTO> lista_pacchi, Session session) {
		
		
		for(int i=0; i<lista_pacchi.size();i++) {
			lista_pacchi.get(i).setChiuso(1);
			session.update(lista_pacchi.get(i));
		}
		

	}


	public static void accettaItem(JsonArray acc, JsonArray non_acc, JsonArray note_acc,JsonArray note_non_acc, String id_pacco, Session session) {
		
		for(int i=0; i<acc.size();i++) {
		//Query query  = session.createQuery( "select distinct item_pacco.pacco from MagItemPaccoDTO item_pacco where item_pacco.pacco.commessa= :_commessa");
			//Query query = session.createQuery("update MagItemPaccoDTO item_pacco set accettato= 1 where  item_pacco.pacco.id = :_id_pacco and item_pacco.item.id_tipo_proprio = :_id_strumento");
			Query query = session.createQuery("select distinct item_pacco.item.id from MagItemPaccoDTO item_pacco where  item_pacco.pacco.id = :_id_pacco and item_pacco.item.id_tipo_proprio = :_id_strumento");
			query.setParameter("_id_strumento", Integer.parseInt(acc.get(i).getAsString()));
			query.setParameter("_id_pacco", Integer.parseInt(id_pacco));
			//query.executeUpdate();
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
			//query.executeUpdate();
			int id_item=(int) query.list().get(0);
		
			query = session.createQuery("update MagItemPaccoDTO set accettato=0, note_accettazione= :note where item.id= :_item and pacco.id= :_id_pacco");
			query.setParameter("_item", id_item);
			query.setParameter("_id_pacco", Integer.parseInt(id_pacco));
			query.setParameter("note", note_non_acc.get(i).getAsString());
			query.executeUpdate();
			
		}
		


		
			
	}








	
	
}
