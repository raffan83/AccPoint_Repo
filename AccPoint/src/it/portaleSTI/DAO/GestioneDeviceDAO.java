package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.DevAllegatiDeviceDTO;
import it.portaleSTI.DTO.DevAllegatiSoftwareDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
import it.portaleSTI.DTO.DevDeviceSoftwareDTO;
import it.portaleSTI.DTO.DevLabelConfigDTO;
import it.portaleSTI.DTO.DevLabelTipoInterventoDTO;
import it.portaleSTI.DTO.DevProceduraDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.DevStatoValidazioneDTO;
import it.portaleSTI.DTO.DevTestoEmailDTO;
import it.portaleSTI.DTO.DevTipoDeviceDTO;
import it.portaleSTI.DTO.DevTipoEventoDTO;
import it.portaleSTI.DTO.DevTipoProceduraDTO;
import it.portaleSTI.DTO.DpiDTO;

public class GestioneDeviceDAO {

	public static ArrayList<DevTipoDeviceDTO> getListaTipiDevice(Session session) {
		
		ArrayList<DevTipoDeviceDTO> lista = null;
		
		Query query = session.createQuery("from DevTipoDeviceDTO");
		
		lista = (ArrayList<DevTipoDeviceDTO>) query.list();
		
		return lista;
	}

