package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
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
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestionePrenotazioniBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.Hashtable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="gestioneCampione" , urlPatterns = { "/gestioneCampione.do" })
@MultipartConfig
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		PrintWriter out = response.getWriter();
	
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");
	
        try{	
	
		List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

		String action=  request.getParameter("action");

		
		
		if(action !=null )
		{
			
			if(action.equals("controllaCodice"))
			{
				/*
				 * controllare unicit� codice 
				 */
			}
			else
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
			FileItem fileItem = null;
			
	        Hashtable ret = new Hashtable();
	        String filename= null;
	        for (FileItem item : items) {
            	 if (!item.isFormField()) {
            		 String fieldname = item.getFieldName();
            		 filename = FilenameUtils.getName(item.getName());
                     InputStream filecontent = item.getInputStream();
                     /*
                      * TO DO Salvataggio file
                      */
                     fileItem = item;
                     
            	 }else{
                      ret.put(item.getFieldName(), item.getString());
                     
            	 }
            	
            
            }
		        
		        
		        
		        
		        
		  String nome = (String) ret.get("nome");

		  String descrizione = (String) ret.get("descrizione");
		  String costruttore = (String) ret.get("costruttore");
		  String modello = (String) ret.get("modello");
		  String interpolazione = (String) ret.get("interpolazione");
		  String freqTaratura = (String) ret.get("freqTaratura");
		  String statoCampione = (String) ret.get("statoCampione");
		  String dataVerifica = (String) ret.get("dataVerifica");
		  String numeroCerificato  = (String) ret.get("numeroCerificato");
		 
		  
		 
		  String tipoVerifica = (String) ret.get("tipoVerifica");
		  String tipoCampione = (String) ret.get("tipoCampione");
		  String codice  = (String) ret.get("codice");
		  String matricola = (String) ret.get("matricola");
		  String dataScadenza = (String) ret.get("dataScadenza");
		  String utilizzatore = (String) ret.get("utilizzatore"); 
		  String dataInizio  = (String) ret.get("dataInizio");
		  String dataFine  = (String) ret.get("dataFine"); 

		  
		  
		  

			campione.setNome(nome);
 			campione.setDescrizione(descrizione);
			campione.setCostruttore(costruttore);
			campione.setModello(modello);
			campione.setInterpolazionePermessa(Integer.parseInt(interpolazione));
			campione.setFreqTaraturaMesi(Integer.parseInt(freqTaratura));
			campione.setStatoCampione(statoCampione);
			

			
			
			
			DateFormat format = new SimpleDateFormat("dd/mm/yyyy", Locale.ITALIAN);
			
			Date dataVerificaDate = (Date) format.parse(dataVerifica);
 			campione.setDataVerifica(dataVerificaDate);
 			
// 			if(!filename.equals("")){
// 				campione.setFilenameCertificato(filename+"_"+campione.getId()); //decidere come generare il nome del file
// 			}
			campione.setNumeroCertificato(numeroCerificato);

			ArrayList<ValoreCampioneDTO> listaValoriNew = new ArrayList<ValoreCampioneDTO>();

			if(action.equals("nuovo")){
				Date dataScadenzaDate = (Date) format.parse(dataScadenza);			
				Date dataInizioPrenotazioneDate = (Date) format.parse(dataInizio);
				Date dataFinePrenotazioneDate = (Date) format.parse(dataFine);
				campione.setDataScadenza(dataScadenzaDate);
				campione.setTipo_Verifica(tipoVerifica);
				campione.setUtilizzatore(utilizzatore);
				campione.setDataInizioPrenotazione(dataInizioPrenotazioneDate);
				campione.setDataFinePrenotazione(dataFinePrenotazioneDate);
				campione.setTipo_campione(new TipoCampioneDTO(Integer.parseInt(tipoCampione),""));
				campione.setCodice(codice);
				campione.setMatricola(matricola);

				campione.setCompany((CompanyDTO) request.getSession().getAttribute("usrCompany"));
				campione.setCompany_utilizzatore((CompanyDTO) request.getSession().getAttribute("usrCompany"));
			
			
			
			// Gestione valori campione
			
			


			String rowOrder =  (String) ret.get("tblAppendGrid_rowOrder");
			
			String[] list = rowOrder.split(",");

			
			for (int i = 0; i < list.length; i++) {
				
				String valNom =  (String) ret.get("tblAppendGrid_valore_nominale_"+list[i]);
				String valTar =  (String) ret.get("tblAppendGrid_valore_taratura_"+list[i]);
				String valInAs =  (String) ret.get("tblAppendGrid_incertezza_assoluta_"+list[i]);
				String valInRel =  (String) ret.get("tblAppendGrid_incertezza_relativa_"+list[i]);
				String valPT =  (String) ret.get("tblAppendGrid_parametri_taratura_"+list[i]);
				String valUM =  (String) ret.get("tblAppendGrid_unita_misura_"+list[i]);
				String valInterp =  (String) ret.get("tblAppendGrid_interpolato_"+list[i]);
				String valComp =  (String) ret.get("tblAppendGrid_valore_composto_"+list[i]);
				String valDivUM =  (String) ret.get("tblAppendGrid_divisione_UM_"+list[i]);
				String valTipoG =  (String) ret.get("tblAppendGrid_tipo_grandezza_"+list[i]);
	
				
				ValoreCampioneDTO valc = new ValoreCampioneDTO();
				valc.setValore_nominale(Float.parseFloat(valNom));
				valc.setValore_taratura(Float.parseFloat(valTar));
				if(valInAs.length()>0){
					valc.setIncertezza_assoluta(Float.parseFloat(valInAs));
				}
				if(valInRel.length()>0){
					valc.setIncertezza_relativa(Float.parseFloat(valInRel));
				}
				
				UnitaMisuraDTO um = new UnitaMisuraDTO();
				um.setId(Integer.parseInt(valUM));
				
				TipoGrandezzaDTO tipoGrandezzaDTO = new TipoGrandezzaDTO();
				tipoGrandezzaDTO.setId(Integer.parseInt(valTipoG));
				valc.setParametri_taratura(valPT);
				valc.setUnita_misura(um);
				valc.setValore_composto(Integer.parseInt(valComp));
				valc.setInterpolato(Integer.parseInt(valInterp));
				valc.setDivisione_UM(Float.parseFloat(valDivUM));
				valc.setTipo_grandezza(tipoGrandezzaDTO);
				
				valc.setCampione(campione);
				
				listaValoriNew.add(valc);
			}
			}
			
			/*
			 * TODO salvataggio su db
			 */
			
			 JsonObject myObj = new JsonObject();

					myObj.addProperty("success", true);
			        out.println(myObj.toString());

			Boolean success = GestioneCampioneDAO.save(campione, action, listaValoriNew, session);
				
		
			
				String message = "";
				if(success){
					
					
				    
					if(!GestioneCampioneBO.saveCertificatoUpload(fileItem, campione)){
                	 	session.getTransaction().rollback();
 			 			session.close();
                	 	myObj.addProperty("success", false);
                	 	myObj.addProperty("message", "Nessuna action riconosciuta");
                	 	out.println(myObj.toString());
                 }else{

                	session.getTransaction().commit();
         	 		session.close();
                 }
				        
					
					
					
					message = "Salvato con Successo";
				}else{
					session.getTransaction().rollback();
			 		session.close();
					message = "Errore Salvataggio";
				}
			
			/*
			 * TODO salvataggio su db
			 */
			
				Gson gson = new Gson();
				
				// 2. Java object to JSON, and assign to a String

				
				

					myObj.addProperty("success", success);
					myObj.addProperty("message", message);
			        out.println(myObj.toString());
			}
		}else{
			session.getTransaction().rollback();
	 			session.close();
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
