package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.util.List;

import javax.activation.DataHandler;
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
import org.apache.commons.io.FileUtils;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.arubapec.arubasignservice.ArubaSignServiceServiceStub;
import it.arubapec.arubasignservice.TypeOfTransportNotImplementedException;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Auth;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2E;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2ResponseE;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.SignRequestV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.TypeTransport;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class FirmaDocumento
 */
@WebServlet("/firmaDocumento.do")
public class FirmaDocumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FirmaDocumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		if(Utility.validateSession(request,response,getServletContext()))return;
		
		String action = request.getParameter("action");
		JsonObject jsono = new JsonObject();
		boolean ajax = false;
		try {
			
			if(action==null || action.equals("")) {
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/firmaDocumento.jsp");
			     dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("upload")) {
				ajax=true;
				File folder = new File(Costanti.PATH_FIRMA_DIGITALE);
				FileUtils.cleanDirectory(folder); 
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				
				response.setContentType("application/json");
				PrintWriter writer = response.getWriter();
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {

						
						uploadPdf(item);
											
						jsono.addProperty("success", true);
						jsono.addProperty("filename", item.getName());
					}
			
				}
				
			writer.write(jsono.toString());			
				writer.close();
				
				
			}
			else if(action.equals("checkPIN")) {
				ajax = true;
				String pin = request.getParameter("pin");
				
				response.setContentType("application/json");
				PrintWriter writer = response.getWriter();
				Session session=SessionFacotryDAO.get().openSession();
				session.beginTransaction();
				
				UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
				
				UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);
				
				boolean esito = GestioneUtenteBO.checkPINFirma(utente_firma.getId(),pin, session);
				if(esito) {
					jsono.addProperty("success", true);
					
				}else {
					jsono.addProperty("success", false);
					jsono.addProperty("messaggio", "Attenzione! PIN errato!");
					jsono.addProperty("num_error", 1);
				}
				
				writer.write(jsono.toString());			
				writer.close();
			}
			
			else if(action.equals("firma")) {
				ajax=true;
			
				String filename = request.getParameter("filename");
				Session session=SessionFacotryDAO.get().openSession();
				session.beginTransaction();
				
				UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
				
				UtenteDTO utente_firma = GestioneUtenteBO.getUtenteById(String.valueOf(utente.getId()), session);	
		
				PrintWriter writer = response.getWriter();
				
				jsono = sign(utente_firma.getIdFirma(), filename);

				session.getTransaction().commit();
				session.close();
				writer.print(jsono);
				
				}
			
			
			else if(action.equals("download")) {
				ajax=false;
				
				String filename = request.getParameter("filename");
				downloadDocumentoFirmato(request, response, filename);
				
			}

		}catch(Exception e) {
			
			if(ajax) {
			
				 e.printStackTrace();
				 request.getSession().setAttribute("exception", e);
				 jsono = STIException.getException(e);
				 PrintWriter writer = response.getWriter();
				writer.print(jsono);
				
			}else {
			 e.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(e));
	   	     
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);
			}
		}
		
	}

	
	
	
	public static void uploadPdf(FileItem item) throws Exception {
		
		
		File file = new File(Costanti.PATH_FIRMA_DIGITALE+ item.getName());
		
		while(true) {

			
					item.write(file);
					
					break;
				
		}
	}
	
	
	public static JsonObject sign(String utente, String filename) throws TypeOfTransportNotImplementedException, IOException {
		

		ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
		
		
		Pkcs7SignV2E request= new Pkcs7SignV2E();
		Pkcs7SignV2 pkcs = new Pkcs7SignV2();
		
		SignRequestV2  sign = new SignRequestV2();
		
		sign.setCertID("AS0");
		
		Auth identity = new Auth();
		identity.setDelegated_domain("faSTI");
		identity.setTypeOtpAuth("faSTI");
		identity.setOtpPwd("dsign");
		identity.setTypeOtpAuth("faSTI");
		
		identity.setUser(utente);
		
		identity.setDelegated_user("admin.firma");
		identity.setDelegated_password("uBFqc8YYslTG");
		
		sign.setIdentity(identity);
	
		String path = Costanti.PATH_FIRMA_DIGITALE+filename;
		File f = new File(path);

 		URI uri = f.toURI();
		
		javax.activation.DataHandler dh = new DataHandler(uri.toURL());
		
		sign.setBinaryinput(dh);

		sign.setTransport(TypeTransport.BYNARYNET);
		
		pkcs.setSignRequestV2(sign);
		
		request.setPkcs7SignV2(pkcs);
		
		Pkcs7SignV2ResponseE response= stub.pkcs7SignV2(request);
		JsonObject jsonObj = new JsonObject();
		

	
		if( response.getPkcs7SignV2Response().get_return().getStatus().equals("KO")) {
			jsonObj.addProperty("success", false);
			jsonObj.addProperty("messaggio", response.getPkcs7SignV2Response().get_return().getDescription());
		}else {
			
			jsonObj.addProperty("success", true);
			String fileNoExt = filename.substring(0, filename.length()-4);
			DataHandler fileReturn=response.getPkcs7SignV2Response().get_return().getBinaryoutput();
			File targetFile = new File(Costanti.PATH_FIRMA_DIGITALE+ fileNoExt+".p7m");
			FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);

			jsonObj.addProperty("messaggio", "Documento firmato");
		}
		
		f.delete();
		return jsonObj;
		
		
		 
	}
	
	public static void downloadDocumentoFirmato(HttpServletRequest request, HttpServletResponse response, String filename) throws IOException {
		
		String fileNoExt = filename.substring(0, filename.length()-4);
			String path = Costanti.PATH_FIRMA_DIGITALE+fileNoExt +".p7m"; 
			File file = new File(path);
			
			FileInputStream fileIn = new FileInputStream(file);
			 
			 response.setContentType("application/octet-stream");
			  
			 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
			 
			 ServletOutputStream outp = response.getOutputStream();
			     
			    byte[] outputByte = new byte[1];
			    
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			    }
			    
			    fileIn.close();
			    outp.flush();
			    outp.close();
			    file.delete();
	}
	
}
