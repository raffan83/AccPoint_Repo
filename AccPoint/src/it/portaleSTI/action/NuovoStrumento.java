package it.portaleSTI.action;

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
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
@WebServlet(name="nuovoStrumento" , urlPatterns = { "/nuovoStrumento.do" })

public class NuovoStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NuovoStrumento() {
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
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PrintWriter out = response.getWriter();
		
		String action = request.getParameter("action");
		if(action==null || action =="") {

		try{	
			
				String ref_stato_strumento = request.getParameter("ref_stato_strumento");
				String denominazione = request.getParameter("denominazione");
				String codice_interno = request.getParameter("codice_interno");
				String costruttore = request.getParameter("costruttore");
				String modello = request.getParameter("modello");
				String matricola = request.getParameter("matricola");
				String risoluzione = request.getParameter("risoluzione");
				String campo_misura = request.getParameter("campo_misura");
				String ref_tipo_strumento = request.getParameter("ref_tipo_strumento");
				String freq_mesi = request.getParameter("freq_mesi");
				String idSede = request.getParameter("idSede");
				String idCliente = request.getParameter("idCliente");
				String reparto = request.getParameter("reparto");
				String utilizzatore = request.getParameter("utilizzatore");
				String note = request.getParameter("note");
				String luogo_verifica = request.getParameter("luogo_verifica");
				//String interpolazione = request.getParameter("interpolazione");
				String classificazione = request.getParameter("classificazione");
				String company = request.getParameter("company");
				
				String dataUltimaVerifica = request.getParameter("dataUltimaVerifica");
				String dataProssimaVerifica = request.getParameter("dataProssimaVerifica");
				String ref_tipo_rapporto = request.getParameter("ref_tipo_rapporto");			
				
				StrumentoDTO strumento = new StrumentoDTO();
				strumento.setStato_strumento(new StatoStrumentoDTO(Integer.parseInt(ref_stato_strumento),""));
				strumento.setDenominazione(denominazione);
				strumento.setCodice_interno(codice_interno);
				strumento.setCostruttore(costruttore);
				strumento.setModello(modello);
				strumento.setMatricola(matricola);
				strumento.setRisoluzione(risoluzione);
				strumento.setCampo_misura(campo_misura);
				strumento.setTipo_strumento(new TipoStrumentoDTO(Integer.parseInt(ref_tipo_strumento),""));
				strumento.setId__sede_(Integer.parseInt(idSede));
				strumento.setId_cliente(Integer.parseInt(idCliente));
			
				strumento.setReparto(reparto);
				strumento.setUtilizzatore(utilizzatore);
				strumento.setNote(note);
				strumento.setLuogo(new LuogoVerificaDTO(Integer.parseInt(luogo_verifica),""));
				//strumento.setInterpolazione(Integer.parseInt(interpolazione));
				strumento.setCompany((CompanyDTO)request.getSession().getAttribute("usrCompany"));
				strumento.setUserCreation((UtenteDTO)request.getSession().getAttribute("userObj"));
				strumento.setClassificazione(new ClassificazioneDTO(Integer.parseInt(classificazione),""));
				
				
				ScadenzaDTO scadenza = new ScadenzaDTO();
				if(freq_mesi.length()>0){
					scadenza.setFreq_mesi(Integer.parseInt(freq_mesi));
				}
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

				scadenza.setDataUltimaVerifica(new java.sql.Date(df.parse(dataUltimaVerifica).getTime()));
				if(dataProssimaVerifica.length()>0){
					scadenza.setDataProssimaVerifica(new java.sql.Date(df.parse(dataProssimaVerifica).getTime()));
				}
				scadenza.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(ref_tipo_rapporto),""));
				
				Set<ScadenzaDTO> listaScadenze = new HashSet<ScadenzaDTO>();
				listaScadenze.add(scadenza);
				strumento.setListaScadenzeDTO(listaScadenze);
				/*
				 * Save Hibernate abnd return strumento
				 */
				
				int successInt = GestioneStrumentoBO.saveStrumento(strumento, session);
				
				String message = ""; 
				Boolean success = true;
				if(successInt>0){
					message = "Salvato con Successo";
				}else{
					message = "Errore Salvataggio";
					success = false;
				}
			
			/*
			 * TODO salvataggio su db
			 */
			
				Gson gson = new Gson();
				
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(strumento);
				
				
			 JsonObject myObj = new JsonObject();

					myObj.addProperty("success", success);
					myObj.addProperty("messaggio", message);
					myObj.addProperty("strumento", jsonInString);
			        out.println(myObj.toString());
			        
