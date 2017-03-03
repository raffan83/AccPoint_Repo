package it.portaleSTI.action;

import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

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

/**
 * Servlet implementation class ScaricaCertificato
 */
@WebServlet(name= "/scaricaCertificato", urlPatterns = { "/scaricaCertificato.do" })
public class ScaricaCertificato extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaCertificato() {
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
		
		try
		{
		response.setContentType("application/octet-stream");
		File file=new File("C://Test.pdf");

		
		response.setHeader("Content-disposition","attachment;filename=\"Certificato.pdf\" ");
		
		FileInputStream fileIn = new FileInputStream(file);
		 
		 ServletOutputStream outp = response.getOutputStream();
		     
		    byte[] outputByte = new byte[1];
//		    copy binary contect to output stream
		    while(fileIn.read(outputByte, 0, 1) != -1)
		     {
		    	outp.write(outputByte, 0, 1);
		     }
		    
		    fileIn.close();
		    outp.flush();
		    outp.close();
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
