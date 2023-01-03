package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CoAllegatoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaTipoControlloDTO;
import it.portaleSTI.DTO.CoControlloDTO;
import it.portaleSTI.DTO.CoTipoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoTipoControlloDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneControlliOperativiBO;

/**
 * Servlet implementation class GestioneControlliOperativi
 */
@WebServlet("/gestioneControlliOperativi.do")
public class GestioneControlliOperativi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneControlliOperativi() {
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
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("lista_attrezzature")) {
				
				ArrayList<CoAttrezzaturaDTO> lista_attrezzature = GestioneControlliOperativiBO.getLista(new CoAttrezzaturaDTO(), session);
				ArrayList<CoTipoControlloDTO> lista_tipi_controllo = GestioneControlliOperativiBO.getLista(new CoTipoControlloDTO(), session);
				ArrayList<CoTipoAttrezzaturaDTO> lista_tipi_attrezzatura = GestioneControlliOperativiBO.getLista(new CoTipoAttrezzaturaDTO(), session);
				
				
				request.getSession().setAttribute("lista_attrezzature",lista_attrezzature);
				request.getSession().setAttribute("lista_tipi_controllo",lista_tipi_controllo);
				request.getSession().setAttribute("lista_tipi_attrezzatura",lista_tipi_attrezzatura);
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAttrezzatureControllo.jsp");
    		     dispatcher.forward(request,response);	
				
			}
			
			else if(action.equals("dettaglio_attrezzatura")) {
				
				ajax = true;
				
				String id = request.getParameter("id");
				
				CoAttrezzaturaDTO attrezzatura = GestioneControlliOperativiBO.getElement(new CoAttrezzaturaDTO(), Integer.parseInt(id.split("_")[0]), session);
				
				Gson g = new Gson();
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("attrezzatura", g.toJsonTree(attrezzatura));
				out.print(myObj);
				
			}
			else if(action.equals("nuova_attrezzatura")) {
				
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
		
				String tipo_attrezzatura = ret.get("tipo_attrezzatura");
				String id_tipi_controllo = ret.get("id_tipi_controllo");
				String descrizione = ret.get("descrizione");
				String modello = ret.get("modello");
				String codice = ret.get("codice");
				String nuovo_tipo_attrezzatura = ret.get("nuovo_tipo_attrezzatura");
				String nuovo_tipo_controllo = ret.get("nuovo_tipo_controllo");
				String data_scadenza = ret.get("data_scadenza");
				String frequenza_controllo = ret.get("frequenza_controllo");
				String marca = ret.get("marca");
				String portata_max = ret.get("portata_max");
				String cmp = ret.get("company");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				CoAttrezzaturaDTO attrezzatura = new CoAttrezzaturaDTO();				
				
				CoTipoAttrezzaturaDTO tipo_attr = null;
				
				if(nuovo_tipo_attrezzatura!=null && !nuovo_tipo_attrezzatura.equals("")) {
					tipo_attr = new CoTipoAttrezzaturaDTO();
					tipo_attr.setDescrizione(nuovo_tipo_attrezzatura);
					session.save(tipo_attr);
				}else {
					tipo_attr = GestioneControlliOperativiBO.getElement(new CoTipoAttrezzaturaDTO(),Integer.parseInt(tipo_attrezzatura), session);
				}
				if(nuovo_tipo_controllo!=null && !nuovo_tipo_controllo.equals("")) {
					for (String str : nuovo_tipo_controllo.split(";")) {
						CoTipoControlloDTO tipo_contr = new CoTipoControlloDTO();
						tipo_contr.setDescrizione(str);
						
						session.save(tipo_contr);
						
						attrezzatura.getListaTipiControllo().add(tipo_contr);
					}
				}
				String[] id_controlli = id_tipi_controllo.split(";");
				
				for (int i = 0; i < id_controlli.length; i++) {
					if(!id_controlli[i].equals("0")) {
						CoTipoControlloDTO tipo_contr = GestioneControlliOperativiBO.getElement(new CoTipoControlloDTO(), Integer.parseInt(id_controlli[i]), session);
						attrezzatura.getListaTipiControllo().add(tipo_contr);
					}
				};
				
				
				attrezzatura.setTipo(tipo_attr);
				attrezzatura.setDescrizione(descrizione);
				attrezzatura.setCodice(codice);
				attrezzatura.setModello(modello);
				attrezzatura.setMarca(marca);
				attrezzatura.setPortata_max(portata_max);
				attrezzatura.setCompany(cmp);
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					attrezzatura.setData_scadenza(df.parse(data_scadenza));
				}
				
				if(frequenza_controllo!=null && !frequenza_controllo.equals("")) {
					attrezzatura.setFrequenza_controllo(Integer.parseInt(frequenza_controllo));
				}
				
				session.save(attrezzatura);
				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attrezzatura salvata con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica_attrezzatura")) {
				
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
		
		        String id_attrezzatura = ret.get("id_attrezzatura");
				String tipo_attrezzatura = ret.get("tipo_attrezzatura_mod");
				String id_tipi_controllo = ret.get("id_tipi_controllo_mod");
				String id_tipi_controllo_dissocia = ret.get("id_tipi_controllo_dissocia");
				String descrizione = ret.get("descrizione_mod");
				String modello = ret.get("modello_mod");
				String codice = ret.get("codice_mod");
				String nuovo_tipo_attrezzatura = ret.get("nuovo_tipo_attrezzatura_mod");
				String nuovo_tipo_controllo = ret.get("nuovo_tipo_controllo_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String frequenza_controllo = ret.get("frequenza_controllo_mod");
				String marca = ret.get("marca_mod");
				String portata_max = ret.get("portata_max_mod");
				String cmp = ret.get("company_mod");
				
				CoAttrezzaturaDTO attrezzatura = GestioneControlliOperativiBO.getElement(new CoAttrezzaturaDTO(), Integer.parseInt(id_attrezzatura), session);			
				
				CoTipoAttrezzaturaDTO tipo_attr = null;
				
				if(nuovo_tipo_attrezzatura!=null && !nuovo_tipo_attrezzatura.equals("")) {
					tipo_attr = new CoTipoAttrezzaturaDTO();
					tipo_attr.setDescrizione(nuovo_tipo_attrezzatura);
					session.save(tipo_attr);
				}else {
					tipo_attr = GestioneControlliOperativiBO.getElement(new CoTipoAttrezzaturaDTO(),Integer.parseInt(tipo_attrezzatura), session);
				}
				
				if(nuovo_tipo_controllo!=null && !nuovo_tipo_controllo.equals("")) {
					for (String str : nuovo_tipo_controllo.split(";")) {
						CoTipoControlloDTO tipo_contr = new CoTipoControlloDTO();
						tipo_contr.setDescrizione(str);
						
						session.save(tipo_contr);
						
						attrezzatura.getListaTipiControllo().add(tipo_contr);
					}
				}
				
				String[] id_controlli = id_tipi_controllo.split(";");
				
				for (int i = 0; i < id_controlli.length; i++) {
					if(!id_controlli[i].equals("0")) {
						CoTipoControlloDTO tipo_contr = GestioneControlliOperativiBO.getElement(new CoTipoControlloDTO(), Integer.parseInt(id_controlli[i]), session);
						attrezzatura.getListaTipiControllo().add(tipo_contr);
					}
				};
				
				
				if(id_tipi_controllo_dissocia !=null && !id_tipi_controllo_dissocia.equals("")) {
					
					for (String id : id_tipi_controllo_dissocia.split(";")) {
						CoTipoControlloDTO tipo_contr = GestioneControlliOperativiBO.getElement(new CoTipoControlloDTO(), Integer.parseInt(id), session);
						attrezzatura.getListaTipiControllo().remove(tipo_contr);
					}
					
				}
				
				
				attrezzatura.setTipo(tipo_attr);
				attrezzatura.setDescrizione(descrizione);
				attrezzatura.setCodice(codice);
				attrezzatura.setModello(modello);
				attrezzatura.setMarca(marca);
				attrezzatura.setPortata_max(portata_max);
				attrezzatura.setCompany(cmp);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					attrezzatura.setData_scadenza(df.parse(data_scadenza));
				}else {
					attrezzatura.setData_scadenza(null);
				}
				
				if(frequenza_controllo!=null && !frequenza_controllo.equals("")) {
					attrezzatura.setFrequenza_controllo(Integer.parseInt(frequenza_controllo));
				}
				
				session.update(attrezzatura);
				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attrezzatura salvata con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("elimina_attrezzatura")) {
				
				ajax = true;
				String id = request.getParameter("id_attrezzatura");
				
				CoAttrezzaturaDTO attrezzatura = GestioneControlliOperativiBO.getElement(new CoAttrezzaturaDTO(), Integer.parseInt(id), session);
				attrezzatura.setDisabilitato(1);
				
				session.update(attrezzatura);
				
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attrezzatura eliminata con successo!");
				out.print(myObj);
				
			}
			
			
			else if(action.equals("lista_controlli")) {
				
				ArrayList<CoAttrezzaturaDTO> lista_attrezzature = GestioneControlliOperativiBO.getLista(new CoAttrezzaturaDTO(), session);
				ArrayList<CoTipoControlloDTO> lista_tipi_controllo = GestioneControlliOperativiBO.getLista(new CoTipoControlloDTO(), session);				
				ArrayList<CoControlloDTO> lista_controlli = GestioneControlliOperativiBO.getLista(new CoControlloDTO(), session);
				
				
				request.getSession().setAttribute("lista_attrezzature",lista_attrezzature);
				request.getSession().setAttribute("lista_tipi_controllo",lista_tipi_controllo);
				request.getSession().setAttribute("lista_controlli",lista_controlli);
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaControlliOperativi.jsp");
    		     dispatcher.forward(request,response);	
				
			}
			
			
			
			else if(action.equals("nuovo_controllo")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        ArrayList<String> lista_esiti = new ArrayList<String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	                      if(item.getFieldName().startsWith("positivo")||item.getFieldName().startsWith("negativo")) {
	                    	  lista_esiti.add(item.getFieldName()); 
	                      }
	            	 }
	            	
	            }
		
				String id_attrezzatura = ret.get("attrezzatura");
				String data_controllo = ret.get("data_controllo");
				String data_prossimo_controllo = ret.get("data_prossimo_controllo");
				String note = ret.get("note");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				CoAttrezzaturaDTO attrezzatura = GestioneControlliOperativiBO.getElement(new CoAttrezzaturaDTO(), Integer.parseInt(id_attrezzatura.split("_")[0]), session);			
				
				String esito_generale = "P";
				
				for (String string : lista_esiti) {
					
					CoAttrezzaturaTipoControlloDTO atc = GestioneControlliOperativiBO.getAttrezzaturaTipoControllo(attrezzatura.getId(), Integer.parseInt(string.split("_")[1]), session);
					
					String esito = "N";
					if(string.startsWith("positivo")) {
						esito = "P";
					}else {
						esito_generale = "N";
					}
					
					atc.setEsito(esito);
					
					session.save(atc);
				}
				
				CoControlloDTO ctr = new CoControlloDTO();
				ctr.setAttrezzatura(attrezzatura);
				ctr.setData_controllo(df.parse(data_controllo));
				
				if(data_prossimo_controllo != null && !data_prossimo_controllo.equals("")) {
					ctr.setData_prossimo_controllo(df.parse(data_prossimo_controllo));
				}
				
				ctr.setEsito_generale(esito_generale);
				ctr.setNote(note);
				
				session.save(ctr);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Controllo salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("lista_controlli_attrezzatura")) {
				
				ajax = true;
				String id = request.getParameter("id_attrezzatura");
				
				ArrayList<CoAttrezzaturaTipoControlloDTO> lista_controlli = GestioneControlliOperativiBO.getListaAttrezzaturaTipoControllo( Integer.parseInt(id.split("_")[0]), session);
				
				Gson g = new Gson();
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_controlli", g.toJsonTree(lista_controlli));
				out.print(myObj);
				
			}
			
			else if(action.equals("modifica_controllo")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        ArrayList<String> lista_esiti = new ArrayList<String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	                      if(item.getFieldName().startsWith("positivo")||item.getFieldName().startsWith("negativo")) {
	                    	  lista_esiti.add(item.getFieldName()); 
	                      }
	            	 }
	            	
	            }
		
				String id_attrezzatura = ret.get("attrezzatura_mod");
				String id_controllo = ret.get("id_controllo");
				String data_controllo = ret.get("data_controllo_mod");
				String data_prossimo_controllo = ret.get("data_prossimo_controllo_mod");
				String note = ret.get("note_mod");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				CoControlloDTO controllo = GestioneControlliOperativiBO.getElement(new CoControlloDTO(), Integer.parseInt(id_controllo), session);
				CoAttrezzaturaDTO attrezzatura = GestioneControlliOperativiBO.getElement(new CoAttrezzaturaDTO(), Integer.parseInt(id_attrezzatura.split("_")[0]), session);			
				

				String esito_generale = "P";
				for (String string : lista_esiti) {
					
					CoAttrezzaturaTipoControlloDTO atc = new CoAttrezzaturaTipoControlloDTO();
					atc.setAttrezzatura(attrezzatura);
					
					CoTipoControlloDTO tipo_controllo = GestioneControlliOperativiBO.getElement(new CoTipoControlloDTO(), Integer.parseInt(string.split("_")[1]), session);
					atc.setTipo_controllo(tipo_controllo);
					
					String esito = "N";
					if(string.startsWith("positivo")) {
						esito = "P";
					}else {
						esito_generale = "N";
					}
					
					atc.setEsito(esito);
					
					session.update(atc);
				}
				
				
				controllo.setAttrezzatura(attrezzatura);
				controllo.setData_controllo(df.parse(data_controllo));
				
				if(data_prossimo_controllo != null && !data_prossimo_controllo.equals("")) {
					controllo.setData_prossimo_controllo(df.parse(data_prossimo_controllo));
				}
				
				controllo.setEsito_generale(esito_generale);
				controllo.setNote(note);
				session.update(controllo);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Controllo salvato con successo!");
				out.print(myObj);
				
			}
			
			
			else if(action.equals("elimina_controllo")) {
				
				ajax = true;
				String id = request.getParameter("id_controllo");
				
				CoControlloDTO controllo = GestioneControlliOperativiBO.getElement(new CoControlloDTO(), Integer.parseInt(id), session);
				controllo.setDisabilitato(1);
				
				session.update(controllo);
				
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Controllo eliminato con successo!");
				out.print(myObj);
				
			}
			
			
			else if(action.equals("lista_allegati")) {
				
				String id_attrezzatura = request.getParameter("id_attrezzatura");	
				
				ArrayList<CoAllegatoAttrezzaturaDTO> lista_allegati = GestioneControlliOperativiBO.getListaAllegatiAttrezzatura(Integer.parseInt(id_attrezzatura), session);
				
				request.getSession().setAttribute("lista_allegati", lista_allegati);
				request.getSession().setAttribute("id_attrezzatura", id_attrezzatura);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAllegatiAttrezzatura.jsp");
		     	dispatcher.forward(request,response);	
						
				
			}
			
			else if(action.equals("upload_allegati")){
				
				ajax = true;
				
				
				String id_attrezzatura = request.getParameter("id_attrezzatura");	
								
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");						
					
					List<FileItem> items = uploadHandler.parseRequest(request);
					for (FileItem item : items) {
						if (!item.isFormField()) {							
								
							
								CoAllegatoAttrezzaturaDTO allegato = new CoAllegatoAttrezzaturaDTO();
								allegato.setId_attrezzatura(Integer.parseInt(id_attrezzatura));
								
								String path = Costanti.PATH_FOLDER+"\\GestioneControlliOperativi\\Allegati\\"+id_attrezzatura+"\\";
								
								String filename = saveFile(item, path,   item.getName().replaceAll("'", "_"));
								
								allegato.setNome_file(filename);
								session.save(allegato);
																					
						}
					}

					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Upload effettuato con successo!");
					out.print(myObj);
			}
			else if(action.equals("download_allegato")){
				
				String id_allegato = request.getParameter("id_allegato");
				
						
				CoAllegatoAttrezzaturaDTO allegato = GestioneControlliOperativiBO.getElement(new CoAllegatoAttrezzaturaDTO(), Integer.parseInt(id_allegato), session);
				
				String path = Costanti.PATH_FOLDER+"\\GestioneControlliOperativi\\Allegati\\"+allegato.getId_attrezzatura()+"\\"+allegato.getNome_file();
					
					response.setHeader("Content-Disposition","attachment;filename="+ allegato.getNome_file());
		
								
				response.setContentType("application/octet-stream");
				
		
				ServletOutputStream outp = response.getOutputStream();
				
				downloadFile(path, outp);
				
			}
			
			
			else if(action.equals("elimina_allegato")) {
				
				ajax=true;				

				String id_allegato = request.getParameter("id_allegato");
				
				
				CoAllegatoAttrezzaturaDTO allegato = GestioneControlliOperativiBO.getElement(new CoAllegatoAttrezzaturaDTO(), Integer.parseInt(id_allegato), session);
			
					allegato.setDisabilitato(1);
					session.update(allegato);
							
				
				PrintWriter out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
				
			}
			
			
			session.getTransaction().commit();
			session.close();
			
	}catch(Exception e) {
			
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
	
	
	private  String saveFile(FileItem item, String path_folder, String filename) {

		File folder=new File(path_folder);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
	
		
		int index = 1;
		String ext1 = FilenameUtils.getExtension(item.getName());
		File file=null;
		while(true)
		{
			
			
			
			file = new File(path_folder+filename);			
			if(file.exists()) {
				filename = filename.replace("_"+(index-1), "").replace("."+ext1, "_"+index+"."+ext1);				
				index++;
			}
			else {
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
	
		
		return filename;
	
	
	}
 
private void downloadFile(String path,  ServletOutputStream outp) throws Exception {
	 
	 File file = new File(path);
		
		FileInputStream fileIn = new FileInputStream(file);


		    byte[] outputByte = new byte[1];
		    
		    while(fileIn.read(outputByte, 0, 1) != -1)
		    {
		    	outp.write(outputByte, 0, 1);
		    }
		    				    
		 
		    fileIn.close();
		    outp.flush();
		    outp.close();
 }

}