			        session.getTransaction().commit();
		        	session.close();	
	
		}catch(Exception ex)
		{
		 session.getTransaction().rollback();
     	 session.close();

		 JsonObject myObj = new JsonObject();
		  request.getSession().setAttribute("exception", ex);
		//myObj.addProperty("success", false);
		//myObj.addProperty("messaggio", STIException.callException(ex).toString());
		  myObj = STIException.getException(ex);
        out.println(myObj.toString());
		
		
			}  
		}
		
		else if(action.equals("nuovo_strumento_pacco")) {
		try {	
			
			String id_pacco = request.getParameter("id_pacco");
			
			String quantita = request.getParameter("quantita");
			
			String freq_mesi = request.getParameter("freq_mesi");
			String idSede = request.getParameter("idSede");
			String idCliente = request.getParameter("idCliente");
			String classificazione = request.getParameter("classificazione");
			String dataUltimaVerifica = request.getParameter("dataUltimaVerifica");
			String dataProssimaVerifica = request.getParameter("dataProssimaVerifica");
			String ref_tipo_rapporto = request.getParameter("ref_tipo_rapporto");			
			
			String tipo_strumento = request.getParameter("tipo_strumento");
			String[] tipo_strumento_split = tipo_strumento.split("_");
			int successInt=0;
			for(int i=0; i<Integer.parseInt(quantita); i++) {
				successInt=0;
				StrumentoDTO strumento = new StrumentoDTO();
				
				strumento.setTipo_strumento(new TipoStrumentoDTO(Integer.parseInt(tipo_strumento_split[0]), ""));
				strumento.setDenominazione("PC_"+id_pacco+"_"+tipo_strumento_split[1]+"_"+(i+1));
				//strumento.setCodice_interno("PC_"+id_pacco+"_"+tipo_strumento_split[1]+"_"+(i+1));
				
				//strumento.setMatricola("PC_"+id_pacco+"_"+tipo_strumento_split[1]+"_"+(i+1));
				
				strumento.setId__sede_(Integer.parseInt(idSede));
				strumento.setId_cliente(Integer.parseInt(idCliente));
				strumento.setClassificazione(new ClassificazioneDTO(Integer.parseInt(classificazione),""));
				strumento.setCompany((CompanyDTO)request.getSession().getAttribute("usrCompany"));
				strumento.setUserCreation((UtenteDTO)request.getSession().getAttribute("userObj"));
				strumento.setStato_strumento(new StatoStrumentoDTO(7226, "In servizio"));
				ScadenzaDTO scadenza = new ScadenzaDTO();
				if(freq_mesi.length()>0){
					scadenza.setFreq_mesi(Integer.parseInt(freq_mesi));
				}
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

				scadenza.setDataUltimaVerifica(new java.sql.Date(df.parse(dataUltimaVerifica).getTime()));
				if(dataProssimaVerifica.length()>0){
					scadenza.setDataProssimaVerifica(new java.sql.Date(df.parse(dataProssimaVerifica).getTime()));
				}
				scadenza.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(ref_tipo_rapporto),""));
				
				Set<ScadenzaDTO> listaScadenze = new HashSet<ScadenzaDTO>();
				listaScadenze.add(scadenza);
				strumento.setListaScadenzeDTO(listaScadenze);
				
				
				GestioneStrumentoBO.saveStrumento(strumento, session);
				
				strumento.setMatricola("PC_"+id_pacco+"_MTR_"+strumento.get__id());
				strumento.setCodice_interno("PC_"+id_pacco+"_CIN_"+strumento.get__id());
				GestioneStrumentoBO.update(strumento, session);
				successInt =1;
			}
			
			session.getTransaction().commit();
			String message = ""; 
			Boolean success = true;
			if(successInt>0){
				message = "Salvato con Successo";
			}else{
				message = "Errore Salvataggio";
				success = false;
			}
			
			
			session.close();	
		 JsonObject myObj = new JsonObject();

				myObj.addProperty("success", success);
				myObj.addProperty("messaggio", message);
		        out.println(myObj.toString());
		        
		        
	        	

	}catch(Exception ex)
	{
	 session.getTransaction().rollback();
 	 session.close();
	  request.getSession().setAttribute("exception", ex);
	 JsonObject myObj = new JsonObject();

	//myObj.addProperty("success", false);
	//myObj.addProperty("messaggio", STIException.callException(ex).toString());
	 myObj = STIException.getException(ex);
    out.println(myObj.toString());
	
	
		}  
			
			
			
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
