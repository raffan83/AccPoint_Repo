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

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/scaricoPacchettoCampionamento", urlPatterns = { "/scaricoPacchettoCampionamento.do" })

public class ScaricaPachettoCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaPachettoCampionamento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
		
		try{
			
			 CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			 
			 CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			 
			 UtenteDTO utente= (UtenteDTO)request.getSession().getAttribute("userObj");
			 
			 InterventoCampionamentoDTO intervento=(InterventoCampionamentoDTO) request.getSession().getAttribute("interventoCampionamento");
			 
		 	 String filename = intervento.getNomePack();
			
		     File d = new File(Costanti.PATH_FOLDER+filename+"/"+filename+".db");
			 
			 FileInputStream fileIn = new FileInputStream(d);
			 
			 response.setContentType("application/octet-stream");
			  
			 response.setHeader("Content-Disposition","attachment;filename="+filename+".db");
			 
			 ServletOutputStream outp = response.getOutputStream();
			     
			    byte[] outputByte = new byte[1];
			    
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			    }
			    
			    
			    fileIn.close();
			    outp.flush();
			    outp.close();
     	

//				session.getTransaction().commit();
//				session.close();
		}
		catch(Exception ex)
    	{
    		 ex.printStackTrace();
//    		 session.getTransaction().rollback();
//    		 session.close();
    	     request.setAttribute("error",STIException.callException(ex));
       	     request.getSession().setAttribute("exception", ex);
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
    	}  
	}

}
