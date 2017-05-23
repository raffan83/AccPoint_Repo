package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.omg.PortableInterceptor.SUCCESSFUL;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;



/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/caricaPacchetto", urlPatterns = { "/caricaPacchetto.do" })

public class CaricaPacchetto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CaricaPacchetto() {
        super();
        // TODO Auto-generated constructor stub
    }

 
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		 JsonObject jsono = new JsonObject();
		 PrintWriter writer = response.getWriter();
		
		String action=  request.getParameter("action");
		
	
		InterventoDTO intervento= (InterventoDTO)request.getSession().getAttribute("intervento");
		
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		
		
		if(action !=null && action.equals("duplicati"))
			{
			 
			 
		     response.setContentType("application/json");
		     ObjSavePackDTO esito=null;
		     try
		     {
		        jsono = new JsonObject();
		        jsono.addProperty("success", true);
		      
		        String obj =request.getParameter("ids");
		        
		        
		        
		        esito =(ObjSavePackDTO)request.getSession().getAttribute("esito");	
		  
		        if(obj!=null && obj.length()>0)
		        {
		        	String[] lista =obj.split(",");
		        	
		        	for (int i = 0; i < lista.length; i++) 
		        	{
						GestioneInterventoBO.updateMisura(lista[i],esito,intervento,utente,session);
			
						esito.getInterventoDati().setNumStrMis(i+1);
						GestioneInterventoDAO.update(esito.getInterventoDati(),session);
						intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
					    GestioneInterventoBO.update(intervento,session);
						
					}
		        	jsono.addProperty("success", true);
		        	jsono.addProperty("messaggio", "Sono stati salvati "+esito.getInterventoDati().getNumStrMis()+" \n"+"Nuovi Strumenti: "+esito.getInterventoDati().getNumStrNuovi());
		        	
		        }
		        else
		        {
		        	jsono.addProperty("messaggio","");
		        	GestioneInterventoBO.removeInterventoDati(esito.getInterventoDati(),session);
		        	jsono.addProperty("success", true);
		        }
		        
		    	writer.write(jsono.toString());
	            writer.close();
		     }catch (Exception e) {
		    	 	if(esito.getInterventoDati()!=null)
		    	 	{
		    	 		GestioneInterventoBO.removeInterventoDati(esito.getInterventoDati(),session);
		    	 	
		    	 	}
		    	 	if(esito.getPackNameAssigned().exists())
		    	 	{
		    	 		esito.getPackNameAssigned().delete();
		    	 	}
					e.printStackTrace();
					
				}
	            return;
				} 
				
        ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        writer = response.getWriter();
        response.setContentType("application/json");

       

        
        
        try {
            List<FileItem> items = uploadHandler.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                	
                		ObjSavePackDTO esito =GestioneInterventoBO.savePackUpload(item,intervento.getNomePack());
                      
                		if(esito.getEsito()==0)
                		{
                             jsono.addProperty("success", false);
                             jsono.addProperty("messaggio", esito.getErrorMsg());
                		}
                		
                		if(esito.getEsito()==1)
                		{
                			
                			esito = GestioneInterventoBO.saveDataDB(esito,intervento,utente,session);
                			
                			if(esito.getEsito()==0)
                			{
                				jsono.addProperty("success", false);
                                jsono.addProperty("messaggio", esito.getErrorMsg());
                			}
                			
                			if(esito.getEsito()==1 && esito.isDuplicati()==false)
                			{
                			 
                				jsono.addProperty("success", true);
                				jsono.addProperty("messaggio", "Sono stati salvati "+esito.getInterventoDati().getNumStrMis()+" \n"+"Nuovi Strumenti: "+esito.getInterventoDati().getNumStrNuovi());
                				
                			}
                			if(esito.getEsito()==1 && esito.isDuplicati()==true)
                			{
                			 for (int i = 0; i < esito.getListaStrumentiDuplicati().size(); i++) 
                			 {
								StrumentoDTO strumento =GestioneStrumentoBO.getStrumentoById(""+esito.getListaStrumentiDuplicati().get(i).get__id());
								esito.getListaStrumentiDuplicati().set(i,strumento);
								
                			 }
                			 	Gson gson = new Gson();
                			 	String jsonInString = gson.toJson(esito.getListaStrumentiDuplicati());
                			 	jsono.addProperty("success", true);                      				
                				jsono.addProperty("duplicate",jsonInString);
                				request.getSession().setAttribute("esito", esito);
           
                			
                			}
                		}
                    
                }
            }
            
        	session.getTransaction().commit();
        	session.close();	
        	
        } catch (Exception e) 
        
        {
              e.printStackTrace();
              session.getTransaction().rollback();
    		
    		  
    		  jsono.addProperty("success", false);
    		  jsono.addProperty("messaggio", "Errore creazione intervento");
    		  writer.print(jsono);
              
        } finally {
          
        	writer.write(jsono.toString());
            writer.close();
        }
        
      

	    }

	  
    private String getMimeType(File file) {
        String mimetype = "";
        if (file.exists()) {
            if (getSuffix(file.getName()).equalsIgnoreCase("png")) {
                mimetype = "image/png";
            }else if(getSuffix(file.getName()).equalsIgnoreCase("jpg")){
                mimetype = "image/jpg";
            }else if(getSuffix(file.getName()).equalsIgnoreCase("jpeg")){
                mimetype = "image/jpeg";
            }else if(getSuffix(file.getName()).equalsIgnoreCase("gif")){
                mimetype = "image/gif";
            }else {
                javax.activation.MimetypesFileTypeMap mtMap = new javax.activation.MimetypesFileTypeMap();
                mimetype  = mtMap.getContentType(file);
            }
        }
        return mimetype;
    }



    private String getSuffix(String filename) {
        String suffix = "";
        int pos = filename.lastIndexOf('.');
        if (pos > 0 && pos < filename.length() - 1) {
            suffix = filename.substring(pos + 1);
        }
        return suffix;
    }

}
