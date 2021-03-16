package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAllegatoLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoApprovazioneDTO;
import it.portaleSTI.DTO.VerTipoProvvedimentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneVerLegalizzazioneBilanceBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class GgestioneVerLegalizzazioneBilance
 */
@WebServlet(name = "GestioneVerLegalizzazioneBilance", urlPatterns = { "/gestioneVerLegalizzazioneBilance.do" })
public class GestioneVerLegalizzazioneBilance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerLegalizzazioneBilance() {
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
			
			if(action.equals("lista")) {
				
				ArrayList<VerLegalizzazioneBilanceDTO> lista_legalizzazioni = GestioneVerLegalizzazioneBilanceBO.getListaLegalizzazioni(session);
				ArrayList<VerTipoApprovazioneDTO>  lista_tipo_approvazione = GestioneVerLegalizzazioneBilanceBO.getListaTipoApprovazione(session);
				ArrayList<VerTipoProvvedimentoDTO>  lista_tipo_provvedimento = GestioneVerLegalizzazioneBilanceBO.getListaTipoProvvedimento(session);
				
				request.getSession().setAttribute("lista_legalizzazioni", lista_legalizzazioni);
				request.getSession().setAttribute("lista_tipo_provvedimento", lista_tipo_provvedimento);
				request.getSession().setAttribute("lista_tipo_approvazione", lista_tipo_approvazione);
				
				
				
				
				//importaAllegati(lista_legalizzazioni, session);
				
				
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneAccertamentoConformita.jsp");
		  	    dispatcher.forward(request,response);
		  	    
			}
			else if(action.equals("nuovo_provvedimento")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        ArrayList<FileItem> file_list = new ArrayList<FileItem>();
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 file_list.add(item);
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String strumento = ret.get("strumento");
				String costruttore = ret.get("costruttore");
				String modello = ret.get("modello");
				String classe = ret.get("classe");
				String tipo_approvazione = ret.get("tipo_approvazione");
				String tipo_provvedimento = ret.get("tipo_provvedimento");
				String numero_provvedimento = ret.get("numero_provvedimento");
				String data_provvedimento = ret.get("data_provvedimento");
				String rev = ret.get("rev");
				
				VerLegalizzazioneBilanceDTO provvedimento = new VerLegalizzazioneBilanceDTO();
				
				provvedimento.setDescrizione_strumento(strumento);
				provvedimento.setCostruttore(costruttore);
				provvedimento.setClasse(classe);
				provvedimento.setModello(modello);
				provvedimento.setNumero_provvedimento(numero_provvedimento);
				provvedimento.setRev(rev);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				provvedimento.setData_provvedimento(df.parse(data_provvedimento));
				provvedimento.setTipo_approvazione(new VerTipoApprovazioneDTO(Integer.parseInt(tipo_approvazione),""));
				provvedimento.setTipo_provvedimento(new VerTipoProvvedimentoDTO(Integer.parseInt(tipo_provvedimento), ""));
				
				session.save(provvedimento);
				
				for (FileItem item : file_list) {
					if(!item.getName().equals("")) {
						saveFile(item, provvedimento.getId(),item.getName());		
						
						VerAllegatoLegalizzazioneBilanceDTO allegato = new VerAllegatoLegalizzazioneBilanceDTO();
						allegato.setNome_file(item.getName());
						allegato.setProvvedimento(provvedimento);
								
						session.save(allegato);
					}
				}				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Provvedimento salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			}
			else if(action.equals("modifica_provvedimento")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String id = ret.get("id_provvedimento");
				String strumento = ret.get("strumento_mod");
				String costruttore = ret.get("costruttore_mod");
				String modello = ret.get("modello_mod");
				String classe = ret.get("classe_mod");
				String tipo_approvazione = ret.get("tipo_approvazione_mod");
				String tipo_provvedimento = ret.get("tipo_provvedimento_mod");
				String numero_provvedimento = ret.get("numero_provvedimento_mod");
				String data_provvedimento = ret.get("data_provvedimento_mod");
				String rev = ret.get("rev_mod");
				
				VerLegalizzazioneBilanceDTO provvedimento = GestioneVerLegalizzazioneBilanceBO.getProvvedimentoFromId(Integer.parseInt(id), session);
				
				provvedimento.setDescrizione_strumento(strumento);
				provvedimento.setCostruttore(costruttore);
				provvedimento.setClasse(classe);
				provvedimento.setModello(modello);
				provvedimento.setNumero_provvedimento(numero_provvedimento);
				provvedimento.setRev(rev);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				provvedimento.setData_provvedimento(df.parse(data_provvedimento));
				provvedimento.setTipo_approvazione(new VerTipoApprovazioneDTO(Integer.parseInt(tipo_approvazione),""));
				provvedimento.setTipo_provvedimento(new VerTipoProvvedimentoDTO(Integer.parseInt(tipo_provvedimento), ""));
				
				session.save(provvedimento);
				
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Provvedimento salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("strumento_legalizzazione_bilance")) {
				 response.setContentType("application/json");
				
				String id_strumento = request.getParameter("id_strumento");
				
				VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(id_strumento), session);
				ArrayList<VerLegalizzazioneBilanceDTO> lista_provvedimenti = GestioneVerLegalizzazioneBilanceBO.getListaLegalizzazioni(session);
				PrintWriter out = response.getWriter();
				
				 Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
			        			        
			     			       		   
			        myObj.addProperty("success", true);
			  
			        myObj.add("lista_provvedimenti", gson.toJsonTree(lista_provvedimenti));
			        myObj.add("lista_provvedimenti_associati", gson.toJsonTree(strumento.getLista_legalizzazione_bilance()));
			        
			        out.print(myObj);
		
			        out.close();
			        
