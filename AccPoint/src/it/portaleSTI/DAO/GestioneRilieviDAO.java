package it.portaleSTI.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;

public class GestioneRilieviDAO {

	public static ArrayList<RilMisuraRilievoDTO> getListaRilievi() {
		
		ArrayList<RilMisuraRilievoDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilMisuraRilievoDTO");
				
		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();
				
		session.close();
				
		return lista;
	}



	public static ArrayList<RilTipoRilievoDTO> getListaTipoRilievo() {

		ArrayList<RilTipoRilievoDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilTipoRilievoDTO");
				
		lista = (ArrayList<RilTipoRilievoDTO>)query.list();
				
		session.close();
				
		return lista;
	}

	public static void saveRilievo(RilMisuraRilievoDTO misura_rilievo, Session session) {
		
		session.save(misura_rilievo);
		
	}

	public static void updateRilievo(RilMisuraRilievoDTO misura_rilievo, Session session) {

		session.update(misura_rilievo);
	}

	public static RilMisuraRilievoDTO getMisuraRilievoFromId(int id_misura, Session session) {
		
		RilMisuraRilievoDTO misura = null;
		
		
		Query query = session.createQuery("from RilMisuraRilievoDTO where id = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		List<RilMisuraRilievoDTO>result = (List<RilMisuraRilievoDTO>)query.list();
		
		if(result.size()>0) {
			misura = result.get(0);
		}
		
		return misura;
	}



	public static ArrayList<RilParticolareDTO> getListaParticolariPerMisura(int id_misura, Session session) {
		
		ArrayList<RilParticolareDTO>  lista = null;
				
		Query query = session.createQuery("from RilParticolareDTO where id_misura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
				
		lista = (ArrayList<RilParticolareDTO>)query.list();
				

				
		return lista;
	}
	
	
	public static ArrayList<RilParticolareDTO> getListaImprontePerMisura(int id_misura, Session session) {
		
		ArrayList<RilParticolareDTO>  lista = null;
				
		Query query = session.createQuery("from RilParticolareDTO where id_misura = :_id_misura and nome_impronta != null and nome_impronta != ''  ");
		query.setParameter("_id_misura", id_misura);
				
		lista = (ArrayList<RilParticolareDTO>)query.list();
				

				
		return lista;
	}



	public static ArrayList<RilSimboloDTO> getListaSimboli() {
		
		ArrayList<RilSimboloDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilSimboloDTO");
						
		lista = (ArrayList<RilSimboloDTO>)query.list();
				
		session.close();
				
		return lista;
	}



	public static ArrayList<RilQuotaFunzionaleDTO> getListaQuoteFunzionali() {

		ArrayList<RilQuotaFunzionaleDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		Query query = session.createQuery("from RilQuotaFunzionaleDTO");
						
		lista = (ArrayList<RilQuotaFunzionaleDTO>)query.list();
				
		session.close();
				
		return lista;
	}



	public static ArrayList<RilQuotaDTO> getQuoteFromImpronta(int id_impronta, Session session) {

		ArrayList<RilQuotaDTO> lista = null;
	
		
		Query query = session.createQuery("from RilQuotaDTO where id_impronta = :_id_impronta");
		query.setParameter("_id_impronta", id_impronta);
		lista = (ArrayList<RilQuotaDTO>)query.list();
	
		return lista;
	}



	public static ArrayList<RilPuntoQuotaDTO> getPuntoQuotiFromQuota(int id_quota, Session session) {

		ArrayList<RilPuntoQuotaDTO> lista = null;
		
	
		Query query = session.createQuery("from RilPuntoQuotaDTO where id_quota = :_id_quota");
		query.setParameter("_id_quota", id_quota);
		lista = (ArrayList<RilPuntoQuotaDTO>)query.list();
		
	
		return lista;
		
	}



	public static RilParticolareDTO getimprontaById(int id_impronta, Session session) {
				
		RilParticolareDTO impronta = null;

		Query query = session.createQuery("from RilParticolareDTO where id = :_id_impronta");
		query.setParameter("_id_impronta", id_impronta);
		List<RilParticolareDTO>result = (List<RilParticolareDTO>)query.list();
	
		if(result.size()>0) {
			impronta = result.get(0);
		}
		
		return impronta;
	}



	public static BigDecimal getTolleranzeAlbero(String lettera, int indiceTabellaTol, BigDecimal d, String nomeColonna) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("SELECT * FROM ril_scostamenti_albero where over <? AND up_to>=?");

			pst.setBigDecimal(1, d);
			pst.setBigDecimal(2, d);
			rs=pst.executeQuery();

			while(rs.next())
			{
				return rs.getBigDecimal(nomeColonna);
			}

		}
		catch(Exception ex)
		{
			throw ex;

		}
		finally
		{
			pst.close();
			con.close();

		}
		return null;
	}

