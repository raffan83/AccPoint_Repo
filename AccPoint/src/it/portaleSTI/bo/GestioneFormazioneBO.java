package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.mail.EmailException;
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
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.AcroFields.Item;
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
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForCorsoMoodleDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForEmailDTO;
import it.portaleSTI.DTO.ForGruppoMoodleDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.ForPiaStatoDTO;
import it.portaleSTI.DTO.ForPiaTipoDTO;
import it.portaleSTI.DTO.ForQuestionarioDTO;
import it.portaleSTI.DTO.ForReferenteDTO;
import it.portaleSTI.DTO.ForRuoloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import it.portaleSTI.action.SendEmailFormazione;

public class GestioneFormazioneBO {
	static final Logger logger = Logger.getLogger(GestioneFormazioneBO.class);

	static ArrayList<ForMembriGruppoDTO> lista_utenti_mancanti= null;
	
	static ArrayList<ForMembriGruppoDTO> lista_utenti_inviati= null;
	
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
							else if(cell.getColumnIndex()==2) {
								
								SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
						        dateFormat.setLenient(false);
						        Date date = null;
						        try {
						            date = dateFormat.parse(cell.getStringCellValue());
						        } catch (Exception e) {
						            // In caso di errore di parsing, date rimarrà null
						        }
						        data_nascita = date;
						        
							}
							else if(cell.getColumnIndex()==3) {
								luogo_nascita = cell.getStringCellValue();
							}
							else if(cell.getColumnIndex()==4) {
								cf = cell.getStringCellValue();
							}
							
							
							else if(cell.getColumnIndex()==5 ) {
								id_corso = Integer.parseInt(cell.getStringCellValue());
							}
							else if(cell.getColumnIndex()==6 ) {
								id_ruolo =  Integer.parseInt(cell.getStringCellValue());							
							}else if(cell.getColumnIndex()==7 ) {
								ore_partecipate = cell.getStringCellValue();
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
					codiciFiscali.add(cf);
					
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

			 for(int j = 0; j<12; j++) {
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
			 
			 sheet0.getRow(0).getCell(7).setCellValue("Categoria");
			 
			 sheet0.getRow(0).getCell(8).setCellValue("Data inizio");
			 
			 sheet0.getRow(0).getCell(9).setCellValue("Data scadenza");
			 
			 sheet0.getRow(0).getCell(10).setCellValue("Commessa");
			 
			 sheet0.getRow(0).getCell(11).setCellValue("Ore partecipate");		 
			 			 
	  
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
		    	 
		    	 cell.setCellValue(partecipante.getCorso().getCorso_cat().getDescrizione());
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    
		    	 if(partecipante.getCorso().getData_corso()!=null) {
		    		 cell.setCellValue(df.format(partecipante.getCorso().getData_corso())); 
		    	 }else {
		    		 cell.setCellValue("");
		    	 }
		    	 
		    	 
		    	 col++;
		    	 cell = row.createCell(col);
		    	 
		    	 
		    	 if(partecipante.getCorso().getData_scadenza()!=null) {
		    		 cell.setCellValue(df.format(partecipante.getCorso().getData_scadenza()));
		    	 }else {
		      		 cell.setCellValue("");
		    	 }
		    	 
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
		     		     
		    	 for(int j = 0; j<3;j++) {
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
	
	public static void importaQuestionario() throws Exception {
		
		
		PdfReader pdfReader = new PdfReader("C:\\Users\\antonio.dicivita\\Desktop\\gradimento_mariconte_23_02_2023.pdf");
		//PdfReader pdfReader = new PdfReader("C:\\Users\\antonio.dicivita\\Desktop\\questionario regione definitivo.pdf");
	
		 PdfReader.unethicalreading = true;
		 
	
		 String timestamp = ""+System.currentTimeMillis();
			
		 
		    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream("C:\\Users\\antonio.dicivita\\Desktop\\"+timestamp+".pdf"));
		   
		    //AcroFields acroFields = pdfReader.getAcroFields();
		    //AcroFields acroFields = stamper.getAcroFields();
		    AcroFields acroFields1 = pdfReader.getAcroFields();
		    AcroFields acroFields = stamper.getAcroFields();
		    
		    Map<String, Item> fields = acroFields.getFields();
		    Set<Entry<String, Item>> entrySet = fields.entrySet();
		    int i = 1;
		    Map<String, String>map = new LinkedHashMap<String, String>();
		    
		    for (Map.Entry<String, Item> entry : fields.entrySet()) {
		    	
		    	map.put(entry.getKey(), entry.getValue()+"");
		    	//acroFields.renameField(entry.getKey(), ""+i);
		        System.out.println("Key = " + entry.getKey() + ", Value = " + acroFields.getField(entry.getKey()));
		       // i++;
		    }

//		    acroFields.renameField("Text1", "annualita");
//		    acroFields.renameField("Text2", "denominazione_ente");
//		    acroFields.renameField("Text3", "titolo");
//		   //.renameField("Text4", "annualita");
//		    acroFields.renameField("Text4", "codice");
//		    acroFields.renameField("Text6", "annualita");
//		    acroFields.renameField("Text7", "annualita");
//		    acroFields.renameField("Text8", "provincia");
//		    acroFields.renameField("Text9", "eta");
//		    acroFields.renameField("Text21", "annualita");
//		    acroFields.renameField("Text32", "annualita");
//		    acroFields.renameField("Text44", "annualita");
//		    acroFields.renameField("Text55", "annualita");
//		    acroFields.renameField("Text66", "annualita");
//		    acroFields.renameField("Text74", "annualita");
//		    acroFields.renameField("Text77", "suggerimenti");
//		    acroFields.renameField("Text78", "annualita");
//		    acroFields.renameField("Button5", "fonte_finanziamento");
//		    acroFields.renameField("Button10", "genere");
//		    acroFields.renameField("Button11", "nazionalita");
//		    acroFields.renameField("Button12", "condizione_occupazionale");
		    acroFields.renameField("altri_corsi_priv", "altri_corsi_prov");
//		    acroFields.renameField("Button15", "altri_corsi_prov");
//		    acroFields.renameField("Button16", "altri_corsi_priv");
//		    acroFields.renameField("Button17", "motivazione");
//		    acroFields.renameField("Button18", "ric_cred");
//		    acroFields.renameField("Button19", "ric_ric_cred");
//		    acroFields.renameField("Button20", "spec_cred");
//		    
//		    
//		    for(int j = 0;j<3;j++) {
//		    	acroFields.renameField("Button"+(22+j), "0_"+(j+1));	
//	    		    	
//		    }
//		    
//		    for(int j = 0;j<3;j++) {
//		    	acroFields.renameField("Button"+(26+j), "1_"+(j+1));	
//	    		    	
//		    }
//		    
//		    
//		    for(int j = 0;j<3;j++) {
//		    	acroFields.renameField("Button"+(29+j), "2_"+(j+1));	
//	    		    	
//		    }
//		    
//		    acroFields.renameField("Button33", "2_4");
//		    acroFields.renameField("Button34", "2_5");
//		    for(int j = 0;j<7;j++) {
//		    	acroFields.renameField("Button"+(35+j), "3_"+(j+1));	
//	    		    	
//		    }
//		    
//		    acroFields.renameField("Button42", "4");
//		    acroFields.renameField("Button43", "4_1");
//		    
//		    for(int j = 0;j<4;j++) {
//		    	acroFields.renameField("Button"+(45+j), "4_"+(j+2));	
//	    		    	
//		    }
//		    acroFields.renameField("Button49", "5");
//		    
//		    for(int j = 0;j<5;j++) {
//		    	acroFields.renameField("Button"+(50+j), "5_"+(j+1));	
//	    		    	
//		    }
//		    
//		    acroFields.renameField("Button56", "5_6");
//		    acroFields.renameField("Button57", "5_7");
//		    acroFields.renameField("Button58", "6");
//		    
//		    for(int j = 0;j<7;j++) {
//		    	acroFields.renameField("Button"+(59+j), "6_"+(j+1));	
//	    		    	
//		    }
//		    
//		    
//		    acroFields.renameField("Button67", "6_8");
//		    acroFields.renameField("Button68", "6_9");
//		    acroFields.renameField("Button69", "7");
//		    
//		    for(int j = 0;j<3;j++) {
//		    	acroFields.renameField("Button"+(70+j), "7_"+(j+1));	
//	    		    	
//		    }
//		    
//		    acroFields.renameField("Button73", "7_4");
//		    
//		    
//		    acroFields.renameField("Button75", "7_5");
//		    
//		    acroFields.renameField("Button2", "8");
//		    
//		    acroFields.renameField("Button79", "9");
		    
		    
//		    acroFields.renameField("Button2", "genere");
//		    acroFields.renameField("Button3", "occupazione");
//		    acroFields.renameField("Button23", "nazionalita");
//		    acroFields.renameField("Button4", "studio");
//		    acroFields.renameField("Button5", "0_0");
//		    acroFields.renameField("Button6", "0_1");
//		    acroFields.renameField("Button7", "0_2");
//		    acroFields.renameField("Button8", "1_1");
//		    acroFields.renameField("Button39", "1_2");
//		    
//		    acroFields.renameField("Button9", "1_3");
//		    
//		    for(int j = 0;j<5;j++) {
//		    	//if(j!=1) {
//		    		acroFields.renameField("Button"+(10+j), "1_"+(j+4));	
//		    	//}		    	
//		    }
//		    
//		    for(int j = 0;j<7;j++) {
//		    	
//		    		acroFields.renameField("Button"+(15+j), "3_"+(j+1));	
//		    }
//		    
//		    acroFields.renameField("Button21", "2_1");
//		    acroFields.renameField("Text22", "2_2_1");
//		    acroFields.renameField("Text23", "2_2_2");
//		    acroFields.renameField("Button41", "4_1");
//		    
//		    for(int j = 0;j<5;j++) {
//		    	
//	    		acroFields.renameField("Button"+(24+j), "4_"+(j+2));	
//	    	
//		    }
//		    
//		    acroFields.renameField("Button28", "4");
//		    acroFields.renameField("Button29", "4_7");
//		    acroFields.renameField("Button30", "5");
//		    
//		    for(int j = 0;j<6;j++) {
//		    	
//	    		acroFields.renameField("Button"+(31+j), "7_"+(j+1));	
//	    
//	    	
//		    }
//		    
//		    acroFields.renameField("Text37", "7");
//		    
		    
//		    for (Map.Entry<String, Item> entry : fields.entrySet()) {
//		    	
//		    	map.put(entry.getKey(), entry.getValue()+"");
//		    	//acroFields.renameField(entry.getKey(), ""+i);
//		        System.out.println("Key = " + entry.getKey() + ", Value = " + acroFields.getField(entry.getKey()));
//		      //  acroFields.setField(entry.getKey(), "Off");
//		       // i++;
//		    }
//		    System.out.println();
//	    	 System.out.println();
//		    for (Map.Entry<String, String> entry : map.entrySet()) {
//		    	
//		    	
////		    	 System.out.println(entry.getKey() + ", Value = " + acroFields1.getField(entry.getKey()));
//		    	// acroFields1.setFieldProperty(entry.getKey(), "setfflags", PdfFormField.FF_READ_ONLY, null);
//		    	// acroFields.setField(entry.getKey(), "Off");
//		    	 
////		    	 System.out.println(entry.getKey() + ", Value = " + acroFields.getField(entry.getKey()));
////		    	if(entry.getKey().startsWith("Text")) {
////		    		//acroFields.renameField(entry.getKey(), "text_"+i);
////		    		 System.out.println(entry.getKey() + ", Value = " + acroFields.getField("text_"+i));
////		    	}else {
////		    		//acroFields.renameField(entry.getKey(), "radio_"+i);
////		    		 System.out.println(entry.getKey(), Value = " + acroFields.getField("radio_"+i));
////		    	}
////		    	
//		       
//		        i++;
//		    }
		  
		    stamper.close();
		    pdfReader.close();
		
	}
	
	
	
	public static JsonObject compilaExcelQuestionario(String filename) throws Exception {
	
	JsonObject obj = new JsonObject();
		
		String zipPath = Costanti.PATH_FOLDER+"//Formazione//temp//"+filename;
		
		ZipFile zipFile = new ZipFile(zipPath);

	    Enumeration<? extends ZipEntry> entries = zipFile.entries();
	    
	    InputStream file = new FileInputStream(Costanti.PATH_FOLDER+"//Formazione//Questionari//template_questionari_regionali.xlsx");	    
	    XSSFWorkbook workbook = new XSSFWorkbook(file);   
	    int sheets = workbook.getNumberOfSheets();
		 XSSFSheet sheet0 = workbook.getSheetAt(1);
		 XSSFSheet sheet = null;
		 int row = 2;
		 for(int i = 1;i<sheets;i++) {					
				 sheet = workbook.getSheetAt(i);						
					 
				 String text = sheet.getRow(row).getCell(0).getStringCellValue();
				if(text.equals(""))	{
					break;
				}
		 }

		
		 sheet.setSelected(true);
		 workbook.getSheetAt(0).setSelected(false);
	    while(entries.hasMoreElements()){
	        ZipEntry zentry = entries.nextElement();
	        InputStream stream = zipFile.getInputStream(zentry);
	        
	        
	        //PdfReader pdfReader = new PdfReader("C:\\Users\\antonio.dicivita\\Desktop\\gradimento_mariconte_23_02_2023.pdf");	
	        PdfReader pdfReader = new PdfReader(stream);
			PdfReader.unethicalreading = true;
				
			 
			   // PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream("C:\\Users\\antonio.dicivita\\Desktop\\"+timestamp+".pdf"));

			    AcroFields acroFields = pdfReader.getAcroFields();
			  //  AcroFields acroFields1 = stamper.getAcroFields();			    
			  
			    
			    acroFields.renameField("altri_corsi_priv", "altri_corsi_prov");
			    acroFields.renameField("motivazione", "altri_corsi_priv");
			    acroFields.renameField("ric_cred", "motivazione");
			    acroFields.renameField("ric_ric_cred", "ric_cred");
			    acroFields.renameField("spec_cred", "ric_ric_cred");
			    acroFields.renameField("Button20", "spec_cred");
			    
			    Map<String, Item> fields = acroFields.getFields();
			    
			    Set<Entry<String, Item>> entrySet = fields.entrySet();
			
			    Map<String, String>map = new LinkedHashMap<String, String>();
			    
			    for (Map.Entry<String, Item> entry : fields.entrySet()) {
			    	
			    	map.put(entry.getKey(), acroFields.getField(entry.getKey())+"");
			       // System.out.println("Key = " + entry.getKey() + ", Value = " + acroFields.getField(entry.getKey()));
			 
			    }
			
			    if(map.size()<68) {
			    	obj.addProperty("success", false);
			    	obj.addProperty("messaggio", "Attenzione! Il file "+zentry.getName()+" presenta degli errori!");
			    	File f = new File(zipPath);
					f.delete();
			    	return obj;
			    }
			
			
				 if(row==2) {
					 sheet.getRow(row).getCell(0).setCellValue(map.get("titolo"));	 
				 }
				 
				 if(!map.get("provincia").equals("Off") && !map.get("4_2").equals("Off")) {
					 String provincia =  map.get("provincia");		
					 boolean altro = true;
					 for (int j = 0; j < 5; j++) {
						
						 String prov_tab =  sheet.getRow(3+j).getCell(230).getStringCellValue();
						 if(provincia.equalsIgnoreCase(prov_tab)) {
							 sheet.getRow(row).getCell(2).setCellValue(prov_tab);
							 altro = false;
							 break;
						 }
					}
					if(altro) {
						sheet.getRow(row).getCell(2).setCellValue("Altro");
					}
					 
				 }
				 
				
				 
				 if(!map.get("eta").equals("Off") && !map.get("eta").equals("")) {
					 int index =  Integer.parseInt(map.get("eta"));
					 sheet.getRow(row).getCell(3).setCellValue(index);
				 }
				 
				 
				 
				 
				 if(!map.get("genere").equals("Off") && !map.get("genere").equals("")) {
					 int index =  Integer.parseInt(map.get("genere"));			 
					 String genere =  sheet.getRow(2+index).getCell(231).getStringCellValue();
					 sheet.getRow(row).getCell(4).setCellValue(genere);
				 }
				
				 if(!map.get("nazionalita").equals("Off") && !map.get("nazionalita").equals("")) {
					 int index = Integer.parseInt(map.get("nazionalita"));			 
					 String nazionalita =  sheet.getRow(2+index).getCell(232).getStringCellValue();	 
					 sheet.getRow(row).getCell(5).setCellValue(nazionalita);
				 }
				 
				 if(!map.get("condizione_occupazionale").equals("Off") && !map.get("condizione_occupazionale").equals("")) {
					 int index =Integer.parseInt(map.get("condizione_occupazionale"));			 
					 String condizione_occupazionale =  sheet0.getRow(2+index).getCell(233).getStringCellValue();	
					 sheet.getRow(row).getCell(6).setCellValue(condizione_occupazionale);
				 }
				 
				 if(!map.get("titolo_studio").equals("Off") && !map.get("titolo_studio").equals("")) {
					 int  index = Integer.parseInt(map.get("titolo_studio"));			 
					 String titolo_studio =  sheet.getRow(2+index).getCell(234).getStringCellValue();	
					 sheet.getRow(row).getCell(7).setCellValue(titolo_studio);
				 }
				 
				 if(!map.get("altri_corsi_prov").equals("Off") && !map.get("altri_corsi_prov").equals("")) {
					 int index = Integer.parseInt(map.get("altri_corsi_prov"));			 
					 String altri_corsi_prov =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(8).setCellValue(altri_corsi_prov);
				 }
				 
				 if(!map.get("altri_corsi_priv").equals("Off") && !map.get("altri_corsi_priv").equals("")) {
					 int index =Integer.parseInt(map.get("altri_corsi_priv"));			 
					 String altri_corsi_priv =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(9).setCellValue(altri_corsi_priv);
				 }
				 
				 if(!map.get("motivazione").equals("Off") && !map.get("motivazione").equals("")) {
					 int index = Integer.parseInt(map.get("motivazione"));			 
					 String motivazione =  sheet.getRow(2+index).getCell(237).getStringCellValue();	
					 sheet.getRow(row).getCell(10).setCellValue(motivazione);
				 }
				 
				 if(!map.get("ric_cred").equals("Off") && !map.get("ric_cred").equals("")) {
					 int index = Integer.parseInt(map.get("ric_cred"));			 
					 String ric_cred =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(11).setCellValue(ric_cred);
				 }
				 
				 if(!map.get("ric_ric_cred").equals("Off") && !map.get("ric_ric_cred").equals("")) {
					 int index =Integer.parseInt(map.get("ric_ric_cred"));			 
					 String ric_ric_cred =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(12).setCellValue(ric_ric_cred);
				 }
				 
				 if(!map.get("spec_cred").equals("Off") && !map.get("spec_cred").equals("")) {
					 int index = Integer.parseInt(map.get("spec_cred"));			 
					 String spec_cred =  sheet.getRow(2+index).getCell(241).getStringCellValue();	
					 sheet.getRow(row).getCell(13).setCellValue(spec_cred);
				 }
				 
				 if(!map.get("0_1").equals("Off") && !map.get("0_1").equals("")) {
					 int index = Integer.parseInt(map.get("0_1"));						 
					 int dom0_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(14).setCellValue(dom0_1);
				 }
			
				 if(!map.get("0_2").equals("Off") && !map.get("0_2").equals("")) {
					 int index = Integer.parseInt(map.get("0_2"));						 
					 int dom0_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(15).setCellValue(dom0_2);
				 }
				 
				 if(!map.get("0_3").equals("Off") && !map.get("0_3").equals("")) {
					 int index = Integer.parseInt(map.get("0_3"));						 
					 int dom0_3 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(16).setCellValue(dom0_3);
				 }
				 
			//da qui				 
				 
				 if(!map.get("1_1").equals("Off") && !map.get("1_1").equals("")) {
					 int index = Integer.parseInt(map.get("1_1"));						 
					 int dom1_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(17).setCellValue(dom1_1);
				 }
				 
				 if(!map.get("1_2").equals("Off") && !map.get("1_2").equals("")) {
					 int index = Integer.parseInt(map.get("1_2"));						 
					 int dom1_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(18).setCellValue(dom1_2);
				 }
				 
				 if(!map.get("1_3").equals("Off") && !map.get("1_3").equals("")) {
					 int index = Integer.parseInt(map.get("1_3"));						 
					 int dom1_3 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(19).setCellValue(dom1_3);
				 }
				
				 if(!map.get("2_1").equals("Off") && !map.get("2_1").equals("")) {
					 int index = Integer.parseInt(map.get("2_1"));						 
					 int dom2_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(20).setCellValue(dom2_1);
				 }
				 
				 if(!map.get("2_2").equals("Off") && !map.get("2_2").equals("")) {
					 int index = Integer.parseInt(map.get("2_2"));						 
					 int dom2_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(21).setCellValue(dom2_2);
				 }
				 
				 if(!map.get("2_3").equals("Off") && !map.get("2_3").equals("")) {
					 int index = Integer.parseInt(map.get("2_3"));						 
					 int dom2_3 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(22).setCellValue(dom2_3);
				 }
				 
				 if(!map.get("2_4").equals("Off") && !map.get("2_4").equals("")) {				 
					 int index = Integer.parseInt(map.get("2_4"));			 
					 String dom2_4 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(23).setCellValue(dom2_4);
				 }
				 
				 if(!map.get("2_5").equals("Off") && !map.get("2_5").equals("")) {				 
					 int index = Integer.parseInt(map.get("2_5"));			 
					 int dom2_5 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(24).setCellValue(dom2_5);
				 }
				 
				 if(!map.get("3_1").equals("Off") && !map.get("3_1").equals("")) {
					 int index = Integer.parseInt(map.get("3_1"));						 
					 int dom3_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(25).setCellValue(dom3_1);
				 }
				 
				 if(!map.get("3_2").equals("Off") && !map.get("3_2").equals("")) {
					 int index = Integer.parseInt(map.get("3_2"));						 
					 int dom3_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(26).setCellValue(dom3_2);
				 }
				 
				 if(!map.get("3_3").equals("Off") && !map.get("3_3").equals("")) {
					 int index = Integer.parseInt(map.get("3_3"));						 
					 int dom3_3 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(27).setCellValue(dom3_3);
				 }
				 
				 if(!map.get("3_4").equals("Off") && !map.get("3_4").equals("")) {				 
					 int index = Integer.parseInt(map.get("3_4"));			 
					 int dom3_4 = (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(28).setCellValue(dom3_4);
				 }
				 
				 if(!map.get("3_5").equals("Off") && !map.get("3_5").equals("")) {				 
					 int index = Integer.parseInt(map.get("3_5"));			 
					 int dom3_5 = (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(29).setCellValue(dom3_5);
				 }
				 
				 if(!map.get("3_6").equals("Off") && !map.get("3_6").equals("")) {				 
					 int index = Integer.parseInt(map.get("3_6"));			 
					 int dom3_6 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(30).setCellValue(dom3_6);
				 }
				 
				 if(!map.get("3_7").equals("Off") && !map.get("3_7").equals("")) {				 
					 int index = Integer.parseInt(map.get("3_7"));			 
					 int dom3_7 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 sheet.getRow(row).getCell(31).setCellValue(dom3_7);
				 }
				 
				 if(!map.get("4").equals("Off") && !map.get("4").equals("")) {				 
					int index = Integer.parseInt(map.get("4"));			 
				 	String dom4 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
				 	sheet.getRow(row).getCell(32).setCellValue(dom4);
				 }
				 
				 if(!map.get("4_1").equals("Off") && !map.get("4_1").equals("")) {
					 int index = Integer.parseInt(map.get("4_1"));			 
					 int dom4_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(33).setCellValue(dom4_1);
				 }
				 
				 if(!map.get("4_2").equals("Off") && !map.get("4_2").equals("")) {
					 int index = Integer.parseInt(map.get("4_2"));			 
					 int dom4_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(34).setCellValue(dom4_2);
				 }
				 
				 if(!map.get("4_3").equals("Off") && !map.get("4_3").equals("")) {
					 int index = Integer.parseInt(map.get("4_3"));			 
					 int dom4_3 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(35).setCellValue(dom4_3);
				 }
				 
				 if(!map.get("4_4").equals("Off") && !map.get("4_4").equals("")) {
					 int index = Integer.parseInt(map.get("4_4"));			 
					 int dom4_4 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(36).setCellValue(dom4_4);
				 }
				 
				 if(!map.get("4_5").equals("Off") && !map.get("4_5").equals("")) {
					 int index = Integer.parseInt(map.get("4_5"));			 
					 int dom4_5 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(37).setCellValue(dom4_5);
				 }
					 
				 if(!map.get("5").equals("Off") && !map.get("5").equals("")) {
					 int index = Integer.parseInt(map.get("5"));			 
					 String dom5 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(38).setCellValue(dom5);	
				 }
				 
				 if(!map.get("5_1").equals("Off") && !map.get("5_1").equals("")) {
					 int index = Integer.parseInt(map.get("5_1"));			 
					 int dom5_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(39).setCellValue(dom5_1);
				 }
				 
				 if(!map.get("5_2").equals("Off") && !map.get("5_2").equals("")) {
					 int index = Integer.parseInt(map.get("5_2"));			 
					 int dom5_2 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(40).setCellValue(dom5_2);
				 }
				 
				 if(!map.get("5_3").equals("Off") && !map.get("5_3").equals("")) {
					 int index = Integer.parseInt(map.get("5_3"));			 
					 int dom5_3 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(41).setCellValue(dom5_3);
				 }
				 
				 if(!map.get("5_4").equals("Off") && !map.get("5_4").equals("")) {
					 int index = Integer.parseInt(map.get("5_4"));			 
					 int dom5_4 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(42).setCellValue(dom5_4);
				 }
				 
				 if(!map.get("5_5").equals("Off") && !map.get("5_5").equals("")) {
					 int index = Integer.parseInt(map.get("5_5"));			 
					 int dom5_5 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(43).setCellValue(dom5_5);
				 }				 
				 
				 if(!map.get("5_6").equals("Off") && !map.get("5_6").equals("")) {
					 int index = Integer.parseInt(map.get("5_6"));			 
					 String dom5_6 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 	sheet.getRow(row).getCell(44).setCellValue(dom5_6);
				 }	
								 
				 if(!map.get("5_7").equals("Off") && !map.get("5_7").equals("")) {
					 int index = Integer.parseInt(map.get("5_7"));			 
					 int dom5_7 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(45).setCellValue(dom5_7);
				 }	
					 
				 if(!map.get("6").equals("Off") && !map.get("6").equals("")) {
					 int index = Integer.parseInt(map.get("6"));			 
					 String dom6 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(46).setCellValue(dom6);
				 }
				 
				 if(!map.get("6_1").equals("Off") && !map.get("6_1").equals("")) {
					 int index = Integer.parseInt(map.get("6_1"));			 
					 int dom6_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(47).setCellValue(dom6_1);
				 }
				 
				 if(!map.get("6_2").equals("Off") && !map.get("6_2").equals("")) {
					 int index = Integer.parseInt(map.get("6_2"));			 
					 int dom6_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(48).setCellValue(dom6_2);
				 }
				 
				 if(!map.get("6_3").equals("Off") && !map.get("6_3").equals("")) {
					 int index = Integer.parseInt(map.get("6_3"));			 
					 int dom6_3 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(49).setCellValue(dom6_3);
				 }
				 
				 if(!map.get("6_4").equals("Off") && !map.get("6_4").equals("")) {
					 int index = Integer.parseInt(map.get("6_4"));			 
					 int dom6_4 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(50).setCellValue(dom6_4);
				 }
				 
				 if(!map.get("6_5").equals("Off") && !map.get("6_5").equals("")) {
					 int index = Integer.parseInt(map.get("6_5"));			 
					 int dom6_5 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(51).setCellValue(dom6_5);
				 }
				 
				 if(!map.get("6_6").equals("Off") && !map.get("6_6").equals("")) {
					 int index = Integer.parseInt(map.get("6_6"));			 
					 int dom6_6 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(52).setCellValue(dom6_6);
				 }
				 
				 if(!map.get("6_7").equals("Off") && !map.get("6_7").equals("")) {
					 int index = Integer.parseInt(map.get("6_7"));			 
					 int dom6_7 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(53).setCellValue(dom6_7);
				 }
				 
								 
				 if(!map.get("6_8").equals("Off") && !map.get("6_8").equals("")) {
					 int index = Integer.parseInt(map.get("6_8"));			 
					 String dom6_8 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(54).setCellValue(dom6_8);
				 }
				 
				 if(!map.get("6_9").equals("Off") && !map.get("6_9").equals("")) {
					 int index = Integer.parseInt(map.get("6_9"));			 
					 int dom6_9 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(55).setCellValue(dom6_9);
				 }
				 
				 if(!map.get("7").equals("Off") && !map.get("7").equals("")) {
					 int index = Integer.parseInt(map.get("7"));			 
					 String dom7 =  sheet.getRow(2+index).getCell(236).getStringCellValue();	
					 sheet.getRow(row).getCell(56).setCellValue(dom7);
				 }
				
				 if(!map.get("7_1").equals("Off") && !map.get("7_1").equals("")) {
					 int index = Integer.parseInt(map.get("7_1"));			 
					 int dom7_1 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(57).setCellValue(dom7_1);
				 }
				 
				 if(!map.get("7_2").equals("Off") && !map.get("7_2").equals("")) {
					 int index = Integer.parseInt(map.get("7_2"));			 
					 int dom7_2 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(58).setCellValue(dom7_2);
				 }
				 
				 if(!map.get("7_3").equals("Off") && !map.get("7_3").equals("")) {
					 int index = Integer.parseInt(map.get("7_3"));			 
					 int dom7_3 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
					 	sheet.getRow(row).getCell(59).setCellValue(dom7_3);
				 }
				
				 
				 if(!map.get("7_4").equals("Off") && !map.get("7_4").equals("")) {
					int index = Integer.parseInt(map.get("7_4"));			 
					String dom7_4 =  sheet.getRow(2+index).getCell(242).getStringCellValue();	
					sheet.getRow(row).getCell(60).setCellValue(dom7_4);
				 }
				 
				 if(!map.get("7_5").equals("Off") && !map.get("7_5").equals("")) {
						int index = Integer.parseInt(map.get("7_5"));			 
						int dom7_5 =  (int) sheet.getRow(3+index).getCell(238).getNumericCellValue();	
						sheet.getRow(row).getCell(61).setCellValue(dom7_5);
				 }
				 
				 if(!map.get("8").equals("Off") && !map.get("8").equals("")) {
					 int index = Integer.parseInt(map.get("8"));	
					 String dom8 =   sheet.getRow(2+index).getCell(239).getStringCellValue();	
					 sheet.getRow(row).getCell(62).setCellValue(dom8);
				 }
				 			 
				 
				 if(!map.get("9").equals("Off") && !map.get("9").equals("")) {
						int index = Integer.parseInt(map.get("9"));			 
						int dom9 = (int)  sheet.getRow(3+index).getCell(238).getNumericCellValue();	
						sheet.getRow(row).getCell(61).setCellValue(dom9);
				 }
				
				 
				 sheet.getRow(row).getCell(64).setCellValue(map.get("suggerimenti"));
				 
				
			        
			        row++;
	    }
		
	    workbook.getCreationHelper().createFormulaEvaluator().evaluateAll();
	  //  FileOutputStream fileOut = new FileOutputStream("C:\\Users\\antonio.dicivita\\Desktop\\"+timestamp+"_"+".xlsx");
	    FileOutputStream fileOut = new FileOutputStream( Costanti.PATH_FOLDER+"//Formazione//Questionari//template_questionari_regionali.xlsx");
        workbook.write(fileOut);
        fileOut.close();
        
        workbook.close();
		zipFile.close();
		
		File f = new File(zipPath);
		f.delete();
		    		
		obj.addProperty("success", true);
		obj.addProperty("messaggio", "Questionari corso caricati con successo!");
		return obj;
	}
	

	
	public static void main(String[] args) throws Exception{
		//compilaExcelQuestionario("");
		
	}

	public static JsonObject importaDaPDF(FileItem fileItem,ClienteDTO cl, SedeDTO sd, Session session) throws Exception {
		
		
		JsonObject obj = new JsonObject();
		Gson g = new Gson();
		boolean esito = true;
		String messaggio = "Attenzione! Formato codice fiscale errato per ";
		
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
					
					if(controllaDuplicato(partecipante.getNome(), partecipante.getCognome(), cf, session)) {
						partecipante.setDuplicato(1);
					}else {
						partecipante.setDuplicato(0);
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
					messaggio += "<br>"+ nominativo;
					
				}
				
			}
		

		}
		
		
		obj.addProperty("success", esito);
		obj.addProperty("messaggio", messaggio);
		obj.add("lista_partecipanti_import", g.toJsonTree(lista));
		
		return obj;
		//return lista;
	}

	
	
	private static boolean controllaDuplicato(String nome, String cognome,String cf, Session session) {
		
		boolean result = GestioneFormazioneDAO.controllaDuplicato(nome, cognome,cf, session);
	
		return result;
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
				
				
				String pdftext = getPDFText(reader, i).replaceAll("\\n", " ");
				
				if(pdftext.contains("SICERTIFICACHE")) {
					String[] text = getText(reader, i); 
					pdftext = text[0];
				}
				
				//String[] text = getText(reader, i); 
				//String pdftext = text[0];
				
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
			
			int firma_legale_rap = partecipante.getFirma_legale_rappresentante();
		
			if(firma_legale_rap!=10) {
				firma_legale_rap = 0;
			}
			addSign(Costanti.PATH_FOLDER+"\\Formazione\\Attestati\\"+partecipante.getCorso().getId() +"\\"+partecipante.getPartecipante().getId()+ "\\"+filename+ ".pdf", filename,firma_legale_rap, partecipante.getFirma_responsabile(),partecipante.getFirma_centro_formazione());	
		
			if(partecipante.getFirma_legale_rappresentante()>0 && partecipante.getFirma_legale_rappresentante()!=10) {
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
				    
					 
				    	if(firma_responsabile == 1) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_alessandro_di_vito.png");	
				    	}else if(firma_responsabile == 2) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");
				    	}else if(firma_responsabile == 3) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_gabriella_mammone.png");
				    	}else if(firma_responsabile == 0 || firma_responsabile == 4) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_lisa_lombardozzi.png");
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
					 
				    	if( firma_responsabile == 1) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_alessandro_di_vito.png");	
				    	}else if(firma_responsabile == 2) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_antonio_accettola.png");
				    	}else if(firma_responsabile == 3) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_gabriella_mammone.png");
				    	}else if(firma_responsabile == 0 || firma_responsabile == 4) {
				    		image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\firma_lisa_lombardozzi.png");
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
	    	
	    }else if(firma_legale_rappresentante!=10){
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
	    

	    
	    if(firma_centro_formazione >0 && firma_centro_formazione!=10) {
	    	
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

	public static ArrayList<ForEmailDTO> getStoricoEmail(int id_corso, int attestato,Session session) {
		
		return GestioneFormazioneDAO.getStoricoEmail(id_corso, attestato,session);
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

	public static ArrayList<ForCorsoDTO> getListaCorsiCategoria(int id_categoria, Session session) {

		return GestioneFormazioneDAO.getListaCorsiCategoria(id_categoria, session);
	}

	public static void sendEmailCorsiInScadenza(String path) throws ParseException, Exception {
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		try {
			
			
			Date today = new Date();
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			cal.add(Calendar.DATE, 59);
			Date nextDate = cal.getTime();
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			
			ArrayList<ForCorsoDTO> lista_corsi = GestioneFormazioneDAO.getListaCorsiInScadenza(df.format(nextDate), session);
		
			df = new SimpleDateFormat("dd/MM/yyyy");
			
			String messaggio = "";
			
			
			
			for (ForCorsoDTO corso : lista_corsi) {
				
				messaggio = "Gentile Utente <br>Si comunica che il seguente corso &egrave; in scadenza il "+df.format(nextDate)+":<br><br>";
				
				messaggio += "ID Corso: "+corso.getId()+" - " +corso.getCorso_cat().getDescrizione() +" - "+corso.getDescrizione()+"<br><br>";
				
				messaggio += 	"Siamo a disposizione per supportarvi nell'organizzazione e pianificazione dei corsi.<br>"
					  	+"Cordiali saluti.<br><br>";
				
				SendEmailBO.sendEmailCorsiInScadenza(messaggio, corso, path);
				corso.setEmail_inviata(1);
				
			}
			
					
			session.getTransaction().commit();
			session.close();
		}catch(Exception e) {
			session.getTransaction().rollback();
			session.close();
			e.printStackTrace();
			logger.error(e);
		}
		
		
		
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiDate(String dateFrom, String dateTo, Integer id_cliente, Integer id_sede,Session session) throws HibernateException, ParseException {
		
		
		return GestioneFormazioneDAO.getListaCorsiDate(dateFrom, dateTo, id_cliente, id_sede, session);
	}

	public static ForPiaPianificazioneDTO getPianificazioneFromId(int id, Session session) {
		
		
		return GestioneFormazioneDAO.getPianificazioneFromId( id,  session);
	
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioni(String anno,String filtro_tipo, Session session) {
		
		return GestioneFormazioneDAO.getListaPianificazioni(anno,filtro_tipo, session);
	}

	public static ArrayList<ForPiaStatoDTO> getListaStati(Session session) {
		
		return GestioneFormazioneDAO.getListaStati(session);
	}

	public static ArrayList<ForPiaTipoDTO> getListaTipi(Session session) {
		
		return GestioneFormazioneDAO.getListaTipi(session);
	}

	public static void sendEmailAttestatiNonConsegnati(String path) throws Exception {
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try {
		
		ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni_fatturate = GestioneFormazioneDAO.getListaPianificazioniStato(4, session);
		
		LocalDate today = LocalDate.now();
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
		for (ForPiaPianificazioneDTO p : lista_pianificazioni_fatturate) {
			
			if(p.getData_reminder()!=null) {
				
				LocalDate date =  p.getData_reminder().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				
				if(date.equals(today)) {
					
					String messaggio = "Si comunica che dalla pianificazione corsi emerge che per la commessa "+p.getId_commessa()+" &egrave; presente un item nello stato \"FATTURATO SENZA ATTESTATI\" in data "+df.format(p.getData())+".";
					SendEmailBO.sendEmailReminderPianificazione(messaggio,  path);
					
					
					p.setData_reminder(Date.from(date.plusWeeks(1).atStartOfDay(ZoneId.systemDefault()).toInstant()));
					session.update(p);
				}
			}
			
			if(p.getData_cambio_stato()!=null) {
				LocalDate dataCambioStato = p.getData_cambio_stato().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				
				if(p.getTipo().getId()==3 && dataCambioStato.plusMonths(6).isEqual(today)) {
					String messaggio = "Si comunica che dalla pianificazione corsi emerge che per la commessa "+p.getId_commessa()+" &egrave; presente un item E-LEARNING nello stato \"FATTURATO SENZA ATTESTATI\" DA 6 MESI - Data pianificazione "+df.format(p.getData())+".";
					SendEmailBO.sendEmailReminderPianificazione(messaggio,  path);
				}
			}	
			}
			
		
	
			
		
		
			
	
				
		session.getTransaction().commit();
		session.close();
	}catch(Exception e) {
		session.getTransaction().rollback();
		session.close();
		e.printStackTrace();
		logger.error(e);
	}
		
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioniDocente(String dateFrom, String dateTo,
			int parseInt, Session session) throws HibernateException, ParseException {
		
		return GestioneFormazioneDAO.getListaPianificazioniDocente( dateFrom,  dateTo,
				 parseInt,  session);
	}

	public static ArrayList<ForPiaPianificazioneDTO> getListaPianificazioniData(String dateFrom, String dateTo,	Session session) throws HibernateException, ParseException {
	
		return GestioneFormazioneDAO.getListaPianificazioniData(dateFrom, dateTo, session);
		
		
	}

	public static ArrayList<ForConfInvioEmailDTO> getListaConfigurazioniInvioEmail(Session session) {
		
		return GestioneFormazioneDAO.getListaConfigurazioniInvioEmail(session);
	}

	public static ArrayList<ForCorsoMoodleDTO> getListaCorsiInvioEmail() throws Exception {

		return GestioneFormazioneDAO.getListaCorsiInvioEmail();
	}

	public static ArrayList<ForGruppoMoodleDTO> getGruppiFromCorso(int parseInt) throws Exception {
		
		return GestioneFormazioneDAO.getGruppiFromCorso(parseInt);
	}

	public static ArrayList<ForMembriGruppoDTO> getMembriGruppo(int gruppo, int corso) throws Exception{
		// TODO Auto-generated method stub
		return GestioneFormazioneDAO.getMembriGruppo(gruppo, corso);
	}

	public static ForConfInvioEmailDTO getConfigurazioneInvioEmail(int id_conf,Session session) {
		// TODO Auto-generated method stub
		return GestioneFormazioneDAO.getConfigurazioneInvioEmail(id_conf,session);
	}

	public static void sendEmailCorsiNonCompleti(String path) throws Exception  {
		
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		try {
		
		ArrayList<ForConfInvioEmailDTO> lista_conf = getListaConfigurazioniInvioEmailData(new Date(),session);

		for (ForConfInvioEmailDTO conf : lista_conf) {
			
			lista_utenti_mancanti = new ArrayList<ForMembriGruppoDTO>();
			
			lista_utenti_inviati = new ArrayList<ForMembriGruppoDTO>();
			
			ArrayList<ForMembriGruppoDTO> lista_utenti = GestioneFormazioneDAO.getListaUtentiNonCompleti(conf.getId_corso(), conf.getId_gruppo());
			
	
			
			for (ForMembriGruppoDTO utente : lista_utenti) 
			{

				System.out.println("Tentativo invio " +utente.getNome()+" "+utente.getCognome()+" "+utente.getEmail());
				SendEmailBO.sendEmailCorsoMoodle(utente, conf.getDescrizione_corso(),conf.getOggetto_email(), conf.getTesto_email());
				TimeUnit.SECONDS.sleep(2);
				
			}
			
			if(lista_utenti_mancanti.size()>0) 
			{
				String messaggio ="<html>Non è stato possibile inviare il Remind del corso ID:"+conf.getId()+" ("+conf.getDescrizione_corso()+") ai seguenti utenti:<br><br>";
				
				for (ForMembriGruppoDTO user : lista_utenti_mancanti) {
					messaggio+= user.getNome() +" "+ user.getCognome()+" email: "+user.getEmail()+" Errore: "+user.getDescrizioneErrore()+"<br>";	
				}
				
				try {
					Utility.sendEmail("antonio.dicivita@ncsnetwork.it","Errore invio Remind corsi Moodle",messaggio);
					Utility.sendEmail("raffaele.fantini@ncsnetwork.it","Errore invio Remind corsi Moodle",messaggio);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			
			if(lista_utenti_inviati.size()>0) 
			{
			
				try 
				{
					SendEmailBO.sendEmailReportCorsiMoodle(conf, lista_utenti_inviati);
					logger.error("Report inviato correttamente");
				}
				catch (Exception e) 
				{
					logger.error(e);
					e.printStackTrace();
				}
				
			}
	
			Calendar cal = Calendar.getInstance();
			cal.setTime(conf.getData_prossimo_invio());
			cal.add(Calendar.DAY_OF_YEAR, conf.getFrequenza_invio());
			
			conf.setData_prossimo_invio(cal.getTime());
			
			session.update(conf);

		}
		
		lista_conf = getListaConfigurazioniInvioEmailScadenza(new Date(),session);
		
		
		for (ForConfInvioEmailDTO conf : lista_conf) {			
			
			conf.setStato_invio(1);
			session.update(conf);
		}
		
		session.getTransaction().commit();
		session.close();
		
	}catch(Exception e) {
		
		throw e;
		
	}
		

		
	}

	public static ArrayList<ForConfInvioEmailDTO> getListaConfigurazioniInvioEmailData(Date date, Session session) {
		
		return GestioneFormazioneDAO.getListaConfigurazioniInvioEmailData(date, session);
	}

	private static ArrayList<ForConfInvioEmailDTO> getListaConfigurazioniInvioEmailScadenza(Date date,
			Session session) {
		
		return GestioneFormazioneDAO.getListaConfigurazioniInvioEmailScadenza(date, session);
	}

	public static File convertInputStreamToFile(InputStream inputStream, String outputPath) {
        File outputFile = new File(outputPath);

        try {
            OutputStream outputStream = new FileOutputStream(outputFile);
            byte[] buffer = new byte[1024];
            int length;
            
            while ((length = inputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, length);
            }

            return outputFile;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
	}

	public static ArrayList<ForMembriGruppoDTO> getMembriGruppoVittoria(int id_gruppo, int id_corso) throws Exception {
		
		return GestioneFormazioneDAO.getMembriGruppoVittoria(id_gruppo, id_corso);
	}

	public static ArrayList<ForCorsoDTO> getlistaCorsiCommessa(String commessa, Integer id_cliente, Integer id_sede, Session session) {
		// TODO Auto-generated method stub
		return GestioneFormazioneDAO.getListaCorsiCommessa(commessa, id_cliente, id_sede, session);
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiInCorsoPartecipante(int id, Session session) {
		// TODO Auto-generated method stub
		return GestioneFormazioneDAO.getListaCorsiInCorsoPartecipante(id, session);
	}

	public static HashMap<String, String> listaCompletaEmailMoodle() throws Exception {
		// TODO Auto-generated method stub
		return GestioneFormazioneDAO.listaCompletaEmailMoodle();
	}

	public static void sendEmailValutazioneEfficacia(String path) throws Exception {
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		try {
		
		ArrayList<ForCorsoDTO> lista_corsi_val_efficazia = GestioneFormazioneDAO.getListaCorsiEfficacia(new Date(),session);

		for (ForCorsoDTO corso : lista_corsi_val_efficazia) {
			
			for (ForReferenteDTO referente : corso.getListaReferenti()) {
				SendEmailBO.sendEmailEfficaciaCorso(corso, referente);
			}
				
	
		}

		
		session.getTransaction().commit();
		session.close();
		
	}catch(Exception e) {
		
		throw e;
		
	}
	}

	public static ArrayList<ForCorsoDTO> getLisaCorsiFiltro(String range, String commessa,String categoria, Session session) {
		// TODO Auto-generated method stub
		return GestioneFormazioneDAO.getLisaCorsiFiltro(range, commessa, categoria, session);
	}

	public static int getMaxIdCorso(Session session) {
		
		return GestioneFormazioneDAO.getMaxIdCorso(session);
	}

	public static Map<Integer, List<Integer>> getListaCorsiSuccessiviCategoria(String dateFrom, int id_categoria,int id_corso, Session session) throws ParseException, Exception {
		// TODO Auto-generated method stub
		return DirectMySqlDAO. getListaCorsiSuccessiviCategoria(dateFrom, id_categoria, id_corso,session);
	}

	
	public static void sendEmailPreavviso(String path) throws Exception {
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		try {
		
		ArrayList<ForCorsoDTO> lista_corsi_preavviso = GestioneFormazioneDAO.getListaCorsiPreavviso(new Date(),session);

		for (ForCorsoDTO corso : lista_corsi_preavviso) {
			
			for (ForReferenteDTO referente : corso.getListaReferenti()) {
				SendEmailBO.sendEmailPreavvisoCorso(corso, referente);
			}
				
	
		}

		
		session.getTransaction().commit();
		session.close();
		
	}catch(Exception e) {
		
		throw e;
		
	}
	}
	
	
	}
