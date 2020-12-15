package it.portaleSTI.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaItemDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagNoteDdtDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoNotaPaccoDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;

/**
 * Servlet implementation class ListaPacchi
 */
@WebServlet("/listaPacchi.do")
public class ListaPacchi extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(ListaPacchi.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPacchi() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		int id_company= utente.getCompany().getId();
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		String action = request.getParameter("action");
		
		logger.error("Action: "+action +" - Utente: "+utente.getNominativo());
		
		try {
			
		if(request.getSession().getAttribute("listaClientiAll")==null) 
		{
			request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
		}	
		
		if(request.getSession().getAttribute("listaSediAll")==null) 
		{
			request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());
		}
		
		List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
		if(listaClienti==null) {
			listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(id_company));	
		}
				
		List<ClienteDTO> listaFornitori = (List<ClienteDTO>)request.getSession().getAttribute("lista_fornitori");
		if(listaFornitori==null) {
			listaFornitori = GestioneAnagraficaRemotaBO.getListaFornitori(String.valueOf(id_company));
		}
		
		List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
		if(listaSedi== null) {
			listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
		}
	
			
		if(action==null || action.equals("")) {
			
			String stato = request.getParameter("stato");
			ArrayList<MagPaccoDTO> lista_pacchi = null;
			String dateFrom=null;
			String dateTo = null;
			if(stato!=null && stato.equals("tutti")) {
				
				Date end = new Date();
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(end);
				calendar.add(Calendar.DAY_OF_MONTH, -30);
				
				Date start = calendar.getTime();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				//lista_pacchi = GestioneMagazzinoBO.getListaPacchi(id_company, session);
				dateFrom = df.format(start);
				dateTo = df.format(end);
				lista_pacchi = GestioneMagazzinoBO.getListaPacchiPerData(df.format(start), df.format(end), "data_lavorazione", 0, session);
			}
			else if(stato!=null && stato.equals("chiusi")) {
				Date end = new Date();
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(end);
				calendar.add(Calendar.DAY_OF_MONTH, -30);
				
				Date start = calendar.getTime();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				dateFrom = df.format(start);
				dateTo = df.format(end);
				lista_pacchi = GestioneMagazzinoBO.getListaPacchiPerData(df.format(start), df.format(end), "data_lavorazione", 1, session);
			}
			else {
				lista_pacchi = GestioneMagazzinoBO.getListaPacchiApertiChiusi(id_company, 0, session);				
			}
		
			
		//	List<ClienteDTO> listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(id_company));	
		//	List<ClienteDTO> listaFornitori = GestioneAnagraficaRemotaBO.getListaFornitori(String.valueOf(id_company));
		//	List<SedeDTO> listaSedi = GestioneAnagraficaRemotaBO.getListaSedi();			
			ArrayList<MagTipoDdtDTO> tipo_ddt = GestioneMagazzinoBO.getListaTipoDDT(session);
			ArrayList<MagTipoPortoDTO> tipo_porto = GestioneMagazzinoBO.getListaTipoPorto(session);
			ArrayList<MagTipoTrasportoDTO> tipo_trasporto = GestioneMagazzinoBO.getListaTipoTrasporto(session); 
			ArrayList<MagAspettoDTO> aspetto = GestioneMagazzinoBO.getListaTipoAspetto(session);
			ArrayList<MagTipoItemDTO> tipo_item = GestioneMagazzinoBO.getListaTipoItem(session);
			ArrayList<MagStatoLavorazioneDTO> stato_lavorazione = GestioneMagazzinoBO.getListaStatoLavorazione(session);
			ArrayList<MagAttivitaItemDTO> lista_attivita_item = GestioneMagazzinoBO.getListaAttivitaItem(session);
			ArrayList<CommessaDTO> lista_commesseAperte = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0,true);
			ArrayList<CommessaDTO> lista_commesseTutte = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0,false);
			ArrayList<MagTipoNotaPaccoDTO> lista_tipo_note_pacco = GestioneMagazzinoBO.getListaTipoNotaPacco(session);
			ArrayList<MagNoteDdtDTO> lista_note_ddt = GestioneMagazzinoBO.getListaNoteDDT(session);
			ArrayList<MagCausaleDTO> lista_causali = GestioneMagazzinoBO.geListaCausali(session);
			ArrayList<MagSaveStatoDTO> lista_save_stato = GestioneMagazzinoBO.getListaMagSaveStato(session);
		//	ArrayList<Integer> lista_pacchi_allegati = GestioneMagazzinoBO.getListaAllegati(session);
						
			
			
			String commessa = null;
			
			session.close();
			
