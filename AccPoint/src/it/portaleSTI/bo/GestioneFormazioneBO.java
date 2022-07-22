package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.pdfbox.multipdf.Splitter;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.itextpdf.text.Annotation;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.parser.ImageRenderInfo;
import com.itextpdf.text.pdf.parser.PdfReaderContentParser;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;
import com.itextpdf.text.pdf.parser.RenderListener;
import com.itextpdf.text.pdf.parser.TextRenderInfo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForEmailDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForQuestionarioDTO;
import it.portaleSTI.DTO.ForReferenteDTO;
import it.portaleSTI.DTO.ForRuoloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import org.apache.commons.lang3.StringUtils;

public class GestioneFormazioneBO {
	static final Logger logger = Logger.getLogger(GestioneFormazioneBO.class);

	public static ArrayList<ForDocenteDTO> getListaDocenti(Session session) {
	
		return GestioneFormazioneDAO.getListaDocenti(session);
	}

	public static ForDocenteDTO getDocenteFromId(int id_docente, Session session) {
		
		return GestioneFormazioneDAO.getDocenteFromId(id_docente, session);
	}

	public static ArrayList<ForCorsoCatDTO> getListaCategorieCorsi(Session session) {
		
		return GestioneFormazioneDAO.getListaCategorieCorsi(session);
	}

