package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.RilInterventoDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;

/**
 * Servlet implementation class ListaRilieviDimensionali
 */
@WebServlet("/listaRilieviDimensionali.do")
public class ListaRilieviDimensionali extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ListaRilieviDimensionali.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaRilieviDimensionali() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		
		String action = request.getParameter("action");
	
		
		try {
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			if(action==null) {
				List<ClienteDTO> listaClientiFull = null;
				List<ClienteDTO> listaClienti = new ArrayList<ClienteDTO>();
				ArrayList<String> clientiIds=null;
				if(utente.checkRuolo("AM") || utente.checkPermesso("RILIEVI_DIMENSIONALI")) {
				
					if(request.getSession().getAttribute("listaClientiAll")==null) 
					{
						request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
					}	
					
					if(request.getSession().getAttribute("listaSediAll")==null) 
					{				
							request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
					}			
			
					listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
					if(listaClienti==null) {
						listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
					}
					
					//ArrayList<Integer> clientiIds = GestioneRilieviBO.getListaClientiRilievi();
					//clientiIds = GestioneRilieviBO.getListaClientiRilievi(session);
										
//					for (ClienteDTO cliente : listaClientiFull) {
//		 				if(clientiIds.contains(cliente.get__id())) {
//							listaClienti.add(cliente);
//						}
//					}
											
				}else {
					listaClienti = new ArrayList<ClienteDTO>();
					listaClienti.add(GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(utente.getIdCliente())));
					
				}
			
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				ArrayList<RilTipoRilievoDTO> lista_tipo_rilievo = GestioneRilieviBO.getListaTipoRilievo(session);					
				ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0, true);
				
				String id_stato_lavorazione = request.getParameter("id_stato_lavorazione");
				String cliente_filtro = request.getParameter("cliente_filtro");	
				
				request.getSession().setAttribute("lista_clienti", listaClienti);
				//request.getSession().setAttribute("lista_clienti", clientiIds);
				request.getSession().setAttribute("lista_sedi", listaSedi);
				
				request.getSession().setAttribute("lista_tipo_rilievo", lista_tipo_rilievo);
				request.getSession().setAttribute("lista_commesse", lista_commesse);
				
				if(cliente_filtro!=null && id_stato_lavorazione!=null) {
					request.getSession().setAttribute("cliente_filtro", Utility.decryptData(cliente_filtro));
					request.getSession().setAttribute("filtro_rilievi", Utility.decryptData(id_stato_lavorazione));
				}
				
