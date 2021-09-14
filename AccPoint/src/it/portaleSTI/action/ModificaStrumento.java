package it.portaleSTI.action;

import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.StrumentoNoteDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="modificaStrumento" , urlPatterns = { "/modificaStrumento.do" })
public class ModificaStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ModificaStrumento.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ModificaStrumento() {
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
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		boolean ajax = false;
		try
		{


			String action = request.getParameter("action");


			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
			if(action.equals("modifica")) {
				String idS = request.getParameter("id");


				//ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>)request.getSession().getAttribute("listaStrumenti");


				StrumentoDTO dettaglio = GestioneStrumentoBO.getStrumentoById(idS, session);

				ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)request.getSession().getAttribute("listaTipoRapporto");
				if(listaTipoRapporto==null) {
					listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto(session);
				}

				ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)request.getSession().getAttribute("listaTipoStrumento");				
				if(listaTipoStrumento==null) {
					listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
				}

				ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)request.getSession().getAttribute("listaStatoStrumento");
				if(listaStatoStrumento==null) {
					listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento(session);
				}

				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)request.getSession().getAttribute("listaLuogoVerifica");
				if(listaLuogoVerifica==null) {
					listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
				}

				ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)request.getSession().getAttribute("listaClassificazione");
				if(listaClassificazione==null) {
					listaClassificazione = GestioneTLDAO.getListaClassificazione(session);
				}


				PrintWriter out = response.getWriter();

				Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create(); 
				JsonObject myObj = new JsonObject();

				JsonElement obj = gson.toJsonTree(dettaglio);


				myObj.addProperty("success", true);

				myObj.add("dataInfo", obj);
				//	        out.println(myObj.toString());
				//	        System.out.println(myObj.toString());
				//	        out.close();

				request.getSession().setAttribute("myObj",myObj);
				request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
				request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
				request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
				request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
				request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
				request.getSession().setAttribute("listaClassificazione",listaClassificazione);

				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/modificaStrumento.jsp");
				dispatcher.forward(request,response);
			}
			if(action.equals("salva")) {
				UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
				String idS = request.getParameter("id");
				StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(idS, session);



				String denominazione=request.getParameter("denominazione");
				String codice_interno=request.getParameter("codice_interno");
				String costruttore=request.getParameter("costruttore");
				String modello=request.getParameter("modello");
				String matricola=request.getParameter("matricola");
				String risoluzione=request.getParameter("risoluzione");
				String campo_misura=request.getParameter("campo_misura");
				String ref_tipo_strumento=request.getParameter("ref_tipo_strumento");
				String reparto=request.getParameter("reparto");
				String utilizzatore=request.getParameter("utilizzatore");
				String note=request.getParameter("note");
				String luogo_verifica=request.getParameter("luogo_verifica");
				//String interpolazione=request.getParameter("interpolazione");
				String classificazione=request.getParameter("classificazione");
				String procedura = request.getParameter("procedura");

				String altre_matricole = request.getParameter("altre_matricole");

				String stringaModifica=("Modifica attributi strumento|");

				if(!strumento.getDenominazione().equals(denominazione))
				{
					if(strumento.getDenominazione().equals("")) {
						stringaModifica=stringaModifica+"Denominazione([VUOTO],"+denominazione+")|";
					}else {
						if(denominazione.equals("")) {
							denominazione = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Denominazione("+strumento.getDenominazione()+","+denominazione+")|";	
					}
					
				}

				if(!strumento.getCodice_interno().equals(codice_interno))
				{
					if(strumento.getCodice_interno().equals("")) {
						stringaModifica=stringaModifica+"Codice Interno([VUOTO],"+codice_interno+")|";
					}else {
						if(codice_interno.equals("")) {
							codice_interno = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Codice Interno("+strumento.getCodice_interno()+","+codice_interno+")|";
					}
				}

				if(!strumento.getCostruttore().equals(costruttore))
				{
					if(strumento.getCostruttore().equals("")) {
						stringaModifica=stringaModifica+"Costruttore([VUOTO],"+costruttore+")|";
					}else {				
						if(costruttore.equals("")) {
							costruttore = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Costruttore("+strumento.getCostruttore()+","+costruttore+")|";
					}
				}

				if(!strumento.getModello().equals(modello))
				{
					
					if(strumento.getModello().equals("")) {
						stringaModifica=stringaModifica+"Modello([VUOTO],"+modello+")|";
					}else {
						if(modello.equals("")) {
							modello = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Modello("+strumento.getModello()+","+modello+")|";
					}
				}

				if(!strumento.getMatricola().equals(matricola))
				{
					if(strumento.getMatricola().equals("")) {
						stringaModifica=stringaModifica+"Matricola([VUOTO],"+matricola+")|";
					}else {
						if(matricola.equals("")) {
							matricola = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Matricola("+strumento.getMatricola()+","+matricola+")|";
					}
				}

				if(!strumento.getRisoluzione().equals(risoluzione))
				{
					if(strumento.getRisoluzione().equals("")) {
						stringaModifica=stringaModifica+"Risoluzione([VUOTO],"+risoluzione+")|";
					}else {
						if(risoluzione.equals("")) {
							risoluzione = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Risoluzione("+strumento.getRisoluzione()+","+risoluzione+")|";
					}
				}

				if(!strumento.getCampo_misura().equals(campo_misura))
				{
					if(strumento.getCampo_misura().equals("")) {
						stringaModifica=stringaModifica+"Campo Misura([VUOTO],"+campo_misura+")|";
					}else {
						if(campo_misura.equals("")) {
							campo_misura = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Campo Misura("+strumento.getCampo_misura()+","+campo_misura+")|";
					}
				}

				if(!strumento.getUtilizzatore().equals(utilizzatore))
				{
					if(strumento.getUtilizzatore().equals("")) {
						stringaModifica=stringaModifica+"Utilizzatore([VUOTO],"+utilizzatore+")|";
					}else {
						if(utilizzatore.equals("")) {
							utilizzatore = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Utilizzatore("+strumento.getUtilizzatore()+","+utilizzatore+")|";
					}
				}

				if(!strumento.getReparto().equals(reparto))
				{
					if(strumento.getReparto().equals("")) {
						stringaModifica=stringaModifica+"Reparto([VUOTO],"+reparto+")|";
					}else {
						if(reparto.equals("")) {
							reparto = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Reparto("+strumento.getReparto()+","+reparto+")|";
					}
				}

				if(!strumento.getNote().equals(note))
				{
					if(strumento.getNote().equals("")) {
						stringaModifica=stringaModifica+"Note([VUOTO],"+note+")|";
					}else {
						if(note.equals("")) {
							note = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Note("+strumento.getNote()+","+note+")|";
					}
				}

				if(!strumento.getProcedura().equals(procedura))
				{
					if(strumento.getDenominazione().equals("")) {
						stringaModifica=stringaModifica+"Procedure([VUOTO],"+procedura+")|";
					}else {
						if(procedura.equals("")) {
							procedura = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Procedure("+strumento.getProcedura()+","+procedura+")|";
					}
				}

				if(!strumento.getAltre_matricole().equals(altre_matricole))
				{
					if(strumento.getDenominazione().equals("")) {
						stringaModifica=stringaModifica+"Altre Matricole([VUOTO],"+altre_matricole+")|";
					}else {
						if(altre_matricole.equals("")) {
							altre_matricole = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Altre Matricole("+strumento.getAltre_matricole()+","+altre_matricole+")|";
					}
				}


				ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)request.getSession().getAttribute("listaTipoStrumento");				
				if(listaTipoStrumento==null) {
					listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento(session);
				}

				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)request.getSession().getAttribute("listaLuogoVerifica");
				if(listaLuogoVerifica==null) {
					listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica(session);
				}

				ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)request.getSession().getAttribute("listaClassificazione");
				if(listaClassificazione==null) {
					listaClassificazione = GestioneTLDAO.getListaClassificazione(session);
				}


				if(strumento.getTipo_strumento().getId()!=(Integer.parseInt(ref_tipo_strumento)))
				{
					stringaModifica=stringaModifica+"Tipo Strumento("+strumento.getTipo_strumento().getNome()+","+getTipoStrumento(listaTipoStrumento,ref_tipo_strumento)+")|";
				}

				if(strumento.getClassificazione().getId()!=(Integer.parseInt(classificazione)))
				{
					stringaModifica=stringaModifica+"Classificazione("+strumento.getClassificazione().getDescrizione()+","+getClassificazione(listaClassificazione,classificazione)+")|";
				}

				if(strumento.getLuogo().getId()!=(Integer.parseInt(luogo_verifica)))
				{
					stringaModifica=stringaModifica+"Luogo("+strumento.getLuogo().getDescrizione()+","+getLuogoVerifica(listaLuogoVerifica,luogo_verifica)+")";
				}
				strumento.setDenominazione(denominazione);
				strumento.setCodice_interno(codice_interno);
				strumento.setCostruttore(costruttore);
				strumento.setModello(modello);
				strumento.setMatricola(matricola);
				strumento.setRisoluzione(risoluzione);
				strumento.setCampo_misura(campo_misura);
				strumento.setReparto(reparto);
				strumento.setUtilizzatore(utilizzatore);
				strumento.setNote(note);
				strumento.setProcedura(procedura);
				//strumento.setInterpolazione(Integer.parseInt(interpolazione));
				strumento.setAltre_matricole(altre_matricole);

				strumento.setTipo_strumento(new TipoStrumentoDTO(Integer.parseInt(ref_tipo_strumento),""));		
				strumento.setClassificazione(new ClassificazioneDTO(Integer.parseInt(classificazione),""));
				strumento.setLuogo(new LuogoVerificaDTO(Integer.parseInt(luogo_verifica),""));

				strumento.setUserModifica(utente);
				strumento.setDataModifica(new Date(System.currentTimeMillis()));
				
				StrumentoNoteDTO noteStrumento= new StrumentoNoteDTO();

				noteStrumento.setId_strumento(strumento.get__id());
				noteStrumento.setUser(utente);
				noteStrumento.setDescrizione(stringaModifica);

				noteStrumento.setData(new Date(System.currentTimeMillis()));

				String message = "Salvato con Successo";
				Boolean success = true;

				if(!GestioneStrumentoBO.update(strumento, session)) {
					session.getTransaction().rollback();
					session.close();	
					message = "Errore Salvataggio";
					success = false;
				}

				if(!GestioneStrumentoBO.saveNote(noteStrumento, session)) {
					session.getTransaction().rollback();
					session.close();	
					message = "Errore Salvataggio";
					success = false;
				}
				GestioneMagazzinoBO.updateStrumento(strumento, session);
				Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();

				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(strumento);


				JsonObject myObj = new JsonObject();

				myObj.addProperty("success", success);
				myObj.addProperty("messaggio", message);
				myObj.addProperty("strumento", jsonInString);

				PrintWriter out = response.getWriter();

				out.println(myObj.toString());

			}
			else if(action.equals("nuova_nota_strumento")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }

				String nuova_nota = ret.get("nuova_nota");
				
				StrumentoDTO strumento = (StrumentoDTO) request.getSession().getAttribute("strumento");		
				
				UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
				
				StrumentoNoteDTO nota = new StrumentoNoteDTO();
				nota.setDescrizione(nuova_nota);
				nota.setUser(utente);
				nota.setData(new java.util.Date());
				nota.setId_strumento(strumento.get__id());
				session.save(nota);
				
				JsonObject myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Nota salvata con successo!");
				out.print(myObj);
				
			}
			session.getTransaction().commit();
			session.close();


		}catch(Exception ex)
		{

			session.getTransaction().rollback();
			session.close();

			ex.printStackTrace();
			request.setAttribute("error",STIException.callException(ex));
			request.getSession().setAttribute("exception", ex);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			dispatcher.forward(request,response);	
		}  
	}



	private String getLuogoVerifica(ArrayList<LuogoVerificaDTO> listaLuogoVerifica, String luogo_verifica) {
		
		for (LuogoVerificaDTO luogoVerificaDTO : listaLuogoVerifica) {
			
			if(luogoVerificaDTO.getId()==Integer.parseInt(luogo_verifica)) 
			{
				return luogoVerificaDTO.getDescrizione();
			}
		}
		return "";
	}

	private String getClassificazione(ArrayList<ClassificazioneDTO> listaClassificazione, String classificazione) {

		for (ClassificazioneDTO classificazioneDTO : listaClassificazione) {
			if(classificazioneDTO.getId()==Integer.parseInt(classificazione)) 
			{
			 return	classificazioneDTO.getDescrizione();
			}
		}
		return "";
	}

	private String getTipoStrumento(ArrayList<TipoStrumentoDTO> listaTipoStrumento, String ref_tipo_strumento) {

		for (TipoStrumentoDTO tipoStrumentoDTO : listaTipoStrumento) {

			if(tipoStrumentoDTO.getId()==Integer.parseInt(ref_tipo_strumento)) 
			{
				return tipoStrumentoDTO.getNome();
			}

		}
		return "";
	}

	private StrumentoDTO getDettaglio(ArrayList<StrumentoDTO> listaStrumenti,String idS) {
		StrumentoDTO strumento =null;

		try
		{



			for (int i = 0; i < listaStrumenti.size(); i++) {

				if(listaStrumenti.get(i).get__id()==Integer.parseInt(idS))
				{
					return listaStrumenti.get(i);
				}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			strumento=null;

		}
		return strumento;
	}

}
