package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ScaricaPacchettoDirect
 */
@WebServlet(name= "/scaricoPacchettoDirect", urlPatterns = { "/scaricoPacchettoDirect.do" })
public class ScaricaPacchettoDirect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaPacchettoDirect() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	if(Utility.validateSession(request,response,getServletContext()))return;
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		response.setContentType("application/octet-stream");
		
		try{
		
		 String idC= request.getParameter("idC");
		 
		 String idS= request.getParameter("idS");
		 
		 String nomeSede= request.getParameter("nomeSede");
		 
		 String nomeCliente= request.getParameter("nomeCliente");
		 
		 CompanyDTO cmp =(CompanyDTO) request.getSession().getAttribute("usrCompany");
		 
		 if(idS!=null && !idS.equals("null") && !idS.equals("") )
		 {
		  idS=idS.split("_")[0];
		 }
		 else
		 {
			 idS="0";
		 }

		 InterventoDTO intervento = new InterventoDTO();
		 intervento.setNome_sede(nomeSede);
		 
		 String filename = GestioneStrumentoBO.creaPacchetto(Integer.parseInt(idC),Integer.parseInt(idS),cmp,nomeCliente,session,intervento);
		  
		 response.setHeader("Content-Disposition","attachment;filename="+filename+".db");
			
		     File d = new File(Costanti.PATH_FOLDER+"\\"+filename+"\\"+filename+".db");
			 
			 FileInputStream fileIn = new FileInputStream(d);
			 
			 ServletOutputStream outp = response.getOutputStream();
			     
			    byte[] outputByte = new byte[1];
//			    copy binary contect to output stream
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			     }
			    
			    
			    fileIn.close();
		
			    outp.flush();
			    outp.close();
	
			    session.getTransaction().commit();
			    session.close();
	}	
	catch(Exception ex)
	{
		session.getTransaction().rollback();
		session.close();
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception", ex);
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);	
	}  

 }
}
