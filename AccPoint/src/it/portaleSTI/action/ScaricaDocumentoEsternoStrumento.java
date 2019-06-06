package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Set;

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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.DocumentiEsterniStrumentoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ScaricaCertificato
 */
@WebServlet(name= "/scaricaDocumentoEsternoStrumento", urlPatterns = { "/scaricaDocumentoEsternoStrumento.do" })
public class ScaricaDocumentoEsternoStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaDocumentoEsternoStrumento() {
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
		
	
		String action=request.getParameter("action");
		
		try
		{

			if(action.equals("caricaDocumento")) {
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
				ObjSavePackDTO esito = null;
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				List<FileItem> items = uploadHandler.parseRequest(request);
				String dataVerifica = "";
				String idStrumento = "";
				FileItem fileUploaded = null;
				for (FileItem item : items) {
					if (!item.isFormField()) {
 
						fileUploaded = item;
 
					}else {
						
						if(item.getFieldName().equals("dataVerifica")) {
							dataVerifica = item.getString();
						}
						if(item.getFieldName().equals("idStrumento")) {
							idStrumento = item.getString();
						}
						

					}
					
				
				}
				
				StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(idStrumento, session);
				if(fileUploaded != null && !dataVerifica.equals("")) {
					esito = GestioneStrumentoBO.saveDocumentoEsterno(fileUploaded,strumento,dataVerifica,session);
				 
					if(esito.getEsito() == 1) {
	
						ScadenzaDTO scadenza = new ScadenzaDTO();
						scadenza.setIdStrumento(strumento.get__id());
						scadenza.setFreq_mesi(strumento.getScadenzaDTO().getFreq_mesi());
						scadenza.setTipo_rapporto(strumento.getScadenzaDTO().getTipo_rapporto());
						{

							SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

					        Date date = format.parse(dataVerifica);
					        					        
							java.sql.Date sqlDate = new java.sql.Date(date.getTime());
							
							scadenza.setDataUltimaVerifica(sqlDate);
							scadenza.setDataEmissione(sqlDate);
							
							Calendar data = Calendar.getInstance();
							
							data.setTime(date);
							data.add(Calendar.MONTH,scadenza.getFreq_mesi());
							
							java.sql.Date sqlDateProssimaVerifica = new java.sql.Date(data.getTime().getTime());
								
							scadenza.setDataProssimaVerifica(sqlDateProssimaVerifica);
							
						}
						Set<ScadenzaDTO> listaScadenze = strumento.getListaScadenzeDTO();
						listaScadenze.add(scadenza);
						strumento.setListaScadenzeDTO(listaScadenze);
						
						
						GestioneStrumentoBO.saveScadenza(scadenza, session);						
						GestioneStrumentoBO.update(strumento, session);
						
						
						
						jsono.addProperty("success", true);
						jsono.addProperty("messaggio","ok");
					}else {
						jsono.addProperty("success", false);
						jsono.addProperty("messaggio","Errore salvataggio File");
					}
					
				 	
					
				}else {
					jsono.addProperty("success", false);
					jsono.addProperty("messaggio","File o data verifica mancanti");
				}

				
				
				session.getTransaction().commit();
				session.close();	
				writer.write(jsono.toString());
				writer.close();
			}
			
			
			
			if(action.equals("scaricaDocumento"))
			{
			String idDocumento= request.getParameter("idDoc");
			 	
			 	DocumentiEsterniStrumentoDTO documento= GestioneStrumentoBO.getDocumentoEsterno(idDocumento,session);
			 	StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(""+documento.getId_strumento(), session);
				
				
			 	if(documento!=null)
			 	{
				
			     File d = new File(Costanti.PATH_FOLDER+"//DocumentiEsterni//"+strumento.get__id()+"/"+documento.getNomeDocumento());
				 
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 //response.setContentType("application/octet-stream");
				 response.setContentType("application/pdf");
				 response.setHeader("Content-Disposition","attachment;filename="+documento.getNomeDocumento());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
				    session.close();	
				    outp.flush();
				    outp.close();
			 	}
			}
			if(action.equals("eliminaDocumento"))
			{
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
				
				String idDocumento= request.getParameter("idDoc");
				

				GestioneStrumentoBO.deleteDocumentoEsterno(idDocumento,session);


				jsono.addProperty("success", true);
				jsono.addProperty("messaggio", "Documento eliminato correttamente");
				
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
			if(action.equals("scaricaDocumento"))
			{
				request.setAttribute("error",STIException.callException(ex));
		   	     request.getSession().setAttribute("exception", ex);
			   	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			   	dispatcher.forward(request,response);	
			
			}else {
				PrintWriter writer = response.getWriter();
				JsonObject jsono = new JsonObject();
			   //	jsono.addProperty("success", false);
			   	//jsono.addProperty("messaggio",ex.getMessage());
				jsono = STIException.getException(ex);
			   	writer.write(jsono.toString());
				writer.close();
			}
   
   	   
   	}  
	}

}
