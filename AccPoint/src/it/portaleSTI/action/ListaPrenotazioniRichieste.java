package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListaPrenotazioniRichieste
 */
@WebServlet(name = "listaPrenotazioniRichieste", urlPatterns = { "/listaPrenotazioniRichieste.do" })

public class ListaPrenotazioniRichieste extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPrenotazioniRichieste() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		
		try {
			
			HashMap<Integer, String> company=null;
			HashMap<Integer, String> user=null;
			HashMap<Integer, String> statoPrenotazione=null;
			
			if(Utility.checkSession(request.getSession(),"SES_Company"))
			{
				company=(HashMap<Integer, String>)request.getSession().getAttribute("SES_Company");
			}else
			{
				company=GestioneAccessoDAO.getListCompany();
				request.getSession().setAttribute("SES_Company", company);
			}
			
			if(Utility.checkSession(request.getSession(),"SES_User"))
			{
				user=(HashMap<Integer, String>)request.getSession().getAttribute("SES_User");
			}else
			{
				user=GestioneAccessoDAO.getListUser();
				request.getSession().setAttribute("SES_User", user);
			}
			
			if(Utility.checkSession(request.getSession(),"SES_StatoPrenotazione"))
			{
				statoPrenotazione=(HashMap<Integer, String>)request.getSession().getAttribute("SES_StatoPrenotazione");
			}else
			{
				statoPrenotazione=GestioneTLDAO.getListStatoPrenotazione();
				request.getSession().setAttribute("SES_StatoPrenotazione", statoPrenotazione);
			}
			
			int myId=((CompanyDTO)request.getSession().getAttribute("usrCompany")).getId();
			
			ArrayList<PrenotazioneDTO> listaPrenotazioni =GestionePrenotazioniBO.getListaPrenotazioniRichieste(myId);
			
			for (int i = 0; i < listaPrenotazioni.size(); i++) 
			{
				listaPrenotazioni.get(i).setNomeCompanyProprietario(company.get(listaPrenotazioni.get(i).getId_company()));
				listaPrenotazioni.get(i).setNomeCompanyRichiedente(company.get(listaPrenotazioni.get(i).getId_companyRichiedente()));
				listaPrenotazioni.get(i).setNomeUtenteRichiesta(user.get(listaPrenotazioni.get(i).getId_userRichiedente()));
				listaPrenotazioni.get(i).setDescrizioneStatoPrenotazione(statoPrenotazione.get(listaPrenotazioni.get(i).getStato()));
				
			}
			
			request.getSession().setAttribute("listaPrenotazioni",listaPrenotazioni);
			 
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPrenotazioniRichieste.jsp");
			dispatcher.forward(request,response);	
			
			
		} 
		
		catch(Exception ex)
    	{
    		 ex.printStackTrace();
    	     request.setAttribute("error",STIException.callException(ex));
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
    	}  
	}

}
