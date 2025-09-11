package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

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
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;

import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="nuovoStrumento" , urlPatterns = { "/nuovoStrumento.do" })

public class NuovoStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(NuovoStrumento.class);
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
		
		boolean ajax = false;
		
		logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
		try{	
			
			if(action==null || action =="") {
				
				ajax = true;
		
			
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
				
				String altre_matricole = request.getParameter("altre_matricole");
				String note_tecniche = request.getParameter("note_tecniche");
				
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
				
				//if(idSede.equals("0")) {
					strumento.setId__sede_(Integer.parseInt(Utility.decryptData(idSede.split("_")[0])));
//				}else {
//					strumento.setId__sede_(Integer.parseInt(idSede.split("_")[0]));
//				}
				
				
				strumento.setId_cliente(Integer.parseInt(Utility.decryptData(idCliente)));
			
				strumento.setReparto(reparto);
				strumento.setUtilizzatore(utilizzatore);
				strumento.setNote(note);
				strumento.setLuogo(new LuogoVerificaDTO(Integer.parseInt(luogo_verifica),""));
				//strumento.setInterpolazione(Integer.parseInt(interpolazione));
				strumento.setCompany((CompanyDTO)request.getSession().getAttribute("usrCompany"));
				strumento.setUserCreation((UtenteDTO)request.getSession().getAttribute("userObj"));
				strumento.setClassificazione(new ClassificazioneDTO(Integer.parseInt(classificazione),""));
				
				strumento.setAltre_matricole(altre_matricole);
			
				if(freq_mesi.length()>0){
					strumento.setFrequenza(Integer.parseInt(freq_mesi));
				}
			//	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

			//	strumento.setDataUltimaVerifica(new java.sql.Date(df.parse(dataUltimaVerifica).getTime()));
			//	if(dataProssimaVerifica.length()>0){
			//		strumento.setDataProssimaVerifica(new java.sql.Date(df.parse(dataProssimaVerifica).getTime()));
			//	}
				strumento.setTipoRapporto(new TipoRapportoDTO(Integer.parseInt(ref_tipo_rapporto),""));
				strumento.setNote_tecniche(note_tecniche);
				
			
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
	
 
		}
		
		else if(action.equals("nuovo_strumento_pacco")) {
	
			ajax = true;
			
			String id_pacco = request.getParameter("id_pacco");
			
			String quantita = request.getParameter("quantita");
			
			String freq_mesi = request.getParameter("freq_mesi");
			String idSede = request.getParameter("idSede");
			String idCliente = request.getParameter("idCliente");
			String classificazione = request.getParameter("classificazione");
			String dataUltimaVerifica = request.getParameter("dataUltimaVerifica");
			String dataProssimaVerifica = request.getParameter("dataProssimaVerifica");
			String ref_tipo_rapporto = request.getParameter("ref_tipo_rapporto");		
			String denominazione = request.getParameter("denominazione");
			String codice_interno = request.getParameter("codice_interno");
			String matricola = request.getParameter("matricola");
			String company = request.getParameter("company");
			
			String altre_matricole = request.getParameter("altre_matricole");
			
			String tipo_strumento = request.getParameter("tipo_strumento");
			String[] tipo_strumento_split = tipo_strumento.split("_");
			int successInt=0;
			
			boolean presente = GestioneMagazzinoBO.checkStrumentoCliente(idCliente, matricola, codice_interno, session);
			
			String message = ""; 
			Boolean success = true;
			
			if(presente) {
				message = "Attenzione! Lo strumento che stai tentando di inserire esiste gi&agrave;!";
				success = false;
				
			}else {
				
			
			
			for(int i=0; i<Integer.parseInt(quantita); i++) {
				successInt=0;
				StrumentoDTO strumento = new StrumentoDTO();
				
				strumento.setTipo_strumento(new TipoStrumentoDTO(Integer.parseInt(tipo_strumento_split[0]), ""));
				if(Integer.parseInt(quantita)==1 && denominazione!=null) {
					strumento.setDenominazione(denominazione);
				}else {
					strumento.setDenominazione("PC_"+id_pacco+"_"+tipo_strumento_split[1]+"_"+(i+1));
				}
				//strumento.setCodice_interno("PC_"+id_pacco+"_"+tipo_strumento_split[1]+"_"+(i+1));
				
				//strumento.setMatricola("PC_"+id_pacco+"_"+tipo_strumento_split[1]+"_"+(i+1));
				
				strumento.setId__sede_(Integer.parseInt(idSede));
				strumento.setId_cliente(Integer.parseInt(idCliente));
				strumento.setClassificazione(new ClassificazioneDTO(Integer.parseInt(classificazione),""));
				strumento.setCompany(new CompanyDTO(Integer.parseInt(company),"","","","","","","",""));
				strumento.setUserCreation((UtenteDTO)request.getSession().getAttribute("userObj"));
				strumento.setStato_strumento(new StatoStrumentoDTO(7226, "In servizio"));
			
				if(freq_mesi.length()>0){
					strumento.setFrequenza(Integer.parseInt(freq_mesi));
				}
			//	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

			//	strumento.setDataUltimaVerifica(new java.sql.Date(df.parse(dataUltimaVerifica).getTime()));
			//	if(dataProssimaVerifica.length()>0){
			//		strumento.setDataProssimaVerifica(new java.sql.Date(df.parse(dataProssimaVerifica).getTime()));
			//	}
				strumento.setTipoRapporto(new TipoRapportoDTO(Integer.parseInt(ref_tipo_rapporto),""));
				
				strumento.setAltre_matricole(altre_matricole);
				
			//	GestioneStrumentoBO.saveStrumento(strumento, session);
				
				if(Integer.parseInt(quantita)==1 && matricola!=null && !matricola.equals("")) {
					strumento.setMatricola(matricola);
				}else {
					strumento.setMatricola("PC_"+id_pacco+"_MTR_"+strumento.get__id());
				}
				if(Integer.parseInt(quantita)==1 && codice_interno!= null && !codice_interno.equals("")) {
					strumento.setCodice_interno(codice_interno);	
				}else {
					strumento.setCodice_interno("PC_"+id_pacco+"_CIN_"+strumento.get__id());
				}
				
				//GestioneStrumentoBO.saveStrumento(strumento, session);
				session.save(strumento);
				successInt =1;
			}
			
			if(successInt>0){
				message = "Salvato con Successo";
			}else{
				message = "Errore Salvataggio";
				success = false;
			}
		}
			
			
			session.getTransaction().commit();
			session.close();	
			 JsonObject myObj = new JsonObject();

				myObj.addProperty("success", success);
				myObj.addProperty("messaggio", message);
		        out.println(myObj.toString());
		        
		        
		}

	}catch(Exception e)
	{
		session.getTransaction().rollback();
    	session.close();
		if(ajax) {
			
			e.printStackTrace();
			 JsonObject myObj = new JsonObject();
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
