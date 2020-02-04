package it.portaleSTI.DAO;

import java.io.File;
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

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilAllegatiDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneRilieviBO;

public class GestioneRilieviDAO {

	public static ArrayList<RilMisuraRilievoDTO> getListaRilievi() {
		
		ArrayList<RilMisuraRilievoDTO>  lista = null;
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from RilMisuraRilievoDTO where disabilitato=0");
				
		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();

		return lista;
	}



	public static ArrayList<RilTipoRilievoDTO> getListaTipoRilievo(Session session) {

		ArrayList<RilTipoRilievoDTO>  lista = null;

		
		Query query = session.createQuery("from RilTipoRilievoDTO");
				
		lista = (ArrayList<RilTipoRilievoDTO>)query.list();

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



	public static ArrayList<RilSimboloDTO> getListaSimboli(Session session) {
		
		ArrayList<RilSimboloDTO>  lista = null;		

		Query query = session.createQuery("from RilSimboloDTO");
						
		lista = (ArrayList<RilSimboloDTO>)query.list();
				

				
		return lista;
	}



	public static ArrayList<RilQuotaFunzionaleDTO> getListaQuoteFunzionali(Session session) {

		ArrayList<RilQuotaFunzionaleDTO>  lista = null;

		Query query = session.createQuery("from RilQuotaFunzionaleDTO");
						
		lista = (ArrayList<RilQuotaFunzionaleDTO>)query.list();
					
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
			//pst=con.prepareStatement("SELECT * FROM ril_gradi_tolleranza where diam_da <? AND diam_a>=?");
			pst=con.prepareStatement("SELECT * FROM ril_gradi_tolleranza where diam_da <=? AND diam_a>=?");
			

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



	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviInLavorazione(int id_stato_lavorazione,int anno, Session session) {

		ArrayList<RilMisuraRilievoDTO>  lista = null;
		
		Query query = null;
		if(id_stato_lavorazione !=0) {
			
			
			if(anno !=0) {
				query = session.createQuery("from RilMisuraRilievoDTO where stato_rilievo.id =:_id_stato_lavorazione and disabilitato=0 and YEAR(data_inizio_rilievo) = :_anno");
				query.setParameter("_anno", anno);	
			}else {
				query = session.createQuery("from RilMisuraRilievoDTO where stato_rilievo.id =:_id_stato_lavorazione and disabilitato=0");
			}
			
			query.setParameter("_id_stato_lavorazione", id_stato_lavorazione);
			
		}else {
			
			if(anno !=0) {
				query = session.createQuery("from RilMisuraRilievoDTO where disabilitato=0 and YEAR(data_inizio_rilievo) = :_anno");
				query.setParameter("_anno", anno);	
			}else {
				query = session.createQuery("from RilMisuraRilievoDTO where disabilitato=0");
			}
		}
		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();
				
		
		return lista;
	}



	public static void updateQuota(RilQuotaDTO quota, int id_impronta, Session session) {
		
		Query query = session.createQuery("update RilQuotaDTO set val_nominale = :_val_nominale, coordinata = :_coordinata, "
				+ "tolleranza_positiva = :_tolleranza_positiva, tolleranza_negativa = :_tolleranza_negativa, "
				+ "id_ril_simbolo = :_simbolo, um = :_um, id_quota_funzionale = :_quota_funzionale where id_ripetizione = :_id_ripetizione "
				+ "and id_impronta = :_id_impronta");
		
		query.setParameter("_val_nominale", quota.getVal_nominale());
		query.setParameter("_coordinata", quota.getCoordinata());
		query.setParameter("_tolleranza_positiva", quota.getTolleranza_positiva());
		query.setParameter("_tolleranza_negativa", quota.getTolleranza_negativa());
		query.setParameter("_id_ripetizione", quota.getId_ripetizione());
		query.setParameter("_id_impronta", id_impronta);
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
		
		Integer res= 0;
			Query query = session.createQuery("select max(id_ripetizione) from RilQuotaDTO where impronta.id = :_impronta");
			query.setParameter("_impronta", impronta.getId());
		
			List<Integer> result = (List<Integer>) query.list();
			
			if(result.get(0)!=null) {
				return result.get(0);
			}
			else {
				return res; 
			}
			

	}



	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviFiltrati(int id_stato_lavorazione, int cliente, int anno, Session session) {
		
		ArrayList<RilMisuraRilievoDTO>  lista = null;
		
		Query query = null;
		String s_query = null;
		if(id_stato_lavorazione!=0) {
			s_query = "from RilMisuraRilievoDTO where stato_rilievo.id =:_id_stato_lavorazione and id_cliente_util = :_cliente and disabilitato=0 ";
			if(anno !=0) {
				s_query = s_query +"and YEAR(data_inizio_rilievo) = :_anno";
			}			
		query = session.createQuery(s_query);
		query.setParameter("_id_stato_lavorazione", id_stato_lavorazione);
		}else {
			s_query = "from RilMisuraRilievoDTO where id_cliente_util = :_cliente and disabilitato=0";
			if(anno !=0) {
				s_query = s_query +" and YEAR(data_inizio_rilievo) = :_anno";
			}
			query = session.createQuery(s_query);
			
		}
			
		query.setParameter("_cliente", cliente);
		if(anno !=0) {
			query.setParameter("_anno", anno);
		}
						
		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();
				
		return lista;
	}



	public static RilMisuraRilievoDTO getRilievoFromId(int id_rilievo, Session session) {
		
		ArrayList<RilMisuraRilievoDTO>  lista = null;
		RilMisuraRilievoDTO result = null;
		Query query = session.createQuery("from RilMisuraRilievoDTO where id = :_id");
		query.setParameter("_id", id_rilievo);

		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();
				
		if(lista.size()>0) {
			result = lista.get(0);
		}		

		return result;
		
	}



	public static void uploadAllegato(FileItem item, int id,boolean img, boolean archivio, Session session) {
		
		String filename=item.getName();
		File folder = null;
		if(archivio) {
			folder = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\Archivio\\"+id);
		}else {
			if(img) {
				folder = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\Immagini\\"+id);
			}else {
				folder = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\"+id);	
			}
		}
		
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		File file = new File(folder.getPath() +"\\"+ filename);

			while(true) {		
				try {
					item.write(file);
					
					break;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					break;
				}
				
		
			}
		
	}
	
	public static void updateNoteParticolare(int id_particolare, String note_particolare, Session session) {

		Query query = session.createQuery("update RilParticolareDTO set note = :_note_particolare where id = :_id_particolare");
		query.setParameter("_id_particolare", id_particolare);
		query.setParameter("_note_particolare", note_particolare);

		query.executeUpdate();
		
		
	}



	public static ArrayList<RilAllegatiDTO> getListaFileArchivio(int id_rilievo, Session session) {
		
		ArrayList<RilAllegatiDTO>  lista = null;
		
		Query query = session.createQuery("from RilAllegatiDTO where id_rilievo = :_id_rilievo");
		query.setParameter("_id_rilievo", id_rilievo);

		lista = (ArrayList<RilAllegatiDTO>)query.list();

		return lista;
	}



	public static RilSimboloDTO getSimboloFromDescrizione(String descrizione, Session session) {
		
		ArrayList<RilSimboloDTO>  lista = null;
		RilSimboloDTO result = null;
		Query query = session.createQuery("from RilSimboloDTO where descrizione = :_descrizione");
		query.setParameter("_descrizione", descrizione);

		lista = (ArrayList<RilSimboloDTO>)query.list();
				
		if(lista.size()>0) {
			result = lista.get(0);
		}		

		return result;
	}



	public static ArrayList<RilQuotaDTO> getQuoteImportate(int id_impronta, Session session) {
		
		ArrayList<RilQuotaDTO> lista = null;	
		
		Query query = session.createQuery("from RilQuotaDTO where id_impronta = :_id_impronta and importata=1");
		query.setParameter("_id_impronta", id_impronta);
		lista = (ArrayList<RilQuotaDTO>)query.list();
	
		return lista;
	}

	
	public static ArrayList<String> getListaClientiRilievi(Session session) throws Exception {
		Query query=null;
		
		ArrayList<RilMisuraRilievoDTO> lista=null;
		ArrayList<String> result = new ArrayList<String>();
				
		//String s_query = "select DISTINCT(ril.id_cliente_util) from RilMisuraRilievoDTO as ril";
		String s_query = "from RilMisuraRilievoDTO where disabilitato=0";
						  
	    query = session.createQuery(s_query);
 		
	    lista=(ArrayList<RilMisuraRilievoDTO>)query.list();
	    
	    for (RilMisuraRilievoDTO rilievo : lista) {
			result.add(rilievo.getId_cliente_util()+"_"+rilievo.getNome_cliente_util());
			//rilievo.setNome_cliente_util(GestioneAnagraficaRemotaDAO.getClienteById(String.valueOf(rilievo.getId_cliente_util())).getNome());
			//rilievo.setNome_sede_util(listaSediAll.get(rilievo.getId_cliente_util()+"_"+rilievo.getId_sede_util()));
		}
	    //session.getTransaction().commit();
	    //session.close();
		return result;
	}



	public static RilAllegatiDTO getAllegatoArchivioFromId(int id_allegato, Session session) {
		
		ArrayList<RilAllegatiDTO>  lista = null;
		RilAllegatiDTO result = null;
		Query query = session.createQuery("from RilAllegatiDTO where id = :_id");
		query.setParameter("_id", id_allegato);

		lista = (ArrayList<RilAllegatiDTO>)query.list();
				
		if(lista.size()>0) {
			result = lista.get(0);
		}		

		return result;
		
	}
	
	public static ArrayList<RilMisuraRilievoDTO> getListaRilieviSchedaConsegna(int id_cliente, int id_sede, String mese, String commessa, Session session) {

		ArrayList<RilMisuraRilievoDTO>  lista = null;
	
		Query query = session.createQuery("from RilMisuraRilievoDTO where id_cliente_util = :_id_cliente and id_sede_util = :_id_sede_util and "
				+ "mese_riferimento = :_mese and id_Stato_rilievo = 2 and commessa = :_commessa");
		query.setParameter("_id_cliente", id_cliente);
		query.setParameter("_id_sede_util", id_sede);
		query.setParameter("_mese", mese);
		query.setParameter("_commessa", commessa);

		lista = (ArrayList<RilMisuraRilievoDTO>)query.list();	

		return lista;
	}



	public static int getQuotaRiferimento(int id_particolare, Session session) {
		
		int result = 0;
		ArrayList<Integer> lista = null;
				
		//Query query = session.createQuery("select max(riferimento) from RilQuotaDTO where impronta.misura.id = :_id_rilievo ");
		Query query = session.createQuery("select max(riferimento) from RilQuotaDTO where impronta.id = :_id_particolare ");
		query.setParameter("_id_particolare", id_particolare);
		//query.setParameter("_id_rilievo", id_rilievo);
		

		lista = (ArrayList<Integer>)query.list();	

		if(lista.size()>0 && lista.get(0)!=null) {
			result = lista.get(0);
		}		
		
		return result;
	}



	public static ArrayList<RilQuotaDTO> getQuoteFromImprontaAndRiferimento(int id_impronta, int riferimento, Session session) {
		
		ArrayList<RilQuotaDTO> lista = null;	
		
		Query query = session.createQuery("from RilQuotaDTO where id_impronta = :_id_impronta and riferimento = :_riferimento");
		query.setParameter("_id_impronta", id_impronta);
		query.setParameter("_riferimento", riferimento);
		lista = (ArrayList<RilQuotaDTO>)query.list();
	
		return lista;
	}



	public static int getNumeroPezziCPCPK(int id_particolare, Session session) {
		
		int result = 0;
		ArrayList<Long> lista = null;
		
		Query query = session.createQuery("select count(id) from RilQuotaDTO where id_impronta = :_id_impronta group by riferimento order by count(id) desc");
		query.setParameter("_id_impronta", id_particolare);
		
		lista = (ArrayList<Long>) query.list();
		
		if(lista.size()>0) {
			result = Math.toIntExact(lista.get(0));
		}
		
		return result;
	}



	public static void updateQuotaCpCpk(RilQuotaDTO quota,int id_impronta,String riferimento, Session session) {
		
		Query query = session.createQuery("update RilQuotaDTO set val_nominale = :_val_nominale, coordinata = :_coordinata, "
				+ "tolleranza_positiva = :_tolleranza_positiva, tolleranza_negativa = :_tolleranza_negativa, "
				+ "id_ril_simbolo = :_simbolo, um = :_um, id_quota_funzionale = :_quota_funzionale, note = :_note where "
				+ "id_impronta = :_id_impronta and riferimento= :_riferimento");
		
		query.setParameter("_val_nominale", quota.getVal_nominale());
		query.setParameter("_coordinata", quota.getCoordinata());
		query.setParameter("_tolleranza_positiva", quota.getTolleranza_positiva());
		query.setParameter("_tolleranza_negativa", quota.getTolleranza_negativa());
	//	query.setParameter("_id_ripetizione", quota.getId_ripetizione());
		query.setParameter("_id_impronta", id_impronta);
		query.setParameter("_um", quota.getUm());
		query.setParameter("_note", quota.getNote());
		query.setParameter("_riferimento", Integer.parseInt(riferimento));

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


	
}
