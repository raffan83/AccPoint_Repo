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
import it.portaleSTI.DTO.RapportoCampionamentoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateRelazioneCampionamentoDoc;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
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
import javax.servlet.ServletContext;
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
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.ghost4j.document.PDFDocument;
import org.ghost4j.renderer.SimpleRenderer;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
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
			if(action.equals("checkTipoInterventi"))
			{
				String selezionati = request.getParameter("dataIn");

				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				int tipoMatrice=0; 
				int tipoCampionamento = 0;
				Boolean check = true;
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
					InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(id);
					if(tipoMatrice==0 && tipoCampionamento==0) {
						tipoMatrice = interventoCampionamento.getTipoMatrice().getId();
						tipoCampionamento = interventoCampionamento.getTipologiaCampionamento().getId();
					}else {
						if(tipoMatrice != interventoCampionamento.getTipoMatrice().getId() || tipoCampionamento != interventoCampionamento.getTipologiaCampionamento().getId()) {
							check=false;
						}
					}
					
				}		
				JsonObject myObj = new JsonObject();
				if(check) {
					
					myObj.addProperty("success", true);
 					
				}else {
					myObj.addProperty("messaggio", "Gli interventi selezionati hanno matrice o tipologia campionamento diverse. Non si pu&ograve; creare una relazione comune.");	
					myObj.addProperty("success", false);
				}
				PrintWriter out = response.getWriter();
		        out.println(myObj.toString());
			}
			
			if(action.equals("relazioneCampionamento"))
			{
				
				String[] ids= request.getParameterValues("ids[]");
				String commessa=request.getParameter("commessa");
				
				ArrayList<InterventoCampionamentoDTO> interventi = new ArrayList<InterventoCampionamentoDTO>();
				for(int i = 0; i < ids.length; i++)
				{
					InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(ids[i]);
					interventi.add(interventoCampionamento);
 				}
				
				
 				
 
				request.getSession().setAttribute("interventi", interventi);
				request.getSession().setAttribute("commessa", commessa);
				
				


				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/creazioneRelazioneInterventoDatiCampionamento.jsp");     	
				dispatcher.forward(request,response);


				
			 	
			}
			
			if(action.equals("generaRelazioneCampionamento")){
			 
				
				
				ArrayList<InterventoCampionamentoDTO> interventi = (ArrayList<InterventoCampionamentoDTO>) request.getSession().getAttribute("interventi");
				String commessa = (String) request.getSession().getAttribute("commessa");
				
				String commessaNorm = commessa.replaceAll("/", "_");
					
				
				boolean isMultipart = ServletFileUpload.isMultipartContent(request);

				File directory =new File(Costanti.PATH_FOLDER+"//Relazioni//"+commessaNorm);
				
				if(directory.exists()==false)
				{
					directory.mkdir();
				}
				
				File directoryTemp =new File(Costanti.PATH_FOLDER+"//Relazioni//"+commessaNorm+"//temp");
				
				if(directoryTemp.exists()==false)
				{
					directoryTemp.mkdir();
				}
				
				XSSFWorkbook relazione = null;
				PDFDocument relazioneLab = new PDFDocument();
				String text = null;
				String laboratorio = null;
				LinkedHashMap<String, Object> componenti = new LinkedHashMap<>();
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
				              

					                if(item.getFieldName().equals("relazione") && item.getFieldName()!=null) {
					                	String nomeFile=item.getName();
					                	
					                	if(item.getName()!=null && FilenameUtils.getExtension(nomeFile).equals("xlsx")) 
					                	{
					                		File file = new File(directoryTemp+"//relazione.xlsx");
					                		item.write(file);
					                		relazione = new XSSFWorkbook(file);
					                		componenti.put("relazione", relazione);
					                	}else 
					                	{
					                		relazione=null;
					                	}
					                }
					                
					                
					                if(item.getFieldName().equals("relazioneLab")) {
					                	String nomeFile=item.getName();
					                	
					                	if(item.getName()!=null && FilenameUtils.getExtension(nomeFile).equals("pdf")) 
					                	{
					                		File file = new File(directoryTemp+"//relazioneLab.pdf");
					                		item.write(file);
					                		relazioneLab.load(file);
					                		componenti.put("relazioneLab", relazioneLab);
					                	}
					                	else 
					                	{
					                		relazioneLab=null;
					                	}
				               
					                }
				                		if(item.getFieldName().equals("text")) {
				                			text = item.getString();
				                		}
				                		if(item.getFieldName().equals("laboratorio")) {
				                			laboratorio = item.getString();
				                		}
				                	 
				                	 
			                }
		                } 
		                catch (Exception e) 
		                {
		                		e.printStackTrace();
		                }
		        }

				componenti.put("text", text);
				componenti.put("laboratorio", laboratorio);
				UtenteDTO user = (UtenteDTO) request.getSession().getAttribute("userObj");
				
				CreateRelazioneCampionamentoDoc creazioneRelazione = new CreateRelazioneCampionamentoDoc(componenti,interventi,user,session,getServletContext());			
				
				JsonObject jsono = new JsonObject();
				PrintWriter writer = response.getWriter();
				
				if(creazioneRelazione.idRelazione == 0) {
					jsono.addProperty("success", false);
					jsono.addProperty("messaggio", "Impossibile creare la relazione. "+creazioneRelazione.errordesc);
				}
				else 
				{

						jsono.addProperty("success", true);
						jsono.addProperty("messaggio", "Rapporto salvato con successo");	
						jsono.addProperty("idRelazione", creazioneRelazione.idRelazione);	
						jsono.addProperty("idCommessa", commessa);
						

				}
				Utility.removeDirectory(directoryTemp);
					
				writer.write(jsono.toString());
				writer.close();

				
			}
			
			if(action.equals("scaricaRelazioneCampionamento")){
		
				String idRelazione= request.getParameter("idRelazione");
				
				RapportoCampionamentoDTO relazione = GestioneCampionamentoBO.getRapportoById(idRelazione,session);
 			
			    response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename="+relazione.getNomeFile()+".docx");

				
                String commessa = relazione.getIdCommessa();
				
				commessa = commessa.replaceAll("/", "_");
				File d = new File(Costanti.PATH_FOLDER+"//Relazioni//"+commessa+"//"+relazione.getNomeFile()+".docx");
				
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
			
			
			session.getTransaction().commit();
			session.close();	
		
		
		}catch (Exception ex) {
			
			session.getTransaction().rollback();
			session.close();
			request.getSession().invalidate();
			
			String action=request.getParameter("action");
			
			if(action.equals("generaRelazioneCampionamento") || action.equals("checkTipoInterventi"))
			{
				JsonObject jsono = new JsonObject();
				PrintWriter writer = response.getWriter();
				jsono.addProperty("success", false);
				jsono.addProperty("messaggio", ex.toString());	
				writer.write(jsono.toString());
				writer.close();
			}else {
				 ex.printStackTrace();
		   	     request.setAttribute("error",STIException.callException(ex));
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);	
			}
		}
		
	}



}
