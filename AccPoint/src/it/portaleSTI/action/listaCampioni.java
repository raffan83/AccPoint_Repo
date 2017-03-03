package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCampioni" , urlPatterns = { "/listaCampioni.do" })

public class listaCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public listaCampioni() {
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
		
		
		if(Utility.checkSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		
		try 
		{
			String myCMP =  request.getParameter("p");
			
			int idCompany;
			
			if(myCMP!=null)
			{
				CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				idCompany=cmp.getId();
			}else
			{
				idCompany=0;
			}
			
			String date =request.getParameter("date");
			ArrayList<CampioneDTO> listaCampioni=new ArrayList<CampioneDTO>();
			if(date==null || date.equals(""))
			{
				listaCampioni =GestioneCampioneDAO.getListaCampioni(null,idCompany);
			}
			else
			{
				if(date.length()>10)
				{
					listaCampioni =GestioneCampioneDAO.getListaCampioni(date.substring(0,10),idCompany);
				}
			}
			
			
			System.out.println("****"+date);
	
			HashMap<Integer, String> company=null;
			HashMap<Integer, String> tipoCampione=null;
			HashMap<Integer, Integer> prenotazioni=null;
			
			if(Utility.checkSession(request.getSession(),"SES_Company"))
			{
				company=(HashMap<Integer, String>)request.getSession().getAttribute("SES_Company");
			}else
			{
				company=GestioneAccessoDAO.getListCompany();
				request.getSession().setAttribute("SES_Company", company);
			}
			
			if(Utility.checkSession(request.getSession(),"SES_Tipo_Campione"))
			{
				tipoCampione=(HashMap<Integer, String>)request.getSession().getAttribute("SES_Tipo_Campione");
			}else
			{
				tipoCampione=GestioneTLDAO.getListTipoCampione();
				request.getSession().setAttribute("SES_Tipo_Campione", tipoCampione);
			}
			
			if(Utility.checkSession(request.getSession(),"SES_Prenotazioni"))
			{
				prenotazioni=(HashMap<Integer, Integer>)request.getSession().getAttribute("SES_Prenotazioni");
			}else
			{
				prenotazioni=GestioneCampioneDAO.getListPrenotazioni();
				request.getSession().setAttribute("SES_Prenotazioni", prenotazioni);
			}
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			for (int i=0;i<listaCampioni.size();i++)
			{
				listaCampioni.get(i).setProprietario(company.get(listaCampioni.get(i).getIdCompany()));
				listaCampioni.get(i).setUtilizzatore(company.get(listaCampioni.get(i).getId_company_utilizzatore()));
				listaCampioni.get(i).setTipoCampione(tipoCampione.get(listaCampioni.get(i).getId_tipo_campione()));
				listaCampioni.get(i).setStatoPrenotazione(""+prenotazioni.get(listaCampioni.get(i).getId()));
			
			}
			
			request.getSession().setAttribute("listaCampioni",listaCampioni);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioni.jsp");
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
