package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.commons.fileupload.FileItem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
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

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiRuoloCorso(String dateFrom, String dateTo, String tipo_data,Session session) throws Exception {
		
		return GestioneFormazioneDAO.getListaPartecipantiRuoloCorso(dateFrom, dateTo, tipo_data, session);
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
							if(cell.getColumnIndex()==0) {
								partecipante.setNome(cell.getStringCellValue());
							}
							else if(cell.getColumnIndex()==1) {
								partecipante.setCognome(cell.getStringCellValue());
							}	
							else if(cell.getColumnIndex()==3) {
								partecipante.setLuogo_nascita(cell.getStringCellValue());
							}
							else if(cell.getColumnIndex()==4) {
								partecipante.setCf(cell.getStringCellValue());
							}
							esito = true;
						}
						
					}else {
						
						if(cell.getDateCellValue()!=null && cell.getColumnIndex()==2) {
							partecipante.setData_nascita(cell.getDateCellValue());					
							esito = true;
						}				
					}				
				}	
				if(esito) {
					session.save(partecipante);	
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
}
