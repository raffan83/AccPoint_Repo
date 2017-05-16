package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="gestioneCampione" , urlPatterns = { "/gestiooneCampione.do" })

public class GestioneCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneCampione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		PrintWriter out = response.getWriter();
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");
	try{	
		
		String action=  request.getParameter("action");

		

		if(action !=null)
		{
			CampioneDTO campione = null;
			if(action.equals("modifica")){
				campione = GestioneCampioneDAO.getCampioneFromId( request.getParameter("id"));
			}else if(action.equals("nuovo")){
				campione = new CampioneDTO();
			
			}else{
				JsonObject myObj = new JsonObject();

				myObj.addProperty("success", false);
				myObj.addProperty("message", "Errore, action non riconosciuta");
		        out.println(myObj.toString());
			}
			
			 List<FileItem> items = uploadHandler.parseRequest(request);
	            for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		 
	            	 }
	            	
	            
	            }
		
		  String nome = request.getParameter("nome");
		  String tipoCampione = request.getParameter("tipoCampione");
		  String codice  = request.getParameter("codice");
		  String matricola = request.getParameter("matricola");
		  String descrizione = request.getParameter("descrizione");
		  String costruttore = request.getParameter("costruttore");
		  String modello = request.getParameter("modello");
		  String interpolazione = request.getParameter("interpolazione");
		  String freqTaratura = request.getParameter("freqTaratura");
		  String statoCampione = request.getParameter("statoCampione");
		  String dataVerifica = request.getParameter("dataVerifica");
		  String dataScadenza = request.getParameter("dataScadenza");
		  String tipoVerifica = request.getParameter("tipoVerifica");

		  String numeroCerificato  = request.getParameter("numeroCerificato");
		  String utilizzatore = request.getParameter("utilizzatore"); 
		  String dataInizio  = request.getParameter("dataInizio");
		  String dataFine  = request.getParameter("dataFine"); 

			campione.setNome(nome);
			campione.setTipo_campione(new TipoCampioneDTO(Integer.parseInt(tipoCampione),""));
			campione.setCodice(codice);
			campione.setMatricola(matricola);
			campione.setDescrizione(descrizione);
			campione.setCostruttore(costruttore);
			campione.setModello(modello);
			campione.setInterpolazionePermessa(Integer.parseInt(interpolazione));
			campione.setFreqTaraturaMesi(Integer.parseInt(freqTaratura));
			campione.setStatoCampione(statoCampione);
			
			
			
			DateFormat format = new SimpleDateFormat("dd/mm/yyyy", Locale.ITALIAN);
			
			Date dataVerificaDate = (Date) format.parse(dataVerifica);
			Date dataScadenzaDate = (Date) format.parse(dataScadenza);
			
			Date dataInizioPrenotazioneDate = (Date) format.parse(dataInizio);
			Date dataFinePrenotazioneDate = (Date) format.parse(dataFine);
			
			campione.setDataVerifica(dataVerificaDate);
			campione.setDataScadenza(dataScadenzaDate);
			campione.setTipo_Verifica(tipoVerifica);
			/*
			 * Salvataggio file certificato.....
			 */
			//campione.setFilenameCertificato(certificato);
			campione.setNumeroCertificato(numeroCerificato);
			campione.setUtilizzatore(utilizzatore);
			campione.setDataInizioPrenotazione(dataInizioPrenotazioneDate);
			campione.setDataFinePrenotazione(dataFinePrenotazioneDate);
			
			
			Boolean success = GestioneCampioneDAO.save(campione, action);
				
				String message = "";
				if(success){
					message = "Salvato con Successo";
				}else{
					message = "Errore Salvataggio";
				}
			
			/*
			 * TODO salvataggio su db
			 */
			
				Gson gson = new Gson();
				
				// 2. Java object to JSON, and assign to a String

				
				
			 JsonObject myObj = new JsonObject();

					myObj.addProperty("success", success);
					myObj.addProperty("message", message);
			        out.println(myObj.toString());

		}else{
			JsonObject myObj = new JsonObject();

			myObj.addProperty("success", false);
			myObj.addProperty("message", "Nessuna action riconosciuta");
	        out.println(myObj.toString());
		}
		
	}catch(Exception ex)
	{
		 JsonObject myObj = new JsonObject();

		myObj.addProperty("success", false);
		myObj.addProperty("message", STIException.callException(ex).toString());
        out.println(myObj.toString());
		
//		 ex.printStackTrace();
//	     request.setAttribute("error",STIException.callException(ex));
//		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
//	     dispatcher.forward(request,response);
		
	}  
	
	}
	
	static CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
		CampioneDTO campione =null;
		
		try
		{		
		for (int i = 0; i < listaCampioni.size(); i++) {
			
			if(listaCampioni.get(i).getId()==Integer.parseInt(idC))
			{
				return listaCampioni.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			campione=null;
			throw ex;
		}
		return campione;
	}

}
