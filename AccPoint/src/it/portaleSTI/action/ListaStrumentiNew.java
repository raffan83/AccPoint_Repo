package it.portaleSTI.action;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import it.portaleSTI.bo.ServiceBO;

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
				
				List<ClienteDTO> listaClientiCS = (List<ClienteDTO>)request.getSession().getAttribute("listaClientiStr");
				List<ClienteDTO> listaClientiFull = (List<ClienteDTO>)request.getSession().getAttribute("listaClientiFull");

				 HashMap<Integer,String> encrypt = ServiceBO.getHashEncrypt();
				 
				
				listaClientiFull = GestioneStrumentoBO.getListaClientiFull(listaClientiFull, encrypt, idCompany); 
				
				listaClientiCS = GestioneStrumentoBO.getClienteWithStrumento(listaClientiFull, listaClientiCS, encrypt);
				

				request.getSession().setAttribute("listaClientiFull",listaClientiFull);
				request.getSession().setAttribute("listaClientiStr",listaClientiCS);
				
				
				
				
				List<SedeDTO> listaSediFull = (List<SedeDTO>)request.getSession().getAttribute("listaSediStrumenti");	
				listaSediFull = GestioneStrumentoBO.getListaSedifull(listaSediFull, encrypt);
				
				request.getSession().setAttribute("listaSediStrumenti",listaSediFull);
				
				
				
				ArrayList<StrumentoDTO> strumenti= new ArrayList<StrumentoDTO>();
				request.getSession().setAttribute("listaStrumenti",strumenti);
				
				request.getSession().setAttribute("non_associate_encrypt",Utility.encryptData("0"));
			
				
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
