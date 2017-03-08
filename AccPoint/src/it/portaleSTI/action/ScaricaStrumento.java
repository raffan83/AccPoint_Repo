package it.portaleSTI.action;

import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneListaStrumenti;

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
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/scaricoStrumento", urlPatterns = { "/scaricoStrumento.do" })

public class ScaricaStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaStrumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		response.setContentType("application/octet-stream");
		
		try{
		
		 String[] listaCheck= request.getParameterValues("chk");
		 
		 String idSede=(String)request.getSession().getAttribute("sede");
		 
	//	 listaCheck= new String[2];
	//	 listaCheck[0]="13925";  /*cod int 782*/
	//	 listaCheck[0]="18143";
	//	 listaCheck[1]="16558";
	//	 listaCheck[3]="15017";
		 
	//	 idSede="6913";
	String filename=	 GestioneListaStrumenti.creaPacchetto(listaCheck,idSede);
		  
		  response.setHeader("Content-Disposition","attachment;filename="+filename+".zip");
			
		     File d = new File(Costanti.PATH_FOLDER+"\\"+filename+".zip");
			 
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
		catch(Exception ex)
    	{
    		 ex.printStackTrace();
    	     request.setAttribute("error",STIException.callException(ex));
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
    	}  
	}

}
