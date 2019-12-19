package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ControlloAttivitaDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MilestoneOperatoreDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAssegnazioneAttivitaBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneAssegnazioneAttivita
 */
@WebServlet("/gestioneAssegnazioneAttivita.do")
public class GestioneAssegnazioneAttivita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAssegnazioneAttivita() {
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
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			
			if(action.equals("assegna")) {
			
				String str = request.getParameter("str");
				
				
				InterventoDTO intervento = (InterventoDTO) request.getSession().getAttribute("intervento");
				
				String [] line =str.split(";");
				
				for (String attivita : line) {
					
					String[] data=attivita.split("_");
				
					MilestoneOperatoreDTO milestone = new MilestoneOperatoreDTO();
					
					String descrizione=data[0];
					String note=data[1];
					BigDecimal qta_tot =new BigDecimal(data[2]);
					BigDecimal qta_ass= new BigDecimal(data[3]);
					BigDecimal importo_unitario= new BigDecimal(data[4]);
					String unita_misura = "";
					
					if(data.length>5) {
						unita_misura = data[5];
					}							
					
					milestone.setIntervento(intervento);
					milestone.setUser(utente);
					milestone.setDescrizioneMilestone(descrizione);
					milestone.setQuantitaTotale(qta_tot);
					milestone.setData(new Date());
					milestone.setQuantitaAssegnata(qta_ass);
					milestone.setPrezzo_un(importo_unitario);
					milestone.setPresso_assegnato(qta_ass.setScale(2, RoundingMode.HALF_UP).multiply(importo_unitario.setScale(2, RoundingMode.HALF_UP)));
					milestone.setPrezzo_totale(qta_tot.multiply(importo_unitario));
					milestone.setPrezzo_un(importo_unitario);
					milestone.setNote(note);
					milestone.setAbilitato(1);
					milestone.setUnita_misura(unita_misura);
					
					session.save(milestone);
				}
				
				
				session.getTransaction().commit();
				session.close();	
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attività assegnata con successo!");
				out.print(myObj);
			}
			else if(action.equals("lista")){
				
				String admin = request.getParameter("admin");
				
				ArrayList<String> listaCommesse = null;
				if(admin.equals("1")) {
					listaCommesse = GestioneAssegnazioneAttivitaBO.getListaCommesse(0,session);
				}else {
					listaCommesse = GestioneAssegnazioneAttivitaBO.getListaCommesse(utente.getId(),session);
				}
				ArrayList<UtenteDTO> lista_utenti = new ArrayList<UtenteDTO>();
				ArrayList<UtenteDTO> lista_utenti_company = GestioneUtenteBO.getUtentiFromCompany(utente.getCompany().getId(), session);
				for (UtenteDTO user : lista_utenti_company) {
					if(user.checkRuolo("OP") || user.checkRuolo("AM") || user.checkRuolo("RS")) {
						lista_utenti.add(user);
					}
				}
				
				Collections.sort(lista_utenti, new Comparator<UtenteDTO>() {
				    public int compare(UtenteDTO v1, UtenteDTO v2) {
				        return v1.getNominativo().compareTo(v2.getNominativo());
				    }
				});
				
				request.getSession().setAttribute("lista_commesse",listaCommesse);
				request.getSession().setAttribute("lista_utenti",lista_utenti);
				
				session.getTransaction().commit();
				session.close();
				
				if(admin.equals("1")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAssegnazioneAttivitaAdmin.jsp");	
					dispatcher.forward(request,response);	
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAssegnazioneAttivita.jsp");
					dispatcher.forward(request,response);	
				}
				
		  	    
				
			}
			else if(action.equals("cerca")) {
				
				String admin = request.getParameter("admin");
				String id_utente = request.getParameter("utente");
				String commessa = request.getParameter("commessa");
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
				
				ArrayList<MilestoneOperatoreDTO> lista_milestone = null;
				
				if(id_utente.equals("")&& commessa.equals("") && dateFrom.equals("") && dateTo.equals("")) {
					
					lista_milestone = GestioneAssegnazioneAttivitaBO.getListaMilestoneOperatore(session);
					
				}else {
					
					lista_milestone = GestioneAssegnazioneAttivitaBO.getListaMilestoneFiltrata(id_utente, commessa, dateFrom, dateTo, session);
					
				}
										
				request.getSession().setAttribute("lista_milestone",lista_milestone);
				
				session.getTransaction().commit();
				session.close();
				
				if(admin.equals("1")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAssegnazioneAttivitaFiltrataAdmin.jsp");
					dispatcher.forward(request,response);	
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAssegnazioneAttivitaFiltrata.jsp");
					dispatcher.forward(request,response);	
				}
				
				
			}
			else if(action.equals("modifica")) {
				
				String id_assegnazione = request.getParameter("id_assegnazione");
				String prezzo_unitario = request.getParameter("prezzo_unitario");
				String prezzo_assegnato = request.getParameter("prezzo_assegnato");
				String quantita_totale = request.getParameter("quantita_totale");
				String quantita_assegnata = request.getParameter("quantita_assegnata");
				String unita_misura = request.getParameter("unita_misura");
				String note = request.getParameter("note");
				
				MilestoneOperatoreDTO assegnazione = GestioneAssegnazioneAttivitaBO.getMilestone(Integer.parseInt(id_assegnazione),session);
				
				if(prezzo_assegnato!=null && !prezzo_assegnato.equals("")) {
					assegnazione.setPresso_assegnato(new BigDecimal(prezzo_assegnato));
				}
				if(prezzo_unitario!=null && !prezzo_unitario.equals("")) {
					assegnazione.setPrezzo_un(new BigDecimal(prezzo_unitario));
				}
				if(quantita_assegnata!=null && !quantita_assegnata.equals("")) {
					assegnazione.setQuantitaAssegnata(new BigDecimal(quantita_assegnata));
				}
				if(quantita_totale!=null && !quantita_totale.equals("")) {
					assegnazione.setQuantitaTotale(new BigDecimal(quantita_totale));
				}
				
				assegnazione.setNote(note);
				assegnazione.setUnita_misura(unita_misura);
				
				session.update(assegnazione);
				session.getTransaction().commit();
				session.close();
				PrintWriter out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvataggio effettuato con successo!");				
	        	out.print(myObj);
			}
			