	public static BigDecimal getTolleranzeForo(String lettera, int indiceTabellaTol, BigDecimal d,String nomeColonna) throws Exception {
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("SELECT * FROM ril_scostamenti_foro where over <? AND up_to>=?");

			pst.setBigDecimal(1, d);
			pst.setBigDecimal(2, d);
			rs=pst.executeQuery();

			while(rs.next())
			{
				//rs.getString(nomeColonna);
				return rs.getBigDecimal(nomeColonna);
			}

		}
		catch(Exception ex)
		{
			throw ex;

		}
		finally
		{
			pst.close();
			con.close();

		}
		return null;
	}
	
	public static BigDecimal getGradoTolleranza(BigDecimal d, int indiceTabellaTol) throws Exception {

		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs= null;

		try
		{
			con=DirectMySqlDAO.getConnection();
			pst=con.prepareStatement("SELECT * FROM ril_gradi_tolleranza where diam_da <? AND diam_a>=?");
			

			pst.setBigDecimal(1, d);
			pst.setBigDecimal(2, d);
			rs=pst.executeQuery();


			while(rs.next())
			{

				return rs.getBigDecimal(indiceTabellaTol+2);
			}

		}
		catch(Exception ex)
		{
			throw ex;

		}
		finally
		{
			pst.close();
			con.close();

		}
		return null;
	}



	public static RilQuotaDTO getQuotaFromId(int id_quota, Session session) {

		RilQuotaDTO impronta = null;
		
		Query query = session.createQuery("from RilQuotaDTO where id = :_id_quota");
		query.setParameter("_id_quota", id_quota);
		List<RilQuotaDTO>result = (List<RilQuotaDTO>)query.list();
		
		if(result.size()>0) {
			impronta = result.get(0);
		}
		
		return impronta;
	}



	public static void updatePezzi(int n_pezzi, int id_rilievo, Session session) {
		
		Query query = session.createQuery("update RilParticolareDTO set numero_pezzi = :_n_pezzi where id_misura = :_id_rilievo");
		query.setParameter("_id_rilievo", id_rilievo);
		query.setParameter("_n_pezzi", n_pezzi);
		
		query.executeUpdate();

		
	}



	public static void chiudiRilievi(int id_rilievo,Session session) {
		
	

		Query query = session.createQuery("update RilMisuraRilievoDTO set stato_rilievo.id = 2 where id = :_id_rilievo");
		query.setParameter("_id_rilievo", id_rilievo);
		
		query.executeUpdate();
	
	}



	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviInLavorazione(int id_stato_lavorazione) {

		ArrayList<RilMisuraRilievoDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilMisuraRilievoDTO where stato_rilievo.id =:_id_stato_lavorazione ");
		query.setParameter("_id_stato_lavorazione", id_stato_lavorazione);
				
		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();
				
		session.close();

		return lista;
	}



	public static void updateQuota(RilQuotaDTO quota, Session session) {
		
		Query query = session.createQuery("update RilQuotaDTO set val_nominale = :_val_nominale, coordinata = :_coordinata, "
				+ "tolleranza_positiva = :_tolleranza_positiva, tolleranza_negativa = :_tolleranza_negativa, "
				+ "id_ril_simbolo = :_simbolo, um = :_um, id_quota_funzionale = :_quota_funzionale where id_ripetizione = :_id_ripetizione");
		
		query.setParameter("_val_nominale", quota.getVal_nominale());
		query.setParameter("_coordinata", quota.getCoordinata());
		query.setParameter("_tolleranza_positiva", quota.getTolleranza_positiva());
		query.setParameter("_tolleranza_negativa", quota.getTolleranza_negativa());
		query.setParameter("_id_ripetizione", quota.getId_ripetizione());
		query.setParameter("_um", quota.getUm());
		if( quota.getSimbolo()!=null) {
			query.setParameter("_simbolo", quota.getSimbolo().getId());
		}else {
			query.setParameter("_simbolo", null);
		}
		if(quota.getQuota_funzionale()!=null) {
			query.setParameter("_quota_funzionale", quota.getQuota_funzionale().getId());
		}else {
			query.setParameter("_quota_funzionale", null);
		}
		
		query.executeUpdate();
		
	}



	public static int getMaxIdRipetizione(RilParticolareDTO impronta, Session session) {
		
		int res = 0;
			Query query = session.createQuery("select max(id_ripetizione) from RilQuotaDTO where impronta.id = :_impronta");
			query.setParameter("_impronta", impronta.getId());
		
			List<Integer> result = (List<Integer>) query.list();
			
			if(result.size()>0) {
				res= result.get(0);
			}
			
		return res;
	}
	
	
}
