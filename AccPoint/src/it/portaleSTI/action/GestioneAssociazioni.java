package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="gestioneAssociazioni" , urlPatterns = { "/gestioneAssociazioni.do" })

public class GestioneAssociazioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAssociazioni() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

		
		response.setContentType("text/html");
		
		try 
		{
			CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO user =(UtenteDTO)request.getSession().getAttribute("userObj");
			ArrayList<UtenteDTO> listaUtenti = null;
			if(user.isTras()) {
			 	listaUtenti =  (ArrayList<UtenteDTO>) GestioneAccessoDAO.getListUser();
			}else {
				listaUtenti =  (ArrayList<UtenteDTO>) GestioneAccessoDAO.getListUserPerCompany(company);
			}
			
			ArrayList<PermessoDTO> listaPermessi =  (ArrayList<PermessoDTO>) GestioneAccessoDAO.getListPermission();
			ArrayList<RuoloDTO> listaRuoli =  (ArrayList<RuoloDTO>) GestioneAccessoDAO.getListRole();
			if(!user.checkRuolo("AM")) {
				ArrayList<RuoloDTO> listaRuolinew = new ArrayList<RuoloDTO>();
				for (RuoloDTO ruoloDTO : listaRuoli) {
					if(!ruoloDTO.getDescrizione().equals("AM")) {
						listaRuolinew.add(ruoloDTO);
					}
				}
				request.getSession().setAttribute("listaRuoli",listaRuolinew);
			}else {
				request.getSession().setAttribute("listaRuoli",listaRuoli);
			}
			
	        request.getSession().setAttribute("listaUtenti",listaUtenti);
	        request.getSession().setAttribute("listaPermessi",listaPermessi);


			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneAssociazioni.jsp");
	     	dispatcher.forward(request,response);
		} 
		catch (Exception ex) {
			
		//	ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception",ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
