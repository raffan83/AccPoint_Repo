package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaItemDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagNoteDdtDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;

/**
 * Servlet implementation class ListaItem
 */
@WebServlet("/listaItem.do")
public class ListaItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static final Logger logger = Logger.getLogger(ListaItem.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		PrintWriter  out = response.getWriter();
		boolean ajax = false;
		try {
		String tipo_item = request.getParameter("tipo_item");
		String action = request.getParameter("action");
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
	
		if(action!=null && action.equals("new")) {
			ajax = false;
			
			String categoria = request.getParameter("categoria");
			String descrizione = request.getParameter("descrizione");
			String quantita = request.getParameter("quantita");
			String matricola = request.getParameter("matricola");
			
			MagAccessorioDTO generico= new MagAccessorioDTO();
			
			generico.setCategoria(new MagCategoriaDTO(Integer.parseInt(categoria),""));
			generico.setDescrizione(descrizione);
			generico.setQuantita_fisica(Integer.parseInt(quantita));
			generico.setMatricola(matricola);
			
			GestioneMagazzinoBO.saveGenerico(generico, session);
			
			session.getTransaction().commit();
			session.close();
			
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Generico inserito correttamente!");
		
		out.print(myObj);
		
		logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		
		
		if(action!=null && action.equals("lista_item_inserimento") && tipo_item!=null && tipo_item.equals("1")) {
			ajax = false;
			String id_cliente=request.getParameter("id_cliente");
			String id_sede = request.getParameter("id_sede");
			
			String[] sede= id_sede.split("_");
			String[] cliente= id_cliente.split("_");
				
			ArrayList<StrumentoDTO> lista_strumenti = (ArrayList<StrumentoDTO>) GestioneStrumentoDAO.getListaStrumenti(cliente[0],sede[0], utente.getCompany().getId(), session,utente);
							
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto(session);
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento(session);
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione(session);
				ArrayList<CompanyDTO> lista_company = GestioneCompanyBO.getAllCompany(session);
				
				session.close();
		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
		        request.getSession().setAttribute("lista_company",lista_company);
			
			request.getSession().setAttribute("lista_strumenti", lista_strumenti);
			request.getSession().setAttribute("id_Cliente", cliente[0]);
			request.getSession().setAttribute("id_Sede", sede[0]);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemStrumenti.jsp");
		     dispatcher.forward(request,response);
		     
		     logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action!=null && action.equals("lista_item_inserimento") && tipo_item!=null && tipo_item.equals("2")) {
			ajax = false;
			
			CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			ArrayList<AccessorioDTO> lista_accessori =  (ArrayList<AccessorioDTO>) GestioneAccessorioBO.getListaAccessori(cmp,session);
			
			request.getSession().setAttribute("lista_accessori", lista_accessori);
			session.close();
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemAccessori.jsp");
		     dispatcher.forward(request,response);
		     logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action!=null && action.equals("lista_item_inserimento") && tipo_item!=null && tipo_item.equals("3")) {
			
			ajax = false;
			ArrayList<MagAccessorioDTO> lista_generici =   GestioneMagazzinoBO.getListaGenerici(session);
			ArrayList<MagCategoriaDTO> categoria_generico = GestioneMagazzinoBO.getListaCategorie(session);
 			
			request.getSession().setAttribute("lista_generici", lista_generici);
			request.getSession().setAttribute("categoria_generico", categoria_generico);
			session.close();
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemGenerici.jsp");
		     dispatcher.forward(request,response);
		     logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action!=null && action.equals("lista")) {
			
			ajax = false;
			
			
			int id_company= utente.getCompany().getId();
			
			String stato = request.getParameter("stato");
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
			
			
	
			ArrayList<MagTipoDdtDTO> tipo_ddt = GestioneMagazzinoBO.getListaTipoDDT(session);
			ArrayList<MagTipoPortoDTO> tipo_porto = GestioneMagazzinoBO.getListaTipoPorto(session);
			ArrayList<MagTipoTrasportoDTO> tipo_trasporto = GestioneMagazzinoBO.getListaTipoTrasporto(session); 
			ArrayList<MagAspettoDTO> aspetto = GestioneMagazzinoBO.getListaTipoAspetto(session);
			ArrayList<MagTipoItemDTO> lista_tipo_item = GestioneMagazzinoBO.getListaTipoItem(session);
			ArrayList<MagStatoLavorazioneDTO> stato_lavorazione = GestioneMagazzinoBO.getListaStatoLavorazione(session);
			ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0,false);
			ArrayList<MagAttivitaItemDTO> lista_attivita_item = GestioneMagazzinoBO.getListaAttivitaItem(session);
			

			
			ArrayList<MagItemPaccoDTO> lista_item_pacco = null;
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
				lista_item_pacco = GestioneMagazzinoBO.getListaItemPaccoPerData(df.format(start), df.format(end), "data_lavorazione", 0, session);
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
				lista_item_pacco = GestioneMagazzinoBO.getListaItemPaccoPerData(df.format(start), df.format(end), "data_lavorazione", 1, session);
			}
			else {
				lista_item_pacco = GestioneMagazzinoBO.getListaItemPaccoApertiChiusi(0, session);				
			}
			
			
			
			//ArrayList<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPacco(session);
			ArrayList<MagNoteDdtDTO> lista_note_ddt = GestioneMagazzinoBO.getListaNoteDDT(session);
			ArrayList<MagCausaleDTO> lista_causali = GestioneMagazzinoBO.geListaCausali(session);
			session.close();
			
			request.getSession().setAttribute("stato", stato);
			//request.getSession().setAttribute("lista_pacchi",lista_pacchi);
			request.getSession().setAttribute("lista_clienti", listaClienti);
			request.getSession().setAttribute("lista_fornitori", listaFornitori);
			request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_tipo_ddt", tipo_ddt);
			request.getSession().setAttribute("lista_tipo_porto", tipo_porto);
			request.getSession().setAttribute("lista_tipo_trasporto", tipo_trasporto);
			request.getSession().setAttribute("lista_aspetto", aspetto);
			request.getSession().setAttribute("lista_tipo_item", lista_tipo_item);
			request.getSession().setAttribute("lista_tipo_aspetto", aspetto);
			request.getSession().setAttribute("lista_stato_lavorazione", stato_lavorazione);
			request.getSession().setAttribute("lista_commesse", lista_commesse);
			request.getSession().setAttribute("lista_attivita_pacco", lista_attivita_item);
			request.getSession().setAttribute("lista_causali", lista_causali);
			request.getSession().setAttribute("lista_note_ddt", lista_note_ddt);
			String attivita_json = new Gson().toJson(lista_attivita_item);
			request.getSession().setAttribute("attivita_json", attivita_json);
			Gson gson = new Gson();
    		String item_pacco_json = gson.toJson(lista_item_pacco);
    		
    		request.getSession().setAttribute("dateTo",dateTo);
			request.getSession().setAttribute("dateFrom", dateFrom);
			request.getSession().setAttribute("lista_item_pacco", lista_item_pacco);
			request.getSession().setAttribute("item_pacco_json", item_pacco_json);
			request.getSession().setAttribute("item_esterno", false);
			request.getSession().setAttribute("item_magazzino", false);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemMagazzino.jsp");
		     dispatcher.forward(request,response);
			
		     logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if(action!=null && action.equals("item_esterno")) {
			
			ajax = false;
			ArrayList<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaStrumentiInEsterno(session);
			
			session.close();

			Gson gson = new Gson();
    		String item_pacco_json = gson.toJson(lista_item_pacco);
    		
			request.getSession().setAttribute("lista_item_pacco", lista_item_pacco);
			request.getSession().setAttribute("item_pacco_json", item_pacco_json);
			request.getSession().setAttribute("item_esterno", true);
			request.getSession().setAttribute("item_magazzino", false);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemMagazzino.jsp");
		     dispatcher.forward(request,response);
			
		     logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		else if(action!=null && action.equals("item_magazzino")) {
			
			ajax = false;
			ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoBO.getListaPacchiInMagazzino(session);
			ArrayList<MagItemPaccoDTO> lista_item_pacco = new ArrayList<MagItemPaccoDTO>();
			
			for (MagPaccoDTO magPaccoDTO : lista_pacchi) {
				for (MagItemPaccoDTO magItemPaccoDTO : magPaccoDTO.getItem_pacco()) {
					
					lista_item_pacco.add(magItemPaccoDTO);
				}
			}
			
//			ArrayList<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaStrumentiInMagazzino(session);
			
			session.close();

			Gson gson = new Gson();
    		String item_pacco_json = gson.toJson(lista_item_pacco);
    		
			request.getSession().setAttribute("lista_item_pacco", lista_item_pacco);
			request.getSession().setAttribute("item_pacco_json", item_pacco_json);
			request.getSession().setAttribute("item_esterno", false);
			request.getSession().setAttribute("item_magazzino", true);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemMagazzino.jsp");
		     dispatcher.forward(request,response);
		     logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		
		else if (action!=null && action.equals("cerca_origini")) {
			ajax = true;
			String id_item = request.getParameter("id_item");
			String matricola = request.getParameter("matricola");
			
			ArrayList<MagPaccoDTO> lista_pacchi_origine = GestioneMagazzinoBO.getOriginiFromItem(id_item, matricola, session);
			
			Gson gson = new Gson();
    		String pacchi_origine_json = gson.toJson(lista_pacchi_origine);
			
			request.getSession().setAttribute("pacchi_origine_json", pacchi_origine_json);
			session.close();
			
			if(lista_pacchi_origine!=null && lista_pacchi_origine.size()>0) {
				myObj.addProperty("success", true);
				myObj.addProperty("pacchi_origine_json", pacchi_origine_json);
			}else {
				myObj.addProperty("success", false);
				myObj.addProperty("messaggio", "Nessun pacco origine trovato!");
			}
			out.print(myObj);
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		else if(action!=null && action.equals("storico_item")) {
			
			ajax = true;
			String origine = request.getParameter("origine");
			String id_item = request.getParameter("id_item");    		
			String matricola = request.getParameter("matricola");
			
				ArrayList<MagPaccoDTO> lista_pacchi_origine = GestioneMagazzinoDAO.getListaPacchiByOrigineAndItem(origine,id_item, matricola, session);
				
				Gson gson = new GsonBuilder().setDateFormat("MM/dd/yyyy").create();
	    		String lista_pacchi_json = gson.toJson(lista_pacchi_origine);
								
				if(lista_pacchi_origine!=null && lista_pacchi_origine.size()>0) {
					myObj.addProperty("success", true);
					myObj.addProperty("lista_pacchi_json", lista_pacchi_json);
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Non è possibile visualizzare lo storico!");
				}
				session.close();
				out.print(myObj);
				logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		else if(action!=null && action.equals("filtraDate")) {
			
			
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
			
			ArrayList<MagItemPaccoDTO> lista_item_pacco = GestioneMagazzinoBO.getListaItemPaccoPerData(dateFrom, dateTo, tipo,0, session);
			session.close();
			
			request.getSession().setAttribute("lista_item_pacco",lista_item_pacco);
			request.getSession().setAttribute("dateFrom",dateFrom);
			request.getSession().setAttribute("dateTo",dateTo);
			request.getSession().setAttribute("tipo_data", tipo_data);
			request.getSession().setAttribute("item_esterno", false);
			request.getSession().setAttribute("item_magazzino", false);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaItemMagazzino.jsp");
	     	dispatcher.forward(request,response);
	     	logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo() +" - fine action");
		}
		

		} catch (Exception e) {
		
			session.getTransaction().rollback();
			session.close();
		if(ajax) {

			e.printStackTrace();
			
			request.getSession().setAttribute("exception", e);
			myObj = STIException.getException(e);
			out.print(myObj);
		
		}else {
			e.printStackTrace();
			
   	     request.setAttribute("error",STIException.callException(e));
   	     request.getSession().setAttribute("exception", e);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	  
		}
		}
		
	}

}
