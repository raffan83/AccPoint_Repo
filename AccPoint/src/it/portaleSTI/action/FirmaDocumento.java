package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.apache.commons.io.FileUtils;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.arubapec.arubasignservice.ArubaSignService;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class FirmaDocumento
 */
@WebServlet("/firmaDocumento.do")
public class FirmaDocumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FirmaDocumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		if(Utility.validateSession(request,response,getServletContext()))return;
		
		String action = request.getParameter("action");
		JsonObject jsono = new JsonObject();
		boolean ajax = false;
		try {
			
			if(action==null || action.equals("")) {
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/firmaDocumento.jsp");
			     dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("upload")) {
				ajax=true;
				File folder = new File(Costanti.PATH_FIRMA_DIGITALE);
				FileUtils.cleanDirectory(folder); 
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				
				response.setContentType("application/json");
				PrintWriter writer = response.getWriter();
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {

						
						uploadPdf(item);
											
						jsono.addProperty("success", true);
						jsono.addProperty("filename", item.getName());
					}
			
				}
				
			writer.write(jsono.toString());			
				writer.close();
				
				
			}
			else if(action.equals("checkPIN")) {
				ajax = true;
				String pin = request.getParameter("pin");
				
				response.setContentType("application/json");
				PrintWriter writer = response.getWriter();
				Session session=SessionFacotryDAO.get().openSession();
				session.beginTransaction();
				
				UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
				
				UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);
				
				boolean esito = GestioneUtenteBO.checkPINFirma(utente_firma.getId(),pin, session);
				if(esito) {
					jsono.addProperty("success", true);
					
				}else {
					jsono.addProperty("success", false);
					jsono.addProperty("messaggio", "Attenzione! PIN errato!");
					jsono.addProperty("num_error", 1);
				}
				
				writer.write(jsono.toString());			
				writer.close();
			}
			
			else if(action.equals("firma")) {
				ajax=true;
			
				String filename = request.getParameter("filename");
				Session session=SessionFacotryDAO.get().openSession();
				session.beginTransaction();
				
				UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
				
				UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);	
		
				PrintWriter writer = response.getWriter();
				
				jsono = ArubaSignService.signDocumento(utente_firma.getIdFirma(), filename);

				session.getTransaction().commit();
				session.close();
				writer.print(jsono);
				
				}
			
			
			else if(action.equals("download")) {
				ajax=false;
				
				String filename = request.getParameter("filename");
				downloadDocumentoFirmato(request, response, filename);
				
			}

		}catch(Exception e) {
			
			if(ajax) {
			
				 e.printStackTrace();
				 request.getSession().setAttribute("exception", e);
				 jsono = STIException.getException(e);
				 PrintWriter writer = response.getWriter();
				writer.print(jsono);
				
			}else {
			 e.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(e));
	   	     request.getSession().setAttribute("exception",e);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);
			}
		}
		
	}

	
	
	
	public static void uploadPdf(FileItem item) throws Exception {
		
		
		File file = new File(Costanti.PATH_FIRMA_DIGITALE+ item.getName());
		
		while(true) {

			
					item.write(file);
					
					break;
				
		}
	}
	
	
	
	
	public static void downloadDocumentoFirmato(HttpServletRequest request, HttpServletResponse response, String filename) throws IOException {
		
		String fileNoExt = filename.substring(0, filename.length()-4);
			String path = Costanti.PATH_FIRMA_DIGITALE+fileNoExt +".p7m"; 
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
			    file.delete();
	}
	
	
}