//				ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilievi();
//				ArrayList<String> lista_comm =  new ArrayList<String>();
//				
//				for (RilMisuraRilievoDTO r : lista_rilievi) {
//					
//					if(!lista_comm.contains(r.getCommessa())) {
//						RilInterventoDTO intervento = new RilInterventoDTO();
//						intervento.setCommessa(r.getCommessa());
//						intervento.setData_apertura(r.getData_inizio_rilievo());
//						intervento.setData_chiusura(r.getData_consegna());
//						intervento.setId_cliente(r.getId_cliente_util());
//						intervento.setId_sede(r.getId_sede_util());
//						intervento.setNome_cliente(r.getNome_cliente_util());
//						intervento.setNome_sede(r.getNome_sede_util());
//						intervento.setStato_intervento(r.getStato_rilievo().getId());
//						
//						lista_comm.add(r.getCommessa());
//						session.save(intervento);
//						
//						
//						r.setIntervento(intervento);
//					
//						
//					}else {
//						
//						ArrayList<RilInterventoDTO> lista_int = GestioneRilieviBO.getListaInterventi(r.getId_cliente_util(), 0, session);
//						
//						for (RilInterventoDTO intervento : lista_int) {
//							
//							if(intervento.getCommessa().equals(r.getCommessa())) {
//								r.setIntervento(intervento);
//								break;
//							}
//							
//						}
//						
//					}
//					session.update(r);
//				}
//				
//				
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilievi.jsp");
		  	    dispatcher.forward(request,response);	
			}
			else if(action.equals("filtra")) {
				
				String id_stato_lavorazione = request.getParameter("id_stato_lavorazione");
				String cliente_filtro = request.getParameter("cliente_filtro");	
				String year = request.getParameter("anno");
				
				
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
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));	
				}
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				HashMap<Integer, String> listaClientiAll = (HashMap<Integer, String>)request.getSession().getAttribute("listaClientiAll");
				HashMap<String, String> listaSediAll = (HashMap<String, String>)request.getSession().getAttribute("listaSediAll");

				ArrayList<RilMisuraRilievoDTO> lista_rilievi = 	null;
				int anno = 0;
				if(year!=null && !year.equals("")) {
					anno = Integer.parseInt(year);
				}else {
					Calendar cal = Calendar.getInstance();
					cal.setTime(new Date());
					anno = cal.get(Calendar.YEAR);
				}
				
				String controfirmato = "0";
				if(id_stato_lavorazione.split("_").length>1) {
					controfirmato = id_stato_lavorazione.split("_")[1];
				}
				
				if(cliente_filtro!=null && !cliente_filtro.equals("") && !cliente_filtro.equals("0")) {
					 lista_rilievi = GestioneRilieviBO.getListaRilieviFiltrati(Integer.parseInt(id_stato_lavorazione.split("_")[0]), Integer.parseInt(cliente_filtro), anno, controfirmato, session);
				}else{
					 lista_rilievi = GestioneRilieviBO.getListaRilieviInLavorazione(Integer.parseInt(id_stato_lavorazione.split("_")[0]), anno, controfirmato, session);	
				}
				
				
				for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
					if(rilievo.getId_cliente_util()!=0) {
						rilievo.setNome_cliente_util(listaClientiAll.get(rilievo.getId_cliente_util()));
					}
					rilievo.setNome_sede_util(listaSediAll.get(rilievo.getId_cliente_util()+"_"+rilievo.getId_sede_util()));
				}
				
		
				request.getSession().setAttribute("lista_rilievi", lista_rilievi);
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);
				request.getSession().setAttribute("cliente_filtro", cliente_filtro);
				request.getSession().setAttribute("filtro_rilievi", id_stato_lavorazione);
				request.getSession().setAttribute("anno_riferimento", anno);
			//	request.getSession().setAttribute("lista_tipo_rilievo", lista_tipo_rilievo);
			//	request.getSession().setAttribute("lista_commesse", lista_commesse);
				
				if(id_stato_lavorazione.equals("1")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviInLavorazione.jsp");
		  	    	dispatcher.forward(request,response);	
				}
				else if(id_stato_lavorazione.equals("0")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviTutti.jsp");
		  	    	dispatcher.forward(request,response);	
				}
				else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviLavorati.jsp");
		  	    	dispatcher.forward(request,response);	
				}
				session.getTransaction().commit();
				session.close();
				
			}

			
			else if(action.equals("lista_interventi")) {
				
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));	
				}
				request.getSession().setAttribute("lista_clienti", listaClienti);		
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilInterventi.jsp");
		  	    dispatcher.forward(request,response);	
			
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("filtra_interventi_rilievi")) {
				
				String id_cliente = request.getParameter("id_cliente");
				String stato = request.getParameter("stato");
				
				ArrayList<RilInterventoDTO> lista_interventi = GestioneRilieviBO.getListaInterventi(Integer.parseInt(id_cliente), Integer.parseInt(stato), session);
				
				request.getSession().setAttribute("lista_interventi", lista_interventi);		
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilInterventiFiltro.jsp");
		  	    dispatcher.forward(request,response);	
			
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("lista_rilievi_intervento")) {
				
				String id_intervento = request.getParameter("id_intervento");
				RilInterventoDTO intervento = GestioneRilieviBO.getInterventoFromId(Integer.parseInt(id_intervento), session);
				
				ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilieviIntervento(Integer.parseInt(id_intervento), session);
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));	
				}
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				ArrayList<RilTipoRilievoDTO> lista_tipo_rilievo = GestioneRilieviBO.getListaTipoRilievo(session);					
				ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0, true);
				request.getSession().setAttribute("lista_tipo_rilievo", lista_tipo_rilievo);
				request.getSession().setAttribute("lista_commesse", lista_commesse);	
				request.getSession().setAttribute("lista_clienti", listaClienti);	
				request.getSession().setAttribute("lista_sedi", listaSedi);	
				request.getSession().setAttribute("lista_rilievi", lista_rilievi);		
				request.getSession().setAttribute("intervento", intervento);	
				request.getSession().setAttribute("filtro_rilievi", "");
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRilieviIntervento.jsp");
		  	    dispatcher.forward(request,response);	
			
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("cerca_rilievi_schede")) {
				 response.setContentType("application/json");
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");

				ArrayList<String> lista_clienti = new ArrayList<String>();
				ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getRilieviDateSchedeConsegna(dateFrom, dateTo, session);
			
				for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
					if(!lista_clienti.contains(rilievo.getCommessa()+";"+rilievo.getNome_cliente_util()+";"+rilievo.getNome_sede_util())) {
						lista_clienti.add(rilievo.getCommessa()+";"+rilievo.getNome_cliente_util()+";"+rilievo.getNome_sede_util());	
					}
					
				}
			
				
				session.close();
				
				
				PrintWriter out = response.getWriter();
				
				Gson g = new Gson();
				
				myObj.addProperty("success", true);
				myObj.add("lista_clienti", g.toJsonTree(lista_clienti));
				
				out.print(myObj);
			
				
			}
			
		} catch (Exception e) {
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				PrintWriter out = response.getWriter();
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