	public static ForCorsoCatDTO getCategoriaCorsoFromId(int id_categoria, Session session) {

		return GestioneFormazioneDAO.getCategoriaCorsoFromId(id_categoria, session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsi(Session session) {
		
		return GestioneFormazioneDAO.getListaCorsi(session);
	}

	public static ForCorsoDTO getCorsoFromId(int id_corso, Session session) {

		return GestioneFormazioneDAO.getCorsoFromId(id_corso, session);
	}


	public static ArrayList<ForCorsoAllegatiDTO>  getAllegatiCorso(int id_corso, Session session) {

		return GestioneFormazioneDAO.getAllegatiCorso(id_corso, session);
		
	}

	public static ArrayList<ForCorsoCatAllegatiDTO> getAllegatiCategoria(int id_categoria, Session session) {
	
		return GestioneFormazioneDAO.getAllegatiCategoria(id_categoria, session);
	}

	public static ForCorsoAllegatiDTO getAllegatoCorsoFormId(int id_allegato, Session session) {
		
		return GestioneFormazioneDAO.getAllegatoCorsoFormId(id_allegato, session);
	}
	
	public static ForCorsoCatAllegatiDTO getAllegatoCorsoCategoriaFormId(int id_allegato, Session session) {
		
		return GestioneFormazioneDAO.getAllegatoCategoriaFormId(id_allegato, session);
	}

	public static ArrayList<ForPartecipanteDTO> getListaPartecipanti(Session session) throws Exception {
		
		return DirectMySqlDAO.getListaPartecipantiDirect(session);
	}

	public static ForPartecipanteDTO getPartecipanteFromId(int id_partecipante, Session session) {
		
		return GestioneFormazioneDAO.getPartecipanteFromId(id_partecipante,session);
	}

	public static ArrayList<ForRuoloDTO> getListaRuoli(Session session) {
		
		return GestioneFormazioneDAO.getListaRuoli(session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorso(int id, Session session) {
		
		return GestioneFormazioneDAO.getListaPartecipantiCorso(id,session);
	}

	public static ForPartecipanteRuoloCorsoDTO getPartecipanteFromCorso(int id_corso, int id_partecipante, int id_ruolo, Session session) {
	
		return GestioneFormazioneDAO.getPartecipanteFromCorso(id_corso,id_partecipante, id_ruolo, session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaCorsiFromPartecipante(int id_partecipante, Session session) {

		return GestioneFormazioneDAO.getListaCorsiFromPartecipante(id_partecipante, session);
	}

	public static HashMap<String, Integer> getListaScadenzeCorsi(int id_partecipante, Session session) {
		
		return GestioneFormazioneDAO.getListaScadenzeCorsi(id_partecipante, session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiPartecipanteScadenza(int id_partecipante, String data_scadenza, Session session) throws Exception {
		
		return GestioneFormazioneDAO.getListaCorsiPartecipanteScadenza(id_partecipante, data_scadenza, session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorso(String dateFrom, String dateTo, String tipo_data, String id_azienda, String id_sede, Session session) throws Exception {
		
		return GestioneFormazioneDAO.getListaPartecipantiRuoloCorso(dateFrom, dateTo, tipo_data, id_azienda, id_sede, session);
	}

	public static int importaDaExcel(FileItem fileItem, int id_azienda,String nome_azienda, int id_sede, String nome_sede, Session session) throws Exception {
		
		
		File file = new File(Costanti.PATH_FOLDER+"temp//tempImportazione.xlsx");
		fileItem.write(file);
		int esito_generale = 0;
		FileInputStream fis = new FileInputStream(file);   //obtaining bytes from the file  
		//creating Workbook instance that refers to .xlsx file  
		XSSFWorkbook wb = new XSSFWorkbook(fis);   
		XSSFSheet sheet = wb.getSheetAt(0);     //creating a Sheet object to retrieve object  
		Iterator<Row> itr = sheet.iterator();    //iterating over excel file  
		
		ArrayList<String> codiciFiscali = GestioneFormazioneDAO.getListaCodiciFiscali(session);

		while (itr.hasNext())                 
		{  
			Row row = itr.next();  
			Iterator<Cell> cellIterator = row.cellIterator();   //iterating over each column  
			
			ForPartecipanteDTO partecipante = null;		
			
			String nome = null;
			String cognome = null;
			String cf = null;
			String luogo_nascita = null;
			Date data_nascita = null;
			int id_ruolo = 0;
			int id_corso = 0;
			String ore_partecipate = null;
			
			while (cellIterator.hasNext())   
			{  
				Cell cell = cellIterator.next();  
				
				if(cell.getRowIndex()==0) {
					if(row.getCell(0)== null || row.getCell(1) == null || row.getCell(2)==null || row.getCell(3)== null || row.getCell(4)==null
							|| !row.getCell(0).getStringCellValue().equals("NOME") || !row.getCell(1).getStringCellValue().equals("COGNOME") 
							|| !row.getCell(2).getStringCellValue().equals("DATA DI NASCITA") || !row.getCell(3).getStringCellValue().equals("LUOGO DI NASCITA") 
							|| !row.getCell(4).getStringCellValue().equals("CODICE FISCALE") ) {
						esito_generale = 1;
						break;
					}
				}
				
				if(esito_generale == 0 && cell.getRowIndex()!=0) {
					if(cell.getCellType() == Cell.CELL_TYPE_STRING ) {
						
						if(cell.getStringCellValue()!=null && !cell.getStringCellValue().equals("") )
						{
							
							if(cell.getColumnIndex()==0) {
								nome = cell.getStringCellValue();
							}
							else if(cell.getColumnIndex()==1) {
								cognome = cell.getStringCellValue();
							}	
							else if(cell.getColumnIndex()==3) {
								luogo_nascita = cell.getStringCellValue();
							}
							else if(cell.getColumnIndex()==4) {
								cf = cell.getStringCellValue();
							}
							
							
						}
						
					}else {
						
						if(cell.getDateCellValue()!=null && cell.getColumnIndex()==2) {							
							data_nascita = cell.getDateCellValue();						
						}						
						else if(cell.getColumnIndex()==5 ) {
							id_corso = (int) cell.getNumericCellValue();
						}
						else if(cell.getColumnIndex()==6 ) {
							id_ruolo =  (int) cell.getNumericCellValue();								
						}else if(cell.getColumnIndex()==7 ) {
							ore_partecipate = ""+cell.getNumericCellValue();
						}
					}	
				}
			
			}
			if(row.getRowNum()!=0) {
				if(!codiciFiscali.contains(cf)) {
					partecipante= new ForPartecipanteDTO();		
					partecipante.setId_azienda(id_azienda);
					partecipante.setId_sede(id_sede);
					partecipante.setNome_azienda(nome_azienda);
					partecipante.setNome_sede(nome_sede);	
					
				}else {
					partecipante = getPartecipanteFromCf(cf, session);
				}
				
				if(partecipante!=null) {
					partecipante.setNome(nome);
					partecipante.setCognome(cognome);
					partecipante.setData_nascita(data_nascita);
					partecipante.setLuogo_nascita(luogo_nascita);
					partecipante.setCf(cf);
					session.saveOrUpdate(partecipante);	
					
					
					if(id_corso!=0 && id_ruolo!=0 && ore_partecipate!=null) {
						ForPartecipanteRuoloCorsoDTO p = new ForPartecipanteRuoloCorsoDTO();
						ForCorsoDTO corso = getCorsoFromId(id_corso, session);
						p.setCorso(corso);
						p.setPartecipante(partecipante);
						p.setRuolo(new ForRuoloDTO(id_ruolo));
						p.setOre_partecipate(Double.parseDouble(ore_partecipate));
						session.saveOrUpdate(p);
					}
				}
				
			}
			
		}
		
		
		file.delete();

		return esito_generale;
	}

	public static ArrayList<ForPartecipanteDTO> getListaPartecipantiCliente(int idCliente, int idSede, Session session) {
		
		return GestioneFormazioneDAO.getListaPartecipantiCliente(idCliente,idSede,session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiCliente(int idCliente, int idSede, Session session) {
		
		return GestioneFormazioneDAO.getListaCorsiCliente(idCliente,idSede, session);
	}
	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorsoCliente(String dateFrom, String dateTo, String tipo_data, int idCliente, int idSede, Session session) throws Exception {
		
		return GestioneFormazioneDAO.getListaPartecipantiRuoloCorsoCliente(dateFrom, dateTo, tipo_data,idCliente,idSede, session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorsoCliente(int id, int idCliente, int idSede, Session session) {

		return GestioneFormazioneDAO.getListaPartecipantiCorsoCliente(id,idCliente,idSede,session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaCorsiConsuntivo(String dateFrom, String dateTo, int id_cliente, int id_sede, Session session) throws Exception {
		
		return GestioneFormazioneDAO.getListaCorsiConsuntivo(dateFrom, dateTo, id_cliente, id_sede, session);
	}

	public static ForQuestionarioDTO getQuestionarioFromId(int id_questionario, Session session) {
		
		return GestioneFormazioneDAO.GestioneFormazioneDAO(id_questionario,session);
	}
	
	public static ArrayList<String> getListaAziendeConPartecipanti(Session session) {
		
		return GestioneFormazioneDAO.getListaAziendeConPartecipanti(session);
	}

	public static ForPartecipanteDTO getPartecipanteFromCf(String cf,Session session) {
		
		return GestioneFormazioneDAO.getPartecipanteFromCf(cf,session);
	}
		

	public static void createReportPartecipanti(ArrayList<ForPartecipanteRuoloCorsoDTO> lista) throws Exception {

	        XSSFWorkbook workbook = new XSSFWorkbook();         
	           
			 XSSFSheet sheet0 = workbook.createSheet("Report partecipanti");
			 
			 workbook.setSheetOrder("Report partecipanti", 0);
			 workbook.setActiveSheet(0);
			 sheet0.setSelected(true);			 
			 
			 sheet0.setMargin(Sheet.RightMargin, 0.39);
			 sheet0.setMargin(Sheet.LeftMargin, 0.39);
			 sheet0.setMargin(Sheet.TopMargin, 0.39);
			 sheet0.setMargin(Sheet.BottomMargin, 0.39);
			 sheet0.setMargin(Sheet.HeaderMargin, 0.157);
			 sheet0.setMargin(Sheet.FooterMargin, 0.39);		
			 Font headerFont = workbook.createFont();
		     headerFont.setBold(false);
		     headerFont.setFontHeightInPoints((short) 12);
		     headerFont.setColor(IndexedColors.BLACK.getIndex());		
		
		     CellStyle greenStyle = workbook.createCellStyle();

		     greenStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
		     greenStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    
		     greenStyle.setBorderBottom(BorderStyle.THIN);
		     greenStyle.setBorderTop(BorderStyle.THIN);
		     greenStyle.setBorderLeft(BorderStyle.THIN);
		     greenStyle.setBorderRight(BorderStyle.THIN);
		     greenStyle.setAlignment(HorizontalAlignment.CENTER);
		     greenStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		     greenStyle.setFont(headerFont);
			
		     CellStyle titleStyle = workbook.createCellStyle();
		        
		     titleStyle.setBorderBottom(BorderStyle.THIN);
		     titleStyle.setBorderTop(BorderStyle.THIN);
		     titleStyle.setBorderLeft(BorderStyle.THIN);
		     titleStyle.setBorderRight(BorderStyle.THIN);
		     titleStyle.setAlignment(HorizontalAlignment.CENTER);
		     titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		     titleStyle.setFont(headerFont);
		     
		     
			 Row rowHeader = sheet0.createRow(0);

			 for(int j = 0; j<9; j++) {
				 rowHeader.createCell(j);
				 
				 rowHeader.getCell(j).setCellStyle(greenStyle);
			 }
			 
		
			 sheet0.getRow(0).getCell(0).setCellValue("Nome");
			 
			 sheet0.getRow(0).getCell(1).setCellValue("Cognome");
			 
			 sheet0.getRow(0).getCell(2).setCellValue("Data di nascita");	
			 
			 sheet0.getRow(0).getCell(3).setCellValue("Codice fiscale");	
			 		 
			 sheet0.getRow(0).getCell(4).setCellValue("Azienda");		 
			 
			 sheet0.getRow(0).getCell(5).setCellValue("Sede");
			 		 
			 sheet0.getRow(0).getCell(6).setCellValue("Corso");		 
			 
			 sheet0.getRow(0).getCell(7).setCellValue("Commessa");
			 
			 sheet0.getRow(0).getCell(8).setCellValue("Ore partecipate");		 
			 			 
	  
		     int row_index = 0;	        
		     for (int i = 0; i<lista.size();i++) {
		    	 
		    	 Row row = sheet0.createRow(1+row_index);
		    	 
		    	 ForPartecipanteRuoloCorsoDTO partecipante = lista.get(i);
		    	 
		    	 int col = 0;
		    	 
		    	 Cell cell = row.createCell(col);
		    	 
		 		 cell.setCellValue(partecipante.getPartecipante().getNome());

		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 cell.setCellValue(partecipante.getPartecipante().getCognome());
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
			 	 SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			 	 
			 	 if(partecipante.getPartecipante().getData_nascita()!=null) {
			 		cell.setCellValue(df.format(partecipante.getPartecipante().getData_nascita())+"");	 
			 	 }else {
			 		cell.setCellValue("");
			 	 }
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 if(partecipante.getPartecipante().getCf()!=null) {
		    		 cell.setCellValue(partecipante.getPartecipante().getCf());		  
		    	 }else {
		    		 cell.setCellValue("");		  	 
		    	 }
		    	   	 
	    	 
		    	 col++;
		    	 cell = row.createCell(col);	    	 
		    	 
		    	 if(partecipante.getPartecipante().getNome_azienda()!=null) {
		    		 cell.setCellValue(partecipante.getPartecipante().getNome_azienda());
		    	 }else {
		    		 cell.setCellValue("");	 
		    	 }
		    	 
		    	 
		    	 col++;
		    	 cell = row.createCell(col);	
		    	 
		    	 if(partecipante.getPartecipante().getNome_azienda()!=null) {
		    		 cell.setCellValue(partecipante.getPartecipante().getNome_sede());
		    	 }else {
		    		 cell.setCellValue("");	 
		    	 }
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 cell.setCellValue(partecipante.getCorso().getDescrizione());
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 if(partecipante.getCorso().getCommessa()!=null) {
		    		 cell.setCellValue(partecipante.getCorso().getCommessa());	 
		    	 }else {
		    		 cell.setCellValue("");
		    	 }
		    	 
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 cell.setCellValue(partecipante.getOre_partecipate());
		    	 
			 	
						row_index++;
			}
		     		     
		    	 for(int j = 0; j<10;j++) {
		    		 sheet0.autoSizeColumn(j);
		    	 }
		     
		 		
		 		String path = Costanti.PATH_FOLDER + "\\Formazione\\ReportPartecipanti\\";

		 		
		 		if(!new File(path).exists()) {
		 			new File(path).mkdirs();
		 		}
		        FileOutputStream fileOut = new FileOutputStream(path +"REPORT_PARTECIPANTI.xlsx");
		        workbook.write(fileOut);
		        fileOut.close();

		        workbook.close();
		  
		}

	public static JsonObject importaDaPDF(FileItem fileItem,ClienteDTO cl, SedeDTO sd, Session session) throws Exception {
		
		
		JsonObject obj = new JsonObject();
		Gson g = new Gson();
		boolean esito = true;
		String messaggio = "";
		
		ArrayList<ForPartecipanteDTO> lista = new ArrayList<ForPartecipanteDTO>();
		PdfReader reader = new PdfReader(fileItem.getInputStream());
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		int pageNumber = reader.getNumberOfPages();
		ArrayList<Integer> firstPages = new ArrayList<Integer>();
		
	//	String x = getPDFText();
		
		for (int i = 1; i <= pageNumber; i++) {
			//String[] text = getText(reader, i); 
			//String pdftext = text[0];
			String pdftext = getPDFText(reader, i).replaceAll("\\n", " ");
			
			if(pdftext.contains("SICERTIFICACHE")) {
				String[] text = getText(reader, i); 
				pdftext = text[0];
			}
	
			String keyNome = "SI CERTIFICA CHE ";
			String keyNome2 = "Si certifica che ";
			String keyNome3 = "Si Certifica che ";
			String keyNascita = "Nato/a il";
			String keyLuogoStart = ", in ";
			String keyLuogoEnd = "Profilo";
			String keyCf = "C.F. : ";
			Locale locale = new Locale("it", "IT");
			
			String nominativo = "";				
			String data_nascita = "";
			String luogo_nascita = "";
		
			//if(pdftext.contains(keyNome) || pdftext.contains(keyNome2)) {
			if(StringUtils.containsIgnoreCase(pdftext, keyNome) || StringUtils.containsIgnoreCase(pdftext, keyNome2) || StringUtils.containsIgnoreCase(pdftext, keyNome3)) {
				
				
				if(pdftext.contains(keyNome2)) {
					keyNome = keyNome2;
					keyCf = "C.F. ";
				}
				
				if(pdftext.contains(keyNome3)) {
					keyNome = keyNome3;
					keyCf = "C.F. ";
					keyLuogoStart = "Nato/a a ";
					keyLuogoEnd = ") il ";
					keyNascita = keyLuogoEnd;
					
					nominativo = pdftext.substring(pdftext.indexOf(keyNome) + keyNome.length(), pdftext.indexOf(keyLuogoStart)-1).replaceAll("\\n", "");					
					data_nascita = pdftext.substring(pdftext.indexOf(keyNascita) + keyNascita.length(), pdftext.indexOf(keyNascita)+ keyNascita.length()+11);
					luogo_nascita =  pdftext.substring(pdftext.indexOf(keyLuogoStart) + keyLuogoStart.length(), pdftext.indexOf(keyLuogoEnd)+keyLuogoEnd.length()-3);
					
				}else {
					
					nominativo = pdftext.substring(pdftext.indexOf(keyNome) + keyNome.length(), pdftext.indexOf(keyNascita)).replaceAll("\\n", "");
					data_nascita = pdftext.substring(pdftext.indexOf(keyNascita) + keyNascita.length(), pdftext.indexOf(keyLuogoStart));					
					luogo_nascita =  pdftext.substring(pdftext.indexOf(keyLuogoStart) + keyLuogoStart.length(), pdftext.indexOf(keyLuogoEnd));
					
					
				}				

				String cf = "";
				
				if(pdftext.indexOf(keyCf) == -1) {
					
					keyCf =  "C.F. ";
					
					if(pdftext.indexOf(keyCf) == -1) {
						cf = pdftext.substring(pdftext.indexOf("opnefeiitalia@flexipec.it") +66, pdftext.indexOf("opnefeiitalia@flexipec.it") +82);
					}else {
						cf = pdftext.substring(pdftext.indexOf(keyCf) + keyCf.length(), pdftext.indexOf(keyCf)+(keyCf.length()+16));
					}
					
					
				}else {
					cf = pdftext.substring(pdftext.indexOf(keyCf) + keyCf.length(), pdftext.indexOf(keyCf)+(keyCf.length()+16));
				}						
						
				
				if(data_nascita.contains("/")) {
					df = new SimpleDateFormat("dd/MM/yyyy", locale);
				}else {
					df = new SimpleDateFormat("dd MMMM yyyy", locale);
				}
			
				System.out.println(nominativo + " "+ data_nascita+" "+luogo_nascita+" "+cf);
				
				nominativo = removeSpace(nominativo);
				luogo_nascita = removeSpace(luogo_nascita);
				cf = removeSpace(cf);
				
				esito = checkCFPattern(cf);
				
				if(esito) {
					
					ForPartecipanteDTO partecipante = new ForPartecipanteDTO();
					
					String[] nomeCognome = nominativo.split(" ");
					
					if(pdftext.indexOf(keyCf) == -1) {
						if(nomeCognome.length == 2) {
							partecipante.setCognome(nomeCognome[1]);
							partecipante.setNome(nomeCognome[0]);
								
						}else if(nomeCognome.length == 3){
							partecipante.setCognome(nomeCognome[1] +" "+ nomeCognome[2]);					
							partecipante.setNome(nomeCognome[0]);
							partecipante.setNominativo_irregolare(1);
						}else if(nomeCognome.length>3){
							partecipante.setNome(nomeCognome[0]);								
							partecipante.setNominativo_irregolare(0);
							int j = 2;
							String cognome = nomeCognome[1] +" "+ nomeCognome[2];
							
							while(j<nomeCognome.length) {
								cognome += nomeCognome[j];
								
								j++;
							}
							partecipante.setCognome(cognome);
						}
					}else {
						if(nomeCognome.length == 2) {
							partecipante.setCognome(nomeCognome[0]);
							partecipante.setNome(nomeCognome[1]);
								
						}else if(nomeCognome.length == 3){
							partecipante.setCognome(nomeCognome[0] +" "+ nomeCognome[1]);					
							partecipante.setNome(nomeCognome[2]);
							partecipante.setNominativo_irregolare(1);
						}else if(nomeCognome.length>3){
							partecipante.setCognome(nomeCognome[0] +" "+ nomeCognome[1]);			
							partecipante.setNominativo_irregolare(1);
							int j = 2;
							while(j<nomeCognome.length) {
								if(partecipante.getNome()!=null) {
									partecipante.setNome(partecipante.getNome()+" "+nomeCognome[j]);
								}else {
									partecipante.setNome(nomeCognome[j]);
								}
								
								j++;
							}
						}
					}
					
					
					partecipante.setCf(cf);
					partecipante.setData_nascita(df.parse(data_nascita));
					partecipante.setLuogo_nascita(luogo_nascita);
					if(cl!=null) {
						partecipante.setId_azienda(cl.get__id());
						partecipante.setNome_azienda(cl.getNome());
					}
					
					if(sd!=null) {
						partecipante.setId_sede(sd.get__id());
						String nome_sede = sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")";
						partecipante.setNome_sede(nome_sede);
					}
					
					lista.add(partecipante);
					
					
				}else {
					messaggio = "Attenzione! Formato codice fiscale errato per "+nominativo;
					break;
				}
				
			}
		

		}
		
		
		obj.addProperty("success", esito);
		obj.addProperty("messaggio", messaggio);
		obj.add("lista_partecipanti_import", g.toJsonTree(lista));
		
		return obj;
		//return lista;
	}

	
	
	static boolean checkCFPattern(String cf) {
		
		 // String patternStr = "/^[A-Z]{6}\\d{2}[A-Z]\\d{2}[A-Z]\\d{3}[A-Z]$/";
		 String patternStr = "[a-zA-Z]{6}\\d\\d[a-zA-Z]\\d\\d[a-zA-Z]\\d\\d\\d[a-zA-Z]";
		  
	        if(cf.matches(patternStr)) {
	        	return true;
	        }else {
	        	return false;
	        }

		
		
	}
	
	
	static String removeSpace(String str) {
		
		if(str.startsWith(" ")) {
			str = str.replaceFirst(" ", "");
		}
		if(str.endsWith(" ")) {
			str = str.substring(0,str.length() - 1);
		}
		
		return str;
	}
	
	
	public static String getPDFText(PdfReader reader, int page) throws IOException {
		
		//PdfReader pdf = new PdfReader("C:\\Users\\antonio.dicivita\\Desktop\\1.pdf");  
		   
        //Get the number of pages in pdf.
    //    int nbrPages = pdf.getNumberOfPages(); 
        String content = "";
        //Iterate the pdf through the pages.
//        for(int i=1; i <= nbrPages; i++) 
//        { 
            //Extract the content of the page using PdfTextExtractor.
             content = PdfTextExtractor.getTextFromPage(reader, page);
   
            //Display the content of the page on the console.
          //  System.out.println("Content of the page : " + content);
//        }
   
        //Close the PdfReader.
       // pdf.close();
		
        return content;
		
	}
	
	
	public static void splitPdf(FileItem fileItem, ArrayList<ForPartecipanteRuoloCorsoDTO> lista_partecipanti,Session session) throws Exception, IOException {
		
		//File file = new File(Costanti.PATH_FOLDER+"\\Formazione\\temp\\attestati_temp.pdf");
		//fileItem.write(file);		
		
		PdfReader reader = new PdfReader(fileItem.getInputStream());
		
		PDDocument document = PDDocument.load(fileItem.getInputStream()); 
	
		
		int pageNumber = reader.getNumberOfPages();		

		String keyFirstPage = "SI CERTIFICA CHE";
		
		ArrayList<Integer> firstPages = new ArrayList<Integer>();
		
		for (ForPartecipanteRuoloCorsoDTO partecipante : lista_partecipanti) {
			Splitter splitter = new Splitter(); 
			for (int i = 1; i <= pageNumber; i++) {
				String[] text = getText(reader, i); 
				String pdftext = text[0];
				
				if(StringUtils.containsIgnoreCase(pdftext, keyFirstPage) &&  StringUtils.containsIgnoreCase(pdftext, partecipante.getPartecipante().getCf())) {				
					splitter.setStartPage(i);
					splitter.setEndPage(i+1);
					splitter.setSplitAtPage(i+1);
					break;
				}
			}
			
			String filename = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
			List<PDDocument> splittedList = splitter.split(document);
			
			 File folder = new File(Costanti.PATH_FOLDER+"\\Formazione\\Attestati\\"+partecipante.getCorso().getId() +"\\"+partecipante.getPartecipante().getId()+ "\\");
			 if(!folder.exists()) {
				 folder.mkdirs();
			 }
			splittedList.get(0).save(Costanti.PATH_FOLDER+"\\Formazione\\Attestati\\"+partecipante.getCorso().getId() +"\\"+partecipante.getPartecipante().getId()+ "\\"+filename+ ".pdf");
			splittedList.get(0).close();
			
			partecipante.setAttestato(filename+".pdf");
			session.update(partecipante);
			
			
			addSign(Costanti.PATH_FOLDER+"\\Formazione\\Attestati\\"+partecipante.getCorso().getId() +"\\"+partecipante.getPartecipante().getId()+ "\\"+filename+ ".pdf", filename,0, partecipante.getFirma_responsabile(),partecipante.getFirma_centro_formazione());	
		
			if(partecipante.getFirma_legale_rappresentante()>0) {
				addSign(Costanti.PATH_FOLDER+"\\Formazione\\Attestati\\"+partecipante.getCorso().getId() +"\\"+partecipante.getPartecipante().getId()+ "\\"+filename+ ".pdf", filename, partecipante.getFirma_legale_rappresentante(), 0,0);
			}
			
			
			//System.out.println("Inserito: "+partecipante.getPartecipante().getNome()+" "+partecipante.getPartecipante().getCognome());
		}
		
  
		
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
	
	public static JsonObject addSign(String path, String filename_attestato, int firma_legale_rappresentante, int firma_responsabile, int firma_centro_formazione) throws Exception {

	    PdfReader reader = new PdfReader(path);
	    
	    String filename = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
	    	          
	    PdfStamper stamper = new PdfStamper(reader,new FileOutputStream(Costanti.PATH_FOLDER+"\\temp\\"+filename+".pdf"));
	    PdfContentByte content = stamper.getOverContent(1);	   
	    
	    if(firma_legale_rappresentante == 0) {
	    
	    	Image image = null;
	    	
    	
	    	
		    String keyWord = "RESPONSABILE";
		    Integer[] fontPosition = null;
			for(int i = 1;i<=reader.getNumberOfPages();i++) {
				fontPosition = getFontPosition(reader, keyWord, i);
				
				if(fontPosition[0] != null && fontPosition[1] != null) {
					
					int x = fontPosition[0] ;
					int y = fontPosition[1] -20;
					int w = x + 85;
					int h = y + 31;
					
					 Rectangle rect = new Rectangle(x, y, w, h);
				    
					 
				    	if(firma_responsabile == 0 || firma_responsabile == 1) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_alessandro_di_vito.png");	
				    	}else if(firma_responsabile == 2) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");
				    	}else if(firma_responsabile == 3) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_gabriella_mammone.png");
				    	}
				    	
				    	image.setAnnotation(new Annotation(0, 0, 0, 0, 3));	   
					    
						 image.scaleAbsolute(rect);
						
						image.setAbsolutePosition(fontPosition[0] , fontPosition[1] -35);
						
						content.addImage(image);
					
					break;
				}else {
					
					keyWord = "DIRETTORE";
					
					fontPosition = getFontPosition(reader, keyWord, i);
					
					if(fontPosition[0] != null && fontPosition[1] != null) {
					int x = fontPosition[0] ;
					int y = fontPosition[1] -20;
					int w = x + 85;
					int h = y + 31;
					
					 Rectangle rect = new Rectangle(x, y, w, h);
					 
				    	if(firma_responsabile == 0 || firma_responsabile == 1) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_alessandro_di_vito.png");	
				    	}else if(firma_responsabile == 2) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");
				    	}else if(firma_responsabile == 3) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_gabriella_mammone.png");
				    	}
				    	

				  	    image.setAnnotation(new Annotation(0, 0, 0, 0, 3));	   
				    
					 image.scaleAbsolute(rect);
					
					 if(firma_legale_rappresentante>0) {
						 image.setAbsolutePosition(fontPosition[0] +55, fontPosition[1] -35);
					 }else {
						 image.setAbsolutePosition(fontPosition[0] , fontPosition[1] -35);	 
					 }
					
					
					content.addImage(image);
					break;
					}
					
				}
			}
			
			//stamper.close();
			//reader.close();
		   // System.out.println(Arrays.toString(fontPosition));
			System.out.println(Arrays.toString(fontPosition));
	    	
	    }else {
	    	Image image = null;
	    	
	    	if(firma_legale_rappresentante == 1) {
	    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");
	    	}else if(firma_legale_rappresentante == 2) {
	    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_gabriella_mammone.png");
	    	}
	    	
	    	
	    	 image.setAnnotation(new Annotation(0, 0, 0, 0, 3));	   
		    	
		    	
			    String keyWord = "CRESCO";
			    Integer[] fontPosition = null;
				for(int i = 1;i<=reader.getNumberOfPages();i++) {
					fontPosition = getFontPosition(reader, keyWord, i);
					
					if(fontPosition[0] != null && fontPosition[1] != null) {
						
						int x = fontPosition[0] + 25 ;
						int y = fontPosition[1] -45;
						int w = x + 85;
						int h = y + 31;
						
						 Rectangle rect = new Rectangle(x, y, w, h);
					    
						 image.scaleAbsolute(rect);
						
						image.setAbsolutePosition(fontPosition[0] +25, fontPosition[1] - 45);
						content.addImage(image);
						
						break;
					}
				}
				
				//stamper.close();
				//reader.close();
			    //System.out.println(Arrays.toString(fontPosition));
				System.out.println(Arrays.toString(fontPosition));
	    }
	    

	    
	    if(firma_centro_formazione >0) {
	    	
	    	Image image =  null;
	    	
	    	if(firma_centro_formazione == 1) {
	    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");	
	    	}else if(firma_responsabile == 2) {
	    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_gabriella_mammone.png");
	    	}
	    	
	    	
	    	Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");	    	
	    	
	    	 image.setAnnotation(new Annotation(0, 0, 0, 0, 3));	   
		    	
		    	
			    String keyWord = "Centro di Formazione";
			    Integer[] fontPosition = null;
				for(int i = 1;i<=reader.getNumberOfPages();i++) {
					fontPosition = getFontPosition(reader, keyWord, i);
					
					if(fontPosition[0] != null && fontPosition[1] != null) {
						
						int x = fontPosition[0] + 25 ;
						int y = fontPosition[1] -45;
						int w = x + 85;
						int h = y + 31;
						
						 Rectangle rect = new Rectangle(x, y, w, h);
					    
						 image.scaleAbsolute(rect);
						
						image.setAbsolutePosition(fontPosition[0] +25, fontPosition[1] - 45);
						content.addImage(image);
						
						break;
					}
				}
				System.out.println(Arrays.toString(fontPosition));
				
	    }
	    
	    stamper.close();
		reader.close();
	  //  

	    File targetFile=  new File(path);
		File source = new File(Costanti.PATH_FOLDER+"\\temp\\"+filename+".pdf");
     	FileUtils.copyFile(source, targetFile);
     	
     
     	source.delete();
     
	    JsonObject myObj = new JsonObject();
	    
     	myObj.addProperty("success", true);
		return myObj;
	}

	public static ForRuoloDTO getRuoloFromId(int id_ruolo, Session session) {
		
		return GestioneFormazioneDAO.getRuoloFromId(id_ruolo, session);
	}

	public static ArrayList<ForReferenteDTO> getListaReferenti(Session session) {
		
		return GestioneFormazioneDAO.getListaReferenti(session);
	}

	public static ForReferenteDTO getReferenteFromID(int id_referente, Session session) {
		
		return GestioneFormazioneDAO.getReferenteFromID(id_referente, session);
	}

	public static ArrayList<ForEmailDTO> getStoricoEmail(int id_corso, Session session) {
		
		return GestioneFormazioneDAO.getStoricoEmail(id_corso, session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiSuccessivi(String dateTo, Session session) throws Exception, Exception {
		
		return GestioneFormazioneDAO.getListaCorsiSuccessivi(dateTo, session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiDocente(String dateFrom, String dateTo, int id_docente,	Session session) throws Exception, Exception {
		
		return GestioneFormazioneDAO.getListaCorsiDocente(dateFrom, dateTo, id_docente, session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiClienteSupervisore(int idCliente, Session session) {
		// 
		return GestioneFormazioneDAO.getListaCorsiClienteSupervisore( idCliente,  session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorsoClienteSupervisore(int id,int idCliente, Session session) {
		return GestioneFormazioneDAO.getListaPartecipantiCorsoClienteSupervisore(id, idCliente,  session) ;
	}

	public static ArrayList<ForPartecipanteDTO> getListaPartecipantiClienteSupervisore(int idCliente, Session session) {
		
		return GestioneFormazioneDAO.getListaPartecipantiClienteSupervisore( idCliente,  session);
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorsoClienteSupervisore(String dateFrom, String dateTo, String tipo_data, int idCliente, Session session) throws HibernateException, ParseException {
	
		return GestioneFormazioneDAO.getListaPartecipantiRuoloCorsoClienteSupervisore( dateFrom,  dateTo,  tipo_data,  idCliente,  session);
	}

	
	
}
