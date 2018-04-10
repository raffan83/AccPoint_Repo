package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSpedizioniereDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
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


	public static ArrayList<MagSpedizioniereDTO> getSpedizionieri(Session session) {
		
		ArrayList<MagSpedizioniereDTO> lista= null;
		
		 session.beginTransaction();
			Query query  = session.createQuery( "from MagSpedizioniereDTO");
	
			lista=(ArrayList<MagSpedizioniereDTO>) query.list();
			
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
		
		session.save(item_pacco);
	}


	public static MagPaccoDTO getPaccoId(int id_pacco, Session session) {
	

		MagPaccoDTO pacco= null;		
		 
		Query query  = session.createQuery( "from MagPaccoDTO WHERE id= :_id_pacco");
		
		query.setParameter("_id_pacco", id_pacco);
				
		pacco= (MagPaccoDTO) query.list().get(0);
		
		return pacco;
	
	}


	public static ArrayList<MagItemPaccoDTO> getItemPacco(int id, Session session) {
	
		ArrayList<MagItemPaccoDTO> item_pacco= null;		
		 
		Query query  = session.createQuery( "from MagItemPaccoDTO WHERE id_pacco= :_id order by id_item");
		//Query query = session.createQuery("select magitempaccodto from MagItemPaccoDTO as magitempaccodto where magitempaccodto.pacco.id = 5")
		query.setParameter("_id", id);
				
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








	
	
}
