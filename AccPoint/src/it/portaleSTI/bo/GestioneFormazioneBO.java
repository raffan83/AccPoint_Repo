package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
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
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForQuestionarioDTO;
import it.portaleSTI.DTO.ForRuoloDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneFormazioneBO {

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

	public static ArrayList<ForPartecipanteDTO> getListaPartecipanti(Session session) {
		
		return GestioneFormazioneDAO.getListaPartecipanti(session);
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
			
			ForPartecipanteDTO partecipante = new ForPartecipanteDTO();		
			partecipante.setId_azienda(id_azienda);
			partecipante.setId_sede(id_sede);
			partecipante.setNome_azienda(nome_azienda);
			partecipante.setNome_sede(nome_sede);			
			boolean esito = false;
			
			String nome = null;
			String cognome = null;
			String cf = null;
			String luogo_nascita = null;
			Date data_nascita = null;
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
					if(cell.getCellType() == Cell.CELL_TYPE_STRING) {
						
						if(cell.getStringCellValue()!=null && !cell.getStringCellValue().equals("") )
						{
							esito = true;		
							
							if(cell.getColumnIndex()==0) {
								nome = cell.getStringCellValue();
								//partecipante.setNome(cell.getStringCellValue());
							}
							else if(cell.getColumnIndex()==1) {
								cognome = cell.getStringCellValue();
								//partecipante.setCognome(cell.getStringCellValue());
							}	
							else if(cell.getColumnIndex()==3) {
								luogo_nascita = cell.getStringCellValue();
								//partecipante.setLuogo_nascita(cell.getStringCellValue());
							}
							else if(cell.getColumnIndex()==4) {
								cf = cell.getStringCellValue();
								//partecipante.setCf(cell.getStringCellValue());
								
//								if(codiciFiscali.contains(cell.getStringCellValue())) {
//									esito = false;
//								}
							}											
							
						}
						
					}else {
						
						if(cell.getDateCellValue()!=null && cell.getColumnIndex()==2) {
							
							data_nascita = cell.getDateCellValue();
							//partecipante.setData_nascita(cell.getDateCellValue());					
							esito = true;
						}				
					}				
				}	
			
			}
			if(!codiciFiscali.contains(cf)) {
				partecipante.setNome(nome);
				partecipante.setCognome(cognome);
				partecipante.setData_nascita(data_nascita);
				partecipante.setCf(cf);
				session.save(partecipante);	
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

	
		
	
}
