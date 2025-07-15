package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ibm.wsdl.util.IOUtils;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LatMasterDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.PRInterventoRequisitoDTO;
import it.portaleSTI.DTO.PRInterventoRisorsaDTO;
import it.portaleSTI.DTO.PRRequisitoDocumentaleDTO;
import it.portaleSTI.DTO.PRRequisitoSanitarioDTO;
import it.portaleSTI.DTO.PRRisorsaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneRisorseBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class GestioneInterventoDati
 */
@WebServlet(name = "gestioneInterventoDati", urlPatterns = { "/gestioneInterventoDati.do" })
public class GestioneInterventoDati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneInterventoDati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;

		String idIntervento=request.getParameter("idIntervento");
		Session session = SessionFacotryDAO.get().openSession(); 
		session.beginTransaction();
		try {
		
		idIntervento = Utility.decryptData(idIntervento);
	
		
		InterventoDTO intervento=GestioneInterventoBO.getIntervento(idIntervento, session);
		
		HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
		

		ArrayList<StrumentoDTO> listaStrumentiPerIntervento =  GestioneStrumentoBO.getListaStrumentiIntervento(intervento, session);

		for(StrumentoDTO strumentoDTO: listaStrumentiPerIntervento) {

			if(statoStrumenti.containsKey(strumentoDTO.getStato_strumento().getNome())) {
				Integer iter = statoStrumenti.get(strumentoDTO.getStato_strumento().getNome());
				iter++;
				statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), iter);
			}else {
				statoStrumenti.put(strumentoDTO.getStato_strumento().getNome(), 1);
			}
			
			if(tipoStrumenti.containsKey(strumentoDTO.getTipo_strumento().getNome())) {
				Integer iter = tipoStrumenti.get(strumentoDTO.getTipo_strumento().getNome());
				iter++;
				tipoStrumenti.put(strumentoDTO.getTipo_strumento().getNome(), iter);
			}else {
				
				tipoStrumenti.put(strumentoDTO.getTipo_strumento().getNome(), 1);
				
			}
		
			if(denominazioneStrumenti.containsKey(strumentoDTO.getDenominazione())) {
				Integer iter = denominazioneStrumenti.get(strumentoDTO.getDenominazione());
				iter++;
				denominazioneStrumenti.put(strumentoDTO.getDenominazione(), iter);
			}else {
				
				denominazioneStrumenti.put(strumentoDTO.getDenominazione(), 1);
				
			}
			if(freqStrumenti.containsKey(""+strumentoDTO.getFrequenza())) {
				Integer iter = freqStrumenti.get(""+strumentoDTO.getFrequenza());
				iter++;
				freqStrumenti.put(""+strumentoDTO.getFrequenza(), iter);
			}else {
				
				freqStrumenti.put(""+strumentoDTO.getFrequenza(), 1);
				
			}
			
			if(repartoStrumenti.containsKey(strumentoDTO.getReparto())) {
				Integer iter = repartoStrumenti.get(strumentoDTO.getReparto());
				iter++;
				repartoStrumenti.put(strumentoDTO.getReparto(), iter);
			}else {
				
				repartoStrumenti.put(strumentoDTO.getReparto(), 1);
				
			}
			if(utilizzatoreStrumenti.containsKey(strumentoDTO.getUtilizzatore())) {
				Integer iter = utilizzatoreStrumenti.get(strumentoDTO.getUtilizzatore());
				iter++;
				utilizzatoreStrumenti.put(strumentoDTO.getUtilizzatore(), iter);
			}else {
				
				utilizzatoreStrumenti.put(strumentoDTO.getUtilizzatore(), 1);
				
			}

		
		}
		
		ArrayList<LatMasterDTO> lista_lat_master = null;
		if(intervento.getStatoIntervento().getId()==1) {
			lista_lat_master = GestioneMisuraBO.getListaLatMaster();
		}
		
		CommessaDTO comm=GestioneCommesseBO.getCommessaById(intervento.getIdCommessa());		
		
		request.getSession().setAttribute("commessa", comm);
		
		Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create(); 
		
		request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
		request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
		request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
		request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
		request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
		request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
		request.getSession().setAttribute("lista_lat_master", lista_lat_master);
		
		
		request.getSession().setAttribute("intervento", intervento);
		request.getSession().setAttribute("listaRequisitiJson", gson.toJsonTree(intervento.getListaRequisiti()));
		
		
		Map<Integer,Integer> map_relazioni = DirectMySqlDAO.getListaRelazioni();
		
		//ArrayList<PRInterventoRisorsaDTO> risorse_intervento = GestioneRisorseBO.getRisorsaIntervento(intervento.getId(), intervento.getDataCreazione(), session);
		
		request.getSession().setAttribute("map_relazioni", gson.toJsonTree(map_relazioni));
		 Map<Integer, ArrayList<ForCorsoDTO>> map_doc = new HashMap();
		 
			ArrayList<PRRisorsaDTO> lista_risorse_all = GestioneRisorseBO.getListaRisorse(session);
		 
		 for (PRRisorsaDTO risorsa : lista_risorse_all) {
			 
				//for (PRInterventoRisorsaDTO r : intervento.getListaRisorse()) {
					ArrayList<ForCorsoDTO>lista_corsi = GestioneFormazioneBO.getListaCorsiInCorsoPartecipante(risorsa.getPartecipante().getId(), session);
					 for (ForCorsoDTO c : lista_corsi) {
		
				        	if(c.getCorso_cat().getId() == 31) {
				        		risorsa.setPreposto(true);
				        	}
				        	Integer id_risorsa = risorsa.getId();
				        	if (!map_doc.containsKey(id_risorsa)) {
				        	    map_doc.put(id_risorsa, new ArrayList<ForCorsoDTO>());
				        	}
				           map_doc.get(risorsa.getId()).add(c);
				        
				        }
				//}
		 }
		
		 Set<Integer> idRequisitiSanitariIntervento = new HashSet<>();
		 
	     for (PRInterventoRequisitoDTO requisito : intervento.getListaRequisiti()) {
	          if (requisito.getRequisito_sanitario() != null) {
	              idRequisitiSanitariIntervento.add(requisito.getRequisito_sanitario().getId());
	            }	        
	        }
		 
		request.getSession().setAttribute("risorse_intervento_json",gson.toJsonTree(intervento.getListaRisorse()));
		
		Properties prop = new Properties();
		String propFileName = "config.properties";

		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

		prop.load(inputStream);
		
		request.getSession().setAttribute("defaultNotaConsegna", prop.getProperty("DEFAULT_NOTE_CONSEGNA"));

		
		ArrayList<PRRequisitoDocumentaleDTO> lista_documentale = GestioneRisorseBO.getListaRequisitiDocumentali(session);
		ArrayList<PRRequisitoSanitarioDTO> lista_sanitari = GestioneRisorseBO.getListaRequisitiSanitari(session);
	
		
		request.getSession().setAttribute("lista_documentale", lista_documentale);		
		request.getSession().setAttribute("lista_sanitari", lista_sanitari);
		request.getSession().setAttribute("lista_risorse_json", gson.toJsonTree(lista_risorse_all));
		request.getSession().setAttribute("lista_req_doc_json", gson.toJsonTree(map_doc));
		request.getSession().setAttribute("idRequisitiSanitariIntervento", idRequisitiSanitariIntervento);
		
		UtenteDTO user =(UtenteDTO)request.getSession().getAttribute("userObj");
		
		String userCliente = "0";
		if(user.checkRuolo("CL")) {
			userCliente = "1";
		}
		request.getSession().setAttribute("userCliente", userCliente);

		session.getTransaction().commit();
		session.close();
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoDati.jsp");
     	dispatcher.forward(request,response);
     	
     	
		} catch (Exception e) {
			session.getTransaction().rollback();
			session.close();
			request.setAttribute("error",STIException.callException(e));
	   		request.getSession().setAttribute("exception", e);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
	   	  e.printStackTrace();
		}
     	
	}

	public static void updateNStrumenti(int id, int numStrMis) throws Exception {
		
		GestioneInterventoDAO.updateNStrumenti(id,numStrMis);
		
	}
		
}
