package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
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
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaApparecchiaturaCampioni;
import it.portaleSTI.bo.CreateSchedaManutenzioniCampione;
import it.portaleSTI.bo.CreateSchedaTaraturaVerificaIntermedia;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneAttivitaCampioni
 */
@WebServlet("/gestioneAttivitaCampioni.do")
public class GestioneAttivitaCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAttivitaCampioni() {
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
			
			if(action.equals("lista")) {
				String idC = request.getParameter("idCamp");
				
				ArrayList<AcAttivitaCampioneDTO> lista_attivita = GestioneAttivitaCampioneBO.getListaAttivita(Integer.parseInt(idC), session);
				ArrayList<AcTipoAttivitaCampioniDTO> lista_tipo_attivita = GestioneAttivitaCampioneBO.getListaTipoAttivitaCampione(session);
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);
				ArrayList<UtenteDTO> lista_utenti_company = GestioneUtenteBO.getUtentiFromCompany(campione.getCompany().getId(), session);
				ArrayList<UtenteDTO> lista_utenti = new ArrayList<UtenteDTO>();
				for (UtenteDTO user : lista_utenti_company) {
					if(user.checkRuolo("OP") || user.checkRuolo("AM") || user.checkRuolo("RS")) {
						lista_utenti.add(user);
					}
				}
				request.getSession().setAttribute("lista_attivita", lista_attivita);
				request.getSession().setAttribute("lista_tipo_attivita_campioni", lista_tipo_attivita);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAttivitaCampione.jsp");
				dispatcher.forward(request,response);
			}
			else if(action.equals("nuova")) {
				
				 response.setContentType("application/json");
				 
				  	List<FileItem> items = null;
			        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

			        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			        	}			        
					FileItem fileItem = null;
			        Hashtable<String,String> ret = new Hashtable<String,String>();			      
			        for (FileItem item : items) {
		            	 if (!item.isFormField()) {
		                     fileItem = item;
		            	 }else
		            	 {
		                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
		            	 }		            	
		            }
				
				String idC = request.getParameter("idCamp");				
				String tipo_attivita = ret.get("select_tipo_attivita");
				String data_attivita = ret.get("data_attivita");
				String descrizione = ret.get("descrizione");
				String tipo_manutenzione = ret.get("select_tipo_manutenzione");
				String id_certificato = ret.get("id_certificato");
				
				String ente = ret.get("ente");
				String data_scadenza = ret.get("data_scadenza");
				String etichettatura = ret.get("etichettatura");
				String stato = ret.get("stato");
				String campo_sospesi = ret.get("campo_sospesi");
				String operatore = ret.get("operatore");				
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);				
				
				AcAttivitaCampioneDTO attivita = new AcAttivitaCampioneDTO();
				attivita.setCampione(campione);
				attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(Integer.parseInt(tipo_attivita),""));
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date date = format.parse(data_attivita);
				attivita.setData(date);				
				attivita.setDescrizione_attivita(descrizione);
				if(operatore!=null && !operatore.equals("")) {
					UtenteDTO user = GestioneUtenteBO.getUtenteById(operatore, session);
					attivita.setOperatore(user);
				}
				if(tipo_manutenzione!=null && !tipo_manutenzione.equals("")) {
					attivita.setTipo_manutenzione(Integer.parseInt(tipo_manutenzione));	
				}
				if(Integer.parseInt(tipo_attivita)==2 || Integer.parseInt(tipo_attivita)==3) {
					attivita.setEnte(ente);					
					attivita.setData_scadenza(format.parse(data_scadenza));
					attivita.setEtichettatura(etichettatura);
					attivita.setStato(stato);
					attivita.setCampo_sospesi(campo_sospesi);
					if(id_certificato!=null && !id_certificato.equals("")) {
						CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(id_certificato);
						attivita.setCertificato(certificato);
					}
				}				
				
				session.save(attivita);
				session.getTransaction().commit();
				session.close();
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attività salvata con successo!");
				out.print(myObj);
			}

			
			else if(action.equals("modifica")) {
				
				 response.setContentType("application/json");
				 
				  	List<FileItem> items = null;
			        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

			        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			        	}			        
					FileItem fileItem = null;
			        Hashtable<String,String> ret = new Hashtable<String,String>();			      
			        for (FileItem item : items) {
		            	 if (!item.isFormField()) {
		                     fileItem = item;
		            	 }else
		            	 {
		                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
		            	 }		            	
		            }
			
			    String id_attivita = ret.get("id_attivita");
				String tipo_attivita = ret.get("select_tipo_attivita_mod");
				String data_attivita = ret.get("data_attivita_mod");
				String descrizione = ret.get("descrizione_mod");
				String tipo_manutenzione = ret.get("select_tipo_manutenzione_mod");				
			
				String ente = ret.get("ente_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String etichettatura = ret.get("etichettatura_mod");
				String stato = ret.get("stato_mod");
				String campo_sospesi = ret.get("campo_sospesi_mod");
				String operatore = ret.get("operatore_mod");
				String id_certificato = ret.get("id_certificato_mod");
				
				AcAttivitaCampioneDTO attivita = GestioneAttivitaCampioneBO.getAttivitaFromId(Integer.parseInt(id_attivita), session);
				
				attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(Integer.parseInt(tipo_attivita),""));
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date date = format.parse(data_attivita);
				attivita.setData(date);
				attivita.setDescrizione_attivita(descrizione);
				if(operatore!=null && !operatore.equals("")) {
					UtenteDTO user = GestioneUtenteBO.getUtenteById(operatore, session);
					attivita.setOperatore(user);
				}
				if(tipo_manutenzione!=null && !tipo_manutenzione.equals("")) {
					attivita.setTipo_manutenzione(Integer.parseInt(tipo_manutenzione));	
				}
				
				if(Integer.parseInt(tipo_attivita)==2 || Integer.parseInt(tipo_attivita)==3) {
					attivita.setEnte(ente);					
					attivita.setData_scadenza(format.parse(data_scadenza));
					attivita.setEtichettatura(etichettatura);
					attivita.setStato(stato);
					attivita.setCampo_sospesi(campo_sospesi);
					if(id_certificato!=null && !id_certificato.equals("")) {
						CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(id_certificato);
						attivita.setCertificato(certificato);
					}
				}
				
				session.update(attivita);
				session.getTransaction().commit();
				session.close();
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attività modificata con successo!");
				out.print(myObj);
			}
			
			else if(action.equals("scheda_manutenzioni")) {
				
				ajax = false;
				
				String id_campione = request.getParameter("id_campione");
				
				ArrayList<AcAttivitaCampioneDTO> lista_manutenzioni = GestioneAttivitaCampioneBO.getListaManutenzioni(Integer.parseInt(id_campione), session);
				CampioneDTO campione= null;
				if(lista_manutenzioni.size()>0) {
					campione = lista_manutenzioni.get(0).getCampione();
				}else {
					campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				}
				new CreateSchedaManutenzioniCampione(lista_manutenzioni, campione);
				
				String path = Costanti.PATH_FOLDER_CAMPIONI+id_campione+"\\SchedaManutenzione\\sma_"+id_campione+".pdf";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    				    
				    session.close();

				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			
			else if(action.equals("scheda_verifiche_intermedie")) {
				
				ajax = false;
				
				String id_campione = request.getParameter("id_campione");
				
				ArrayList<AcAttivitaCampioneDTO> lista_verifiche = GestioneAttivitaCampioneBO.getListaTaratureVerificheIntermedie(Integer.parseInt(id_campione), session);
				CampioneDTO campione= null;
				if(lista_verifiche.size()>0) {
					campione = lista_verifiche.get(0).getCampione();
				}else {
					campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				}
				new CreateSchedaTaraturaVerificaIntermedia(lista_verifiche, campione);
				
				String path = Costanti.PATH_FOLDER_CAMPIONI+id_campione+"\\SchedaVerificaIntermedia\\stca_"+id_campione+".pdf";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    				    
				    session.close();

				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			else if(action.equals("scheda_apparecchiatura")) {
				
				ajax = false;
				
				String id_campione = request.getParameter("id_campione");
				
				//ArrayList<AcAttivitaCampioneDTO> lista_verifiche = GestioneAttivitaCampioneBO.getListaTaratureVerificheIntermedie(Integer.parseInt(id_campione), session);
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				
				new CreateSchedaApparecchiaturaCampioni(campione, session);
				
				String path = Costanti.PATH_FOLDER_CAMPIONI+id_campione+"\\SchedaApparecchiatura\\sa_"+id_campione+".pdf";
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    				    
				    session.close();

				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			
			if(action.equals("lista_verifiche_intermedie")) {
				String idC = request.getParameter("idCamp");
				
				ArrayList<AcAttivitaCampioneDTO> lista_verifiche_intermedie = GestioneAttivitaCampioneBO.getListaVerificheIntermedie(Integer.parseInt(idC), session);
				
				request.getSession().setAttribute("lista_attivita", lista_verifiche_intermedie);
							
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerificheIntermedie.jsp");
				dispatcher.forward(request,response);
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