//			for (MagPaccoDTO pacco : lista_pacchi) {
//				if(lista_pacchi_allegati.contains(pacco.getId())) {
//					pacco.setHasAllegato(true);
//				}
//			}			
			request.getSession().setAttribute("stato", stato);
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_clienti", listaClienti);
			request.getSession().setAttribute("lista_fornitori", listaFornitori);
			request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_tipo_ddt", tipo_ddt);
			request.getSession().setAttribute("lista_tipo_porto", tipo_porto);
			request.getSession().setAttribute("lista_tipo_trasporto", tipo_trasporto);
			request.getSession().setAttribute("lista_aspetto", aspetto);
			request.getSession().setAttribute("lista_tipo_item", tipo_item);
			request.getSession().setAttribute("lista_tipo_aspetto", aspetto);
			request.getSession().setAttribute("lista_stato_lavorazione", stato_lavorazione);
			request.getSession().setAttribute("lista_attivita_pacco", lista_attivita_item);
			request.getSession().setAttribute("lista_causali", lista_causali);
			//request.getSession().setAttribute("lista_save_stato", lista_save_stato);
			String lista_save_stato_json = new Gson().toJson(lista_save_stato);
			request.getSession().setAttribute("lista_save_stato_json", lista_save_stato_json);
			
			String attivita_json = new Gson().toJson(lista_attivita_item);
			request.getSession().setAttribute("attivita_json", attivita_json);
			request.getSession().setAttribute("lista_commesse", lista_commesseAperte);
			request.getSession().setAttribute("lista_commesseTutte", lista_commesseTutte);
			request.getSession().setAttribute("lista_tipo_note_pacco", lista_tipo_note_pacco);
			request.getSession().setAttribute("lista_note_ddt", lista_note_ddt);
			if(!lista_pacchi.isEmpty()) {
			request.getSession().setAttribute("pacco", lista_pacchi.get(lista_pacchi.size()-1));
			}

			request.getSession().setAttribute("dateTo",dateTo);
			request.getSession().setAttribute("dateFrom", dateFrom);
			request.getSession().setAttribute("commessa", commessa);		
			request.getSession().setAttribute("pacchi_esterno",false);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	     	dispatcher.forward(request,response);
	     	
	     	
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		else if(action.equals("filtraDate")) {
			
			String dateFrom = request.getParameter("dateFrom");
			String dateTo = request.getParameter("dateTo");
			String tipo_data= request.getParameter("tipo_data");
			String tipo="";
			
			if(tipo_data.equals("1")) {
				tipo= "data_lavorazione";
			}
			else if(tipo_data.equals("2")){
				tipo= "data_arrivo";
			}else if(tipo_data.equals("3")) {
				tipo= "data_spedizione";
			}
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchiPerData(dateFrom, dateTo, tipo,0, session);
			session.close();
			
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("dateFrom",dateFrom);
			request.getSession().setAttribute("dateTo",dateTo);
			request.getSession().setAttribute("tipo_data", tipo_data);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	     	dispatcher.forward(request,response);
	     	
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		else if(action.equals("filtraCommesse")) {
		
			String commessa = request.getParameter("commessa");
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getPaccoByCommessa(commessa, session);
			
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("commessa", commessa);
			
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	     	dispatcher.forward(request,response);
	     	
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
			
		else if(action.equals("pacchi_esterno")) {
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchiInEsterno(session);
			
			session.close();
			
			request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("pacchi_esterno",true);
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listapacchi.jsp");
	     	dispatcher.forward(request,response);
			
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action.equals("pacchi_magazzino")) {
			
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchiInMagazzino(session);
			
			session.close();
			
			request.getSession().setAttribute("lista_pacchi_magazzino",lista_pacchi);
					
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPacchiInMagazzino.jsp");
	     	dispatcher.forward(request,response);
			
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action.equals("lista_ddt")) {
			
			HashMap<Integer, String> listaClientiAll = (HashMap<Integer, String>)request.getSession().getAttribute("listaClientiAll");
			
			if(listaClientiAll==null) 
			{
				listaClientiAll = GestioneAnagraficaRemotaBO.getListaClientiAll();
				request.getSession().setAttribute("listaClientiAll",listaClientiAll);
			}	
			
			HashMap<String, String> listaSediAll = (HashMap<String, String>)request.getSession().getAttribute("listaSediAll");
			if(listaSediAll==null) 
			{
				listaSediAll = GestioneAnagraficaRemotaBO.getListaSediAll();
				request.getSession().setAttribute("listaSediAll",listaSediAll);
			}
			
		//	ArrayList<MagDdtDTO> lista_ddt = GestioneMagazzinoBO.getListaDDT(session);
			
			String stato = request.getParameter("stato");
			ArrayList<MagPaccoDTO> lista_pacchi = null;
			String dateFrom=null;
			String dateTo = null;
			if(stato!=null && stato.equals("tutti")) {
				
				Date end = new Date();
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(end);
				calendar.add(Calendar.DAY_OF_MONTH, -30);
				
				Date start = calendar.getTime();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				//lista_pacchi = GestioneMagazzinoBO.getListaPacchi(id_company, session);
				dateFrom = df.format(start);
				dateTo = df.format(end);
				lista_pacchi = GestioneMagazzinoBO.getListaPacchiPerData(df.format(start), df.format(end), "data_lavorazione", 0, session);
			}
			else if(stato!=null && stato.equals("chiusi")) {
				Date end = new Date();
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(end);
				calendar.add(Calendar.DAY_OF_MONTH, -30);
				
				Date start = calendar.getTime();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				dateFrom = df.format(start);
				dateTo = df.format(end);
				lista_pacchi = GestioneMagazzinoBO.getListaPacchiPerData(df.format(start), df.format(end), "data_lavorazione", 1, session);
			}
			else {
				lista_pacchi = GestioneMagazzinoBO.getListaPacchiApertiChiusi(id_company, 0, session);				
			}
			

			
			ArrayList<MagDdtDTO> lista_ddt = new ArrayList<MagDdtDTO>();
			for (MagPaccoDTO pacco : lista_pacchi) {
				pacco.getDdt().setCommessa(pacco.getCommessa());
				if(pacco.getDdt().getId_destinatario()!=null && pacco.getDdt().getId_destinatario()!=0) {
					pacco.getDdt().setDestinatario(listaClientiAll.get(pacco.getDdt().getId_destinatario()));	
				}
				if(pacco.getDdt().getId_sede_destinatario()!=null && pacco.getDdt().getId_sede_destinatario()!=0) {
					pacco.getDdt().setSede_destinatario(listaSediAll.get(pacco.getDdt().getId_destinatario()+"_"+pacco.getDdt().getId_sede_destinatario()));
				}
				if(pacco.getDdt().getId_destinazione()!=null && pacco.getDdt().getId_destinazione()!=0) {
					pacco.getDdt().setDestinazione(listaClientiAll.get(pacco.getDdt().getId_destinazione()));
				}
				if(pacco.getDdt().getId_sede_destinazione()!=null && pacco.getDdt().getId_sede_destinazione()!=0) {
					pacco.getDdt().setSede_destinazione(listaSediAll.get(pacco.getDdt().getId_destinazione()+"_"+pacco.getDdt().getId_sede_destinazione()));
				}
				if(!lista_ddt.contains(pacco.getDdt())) {
					lista_ddt.add(pacco.getDdt());	
				}
				
			}
			

			ArrayList<MagTipoDdtDTO> tipo_ddt = GestioneMagazzinoBO.getListaTipoDDT(session);
			ArrayList<MagTipoPortoDTO> tipo_porto = GestioneMagazzinoBO.getListaTipoPorto(session);
			ArrayList<MagTipoTrasportoDTO> tipo_trasporto = GestioneMagazzinoBO.getListaTipoTrasporto(session); 
			ArrayList<MagAspettoDTO> aspetto = GestioneMagazzinoBO.getListaTipoAspetto(session);
			ArrayList<MagTipoItemDTO> tipo_item = GestioneMagazzinoBO.getListaTipoItem(session);
			ArrayList<MagStatoLavorazioneDTO> stato_lavorazione = GestioneMagazzinoBO.getListaStatoLavorazione(session);
			ArrayList<MagAttivitaItemDTO> lista_attivita_item = GestioneMagazzinoBO.getListaAttivitaItem(session);
			ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0,true);
			ArrayList<MagNoteDdtDTO> lista_note_ddt = GestioneMagazzinoBO.getListaNoteDDT(session);
			ArrayList<MagCausaleDTO> lista_causali = GestioneMagazzinoBO.geListaCausali(session);
			
			session.close();			

			request.getSession().setAttribute("lista_clienti", listaClienti);
			request.getSession().setAttribute("lista_fornitori", listaFornitori);
			request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_tipo_ddt", tipo_ddt);
			request.getSession().setAttribute("lista_tipo_porto", tipo_porto);
			request.getSession().setAttribute("lista_tipo_trasporto", tipo_trasporto);
			request.getSession().setAttribute("lista_aspetto", aspetto);
			request.getSession().setAttribute("lista_tipo_item", tipo_item);
			request.getSession().setAttribute("lista_tipo_aspetto", aspetto);
			request.getSession().setAttribute("lista_stato_lavorazione", stato_lavorazione);
			request.getSession().setAttribute("lista_attivita_pacco", lista_attivita_item);
			request.getSession().setAttribute("lista_causali", lista_causali);
			
			String attivita_json = new Gson().toJson(lista_attivita_item);
			request.getSession().setAttribute("attivita_json", attivita_json);
			
			request.getSession().setAttribute("lista_commesse", lista_commesse);

			request.getSession().setAttribute("lista_note_ddt", lista_note_ddt);
//			String dateFrom="";
//			String dateTo = "";
			request.getSession().setAttribute("dateFromDdt",dateFrom);
			request.getSession().setAttribute("dateToDdt",dateTo);

			
			request.getSession().setAttribute("lista_ddt",lista_ddt);
			request.getSession().setAttribute("stato",stato);
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDDT.jsp");
	     	dispatcher.forward(request,response);
		
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action.equals("filtraDateDDT")) {
			
			String dateFrom = request.getParameter("dateFrom");
			String dateTo = request.getParameter("dateTo");
			
			HashMap<Integer, String> listaClientiAll = (HashMap<Integer, String>)request.getSession().getAttribute("listaClientiAll");
			if(listaClientiAll==null) 
			{
				listaClientiAll = GestioneAnagraficaRemotaBO.getListaClientiAll();
				request.getSession().setAttribute("listaClientiAll",listaClientiAll);
			}	
			
			HashMap<String, String> listaSediAll = (HashMap<String, String>)request.getSession().getAttribute("listaSediAll");
			if(listaSediAll==null) 
			{
				listaSediAll = GestioneAnagraficaRemotaBO.getListaSediAll();
				request.getSession().setAttribute("listaSediAll",listaSediAll);
			}
			
			ArrayList<MagDdtDTO> lista_ddt = GestioneMagazzinoBO.getListaDDTPerData(dateFrom, dateTo, session);
			session.close();
			
			for (MagDdtDTO ddt : lista_ddt) {
			if(ddt.getId_destinatario()!=null && ddt.getId_destinatario()!=0) {
				ddt.setDestinatario(listaClientiAll.get(ddt.getId_destinatario()));	
			}
			if(ddt.getId_sede_destinatario()!=null && ddt.getId_sede_destinatario()!=0) {
				ddt.setSede_destinatario(listaSediAll.get(ddt.getId_destinatario()+"_"+ddt.getId_sede_destinatario()));
			}
			if(ddt.getId_destinazione()!=null && ddt.getId_destinazione()!=0) {
				ddt.setDestinazione(listaClientiAll.get(ddt.getId_destinazione()));
			}
			if(ddt.getId_sede_destinazione()!=null && ddt.getId_sede_destinazione()!=0) {
				ddt.setSede_destinazione(listaSediAll.get(ddt.getId_destinazione()+"_"+ddt.getId_sede_destinazione()));
			}
		}
			
			request.getSession().setAttribute("lista_ddt",lista_ddt);
			request.getSession().setAttribute("dateFromDdt",dateFrom);
			request.getSession().setAttribute("dateToDdt",dateTo);
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDDT.jsp");
	     	dispatcher.forward(request,response);
	     	
	     	logger.error("Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
				
		
		
		} catch (Exception e) {
			session.close();
			e.printStackTrace();
			 request.setAttribute("error",STIException.callException(e));
	   	     request.getSession().setAttribute("exception", e);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
	   
		}
		
		
	}

}
