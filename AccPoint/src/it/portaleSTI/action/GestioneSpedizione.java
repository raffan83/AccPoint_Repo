package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.CorriereDTO;
import it.portaleSTI.DTO.SpedizioneDTO;
import it.portaleSTI.DTO.StatoSpedizioneDTO;
import it.portaleSTI.DTO.MagAllegatoItemDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateDDT;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneSpedizioneBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;



/**
 * Servlet implementation class GestioneDDT
 */
@WebServlet("/gestioneSpedizione.do")
public class GestioneSpedizione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(GestioneSpedizione.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneSpedizione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
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
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		
	try {
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());

			if(action.equals("recupero_dati_spedizione")) {
				
				 ajax = true;
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");

				
				String id_pacco= request.getParameter("id_pacco");
				id_pacco = "PC_" + id_pacco;
				String id_ddt = request.getParameter("id_ddt");
				String destinazione = request.getParameter("destinazione");
				
				String indirizzoCompleto = request.getParameter("indirizzo");
				String[] arrayIndirizzo = indirizzoCompleto.split("-");

				String indirizzo = arrayIndirizzo[0].trim();   // "VIA FERMI ENRICO, 40"
				String cap = "";
				String citta = "";
				String provincia ="";
				//String cap = arrayIndirizzo[1].trim();         // "03100"
				//String cittaProv = arrayIndirizzo[2].trim();   // "FROSINONE (FR)"
				//String citta = cittaProv.substring(0, cittaProv.indexOf('(')).trim();    
				//String provincia = cittaProv.substring(cittaProv.indexOf('(') + 1, cittaProv.indexOf(')')); // "FR"
				
				
				MagDdtDTO ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
				ClienteDTO cliente = null;
				
				if(ddt.getId_destinazione()!= null && ddt.getId_destinazione() !=0) {
				 cliente = GestioneAnagraficaRemotaBO.getClienteById(""+ddt.getId_destinazione());
								
				}
				ArrayList<CorriereDTO> lista_corrieri = (ArrayList<CorriereDTO>) GestioneSpedizioneBO.getListaCorrieri(session);
				request.setAttribute("lista_corrieri", lista_corrieri);
				
				
				request.getSession().setAttribute("id_pacco",id_pacco);
				request.getSession().setAttribute("ddt",ddt);
				request.getSession().setAttribute("cliente",cliente);
				
				JsonObject spedizione = new JsonObject();
				
				spedizione.addProperty("id_pacco", id_pacco);			
				spedizione.addProperty("corriere", ddt.getSpedizioniere());
				spedizione.addProperty("data_spedizione",
					        new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date()));				 
				spedizione.addProperty("nazione", "IT");
				 
						
				 
				if (cliente != null) {
					if(destinazione==null) {
						destinazione = cliente.getNome();
					} if(indirizzo==null) {
						indirizzo =cliente.getIndirizzo();
					}
					cap = cliente.getCap();
					citta = cliente.getCitta();
					provincia = cliente.getProvincia();
					
					spedizione.addProperty("telefono", cliente.getTelefono());
				   
				} 
				
					spedizione.addProperty("destinatario", destinazione);
					spedizione.addProperty("indirizzo",indirizzo);
					spedizione.addProperty("cap",cap);
					spedizione.addProperty("citta",citta);
					spedizione.addProperty("provincia", provincia);
				

				JsonObject risultato = new JsonObject();
				risultato.addProperty("success", true);
				risultato.add("spedizione", spedizione);

				response.getWriter().print(risultato.toString());
				
			}
			else if(action.equals("invio_spedizione")) {
				
		   ajax = true;
		  response.setContentType("application/json");
		  response.setCharacterEncoding("UTF-8");

			SpedizioneDTO spedizione = new SpedizioneDTO();

			spedizione.setId_pacco(request.getParameter("id_pacco"));
			spedizione.setDestinatario(request.getParameter("destinatario"));
			spedizione.setPresso(request.getParameter("presso"));
			spedizione.setCorriere(request.getParameter("corriere"));
			spedizione.setReferente(request.getParameter("referente"));
			spedizione.setTelefono(request.getParameter("telefono"));
			spedizione.setIndirizzo(request.getParameter("indirizzo"));
			spedizione.setCap(request.getParameter("cap"));
			spedizione.setCitta(request.getParameter("citta"));
			spedizione.setProvincia(request.getParameter("provincia"));
			spedizione.setNazione(request.getParameter("nazione"));
			spedizione.setNote(request.getParameter("note"));
			    String dataSpedizione = request.getParameter("data_spedizione");
			    spedizione.setData_spedizione(
			            dataSpedizione == null || dataSpedizione.trim().isEmpty()
			                    ? null
			                    : java.sql.Date.valueOf(dataSpedizione.trim())
			    );
			    spedizione.setCodice_tracking(request.getParameter("codice_tracking"));
		
	
			    Path caPem = Paths.get(
			            System.getProperty("user.home"),
			            "Desktop", "demo", "certs", "sti-erp-api-ca.crt"
			    );
			   String risp = GestioneSpedizioneBO.send(spedizione, Costanti.URL_STI_ETICHETTA, Costanti.TOKEN_API_ETICHETTA, caPem, "invio");
			   
			   JsonObject risposta = new JsonParser().parse(risp).getAsJsonObject();
			   JsonElement campoOk = risposta.get("ok");

			   Boolean ok = campoOk == null || campoOk.isJsonNull()
			           ? null
			           : campoOk.getAsBoolean();
			   
			   if(ok == true) {
				   JsonObject risultato = new JsonObject();
				   try {

						String id_ddt = request.getParameter("id_ddt");
						MagDdtDTO ddt = GestioneMagazzinoBO.getDDT(id_ddt, session);
						spedizione.setDdt(ddt);
					 spedizione.setStato(new StatoSpedizioneDTO(1));
					   GestioneSpedizioneBO.saveSpedizione(spedizione, session);
					   session.getTransaction().commit();
	   
					   risultato.addProperty("success", true);
					   risultato.addProperty("messaggio", "Spedizione inviata e salvata con successo.");
				} catch (Exception e) {
					  risultato.addProperty("success", false);
					   risultato.addProperty("messaggio", "Attenzione! Spedizione inviata ma non salvata. Controllare il gestionale Consegne");
				}
				   response.getWriter().print(risultato.toString());
			   } else {
				   throw new IOException("STI Etichette non ha confermato l'invio del pacco "
				            + spedizione.getId_pacco());
			   }
			   
			
	
		} else if(action.equals("salva_modifica")) {
			
			 ajax = true;
			  response.setContentType("application/json");
			  response.setCharacterEncoding("UTF-8");
			  
			  int idSpedizione = Integer.parseInt(request.getParameter("id"));

			  
			    String destinatario = request.getParameter("destinatario");
			    String presso = request.getParameter("presso");
			    String referente = request.getParameter("referente");
			    String indirizzo = request.getParameter("indirizzo");
			    String cap = request.getParameter("cap");
			    String citta = request.getParameter("citta");
			    String provincia = request.getParameter("provincia");
			    String nazione = request.getParameter("nazione");
			    String corriere = request.getParameter("corriere");
			    String telefono = request.getParameter("telefono");
			    String codiceTracking = request.getParameter("codice_tracking");
			    String note = request.getParameter("note");

			    String dataSpedizioneParam = request.getParameter("data_spedizione");
			    java.sql.Date dataSpedizione =
			            dataSpedizioneParam == null || dataSpedizioneParam.trim().isEmpty()
			                    ? null
			                    : java.sql.Date.valueOf(dataSpedizioneParam.trim());
			    SpedizioneDTO spedizione =
			            GestioneSpedizioneBO.getSpedizioneById(idSpedizione, session);

			    JsonObject risultato = new JsonObject();

			    if (spedizione == null) {
			        risultato.addProperty("success", false);
			        risultato.addProperty("messaggio", "Spedizione non trovata.");
			    } else {
			    	 spedizione.setDestinatario(destinatario);
			    	    spedizione.setPresso(presso);
			    	    spedizione.setReferente(referente);
			    	    spedizione.setIndirizzo(indirizzo);
			    	    spedizione.setCap(cap);
			    	    spedizione.setCitta(citta);
			    	    spedizione.setProvincia(provincia);
			    	    spedizione.setNazione(nazione);
			    	    spedizione.setCorriere(corriere);
			    	    spedizione.setTelefono(telefono);
			    	    spedizione.setData_spedizione(dataSpedizione);
			    	    spedizione.setCodice_tracking(codiceTracking);
			    	    spedizione.setNote(note);
			    	    
			    GestioneSpedizioneBO.updateSpedizone(spedizione, session);
			    session.getTransaction().commit();

			    risultato.addProperty("success", true);
			    risultato.addProperty("messaggio", "Spedizione modificata con successo.");
			}
			    response.getWriter().print(risultato.toString());
			
		} else if(action.equals("aggiorna_stato_spedizione")) {
			
			 ajax = true;
			  response.setContentType("application/json");
			  response.setCharacterEncoding("UTF-8");
			  int idSpedizione = Integer.parseInt(request.getParameter("id_spedizione"));
			  
			  Path caPem = Paths.get(
			            System.getProperty("user.home"),
			            "Desktop", "demo", "certs", "sti-erp-api-ca.crt"
			    );
			  
			  SpedizioneDTO spedizione = GestioneSpedizioneBO.getSpedizioneById(idSpedizione, session);
			  
			   String risp = GestioneSpedizioneBO.send(spedizione, Costanti.URL_STI_ETICHETTA, Costanti.TOKEN_API_ETICHETTA, caPem, "stato_spedizione");
			   
			   JsonObject risposta = new JsonParser().parse(risp).getAsJsonObject();
			   JsonElement campoStato = risposta.get("stato");

			   String stato = campoStato != null && !campoStato.isJsonNull()
			           ? campoStato.getAsString()
			           : null;
			           
			           Integer idNuovoStato = null;

			           if ("consegnato".equals(stato)) {
			               idNuovoStato = 4;
			           } else if ("in_corso".equals(stato)) {
			               idNuovoStato = 1;
			           }

			           JsonObject risultato = new JsonObject();
			          
			           if (idNuovoStato == null) {
			               risultato.addProperty("success", false);
			               risultato.addProperty("messaggio", "Stato spedizione non riconosciuto: " + stato);
			           } else {
			               StatoSpedizioneDTO statoAttuale = spedizione.getStato();
			               boolean cambiato = statoAttuale == null
			                       || !idNuovoStato.equals(statoAttuale.getId());

			               if (cambiato) {
			                   StatoSpedizioneDTO nuovoStato = (StatoSpedizioneDTO)
			                           session.get(StatoSpedizioneDTO.class, idNuovoStato);

			                   if (nuovoStato == null) {
			                       throw new IllegalStateException("Stato spedizione non trovato: " + idNuovoStato);
			                   }

			                   spedizione.setStato(nuovoStato);
			                   GestioneSpedizioneBO.updateSpedizone(spedizione, session);
			               }

			               risultato.addProperty("success", true);
			               risultato.addProperty("stato", stato);
			               risultato.addProperty("messaggio", cambiato
			                       ? "Stato spedizione aggiornato."
			                       : "Lo stato della spedizione è già aggiornato.");
			           }

			           session.getTransaction().commit();
			           response.getWriter().print(risultato.toString());
			
		}
	} catch (Exception e) {
	    logger.error("Errore in gestioneSpedizione.do, action=" + action, e);
	    request.getSession().setAttribute("exception", e);
	    try {
	        if (session != null && session.getTransaction().isActive()) {
	            session.getTransaction().rollback();
	        }
	    } catch (RuntimeException erroreRollback) {
	        logger.error("Errore durante il rollback", erroreRollback);
	    }

	    if (!response.isCommitted()) {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        String messaggio = e.getMessage();

	        if (messaggio == null || messaggio.trim().isEmpty()) {
	            messaggio = "Errore durante la gestione della Spedizione.";
	        }

	        JsonObject risultato = new JsonObject();
	        risultato.addProperty("success", false);
	        risultato.addProperty("messaggio", messaggio);


	        response.getWriter().print(risultato.toString());
	    }
	} finally {
	    session.close();
	}
	}



}