			else if(action.equals("elimina")) {
				
				String id_assegnazione = request.getParameter("id_assegnazione");
								
				MilestoneOperatoreDTO assegnazione = GestioneAssegnazioneAttivitaBO.getMilestone(Integer.parseInt(id_assegnazione),session);
				
				assegnazione.setAbilitato(0);				
				
				session.update(assegnazione);
				session.getTransaction().commit();
				session.close();
				PrintWriter out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Assegnazione eliminata con successo!");				
	        	out.print(myObj);
			}
			else if(action.equals("controllo_attivita")) {
				
				ArrayList<UtenteDTO> lista_utenti = new ArrayList<UtenteDTO>();
				ArrayList<UtenteDTO> lista_utenti_company = GestioneUtenteBO.getUtentiFromCompany(utente.getCompany().getId(), session);
				for (UtenteDTO user : lista_utenti_company) {
					if(user.checkRuolo("OP") || user.checkRuolo("AM") || user.checkRuolo("RS")) {
						lista_utenti.add(user);
					}
				}
				
				Collections.sort(lista_utenti, new Comparator<UtenteDTO>() {
				    public int compare(UtenteDTO v1, UtenteDTO v2) {
				        return v1.getNominativo().compareTo(v2.getNominativo());
				    }
				});
				
			
				request.getSession().setAttribute("lista_utenti",lista_utenti);
				
				
				session.getTransaction().commit();
				session.close();

				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaControlloAttivita.jsp");
				dispatcher.forward(request,response);	
				
			}
			else if(action.equals("cerca_controllo")) {
				
				String id_utente = request.getParameter("utente");				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
								
				
				ArrayList<InterventoDTO> lista_intervento_operatore = GestioneInterventoBO.getListaInterventoUtente(Integer.parseInt(id_utente), dateFrom, dateTo,session);
				ArrayList<ControlloAttivitaDTO> lista_controllo_attivita = new ArrayList<ControlloAttivitaDTO>();
				
				for (InterventoDTO intervento : lista_intervento_operatore) {
					int nStrumenti = 0;
					BigDecimal nStrumentiAss = BigDecimal.ZERO;
					ControlloAttivitaDTO controllo = new ControlloAttivitaDTO();
					Object[] result = new Object[2];
					UtenteDTO operatore = null;
					for (InterventoDatiDTO int_dati : intervento.getListaInterventoDatiDTO()) {
						if(int_dati.getUtente().getId()==Integer.parseInt(id_utente)) {
							nStrumenti = nStrumenti + int_dati.getNumStrMis();
							operatore = int_dati.getUtente();
						}
					}
				
					result = GestioneInterventoBO.getStrumentiAssegnatiUtente(Integer.parseInt(id_utente), intervento.getId(), session);
					nStrumentiAss = (BigDecimal) result[0];
					controllo.setControllato((int) result[1]);
					//nStrumentiAss = GestioneInterventoBO.getStrumentiAssegnatiUtente(Integer.parseInt(id_utente), intervento.getId(), session);
					controllo.setIntervento(intervento);
					if(operatore!=null) {
						controllo.setOperatore(operatore);	
					}else {
						controllo.setOperatore(GestioneUtenteBO.getUtenteById(id_utente, session));
					}
					
					controllo.setStrumentiAss(nStrumentiAss.intValue());
					controllo.setStrumentiTot(nStrumenti);
					controllo.setUnita_misura((String)result[2]);
					
					lista_controllo_attivita.add(controllo);
				}
				
				
				request.getSession().setAttribute("lista_controllo_attivita",lista_controllo_attivita);
				
				session.getTransaction().commit();
				session.close();
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaControlloAttivitaTab.jsp");
				dispatcher.forward(request,response);	
			
			}
			else if(action.equals("check_controllo")) {
				String id_intervento = request.getParameter("id_intervento");
				String id_utente = request.getParameter("id_utente");
				String tipo = request.getParameter("tipo");
				
				GestioneInterventoBO.setControllato(Integer.parseInt(id_intervento), Integer.parseInt(id_utente), Integer.parseInt(tipo),session );
				
				myObj.addProperty("success", true);
				PrintWriter out = response.getWriter();
				
				session.getTransaction().commit();
	        	session.close();
				
				out.print(myObj);
			}
			
		}catch (Exception e) {
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
