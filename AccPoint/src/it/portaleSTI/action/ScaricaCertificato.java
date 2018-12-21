package it.portaleSTI.action;

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

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

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
		JsonObject myObj = new JsonObject();
		
		boolean ajax = false;
	
		
		try
		{
			
			
			String action=request.getParameter("action");
			
			
			if(action.equals("certificatoCampione"))
			{
				ajax = false;
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
				    
				    
				    
				    session.close();
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			 	}
			}
			if(action.equals("certificatoStrumento"))
			{
				ajax = false;
				String filename= request.getParameter("nome");
			 	String pack= request.getParameter("pack");

			 	filename = Utility.decryptData(filename);
			 	pack = Utility.decryptData(pack);
			 	
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
				    
				    
				    session.close();
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			}
			if(action.equals("certificatoStrumentoFirmato"))
			{
				
				String filename= request.getParameter("nome");
			 	String pack= request.getParameter("pack");

			 	filename = Utility.decryptData(filename);
			 	pack = Utility.decryptData(pack);
			 	
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
				    
				    session.close();
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			}
			if(action.equals("certificatoCampioneDettaglio"))
			{
				ajax= false;
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
				    
				    session.close();
				    fileIn.close();
			
				    outp.flush();
				    outp.close();
			}
			if(action.equals("eliminaCertificatoCampione"))
			{
				ajax = true;
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
			if(action.equals("upload_allegato")) {
				
				ajax = true;				
				PrintWriter  out = response.getWriter();
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());				
				response.setContentType("application/json");
			
			//	String id_pacco = request.getParameter("id_pacco");
				String id_misura = request.getParameter("id_misura");
				String pack = request.getParameter("pack");
				String note = "";				
				String filename = "";
				MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misura));
				List<FileItem> items;
				
					items = uploadHandler.parseRequest(request);
					
					for (FileItem item : items) {
						if (item.isFormField()) {
							if(item.getFieldName().equals("note_allegato")) {
								note = item.getString();
								misura.setNote_allegato(note);
							}							
						}else {
							if(item.getName()!="") {
								GestioneMisuraBO.uploadAllegatoPdf(item, pack, id_misura);
								filename = item.getName();
								misura.setFile_allegato(filename);
							}		
						}
					}
					
					
				
					session.update(misura);
					session.getTransaction().commit();
					session.close();			
					
					myObj.addProperty("success", true);					
					myObj.addProperty("messaggio", "Allegato caricato con successo!");
					
					
					ArrayList<MisuraDTO> listaMisure = GestioneStrumentoBO.getListaMisureByStrumento(misura.getStrumento().get__id());
					request.getSession().setAttribute("listaMisure", listaMisure);
					myObj.addProperty("id_strumento", misura.getStrumento().get__id());
					out.print(myObj);			
		}
			if(action.equals("download_allegato")) {
				
				ajax = false;
				String id_misura= request.getParameter("id_misura");
				id_misura = Utility.decryptData(id_misura);
				
				MisuraDTO misura = GestioneMisuraDAO.getMisuraByID(Integer.parseInt(id_misura), session);
				
				String path = Costanti.PATH_FOLDER+misura.getIntervento().getNomePack()+"\\"+id_misura+"\\Allegati\\" + misura.getFile_allegato();
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 //response.setContentType("application/octet-stream");
				 
				 response.setContentType("application/pdf");
				 //response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			
			if(action.equals("elimina_allegato")) {
				ajax = true;
				PrintWriter  out = response.getWriter();
				String id_misura= request.getParameter("id_misura");
				String id_strumento = request.getParameter("id_strumento");
				
				GestioneMisuraBO.eliminaAllegato(Integer.parseInt(id_misura), session);
				session.getTransaction().commit();
				ArrayList<MisuraDTO> listaMisure = GestioneStrumentoBO.getListaMisureByStrumento(Integer.parseInt(id_strumento));						
				session.close();
				
				request.getSession().setAttribute("listaMisure", listaMisure);
				
				myObj.addProperty("id_strumento", Integer.parseInt(id_strumento));
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
			}
		
		
		}
		catch(Exception ex)
    	{
			PrintWriter  out = response.getWriter();
			if(ajax) {
				ex.printStackTrace();
				session.getTransaction().rollback();
				session.close();
				request.getSession().setAttribute("exception", ex);
				myObj = STIException.getException(ex);
				out.print(myObj);
			}else {
				
			
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
		

}
	
