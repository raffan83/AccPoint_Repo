package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.Util.Utility;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

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

public class ListaCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCampioni() {
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
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			request.getSession().setAttribute("listaCampioni",listaCampioni);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioni.jsp");
	     	dispatcher.forward(request,response);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}
