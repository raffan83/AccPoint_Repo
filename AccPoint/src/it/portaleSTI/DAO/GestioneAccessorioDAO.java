package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.UtenteDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


public class GestioneAccessorioDAO {

	public static ArrayList<AccessorioDTO> getListaAccessori(CompanyDTO cmp, Session session) {
		Query query  = session.createQuery( "from AccessorioDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		ArrayList<AccessorioDTO> result =(ArrayList<AccessorioDTO>) query.list();
		
		return result;
	}

	public static int saveAccessorio(AccessorioDTO accessorio, String action, Session session) {
		int toRet=0;
		
		try{
		int idAccessorio=0;
		
		if(action.equals("modifica") || action.equals("caricoscarico")){
			session.update(accessorio);
			idAccessorio=accessorio.getId();
		}
		else if(action.equals("nuovo")){
			idAccessorio=(Integer) session.save(accessorio);

		}
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
	}

	public static AccessorioDTO getAccessorioById(String id, Session session) {

		Query query  = session.createQuery( "from AccessorioDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<AccessorioDTO> result =query.list();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}
	
	public static AccessorioDTO getAccessorioById(String id) {
		
	
		Session	session = SessionFacotryDAO.get().openSession();
		    
		session.beginTransaction();
			
		
		
		Query query  = session.createQuery( "from AccessorioDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<AccessorioDTO> result =query.list();
		
		session.getTransaction().commit();
		session.close();
		
		if(result.size()>0)
		{
			
			return result.get(0);
		}
		
		return null;
	}

	public static int deleteAccessorio(AccessorioDTO accessorio, Session session) {
		int toRet=0;
		try{
			session.delete(accessorio);
			toRet=0;	
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;

		}
		return toRet;
	}

	public static ArrayList<TipologiaAccessoriDTO> getListaTipologieAccessori(Session session) {
		Query query  = session.createQuery( "from TipologiaAccessoriDTO");
		
		ArrayList<TipologiaAccessoriDTO> result =(ArrayList<TipologiaAccessoriDTO>) query.list();
		
		return result;
	}

	public static void inserisciAssociazioneArticoloAccessorio(String idArticolo, int idAccessorio,int quantita,int idCompany,int idUser) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("INSERT INTO articolo_accessorio VALUES(?,?,?,?,?)");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idAccessorio);		
			pst.setInt(3, quantita);
			pst.setInt(4, idUser);
			pst.setInt(5, idCompany);
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		finally{
			pst.close();
			con.close();
		}
	}

	public static void deleteAssociazioneArticoloAccessorio(String idArticolo,int idAccessorio) throws Exception {
		
		Connection con=null;
		PreparedStatement pst=null;
		
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("DELETE  FROM articolo_accessorio WHERE id_articolo=? AND id_accessorio=?");
			
			pst.setString(1, idArticolo);
			pst.setInt(2, idAccessorio);		
		
			pst.execute();
		} 
		catch (Exception e) 
		{
		 throw e;
		}
		finally{
			pst.close();
			con.close();
		}
		
	}

	public static ArrayList<AccessorioDTO> getListaAccessoriByArticolo(CompanyDTO company, String codiceArticolo) throws Exception {
		
		
		Connection con=null;
		PreparedStatement pst=null;
		ResultSet rs = null;
		 ArrayList<AccessorioDTO> listaAccessori = new  ArrayList<AccessorioDTO>();
		try 
		{
			con=DirectMySqlDAO.getConnection();
			
			pst=con.prepareStatement("SELECT *, c.id as idTipologia, d.id as idCompany, u.id as idUser FROM accessorio a "
					+ "LEFT JOIN articolo_accessorio b ON a.id = b.id_accessorio "
					+ "LEFT JOIN tipologia_accessori c ON a.tipologia_id = c.id "
					+ "LEFT JOIN users u ON a.idUser = u.ID "
					+ "LEFT JOIN company d ON a.company_id = d.id WHERE b.id_articolo=?");
			
			pst.setString(1, codiceArticolo);
			
			rs = pst.executeQuery();
			AccessorioDTO accessorio = null;
			TipologiaAccessoriDTO tipologia = null;
			UtenteDTO user = null;
			CompanyDTO cmp = null;
			while(rs.next()) {
				accessorio = new AccessorioDTO();
				accessorio.setId(rs.getInt("a.id"));
				accessorio.setNome(rs.getString("a.nome"));
				accessorio.setDescrizione(rs.getString("a.descrizione"));
				accessorio.setQuantitaFisica(rs.getInt("a.quantita_fisica"));
				accessorio.setQuantitaPrenotata(rs.getInt("a.quantita_prenotata"));
				accessorio.setQuantitaNecessaria(rs.getInt("b.quantita"));
				accessorio.setComponibile(rs.getString("a.componibile"));
				accessorio.setIdComponibili(rs.getString("a.id_componibili"));
				accessorio.setCapacita(rs.getInt("a.capacita"));
				accessorio.setUnitaMisura(rs.getString("a.um"));
				
				tipologia = new TipologiaAccessoriDTO();
				tipologia.setId(rs.getInt("idTipologia"));
				tipologia.setCodice(rs.getString("c.codice"));
				tipologia.setDescrizione(rs.getString("c.descrizione"));
				accessorio.setTipologia(tipologia);
				
				user = new UtenteDTO();
				user.setId(rs.getInt("idUser"));
				accessorio.setUser(user);
				
				cmp = new CompanyDTO();
				cmp.setId(rs.getInt("idCompany"));
				accessorio.setCompany(cmp);
				
				listaAccessori.add(accessorio);
			}
		} 
		catch (Exception e) 
		{
			throw e;
		}
		finally{
			pst.close();
			con.close();
		}
		return listaAccessori;
	}

}
