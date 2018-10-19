package it.portaleSTI.bo;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.lowagie.text.pdf.hyphenation.TernaryTree.Iterator;

import TemplateReport.PivotTemplate;
import ar.com.fdvs.dj.domain.ImageBanner.Alignment;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ContextListener;
import net.sf.jasperreports.engine.export.oasis.RowStyle;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFPicture;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFShape;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class CreateSchedaRilievoExcel {
	
	
	public CreateSchedaRilievoExcel(RilMisuraRilievoDTO rilievo, List<SedeDTO> listaSedi, String path_simboli, Session session) throws Exception {
		
		build(rilievo, listaSedi, path_simboli, session);
		
	}

	private void build(RilMisuraRilievoDTO rilievo, List<SedeDTO> listaSedi, String path_simboli, Session session) throws Exception {
	
		creaExcel(rilievo, listaSedi, path_simboli, session);

	}

	@SuppressWarnings("deprecation")
	private void creaExcel(RilMisuraRilievoDTO rilievo, List<SedeDTO> listaSedi, String path_simboli, Session session) throws Exception {
		
		
		 ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(rilievo.getId(), session);	
	
		 FileInputStream file = new FileInputStream(PivotTemplate.class.getResource("template_excel.xlsx").getFile());

         XSSFWorkbook workbook = new XSSFWorkbook(file);
         CreationHelper helper = workbook.getCreationHelper();         
		 XSSFSheet sheet0 = workbook.getSheetAt(0);
		 if(rilievo.getId_sede_util()!=0) {
			 sheet0.getRow(6).getCell(5).setCellValue(GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, rilievo.getId_sede_util(), rilievo.getId_cliente_util()).getDescrizione());
		 }else {
			 sheet0.getRow(6).getCell(5).setCellValue(GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(rilievo.getId_cliente_util())).getNome());
		 }
		 sheet0.getRow(6).getCell(18).setCellValue(rilievo.getId());
         sheet0.getRow(16).getCell(10).setCellValue(rilievo.getDisegno());
         sheet0.getRow(19).getCell(10).setCellValue(rilievo.getVariante());
         sheet0.getRow(22).getCell(10).setCellValue("");
         sheet0.getRow(25).getCell(10).setCellValue(rilievo.getFornitore());
         sheet0.getRow(28).getCell(10).setCellValue(rilievo.getApparecchio());

         int count=0;
         int n_pezzi = 0;
         for (RilParticolareDTO part : lista_particolari) {
			if(part.getNome_impronta()!=null && !part.getNome_impronta().equals("")) {
				count++;				
				n_pezzi = part.getNumero_pezzi();
			}			
         }
 
         sheet0.getRow(31).getCell(7).setCellValue(count);
         sheet0.getRow(31).getCell(11).setCellValue(n_pezzi);
         sheet0.getRow(31).getCell(18).setCellValue(n_pezzi*count);
         sheet0.getRow(61).getCell(6).setCellValue(rilievo.getData_consegna());
         sheet0.getRow(61).getCell(13).setCellValue(rilievo.getUtente().getNominativo());
         
         FileInputStream img = null;
         if(rilievo.getImmagine_frontespizio()!= null && !rilievo.getImmagine_frontespizio().equals("")) {
        	 img = new FileInputStream(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\Immagini\\"+rilievo.getId()+"\\"+rilievo.getImmagine_frontespizio());
         }
         if(img !=null) {
	         byte[] bytes = IOUtils.toByteArray(img);
	         
	         int pictureureIdx = workbook.addPicture(bytes, Workbook.PICTURE_TYPE_JPEG);
	         
	         Drawing drawing = sheet0.createDrawingPatriarch();
	
	         ClientAnchor anchor = helper.createClientAnchor();
	
	         anchor.setCol1(6);
	         anchor.setRow1(36);
	         anchor.setCol2(18);
	         anchor.setRow2(53);

	
	         Picture  my_picture = drawing.createPicture(anchor, pictureureIdx);
         }
         
		 Font headerFont = workbook.createFont();
	     headerFont.setBold(true);
	     headerFont.setFontHeightInPoints((short) 14);
	     headerFont.setColor(IndexedColors.RED.getIndex());		
	     	        
	     CellStyle headerCellStyle = workbook.createCellStyle();
	     headerCellStyle.setFont(headerFont); 
	     headerCellStyle.setAlignment(HorizontalAlignment.CENTER);	     
	     headerCellStyle.setBorderBottom(BorderStyle.THIN);
	     headerCellStyle.setBorderTop(BorderStyle.THIN);
	     headerCellStyle.setBorderLeft(BorderStyle.THIN);
	     headerCellStyle.setBorderRight(BorderStyle.THIN);
	        
	     CellStyle redStyle = workbook.createCellStyle();
	     redStyle.setFillForegroundColor(IndexedColors.RED.getIndex());
	     redStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	     redStyle.setBorderBottom(BorderStyle.THIN);
	     redStyle.setBorderTop(BorderStyle.THIN);
	     redStyle.setBorderLeft(BorderStyle.THIN);
	     redStyle.setBorderRight(BorderStyle.THIN);
	     redStyle.setAlignment(HorizontalAlignment.CENTER);
	        
	     CellStyle defaultStyle = workbook.createCellStyle();
	     defaultStyle.setAlignment(HorizontalAlignment.CENTER);
	     defaultStyle.setAlignment(HorizontalAlignment.CENTER);	     
	     defaultStyle.setBorderBottom(BorderStyle.THIN);
	     defaultStyle.setBorderTop(BorderStyle.THIN);
	     defaultStyle.setBorderLeft(BorderStyle.THIN);
	     defaultStyle.setBorderRight(BorderStyle.THIN);
	     	        
	     int index_particolare = 1;
		 for (RilParticolareDTO particolare : lista_particolari) {
			 
			 XSSFSheet sheet = null;
			 if(particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
				 sheet = workbook.createSheet(particolare.getNome_impronta());
			 }else {
				 sheet = workbook.createSheet("Particolare "+ index_particolare);	 
			 }
			 creaHeader(particolare, rilievo, sheet, index_particolare, listaSedi, workbook);	 		 

		     Row headerRow = sheet.createRow(6);
		       
		     ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(particolare.getId(), session);
	
		     headerRow.createCell(0).setCellValue("COORDINATA");
		     headerRow.getCell(0).setCellStyle(headerCellStyle);
		     headerRow.createCell(1).setCellValue("SIMBOLO");
			 headerRow.getCell(1).setCellStyle(headerCellStyle);
			 headerRow.createCell(2).setCellValue("VALORE NOMINALE");
		     headerRow.getCell(2).setCellStyle(headerCellStyle);
		     headerRow.createCell(3).setCellValue("FUNZIONALE");
		     headerRow.getCell(3).setCellStyle(headerCellStyle);
		     headerRow.createCell(4).setCellValue("U.M.");
		     headerRow.getCell(4).setCellStyle(headerCellStyle);
		     headerRow.createCell(5).setCellValue("TOLLERANZA");
		     headerRow.getCell(5).setCellStyle(headerCellStyle);
		     
		     if(lista_quote.size()>0) {
			     for(int i = 0; i<lista_quote.get(0).getListaPuntiQuota().size();i++) {
			      	headerRow.createCell(6 + i).setCellValue("PEZZO "+ (i+1));
			     	headerRow.getCell(6+i).setCellStyle(headerCellStyle);
			     }		     
	
		     headerRow.createCell(6+lista_quote.get(0).getListaPuntiQuota().size()).setCellValue("NOTE");
		     headerRow.getCell(6+lista_quote.get(0).getListaPuntiQuota().size()).setCellStyle(headerCellStyle);
		     }
		     int rowNum = 7;
		     for (RilQuotaDTO quota : lista_quote) {
		     	 Row row = sheet.createRow(rowNum++);
		     	  
		     	 row.createCell(0).setCellValue(quota.getCoordinata());
		     	 row.getCell(0).setCellStyle(defaultStyle);
		     	 if(quota.getSimbolo()!=null) {
		     		 row.createCell(1);
		     		 FileInputStream img_simbolo = new FileInputStream(path_simboli + "\\simboli_rilievi\\"+quota.getSimbolo().getDescrizione()+".bmp");
		    
		     	     byte[] bytesArr = IOUtils.toByteArray(img_simbolo);
			         
			         int pictureureIdx = workbook.addPicture(bytesArr, Workbook.PICTURE_TYPE_PNG);
			         
			         Drawing drawing = sheet.createDrawingPatriarch();
			
			         ClientAnchor anchor = helper.createClientAnchor();
			

			         anchor.setCol1(1);
			         anchor.setCol2(2);			        
			         anchor.setRow1(row.getRowNum());			       
			         anchor.setRow2(row.getRowNum()+1);

			         Picture  my_picture = drawing.createPicture(anchor, pictureureIdx);
			         
			         my_picture.resize(0.55 * my_picture.getImageDimension().getWidth() / XSSFShape.PIXEL_DPI, 0.75 * my_picture.getImageDimension().getHeight() / XSSFShape.PIXEL_DPI);
			     //    System.out.println(my_picture.getImageDimension());
		     	 }else {
		     		row.createCell(1).setCellValue("");
		     	 }
		     	 
		     	// row.createCell(1).setCellValue("simbolo");
		     	 row.getCell(1).setCellStyle(defaultStyle);
		         if(quota.getVal_nominale()!=null) {
		        	 row.createCell(2).setCellValue(quota.getVal_nominale().doubleValue());	 
		         }else {
		        	 row.createCell(2).setCellValue("");
		         }	
		         row.getCell(2).setCellStyle(defaultStyle);
		         if(quota.getQuota_funzionale()!=null) {
		        	 row.createCell(3).setCellValue(quota.getQuota_funzionale().getDescrizione());
		         }else{
		        	 row.createCell(3).setCellValue("");
		         }
		         row.getCell(3).setCellStyle(defaultStyle);		         
		         row.createCell(4).setCellValue(quota.getUm());
		         row.getCell(4).setCellStyle(defaultStyle);	         
		         
		     	 if(quota.getTolleranza_negativa()!=null && quota.getTolleranza_positiva()!=null) {
		     		 if(Math.abs(quota.getTolleranza_negativa().doubleValue()) == Math.abs(quota.getTolleranza_positiva().doubleValue())) {
		     			row.createCell(5).setCellValue("±" +Math.abs(quota.getTolleranza_negativa().doubleValue()));
		     		 }else {
		     			row.createCell(5).setCellValue(quota.getTolleranza_negativa().doubleValue() + " ÷ " +  Math.abs(quota.getTolleranza_positiva().doubleValue()));
		     		 }		     		 
		     	 }else {
		     		 row.createCell(5).setCellValue("");
		     	 }		     	
		     	 row.getCell(5).setCellStyle(defaultStyle);

		         List list = new ArrayList(quota.getListaPuntiQuota());
		 			Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
		 			    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
		 			    	Integer obj1 = o1.getId();
		 			    	Integer obj2 = o2.getId();
		 			        return obj1.compareTo(obj2);
		 			    }
		 			});
		 		if(list.size()>0) {
		         for(int i = 0; i<list.size();i++) {
		        	 RilPuntoQuotaDTO punto = (RilPuntoQuotaDTO) list.get(i);
		        	 if(punto.getValore_punto()!=null) {
		        		 row.createCell(i+6).setCellValue(punto.getValore_punto().doubleValue());
		        		 if(punto.getValore_punto().doubleValue() < quota.getVal_nominale().doubleValue() - Math.abs(quota.getTolleranza_negativa().doubleValue()) 
		        			 || punto.getValore_punto().doubleValue() > quota.getVal_nominale().doubleValue() + Math.abs(quota.getTolleranza_positiva().doubleValue())){
		        			row.getCell(i+6).setCellStyle(redStyle);
		        		 }else {
		        			 row.getCell(i+6).setCellStyle(defaultStyle);
		        		 }
		        	 }else {
		        		 row.createCell(i+6).setCellValue("");
		        		 row.getCell(i+6).setCellStyle(defaultStyle);
		        	 }
		         }
		        	 
		         row.createCell(list.size() + 6).setCellValue(quota.getNote());
		         row.getCell(list.size()+6).setCellStyle(defaultStyle);
		 		}
			}
		        
		    for(int i = 0; i < particolare.getNumero_pezzi()+7; i++) {
		        sheet.autoSizeColumn(i);
		    }
		        

		    index_particolare++;
		 }
		 
		 String path = Costanti.PATH_FOLDER + "RilieviDimensionali\\Schede\\" + rilievo.getId() + "\\Excel\\";
		
			if(!new File(path).exists()) {
				new File(path).mkdirs();
			}
	        FileOutputStream fileOut = new FileOutputStream(path+ "scheda_rilievo.xlsx");
	        workbook.write(fileOut);
	        fileOut.close();

	        workbook.close();
	}
	
	
	public void creaHeader(RilParticolareDTO particolare, RilMisuraRilievoDTO rilievo, XSSFSheet sheet, int k, List<SedeDTO> listaSedi, XSSFWorkbook workbook) throws Exception {
		
	     Font fontTitle = workbook.createFont();
	     fontTitle.setBold(true);
	     fontTitle.setFontHeightInPoints((short) 18);	        
	     fontTitle.setColor(IndexedColors.BLACK.getIndex());
	     
	     CellStyle headerPageStyle = workbook.createCellStyle();
	     headerPageStyle.setFont(fontTitle); 
	     headerPageStyle.setAlignment(HorizontalAlignment.CENTER);
	     headerPageStyle.setBorderBottom(BorderStyle.THIN);
	     headerPageStyle.setBorderTop(BorderStyle.THIN);
	     headerPageStyle.setBorderLeft(BorderStyle.THIN);
	     headerPageStyle.setBorderRight(BorderStyle.THIN);
		
		 Font font = workbook.createFont();
		 font.setBold(false);
	     font.setFontHeightInPoints((short) 12);	        
	     font.setColor(IndexedColors.BLACK.getIndex());
	     
	     CellStyle defaultStyle = workbook.createCellStyle();
	     defaultStyle.setFont(font); 
	     defaultStyle.setAlignment(HorizontalAlignment.LEFT);
	     defaultStyle.setBorderBottom(BorderStyle.THIN);
	     defaultStyle.setBorderTop(BorderStyle.THIN);
	     defaultStyle.setBorderLeft(BorderStyle.THIN);
	     defaultStyle.setBorderRight(BorderStyle.THIN);
		
		for(int i = 0;i<5;i++) {
			for(int j = 0;j<particolare.getNumero_pezzi()+13;j++) {
				if(j==0) {
					sheet.createRow(i).createCell(j);
					sheet.getRow(i).getCell(j).setCellStyle(headerPageStyle);
				}else {
					sheet.getRow(i).createCell(j);
					sheet.getRow(i).getCell(j).setCellStyle(headerPageStyle);	
				}				
			}
		}		
		
		 CellRangeAddress region1 = new CellRangeAddress(0, 1, 0, 4);
		 CellRangeAddress region2 = new CellRangeAddress(0, 1, 5, 11);
		 CellRangeAddress region6 = new CellRangeAddress(0, 1, 12, particolare.getNumero_pezzi()+12);
		 CellRangeAddress region3 = new CellRangeAddress(2, 2, 0, particolare.getNumero_pezzi()+12);
		 CellRangeAddress region4 = new CellRangeAddress(3, 3, 0, particolare.getNumero_pezzi()+12);
		 CellRangeAddress region5 = new CellRangeAddress(4, 4, 0, particolare.getNumero_pezzi()+12);

		 sheet.addMergedRegion(region1);
		 sheet.addMergedRegion(region2);
		 sheet.addMergedRegion(region3);
		 sheet.addMergedRegion(region4);
		 sheet.addMergedRegion(region5);
		 sheet.addMergedRegion(region6);
	
		 if(particolare.getNome_impronta() != null && !particolare.getNome_impronta().equals("")) {
			 sheet.getRow(0).getCell(0).setCellValue(particolare.getNome_impronta());	 
		 }else {
			 sheet.getRow(0).getCell(0).setCellValue("Particolare "+ k);
		 }
		 if(rilievo.getId_sede_util()!=0) {
			 sheet.getRow(0).getCell(5).setCellValue(GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, rilievo.getId_sede_util(), rilievo.getId_cliente_util()).getDescrizione());	 
		 }else {
			 sheet.getRow(0).getCell(5).setCellValue(GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(rilievo.getId_cliente_util())).getNome());
		 }		 
		 sheet.getRow(0).getCell(12).setCellValue("SCHEDA NUMERO: SRD "+rilievo.getId());
		 sheet.getRow(2).getCell(0).setCellValue("IN ROSSO LE QUOTE NON CONFORMI");	
		 sheet.getRow(2).getCell(0).setCellStyle(defaultStyle);
		 sheet.getRow(3).getCell(0).setCellValue("Note:  ");
		 sheet.getRow(3).getCell(0).setCellStyle(defaultStyle);
		 sheet.getRow(4).getCell(0).setCellValue("- SCHEDA RILIEVI DIMENSIONALI -");	

	}
	
	
//	public static void main(String[] args) throws HibernateException, Exception {
//	new ContextListener().configCostantApplication();
//	Session session=SessionFacotryDAO.get().openSession();
//	session.beginTransaction();
//	
//		RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(19, session);
//		List<SedeDTO> listaSedi = GestioneAnagraficaRemotaBO.getListaSedi();
//		new CreateSchedaRilievoExcel(rilievo,listaSedi, "C:\\Users\\antonio.dicivita\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images",session);
//		System.out.println("FINITO");
//		session.close();
//}
	

}
