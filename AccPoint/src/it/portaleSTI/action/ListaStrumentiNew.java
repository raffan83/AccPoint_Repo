package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ListaStrumentiNew
 */
@WebServlet(name = "listaStrumentiNew", urlPatterns = { "/listaStrumentiNew.do" })
public class ListaStrumentiNew extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumentiNew() {
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
		 
		String action = request.getParameter("action");
		try {
			if(action==null || action.equals("")) {
				CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
	
				String idCompany=""+cmp.getId();
				
				List<ClienteDTO> listaClientiFull = GestioneAnagraficaRemotaBO.getListaClienti(idCompany);
				
				List<ClienteDTO> listaClientiCS = new ArrayList<ClienteDTO>();
				
				HashMap<Integer,Integer> listaClientiConStrumenti=DirectMySqlDAO.getListaClientiConStrumenti();
				
				for (ClienteDTO clienteDTO : listaClientiFull) {
					
					if(listaClientiConStrumenti.containsKey(clienteDTO.get__id())) 
					{
						listaClientiCS.add(clienteDTO);
					}
				}
				
	//			ArrayList<Integer> clientiIds = GestioneStrumentoBO.getListaClientiStrumenti();
	//			
	//			List<ClienteDTO> listaClienti = new ArrayList<ClienteDTO>();
	//			for (ClienteDTO cliente : listaClientiFull) {
	// 				if(clientiIds.contains(cliente.get__id())) {
	//					listaClienti.add(cliente);
	//				}
	//			}
				request.getSession().setAttribute("listaClienti",listaClientiCS);
				
				
				
				List<SedeDTO> listaSediFull = GestioneAnagraficaRemotaBO.getListaSedi();
				
	//			ArrayList<Integer> sediIds = GestioneStrumentoBO.getListaSediStrumenti();
	//			
	//			List<SedeDTO> listaSedi = new ArrayList<SedeDTO>();
	//			for (SedeDTO sede : listaSediFull) {
	// 				if(sediIds.contains(sede.get__id())) {
	//					listaSedi.add(sede);
	//				}
	//			}
				request.getSession().setAttribute("listaSedi",listaSediFull);
				
				ArrayList<StrumentoDTO> strumenti= new ArrayList<StrumentoDTO>();
				request.getSession().setAttribute("listaStrumenti",strumenti);
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiNEW.jsp");
		     	dispatcher.forward(request,response);
			}

		}
		catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception", ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
     	
	}

}
