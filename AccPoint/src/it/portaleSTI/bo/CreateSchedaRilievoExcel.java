package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.PrintOrientation;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.util.IOUtils;
import org.apache.poi.util.Units;
import org.apache.poi.xssf.usermodel.XSSFShape;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ContextListener;

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
		 ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(rilievo.getId(), session);
	
		 InputStream file = PivotTemplate.class.getResourceAsStream("template_excel.xlsx");

         XSSFWorkbook workbook = new XSSFWorkbook(file);
         
         CreationHelper helper = workbook.getCreationHelper();         
		 XSSFSheet sheet0 = workbook.getSheetAt(0);
		
		 sheet0.setMargin(Sheet.RightMargin, 0.39);
		 sheet0.setMargin(Sheet.LeftMargin, 0.39);
		 sheet0.setMargin(Sheet.TopMargin, 0.39);
		 sheet0.setMargin(Sheet.BottomMargin, 0.39);
		 sheet0.setMargin(Sheet.HeaderMargin, 0.157);
		 sheet0.setMargin(Sheet.FooterMargin, 0.39);		
		 sheet0.getPrintSetup().setPaperSize(PrintSetup.A4_PAPERSIZE);
		 sheet0.getPrintSetup().setScale((short)85);
		 if(rilievo.getId_sede_util()!=0) {
			 sheet0.getRow(6).getCell(5).setCellValue(GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, rilievo.getId_sede_util(), rilievo.getId_cliente_util()).getDescrizione());
		 }else {
			 sheet0.getRow(6).getCell(5).setCellValue(GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(rilievo.getId_cliente_util())).getNome());
		 }
		 sheet0.getRow(6).getCell(18).setCellValue(rilievo.getId());
		 sheet0.getRow(13).getCell(10).setCellValue(rilievo.getDenominazione());
         sheet0.getRow(16).getCell(10).setCellValue(rilievo.getDisegno());
         sheet0.getRow(19).getCell(10).setCellValue(rilievo.getVariante());
         sheet0.getRow(22).getCell(10).setCellValue(rilievo.getMateriale());
         sheet0.getRow(25).getCell(10).setCellValue(rilievo.getFornitore());
         sheet0.getRow(28).getCell(10).setCellValue(rilievo.getApparecchio());

         int count=0;
         int n_pezzi = 0;
         if(lista_impronte.size()>0) {
        	 n_pezzi = lista_impronte.get(0).getNumero_pezzi();
        	 count = lista_impronte.size();
         }else {
        	 if(lista_particolari.size()>0) {
        		 n_pezzi = lista_particolari.get(0).getNumero_pezzi();	 
        	 }        	        			
         }
 
         sheet0.getRow(31).getCell(7).setCellValue(count);
         sheet0.getRow(31).getCell(11).setCellValue(n_pezzi);   
         if(lista_impronte.size()>0) {
        	 sheet0.getRow(31).getCell(18).setCellValue(n_pezzi*count);
         }else {
        	 sheet0.getRow(31).getCell(18).setCellValue(n_pezzi);        	 
         }             	
         
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
			         anchor.setDx1(35 * Units.EMU_PER_PIXEL);
			         anchor.setDy1(1 * Units.EMU_PER_PIXEL);
			        
			         
			         Picture  my_picture = drawing.createPicture(anchor, pictureureIdx);
			         
			         my_picture.resize(0.70 * my_picture.getImageDimension().getWidth() / XSSFShape.PIXEL_DPI, 0.80 * my_picture.getImageDimension().getHeight() / XSSFShape.PIXEL_DPI);
			   
		     	 }else {
		     		row.createCell(1).setCellValue("");
		     	 }
		     	
		     	 row.getCell(1).setCellStyle(defaultStyle);
		         if(quota.getVal_nominale()!=null) {		        	
		        	 row.createCell(2).setCellValue(quota.getVal_nominale());		        	 
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
		     		if(NumberUtils.isNumber(quota.getTolleranza_negativa())&&NumberUtils.isNumber(quota.getTolleranza_positiva())) {
			     		 if(Math.abs(new Double(quota.getTolleranza_negativa())) == Math.abs(new Double(quota.getTolleranza_positiva()))) {
			     			row.createCell(5).setCellValue("±" +Math.abs(new Double(quota.getTolleranza_negativa())));
			     		 }else {
			     			row.createCell(5).setCellValue(quota.getTolleranza_negativa() + " ÷ " +  Math.abs(new Double(quota.getTolleranza_positiva())));
			     		 }	
		     		}else {
		     			row.createCell(5).setCellValue("/");
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
		        		 row.createCell(i+6).setCellValue(punto.getValore_punto());
		        		 if(NumberUtils.isNumber(punto.getValore_punto()) && NumberUtils.isNumber(quota.getTolleranza_negativa()) && NumberUtils.isNumber(quota.getTolleranza_positiva())&& NumberUtils.isNumber(quota.getVal_nominale())) {
		        			 if(new Double(punto.getValore_punto()) < new Double(quota.getVal_nominale()) - Math.abs(new Double(quota.getTolleranza_negativa())) 
				        			 || new Double(punto.getValore_punto()) > new Double(quota.getVal_nominale())+ Math.abs(new Double(quota.getTolleranza_positiva()))){
				        			row.getCell(i+6).setCellStyle(redStyle);
				        		 }else {
				        			 row.getCell(i+6).setCellStyle(defaultStyle);
				        		 }		        			 
		        		 }else {
		        			 if(!punto.getValore_punto().equals("KO")) {
		        				 row.getCell(i+6).setCellStyle(defaultStyle);
		        			 }else {
		        				 row.getCell(i+6).setCellStyle(redStyle);
		        			 }
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
		 sheet.getRow(3).getCell(0).setCellValue("Note:  "+particolare.getNote());
		 sheet.getRow(3).getCell(0).setCellStyle(defaultStyle);
		 sheet.getRow(4).getCell(0).setCellValue("- SCHEDA RILIEVI DIMENSIONALI -");	

	}
	
	
	public static void main(String[] args) throws HibernateException, Exception {
	new ContextListener().configCostantApplication();
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	
		RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(27, session);
		List<SedeDTO> listaSedi = GestioneAnagraficaRemotaBO.getListaSedi();
		new CreateSchedaRilievoExcel(rilievo,listaSedi, "C:\\Users\\antonio.dicivita\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images",session);
		System.out.println("FINITO");
		session.close();
}
	

}
