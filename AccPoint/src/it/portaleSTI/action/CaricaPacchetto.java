package it.portaleSTI.action;

import it.portaleSTI.Util.Utility;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/caricaPacchetto", urlPatterns = { "/caricaPacchetto.do" })

public class CaricaPacchetto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CaricaPacchetto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		
		 if (!ServletFileUpload.isMultipartContent(request)) {
	            throw new IllegalArgumentException("Request is not multipart, please 'multipart/form-data' enctype for your form.");
	        }

	        ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());

	        response.setContentType("application/json");
			PrintWriter out = response.getWriter();

	        try {
	            List<FileItem> items = uploadHandler.parseRequest(request);
	            for (FileItem item : items) {
	                if (!item.isFormField()) {
	                        File file = new File(request.getServletContext().getRealPath("/")+"imgs/", item.getName());

	                        Gson gson = new Gson(); 
	            	        JsonObject myObj = new JsonObject();

	            	        JsonParser jsonParser = new JsonParser();

	            	        JsonElement jsonElement = jsonParser.parse("{dataInfo:[{message:'ok'}]}");

	            	         myObj.addProperty("success", true);
	            	  
	            	        myObj.add("dataInfo", jsonElement); 

	            	        
	            	        System.out.println(myObj.toString());
	            	       
	            	        out.println(myObj.toString());

	                }
	            }
	        } catch (FileUploadException e) {
	                throw new RuntimeException(e);
	        } catch (Exception e) {
	                throw new RuntimeException(e);
	        } finally {

	            out.close();
	        }

	    }

	    private String getMimeType(File file) {
	        String mimetype = "";
	        if (file.exists()) {
	            if (getSuffix(file.getName()).equalsIgnoreCase("png")) {
	                mimetype = "image/png";
	            }else if(getSuffix(file.getName()).equalsIgnoreCase("jpg")){
	                mimetype = "image/jpg";
	            }else if(getSuffix(file.getName()).equalsIgnoreCase("jpeg")){
	                mimetype = "image/jpeg";
	            }else if(getSuffix(file.getName()).equalsIgnoreCase("gif")){
	                mimetype = "image/gif";
	            }else {
	                javax.activation.MimetypesFileTypeMap mtMap = new javax.activation.MimetypesFileTypeMap();
	                mimetype  = mtMap.getContentType(file);
	            }
	        }
	        return mimetype;
	    }



	    private String getSuffix(String filename) {
	        String suffix = "";
	        int pos = filename.lastIndexOf('.');
	        if (pos > 0 && pos < filename.length() - 1) {
	            suffix = filename.substring(pos + 1);
	        }
	        return suffix;
	    }

}
