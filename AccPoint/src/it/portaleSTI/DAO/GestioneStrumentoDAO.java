package it.portaleSTI.DAO;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneStrumentoDAO {

	public static List<StrumentoDTO> getListaStrumentiPerSede(String idSede) throws HibernateException, Exception
	{
	Session session=SessionFacotryDAO.get().openSession();
	List<StrumentoDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_id_sede");
	
			query.setParameter("_id_sede", Integer.parseInt(idSede));
			
	
	lista=query.list();
	
	
	session.getTransaction().commit();
	session.close();
	
	return lista;
	}
	
	public static List<TipoStrumentoDTO> getListaTipoStrumento() throws HibernateException, Exception
	{
	Session session=SessionFacotryDAO.get().openSession();
	List<TipoStrumentoDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from TipoStrumentoDTO Order BY nome ASC");

	lista=query.list();
	
	session.getTransaction().commit();
	session.close();

	return lista;
	}
	
	public static List<TipoRapportoDTO> getListaTipoRapporto() throws HibernateException, Exception
	{
	Session session=SessionFacotryDAO.get().openSession();
	List<TipoRapportoDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from TipoRapportoDTO Order BY nome ASC");

	lista=query.list();
	
	session.getTransaction().commit();
	session.close();
	
	return lista;
	}

	public static List<ClienteDTO> getListaClienti() throws HibernateException, Exception {
		Session session=SessionFacotryDAO.get().openSession();
		List<ClienteDTO> lista =null;
		
		session.beginTransaction();
		Query query  = session.createQuery( "from ClienteDTO Order BY nome ASC" );
		
		lista=query.list();
		
		session.getTransaction().commit();
		session.close();
		
		return lista;
	}
	
	public static List<ClienteDTO> getListaClientiNew(String id_company) throws Exception  {
		
		List<ClienteDTO> lista =new ArrayList<ClienteDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN WHERE TOK_COMPANY LIKE ?");
			pst.setString(1, "%"+id_company+"%");
			rs=pst.executeQuery();
			
			ClienteDTO cliente=null;
			
			while(rs.next())
			{
				cliente= new ClienteDTO();
				cliente.set__id(rs.getInt("ID_ANAGEN"));
				cliente.setNome(rs.getString("NOME"));
				
				lista.add(cliente);
			}
			
		} catch (Exception e) {
			
			throw e;
		//	e.printStackTrace();
			
		}finally
		{
			pst.close();
			con.close();
		}
		
		return lista;
	}
	
public static List<SedeDTO> getListaSedi() throws HibernateException, Exception {
		
		Session session=SessionFacotryDAO.get().openSession();
		List<SedeDTO> lista =null;
		
		session.beginTransaction();
		Query query  = session.createQuery( "from SedeDTO Order BY id__cliente_ ASC" );
		
		lista=query.list();
		
		session.getTransaction().commit();
		session.close();
		
		return lista;
	}

public static List<SedeDTO> getListaSediNEW() throws SQLException {
	List<SedeDTO> lista =new ArrayList<SedeDTO>();
	
	Connection con=null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
	try {
		con=ManagerSQLServer.getConnectionSQL();
		pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN_INDIR");
		rs=pst.executeQuery();
		
		SedeDTO sede=null;
		
		while(rs.next())
		{
			sede= new SedeDTO();
			sede.set__id(rs.getInt("K2_ANAGEN_INDIR"));
			sede.setId__cliente_(rs.getInt("ID_ANAGEN"));
			sede.setComune(rs.getString("LOCALITA"));
			sede.setIndirizzo(rs.getString("INDIR"));
			sede.setDescrizione(rs.getString("DESCR"));
			
			
			lista.add(sede);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally
	{
		pst.close();
		con.close();
	}
	
	return lista;
}


public static List<TipoMisuraDTO> getListaTipiMisura(String tpS) throws HibernateException, Exception {
	Session session=SessionFacotryDAO.get().openSession();
	List<TipoMisuraDTO> lista =null;
	
	session.beginTransaction();
	Query query  = session.createQuery( "from TipoMisuraDTO WHERE id__tipo_strumento_= :_id_tipo_strumento");
	
			query.setParameter("_id_tipo_strumento", Integer.parseInt(tpS));
			
	
	lista=query.list();
	
	
	session.getTransaction().commit();
	session.close();
	
	return lista;
}

public static StrumentoDTO getStrumentoById(String id)throws HibernateException, Exception {
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	Query query  = session.createQuery( "from StrumentoDTO WHERE id= :_id");
	
	query.setParameter("_id", Integer.parseInt(id));
	List<StrumentoDTO> result =query.list();
	if(result.size()>0)
	{			
		return result.get(0);
	}
	return null;
	
}

public static ArrayList<StrumentoDTO> getListaStrumenti(String idCliente,String idSede, Integer idCompany, Session session) throws Exception {
	
	ArrayList<StrumentoDTO> lista =null;
	
	session.beginTransaction();
	
	Query query  = session.createQuery( "from StrumentoDTO WHERE id__sede_= :_idSede AND company.id=:_idCompany AND id_cliente=:_idcliente");
	
			query.setParameter("_idSede", Integer.parseInt(idSede));
			query.setParameter("_idCompany", idCompany);
			query.setParameter("_idcliente",  Integer.parseInt(idCliente));
			
	
	lista=(ArrayList<StrumentoDTO>) query.list();
	
	return lista;
}

public static ArrayList<MisuraDTO> getListaMirureByStrumento(int idStrumento) {

		Query query=null;
		
		ArrayList<MisuraDTO> misura=null;
		try {
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		
		String s_query = "from MisuraDTO WHERE strumento.__id = :_idStrumento";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_idStrumento",idStrumento);
		
	    misura=(ArrayList<MisuraDTO>)query.list();

	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}

}
