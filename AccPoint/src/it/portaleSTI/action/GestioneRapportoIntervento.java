package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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
import com.google.gson.reflect.TypeToken;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMImmagineCampioneDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.RapportoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateRapportoIntervento;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;

/**
 * Servlet implementation class GestioneRapportoIntervento
 */
@WebServlet("/gestioneRapportoIntervento.do")
public class GestioneRapportoIntervento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneRapportoIntervento() {
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

			if(action.equals("nuovo_rapporto")) {
				
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
		
		        String data = ret.get("data");
		        String dateFrom = ret.get("dateFrom");
		        String dateTo = ret.get("dateTo");
		        String note = ret.get("note");
		        String ora_inizio = ret.get("ora_inizio");
		        String ora_fine = ret.get("ora_fine");
		        String id_misure = ret.get("id_misure");
		        String id_intervento = ret.get("id_intervento");
		 
		        
				String filename_img=filename;
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				RapportoInterventoDTO rapporto = new RapportoInterventoDTO();	
				
				if(data!=null && !data.equals("")) {
					Date d = df.parse(data);
					rapporto.setData_inizio(d);
				}
				
				if(dateFrom!=null && dateTo!=null) {
					Date dStart = df.parse(dateFrom);
					Date dEnd = df.parse(dateTo);
					rapporto.setData_inizio(dStart);
					rapporto.setData_fine(dEnd);
				}
				
				rapporto.setNote(note);
				
				rapporto.setOra_inizio(ora_inizio);
				rapporto.setOra_fine(ora_fine);
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento, session);
				rapporto.setIntervento(intervento);
				
				ArrayList<MisuraDTO> listaMisure = new ArrayList<MisuraDTO> ();
				
				if(id_misure!=null && !id_misure.equals("")) {
					for (int i = 0; i < id_misure.split(";").length; i++) {
						MisuraDTO m = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misure.split(";")[i]), session);
						listaMisure.add(m);
						
					}
				}
				
				
				session.save(rapporto);
				
				
				
				new CreateRapportoIntervento(listaMisure, rapporto, intervento);
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("rapporto", g.toJsonTree(rapporto));
				out.print(myObj);
				
			}
			else if(action.equals("download")) {
				
				String id_intervento = request.getParameter("id_intervento");
				
				String path = Costanti.PATH_FOLDER+"\\RapportoIntervento\\"+id_intervento+"\\RAPPORTO_INTERVENTO_"+id_intervento+".pdf";
				response.setContentType("application/pdf");	
				response.setHeader("Content-Disposition", "inline; filename=RAPPORTO_INTERVENTO_"+id_intervento+".pdf");
			
					
			
			
			
			Utility.downloadFile(path, response.getOutputStream());
				
				
			}
			
			else if(action.equals("invia_email")) {
				String destinatario = request.getParameter("destinatario");
				
				
				
			}
			
			
			session.getTransaction().commit();
			session.close();
		}catch(Exception e)
    	{
			e.printStackTrace();
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				
	        	
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
