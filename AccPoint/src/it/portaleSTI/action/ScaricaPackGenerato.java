package it.portaleSTI.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.nio.file.CopyOption;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
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
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/scaricoPackGenerato", urlPatterns = { "/scaricoPackGenerato.do" })

public class ScaricaPackGenerato extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ScaricaPackGenerato.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaPackGenerato() {
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
		 boolean ajax=false;
		 JsonObject myObj = new JsonObject();
		try{
			
			 String filename=(String)request.getParameter("filename");
			 String nome_pack= request.getParameter("nome_pack");
			 
			 String action = request.getParameter("action");
			
			 logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
			 if(action==null) {
				 
			 String ext1 = FilenameUtils.getExtension(filename);
			 
			 File d=null;
			 
			 if(ext1.equals("xls") || ext1.equals("xlsx") || ext1.equals("xlsm")||ext1.equals("xlsxm")) 
			 {
				 if(nome_pack!=null && !nome_pack.equals("")) {
					 d = new File(Costanti.PATH_FOLDER+nome_pack+"/"+filename);
				 }else {					 
					 String[] filnames = filename.split("_");			
					 d = new File(Costanti.PATH_FOLDER+filnames[0]+"/"+filename);
				 }
			 }
			 else 
			 {
				 String[] filnames = filename.split("_");
				 if(filnames[0].startsWith("LAT")) 
				 {
					 filnames[0]=filnames[0].substring(3, filnames[0].length());
				 }
				 filename=filename+".db";
			     d = new File(Costanti.PATH_FOLDER+filnames[0]+"/"+filename);
			 }
			 			 
			 
			 request.getSession().setAttribute("filepath", Costanti.PATH_FOLDER+filename.split("_")[0]+"/");
			 
			 FileInputStream fileIn = new FileInputStream(d);
			
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
			 //}
		}
		else if(action!=null && action.equals("excel")) {
			ajax = true;
			 String[] filnames = filename.split("_");			
		     File d = new File(Costanti.PATH_FOLDER+filnames[0]+"/"+filename);
		     String path = getServletContext().getRealPath("/images") + "\\temp\\";
		     File folder = new File(path);
		     if(!folder.exists()) {
		    	 folder.mkdirs();
		     }
		     File copiato = new File(path+filename);
		     InputStream is = new FileInputStream(d);
		     OutputStream os = new FileOutputStream(copiato);
		     byte[] buffer = new byte[1024];
		        int length;
		        while ((length = is.read(buffer)) > 0) {
		            os.write(buffer, 0, length);
		        }
		        is.close();
		        os.flush();
		        os.close();
		        
		        session.close();
		        PrintWriter out = response.getWriter();
		        myObj.addProperty("success", true);
		        out.print(myObj);
		        
		}
		else if(action.equals("upload_drive")) {
			
			ajax = true;
			
			String url = request.getParameter("url");
			String nome_file = request.getParameter("nome_file");
		
			FileUtils.copyURLToFile(new URL(url), new File(Costanti.PATH_FOLDER+"//"+nome_file.split("_")[0]+"//"+nome_file));
		
		    session.close();
		    PrintWriter out = response.getWriter();
		    myObj.addProperty("success", true);
		    out.print(myObj);

		}
			 
			 
		}
		
		catch(Exception ex)
    	{
			if(ajax) {
				PrintWriter out = response.getWriter();
				ex.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", ex);
	        	myObj = STIException.getException(ex);
	        	out.print(myObj);
	        	
	        	session.getTransaction().rollback();
	    		session.close();
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
