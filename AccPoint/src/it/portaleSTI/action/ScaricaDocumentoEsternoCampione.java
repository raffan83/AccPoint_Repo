package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Set;

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
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CategoriaDocumentoDTO;
import it.portaleSTI.DTO.DocumentiEsterniStrumentoDTO;
import it.portaleSTI.DTO.DocumentoCampioneDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;

import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ScaricaDocumentoEsternoCampione
 */
@WebServlet("/scaricaDocumentoEsternoCampione.do")
public class ScaricaDocumentoEsternoCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaDocumentoEsternoCampione() {
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
		
	
		String action=request.getParameter("action");
		
		try
		{

			if(action.equals("caricaDocumento")) {
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				List<FileItem> items = uploadHandler.parseRequest(request);
				
				String id_campione = "";
				String categoria = request.getParameter("categoria");
				FileItem fileUploaded = null;
				for (FileItem item : items) {
					if (!item.isFormField()) {
 
						fileUploaded = item;
 
					}else {
						
						if(item.getFieldName().equals("id_campione")) {
							id_campione = item.getString();
						}
						

					}
					
				
				}
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				if(fileUploaded != null) {
					
					File directory =new File(Costanti.PATH_FOLDER+"//DocumentiEsterni//Campioni//"+id_campione);
					
					if(directory.exists()==false)
					{
						directory.mkdirs();
					}
					
					File file = new File(Costanti.PATH_FOLDER+"//DocumentiEsterni//Campioni//"+id_campione+"//"+fileUploaded.getName());
		
						fileUploaded.write(file);
											
						DocumentoCampioneDTO documento = new DocumentoCampioneDTO();
								
						documento.setData_caricamento(new Date());
						documento.setCampione(campione);
						documento.setFilename(fileUploaded.getName());
						if(categoria !=null && categoria.equals("1")) {
							documento.setCategoria(new CategoriaDocumentoDTO(1,""));
						}else {
							documento.setCategoria(new CategoriaDocumentoDTO(2,""));	
						}
						
						documento.setPathFolder(directory.getPath());
						
						session.save(documento);
				
						session.getTransaction().commit();
						session.close();
						
						
						
						jsono.addProperty("success", true);
						jsono.addProperty("messaggio","ok");
					}

				writer.write(jsono.toString());
				writer.close();
			}
			
			
			
			if(action.equals("scaricaDocumento"))
			{
			String idDocumento= request.getParameter("idDoc");
			 	
			 	DocumentoCampioneDTO documento= GestioneCampioneBO.getDocumentoCampione(idDocumento,session);
				session.close();	
				
			 	if(documento!=null)
			 	{
				
			     File d = new File(Costanti.PATH_FOLDER+"//DocumentiEsterni//Campioni//"+documento.getCampione().getId()+"//"+documento.getFilename());
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/pdf");
				 response.setHeader("Content-Disposition","attachment;filename="+documento.getFilename());
				 
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
			}
			if(action.equals("eliminaDocumento"))
			{
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
				
				String idDocumento= request.getParameter("idDoc");
				
				DocumentoCampioneDTO documento =  GestioneCampioneBO.getDocumentoCampione(idDocumento, session);
				session.delete(documento);

				jsono.addProperty("success", true);
				jsono.addProperty("messaggio", "Documento eliminato correttamente");
				
				writer.write(jsono.toString());
				writer.close();
				
				
				session.getTransaction().commit();
				session.close();
			}
		
			
		
		}
		catch(Exception ex)
    	{
			 ex.printStackTrace();
	   		 session.getTransaction().rollback();
	   		 session.close();
			if(action.equals("scaricaDocumento"))
			{
				request.setAttribute("error",STIException.callException(ex));
		   	     request.getSession().setAttribute("exception", ex);
			   	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			   	dispatcher.forward(request,response);	
			
			}else {
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
			   //	jsono.addProperty("success", false);
			   	//jsono.addProperty("messaggio",ex.getMessage());
				jsono = STIException.getException(ex);
			   	writer.write(jsono.toString());
				writer.close();
			}
   
   		 

		
   	   
   	}  
	
	}

}
