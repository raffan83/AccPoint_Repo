package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

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

/**
 * Servlet implementation class ScaricaPacchettoDirect
 */
@WebServlet(name= "/downloadCalver", urlPatterns = { "/downloadCalver.do" })
public class DownloadCalverDesktop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadCalverDesktop() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
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
		
		String action =  request.getParameter("action");
		if(action.equals("calverdesktop")) {
		 
		  String filename = "DasmTar.jar";
		  
		  response.setHeader("Content-Disposition","attachment;filename="+filename);
			
		     File d = new File(Costanti.PATH_FOLDER_CALVER+filename);
			 
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
		}

		if(action.equals("librerie")) {
			
			String filename = "librerie.zip";
			  
			  response.setHeader("Content-Disposition","attachment;filename="+filename);
				
			     File d = new File(Costanti.PATH_FOLDER_CALVER+filename);
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
//				    copy binary contect to output stream
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			
		}
		if(action.equals("convertitore")) {
			
			String filename = "convertitore.exe";
			  
			  response.setHeader("Content-Disposition","attachment;filename="+filename);
				
			     File d = new File(Costanti.PATH_FOLDER_CALVER+filename);
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
//				    copy binary contect to output stream
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			
		}
			    session.getTransaction().commit();
			    session.close();
	}	
	catch(Exception ex)
	{
		session.getTransaction().rollback();
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);	
	}  

 }
}
