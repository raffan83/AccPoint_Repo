package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
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
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateReportAccredia;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneMisuraBO;

/**
 * Servlet implementation class GestioneMisura
 */
@WebServlet("/gestioneMisura.do")
public class GestioneMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestioneMisura.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneMisura() {
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

		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(action.equals("lista")) {
				
				
//				ArrayList<MisuraDTO> lista_misureAll = GestioneMisuraDAO.getListaMisure(session);
//				
//				for (MisuraDTO misuraDTO : lista_misureAll) {
//					if(misuraDTO.getStrumento().getTipoRapporto().getId()==7201) {
//						String indice = GestioneMisuraBO.calcolaIndicePrestazione(misuraDTO);
//						misuraDTO.setIndice_prestazione(indice);
//						misuraDTO.getStrumento().setIndice_prestazione(indice);
//						session.update(misuraDTO);
//						session.update(misuraDTO.getStrumento());
//					}
//				}
//				
				
				String date_from = request.getParameter("date_from");
				String date_to = request.getParameter("date_to");
				
				Date end = null;
				Date start = null;
				
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
				if(date_from == null) {
					end = new Date();
					
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(end);
					calendar.add(Calendar.DAY_OF_MONTH, -30);
					
					start = calendar.getTime();
				}else {
					
					
					end = df.parse(date_to);
					start = df.parse(date_from);	
					
				}
								
				//ArrayList<MisuraDTO> lista_misure = GestioneMisuraBO.getListaMisurePerData(start, end, false, session);
				ArrayList<String> lista_misure = DirectMySqlDAO.getListaMisureFromDate(df.format(start), df.format(end));
				
				df = new SimpleDateFormat("dd/MM/yyyy");	
				request.getSession().setAttribute("lista_misure", lista_misure);
				request.getSession().setAttribute("date_to", df.format(end));
				request.getSession().setAttribute("date_from", df.format(start));
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaMisureGeneral.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("crea_report_accredia")) {
				
				String date_from = request.getParameter("date_from");
				String date_to = request.getParameter("date_to");
				
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
				Date end = df.parse(date_to);
				Date start = df.parse(date_from);	
				ArrayList<MisuraDTO> lista_misure = GestioneMisuraBO.getListaMisurePerData(start, end, true, session);
				
				new CreateReportAccredia(lista_misure, date_from, date_to, session);
				
				SimpleDateFormat output = new SimpleDateFormat("ddMMyyyy");
				Date dateValueFrom = df.parse(date_from);
				Date dateValueTo = df.parse(date_to);
				
				String path = Costanti.PATH_FOLDER+"\\ReportAccredia\\"+output.format(dateValueFrom)+output.format(dateValueTo)+".pdf";
				
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

					ServletOutputStream outp = response.getOutputStream();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ output.format(dateValueFrom)+output.format(dateValueTo)+".pdf");
			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
				
				session.close();
				
				
			}else if(action.equals("download_condizioni_ambientali")) {
				
				String id_misura = request.getParameter("id_misura");
				
				id_misura = Utility.decryptData(id_misura);
				
				MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misura), session);
				
				String path = Costanti.PATH_FOLDER+misura.getIntervento().getNomePack()+"\\CondizioniAmbientali\\"+misura.getFile_condizioni_ambientali();
				
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

					ServletOutputStream outp = response.getOutputStream();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ misura.getFile_condizioni_ambientali());
			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
				
				session.close();
			}
			
			else if(action.equals("modifica_certificato")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        //String id_corso = request.getParameter("id_corso");
		        String id_certificato = ret.get("id_certificato");
				String numero_certificato = ret.get("numero_certificato");
				String data_emissione = ret.get("data_emissione");
				String note = ret.get("note");
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(id_certificato);
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				if(data_emissione!=null && !data_emissione.equals("")) {
					certificato.setDataCreazione(df.parse(data_emissione));
				}
				
				certificato.getMisura().setnCertificato(numero_certificato);
				certificato.getMisura().setDataUpdate(new Date());
				certificato.getMisura().setUserModifica(utente);
				certificato.getMisura().setNotaModifica(note);
				
				if(certificato.getMisura().getMisuraLAT()!=null) {
					certificato.getMisura().getMisuraLAT().setnCertificato(numero_certificato);
					session.update(certificato.getMisura().getMisuraLAT());
				}
				
				
				session.update(certificato.getMisura());
				session.update(certificato);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Certificato modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			}
			
			else if(action.equals("aggiorna_indice_prestazione")) {
				
				
				ajax = true;
				String id_misura = request.getParameter("id_misura");
				String stato = request.getParameter("stato");
				
				String id_strumento = "";
				MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id_misura), session);
				misura.setIndice_prestazione(stato);
				if(misura.getStrumento().getDataUltimaVerifica() == null || misura.getStrumento().getDataUltimaVerifica().equals(misura.getDataMisura())) {
					misura.getStrumento().setIndice_prestazione(stato);
					id_strumento = misura.getStrumento().get__id()+"";
				}
				
				session.update(misura);
				session.update(misura.getStrumento());
				
				myObj.addProperty("success", true);
				myObj.addProperty("id_strumento", id_strumento);
				
				session.getTransaction().commit();
				session.close();
				
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
				
			}
					
		}catch(Exception e) {
			
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = STIException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}
			
		}
		
	}

}