	public static DevTipoDeviceDTO getTipoDeviceFromID(int id_tipo_device, Session session) {
		
		ArrayList<DevTipoDeviceDTO> lista = null;
		DevTipoDeviceDTO result = null;
		
		Query query = session.createQuery("from DevTipoDeviceDTO where id =:_id_tipo_device");
		query.setParameter("_id_tipo_device", id_tipo_device);
		
		lista = (ArrayList<DevTipoDeviceDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DevDeviceDTO> getListaDevice(int id_company, Session session) {
		
		ArrayList<DevDeviceDTO> lista = null;
		
		Query query = null;
		
		if(id_company == 0) {
			query = session.createQuery("from DevDeviceDTO where disabilitato = 0");
		}else {
			query = session.createQuery("from DevDeviceDTO where id_company = :_id_company and disabilitato = 0");	
			query.setParameter("_id_company", id_company);
		}
		
		
		lista = (ArrayList<DevDeviceDTO>) query.list();
		
		return lista;
	}

	public static DevDeviceDTO getDeviceFromID(int id_device, Session session) {
		
		ArrayList<DevDeviceDTO> lista = null;
		DevDeviceDTO result = null;
		
		Query query = session.createQuery("from DevDeviceDTO where id =:_id_device");
		query.setParameter("_id_device", id_device);
		
		lista = (ArrayList<DevDeviceDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DevSoftwareDTO> getListaSoftware(Session session) {

		ArrayList<DevSoftwareDTO> lista = null;
		
		Query query = session.createQuery("from DevSoftwareDTO where disabilitato = 0");
		
		lista = (ArrayList<DevSoftwareDTO>) query.list();
		
		return lista;
	}
	
	public static ArrayList<DevStatoValidazioneDTO> getListaStatiValidazione(Session session) {

		ArrayList<DevStatoValidazioneDTO> lista = null;
		
		Query query = session.createQuery("from DevStatoValidazioneDTO");
		
		lista = (ArrayList<DevStatoValidazioneDTO>) query.list();
		
		return lista;
	}

	public static DevSoftwareDTO getSoftwareFromID(int id_software, Session session) {
		
		ArrayList<DevSoftwareDTO> lista = null;
		DevSoftwareDTO result = null;
		
		Query query = session.createQuery("from DevSoftwareDTO where id =:_id_software");
		query.setParameter("_id_software", id_software);
		
		lista = (ArrayList<DevSoftwareDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DevRegistroAttivitaDTO> getRegistroAttivitaFromDevice(DevDeviceDTO device,int id_company,  Session session) {

		ArrayList<DevRegistroAttivitaDTO> lista = null;
		
		Query query = null;
		
		if(id_company==0) {
			query = session.createQuery("from DevRegistroAttivitaDTO where device.id = :_id_device");
			query.setParameter("_id_device", device.getId());
		}else {
			query = session.createQuery("from DevRegistroAttivitaDTO where device.id = :_id_device and (company.id = :_id_company or data_evento >= :_data)");
			query.setParameter("_id_device", device.getId());
			query.setParameter("_id_company", id_company);
			query.setParameter("_data", device.getData_cambio_company());	
		}
		
		
		lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DevTipoEventoDTO> geListaTipiEvento(Session session) {
		
		ArrayList<DevTipoEventoDTO> lista = null;
		
		Query query = session.createQuery("from DevTipoEventoDTO");
		
		lista = (ArrayList<DevTipoEventoDTO>) query.list();
		
		return lista;
	}

	public static DevRegistroAttivitaDTO getRegistroAttivitaFromID(int id_attivita, Session session) {
		ArrayList<DevRegistroAttivitaDTO> lista = null;
		DevRegistroAttivitaDTO result = null;
		
		Query query = session.createQuery("from DevRegistroAttivitaDTO where id =:_id_attivita");
		query.setParameter("_id_attivita", id_attivita);
		
		lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DevLabelConfigDTO> getListaLabelConfigurazioni(Session session) {
		
		ArrayList<DevLabelConfigDTO> lista = null;
		
		Query query = session.createQuery("from DevLabelConfigDTO");
		
		lista = (ArrayList<DevLabelConfigDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DevProceduraDTO> getListaProcedure(int id_device, Session session) {
		
		ArrayList<DevProceduraDTO> lista = null;
		
		Query query = session.createQuery("from DevProceduraDTO where id_device = :_id_device");
		query.setParameter("_id_device", id_device);
		
		lista = (ArrayList<DevProceduraDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<DevTipoProceduraDTO> getListaTipiProcedure(Session session) {
		
		ArrayList<DevTipoProceduraDTO> lista = null;
		
		Query query = session.createQuery("from DevTipoProceduraDTO");
		
		lista = (ArrayList<DevTipoProceduraDTO>) query.list();
		
		return lista;
	}

	public static DevProceduraDTO getProceduraFromID(int id_procedura, Session session) {
		
		ArrayList<DevProceduraDTO> lista = null;
		DevProceduraDTO result = null;
		
		Query query = session.createQuery("from DevProceduraDTO where id =:_id_procedura");
		query.setParameter("_id_procedura", id_procedura);
		
		lista = (ArrayList<DevProceduraDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<DevAllegatiDeviceDTO> getListaAllegatiDevice(int id_device, Session session) {
		
		ArrayList<DevAllegatiDeviceDTO> lista = null;
		
		Query query = session.createQuery("from DevAllegatiDeviceDTO where id_device = :_id_device and disabilitato = 0");
		query.setParameter("_id_device", id_device);
		
		lista = (ArrayList<DevAllegatiDeviceDTO>) query.list();
		
		return lista;
	}
	
	
public static ArrayList<DevAllegatiSoftwareDTO> getListaAllegatiSoftware(int id_software, Session session) {
		
		ArrayList<DevAllegatiSoftwareDTO> lista = null;
		
		Query query = session.createQuery("from DevAllegatiSoftwareDTO where id_software = :_id_software and disabilitato = 0");
		query.setParameter("_id_software", id_software);
		
		lista = (ArrayList<DevAllegatiSoftwareDTO>) query.list();
		
		return lista;
	}

public static DevAllegatiDeviceDTO getAllegatoDeviceFromID(int id_device, Session session) {
	
	ArrayList<DevAllegatiDeviceDTO> lista = null;
	DevAllegatiDeviceDTO result = null;
	
	Query query = session.createQuery("from DevAllegatiDeviceDTO where id =:_id_device");
	query.setParameter("_id_device", id_device);
	
	lista = (ArrayList<DevAllegatiDeviceDTO>) query.list();
	
	if(lista.size()>0) {
		result = lista.get(0);
	}
	
	return result;
}

public static DevAllegatiSoftwareDTO getAllegatoSoftwareFromID(int id_software, Session session) {
	
	ArrayList<DevAllegatiSoftwareDTO> lista = null;
	DevAllegatiSoftwareDTO result = null;
	
	Query query = session.createQuery("from DevAllegatiSoftwareDTO where id =:_id_device");
	query.setParameter("_id_software", id_software);
	
	lista = (ArrayList<DevAllegatiSoftwareDTO>) query.list();
	
	if(lista.size()>0) {
		result = lista.get(0);
	}
	
	return result;
}

public static ArrayList<DevDeviceSoftwareDTO> getListaDeviceSoftware(int id_device, Session session) {
	
	ArrayList<DevDeviceSoftwareDTO> lista = null;
	
	Query query = session.createQuery("from DevDeviceSoftwareDTO where device.id =:_id_device and software.disabilitato = 0");
	query.setParameter("_id_device", id_device);
	
	lista = (ArrayList<DevDeviceSoftwareDTO>) query.list();
	
		
	return lista;
}

public static void dissociaSoftware(int id, Session session) {
	
	Query query = session.createQuery("delete from DevDeviceSoftwareDTO where device.id =:_id_device");
	query.setParameter("_id_device", id);
	query.executeUpdate();
}

public static ArrayList<DevLabelTipoInterventoDTO> geListaLabelTipoIntervento(Session session) {
	
	ArrayList<DevLabelTipoInterventoDTO> lista = null;
	
	Query query = session.createQuery("from DevLabelTipoInterventoDTO");
	
	lista = (ArrayList<DevLabelTipoInterventoDTO>) query.list();
	
		
	return lista;
}

public static ArrayList<DevRegistroAttivitaDTO> getListaScadenze(String dateFrom, String dateTo, Session session) throws Exception, ParseException {
	
	ArrayList<DevRegistroAttivitaDTO> lista = null;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	

	Query query = session.createQuery("from DevRegistroAttivitaDTO where data_prossima between :_data_start and :_data_end");
	query.setParameter("_data_start", sdf.parse(dateFrom));
	query.setParameter("_data_end", sdf.parse(dateTo));
	

	lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
	
	return lista;
}

public static DevTestoEmailDTO getTestoEmail(Session session) {
	ArrayList<DevTestoEmailDTO> lista = null;
	DevTestoEmailDTO result = new DevTestoEmailDTO();
	
	Query query = session.createQuery("from DevTestoEmailDTO");
	
	lista = (ArrayList<DevTestoEmailDTO>) query.list();
	
	if(lista.size()>0) {
		result = lista.get(0);
	}
	
	return result;
}

}
