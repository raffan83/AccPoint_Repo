package it.portaleSTI.bo;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;

import it.portaleSTI.DAO.GestioneAnagraficaRemotaDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.SedeDTO;

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
	
	public static SedeDTO getSedeFromId(List<SedeDTO> listaSedi, int id_sede) {
		
		SedeDTO sede= null;
		
		for (SedeDTO iterator : listaSedi) {
			if(iterator.get__id()==id_sede) {
				sede = iterator;
				
			}
		}
		
		
		return sede;
	}
}