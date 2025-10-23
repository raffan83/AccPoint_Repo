package it.portaleSTI.bo;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.FileTime;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.Session;

import com.google.gson.JsonObject;
import com.itextpdf.text.Annotation;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.AcroFields.Item;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PRStream;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfDocument;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfObject;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.parser.ImageRenderInfo;
import com.itextpdf.text.pdf.parser.PdfReaderContentParser;
import com.itextpdf.text.pdf.parser.RenderListener;
import com.itextpdf.text.pdf.parser.TextRenderInfo;

import it.portaleSTI.DAO.GestioneVerCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerEmailDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ContextListener;

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
	
	
	private static String[] getText(  PdfReader pdfReader, Integer pageNum) throws IOException {
	    final String[] result = new String[1];
	   
	    if (pageNum == null) {
	        pageNum = pdfReader.getNumberOfPages();
	    }
	    new PdfReaderContentParser(pdfReader).processContent(pageNum, new RenderListener() {
	        public void beginTextBlock() {

	        }

	        public void renderText(TextRenderInfo textRenderInfo) {
	        	
	            String text = textRenderInfo.getText();
	            result[0] +=" "+ text;

	        }

	        public void endTextBlock() {

	        }

	        public void renderImage(ImageRenderInfo renderInfo) {

	        }
	    });
	    return result;
	}
	
	

	public static JsonObject addFirmaResponsabile(UtenteDTO utente_firma, VerCertificatoDTO certificato, boolean isRapporto) throws Exception {
		
		String path = ""; 
				
		if(!isRapporto) {
			path = 	Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+certificato.getNomeCertificato();
		}else {
			path = 	Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\Rapporto\\"+certificato.getNomeRapporto();
		}
			
		
		PdfReader reader = new PdfReader(path);
	    
	    String filename = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
	  
	    PdfStamper stamper = new PdfStamper(reader,new FileOutputStream(Costanti.PATH_FOLDER+"\\temp\\"+filename+".pdf"));
	    PdfContentByte content = null;;	   
	    PdfContentByte content1 = null;
		Image image = null;
	    	
		 BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
	    	
		    String keyWord = "Il Responsabile dell'Organismo";
		    Integer[] fontPosition = null;
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");   
		if(!isRapporto) {
			
			   content = stamper.getOverContent(2);	   
			   content1 = stamper.getOverContent(1);
			
			if(utente_firma.getId()!=86) {
				 String[] text = getText(reader, 1);
					
				    StringBuffer sb = new StringBuffer();
				      for(int i = 0; i < text.length; i++) {
				         sb.append(text[i]);
				      }
				      String str = sb.toString();
				      
				      Rectangle rect1 = new Rectangle(20, 665, 600, 630);
				      rect1.setBackgroundColor(BaseColor.WHITE);
				    
				      
				  String sub =  str.substring(str.indexOf("Il sottoscritto"), (str.indexOf("della verificazione periodica")+20));
				  sub = sub.replace("Eliseo Crescenzi", utente_firma.getNominativo()+" Sostituto");
				    content1.rectangle(rect1);
				    
				    content1.beginText();
					content1.setFontAndSize(bf, 10);
					content1.setTextMatrix(20, 650);		
					content1.showText(sub);
					content1.endText();
					
					
					
					String sub1 =  str.substring(str.indexOf("di strumenti"), (str.indexOf("del 21 Aprile")));
					sub1 = "periodica "+sub1;
					content1.beginText();
						content1.setFontAndSize(bf, 10);
						content1.setTextMatrix(20, 638);		
						content1.showText(sub1);
						content1.endText();
					
						
						content1.beginText();
						content1.setFontAndSize(bf, 10);
						content1.setTextMatrix(20, 626);		
						content1.showText("del 21 Aprile 2017,");
						content1.endText();
			}
			   
					
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
							
							if(utente_firma.getId()!=86) {
							Rectangle rect1 = new Rectangle(x-40, y+25, x+200, y+10);
						      rect1.setBackgroundColor(BaseColor.WHITE);
							
						      content.rectangle(rect1);
						      content.beginText();
								content.setFontAndSize(bf, 10);
								content.setTextMatrix(x-25, y+15);		
								content.showText("Il Sostituto Responsabile dell'Organismo");
								content.endText();
							}
							
							content.addImage(image);
							content.beginText();
							content.setFontAndSize(bf, 10);
							content.setTextMatrix(x+35, y);
							content.showText(utente_firma.getNominativo());
							content.endText();
				}
				
	   
					System.out.println(Arrays.toString(fontPosition));
		 
					
					fontPosition = getFontPosition(reader, "Data emissione", 2);
					if(fontPosition[0] != null && fontPosition[1] != null) {
						
						int x = fontPosition[0] ;
						int y = fontPosition[1] -15;
			
							Rectangle rect1 = new Rectangle(x, y, x+200, y+10);
						      rect1.setBackgroundColor(BaseColor.WHITE);
							
						      content.rectangle(rect1);
						      content.beginText();
								content.setFontAndSize(bf, 10);
								content.setTextMatrix(x+10, y);	
						
								content.showText(df.format(new Date()));
								content.endText();
						
						
				}
		}else {

			
			for(int i= 1;i<=reader.getNumberOfPages();i++) {
				content = stamper.getOverContent(i);	   
			
				fontPosition = getFontPosition(reader, "Data emissione", i);
				if(fontPosition[0] != null && fontPosition[1] != null) {
					
					int x = fontPosition[0] ;
					int y = fontPosition[1] -15;
		
						Rectangle rect1 = new Rectangle(x, y, x+200, y+10);
					      rect1.setBackgroundColor(BaseColor.WHITE);
						
					      content.rectangle(rect1);
					      content.beginText();
							content.setFontAndSize(bf, 10);
							content.setTextMatrix(x+10, y);							
							content.showText(df.format(new Date()));
							content.endText();
					
					
			}
			}
			
		}
		
	    
	    stamper.close();
		reader.close();


	    File targetFile=  new File(path);
		File source = new File(Costanti.PATH_FOLDER+"\\temp\\"+filename+".pdf");
     	FileUtils.copyFile(source, targetFile);
     	
     
     	source.delete();
     
	    JsonObject myObj = new JsonObject();
	    
	   // scanFields("C:\\Users\\antonio.dicivita\\Desktop\\1.pdf");
	    
     	myObj.addProperty("success", true);
		return myObj;
		
	}
	
	
	
	public static void scanFields(String path) throws IOException, DocumentException {
	    PdfReader pdfReader = new PdfReader(path);
	    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream("C:\\Users\\antonio.dicivita\\Desktop\\2.pdf"));
	    AcroFields acroFields = pdfReader.getAcroFields();
	    AcroFields acroFields1 = stamper.getAcroFields();
	    Map<String, Item> fields = acroFields.getFields();
	    Set<Entry<String, Item>> entrySet = fields.entrySet();
	    for (Entry<String, Item> entry : entrySet) {
	        String key = entry.getKey();
	        System.out.println(key);
	    }
	    acroFields1.setField("Cognome", "PAOLINO");
	    acroFields1.setField("nome", "PAPERINO");
	
	    stamper.setFormFlattening(true);
	    stamper.close();
	    pdfReader.close();
	}
	
	
	public static boolean getReportCertificatiFirma(ArrayList<VerMisuraDTO> lista_misure) throws Exception {
		
		XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Dati File Certificati");

        // 📗 Crea l’intestazione
        String[] headers = {
            "ID Certificato", "Commessa", "Cliente", "Sede", "Matricola","Data Misura", "Data Creazione"
        };
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        int rowIndex = 1;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		
		for (VerMisuraDTO m : lista_misure) {
			
			VerCertificatoDTO certificato = GestioneVerCertificatoDAO.getCertificatoByMisura(m);
			if(certificato.getFirmato()==1) {
				String filename = certificato.getNomeCertificato();
				
				String path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+filename+".p7m";
				Path p = Paths.get(path);
				
				Row row = sheet.createRow(rowIndex++);
	
	            // Colonne base
	            row.createCell(0).setCellValue(certificato.getId());
	            row.createCell(1).setCellValue(certificato.getMisura().getVerIntervento().getCommessa());
	            row.createCell(2).setCellValue(certificato.getMisura().getVerIntervento().getNome_cliente());
	            row.createCell(3).setCellValue(certificato.getMisura().getVerIntervento().getNome_sede());
	            row.createCell(4).setCellValue(certificato.getMisura().getVerStrumento().getMatricola());
				
				if (Files.notExists(p)) {
					
					System.out.println("File non trovato: " + path);
				}else {
					
				 BasicFileAttributes attr = Files.readAttributes(p, BasicFileAttributes.class);
	
		            // Data di creazione
		            FileTime creationTime = attr.creationTime();
		            // Ultima modifica
		            FileTime lastModified = attr.lastModifiedTime();
		            // Ultimo accesso
		            FileTime lastAccess = attr.lastAccessTime();
		            
		            String dataCreazione = sdf.format(new Date(attr.creationTime().toMillis()));
		            
		            String dataMisura = sdf.format(certificato.getMisura().getDataVerificazione());
		            
		            row.createCell(5).setCellValue(dataMisura);
		            row.createCell(6).setCellValue(dataCreazione);
	
		            // Stampa in formato leggibile
		            System.out.println("ID Certificato: "+certificato.getId()+ " - Commessa - "+certificato.getMisura().getVerIntervento().getCommessa()+" Cliente: "+certificato.getMisura().getVerIntervento().getNome_cliente()+" - "+certificato.getMisura().getVerIntervento().getNome_sede()+" - Matricola: "+certificato.getMisura().getVerStrumento().getMatricola()+" - Data creazione: " + new Date(creationTime.toMillis()));
				}
			}
		}
		
		 for (int i = 0; i < headers.length; i++) {
	            sheet.autoSizeColumn(i);
	        }

	        
	        //String outputPath = "C:\\Users\\antonio.dicivita\\Desktop\\report_certificati.xlsx";
	        String outputPath = Costanti.PATH_FOLDER+"\\REPORTCERTIFICATIVERIFICAZIONE\\report_certificati.xlsx";
	        try (FileOutputStream out = new FileOutputStream(outputPath)) {
	            workbook.write(out);
	        }
	        workbook.close();
		

		System.out.println("FINE");
		
		return true;
		
	}
	
	public static void main(String[] args) throws Exception {
		new ContextListener().configCostantApplication();
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		UtenteDTO utente = GestioneUtenteBO.getUtenteById(""+40, session);
		
		XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Dati File Certificati");

        // 📗 Crea l’intestazione
        String[] headers = {
            "ID Certificato", "Commessa", "Cliente", "Sede", "Matricola","Data Misura", "Data Creazione"
        };
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        int rowIndex = 1;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		ArrayList<VerMisuraDTO> lista_misure = GestioneVerMisuraBO.getListaMisurePerData(utente, "2021-01-01", "2025-10-22", session)		;
		
		for (VerMisuraDTO m : lista_misure) {
			
			VerCertificatoDTO certificato = GestioneVerCertificatoDAO.getCertificatoByMisura(m);
			String filename = certificato.getNomeCertificato();
			
			String path = Costanti.PATH_FOLDER+"\\"+certificato.getMisura().getVerIntervento().getNome_pack()+"\\"+filename+".p7m";
			Path p = Paths.get(path);
			
			Row row = sheet.createRow(rowIndex++);

            // Colonne base
            row.createCell(0).setCellValue(certificato.getId());
            row.createCell(1).setCellValue(certificato.getMisura().getVerIntervento().getCommessa());
            row.createCell(2).setCellValue(certificato.getMisura().getVerIntervento().getNome_cliente());
            row.createCell(3).setCellValue(certificato.getMisura().getVerIntervento().getNome_sede());
            row.createCell(4).setCellValue(certificato.getMisura().getVerStrumento().getMatricola());
			
			if (Files.notExists(p)) {
				
				System.out.println("File non trovato: " + path);
			}else {
				
			 BasicFileAttributes attr = Files.readAttributes(p, BasicFileAttributes.class);

	            // Data di creazione
	            FileTime creationTime = attr.creationTime();
	            // Ultima modifica
	            FileTime lastModified = attr.lastModifiedTime();
	            // Ultimo accesso
	            FileTime lastAccess = attr.lastAccessTime();
	            
	            String dataCreazione = sdf.format(new Date(attr.creationTime().toMillis()));
	            
	            String dataMisura = sdf.format(certificato.getMisura().getDataVerificazione());
	            
	            row.createCell(5).setCellValue(dataMisura);
	            row.createCell(6).setCellValue(dataCreazione);

	            // Stampa in formato leggibile
	            System.out.println("ID Certificato: "+certificato.getId()+ " - Commessa - "+certificato.getMisura().getVerIntervento().getCommessa()+" Cliente: "+certificato.getMisura().getVerIntervento().getNome_cliente()+" - "+certificato.getMisura().getVerIntervento().getNome_sede()+" - Matricola: "+certificato.getMisura().getVerStrumento().getMatricola()+" - Data creazione: " + new Date(creationTime.toMillis()));
			}
		}
		
		 for (int i = 0; i < headers.length; i++) {
	            sheet.autoSizeColumn(i);
	        }

	        // 📁 Scrive l’Excel su file
	        String outputPath = "C:\\Users\\antonio.dicivita\\Desktop\\report_certificati.xlsx";
	       // String outputPath = Costanti.PATH_FOLDER+"\\REPORTCERTIFICATIVERIFICAZIONE\\report_certificati.xlsx";
	        try (FileOutputStream out = new FileOutputStream(outputPath)) {
	            workbook.write(out);
	        }
	        workbook.close();
		
		session.getTransaction().commit();
		session.close();
		
		System.out.println("FINE");
	}

}
