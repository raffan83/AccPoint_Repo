package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class GestioneTipoStrumento
 */
@WebServlet("/gestioneTipoStrumento.do")
public class GestioneTipoStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneTipoStrumento() {
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
			
			ArrayList<TipoGrandezzaDTO> lista_tipo_grandezza = GestioneTLDAO.getListaTipoGrandezza();
			ArrayList<TipoStrumentoDTO> lista_tipo_strumento = GestioneTLDAO.getListaTipoStrumento();
			
			Gson gson = new Gson();			
		
			request.getSession().setAttribute("lista_tipo_grandezza", lista_tipo_grandezza);
			request.getSession().setAttribute("lista_tipo_strumento", lista_tipo_strumento);	
			request.getSession().setAttribute("lista_tipo_strumento_json", gson.toJsonTree(lista_tipo_strumento));
			
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneTipoStrumento.jsp");
	  	    dispatcher.forward(request,response);
		}
		else if(action.equals("nuovo")) {			
			
			ajax = true;			
			
			String descrizione = request.getParameter("descrizione");
			String ids =request.getParameter("ids");
			
			TipoStrumentoDTO tipo_strumento = new TipoStrumentoDTO();
			
			tipo_strumento.setNome(descrizione);
			tipo_strumento.setId_codice_accredia(0);						
			
			session.save(tipo_strumento);
			
			String[] id = ids.split(";");
			session.getTransaction().commit();
			
			for (String string : id) {
				DirectMySqlDAO.insertTipoStrumentoTipoGrandezzaDirect(Integer.parseInt(string), tipo_strumento.getId());
			}
			
			session.close();		
			myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Tipo strumento salvato con successo!");
			out.print(myObj);
			
			
		}
		else if(action.equals("grandezze_tipo_strumento")){
			
			String id_tipo_strimento = request.getParameter("id_tipo_strumento");
			
			ArrayList<Integer> lista_grandezze_tipo_strumento = DirectMySqlDAO.getGrandezzeFromTipoStrumento(Integer.parseInt(id_tipo_strimento));
		
			request.getSession().setAttribute("lista_grandezze_tipo", lista_grandezze_tipo_strumento);
						
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/tabGrandezzePerTipoStrumento.jsp");
	  	    dispatcher.forward(request,response);
			
		}
		else if(action.equals("aggiungi")) {			
			
			ajax = true;			
			
			String id_tipo_strumento = request.getParameter("id_tipo_strumento");
			String ids =request.getParameter("ids");
						
			String[] id = ids.split(";");
			session.getTransaction().commit();
			
			for (String string : id) {
				DirectMySqlDAO.insertTipoStrumentoTipoGrandezzaDirect(Integer.parseInt(string), Integer.parseInt(id_tipo_strumento));
			}
			
			session.close();		
			myObj = new JsonObject();
			PrintWriter  out = response.getWriter();
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Operazione completata con successo!");
			out.print(myObj);
			
			
		}
			
			
			
		}catch (Exception e) {
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
