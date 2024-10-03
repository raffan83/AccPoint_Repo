package it.portaleSTI.bo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.mail.EmailException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneDeviceDAO;
import it.portaleSTI.DAO.GestioneDpiDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevTestoEmailDTO;
import it.portaleSTI.DTO.DpiAllegatiDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.DpiManualeDTO;
import it.portaleSTI.DTO.TipoAccessorioDispositivoDTO;
import it.portaleSTI.DTO.TipoDpiDTO;

public class GestioneDpiBO {

	public static ArrayList<TipoDpiDTO> getListaTipoDPI(Session session) {
		
		return GestioneDpiDAO.getListaTipoDPI(session);
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpi(Session session) {
		
		return GestioneDpiDAO.getListaConsegneDpi(session);
	}

	public static ConsegnaDpiDTO getCosegnaFromID(int id_consegna, Session session) {
		
		return GestioneDpiDAO.getCosegnaFromID(id_consegna, session);
	}

	public static TipoDpiDTO getTipoDPIFromId(int id_tipo, Session session) {
		
		return GestioneDpiDAO.getTipoDPIFromId(id_tipo,session);
	}

	public static ArrayList<DpiDTO> getListaDpi(Session session) {
		
		return GestioneDpiDAO.getListaDpi(session);
	}

	public static DpiDTO getDpiFormId(int id_dpi, Session session) {
		
		return GestioneDpiDAO.getDpiFormId(id_dpi, session);
	}

	public static ArrayList<ConsegnaDpiDTO> getListaEventiFromDPI(int id_dpi, Session session) {
		
		return GestioneDpiDAO.getListaEventiFromDPI(id_dpi, session);
	}

	public static ArrayList<DpiDTO> getListaDpiScadenzario(String dateFrom, String dateTo, Session session) throws Exception, Exception {
		
		return GestioneDpiDAO.getListaDpiScadenzario(dateFrom, dateTo, session);
	}

	public static DpiManualeDTO getManualeFromId(int id_manuale, Session session) {
		
		return GestioneDpiDAO.getManualeFromId(id_manuale, session);
	}

	public static ArrayList<DpiManualeDTO> getListaManuali(Session session) {
		
		return GestioneDpiDAO.getListaManuali(session);
	}

	public static DpiAllegatiDTO getAllegatoFromID(int id_allegato, Session session) {
		
		return GestioneDpiDAO.getAllegatoFromID(id_allegato, session);
	}

	public static ArrayList<DpiAllegatiDTO> getListaAllegati(int id_manuale,int id_dpi, Session session) {

		return GestioneDpiDAO.getListaAllegati(id_manuale, id_dpi,session);
	}

	public static void sendEmailDpiScadenza() throws ParseException, Exception {

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 10);
		Date nextDate = cal.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<DpiDTO> lista_scadenze = GestioneDpiDAO.getListaDpiScadenzario(df.format(nextDate), df.format(nextDate), session);
		
		if(lista_scadenze.size()>0) {
			
			SendEmailBO.sendEmailDPIInScadenza(lista_scadenze);
			
		}
		session.getTransaction().commit();
		session.close();
		
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpiNonRest(Session session) {
		
		return GestioneDpiDAO.getListaConsegneDpiNonRest(session);
	}

	public static ArrayList<TipoAccessorioDispositivoDTO> getListaAccessoriDispositivo(Session session) {
		// TODO Auto-generated method stub
		return  GestioneDpiDAO.getListaAccessoriDispositivo(session);
	}

}
