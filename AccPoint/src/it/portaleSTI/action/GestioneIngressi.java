package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;

/**
 * Servlet implementation class GestioneIngressi
 */
@WebServlet("/gestioneIngressi.do")
public class GestioneIngressi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneIngressi() {
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
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("ingresso")) {
				
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIngressi.jsp");
		     	dispatcher.forward(request,response);	
				
			}
			else if(action.equals("tipo_ingresso")) {
				
				
//			  	List<FileItem> items = null;
//		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {
//
//		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
//		        	}		        
//		       
//				FileItem fileItem = null;
//				String filename= null;
//		        Hashtable<String,String> ret = new Hashtable<String,String>();
//		      
//		        for (FileItem item : items) {
//	            	 if (!item.isFormField()) {
//	            		
//	                     fileItem = item;
//	                     filename = item.getName();
//	                     
//	            	 }else
//	            	 {
//	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
//	            	 }
//	            	
//	            }
		
				String tipo = request.getParameter("tipoIngresso");
				if(tipo.equals("tipo_1")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIngressiTipo1.jsp");
			     	dispatcher.forward(request,response);	
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIngressiTipo2.jsp");
			     	dispatcher.forward(request,response);	
				}
			
				
				
			}
			
			session.getTransaction().commit();
			session.close();
			
			
		}catch(Exception e) {
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
