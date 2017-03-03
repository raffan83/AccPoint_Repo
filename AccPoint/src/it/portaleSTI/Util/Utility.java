package it.portaleSTI.Util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Utility extends HttpServlet {

	public static String getNomeFile(String memo) {

		if(memo!=null)
		{
			int indexStart=memo.indexOf("<name>");
			int indexEnd=memo.indexOf("</name>");

			memo=memo.substring(indexStart+6,indexEnd);
			return memo;
		}
		else
		{
			return "";
		}
	}

	public static  void copiaFile(String origine, String destinazione)throws Exception
	{
		FileInputStream fis = new FileInputStream(origine);
		FileOutputStream fos = new FileOutputStream(destinazione);

		byte [] dati = new byte[fis.available()];
		fis.read(dati);
		fos.write(dati);

		fis.close();
		fos.close();
	}
	
	public static void generateZipSTI(String path, String archiveName) throws Exception {
		File[] child = new File(path+"\\CORE").listFiles();
		ZipOutputStream zip = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(Costanti.PATH_FOLDER+"\\"+archiveName)));
		
		zip.putNextEntry(new ZipEntry("viewerSTI.jar"));
		FileInputStream fis = new FileInputStream(Costanti.PATH_SOURCE_FORM+"//viewerSTI.jar");
		byte[] readBuffer =new byte[fis.available()];
		
		fis.read(readBuffer);
		zip.write(readBuffer);
		fis.close();
		for(int i = 0; i < child.length; i++)
		{
			
			zip.putNextEntry(new ZipEntry("CORE\\"+child[i].getName()));
			fis = new FileInputStream(child[i]);
			readBuffer =new byte[fis.available()];
			fis.read(readBuffer);
			zip.write(readBuffer);
			fis.close();
		//	child[i].delete();
			
		}
		zip.close(); 

	}

	public static boolean checkSession(HttpSession session, String att) {

		if(session.getAttribute(att)!=null)
		{
			return true;
		}
		return false;
	}

	public static boolean validateSession(HttpServletRequest request,HttpServletResponse response, ServletContext servletContext) throws ServletException, IOException {
		
		if (request.getSession() == null) {
			
		RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/sessionDown.jsp");
     	dispatcher.forward(request,response);
     	
     	return true;
		}
		return false;
	}


}
