package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneBachecaDAO;
import it.portaleSTI.DTO.BachecaDTO;

public class GestioneBachecaBO {

	public static void saveMessaggio(BachecaDTO messaggio, Session session) {
		GestioneBachecaDAO.saveMessaggio(messaggio, session);
	}
	
	public static ArrayList<BachecaDTO> getListaMessaggi(Session session){
	
		return GestioneBachecaDAO.getListaMessaggi(session);
	}
	
	
	public static ArrayList<BachecaDTO> getMessaggiPerUtente(int id_utente, Session session){
		
		ArrayList<BachecaDTO> lista = getListaMessaggi(session);
		ArrayList<BachecaDTO> messaggi=new ArrayList<BachecaDTO>();
		for(int i=0; i<lista.size(); i++) {
			
			if(lista.get(i).getDestinatario().equals("0")) {
				messaggi.add(lista.get(i));
			}else {
			
			String destinatari[] = lista.get(i).getDestinatario().split(";");
			for(int j=0; j<destinatari.length;j++) {
				if(destinatari[j].equals(String.valueOf(id_utente))) {
					messaggi.add(lista.get(i));
				}
			}
			}
		}
		
		
		return messaggi;
		
	}

	public static BachecaDTO getMessaggioFromId(int id_messaggio, Session session) {

		return GestioneBachecaDAO.getMessaggioFromId(id_messaggio, session);
		
	}

	public static void updateMessaggio(BachecaDTO messaggio, Session session) {
		GestioneBachecaDAO.updateMessaggio(messaggio, session);
		
	}
	
}
