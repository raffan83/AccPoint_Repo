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

import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/scaricoPackGenerato", urlPatterns = { "/scaricoPackGenerato.do" })

public class ScaricaPackGenerato extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaPackGenerato() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try{
			
			 String filename=(String)request.getParameter("filename");
			 
			 String ext1 = FilenameUtils.getExtension(filename);
			 
			 File d=null;
			 
			 if(ext1.equals("xls") || ext1.equals("xlsx")) 
			 {
				 String[] filnames = filename.split("_");			
			     d = new File(Costanti.PATH_FOLDER+filnames[0]+"/"+filename);
			 }
			 else 
			 {
				 String[] filnames = filename.split("_");
				 if(filnames[0].startsWith("LAT")) 
				 {
					 filnames[0]=filnames[0].substring(3, filnames[0].length());
				 }
				 filename=filename+".db";
			     d = new File(Costanti.PATH_FOLDER+filnames[0]+"/"+filename);
			 }
			 
		
			 
			 FileInputStream fileIn = new FileInputStream(d);
			 
			 response.setContentType("application/octet-stream");
			  
			 response.setHeader("Content-Disposition","attachment;filename="+filename);
			 
			 ServletOutputStream outp = response.getOutputStream();
			     
			    byte[] outputByte = new byte[1];
			    
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
    		 ex.printStackTrace();
    		 session.getTransaction().rollback();
    		 session.close();
    	     request.setAttribute("error",STIException.callException(ex));
       	     request.getSession().setAttribute("exception", ex);
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
    	}  
	}

}
