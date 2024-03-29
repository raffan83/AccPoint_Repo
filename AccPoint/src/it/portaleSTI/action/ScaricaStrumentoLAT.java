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

import org.apache.log4j.Logger;
import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/scaricoStrumentoLAT", urlPatterns = { "/scaricoStrumentoLAT.do" })

public class ScaricaStrumentoLAT extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ScaricaStrumentoLAT.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaStrumentoLAT() {
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
			
			 CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			 
			 CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			 
			 UtenteDTO utente= (UtenteDTO)request.getSession().getAttribute("userObj");
			 
			 logger.error(Utility.getMemorySpace()+" Action: "+"ScaricaStrumentoLAT" +" - Utente: "+utente.getNominativo());
			 
			 InterventoDTO intervento=(InterventoDTO) request.getSession().getAttribute("intervento");
			 
			 if(comm==null)
			 {
				 comm=GestioneCommesseBO.getCommessaById(intervento.getIdCommessa());
			 }
			 
		 	 String filename = GestioneStrumentoBO.creaPacchettoConNomeLAT(comm.getID_ANAGEN_UTIL(),comm.getK2_ANAGEN_INDR_UTIL(),cmp,comm.getID_ANAGEN_NOME(),session,intervento);
			
		     File d = new File(Costanti.PATH_FOLDER+filename+"/"+"LAT"+filename+".db");
			 
			 FileInputStream fileIn = new FileInputStream(d);
			 
			 response.setContentType("application/octet-stream");
			  
			 response.setHeader("Content-Disposition","attachment;filename="+"LAT"+filename+".db");
			 
			 ServletOutputStream outp = response.getOutputStream();
			     
			    byte[] outputByte = new byte[1];
			    
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			    }
			    
			    
			    fileIn.close();
			    outp.flush();
			    outp.close();
			   
     	
				InterventoDatiDTO intDati = new InterventoDatiDTO();
				intDati.setId_intervento(intervento.getId());
				intDati.setDataCreazione(Utility.getActualDateSQL());
				intDati.setNomePack("LAT"+intervento.getNomePack());
				intDati.setNumStrMis(0);
				intDati.setNumStrNuovi(0);
				intDati.setStato(new StatoPackDTO(2));
				intDati.setUtente(utente);
				
				GestioneInterventoBO.save(intDati,session);
				
				
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