			     session.getTransaction().commit();
		       	session.close();
				
			}
			
			else if(action.equals("associa_provvedimento")) {
								
				ajax = true;
				
				String id_strumento = request.getParameter("id_strumento");
				String selezionati = request.getParameter("selezionati");
					
				VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(id_strumento), session);
				strumento.getLista_legalizzazione_bilance().clear();
				
				if(selezionati!=null && !selezionati.equals("")) {
					for(int i = 0;i<selezionati.split(";").length;i++) {
						
						VerLegalizzazioneBilanceDTO provvedimento = GestioneVerLegalizzazioneBilanceBO.getProvvedimentoFromId(Integer.parseInt(selezionati.split(";")[i]), session);
						strumento.getLista_legalizzazione_bilance().add(provvedimento);					
					}					
				}				
				
				session.getTransaction().commit();
			    session.close();
				
				PrintWriter out = response.getWriter();
			      
		        myObj.addProperty("success", true);
		  
		        myObj.addProperty("messaggio", "Provvedimenti associati con successo!");
		        
		        out.println(myObj);
	
		        out.close();
		        
				
			}
			else if(action.equals("lista_allegati")) {
			
				 String id = request.getParameter("id_provvedimento");
					

				 ArrayList<VerAllegatoLegalizzazioneBilanceDTO> lista_allegati = GestioneVerLegalizzazioneBilanceBO.getListaAllegati(Integer.parseInt(id), session);
	
				    PrintWriter out = response.getWriter();
					
					 Gson gson = new Gson(); 
				        			        
				     			       		       
				        myObj.addProperty("success", true);
				  				        
				        myObj.add("lista_allegati", gson.toJsonTree(lista_allegati));
				        
				        out.print(myObj);
			
				        out.close();
				        
				     session.getTransaction().commit();
			       	session.close();
					
				
			}
			else if(action.equals("upload_allegato")) {
				
				 ajax = true;
				
				 String id = request.getParameter("id_provvedimento");
					
				 VerLegalizzazioneBilanceDTO provvedimento = GestioneVerLegalizzazioneBilanceBO.getProvvedimentoFromId(Integer.parseInt(id), session);
				
				
				 ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
					PrintWriter out = response.getWriter();
					response.setContentType("application/json");						
						
						List<FileItem> items = uploadHandler.parseRequest(request);
						for (FileItem item : items) {
							if (!item.isFormField()) {							
								saveFile(item, provvedimento.getId(),item.getName());		
								
								VerAllegatoLegalizzazioneBilanceDTO allegato = new VerAllegatoLegalizzazioneBilanceDTO();
								allegato.setNome_file(item.getName());
								allegato.setProvvedimento(provvedimento);
										
								session.save(allegato);
							}
						}

						session.getTransaction().commit();
						session.close();	
						myObj.addProperty("success", true);
						myObj.addProperty("messaggio", "Upload effettuato con successo!");
						out.print(myObj);
			}
			else if(action.equals("download_allegato")){
				
			
				String id_allegato = request.getParameter("id_allegato");			
			
				VerAllegatoLegalizzazioneBilanceDTO allegato = GestioneVerLegalizzazioneBilanceBO.getAllegatoFromId(Integer.parseInt(id_allegato), session); 
					
				
				String path = Costanti.PATH_FOLDER+"//Verificazione//LegalizzazioneBilance//"+allegato.getProvvedimento().getId()+"//"+allegato.getNome_file();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename="+ allegato.getNome_file());
		
				ServletOutputStream outp = response.getOutputStream();
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
				
				session.close();
				
			}
			
			
			else if(action.equals("elimina_allegato")) {
				
				ajax=true;				

				String id_allegato = request.getParameter("id_allegato");			
				
				VerAllegatoLegalizzazioneBilanceDTO allegato = GestioneVerLegalizzazioneBilanceBO.getAllegatoFromId(Integer.parseInt(id_allegato), session); 
					
				session.delete(allegato);	
				
				
				PrintWriter out = response.getWriter();
				session.getTransaction().commit();
				session.close();	
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
				
			}
			

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
	
	 private void saveFile(FileItem item, int id_provvedimento, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//Verificazione//LegalizzazioneBilance//"+id_provvedimento+"//";
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



public static void importaAllegati(ArrayList<VerLegalizzazioneBilanceDTO> lista_legalizzazioni, Session session) throws Exception {
	
		
	for(VerLegalizzazioneBilanceDTO legalizzazione : lista_legalizzazioni) {

		if(legalizzazione.getId()>315 && legalizzazione.getId()<811) {
			
			System.out.println(legalizzazione.getId());
			String folder = "C:\\Users\\antonio.dicivita\\Desktop\\BILANCE\\"+legalizzazione.getId();
			
			String[] files;
			
			File cartella = new File(folder);
			
			files = cartella.list();
			
			for (String name : files) {
				File fileToCopy = new File(folder+"\\"+name);					
				
				String destinazione = Costanti.PATH_FOLDER+"//Verificazione//LegalizzazioneBilance//"+legalizzazione.getId()+"//";
				
				File folder_destination=new File(destinazione);
				
				if(!folder_destination.exists()) {
					folder_destination.mkdirs();
				}
				
//				File destination = new File(destinazione+"//"+name);
//				if(destination.exists())
				Files.copy(Paths.get(folder+"\\"+name), Paths.get(destinazione+"\\"+name), StandardCopyOption.REPLACE_EXISTING);
				
				
				VerAllegatoLegalizzazioneBilanceDTO allegato = new VerAllegatoLegalizzazioneBilanceDTO();
				allegato.setProvvedimento(legalizzazione);
				allegato.setNome_file(name);
				session.save(allegato);
			}
			
		}
					
}



}

}
