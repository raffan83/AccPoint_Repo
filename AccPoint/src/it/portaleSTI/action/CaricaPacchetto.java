package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneStrumentoDAO;
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
		
		InterventoDTO intervento= (InterventoDTO)request.getSession().getAttribute("intervento");
		
//		if (!ServletFileUpload.isMultipartContent(request)) {
//            throw new IllegalArgumentException("Request is not multipart, please 'multipart/form-data' enctype for your form.");
//        }

        ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        JsonObject jsono = new JsonObject();

        UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
        String action=request.getParameter("action");
        try {
        	
        	if(action ==null || action.equals(""))
			{
            List<FileItem> items = uploadHandler.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                	
                		ObjSavePackDTO esito =GestioneInterventoBO.savePackUpload(item,intervento.getNomePack());
                      
                		if(esito.getEsito()==0)
                		{
                		     jsono.addProperty("name", item.getName());
                             jsono.addProperty("size", item.getSize());
                             jsono.addProperty("success", false);
                             jsono.addProperty("messaggioErrore", esito.getErrorMsg());
                		}
                		
                		if(esito.getEsito()==1)
                		{
                			
                			esito = GestioneInterventoBO.saveDataDB(esito,intervento,utente);
                			
                			if(esito.getEsito()==0)
                			{
                				jsono.addProperty("success", false);
                                jsono.addProperty("messaggioErrore", esito.getErrorMsg());
                			}
                			
                			if(esito.getEsito()==1 && esito.isDuplicati()==false)
                			{
                			 
                				jsono.addProperty("success", true);
                			
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
                			                          				
                				jsono.addProperty("duplicate",jsonInString);
                				jsono.addProperty("success", true);
                                jsono.addProperty("messaggioErrore", esito.getErrorMsg());
                			
                			}
                		}
                    
                }
            }
			}else if(action.equals("duplicati")){
				String ids = (String) request.getParameter("ids");
				System.out.println(ids);
			}
        } catch (FileUploadException e) {
                throw new RuntimeException(e);
        } catch (Exception e) {
                throw new RuntimeException(e);
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
