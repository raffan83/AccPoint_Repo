package it.portaleSTI.DAO;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.action.GestioneConfigurazioniClienti;

public class GestioneConfigurazioneClienteDAO {

	public static ArrayList<ConfigurazioneClienteDTO> getListaConfigurazioneCliente(Session session) {
	
		ArrayList<ConfigurazioneClienteDTO> lista=null;
 	
		Query query = session.createQuery("from ConfigurazioneClienteDTO");
		
//		query.setParameter("_id_sede",id_sede);
//		query.setParameter("_id_cliente",id_cliente);
//		query.setParameter("_tipo_rapporto",tipo_rapporto);
//		
		lista= (ArrayList<ConfigurazioneClienteDTO>)query.list();
	
		return lista;
	}

	public static boolean chekPresente(int id_cliente, int id_sede, int tipo_rapporto, Session session) {
		
		boolean presente = false;
		
		ArrayList<ConfigurazioneClienteDTO> lista=null;
	 	
		Query query = session.createQuery("from ConfigurazioneClienteDTO a where a.id_cliente = :_id_cliente and a.id_sede = :_id_sede and a.tipo_rapporto.id = :_tipo_rapporto");
		
		query.setParameter("_id_sede",id_sede);
		query.setParameter("_id_cliente",id_cliente);
		query.setParameter("_tipo_rapporto",tipo_rapporto);
		
		lista= (ArrayList<ConfigurazioneClienteDTO>)query.list();
		
		if(lista.size()>0) {
			presente = true;
		}
		
		
		return presente;
	}

	public static ConfigurazioneClienteDTO getConfigurazioneClienteFromId(int id_cliente, int id_sede, int tipo_rapporto, Session session) {
		
		ArrayList<ConfigurazioneClienteDTO> lista=null;
		ConfigurazioneClienteDTO conf = null;
		Query query = null;
		
		if(tipo_rapporto == 0) {
			query = session.createQuery("from ConfigurazioneClienteDTO a where a.id_cliente = :_id_cliente and a.id_sede = :_id_sede");
		}else {
			query = session.createQuery("from ConfigurazioneClienteDTO a where a.id_cliente = :_id_cliente and a.id_sede = :_id_sede and a.tipo_rapporto.id = :_tipo_rapporto"); 
		}						
		
		query.setParameter("_id_sede",id_sede);
		query.setParameter("_id_cliente",id_cliente);
		if(tipo_rapporto != 0) {
			query.setParameter("_tipo_rapporto",tipo_rapporto);	
		}
		
		
		lista= (ArrayList<ConfigurazioneClienteDTO>)query.list();
		
		if(lista.size()>0) {
			conf = lista.get(0);
		}
		return conf;
	}

}
