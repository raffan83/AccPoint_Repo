package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.IngIngressoDTO;
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
				
		
				String tipo = request.getParameter("tipoIngresso");
				if(tipo.equals("tipo_1")) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIngressiTipo1.jsp");
			     	dispatcher.forward(request,response);	
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIngressiTipo2.jsp");
			     	dispatcher.forward(request,response);	
				}
			
				
				
			}
			else if(action.equals("salva")) {
				
				
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
		        
		        
		        String nominativo = ret.get("nominativo");
		        String targa = ret.get("targa");
		        String tipo_merce = ret.get("tipo_merce");
		        String tipo_registrazione = ret.get("tipo_registrazione");
		        String nome_ditta = ret.get("nome_ditta");
		        String data_ingresso = ret.get("data_ingresso");
		        String data_uscita = ret.get("data_uscita");		        
		        String id_reparto = ret.get("reparto");
		        String modalita_ingresso = ret.get("modalita_ingresso");		        
		        String telefono = ret.get("telefono");
		        String id_area = ret.get("area");
		        
		        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		        
		        IngIngressoDTO ingresso = new IngIngressoDTO();
		        ingresso.setNominativo(nominativo);
		        ingresso.setTarga(targa);
		        if(tipo_merce!=null && !tipo_merce.equals("")) {
		        	  ingresso.setTipo_merce(Integer.parseInt(tipo_merce));
		        }
		      
		        if(tipo_registrazione!=null && !tipo_registrazione.equals("")) {
		        	 ingresso.setTipo_registrazione(Integer.parseInt(tipo_registrazione));
		        }
		       
		        ingresso.setNome_ditta(nome_ditta);
		        if(data_ingresso!=null && !data_ingresso.equals("")) {
		        	ingresso.setData_ingresso(df.parse(data_ingresso));
		        }
		        
		        if(data_uscita!=null && !data_uscita.equals("")) {
		        	ingresso.setData_uscita(df.parse(data_uscita));
		        }
		        
		        if(id_reparto!=null && !id_reparto.equals("")) {
		        	ingresso.setId_reparto(Integer.parseInt(id_reparto));
		        }
		        
		        if(modalita_ingresso!=null && !modalita_ingresso.equals("")) {
		        	ingresso.setModalita_ingresso(Integer.parseInt(modalita_ingresso));
		        }
		        
		        ingresso.setTelefono(telefono);
		        if(id_area!=null && !id_area.equals("")) {
		        	ingresso.setId_area(Integer.parseInt(id_area));
		        }
		        
		        DirectMySqlDAO.saveIngresso(ingresso);
		        
		        response.setContentType("application/json");
		        PrintWriter out = response.getWriter();
		        
		        
		        myObj.addProperty("messaggio", "Salvato con successo");
		        myObj.addProperty("success", true);
	        	out.print(myObj);
		        
				
			}
			
			else if(action.equals("lista_ingressi")) {
				
				ArrayList<IngIngressoDTO> lista_ingressi = DirectMySqlDAO.getListaIngressi();


				request.getSession().setAttribute("lista_ingressi", lista_ingressi);
			
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaIngressi.jsp");
			    dispatcher.forward(request,response);	
			
			
				
				
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
