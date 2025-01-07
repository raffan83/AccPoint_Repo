package it.portaleSTI.DAO;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.DevAllegatiDeviceDTO;
import it.portaleSTI.DTO.DevAllegatiSoftwareDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
import it.portaleSTI.DTO.DevDeviceMonitorDTO;
import it.portaleSTI.DTO.DevDeviceSoftwareDTO;
import it.portaleSTI.DTO.DevLabelConfigDTO;
import it.portaleSTI.DTO.DevLabelTipoInterventoDTO;
import it.portaleSTI.DTO.DevProceduraDTO;
import it.portaleSTI.DTO.DevProceduraDeviceDTO;
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
			query = session.createQuery("from DevDeviceDTO where id_company_util = :_id_company and disabilitato = 0");	
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

	public static ArrayList<DevRegistroAttivitaDTO> getRegistroAttivitaFromDevice(DevDeviceDTO device,int id_company, int tipo, Session session) {

		ArrayList<DevRegistroAttivitaDTO> lista = null;
		
		Query query = null;
		
		String q = "";
		
		if(id_company==0) {
			q = "from DevRegistroAttivitaDTO where device.id = :_id_device";
			if(tipo!=0) {
				q+= " and tipo_evento.id = 2 or tipo_evento.id = 3";
			}
			query = session.createQuery(q);
			query.setParameter("_id_device", device.getId());
		}else {
			q = "from DevRegistroAttivitaDTO where device.id = :_id_device and (company.id = :_id_company or data_evento >= :_data)";
			if(tipo!=0) {
				q+= " and tipo_evento.id = 2 or tipo_evento.id = 3";
			}
			query = session.createQuery(q);
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

	public static ArrayList<DevProceduraDeviceDTO> getListaProcedureDevice(int id_device, Session session) {
		
		ArrayList<DevProceduraDeviceDTO> lista = null;
		
		Query query = session.createQuery("from DevProceduraDeviceDTO where device.id = :_id_device and procedura.disabilitato = 0");
		query.setParameter("_id_device", id_device);
		
		lista = (ArrayList<DevProceduraDeviceDTO>) query.list();
		
		return lista;
	}
	
public static ArrayList<DevProceduraDTO> getListaProcedure(Session session) {
		
		ArrayList<DevProceduraDTO> lista = null;
		
		Query query = session.createQuery("from DevProceduraDTO where disabilitato = 0");
		
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
	
	Query query = session.createQuery("from DevAllegatiSoftwareDTO where id =:_id_software");
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

public static ArrayList<DevRegistroAttivitaDTO> getListaScadenze(String dateFrom, String dateTo,int company,  Session session) throws Exception, ParseException {
	
	ArrayList<DevRegistroAttivitaDTO> lista = null;
	ArrayList<DevRegistroAttivitaDTO> lista_no_event =new ArrayList<DevRegistroAttivitaDTO> ();
	ArrayList<DevDeviceDTO> device_no_event =null;	
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	String str = "";
	if(company == 0) {
		//str = "from DevRegistroAttivitaDTO as a where a.data_prossima between :_data_start and :_data_end and a.device.disabilitato = 0";
		str = "FROM DevRegistroAttivitaDTO d " +
                "WHERE (d.tipo_evento.id = 2 or d.tipo_evento.id = 5) and d.device.tipo_device.id <> 14  and d.data_evento = (SELECT MAX(d2.data_evento) FROM DevRegistroAttivitaDTO d2 WHERE d2.device.id = d.device.id and (d2.tipo_evento.id = 2 or d2.tipo_evento.id = 5) ) and d.device.disabilitato = 0 GROUP BY d.device.id";
	}else {
		//str = "from DevRegistroAttivitaDTO as a where a.data_prossima between :_data_start and :_data_end and id_company_util = :_id_company and a.device.disabilitato = 0";
		str = "FROM DevRegistroAttivitaDTO d " +
                "WHERE (d.tipo_evento.id = 2 or d.tipo_evento.id = 5) and d.device.tipo_device.id <> 14 and d.data_evento = (SELECT MAX(d2.data_evento) FROM DevRegistroAttivitaDTO d2 WHERE d2.device.id = d.device.id and (d2.tipo_evento.id = 2 or d2.tipo_evento.id = 5) ) and d.device.disabilitato = 0 and id_company_util = :_id_company GROUP BY d.device.id";
	}

	Query query = session.createQuery(str);
//	query.setParameter("_data_start", sdf.parse(dateFrom));
//	query.setParameter("_data_end", sdf.parse(dateTo));
	
	if(company!=0) {
		query.setParameter("_id_company", company);
	}
	
	lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
	

	
	return lista;
}


//public static ArrayList<DevRegistroAttivitaDTO> getListaScadenzeScheduler(String dateFrom, String dateTo,int company,  Session session) throws Exception, ParseException {
//	
//	ArrayList<DevRegistroAttivitaDTO> lista = null;
//	
//	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//	String str = "";
//	if(company == 0) {
//		str = "from DevRegistroAttivitaDTO as a where a.data_prossima between :_data_start and :_data_end and a.device.disabilitato = 0";
//		
//	}else {
//		str = "from DevRegistroAttivitaDTO as a where a.data_prossima between :_data_start and :_data_end and id_company_util = :_id_company and a.device.disabilitato = 0";
//	
//	}
//
//	Query query = session.createQuery(str);
//	query.setParameter("_data_start", sdf.parse(dateFrom));
//	query.setParameter("_data_end", sdf.parse(dateTo));
//	
//	if(company!=0) {
//		query.setParameter("_id_company", company);
//	}
//
//	lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
//	
//	return lista;
//}


public static ArrayList<DevRegistroAttivitaDTO> getListaScadenzeScheduler(String date, int sollecito, Session session) throws Exception, ParseException {
	
	ArrayList<DevRegistroAttivitaDTO> lista = null;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String tipo_data = "data_invio_email";
	String email_inviata = " and email_inviata = 0";
	if(sollecito == 1) {
		tipo_data = "data_invio_sollecito";
		email_inviata = "";
	}
	
	String str = "from DevRegistroAttivitaDTO as a where "+tipo_data+" = :_date and obsoleta = 'N' and a.device.disabilitato = 0"+email_inviata;

	
	Query query = session.createQuery(str);
	query.setParameter("_date", sdf.parse(date));


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

public static void dissociaProcedura(int id, Session session) {
	Query query = session.createQuery("delete from DevProceduraDeviceDTO where device.id =:_id_device");
	query.setParameter("_id_device", id);
	query.executeUpdate();
	
}

public static ArrayList<DevDeviceDTO> getListaDeviceArchiviati(int id_company,  Session session) {
	ArrayList<DevDeviceDTO> lista = null;
	
	Query query = null;
	
	if(id_company == 0) {
		query = session.createQuery("from DevDeviceDTO where disabilitato = 1");
	}else {
		query = session.createQuery("from DevDeviceDTO where id_company_util = :_id_company and disabilitato = 1");	
		query.setParameter("_id_company", id_company);
	}
	
	
	lista = (ArrayList<DevDeviceDTO>) query.list();
	
	return lista;
}

public static ArrayList<DevRegistroAttivitaDTO> getListaScadenzeEmailInviata(Session session) {
	
	ArrayList<DevRegistroAttivitaDTO> lista = null;
	
	Query query = session.createQuery("from DevRegistroAttivitaDTO where email_inviata = 1 and device.disabilitato = 0 and id_tipo_evento = 2 ");	
	
	lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
	
	return lista;
}

public static ArrayList<DevRegistroAttivitaDTO> getListaManutenzioniSuccessive(String id, int id_device, Session session) throws HibernateException, ParseException {
	
	ArrayList<DevRegistroAttivitaDTO> lista = null;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Query query = session.createQuery("from DevRegistroAttivitaDTO where device.id = :_id_device and tipo_evento.id = 2  and id > :_id");
	query.setParameter("_id_device", id_device);
	query.setParameter("_id", Integer.parseInt(id));
	//query.setParameter("_date", sdf.parse(date));
	
	lista = (ArrayList<DevRegistroAttivitaDTO>) query.list();
	
	return lista;
}

public static ArrayList<DevSoftwareDTO> getListaSoftwareCompany(int id_company, Session session) {
	
	ArrayList<DevSoftwareDTO> lista = null;
	
	Query query = session.createQuery("select distinct a.software from DevDeviceSoftwareDTO as a where a.device.company_proprietaria.id = :_id_company");
	query.setParameter("_id_company", id_company);
	
	lista = (ArrayList<DevSoftwareDTO>) query.list();
	
	return lista;
}

public static ArrayList<DevDeviceDTO> getListaMonitor(Session session) {
	
	ArrayList<DevDeviceDTO> lista = null;
	
	Query query = session.createQuery("from DevDeviceDTO where tipo_device.id = 14 and disabilitato = 0");

	
	lista = (ArrayList<DevDeviceDTO>) query.list();
	
	return lista;
}

public static ArrayList<DevDeviceMonitorDTO> getListaMonitorDevice(int id_device, Session session) {
	
	ArrayList<DevDeviceMonitorDTO> lista = null;
	
	Query query = session.createQuery("from DevDeviceMonitorDTO where device.id = :_id_device");
	query.setParameter("_id_device", id_device);
	

	
	lista = (ArrayList<DevDeviceMonitorDTO>) query.list();
	
	return lista;
}


public static void dissociaMonitor(int id, Session session) {
	
	Query query = session.createQuery("delete from DevDeviceMonitorDTO where device.id =:_id_device");
	query.setParameter("_id_device", id);
	query.executeUpdate();
}

public static ArrayList<DevDeviceDTO> getListaDeviceNoMan(int id_company, Session session) {
	
	ArrayList<DevDeviceDTO> lista = null;
	
	Query query = null;
	
	if(id_company == 0) {
		query = session.createQuery("from DevDeviceDTO where disabilitato = 0 and tipo_device.id <> 14 and id NOT IN (select device.id from DevRegistroAttivitaDTO where tipo_evento.id = 2)");
	}else {
		query = session.createQuery("from DevDeviceDTO where id_company_util = :_id_company and disabilitato = 0 and tipo_device.id <> 14 and id NOT IN (select device.id from DevRegistroAttivitaDTO where tipo_evento.id = 2)");	
		query.setParameter("_id_company", id_company);
	}
	
	
	lista = (ArrayList<DevDeviceDTO>) query.list();
	
	return lista;
}

public static ArrayList<DevDeviceDTO> getListaDeviceManScad(int id_company, Session session) throws Exception, ParseException {
	
	ArrayList<DevDeviceDTO> lista = null;

	Query query = null;
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	
//	if(id_company == 0) {
//		query = session.createQuery("from DevDeviceDTO where disabilitato = 0 and tipo_device.id <> 14 and id IN (select device.id from DevRegistroAttivitaDTO where tipo_evento.id = 2 "
//				+ "AND id IN (SELECT MAX(id) FROM DevRegistroAttivitaDTO WHERE tipo_evento.id = 2 GROUP BY device.id) AND data_prossima < :_date)");
//		query.setParameter("_date", df.parseObject(df.format(new Date())));
//	}else {
//		query = session.createQuery("from DevDeviceDTO where id_company_util = :_id_company and disabilitato = 0 and tipo_device.id <> 14 and id IN (select device.id from DevRegistroAttivitaDTO where tipo_evento.id = 2 "  
//								+ " AND id IN (SELECT MAX(id)  FROM DevRegistroAttivitaDTO WHERE tipo_evento.id = 2 GROUP BY device.id) AND data_prossima < :_date)");	
//		query.setParameter("_id_company", id_company);
//		query.setParameter("_date", df.parseObject(df.format(new Date())));
//	}
	
	
	if(id_company == 0) {
		query = session.createQuery("select device from DevRegistroAttivitaDTO a  where a.device.disabilitato = 0 and a.device.tipo_device.id <> 14 and (a.tipo_evento.id = 2 or a.tipo_evento.id = 3) "
				+ "AND a.id IN (SELECT MAX(id) FROM DevRegistroAttivitaDTO WHERE (tipo_evento.id = 2 or tipo_evento.id = 3) GROUP BY device.id) AND a.data_prossima < :_date");
		query.setParameter("_date", df.parseObject(df.format(new Date())));
	}else {
		query = session.createQuery("select device from DevRegistroAttivitaDTO a where a.device.company_util.id = :_id_company and a.device.disabilitato = 0 and a.device.tipo_device.id <> 14 and (a.tipo_evento.id = 2 or a.tipo_evento.id = 3) "  
								+ " AND a.id IN (SELECT MAX(id)  FROM DevRegistroAttivitaDTO (tipo_evento.id = 2 or tipo_evento.id = 3) GROUP BY device.id) AND a.data_prossima < :_date)");	
		query.setParameter("_id_company", id_company);
		query.setParameter("_date", df.parseObject(df.format(new Date())));
	}
	
	lista = (ArrayList<DevDeviceDTO>) query.list();
	
	return lista;
}

}
