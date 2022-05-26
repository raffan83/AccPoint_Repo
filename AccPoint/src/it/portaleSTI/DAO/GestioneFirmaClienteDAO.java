package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.FirmaClienteDTO;

public class GestioneFirmaClienteDAO {

	public static ArrayList<FirmaClienteDTO> getListaFirme(int id_cliente, int id_sede, Session session) {
		
		ArrayList<FirmaClienteDTO> lista = null;
		
		String str = "from FirmaClienteDTO where disabilitato = 0";
		
		if(id_cliente !=0) {
			str = "from FirmaClienteDTO where disabilitato = 0 and id_cliente = :_id_cliente and id_sede = :_id_sede";
		}
		
		Query query = session.createQuery(str);
		if(id_cliente !=0) {
			query.setParameter("_id_cliente", id_cliente);
			query.setParameter("_id_sede", id_sede);
		}
				
		lista = (ArrayList<FirmaClienteDTO>) query.list();		
			
		return lista;
		
	
	}

	public static FirmaClienteDTO getFirmaCliente(int id, Session session) {
		ArrayList<FirmaClienteDTO> lista = null;
		FirmaClienteDTO result = null;
		
		Query query = session.createQuery("from FirmaClienteDTO where id = :_id");
		query.setParameter("_id", id);
				
		lista = (ArrayList<FirmaClienteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
			
		return result;
	}

}
