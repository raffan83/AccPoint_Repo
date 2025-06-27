package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.math3.analysis.function.Add;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.PRInterventoRequisitoDTO;
import it.portaleSTI.DTO.PRInterventoRisorsaDTO;
import it.portaleSTI.DTO.PRRequisitoDocumentaleDTO;
import it.portaleSTI.DTO.PRRequisitoRisorsaDTO;
import it.portaleSTI.DTO.PRRequisitoSanitarioDTO;
import it.portaleSTI.DTO.PRRisorsaDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneRisorseBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneRisorse
 */
@WebServlet("/gestioneRisorse.do")
public class GestioneRisorse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneRisorse() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("dettaglio_risorsa")) {
				
				String id = request.getParameter("id_risorsa");
				String id_partecipante = request.getParameter("id_partecipante");
				
				
				ArrayList<PRRequisitoRisorsaDTO> lista_requisiti_risorsa = null;
				PRRisorsaDTO risorsa = null; 
				if(id!=null && !id.equals("")) {
				risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id));
				
				lista_requisiti_risorsa = GestioneRisorseBO.getListaRequisitiRisorsa(risorsa.getId(),session);				
				
				id_partecipante = ""+risorsa.getPartecipante().getId();
				}
				
				ArrayList<ForCorsoDTO> lista_corsi = null;
				if(id_partecipante!=null && !id_partecipante.equals("")) {
					 lista_corsi = GestioneFormazioneBO.getListaCorsiInCorsoPartecipante(Integer.parseInt(id_partecipante), session);
				}
				
						
			
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_requisiti_risorsa", g.toJsonTree(lista_requisiti_risorsa));
				myObj.add("lista_corsi", g.toJsonTree(lista_corsi));
				myObj.add("risorsa", g.toJsonTree(risorsa));
				out.print(myObj);
				
			}
			
			else if(action.equals("trova_interventi_disponibili")) {
				
				
				String id = request.getParameter("id_risorsa");			
				String data = request.getParameter("data");		
				
				
				  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
				
				 LocalDate date = LocalDate.parse(data, formatter);
				int meseCorrente = date.getMonthValue();
		
				int anno = date.getYear();
			
				LocalDate inizioAnno = LocalDate.of(anno,1,1);
	

				PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id));				
				ArrayList<PRRequisitoRisorsaDTO>  lista_requisiti_risorsa = GestioneRisorseBO.getListaRequisitiRisorsa(risorsa.getId(),session);				
				
			       
			        //ArrayList<InterventoDTO> lista_interventi = GestioneInterventoBO.getListainterventiDate(date, date, session);
			        ArrayList<InterventoDTO> lista_interventi = GestioneInterventoBO.getListainterventiDate(inizioAnno, date, session);
			     
			        ArrayList<ForCorsoDTO>lista_corsi = GestioneFormazioneBO.getListaCorsiInCorsoPartecipante(risorsa.getPartecipante().getId(), session);
			     // 1. ID dei requisiti sanitari associati alla risorsa
			        Set<Integer> idRequisitiSanitariRisorsa = new HashSet<>();
			        Set<Integer> idRequisitiDocumentaliRisorsa = new HashSet<>();
			        for (PRRequisitoRisorsaDTO req : lista_requisiti_risorsa) {
			            if (req.getReq_sanitario() != null) {
			                idRequisitiSanitariRisorsa.add(req.getReq_sanitario().getId());
			            }
			        }
			        
			        for (ForCorsoDTO c : lista_corsi) {
			           
			        	idRequisitiDocumentaliRisorsa.add(c.getCorso_cat().getId());
			           
			        }

			        ArrayList<InterventoDTO> lista_interventi_disponibili = new ArrayList<>();

			        // 2. Per ogni intervento, verifica che contenga tutti i requisiti sanitari della risorsa
			        for (InterventoDTO interventoDTO : lista_interventi) {
			        	if(interventoDTO.getStatoIntervento().getId() == 1) {
				            Set<Integer> idRequisitiSanitariIntervento = new HashSet<>();
				            Set<Integer> idRequisitiDocumentaliIntervento = new HashSet<>();
	
				            for (PRInterventoRequisitoDTO requisito : interventoDTO.getListaRequisiti()) {
				                if (requisito.getRequisito_sanitario() != null) {
				                    idRequisitiSanitariIntervento.add(requisito.getRequisito_sanitario().getId());
				                }
				                if (requisito.getRequisito_documentale() != null) {
				                	idRequisitiDocumentaliIntervento.add(requisito.getRequisito_documentale().getCategoria().getId());
				                }
				            }
	
				            // 3. Verifica che TUTTI i requisiti della risorsa siano presenti nell'intervento
				            if (idRequisitiSanitariRisorsa.containsAll(idRequisitiSanitariIntervento) && 
				            		idRequisitiDocumentaliRisorsa.containsAll(idRequisitiDocumentaliIntervento)) {
				                lista_interventi_disponibili.add(interventoDTO);
				            }
			        	}
			        }

			        
			    ArrayList<PRInterventoRisorsaDTO> lista_interventi_risorsa = GestioneRisorseBO.getListaInterventiRisorsa(risorsa.getId(), date,session);
			        
			
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				response.setContentType("application/json; charset=UTF-8");
				response.setCharacterEncoding("UTF-8");
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_requisiti_risorsa", g.toJsonTree(lista_requisiti_risorsa));
				myObj.add("lista_interventi_risorsa", g.toJsonTree(lista_interventi_risorsa));
				myObj.add("lista_interventi", g.toJsonTree(lista_interventi_disponibili));
				myObj.add("risorsa", g.toJsonTree(risorsa));
				out.print(myObj);
				
			}else if(action.equals("lista_associazioni")) {
				
				ajax = true;
				
//				ArrayList<PRInterventoRisorsaDTO> lista_associazioni = GestioneRisorseBO.getListaInterventoRisorseAll(session);
				ArrayList<PRInterventoRisorsaDTO> lista_associazioni =DirectMySqlDAO.getListaInterventoRisorseAll(session);
								

				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				response.setContentType("application/json; charset=UTF-8");
				response.setCharacterEncoding("UTF-8");
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_associazioni", g.toJsonTree(lista_associazioni));
				out.print(myObj);
				
			}
			else if(action.equals("get_risorse_disponibili")) {
				
				ajax = true;
				
				String id_intervento = request.getParameter("id_intervento");
				
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento, session);
				
				LocalDate localDate =	intervento.getDataCreazione().toInstant()
				        .atZone(ZoneId.systemDefault())
				        .toLocalDate();
				
				ArrayList<PRRisorsaDTO> lista_risorse_libere = GestioneRisorseBO.getListaRisorseLibere(localDate,session);
				ArrayList<PRRisorsaDTO> lista_risorse_all = GestioneRisorseBO.getListaRisorse(session);
				
				 ArrayList<PRRisorsaDTO> lista_risorse_disponibili = new ArrayList<>();
				
			
			        Set<Integer> idRequisitiSanitariRisorsa = new HashSet<>();
			        Set<Integer> idRequisitiDocumentaliRisorsa = new HashSet<>();
			        
			        Set<Integer> idRequisitiSanitariIntervento = new HashSet<>();
		            Set<Integer> idRequisitiDocumentaliIntervento = new HashSet<>();
			        for (PRInterventoRequisitoDTO req : intervento.getListaRequisiti()) {
			            if (req.getRequisito_sanitario() != null) {
			            	idRequisitiSanitariIntervento.add(req.getRequisito_sanitario().getId());
			            }
			            if (req.getRequisito_documentale() != null) {
			            	idRequisitiDocumentaliIntervento.add(req.getRequisito_documentale().getCategoria().getId());
			            }
			        }
			        
			        for (PRRisorsaDTO risorsa : lista_risorse_libere) {
			        	for (PRRequisitoRisorsaDTO r : risorsa.getListaRequisiti()) {
							
							if(r.getReq_sanitario()!=null) {
								idRequisitiSanitariRisorsa.add(r.getReq_sanitario().getId());
							}
							
							
						}
			        	
			        	
			        	 ArrayList<ForCorsoDTO>lista_corsi = GestioneFormazioneBO.getListaCorsiInCorsoPartecipante(risorsa.getPartecipante().getId(), session);
			        	 
			        	 for (ForCorsoDTO c : lista_corsi) {
					           
					        	idRequisitiDocumentaliRisorsa.add(c.getCorso_cat().getId());
					           
					        }
			        	 
			        	if (idRequisitiSanitariRisorsa.containsAll(idRequisitiSanitariIntervento) && 
			            		idRequisitiDocumentaliRisorsa.containsAll(idRequisitiDocumentaliIntervento)) {
			        		lista_risorse_disponibili.add(risorsa);
			            }
			           			           
			        }

			
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				response.setContentType("application/json; charset=UTF-8");
				response.setCharacterEncoding("UTF-8");
	

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_risorse_disponibili", g.toJsonTree(lista_risorse_disponibili));
				myObj.add("lista_risorse_all", g.toJsonTree(lista_risorse_all));
				out.print(myObj);
				
			}
			session.getTransaction().commit();
	    	session.close();
	}catch(Exception e) {
		e.printStackTrace();
		session.getTransaction().rollback();
    	session.close();
		if(ajax) {
			
			PrintWriter out = response.getWriter();
			
        	
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("lista_risorse")) {
				
				ArrayList<PRRisorsaDTO> lista_risorse = GestioneRisorseBO.getListaRisorse(session);
				ArrayList<UtenteDTO> lista_utenti_all = GestioneUtenteBO.getDipendenti(session);				
				ArrayList<ForPartecipanteDTO> lista_partecipanti_all = GestioneFormazioneBO.getListaPartecipantiCliente(4132, 0, session);
				ArrayList<PRRequisitoDocumentaleDTO> lista_requisiti_documentali = GestioneRisorseBO.getListaRequisitiDocumentali(session);
				ArrayList<PRRequisitoSanitarioDTO> lista_requisiti_sanitari = GestioneRisorseBO.getListaRequisitiSanitari(session);
				
		
				Set<Integer> idUtentiInRisorse = new HashSet<>();
				for (PRRisorsaDTO risorsa : lista_risorse) {
				    if (risorsa.getUtente() != null) {
				        idUtentiInRisorse.add(risorsa.getUtente().getId()); 
				    }
				}

				ArrayList<UtenteDTO> lista_utenti_filtrata = new ArrayList<>();
				for (UtenteDTO u : lista_utenti_all) {
				    if (!idUtentiInRisorse.contains(u.getId())) {
				        lista_utenti_filtrata.add(u);
				    }
				}
				
				Set<Integer> idPartecipantiInRisorse = new HashSet<>();
				for (PRRisorsaDTO risorsa : lista_risorse) {
				    if (risorsa.getPartecipante() != null) {
				        idPartecipantiInRisorse.add(risorsa.getPartecipante().getId());
				    }
				}

				ArrayList<ForPartecipanteDTO> lista_partecipanti_filtrata = new ArrayList<>();
				for (ForPartecipanteDTO partecipante : lista_partecipanti_all) {
				    if (!idPartecipantiInRisorse.contains(partecipante.getId())) {
				        lista_partecipanti_filtrata.add(partecipante);
				    }
				}
				
				request.getSession().setAttribute("lista_risorse", lista_risorse);
				request.getSession().setAttribute("lista_utenti", lista_utenti_filtrata);
				request.getSession().setAttribute("lista_partecipanti", lista_partecipanti_filtrata);
				request.getSession().setAttribute("lista_utenti_all", lista_utenti_all);
				request.getSession().setAttribute("lista_partecipanti_all", lista_partecipanti_all);
				request.getSession().setAttribute("lista_requisiti_documentali", lista_requisiti_documentali);
				request.getSession().setAttribute("lista_requisiti_sanitari", lista_requisiti_sanitari);
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/pr_lista_risorse.jsp");
			     dispatcher.forward(request,response);	
				
			}
			else if(action.equals("nuova_risorsa")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
	
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            	
	            }
		
				String id_utente = ret.get("utente");
				String id_partecipante = ret.get("partecipante");
				String id_req_documentali = ret.get("id_req_documentali");
				String id_req_sanitari = ret.get("id_req_sanitari");
				
				PRRisorsaDTO risorsa = new PRRisorsaDTO();
				UtenteDTO user = (UtenteDTO) session.get(UtenteDTO.class, Integer.parseInt(id_utente));
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) session.get(ForPartecipanteDTO.class, Integer.parseInt(id_partecipante));
				
				risorsa.setUtente(user);
				risorsa.setPartecipante(partecipante);
				
				session.saveOrUpdate(risorsa);
				
				if(id_req_sanitari!=null) {

					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					if(id_req_sanitari!=null && !id_req_sanitari.equals("")) {
						for (int i = 0; i < id_req_sanitari.split(";").length;i++) {
							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
							req_risorsa.setRisorsa(risorsa.getId());
							String[] str_sanitari = id_req_sanitari.split(";")[i].split(",");
							PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(str_sanitari[0]));
							String stato = str_sanitari[1];
							Date data_inizio = df.parse(str_sanitari[2]);
							Date data_fine = df.parse(str_sanitari[3]);
							
							req_risorsa.setReq_sanitario(req_san);
							req_risorsa.setReq_san_data_inizio(data_inizio);
							req_risorsa.setReq_san_data_fine(data_fine);
							req_risorsa.setStato(Integer.parseInt(stato));
							risorsa.getListaRequisiti().add(req_risorsa);
							}
						}
					
					
				}
				
				session.saveOrUpdate(risorsa);
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
				
			}
			else if(action.equals("modifica_risorsa")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
	
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            	
	            }
		
				String id_utente = ret.get("utente_mod");
				String id_partecipante = ret.get("partecipante_mod");
				String id_req_documentali = ret.get("id_req_documentali_mod");
				String id_req_sanitari = ret.get("id_req_sanitari_mod");
				String id_risorsa = ret.get("id_risorsa");
				
				PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id_risorsa));
				UtenteDTO user = (UtenteDTO) session.get(UtenteDTO.class, Integer.parseInt(id_utente));
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) session.get(ForPartecipanteDTO.class, Integer.parseInt(id_partecipante));
				
				risorsa.setUtente(user);
				risorsa.setPartecipante(partecipante);
				
				//session.saveOrUpdate(risorsa);
				
				risorsa.getListaRequisiti().clear();
				
		
				session.update(risorsa);
				
				if(id_req_documentali!= null || id_req_sanitari!=null) {
					
					if(id_req_documentali!=null && !id_req_documentali.equals("")) {
						for (int i = 0; i < id_req_documentali.split(";").length;i++) {
							
							if(!id_req_documentali.split(";")[i].equals("")) {
							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
							req_risorsa.setRisorsa(risorsa.getId());
							PRRequisitoDocumentaleDTO req_doc = (PRRequisitoDocumentaleDTO) session.get(PRRequisitoDocumentaleDTO.class, Integer.parseInt(id_req_documentali.split(";")[i]));
							req_risorsa.setReq_documentale(req_doc);
							//session.save(req_risorsa);
							risorsa.getListaRequisiti().add(req_risorsa);
							}
						}
						
					}
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					if(id_req_sanitari!=null && !id_req_sanitari.equals("")) {
						for (int i = 0; i < id_req_sanitari.split(";").length;i++) {
							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
							req_risorsa.setRisorsa(risorsa.getId());
							String[] str_sanitari = id_req_sanitari.split(";")[i].split(",");
							PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(str_sanitari[0]));
							String stato = str_sanitari[1];
							Date data_inizio = df.parse(str_sanitari[2]);
							Date data_fine = df.parse(str_sanitari[3]);
							
							req_risorsa.setReq_sanitario(req_san);
							req_risorsa.setReq_san_data_inizio(data_inizio);
							req_risorsa.setReq_san_data_fine(data_fine);
							req_risorsa.setStato(Integer.parseInt(stato));
							//session.save(req_risorsa);
							risorsa.getListaRequisiti().add(req_risorsa);
							}
						}
					
					
				}
				session.update(risorsa);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("elimina_risorsa")) {
				
				ajax = true;
				String id_risorsa = request.getParameter("id_risorsa");
				
				PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id_risorsa));
				risorsa.setDisabilitato(1);
				
				session.update(risorsa);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("aggiungi_requisiti")) {
				
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
	
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            	
	            }
		
				String id_intervento = ret.get("id_intervento_req");
				String id_req_documentali = ret.get("id_req_documentali");
				String id_req_sanitari = ret.get("id_req_sanitari");
				
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento, session);
				
				intervento.getListaRequisiti().clear();
				
				
				session.update(intervento);
				
				if(id_req_documentali!= null || id_req_sanitari!=null) {
					
					if(id_req_documentali!=null && !id_req_documentali.equals("")) {
						for (int i = 0; i < id_req_documentali.split(";").length;i++) {
							
							if(!id_req_documentali.split(";")[i].equals("")) {
							
								
							PRRequisitoDocumentaleDTO req_doc = (PRRequisitoDocumentaleDTO) session.get(PRRequisitoDocumentaleDTO.class, Integer.parseInt(id_req_documentali.split(";")[i]));
							
							PRInterventoRequisitoDTO int_req = new PRInterventoRequisitoDTO();
							int_req.setId_intervento(intervento.getId());
							int_req.setRequisito_documentale(req_doc);
							//session.save(int_req);
							intervento.getListaRequisiti().add(int_req);
							}
						}
						
					}
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					if(id_req_sanitari!=null && !id_req_sanitari.equals("")) {
						for (int i = 0; i < id_req_sanitari.split(";").length;i++) {
											
							PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(id_req_sanitari.split(";")[i]));							
							
							PRInterventoRequisitoDTO int_req = new PRInterventoRequisitoDTO();
							int_req.setId_intervento(intervento.getId());
							int_req.setRequisito_sanitario(req_san);
							//session.save(int_req);
							
							intervento.getListaRequisiti().add(int_req);
							}
						}
					
					
				}
				session.update(intervento);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("pianificazione_risorse")) {
				
				String anno = request.getParameter("anno");
				String data_inizio = request.getParameter("data_inizio");
				String move = request.getParameter("move");			
				
									
				if(anno==null) {
					anno = ""+Calendar.getInstance().get(Calendar.YEAR);
				}

				LocalDate dataCorrente = null;
				 
				if(data_inizio == null && Integer.parseInt(anno) == LocalDate.now().getYear()) {
					dataCorrente = LocalDate.now();
				}
				else if(data_inizio == null && Integer.parseInt(anno) != LocalDate.now().getYear()) {
					dataCorrente = LocalDate.ofYearDay(Integer.parseInt(anno), 1);
				}
				else {						
					if(Integer.parseInt(data_inizio) == 366 && !LocalDate.ofYearDay(Integer.parseInt(anno), 1).isLeapYear()) {
						data_inizio = 365+"";
					}
			         dataCorrente = LocalDate.ofYearDay(Integer.parseInt(anno), Integer.parseInt(data_inizio));				       
				}				 							 
						 
				
				int meseCorrente = 0;
				int monthsToAdd = 3;
				
				if(move!=null && move.equals("back")) {
					if(dataCorrente.getMonthValue()==12) {
						meseCorrente = dataCorrente.getMonthValue()-1;
					}else {
						meseCorrente = dataCorrente.getMonthValue()-2;
					}
					
				}else if(move!=null && move.equals("forward")) {
					if(dataCorrente.getMonthValue()+1==12) {
						meseCorrente = dataCorrente.getMonthValue()+1;
						monthsToAdd = 2;
					}
					else if(dataCorrente.getMonthValue()+2==12) {
						meseCorrente = dataCorrente.getMonthValue()+2;
						monthsToAdd = 2;
						
					}
					else if(dataCorrente.getMonthValue()==1) {
						meseCorrente = dataCorrente.getMonthValue();
					}
					else {
						meseCorrente = dataCorrente.getMonthValue()+2;	
					}
									
				}else {
					meseCorrente = dataCorrente.getMonthValue();
				}
				
				
				int mesePrecedente = 0;
				if(meseCorrente>1) {
					mesePrecedente =  meseCorrente - 1;
				}else {
					if(meseCorrente==0) {
						meseCorrente = 12;
						mesePrecedente = 10;
						anno = ""+(Integer.parseInt(anno)-1);
					}else {
						mesePrecedente = meseCorrente;	
					}
					
				}
				
				
				
				LocalDate inizioBimestre = LocalDate.of(Integer.parseInt(anno), mesePrecedente, 1);
				LocalDate fineBimestre = inizioBimestre.plusMonths(monthsToAdd).minusDays(1);

				
		        
		        int start_date = 0; 
		        int end_date = 0; 
		        
				if(inizioBimestre.getYear() == fineBimestre.getYear()) {
					start_date = inizioBimestre.getDayOfYear();
			        end_date = fineBimestre.getDayOfYear();
				}else if(inizioBimestre.getYear() < fineBimestre.getYear()) {
					start_date = inizioBimestre.getDayOfYear();
					 if(LocalDate.ofYearDay(Integer.parseInt(anno), 1).isLeapYear()){
						 end_date = fineBimestre.getDayOfYear() +366;
					 }else {
						 end_date = fineBimestre.getDayOfYear() +365;
					 }
			        
				}
		        

				int daysNumber = end_date - start_date;
				
				
				ArrayList<LocalDate> festivitaItaliane = new ArrayList<>();
			    festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 1, 1));
			    festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 1, 6));

			 // Pasqua - data variabile (calcolata tramite algoritmo)
			   LocalDate pasqua = Utility.calculatePasqua(Integer.parseInt(anno));
			    festivitaItaliane.add(pasqua);
			 // Lunedì di Pasqua
			 festivitaItaliane.add(pasqua.plusDays(1));
			 // Festa della Liberazione - 25 aprile
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 4, 25));
			 // Festa dei Lavoratori - 1 maggio
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 5, 1));
			 // Festa della Repubblica - 2 giugno
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 6, 2));
			 // Ferragosto - 15 agosto
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 8, 15));
			 // Tutti i Santi - 1 novembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 11, 1));
			 // Immacolata Concezione - 8 dicembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 12, 8));
			 // Natale - 25 dicembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 12, 25));
			 // Santo Stefano - 26 dicembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 12, 26));
			
			 
			 long today = 0;
			 
			 if(Integer.parseInt(anno)==Integer.parseInt(LocalDate.now().getYear()+"")) {
				 today = ChronoUnit.DAYS.between(inizioBimestre, dataCorrente);
			 }
			 
			 ArrayList<InterventoDTO> lista_interventi = GestioneInterventoBO.getListainterventiDate(inizioBimestre, fineBimestre, session);
			 
			 ArrayList<PRRisorsaDTO> lista_risorse = GestioneRisorseBO.getListaRisorse(session);

				request.getSession().setAttribute("today", today);
				request.getSession().setAttribute("anno", Integer.parseInt(anno));
				request.getSession().setAttribute("daysNumber", daysNumber);
				request.getSession().setAttribute("festivitaItaliane", festivitaItaliane);
				request.getSession().setAttribute("start_date", start_date);
				request.getSession().setAttribute("end_date", end_date);
				request.getSession().setAttribute("filtro_tipo_pianificazioni", 0);
			
				request.getSession().setAttribute("lista_interventi", lista_interventi);
				request.getSession().setAttribute("lista_risorse", lista_risorse);				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/pr_gestionePianificazioneRisorse.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("associa_intervnto_risorsa")) {
				
				ajax = true;
				
	
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
	
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            	
	            }
		
				String id_intervento = ret.get("id_intervento");
				String id_risorsa = ret.get("id_risorsa");
				String cella = ret.get("cella");
				String data = ret.get("data_pianificazione");
				String calendario = ret.get("calendario");
				String id_intervento_ris = ret.get("id_intervento_ris");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				
				if(data == null || data.equals("")) {
					data = df.format(new Date());
				}
				
				if(id_intervento == null || id_intervento.equals("")) {
					id_intervento = id_intervento_ris; 
				}
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento, session);
				
			
				String [] id_risorsa_multi = id_risorsa.split(",");
				
				int n = id_risorsa_multi.length;
		
				
				if(calendario==null) {
					intervento.getListaRisorse().clear();
				}
				
				session.update(intervento);
				
				  Set<Integer> idRisorseIntervento = new HashSet<>();
				  
				  for (PRInterventoRisorsaDTO r : intervento.getListaRisorse()) {
			            
					  idRisorseIntervento.add(r.getRisorsa().getId());
			           
				  }
			//	ArrayList<PRInterventoRisorsaDTO> lista_risorse_intervento = GestioneRisorseBO.getRisorsaIntervento(intervento.getId(), null, session);
				if(id_risorsa!=null && !id_risorsa.equals("")) {
				for(int i = 0; i<n ; i++) {
					PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id_risorsa_multi[i]));
				
					PRInterventoRisorsaDTO intervento_risorsa = new PRInterventoRisorsaDTO();
					
					intervento_risorsa.setIntervento(intervento.getId());
					intervento_risorsa.setRisorsa(risorsa);
					intervento_risorsa.setData(df.parse(data));
					
					if(cella!=null) {
						intervento_risorsa.setCella(Integer.parseInt(cella));	
					}else {
						
						Calendar calendar = Calendar.getInstance();
				        calendar.setTime(intervento.getDataCreazione());
				        
				        int giornoDellAnno = calendar.get(Calendar.DAY_OF_YEAR);
						intervento_risorsa.setCella(giornoDellAnno);
					}
					if(!idRisorseIntervento.contains(risorsa.getId())) {
						intervento.getListaRisorse().add(intervento_risorsa);
					}
					
				}
				
				session.update(intervento);
				}

				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("lista_requisiti")) {
				
		
				 ArrayList<PRRequisitoDocumentaleDTO> lista_req_documentali = GestioneRisorseBO.getListaRequisitiDocumentali(session);
				 ArrayList<PRRequisitoSanitarioDTO> lista_req_sanitari = GestioneRisorseBO.getListaRequisitiSanitari(session);
				 ArrayList<ForCorsoCatDTO> lista_categorie = GestioneFormazioneBO.getListaCategorieCorsi(session);
				 
				 Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
					request.getSession().setAttribute("lista_req_documentali", lista_req_documentali);
					request.getSession().setAttribute("lista_req_documentali_json", g.toJsonTree(lista_req_documentali));
					request.getSession().setAttribute("lista_req_sanitari", lista_req_sanitari);		
					request.getSession().setAttribute("lista_categorie", lista_categorie);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/pr_lista_requisiti.jsp");
			     dispatcher.forward(request,response);
				
				
			}else if(action.equals("nuovo_requisito")) {
				
				ajax = true;
				
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            }
		
				String descrizione = ret.get("descrizione");
				String id_categorie = ret.get("id_categorie");
				

				if(descrizione!=null)
				{
					PRRequisitoSanitarioDTO req_san = new PRRequisitoSanitarioDTO();
					req_san.setDescrizione(descrizione);
					
					session.save(req_san);
					
				}else {
					
					ArrayList<PRRequisitoDocumentaleDTO> lista_req_doc = GestioneRisorseBO.getListaRequisitiDocumentali(session);
					ArrayList<Integer> lista_id_req_doc = new ArrayList<Integer>();
					ArrayList<Integer> lista_id_req_doc_new = new ArrayList<Integer>();
					
					for (PRRequisitoDocumentaleDTO req : lista_req_doc) {
						lista_id_req_doc.add(req.getCategoria().getId());
					}
					
					String[] ids =id_categorie.split(";");
					
					for (int i = 0; i < ids.length; i++) {
						String string = ids[i];
						
						if(!string.equals("") && !lista_id_req_doc.contains(Integer.parseInt(string))) {
						ForCorsoCatDTO categoria = GestioneFormazioneBO.getCategoriaCorsoFromId(Integer.parseInt(string), session);
						PRRequisitoDocumentaleDTO req_doc =new PRRequisitoDocumentaleDTO();
						req_doc.setCategoria(categoria);
						
						session.save(req_doc);
						
						
						}
						lista_id_req_doc_new.add(Integer.parseInt(string));
						
					}
					
					
					for (int i = 0; i < lista_req_doc.size(); i++) {
						if(!lista_id_req_doc_new.contains(lista_req_doc.get(i).getCategoria().getId())){
							
						
							PRRequisitoDocumentaleDTO r = (PRRequisitoDocumentaleDTO) session.get(PRRequisitoDocumentaleDTO.class, lista_req_doc.get(i).getId());
							r.setDisabilitato(1);
							session.update(r);
						}
						
					}
					
				}
				
			

				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
				
				
			}else if(action.equals("modifica_requisito")) {
				
				ajax = true;
				
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            }
		
				String descrizione = ret.get("descrizione_mod");
				String id_requisito = ret.get("id_requisito");

				if(id_requisito!=null)
				{
					PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(id_requisito));
					req_san.setDescrizione(descrizione);
					
					session.update(req_san);
					
				}

				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
			}
			else if(action.equals("elimina_requisito")) {
				
				ajax = true;
				
				
				response.setContentType("application/json");
		
				String id_requisito = request.getParameter("id_requisito");

				if(id_requisito!=null)
				{
					PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(id_requisito));
					req_san.setDisabilitato(1);
					
					session.update(req_san);
					
				}

				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
			}
			
			session.getTransaction().commit();
	    	session.close();
	}catch(Exception e) {
		e.printStackTrace();
		session.getTransaction().rollback();
    	session.close();
		if(ajax) {
			
			PrintWriter out = response.getWriter();
			
        	
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
