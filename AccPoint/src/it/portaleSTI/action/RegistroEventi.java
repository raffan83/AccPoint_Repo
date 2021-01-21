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
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.DTO.TipoEventoRegistroDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaApparecchiatura;
import it.portaleSTI.bo.CreateSchedaApparecchiaturaCampioni;
import it.portaleSTI.bo.CreateSchedaManutenzioniCampione;
import it.portaleSTI.bo.CreateSchedaTaraturaVerificaIntermedia;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class RegistroEventi
 */
@WebServlet("/registroEventi.do")
public class RegistroEventi extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(RegistroEventi.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistroEventi() {
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
		
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		String action = request.getParameter("action");
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		try{
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(action==null || action.equals("")) {
				
			String idC = request.getParameter("idCamp");
			
			ArrayList<RegistroEventiDTO> lista_eventi = GestioneCampioneBO.getListaRegistroEventi(idC, session);
			ArrayList<TipoManutenzioneDTO> lista_tipo_manutenzione = GestioneCampioneBO.getListaTipoManutenzione(session);
			ArrayList<TipoAttivitaManutenzioneDTO> lista_tipo_attivita_manutenzione = GestioneCampioneBO.getListaTipoAttivitaManutenzione(session);
			ArrayList<TipoEventoRegistroDTO> lista_tipo_evento = GestioneCampioneBO.getListaTipoEventoRegistro(session);
			ArrayList<UtenteDTO> lista_utenti_cmp = GestioneUtenteBO.getUtentiFromCompany(utente.getCompany().getId(), session);
			ArrayList<UtenteDTO> lista_utenti = new ArrayList<UtenteDTO>();
			
			for (UtenteDTO utenteDTO : lista_utenti_cmp) {
				if(utenteDTO.checkRuolo("OP") || utenteDTO.checkRuolo("AM") || utenteDTO.checkRuolo("RS")) {
					lista_utenti.add(utenteDTO);
				}
			}
			
			request.getSession().setAttribute("lista_utenti", lista_utenti);
			request.getSession().setAttribute("lista_eventi", lista_eventi);
			request.getSession().setAttribute("lista_tipo_manutenzione", lista_tipo_manutenzione);
			request.getSession().setAttribute("lista_tipo_attivita_manutenzione", lista_tipo_attivita_manutenzione);
			request.getSession().setAttribute("lista_tipo_evento", lista_tipo_evento);
			
			session.close();
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registroEventi.jsp");
			     dispatcher.forward(request,response);
			} 

			else if(action!=null && action.equals("manutenzione")) {
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
		
				String index = request.getParameter("index");
				String idC = request.getParameter("idCamp");
				String tipo_manutenzione = ret.get("select_tipo_man");
				String data_manutenzione = ret.get("data_manutenzione");
				String frequenza_manutenzione = ret.get("frequenza_manutenzione");
				ArrayList<String> lista_attivita = new ArrayList<String>();
				ArrayList<String> lista_esiti = new ArrayList<String>();
				for(int i=0; i<Integer.parseInt(index);i++) {					
					String attivita = ret.get("descrizione_attivita_"+(i+1));
					String esito = ret.get("select_esito_"+(i+1));
					if(!attivita.equals("")) {
					lista_attivita.add(attivita);
					lista_esiti.add(esito);
					}
				}
				
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);
				RegistroEventiDTO evento = new RegistroEventiDTO();
				DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
				Date date = format.parse(data_manutenzione);
				
				evento.setData_evento(date);
				evento.setTipo_manutenzione(new TipoManutenzioneDTO(Integer.parseInt(tipo_manutenzione)));
				evento.setFrequenza_manutenzione(Integer.parseInt(frequenza_manutenzione));
				evento.setCampione(campione);
				
				GestioneCampioneDAO.saveEventoRegistro(evento, session);
				for(int i = 0; i<lista_attivita.size();i++) {
				AttivitaManutenzioneDTO attivita = new AttivitaManutenzioneDTO();
				//attivita.setTipo_attivita(new TipoAttivitaManutenzioneDTO(Integer.parseInt(lista_attivita.get(i))));
				attivita.setDescrizione(lista_attivita.get(i));
				attivita.setEvento(evento);
				attivita.setEsito(lista_esiti.get(i));
				GestioneCampioneBO.saveAttivitaManutenzione(attivita, session);
			
				}
				
				
			//	ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(2, session);
				
				
			//	CreateSchedaApparecchiatura x = new CreateSchedaApparecchiatura(campione, lista_attivita_manutenzione, evento, session);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Manutenzione salvata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action!=null && action.equals("lista_attivita")) {
				
				String id_evento = request.getParameter("id_evento");
				
				ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(Integer.parseInt(id_evento), session);
				
				request.getSession().setAttribute("lista_attivita_manutenzione", lista_attivita_manutenzione);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAttivitaManutenzione.jsp");
			     dispatcher.forward(request,response);
			     session.close();
			}
			
			else if(action!= null && action.equals("genera_scheda")) {
				String id_evento = request.getParameter("id_evento");
				String id_campione = request.getParameter("id_campione");
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(Integer.parseInt(id_evento), session);
				RegistroEventiDTO evento = GestioneCampioneBO.getEventoFromId(Integer.parseInt(id_evento), session);
				CreateSchedaApparecchiatura scheda = new CreateSchedaApparecchiatura(campione, lista_attivita_manutenzione, evento, session);
				session.getTransaction().commit();
				
				downloadSchedaApparecchiatura("scheda_anagrafica_"+campione.getId()+"_"+evento.getId()+".pdf", response);
				session.close();
			}
			else if(action.equals("nuovo")) {
				
				
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
			
					String idC = request.getParameter("idCamp");
					String tipo_evento = ret.get("select_tipo_evento");
					String tipo_manutenzione = ret.get("select_tipo_manutenzione");
					String data_evento = ret.get("data_evento");
					String operatore = ret.get("operatore");
					
					String data_scadenza = ret.get("data_scadenza");
					String stato = ret.get("stato");
					String laboratorio = ret.get("laboratorio");
					String descrizione = ret.get("descrizione");
					String campo_sospesi = ret.get("campo_sospesi");
					String numero_certificato = ret.get("numero_certificato");
					String presso = ret.get("presso");
					//String allegato = ret.get("allegato");
					
					ArrayList<String> lista_attivita = new ArrayList<String>();
					ArrayList<String> lista_esiti = new ArrayList<String>();
//					for(int i=0; i<Integer.parseInt(index);i++) {					
//						String attivita = ret.get("descrizione_attivita_"+(i+1));
//						String esito = ret.get("select_esito_"+(i+1));
//						if(!attivita.equals("")) {
//						lista_attivita.add(attivita);
//						lista_esiti.add(esito);
//						}
//					}

					CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);
					
					
					RegistroEventiDTO evento = new RegistroEventiDTO();
					
					
					DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date date = format.parse(data_evento);
					
					evento.setData_evento(date);
					if(operatore!=null && !operatore.equals("")) {
						UtenteDTO user = GestioneUtenteBO.getUtenteById(operatore, session);
						evento.setOperatore(user);
					}
					evento.setTipo_evento(new TipoEventoRegistroDTO(Integer.parseInt(tipo_evento),""));
					if(tipo_evento.equals("1")) {
						evento.setTipo_manutenzione(new TipoManutenzioneDTO(Integer.parseInt(tipo_manutenzione)));
						evento.setDescrizione(descrizione);
						evento.setObsoleta("N");
					}else {
						if(laboratorio.equals("Interno")) {
							evento.setLaboratorio(laboratorio);	
						}else {
							evento.setLaboratorio(presso);
						}
						
						evento.setStato(stato);
						evento.setCampo_sospesi(campo_sospesi);
						evento.setNumero_certificato(numero_certificato);
						evento.setData_scadenza(format.parse(data_scadenza));
												
					}
					
					evento.setCampione(campione);
					
					if(fileItem!=null && !filename.equals("")) {

						saveFile(fileItem, campione.getId(),filename);
						evento.setAllegato(filename);
					}
					
					if(tipo_evento.equals("1") && tipo_manutenzione.equals("1")) {
						GestioneCampione.updateManutenzioniObsolete(campione, session);
					}
					
					GestioneCampioneDAO.saveEventoRegistro(evento, session);
					
					
//					for(int i = 0; i<lista_attivita.size();i++) {
//					AttivitaManutenzioneDTO attivita = new AttivitaManutenzioneDTO();
//					//attivita.setTipo_attivita(new TipoAttivitaManutenzioneDTO(Integer.parseInt(lista_attivita.get(i))));
//					attivita.setDescrizione(lista_attivita.get(i));
//					attivita.setEvento(evento);
//					attivita.setEsito(lista_esiti.get(i));
//					GestioneCampioneBO.saveAttivitaManutenzione(attivita, session);
//				
//					}
//					
					
				//	ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(2, session);
					
					
				//	CreateSchedaApparecchiatura x = new CreateSchedaApparecchiatura(campione, lista_attivita_manutenzione, evento, session);
					
					myObj = new JsonObject();
					PrintWriter  out = response.getWriter();
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Evento salvato con successo!");
					out.print(myObj);
					session.getTransaction().commit();
					session.close();
				
			}
			
			else if(action.equals("modifica")) {
				
				
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
			
					String idC = request.getParameter("idCamp");
					String id_evento = ret.get("id_evento");
					String tipo_evento = ret.get("select_tipo_evento_mod");
					String tipo_manutenzione = ret.get("select_tipo_manutenzione_mod");
					String data_evento = ret.get("data_evento_mod");
					String operatore = ret.get("operatore_mod");
					
					String data_scadenza = ret.get("data_scadenza_mod");
					String stato = ret.get("stato_mod");
					String laboratorio = ret.get("laboratorio_mod");
					String descrizione = ret.get("descrizione_mod");
					String campo_sospesi = ret.get("campo_sospesi_mod");
					String numero_certificato = ret.get("numero_certificato_mod");
					String presso = ret.get("presso_mod");
					//String allegato = ret.get("allegato");
					

					CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);
					
					
					RegistroEventiDTO evento = GestioneCampioneBO.getEventoFromId(Integer.parseInt(id_evento), session);					
					
					DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date date = format.parse(data_evento);
					
					evento.setData_evento(date);
					if(operatore!=null && !operatore.equals("")) {
						UtenteDTO user = GestioneUtenteBO.getUtenteById(operatore, session);
						evento.setOperatore(user);
					}
					evento.setTipo_evento(new TipoEventoRegistroDTO(Integer.parseInt(tipo_evento),""));
					if(tipo_evento.equals("1")) {
						evento.setTipo_manutenzione(new TipoManutenzioneDTO(Integer.parseInt(tipo_manutenzione)));
						evento.setDescrizione(descrizione);
					}else {
						if(laboratorio.equals("Interno")) {
							evento.setLaboratorio(laboratorio);	
						}else {
							if(presso.equals("")) {
								evento.setLaboratorio("Esterno");
							}else {
								evento.setLaboratorio(presso);	
							}
							
						}
						
						evento.setStato(stato);
						evento.setCampo_sospesi(campo_sospesi);
						evento.setNumero_certificato(numero_certificato);
						evento.setData_scadenza(format.parse(data_scadenza));
												
					}
					
					evento.setCampione(campione);
					
					if(fileItem!=null && !filename.equals("")) {

						saveFile(fileItem, campione.getId(),filename);
						evento.setAllegato(filename);
					}
					
					session.update(evento);
					session.getTransaction().commit();
					session.close();
					
					PrintWriter  out = response.getWriter();
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Evento modificato con successo!");
					out.print(myObj);
			
				
			}
			
			else if(action.equals("scheda_manutenzioni")) {
				
				ajax = false;
				
				String id_campione = request.getParameter("id_campione");
				
				ArrayList<RegistroEventiDTO> lista_manutenzioni = GestioneCampioneBO.getListaEvento(Integer.parseInt(id_campione), 1, session);
				CampioneDTO campione= null;
				if(lista_manutenzioni.size()>0) {
					campione = lista_manutenzioni.get(0).getCampione();
				}else {
					campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				}
				new CreateSchedaManutenzioniCampione(null,lista_manutenzioni, campione);
				
				
				String path = Costanti.PATH_FOLDER_CAMPIONI+id_campione+"\\RegistroEventi\\SchedaManutenzione\\"+"sma_"+id_campione+".pdf";
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
			else if(action.equals("scheda_tarature")) {
				
				ajax = false;
				
				String id_campione = request.getParameter("id_campione");
				
				ArrayList<RegistroEventiDTO> lista_tarature = GestioneCampioneBO.getListaEvento(Integer.parseInt(id_campione), 2, session);
				CampioneDTO campione= null;
				if(lista_tarature.size()>0) {
					campione = lista_tarature.get(0).getCampione();
				}else {
					campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				}
				new CreateSchedaTaraturaVerificaIntermedia(null,lista_tarature, campione);
				
				String path = Costanti.PATH_FOLDER_CAMPIONI+id_campione+"\\RegistroEventi\\Taratura\\stca_"+id_campione+".pdf";
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
			else if(action.equals("download")) {
				
				ajax = false;
				String id_evento = request.getParameter("id_evento");
				
				id_evento = Utility.decryptData(id_evento);
				
				RegistroEventiDTO evento = GestioneCampioneBO.getEventoFromId(Integer.parseInt(id_evento), session);
				
				
				String path = Costanti.PATH_FOLDER+"//Campioni//"+evento.getCampione().getId()+"//Allegati//"+evento.getAllegato();
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
				
				new CreateSchedaApparecchiaturaCampioni(campione, true,session);
				
				String path = Costanti.PATH_FOLDER_CAMPIONI+id_campione+"\\RegistroEventi\\SchedaApparecchiatura\\sa_"+id_campione+".pdf";
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
			
			
		}catch(Exception ex)
		{
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				PrintWriter out = response.getWriter();
				ex.printStackTrace();	        	
	        	request.getSession().setAttribute("exception", ex);
	        	myObj = STIException.getException(ex);
	        	out.print(myObj);
        	}else {   			    			
    			ex.printStackTrace();
    			request.setAttribute("error",STIException.callException(ex));
    	  	    request.getSession().setAttribute("exception", ex);
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
	
	
	 static void downloadSchedaApparecchiatura(String filename, HttpServletResponse response) throws IOException {
		
		
		
		String path =  Costanti.PATH_SCHEDA_ANAGRAFICA + filename;
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
		    
		    
		    fileIn.close();
		    outp.flush();
		    outp.close();
	}
	
	 private void saveFile(FileItem item, int id_campione, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//Campioni//"+id_campione+"//Allegati//";
			File folder=new File(path_folder);
			
			if(!folder.exists()) {
				folder.mkdirs();
			}
		
			
			while(true)
			{
				File file=null;
				
				
				file = new File(path_folder+filename);					
				
					try {
						item.write(file);
						break;

					} catch (Exception e) 
					{

						e.printStackTrace();
						break;
					}
			}
		
		}
}
