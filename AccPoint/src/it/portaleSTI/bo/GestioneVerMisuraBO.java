package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneVerMisuraDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;

public class GestioneVerMisuraBO {

	public static VerMisuraDTO getMisuraFromId(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getMisuraFromId(id_misura, session);
	}

	public static ArrayList<VerRipetibilitaDTO> getListaRipetibilita(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaRipetibilita(id_misura, session);
	}

	public static ArrayList<VerDecentramentoDTO> getListaDecentramento(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaDecentramento(id_misura, session);
	}

	public static ArrayList<VerLinearitaDTO> getListaLinearita(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaLinearita(id_misura, session);
	}

	public static ArrayList<VerAccuratezzaDTO> getListaAccuratezza(int id_misura, Session session) {

		return GestioneVerMisuraDAO.getListaAccuratezza(id_misura, session);
	}

	public static ArrayList<VerMobilitaDTO> getListaMobilita(int id_misura, Session session) {
		
		return GestioneVerMisuraDAO.getListaMobilita(id_misura, session);
	}

	public static ArrayList<VerMisuraDTO> getListaMisureFromDateAndProv(String dateFrom, String dateTo,String provincia,Session session) throws Exception {
		
		ArrayList<VerMisuraDTO> listaMisure = new ArrayList<VerMisuraDTO>();
		
		ArrayList<String> listaMisureFromDate =DirectMySqlDAO.getListaVerMisureFromDate(dateFrom,dateTo);
		
		for (String sequence : listaMisureFromDate) {
			
			String[] data=sequence.split(";");
			
			ClienteDTO cliente = null;
			
			if(data[2].equals("0")) 
			{
				cliente=GestioneAnagraficaRemotaBO.getClienteById(data[1]);
			}else 
			{
				cliente=GestioneAnagraficaRemotaBO.getClienteFromSede(data[1],data[2]);
			}
			
			if(cliente.getProvincia().equals(provincia)) 
			{
				listaMisure.add(GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(data[0]), session));
			}
		}

		return listaMisure;
	}


}
