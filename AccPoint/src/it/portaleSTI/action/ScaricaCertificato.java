package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCertificatoBO;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

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
	
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("static-access")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();	
		
	
		
		try
		{
			
			
			String action=request.getParameter("action");
			
			
			if(action.equals("certificatoCampione"))
			{
			String idCampione= request.getParameter("idC");
			 	
			 	CampioneDTO campione= GestioneCampioneDAO.getCampioneFromId(idCampione);
			   
			 	
			 	if(campione!=null && campione.getCertificatoCorrente(campione.getListaCertificatiCampione())!=null)
			 	{
				
			     File d = new File(Costanti.PATH_FOLDER+"//Campioni//"+campione.getId()+"/"+campione.getCertificatoCorrente(campione.getListaCertificatiCampione()).getFilename());
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/octet-stream");
				 
				 response.setHeader("Content-Disposition","attachment;filename="+campione.getCertificatoCorrente(campione.getListaCertificatiCampione()).getFilename());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			 	}
			}
			if(action.equals("certificatoStrumento"))
			{
				
				String filename= request.getParameter("nome");
			 	String pack= request.getParameter("pack");

			     File d = new File(Costanti.PATH_FOLDER+pack+"/"+filename);
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/pdf");
				 
			//	 response.setHeader("Content-Disposition","attachment;filename="+filename);
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			}
			if(action.equals("certificatoStrumentoFirmato"))
			{
				
				String filename= request.getParameter("nome");
			 	String pack= request.getParameter("pack");

			     File d = new File(Costanti.PATH_FOLDER+pack+"/"+filename+".p7m");
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/pdf");
				 
			//	 response.setHeader("Content-Disposition","attachment;filename="+filename);
				 response.setHeader("Content-Disposition","attachment;filename="+filename+".p7m");

				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			}
			if(action.equals("certificatoCampioneDettaglio"))
			{
				
				String idCert= request.getParameter("idCert");

			 	
				CertificatoCampioneDTO certificatoCampione=GestioneCampioneDAO.getCertifiactoCampioneById(idCert);
				
				
			     File d = new File(Costanti.PATH_FOLDER_CAMPIONI+certificatoCampione.getId_campione()+"/"+certificatoCampione.getFilename());
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/octet-stream");
				 
				 response.setHeader("Content-Disposition","attachment;filename="+certificatoCampione.getFilename());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			}
			if(action.equals("eliminaCertificatoCampione"))
			{
				
				JsonObject jsono = new JsonObject();
				PrintWriter writer = response.getWriter();
				
				String idCert= request.getParameter("idCert");
				

				CertificatoCampioneDTO certificato =GestioneCampioneDAO.getCertifiactoCampioneById(idCert);
				
				certificato.setObsoleto("S");
				
				
				GestioneCampioneDAO.updateCertificatoCampione(certificato, session);
				
				jsono.addProperty("success", true);
				jsono.addProperty("messaggio", "Certificato eliminato correttamente");
				
				writer.write(jsono.toString());
				writer.close();
				
				
				session.getTransaction().commit();
				session.close();
			}
		
			
		
		}
		catch(Exception ex)
    	{
			
   		 ex.printStackTrace();
   		 session.getTransaction().rollback();
   		 session.close();
   		 
   	//	 jsono.addProperty("success", false);
   	//	 jsono.addProperty("messaggio",ex.getMessage());
		
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception", ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
