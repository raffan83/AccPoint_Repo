package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFirmaClienteDAO;
import it.portaleSTI.DTO.FirmaClienteDTO;

public class GestioneFirmaClienteBO {

	public static ArrayList<FirmaClienteDTO> getListaFirme(int id_cliente, int id_sede, Session session) {
		
		return GestioneFirmaClienteDAO.getListaFirme(id_cliente, id_sede, session);
	}

	public static FirmaClienteDTO getFirmaCliente(int id, Session session) {
		
		return GestioneFirmaClienteDAO.getFirmaCliente(id,  session);
	}

}
