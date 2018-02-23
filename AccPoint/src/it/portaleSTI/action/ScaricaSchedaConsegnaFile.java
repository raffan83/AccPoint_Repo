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
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;

/**
 * Servlet implementation class ScaricaSchedaConsegnaFile
 */
@WebServlet("/scaricaSchedaConsegnaFile.do")
public class ScaricaSchedaConsegnaFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaSchedaConsegnaFile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();	
		
		try
		{
		String idIntervento= request.getParameter("idIntervento");
		String nomeFile = request.getParameter("nomefile");
		InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento);
		
		File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//"+nomeFile);
		
		FileInputStream fileIn = new FileInputStream(d);
		 
		 response.setContentType("application/octet-stream");
		  
		 response.setHeader("Content-Disposition","attachment;filename=SchedaDiConsegna.pdf");
		 
		 ServletOutputStream outp = response.getOutputStream();
		     
		    byte[] outputByte = new byte[1];
		    
		    while(fileIn.read(outputByte, 0, 1) != -1)
		    {
		    	outp.write(outputByte, 0, 1);
		    }
		    
		    
		    fileIn.close();
		    outp.flush();
		    outp.close();
		}catch(Exception ex)
    	{
			
	   		 ex.printStackTrace();
	   		 session.getTransaction().rollback();
	   		 session.close();
	   		 
	   	//	 jsono.addProperty("success", false);
	   	//	 jsono.addProperty("messaggio",ex.getMessage());
			
	   	     request.setAttribute("error",STIException.callException(ex));
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
			
		}
	}

}
