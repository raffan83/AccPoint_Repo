package it.portaleSTI.bo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneDeviceDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.DevAllegatiDeviceDTO;
import it.portaleSTI.DTO.DevAllegatiSoftwareDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
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

public class GestioneDeviceBO {

	public static ArrayList<DevTipoDeviceDTO> getListaTipiDevice(Session session) {
		
		return GestioneDeviceDAO.getListaTipiDevice(session);
	}

	public static DevTipoDeviceDTO getTipoDeviceFromID(int id_tipo_device, Session session) {
		
		return GestioneDeviceDAO.getTipoDeviceFromID(id_tipo_device, session);
	}

	public static ArrayList<DevDeviceDTO> getListaDevice(int id_company, Session session) {
		
		return GestioneDeviceDAO.getListaDevice(id_company,session);
	}

	public static DevDeviceDTO getDeviceFromID(int id_device, Session session) {

		return GestioneDeviceDAO.getDeviceFromID(id_device,  session);
	}

	public static ArrayList<DevSoftwareDTO> getListaSoftware(Session session) {
		
		return GestioneDeviceDAO.getListaSoftware(session);
	}

	public static ArrayList<DevStatoValidazioneDTO> getListaStatiValidazione(Session session) {
		
		return GestioneDeviceDAO.getListaStatiValidazione(session);
	}

	public static DevSoftwareDTO getSoftwareFromID(int id_seftware, Session session) {
		
		return  GestioneDeviceDAO.getSoftwareFromID(id_seftware,session);
	}

	public static ArrayList<DevRegistroAttivitaDTO> getRegistroAttivitaFromDevice(DevDeviceDTO device,int id_company, Session session) {
		
		return GestioneDeviceDAO.getRegistroAttivitaFromDevice(device,id_company, session);
	}

	public static ArrayList<DevTipoEventoDTO> geListaTipiEvento(Session session) {
		
		return GestioneDeviceDAO.geListaTipiEvento(session);
	}

	public static DevRegistroAttivitaDTO getRegistroAttivitaFromID(int id_attivita, Session session) {
		
		return GestioneDeviceDAO.getRegistroAttivitaFromID(id_attivita, session);
	}

	public static ArrayList<DevLabelConfigDTO> getListaLabelConfigurazioni(Session session) {
		
		return GestioneDeviceDAO.getListaLabelConfigurazioni(session);
	}

	public static ArrayList<DevProceduraDTO> getListaProcedure(Session session) {
		
		return GestioneDeviceDAO.getListaProcedure( session);
	}
	
	public static ArrayList<DevProceduraDeviceDTO> getListaProcedureDevice(int id_device, Session session) {
		
		return GestioneDeviceDAO.getListaProcedureDevice(id_device, session);
	}

	public static ArrayList<DevTipoProceduraDTO> getListaTipiProcedure(Session session) {

		return GestioneDeviceDAO.getListaTipiProcedure(session);
	}

	public static DevProceduraDTO getProceduraFromID(int id_procedura, Session session) {
		
		return GestioneDeviceDAO.getProceduraFromID(id_procedura, session);
	}

	public static ArrayList<DevAllegatiDeviceDTO> getListaAllegatiDevice(int id_device, Session session) {
	
		return GestioneDeviceDAO.getListaAllegatiDevice(id_device, session);
	}
	
	public static ArrayList<DevAllegatiSoftwareDTO> getListaAllegatiSoftware(int id_software, Session session) {
		
		return GestioneDeviceDAO.getListaAllegatiSoftware(id_software, session);
	}

	public static DevAllegatiDeviceDTO getAllegatoDeviceFromID(int id_device, Session session) {
		
		return GestioneDeviceDAO.getAllegatoDeviceFromID(id_device, session);
	}
	
	public static DevAllegatiSoftwareDTO getAllegatoSoftwareFromID(int id_software, Session session) {
		
		return GestioneDeviceDAO.getAllegatoSoftwareFromID(id_software, session);
	}

	public static ArrayList<DevDeviceSoftwareDTO> getListaDeviceSoftware(int id_device, Session session) {
		
		return GestioneDeviceDAO.getListaDeviceSoftware(id_device, session);
	}

	public static void dissociaSoftware(int id, Session session) {

		GestioneDeviceDAO.dissociaSoftware(id, session);
		
	}

	public static ArrayList<DevLabelTipoInterventoDTO> geListaLabelTipoIntervento(Session session) {
		
		return GestioneDeviceDAO.geListaLabelTipoIntervento(session);
	}

	public static ArrayList<DevRegistroAttivitaDTO> getListaScadenze(String dateFrom, String dateTo, Session session) throws ParseException, Exception {

		return GestioneDeviceDAO.getListaScadenze(dateFrom, dateTo, session);
	}

	public static void sendEmailAttivitaScadute() throws ParseException, Exception {
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 15);
		Date nextDate = cal.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceDAO.getListaScadenze(df.format(nextDate), df.format(nextDate), session);
		
		DevTestoEmailDTO testo_email = getTestoEmail(session);
		
		for (DevRegistroAttivitaDTO attivita : lista_scadenze) {
			
			if(attivita.getEmail_inviata()==0) {
				SendEmailBO.sendEmailScadenzaAttivitaDevice(attivita, testo_email.getDescrizione(), testo_email.getReferenti());	
				attivita.setEmail_inviata(1);
				session.update(attivita);
			}
		}
		session.getTransaction().commit();
		session.close();
		
	}

	public static DevTestoEmailDTO getTestoEmail(Session session) {
		
		return GestioneDeviceDAO.getTestoEmail(session);
	}

	public static void dissociaProcedura(int id, Session session) {
		
		GestioneDeviceDAO.dissociaProcedura(id, session);
	}
}
