package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaConsegnaMetrologia;
import it.portaleSTI.bo.CreateSchedaListaCampioni;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.Session;

import com.google.gson.JsonObject;

/**
 * Servlet implementation class ScaricaCertificato
 */
@WebServlet(name= "/scaricaListaCampioni", urlPatterns = { "/scaricaListaCampioni.do" })
public class ScaricaListaCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaListaCampioni() {
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
			
			

			String idIntervento= request.getParameter("idIntervento");
			String notaConsegna= request.getParameter("notaConsegna");
			String corteseAttenzione= request.getParameter("corteseAttenzione");
			String stato= request.getParameter("gridRadios");
			
			InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento);
			
			ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureByIntervento(intervento.getId());
			ArrayList<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();
			
			for (MisuraDTO misura : listaMisure) {
				List<CampioneDTO> listaCampioniMisura = GestioneMisuraBO.getListaCampioni(misura.getListaPunti());
				listaCampioni.addAll(listaCampioniMisura);
			}
			
			
			
			new CreateSchedaListaCampioni(intervento,listaCampioni,session,getServletContext());
	
			File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//SchedaListacampioni.pdf");
			
			
			PDFMergerUtility ut = new PDFMergerUtility();
			ut.addSource(d);
			
			for (CampioneDTO campioneDTO : listaCampioni) {
				
				CertificatoCampioneDTO certificato = campioneDTO.getCertificatoCorrente(campioneDTO.getListaCertificatiCampione());
				if(certificato != null) {
					String folder = Costanti.PATH_FOLDER+"//Campioni//"+campioneDTO.getId()+"//"+certificato.getFilename();
					File x = new File(folder);
					if(x.exists() && !x.isDirectory()) {
						ut.addSource(x);
					}
				}
			}
			
			ut.setDestinationFileName(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//SchedaListacampioniCertificati.pdf");
			ut.mergeDocuments(MemoryUsageSetting.setupMainMemoryOnly());
			
			
			
			
			File output = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//SchedaListacampioniCertificati.pdf");
			
			 FileInputStream fileIn = new FileInputStream(output);
			 
			 response.setContentType("application/octet-stream");
			  
			 response.setHeader("Content-Disposition","attachment;filename=SchedaListacampioniCertificati.pdf");
			 
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
		catch(Exception ex)
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