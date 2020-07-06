package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ComuneDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.SedeDTO;

public class GestioneAnagraficaRemotaDAO {
	
	
	public static List<ClienteDTO> getListaClienti(String id_company) throws Exception  {
		
		List<ClienteDTO> lista =new ArrayList<ClienteDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN WHERE TOK_COMPANY LIKE ? ORDER BY NOME ASC");
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
	
	public static List<SedeDTO> getListaSedi() throws SQLException {
		List<SedeDTO> lista =new ArrayList<SedeDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN_INDIR ");
			rs=pst.executeQuery();
			
			SedeDTO sede=null;
			
			while(rs.next())
			{
				sede= new SedeDTO();
				sede.set__id(rs.getInt("K2_ANAGEN_INDIR"));
				sede.setId__cliente_(rs.getInt("ID_ANAGEN"));
				sede.setComune(rs.getString("CITTA"));
				sede.setIndirizzo(rs.getString("INDIR"));
				sede.setSiglaProvincia(rs.getString("CODPROV"));
				sede.setDescrizione(rs.getString("DESCR"));
				sede.setCap(rs.getString("CAP")); 
				sede.setN_REA(rs.getString("NREA"));
				
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
	
	public static HashMap<String, String> getListaNominativiSediClienti() throws SQLException {
		
		HashMap<String, String> lista =new HashMap<String, String>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT DESCR,K2_ANAGEN_INDIR, ID_ANAGEN FROM BWT_ANAGEN_INDIR");
			
			rs=pst.executeQuery();
			
	
			
			while(rs.next())
			{
				lista.put(rs.getString("K2_ANAGEN_INDIR")+"_"+rs.getString("ID_ANAGEN"), rs.getString("DESCR"));
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


		public static HashMap<String, String> getListaNominativiClienti() throws SQLException {
			
			HashMap<String, String> lista =new HashMap<String, String>();
			
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			try {
				con=ManagerSQLServer.getConnectionSQL();
				pst=con.prepareStatement("SELECT ID_ANAGEN,NOME FROM BWT_ANAGEN");
				rs=pst.executeQuery();
				
				
				
				while(rs.next())
				{
					lista.put(rs.getString("ID_ANAGEN"), rs.getString("NOME"));
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
		
		public static ClienteDTO getClienteById(String id_cliente) throws Exception  {
			
			
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			ClienteDTO cliente=null;
			try {
				con=ManagerSQLServer.getConnectionSQL();
				pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN WHERE ID_ANAGEN = "+ id_cliente);
				//pst.setString(1, "%"+id_cliente+"%");
				rs=pst.executeQuery();
				
				while(rs.next())
				{
					cliente= new ClienteDTO();
					cliente.set__id(rs.getInt("ID_ANAGEN"));
					cliente.setNome(rs.getString("NOME"));
					cliente.setPartita_iva(rs.getString("PIVA"));
					cliente.setCf(rs.getString("CODFIS"));
					cliente.setTelefono(rs.getString("TELEF01"));
					cliente.setCodice(rs.getString("CODCLI"));
					cliente.setIndirizzo(rs.getString("INDIR"));
					cliente.setCap(rs.getString("CAP"));
					cliente.setCitta(rs.getString("CITTA"));
					cliente.setProvincia(rs.getString("CODPROV"));
					cliente.setNumeroREA(rs.getString("N_REA"));
					cliente.setEmail(rs.getString("EMAIL"));
					
				}
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			return cliente;
		}

	public static FornitoreDTO getFornitoreById(String id_fornitore) throws Exception {
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		FornitoreDTO fornitore=null;
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN WHERE ID_ANAGEN = "+ id_fornitore);
			rs=pst.executeQuery();
			
			while(rs.next())
			{
				fornitore= new FornitoreDTO();
				fornitore.setDenominazione(rs.getString("NOME"));
				fornitore.setIndirizzo(rs.getString("INDIR"));
				fornitore.setCap(rs.getString("CAP"));
				fornitore.setCitta(rs.getString("CITTA"));
				fornitore.setProvincia(rs.getString("CODPROV"));
			}
			
		} catch (Exception e) {
			
			throw e;

			
		}finally
		{
			pst.close();
			con.close();
		}
		
		return fornitore;
	}
		
	public static ClienteDTO getClienteFromSede(String id_cliente,String id_sede) throws Exception  {
		
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		ClienteDTO cliente=null;
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT *, BWT_ANAGEN_INDIR.TELEF01 as tel,BWT_ANAGEN_INDIR.NREA as numeroREASede,BWT_ANAGEN_INDIR.CITTA as citta_sede,"
					+ "BWT_ANAGEN_INDIR.CAP as cap_sede,BWT_ANAGEN_INDIR.CODPROV as codProvSede,BWT_ANAGEN_INDIR.INDIR as indirizzoSede "
					+ "FROM BWT_ANAGEN JOIN BWT_ANAGEN_INDIR ON BWT_ANAGEN_INDIR.ID_ANAGEN=BWT_ANAGEN.ID_ANAGEN WHERE BWT_ANAGEN_INDIR.ID_ANAGEN = " +id_cliente+ " AND K2_ANAGEN_INDIR = "+id_sede);
			//pst.setString(1, "%"+id_cliente+"%");
			rs=pst.executeQuery();
			
			while(rs.next())
			{
				cliente= new ClienteDTO();
				cliente.set__id(rs.getInt("ID_ANAGEN"));
				cliente.setNome(rs.getString("NOME"));
				cliente.setPartita_iva(rs.getString("PIVA"));
				cliente.setTelefono(rs.getString("tel"));
				cliente.setCodice(rs.getString("CODCLI"));
				cliente.setCf(rs.getString("CODFIS"));
				cliente.setIndirizzo(rs.getString("indirizzoSede"));
				cliente.setCap(rs.getString("cap_sede"));
				cliente.setProvincia(rs.getString("codProvSede"));
				cliente.setCitta(rs.getString("citta_sede"));
				cliente.setNumeroREA(rs.getString("numeroREASede"));
				cliente.setEmail(rs.getString("EMAIL"));
			}
			
		} catch (Exception e) {
			
			throw e;
		//	e.printStackTrace();
			
		}finally
		{
			pst.close();
			con.close();
		}
		
		return cliente;
	}





		
		
		public static List<ClienteDTO> getListaFornitori(String id_company) throws Exception  {
			
			List<ClienteDTO> lista =new ArrayList<ClienteDTO>();
			
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			try {
				con=ManagerSQLServer.getConnectionSQL();
				pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN WHERE TOK_COMPANY LIKE ? AND TIPO LIKE ?");
				pst.setString(1, "%"+id_company+"%");
				pst.setString(2, "%FOR%");
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

		public static HashMap<String, String> getListaSedeAll() throws Exception {
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			HashMap<String, String> listaSedi= new HashMap<>();
			
			try {
				con=ManagerSQLServer.getConnectionSQL();
				pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN_INDIR");
				
				rs=pst.executeQuery();
				
			
				
				while(rs.next())
				{
					listaSedi.put(rs.getInt("ID_ANAGEN")+"_"+rs.getInt("K2_ANAGEN_INDIR"), rs.getString("DESCR"));
					
				}
			
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			return listaSedi;
		}
		
		public static HashMap<Integer, String> getListaClientiAll() throws Exception {
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			HashMap<Integer, String> listaSedi= new HashMap<>();
			
			try {
				con=ManagerSQLServer.getConnectionSQL();
				pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN");
				
				rs=pst.executeQuery();
				
			
				
				while(rs.next())
				{
					listaSedi.put(rs.getInt("ID_ANAGEN"), rs.getString("NOME"));
				}
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			return listaSedi;
		}

		public static String getCodiceComune(String citta) throws Exception {
			PreparedStatement pst=null;
			ResultSet rs= null;
			Connection con=null;
			try{
				con=ManagerSQLServer.getConnectionSQL();
				
				pst=con.prepareStatement("SELECT * FROM BWT_COMUNI WHERE COMUNE=?");
				
				pst.setString(1,citta);
				rs=pst.executeQuery();
				rs.next();
			 String toReturn=rs.getString("COD_ISTAT");
				
				if(toReturn.length()>3) 
				{
					return toReturn.substring(toReturn.length()-3,toReturn.length());
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

			return "0";
		}

		public static String getProvinciaFromSigla(String sigla, Session session) {
			
			String provincia = null;
			ArrayList<String> result = null;
			Query query = session.createQuery("select nome from ProvinciaDTO where sigla =:_sigla");
			query.setParameter("_sigla", sigla);
			
			result = (ArrayList<String>) query.list();
			if(result.size()>0) {
				provincia = result.get(0);
			}
			
			return provincia;
		}

		public static ArrayList<ComuneDTO> getListaComuni(Session session) {
			
			ArrayList<ComuneDTO> lista = null;
			Query query = session.createQuery("from ComuneDTO ");
			
			lista = (ArrayList<ComuneDTO>) query.list();			
			
			return lista;
		}	
		

}
