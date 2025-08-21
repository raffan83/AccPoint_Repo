package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneFormazioneBO;

/**
 * Servlet implementation class DownloadAttestatiFormazione
 */
@WebServlet("/downloadAttestatiFormazione.do")
public class DownloadAttestatiFormazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadAttestatiFormazione() {
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
	
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			if(action == null) {
				
		
				String id_corso = request.getParameter("id_corso");
				
				id_corso = Utility.decryptData(id_corso);
				
				ForCorsoDTO corso = DirectMySqlDAO.getCorsoFromIdDirect(Integer.parseInt(id_corso));
				
				request.getSession().setAttribute("corso", corso);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/downloadAttestatiFormazione.jsp");
		     	dispatcher.forward(request,response);
			
				
			}
			else if(action.equals("check_cf")) {
				ajax = true;
				String cf = request.getParameter("cf");
				
				ForCorsoDTO corso = (ForCorsoDTO) request.getSession().getAttribute("corso");
				
				ForPartecipanteRuoloCorsoDTO partecipante = DirectMySqlDAO.getAttestato(cf, corso.getId());
				PrintWriter out = response.getWriter();
				
				if (partecipante != null) {
				
					request.getSession().setAttribute("partecipante", partecipante);
		        	myObj.addProperty("success", true);
		        	out.print(myObj);
				}else {
					myObj.addProperty("success", false);
		        	out.print(myObj);
				}
			}
			
			else if(action.equals("download")) {
				
				
				
				String cf = request.getParameter("cf");
				ForCorsoDTO corso = (ForCorsoDTO) request.getSession().getAttribute("corso");
				
				//ForPartecipanteRuoloCorsoDTO partecipante = DirectMySqlDAO.getAttestato(cf, corso.getId());
				
				ForPartecipanteRuoloCorsoDTO partecipante =(ForPartecipanteRuoloCorsoDTO) request.getSession().getAttribute("partecipante");
				
				String path = Costanti.PATH_FOLDER+"//Formazione//Attestati//"+corso.getId()+"//"+partecipante.getPartecipante().getId()+"//"+partecipante.getAttestato();
				response.setContentType("application/octet-stream");	
				response.setHeader("Content-Disposition","attachment;filename="+cf+".pdf");
				
				Utility.downloadFile(path, response.getOutputStream());
				
				
				
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
			
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
