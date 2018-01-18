package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateRelazioneCampionamento;
import it.portaleSTI.bo.CreateRelazioneCampionamentoDoc;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import net.sf.dynamicreports.report.builder.component.ImageBuilder;

import java.awt.Image;
import java.awt.image.RenderedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.ghost4j.document.PDFDocument;
import org.ghost4j.renderer.SimpleRenderer;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "creazioneRelazioneCampionamento", urlPatterns = { "/creazioneRelazioneCampionamento.do" })
public class CreazioneRelazioneCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreazioneRelazioneCampionamento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		doPost(request,response);
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

			
			
			String action=request.getParameter("action");
			
			
			if(action.equals("relazioneCampionamento"))
			{
				String idIntervento= request.getParameter("idIntervento");
				
				InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(idIntervento);
				
				ArrayList<PrenotazioniDotazioneDTO> listaPrenotazioniDotazioni = GestioneCampionamentoBO.getListaPrenotazioniDotazione(idIntervento,session);
				ArrayList<PrenotazioneAccessorioDTO> listaPrenotazioniAccessori = GestioneCampionamentoBO.getListaPrenotazioniAccessori(idIntervento,session);
				
				boolean check = new File(Costanti.PATH_FOLDER+"//"+interventoCampionamento.getNomePack()+"//"+interventoCampionamento.getNomePack()+".docx").exists();

				request.getSession().setAttribute("interventoCampionamento", interventoCampionamento);
				request.getSession().setAttribute("relazioneExist", check);

				
				
				session.getTransaction().commit();
		     	session.close();	
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/creazioneRelazioneInterventoDatiCampionamento.jsp");     	
				dispatcher.forward(request,response);


				
			 	
			}
			
			if(action.equals("gerneraRelazioneCampionamento")){
			 
				
				
				String idIntervento= request.getParameter("idIntervento");
				InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(idIntervento);

				
				boolean isMultipart = ServletFileUpload.isMultipartContent(request);

				File directory =new File(Costanti.PATH_FOLDER+"//"+interventoCampionamento.getNomePack()+"//temp/");
				
				if(directory.exists()==false)
				{
					directory.mkdir();
				}
				
				PDFDocument relazione = new PDFDocument();
				PDFDocument relazioneLab = new PDFDocument();
				String text = null;
		        // process only if it is multipart content
		        if (isMultipart) {
		                // Create a factory for disk-based file items
		                FileItemFactory factory = new DiskFileItemFactory();

		                // Create a new file upload handler
		                ServletFileUpload upload = new ServletFileUpload(factory);
		                try {
			                // Parse the request
			                List<FileItem> multiparts = upload.parseRequest(request);
	
			                for (FileItem item : multiparts) {
				              

					                if(item.getFieldName().equals("relazione")) {
					                		File file = new File(Costanti.PATH_FOLDER+"//"+interventoCampionamento.getNomePack()+"//temp/relazione.pdf");
					                		item.write(file);
					                		relazione.load(file);
					                }
					                if(item.getFieldName().equals("relazioneLab")) {
					                		File file = new File(Costanti.PATH_FOLDER+"//"+interventoCampionamento.getNomePack()+"//temp/relazioneLab.pdf");
					                		item.write(file);
					                		relazioneLab.load(file);
					                }
				               
				                
				                		if(item.getFieldName().equals("text")) {
				                			text = item.getString();
				                		}
				                	 
			                }
		                } 
		                catch (Exception e) 
		                {
		                		e.printStackTrace();
		                }
		        }
		        

				
				
				
				LinkedHashMap<String, Object> componenti = new LinkedHashMap<>();
				
				componenti.put("text", text);
				componenti.put("relazione", relazione);
				componenti.put("relazioneLab", relazioneLab);

				
				new CreateRelazioneCampionamentoDoc(componenti,interventoCampionamento,session,getServletContext());
				
		        String[]entries = directory.list();
		        for(String s: entries){
		            File currentFile = new File(directory.getPath(),s);
		            currentFile.delete();
		        }
				directory.delete();

			}
			
			if(action.equals("scaricaRelazioneCampionamento")){
		
				String idIntervento= request.getParameter("idIntervento");
				
				InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(idIntervento);
			
			    
			    response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename="+interventoCampionamento.getNomePack()+".docx");

				
				
				File d = new File(Costanti.PATH_FOLDER+"//"+interventoCampionamento.getNomePack()+"//"+interventoCampionamento.getNomePack()+".docx");
				
				FileInputStream fileIn = new FileInputStream(d);
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
//				    copy binary contect to output stream
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				     }
				    
				    
				    fileIn.close();
			
		
				    
				    outp.flush();
				    outp.close();
			
				
			}
			
		
		
		
		
		}catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}



}
