package it.portaleSTI.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.RilImprontaDTO;
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



	public static ArrayList<RilImprontaDTO> getListaImprontePerMisura(int id_misura) {
		
		ArrayList<RilImprontaDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilImprontaDTO where id_misura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
				
		lista = (ArrayList<RilImprontaDTO>)query.list();
				
		session.close();
				
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



	public static ArrayList<RilQuotaDTO> getQuoteFromImpronta(int id_impronta) {

		ArrayList<RilQuotaDTO> lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilQuotaDTO where id_impronta = :_id_impronta");
		query.setParameter("_id_impronta", id_impronta);
		lista = (ArrayList<RilQuotaDTO>)query.list();
		
		session.close();
		
		return lista;
	}



	public static ArrayList<RilPuntoQuotaDTO> getPuntoQuotiFromQuota(int id_quota) {

		ArrayList<RilPuntoQuotaDTO> lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilPuntoQuotaDTO where id_quota = :_id_quota");
		query.setParameter("_id_quota", id_quota);
		lista = (ArrayList<RilPuntoQuotaDTO>)query.list();
		
		session.close();
		
		return lista;
		
	}



	public static RilImprontaDTO getimprontaById(int id_impronta) {
				
		RilImprontaDTO impronta = null;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		Query query = session.createQuery("from RilImprontaDTO where id = :_id_impronta");
		query.setParameter("_id_impronta", id_impronta);
		List<RilImprontaDTO>result = (List<RilImprontaDTO>)query.list();
		session.close();
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
				rs.getString(nomeColonna);
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

}
