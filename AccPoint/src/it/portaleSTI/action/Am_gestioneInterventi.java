package it.portaleSTI.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="amGestioneInterventi" , urlPatterns = { "/amGestioneInterventi.do" })

public class Am_gestioneInterventi extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(AMInterventoDTO.class); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Am_gestioneInterventi() {
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
		
//		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
        
		
			 
		try {

			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());

			if(action.equals("lista")) 
			{
			String dateFrom = request.getParameter("dateFrom");
			String dateTo = request.getParameter("dateTo");
			
			if(dateFrom == null && dateTo == null) {
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				
				Date today = new Date();				
				
				
				Calendar cal = Calendar.getInstance();
				
				cal.setTime(today);
				
				dateTo = df.format(cal.getTime());
				
				cal.add(Calendar.DATE, -60);
				Date startDate = cal.getTime();
				
				
				dateFrom = df.format(startDate);					
				
				
			}
		/*	
			if(request.getSession().getAttribute("listaClientiAll")==null) 
			{
				request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
			}	
			
			if(request.getSession().getAttribute("listaSediAll")==null) 
			{				
					request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
			}			
	*/
			List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");

			
			if(listaClienti==null) {
				listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
			}
			
			List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			if(listaSedi== null) {
				listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
			}
			
			
			ArrayList<AMInterventoDTO> lista_interventi = GestioneAM_BO.getListaInterventi(utente, dateFrom, dateTo, session);
			
			CompanyDTO c= new CompanyDTO();
			c.setId(52);
			
			utente.setTrasversale(0);
			
			ArrayList<CommessaDTO> lista_commesse= GestioneCommesseBO.getListaCommesse(c, "", utente, 0, false);			
			
			ArrayList<AMOperatoreDTO> listaOperatori = GestioneAM_BO.getListaOperatoriAll(session);
			
			request.getSession().setAttribute("lista_interventi", lista_interventi);
		//	request.getSession().setAttribute("lista_clienti", listaClienti);				
		//	request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_commesse", lista_commesse);
			request.getSession().setAttribute("lista_operatori", listaOperatori);
			
			request.getSession().setAttribute("dateTo", dateTo);
			request.getSession().setAttribute("dateFrom", dateFrom);
			
			
			session.getTransaction().commit();
			session.close();
			
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_listaInterventi.jsp");
	     	dispatcher.forward(request,response);
	     
		}
			
		} 
		catch(Exception ex)
    	{
			
			
   		 	ex.printStackTrace();
   		 	request.getSession().setAttribute("exception",ex);
   	     	request.setAttribute("error",STIException.callException(ex));
   		 	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     	dispatcher.forward(request,response);	
    	} 
	
	}

}
