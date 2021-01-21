package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.Date;
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
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CartaDiControlloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCartaDiControlloBO;

/**
 * Servlet implementation class GestioneCartaDiControllo
 */
@WebServlet("/gestioneCartaDiControllo.do")
public class GestioneCartaDiControllo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneCartaDiControllo() {
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
			
			if(action==null) {
				
				String id_campione = request.getParameter("idCamp");
				CartaDiControlloDTO carta = null;
				if(id_campione != null && !id_campione.equals("")) {
					carta = GestioneCartaDiControlloBO.getCartaDiControlloFromCampione(id_campione, session);	
				}
				
				request.getSession().setAttribute("carta", carta);
				session.getTransaction().commit();		
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneCartaDiControllo.jsp");
		  	    dispatcher.forward(request,response);
		  	    
		  	    
			}
			else if(action.equals("upload")) {
			
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
				
				String id_campione = request.getParameter("idCamp");
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				List<FileItem> items = uploadHandler.parseRequest(request);
				
				
				FileItem fileUploaded = null;
				for (FileItem item : items) {
					if (!item.isFormField()) {
 
						fileUploaded = item;
 
					}
				}
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(id_campione);
				
				if(fileUploaded != null) {
					
					File directory = new File(Costanti.PATH_FOLDER+"//Campioni//"+id_campione+"//CartaDiControllo//");
					String ext = FilenameUtils.getExtension(fileUploaded.getName());
					if(directory.exists()==false)
					{
						directory.mkdirs();
					}
				
					File file = new File(Costanti.PATH_FOLDER+"//Campioni//"+id_campione+"//CartaDiControllo//cc_"+id_campione+"."+ext);
		
						fileUploaded.write(file);						
									
					//	campione.setCarta_di_controllo("cc_"+id_campione+"."+ext);
						
					
				CartaDiControlloDTO carta = new CartaDiControlloDTO();
				carta.setCampione(campione);
				carta.setData_caricamento(new Date());
				carta.setUtente(utente);
				
				carta.setFilename("cc_"+id_campione+"."+ext);							
				
				session.save(carta);
				}
				session.getTransaction().commit();
				session.close();
				
				jsono.addProperty("success", true);
				jsono.addProperty("messaggio","Caricamento effettuato con successo!");
				
				writer.write(jsono.toString());
				writer.close();
				
				
			}
			else if(action.equals("download")) {
				
				ajax = false;
				String filename = request.getParameter("filename");
				String id_campione = request.getParameter("idCamp");
				
				String path = Costanti.PATH_FOLDER+"//Campioni//"+id_campione+"//CartaDiControllo//"+filename;
				//String path = "C:\\Users\\antonio.dicivita\\Desktop\\scheda_rilievo.pdf";
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
			
			else if(action!=null && action.equals("excel")) {
				ajax = true;
				String filename = request.getParameter("filename");
				String id_campione = request.getParameter("idCamp");
				 
			     File d = new File(Costanti.PATH_FOLDER+"//Campioni//"+id_campione+"//CartaDiControllo//"+filename);
			     String path = getServletContext().getRealPath("/images") + "\\temp\\";
			     File folder = new File(path);
			     if(!folder.exists()) {
			    	 folder.mkdirs();
			     }
			     File copiato = new File(path+filename);
			     InputStream is = new FileInputStream(d);
			     OutputStream os = new FileOutputStream(copiato);
			     byte[] buffer = new byte[1024];
			        int length;
			        while ((length = is.read(buffer)) > 0) {
			            os.write(buffer, 0, length);
			        }
			        is.close();
			        os.flush();
			        os.close();
			        
			        session.close();
			        PrintWriter out = response.getWriter();
			        myObj.addProperty("success", true);
			        out.print(myObj);
			        
			}
			else if(action.equals("upload_drive")) {
				
				ajax = true;
				
				String url = request.getParameter("url");
				String nome_file = request.getParameter("nome_file");
				String id_campione = request.getParameter("idCamp");
			
				FileUtils.copyURLToFile(new URL(url), new File(Costanti.PATH_FOLDER+"//Campioni//"+id_campione+"//CartaDiControllo//"+nome_file));
			
			    session.close();
			    PrintWriter out = response.getWriter();
			    myObj.addProperty("success", true);
			    out.print(myObj);

			}
			else if(action.equals("elimina")) {
				
				ajax = true;
				
				String id_carta = request.getParameter("id_carta");
				
				CartaDiControlloDTO carta_controllo = GestioneCartaDiControlloBO.getCartaDiControlloFromId(Integer.parseInt(id_carta),session);
			
				session.delete(carta_controllo);
				session.getTransaction().commit();
			    session.close();
			    PrintWriter out = response.getWriter();
			    myObj.addProperty("messaggio", "Carta di controllo eliminata con successo!");
			    myObj.addProperty("success", true);
			    out.print(myObj);

			}
			
		}
		catch (Exception e) {
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
