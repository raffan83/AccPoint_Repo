package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ibm.wsdl.util.IOUtils;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LatMasterDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
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
		
		try {
		
		idIntervento = Utility.decryptData(idIntervento);
		
		
		InterventoDTO intervento=GestioneInterventoBO.getIntervento(idIntervento);
		
		HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
		HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
		

		ArrayList<StrumentoDTO> listaStrumentiPerIntervento =  GestioneStrumentoBO.getListaStrumentiIntervento(intervento);

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
		
		Gson gson = new Gson(); 
		
		request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
		request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
		request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
		request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
		request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
		request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
		request.getSession().setAttribute("lista_lat_master", lista_lat_master);
		
		
		request.getSession().setAttribute("intervento", intervento);
		
		Properties prop = new Properties();
		String propFileName = "config.properties";

		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

		prop.load(inputStream);
		
		request.getSession().setAttribute("defaultNotaConsegna", prop.getProperty("DEFAULT_NOTE_CONSEGNA"));

		
		
		
		UtenteDTO user =(UtenteDTO)request.getSession().getAttribute("userObj");
		
		String userCliente = "0";
		if(user.checkRuolo("CL")) {
			userCliente = "1";
		}
		request.getSession().setAttribute("userCliente", userCliente);
		InputStream is = new FileInputStream("C:\\Users\\antonio.dicivita\\Desktop\\test.xls");
		byte[] byteArray = org.apache.commons.io.IOUtils.toByteArray(is);
		
		request.getSession().setAttribute("byteArray", byteArray);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoDati.jsp");
     	dispatcher.forward(request,response);
     	
     	
		} catch (Exception e) {
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
