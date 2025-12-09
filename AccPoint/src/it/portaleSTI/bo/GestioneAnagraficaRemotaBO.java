package it.portaleSTI.bo;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneAnagraficaRemotaDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ComuneDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneAnagraficaRemotaBO {

	
	public static List<ClienteDTO> getListaClienti(String id_company) throws HibernateException, Exception {

		return GestioneAnagraficaRemotaDAO.getListaClienti(id_company);
	}
	

	public static List<SedeDTO> getListaSedi() throws SQLException {

		return GestioneAnagraficaRemotaDAO.getListaSedi();
	}
	
	public static HashMap<String, String> getListaNominativiSediClienti() throws SQLException
	{
		return GestioneAnagraficaRemotaDAO.getListaNominativiSediClienti();
	}

	public static HashMap<String, String> getListaNominativiClienti() throws SQLException
	{
		return GestioneAnagraficaRemotaDAO.getListaNominativiClienti();
	}
	
	public static ClienteDTO getClienteById(String id_cliente) throws Exception {
		
		return GestioneAnagraficaRemotaDAO.getClienteById(id_cliente);
	}
	public static FornitoreDTO getFornitoreByID(String id_fornitore) throws Exception
	{
		return GestioneAnagraficaRemotaDAO.getFornitoreById(id_fornitore);
	}
	
	
	public static ClienteDTO getClienteFromSede(String id_cliente, String id_sede) throws Exception {
		
		return GestioneAnagraficaRemotaDAO.getClienteFromSede(id_cliente, id_sede);
	}

	public static List<ClienteDTO> getListaFornitori(String id_company) throws Exception {
		
		return GestioneAnagraficaRemotaDAO.getListaFornitori(id_company);
	}
	
	public static SedeDTO getSedeFromId(List<SedeDTO> listaSedi, int id_sede, int id_cliente) {
		
		SedeDTO sede= null;
		
		for (SedeDTO iterator : listaSedi) {
			if(iterator.get__id()==id_sede && iterator.getId__cliente_()==id_cliente) {
				sede = iterator;
				
			}
		}
		
		
		return sede;
	}
	
	public static ArrayList<SedeDTO> getSediFromCliente(List<SedeDTO> listaSedi, int id_cliente) {
		
		ArrayList<SedeDTO> sedi= new ArrayList<SedeDTO>();
		
		for (SedeDTO iterator : listaSedi) {
			if(iterator.getId__cliente_()==id_cliente) {
				
				sedi.add(iterator);
			}
		}
		
		
		return sedi;
	}
	
	
	public static HashMap<String, String> getListaSediAll() throws Exception
	{
		return GestioneAnagraficaRemotaDAO.getListaSedeAll();
	}
	
	public static HashMap<Integer, String> getListaClientiAll() throws Exception
	{
		return GestioneAnagraficaRemotaDAO.getListaClientiAll();
	}


	public static String getCodiceComune(String citta) throws Exception {
		
		return GestioneAnagraficaRemotaDAO.getCodiceComune(citta);
	}


	public static String getProvinciaFromSigla(String sigla, Session session) {
		
		return GestioneAnagraficaRemotaDAO.getProvinciaFromSigla(sigla, session);
	}


	public static ArrayList<ComuneDTO> getListaComuni(Session session) {
		
		return GestioneAnagraficaRemotaDAO.getListaComuni(session);
	}


	public static ArrayList<ClienteDTO> getListaClientiOfferte(UtenteDTO utente, String indirirzzo,Session session, boolean test) throws Exception {
		// TODO Auto-generated method stub
		return GestioneAnagraficaRemotaDAO.GestioneAnagraficaRemotaDAO( utente,  indirirzzo, session, test);
	}


	public static ArrayList<ArticoloMilestoneDTO> getListaArticoliAgente(UtenteDTO utente, Session session, boolean test) throws Exception {
		// TODO Auto-generated method stub
		return GestioneAnagraficaRemotaDAO.getListaArticoliAgente(utente, session, test);
	}


	public static ArticoloMilestoneDTO getArticoloAgenteFromId(String string, boolean test) throws Exception{
		// TODO Auto-generated method stub
		return GestioneAnagraficaRemotaDAO.getArticoloAgenteFromId(string, test);
	}


	public static boolean checkPartitaIva(String partita_iva, boolean test) throws Exception {
		// TODO Auto-generated method stub
		return GestioneAnagraficaRemotaDAO.checkPartitaIva(partita_iva, test);
	}


	public static void insertCliente(ClienteDTO cl,SedeDTO sede, int company, String codage, boolean test)throws Exception  {
		// TODO Auto-generated method stub
		GestioneAnagraficaRemotaDAO.insertCliente(cl,sede, company, codage, test);
	}


	public static String getIdOffertaFromChiaveGlobale(String id_nh, boolean test) throws Exception {
		// TODO Auto-generated method stub
		return GestioneAnagraficaRemotaDAO.getIdOffertaFromChiaveGlobale(id_nh, test);
	}


	public static void updateSedeOfferta(String id_offerta,String sede_decrypted, String cliente_decrypted, boolean test) throws Exception {
		// TODO Auto-generated method stub
		GestioneAnagraficaRemotaDAO.updateSedeOfferta(id_offerta, sede_decrypted, cliente_decrypted, test);
	}


	public static Map<String, String> getStatoCommessaOfferte() throws Exception {
		// TODO Auto-generated method stub
		return GestioneAnagraficaRemotaDAO.getStatoCommessaOfferte();
	}
	
}
