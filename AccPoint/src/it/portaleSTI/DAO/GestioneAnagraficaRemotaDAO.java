package it.portaleSTI.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ComuneDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;

public class GestioneAnagraficaRemotaDAO {
	
	
	public static List<ClienteDTO> getListaClienti(String id_company) throws Exception  {
		
		List<ClienteDTO> lista =new ArrayList<ClienteDTO>();
		
		Connection con=null;
		PreparedStatement pst = null;
		ResultSet rs=null;
		
		try {
			con=ManagerSQLServer.getConnectionSQL();
			pst=con.prepareStatement("SELECT * FROM BWT_ANAGEN WHERE TOK_COMPANY LIKE ? AND TIPO <> 'OBS' ORDER BY ID_ANAGEN ASC");
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
			pst=con.prepareStatement("SELECT a.*,(SELECT DESCR FROM BWT_PROVINCE b WHERE a.CODPROV = b.CODPROV) as provincia FROM BWT_ANAGEN_INDIR a");
			rs=pst.executeQuery();
			
			SedeDTO sede=null;
			
			while(rs.next())
			{
				sede= new SedeDTO();
				sede.set__id(rs.getInt("K2_ANAGEN_INDIR"));
				sede.setId__cliente_(rs.getInt("ID_ANAGEN"));
				sede.setComune(rs.getString("CITTA"));
				sede.setIndirizzo(rs.getString("INDIR"));
				//sede.setSiglaProvincia(rs.getString("CODPROV"));
				sede.setSiglaProvincia(rs.getString("provincia"));
				sede.setDescrizione(rs.getString("DESCR"));
				sede.setCap(rs.getString("CAP")); 
				sede.setN_REA(rs.getString("NREA"));
				sede.setId_encrypted(Utility.encryptData(""+sede.get__id()));
				sede.setId_cliente_encrypted(Utility.encryptData(""+sede.getId__cliente_()));
				
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
					cliente.setPec(rs.getString("EMAIL_PEC"));
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
				cliente.setPec(rs.getString("EMAIL_PEC"));
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

		
		
		public static ArrayList<ClienteDTO> GestioneAnagraficaRemotaDAO(UtenteDTO utente,String indirizzo, Session session, boolean test) throws Exception {
			List<ClienteDTO> lista =new ArrayList<ClienteDTO>();
			
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			try {
				
				String codage = "";
				if(utente.checkRuolo("VC")) {
					codage = " WHERE a.CODAGE = ? ";
				}
				
				String q = "SELECT distinct b.ID_ANAGEN, b.NOME FROM BWT_ANAGEN_AGENTI AS a JOIN BWT_ANAGEN AS b ON a.ID_ANAGEN = b.ID_ANAGEN" +codage;
				
				if(indirizzo!=null && indirizzo.equals("1")) {
					 q = "SELECT distinct b.ID_ANAGEN, b.NOME, b.INDIR, b.CAP, b.CITTA, b.CODPROV FROM BWT_ANAGEN_AGENTI AS a JOIN BWT_ANAGEN AS b ON a.ID_ANAGEN = b.ID_ANAGEN" +codage;
				}
				
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				pst=con.prepareStatement(q);
				if(utente.checkRuolo("VC")) {
					pst.setString(1, utente.getCodice_agente());
				}
				rs=pst.executeQuery();
				
				ClienteDTO cliente=null;
				
				while(rs.next())
				{
					cliente= new ClienteDTO();
					cliente.set__id(rs.getInt("ID_ANAGEN"));
					cliente.setNome(rs.getString("NOME"));
					if(indirizzo!=null && indirizzo.equals("1")) {
						cliente.setIndirizzo(rs.getString("INDIR"));
						cliente.setCap(rs.getString("CAP"));
						cliente.setCitta(rs.getString("CITTA"));
						cliente.setProvincia(rs.getString("CODPROV"));
					}else {
						cliente.setIdEncrypted(Utility.encryptData(cliente.get__id()+""));
					}
					
					
					
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
			
			return (ArrayList<ClienteDTO>) lista;
		}

		public static ArrayList<ArticoloMilestoneDTO> getListaArticoliAgente(UtenteDTO utente, Session session, boolean test) throws Exception {

			List<ArticoloMilestoneDTO> lista =new ArrayList<ArticoloMilestoneDTO>();
			
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			try {
				String tb_gruppo = "AND TB_GRUPPO IN (SELECT TB_SERVIZIO FROM BWT_AGENTI_SERVIZI WHERE CODAGE = ? ) ";
				
				if(utente.checkRuolo("AM") || utente.checkRuolo("VE")) {
					tb_gruppo = "AND TB_GRUPPO = 'VER_PER'";
				}
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				pst=con.prepareStatement("SELECT distinct articolo.ID_ANAART, articolo.DESCR, listino.PREZZO FROM BWT_ANAART as articolo JOIN PJT_LISTINO_CLIFOR AS listino ON articolo.ID_ANAART = listino.ID_ANAART  where STATO = 'USO'  " + tb_gruppo);
				if(utente.checkRuolo("VC")) {
					pst.setString(1, utente.getCodice_agente());
				}
				rs=pst.executeQuery();
				
				ArticoloMilestoneDTO articolo=null;
				
				while(rs.next())
				{
					articolo= new ArticoloMilestoneDTO();
					articolo.setID_ANAART(rs.getString("ID_ANAART"));
					articolo.setDESCR(rs.getString("DESCR"));
					articolo.setImporto(rs.getDouble("PREZZO"));
				
					
					lista.add(articolo);
				}
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			return (ArrayList<ArticoloMilestoneDTO>) lista;
			
			
		}

		public static ArticoloMilestoneDTO getArticoloAgenteFromId(String id_articolo, boolean test) throws Exception{

		
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			ArticoloMilestoneDTO articolo=null;
			
			try {
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				pst=con.prepareStatement("SELECT articolo.ID_ANAART, articolo.DESCR, listino.PREZZO FROM BWT_ANAART as articolo JOIN PJT_LISTINO_CLIFOR AS listino ON articolo.ID_ANAART = listino.ID_ANAART  where articolo.ID_ANAART = ? ");
				pst.setString(1, id_articolo);
				rs=pst.executeQuery();
				
				
				
				while(rs.next())
				{
					articolo= new ArticoloMilestoneDTO();
					articolo.setID_ANAART(rs.getString("ID_ANAART"));
					articolo.setDESCR(rs.getString("DESCR"));
					articolo.setImporto(rs.getDouble("PREZZO"));
				
									}
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			return articolo;
		}

		public static boolean checkPartitaIva(String partita_iva, boolean test) throws Exception {
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			boolean esito=false;
			
			try {
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				pst=con.prepareStatement("SELECT ID_ANAGEN from BWT_ANAGEN where PIVA = ? ");				
				pst.setString(1, partita_iva);
				rs=pst.executeQuery();
				
				int result = 0;
				
				while(rs.next())
				{
					 result = rs.getInt("ID_ANAGEN");
					
				}
				
				if(result!=0) {
					esito = true;
				}
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			return esito;
		}

		public static void insertCliente(ClienteDTO cl,SedeDTO sede, int idCompany, String codage, boolean test) throws Exception {


			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			boolean esito=false;
			
			try {
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				//pst=con.prepareStatement("INSERT INTO BWT_ANAGEN (NOME, INDIR, TELEF01, CAP, PIVA, CODPROV, CITTA, EMAIL, CODFIS, TIPO, SYS_DTCREAZ, TOK_COMPANY, CODREGI, CODNAZI) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?) ",Statement.RETURN_GENERATED_KEYS);
				pst = con.prepareStatement(
					    "INSERT INTO BWT_ANAGEN (" +
					    "NOME, INDIR, TELEF01, CAP, PIVA, CODPROV, CITTA, EMAIL, CODFIS, TIPO, SYS_DTCREAZ, TOK_COMPANY, CODREGI, CODNAZI, EMAIL_PEC, COD_DEST_FATTELE, CODCOMUNE" +
					    ") " +
					    "SELECT ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, c.CODCOMUNE " +
					    "FROM BWT_COMUNI c " +
					    "WHERE LOWER(c.COMUNE) = LOWER(?)",
					    Statement.RETURN_GENERATED_KEYS
					);
				pst.setString(1, cl.getNome());
				pst.setString(2, cl.getIndirizzo());
				pst.setString(3, cl.getTelefono());
				pst.setString(4, cl.getCap());
				pst.setString(5, cl.getPartita_iva());
				pst.setString(6, cl.getProvincia());
				pst.setString(7, cl.getCitta());
				pst.setString(8, cl.getEmail());
				pst.setString(9, cl.getCf());
				pst.setString(10, "CLI");
				long today = new java.util.Date().getTime();
				pst.setDate(11, new java.sql.Date(today));
				String company = "4132";
				if(idCompany!=4132) {
					company+=","+idCompany;
				}
				pst.setString(12, company);
				pst.setString(13, cl.getRegione());
				pst.setString(14, "IT");
				pst.setString(15, cl.getPec());
				pst.setString(16, cl.getCodice());
				pst.setString(17, cl.getCitta());
				pst.execute();
				
				rs = pst.getGeneratedKeys();
				int idClienteGenerato = -1;
				if (rs.next()) {
					idClienteGenerato = rs.getInt(1);
				}
				
				
				
				if(sede!=null) {
					pst=con.prepareStatement("INSERT INTO BWT_ANAGEN_INDIR (ID_ANAGEN, K2_ANAGEN_INDIR, DESCR, CAP, CODPROV, CITTA, SYS_DTCREAZ, TB_TIPO, CODREGI) VALUES (?,?,?,?,?,?,?,?,?) ",Statement.RETURN_GENERATED_KEYS);
					pst.setInt(1, idClienteGenerato);
					pst.setInt(2, 1);
					pst.setString(3, sede.getDescrizione());
					pst.setString(4, sede.getCap());
					pst.setString(5, sede.getSiglaProvincia());
					pst.setString(6, sede.getComune());
					today = new java.util.Date().getTime();
					pst.setDate(7, new java.sql.Date(today));	
					pst.setString(8, "ND");
					pst.setString(9, sede.getRegione());
					pst.execute();
				}
				
				
				rs = pst.getGeneratedKeys();
				int idSedeGenerato = 0;
				if (rs.next()) {
					idSedeGenerato = rs.getInt(1);
				}
				
				if(idClienteGenerato>-1 && codage!=null) {
					pst=con.prepareStatement("INSERT INTO BWT_ANAGEN_AGENTI (ID_ANAGEN, ID_COMPANY, K2_ANAGEN_INDIR, CODAGE, SYS_DTCREAZ) VALUES (?,?,?,?,?) ");
					pst.setInt(1, idClienteGenerato);
					pst.setInt(2, idCompany);
					pst.setInt(3, idSedeGenerato);
					pst.setString(4, codage);
					today = new java.util.Date().getTime();
					pst.setDate(5, new java.sql.Date(today));
					pst.execute();
					
				}
		
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			
		}

		public static String getIdOffertaFromChiaveGlobale(String id_nh, boolean test) throws Exception {
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			String id_offerta= null;
		
			try {
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				
				pst=con.prepareStatement("SELECT ID_OFFERTA from BWT_OFFERTA where GLB_ORIGINE = ? ");				
				pst.setString(1, "BWT_SFA_ORDINE~|~"+id_nh);
				rs=pst.executeQuery();
				
				int result = 0;
				
				while(rs.next())
				{
					id_offerta = rs.getString("ID_OFFERTA");
					
				}
			
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			return id_offerta;
		}

		public static void updateSedeOfferta(String id_offerta, String sede_decrypted, String cliente_decrypted, boolean test) throws Exception {
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			boolean esito=false;
			
			try {
				if(test) {
					con=ManagerSQLServer.getConnectionSQLTest();
				}else {
					con=ManagerSQLServer.getConnectionSQL();	
				}
				
				//pst=con.prepareStatement("INSERT INTO BWT_ANAGEN (NOME, INDIR, TELEF01, CAP, PIVA, CODPROV, CITTA, EMAIL, CODFIS, TIPO, SYS_DTCREAZ, TOK_COMPANY, CODREGI, CODNAZI) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?) ",Statement.RETURN_GENERATED_KEYS);
				pst = con.prepareStatement(
					    "UPDATE BWT_OFFERTA SET GLB_INDIRIZZO_SEDE = ? WHERE ID_OFFERTA = ?"
					);
				if(sede_decrypted.equals("0")) {
					pst.setString(1, "BWT_ANAGEN~|~"+cliente_decrypted);
				}else {
					pst.setString(1, "BWT_ANAGEN_INDIR~|~"+cliente_decrypted+"~|~"+sede_decrypted.split("_")[0]);
				}
				
				pst.setString(2, id_offerta);
				
				pst.executeUpdate();
				
		
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
		}

		public static Map<String, String> getStatoCommessaOfferte() throws Exception {
			Connection con=null;
			PreparedStatement pst = null;
			ResultSet rs=null;
			
			Map<String,String> map = new HashMap<String,String>();
			try {
				con=ManagerSQLServer.getConnectionSQL();
				pst=con.prepareStatement("SELECT a.ID_OFFERTA, (SELECT ID_COMMESSA from BWT_OFFERTA_ITEMS b WHERE a.ID_OFFERTA=b.ID_OFFERTA AND b.K2_RIGA=1)  AS 'ID COMMESSA' ,a.SYS_STATO"
						+"  FROM BWT_OFFERTA a");			
				rs=pst.executeQuery();
				
			
				while(rs.next())
				{
					String id_offerta = rs.getString("ID_OFFERTA");
					String stato = rs.getString("SYS_STATO");
					String id_commessa = rs.getString("ID COMMESSA");
					if(id_commessa == null) {
						id_commessa = "";
					}
					if(stato.equals("0INCOMPILAZIONE")) {
						stato = "IN COMPILAZIONE";
					}
					if(stato.equals("1EMESSA")) {
						stato = "EMESSA";
					}
					if(stato.startsWith("1CHIUSA")) {
						stato = "CHIUSA";
					}
					map.put(id_offerta, stato+";"+id_commessa);
					
				}
			
				
			} catch (Exception e) {
				
				throw e;
			//	e.printStackTrace();
				
			}finally
			{
				pst.close();
				con.close();
			}
			
			return map;
		}	

}
