package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneVerificazioneBO;

/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/scaricaPacchettoVerificazione", urlPatterns = { "/scaricaPacchettoVerificazione.do" })

public class ScaricaPacchettoVerificazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaPacchettoVerificazione() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doPost(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
		
		try{
			
			String action = request.getParameter("action");
			
			if(action== null) {
				CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
				 
				 VerInterventoDTO intervento=(VerInterventoDTO) request.getSession().getAttribute("interventover");
				 
				 
			 	 String filename = GestioneVerificazioneBO.creaPacchettoConNome(intervento,cmp,session);
				
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
				   
					session.getTransaction().commit();
					session.close();
					
			}			 
				
				else if(action!=null && action.equals("lista_file")) {
					
					ajax = true;
					
					String filename = request.getParameter("filename");
						
				    File dir = new File(Costanti.PATH_FOLDER+filename);
					
				    ArrayList<String> lista_file = new ArrayList<String>();
				    ArrayList<String> lista_date = new ArrayList<String>();
				    
				    if(dir.listFiles()!= null) {
				    	for(File file : dir.listFiles()) {
							
							String ext = FilenameUtils.getExtension(file.getName());
							if(ext.equals("db")) {
								
								lista_file.add(file.getName());	
								lista_date.add(file.lastModified()+"");
							}
							
						}
				    }
					
					
					
					Gson g = new Gson();
							
					myObj.addProperty("success", true);
					myObj.add("lista_file", g.toJsonTree(lista_file));
					myObj.add("lista_date", g.toJsonTree(lista_date));
										
					
					out.print(myObj);
					
	 
					session.getTransaction().commit();
					session.close();
				
				}
			
				else if(action!=null && action.equals("download")) {
					
					String filename = request.getParameter("filename");
					
					File file = new File( Costanti.PATH_FOLDER+filename.split("_")[0].replace(".db","")+"/"+filename);
					 
					 FileInputStream fileIn = new FileInputStream(file);
					
					 response.setContentType("application/octet-stream");					 
					
					 response.setHeader("Content-Disposition","attachment;filename="+filename);
					 
					 ServletOutputStream outp = response.getOutputStream();
					     
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }			    
					    
					    fileIn.close();
					    outp.flush();
					    outp.close();
					 
						session.getTransaction().commit();
						session.close();
				}
		}
		catch(Exception ex)
    	{
			if(ajax) {
				ex.printStackTrace();	        	
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
