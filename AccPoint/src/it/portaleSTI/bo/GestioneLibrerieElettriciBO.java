package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneLibrerieElettriciDAO;
import it.portaleSTI.DTO.LibreriaElettriciDTO;

public class GestioneLibrerieElettriciBO {

	public static ArrayList<LibreriaElettriciDTO> getListaLibrerieElettrici(Session session) {
		
		return GestioneLibrerieElettriciDAO.getListaLibrerieElettrici(session);
	}

	public static LibreriaElettriciDTO getLibreriaElettriciFromID(int id_libreria, Session session) {
		
		return GestioneLibrerieElettriciDAO.getLibreriaElettriciFromID(id_libreria,session);
	}

}
