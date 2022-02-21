package it.portaleSTI.bo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;

import com.google.gson.JsonObject;
import com.itextpdf.text.Annotation;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.parser.ImageRenderInfo;
import com.itextpdf.text.pdf.parser.PdfReaderContentParser;
import com.itextpdf.text.pdf.parser.RenderListener;
import com.itextpdf.text.pdf.parser.TextRenderInfo;

import it.portaleSTI.DAO.GestioneVerCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerEmailDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneVerCertificatoBO {

	public static LinkedHashMap<String, String> getClientiPerVerCertificato(UtenteDTO utente, Session session)throws Exception {
		
		
		return GestioneVerCertificatoDAO.getClientiPerVerCertificato(utente, session);			
		
	}

	public static ArrayList<VerCertificatoDTO> getListaCertificati(int stato, int filtro_emissione, int idCliente, int idSede,String company, boolean obsoleti,Session session) {
	
		return GestioneVerCertificatoDAO.getListaCertificati(stato,filtro_emissione, idCliente, idSede, company,obsoleti,session);
	}

	public static VerCertificatoDTO getCertificatoById(int id, Session session) {
		
		return GestioneVerCertificatoDAO.getCertificatoById(id, session);
	}
	
	public static  VerCertificatoDTO getCertificatoByMisura(VerMisuraDTO misura) throws Exception 
	{
		return GestioneVerCertificatoDAO.getCertificatoByMisura(misura);
	}

	public static ArrayList<VerEmailDTO> getListaEmailCertificato(int id_certificato, Session session) {
		
		return GestioneVerCertificatoDAO.getListaEmailCertificato(id_certificato,session);
	}

	public static ArrayList<VerCertificatoDTO> getListaCertificatiPrecedenti(int id_strumento,  Session session) {
		
		return GestioneVerCertificatoDAO.getListaCertificatiPrecedenti(id_strumento, session);
	}
	
	
	private static Integer[] getFontPosition(  PdfReader pdfReader, final String keyWord, Integer pageNum) throws IOException {
	    final Integer[] result = new Integer[2];
	    final List<Integer[]> list =new ArrayList<Integer[]>();
	    if (pageNum == null) {
	        pageNum = pdfReader.getNumberOfPages();
	    }
	    new PdfReaderContentParser(pdfReader).processContent(pageNum, new RenderListener() {
	        public void beginTextBlock() {

	        }

	        public void renderText(TextRenderInfo textRenderInfo) {
	        	
//	        	 LineSegment segment = textRenderInfo.getBaseline();
//	        	    int x = (int) segment.getStartPoint().get(Vector.I1);
//	        	    // smaller Y means closer to the BOTTOM of the page. So we negate the Y to get proper top-to-bottom ordering
//	        	    int y = -(int) segment.getStartPoint().get(Vector.I2);
//	        	    int endx = (int) segment.getEndPoint().get(Vector.I1);
//	        	    System.out.println("renderText "+x+".."+endx+"/"+y+": "+textRenderInfo.getText());
//	     
	            String text = textRenderInfo.getText();
	            
	            if (text != null && StringUtils.containsIgnoreCase(text, keyWord)) {
	                                 
	                com.itextpdf.awt.geom.Rectangle2D.Float textFloat = textRenderInfo.getBaseline().getBoundingRectange();
	                float x = textFloat.x;
	                float y = textFloat.y;
	                Integer[] integer = new Integer[2];
	                integer[0] = (int) x;
	                integer[1] = (int) y;
	                list.add(integer);
	                
	                 //                    System.out.println(String.format("The signature text field absolute position is x:%s, y:%s", x, y));
	            }
	        }

	        public void endTextBlock() {

	        }

	        public void renderImage(ImageRenderInfo renderInfo) {

	        }
	    });
	    int max = 0;
	   	if(list.size()>0) {
	   		Integer[] integer = list.get(0);
	   		max = integer[0];
	   		result[0] = integer[0];
   			result[1] = integer[1];
	   	}
	   	
	   	for (int i = 1; i < list.size(); i++) {
	   		Integer[] integer = list.get(i);
	   		if(integer[0]>max) {
	   			result[0] = integer[0];
	   			result[1] = integer[1];
	   		}
		}

	    return result;
	}
	

	public static JsonObject addFirmaResponsabile(UtenteDTO utente_firma, VerCertificatoDTO certificato) throws Exception {
		
		String path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+certificato.getNomeCertificato();
		
		PdfReader reader = new PdfReader(path);
	    
	    String filename = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
	    	          
	    PdfStamper stamper = new PdfStamper(reader,new FileOutputStream(Costanti.PATH_FOLDER+"\\temp\\"+filename+".pdf"));
	    PdfContentByte content = stamper.getOverContent(2);	   
	    
		Image image = null;
	    	
		 BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
	    	
		    String keyWord = "Il Responsabile dell'Organismo";
		    Integer[] fontPosition = null;
			
				fontPosition = getFontPosition(reader, keyWord, 2);
				
				if(fontPosition[0] != null && fontPosition[1] != null) {
					
					int x = fontPosition[0] ;
					int y = fontPosition[1] -15;
					int w = x + 85;
					int h = y + 31;
					
					 Rectangle rect = new Rectangle(x, y, w, h);
				    
					   image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\"+utente_firma.getFile_firma());
				    	
				    	image.setAnnotation(new Annotation(0, 0, 0, 0, 3));	   
					    
						 image.scaleAbsolute(rect);
						
						image.setAbsolutePosition(fontPosition[0] + 35 , fontPosition[1] -45);
						
						content.addImage(image);
						content.beginText();
						content.setFontAndSize(bf, 10);
						content.setTextMatrix(x+35, y);
						content.showText(utente_firma.getNominativo());
						content.endText();
			}
			
   
				System.out.println(Arrays.toString(fontPosition));
	 
	    
	    stamper.close();
		reader.close();


	    File targetFile=  new File(path);
		File source = new File(Costanti.PATH_FOLDER+"\\temp\\"+filename+".pdf");
     	FileUtils.copyFile(source, targetFile);
     	
     
     	source.delete();
     
	    JsonObject myObj = new JsonObject();
	    
     	myObj.addProperty("success", true);
		return myObj;
		
	}

}
