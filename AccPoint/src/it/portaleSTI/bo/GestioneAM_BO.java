package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.text.ParseException;
import java.util.ArrayList;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAM_DAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMProgressivoDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMTipoCampioneDTO;
import it.portaleSTI.DTO.AMTipoProvaDTO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneAM_BO {

	public static ArrayList<AMInterventoDTO> getListaInterventi(UtenteDTO utente, String dateFrom, String dateTo,Session session) throws HibernateException, ParseException {
	
		return GestioneAM_DAO.getListaInterventi(utente, dateFrom, dateTo,session);
	}

	public static ArrayList<AMOperatoreDTO> getListaOperatoriAll(Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getListaOperatoriAll(session);
		
		
	}

	public static ArrayList<AMCampioneDTO> getListaCampioni(Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getListaCampioni(session);
	}

	
	public static AMInterventoDTO getInterventoFromID(int id_intervento, Session session) throws HibernateException, ParseException {

		return GestioneAM_DAO.getInterventoFromID(id_intervento, session);
	}

	public static ArrayList<AMOggettoProvaDTO> getListaStrumenti(Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getListaStrumenti(session);
	}

	public static AMOggettoProvaDTO getOggettoProvaFromID(int id_strumento, Session session) throws HibernateException, ParseException {
	
		return GestioneAM_DAO.getOggettoProvaFromID(id_strumento, session);
	}

	public static AMCampioneDTO getCampioneFromID(int id_campione, Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getCampioneFromID(id_campione, session);
	}

	public static ArrayList<AMTipoCampioneDTO> getListaTipiCampione(Session session) {
		
		return GestioneAM_DAO.getListaTipiCampione(session);
	}

	public static AMTipoCampioneDTO getTipoCampioneFromID(int id_tipo, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getTipoCampioneFromID(id_tipo, session);
	}

	public static ArrayList<AMProvaDTO> getListaProveIntervento(int id_intervento, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getListaProveIntervento(id_intervento, session);
	}

	public static ArrayList<AMTipoProvaDTO> getListaTipiProva(Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getListaTipiProva( session);
	}

	public static AMOperatoreDTO getOperatoreFromID(int id_operatore, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getOperatoreFromID(id_operatore, session);
	}

	
	
	public static String[] getMatrix(String filePath) {
		
		StringBuilder matrix = new StringBuilder();
	    matrix.append("[");
	    String[] result = new String[4];

	    try (FileInputStream fis = new FileInputStream(new File(filePath));
	         Workbook workbook = new XSSFWorkbook(fis)) {

	        Sheet sheet = workbook.getSheetAt(0);

	        if (sheet.getPhysicalNumberOfRows() == 0) {
	            throw new IllegalArgumentException("Il foglio è vuoto.");
	        }

	        int expectedCols = -1;
	        int rowCount = 0;

	        for (Row row : sheet) {
	            // --- Estrazione spessori ---
	            for (int i = 0; i < row.getLastCellNum(); i++) {
	                Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);

	                if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
	                    String testo = cell.getStringCellValue().trim().toLowerCase();

	                    if (testo.contains("spessore minimo fasciame")) {
	                    	result[0] = getFirstNumericValueInRow(row, i);
	                    } else if (testo.contains("spessore minimo fondo superiore")) {
	                    	result[1] = getFirstNumericValueInRow(row, i);
	                    } else if (testo.contains("spessore minimo fondo inferiore")) {
	                    	result[2] = getFirstNumericValueInRow(row, i);
	                    }
	                }
	            }

	            // --- Costruzione della matrice ---
	            if (rowCount > 0) matrix.append(", ");
	            StringBuilder riga = new StringBuilder();
	            riga.append("{");

	            boolean hasValidData = false;

	            for (int i = 0; i < row.getLastCellNum(); i++) {
	                Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);

	                if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC || cell.getCellType() == Cell.CELL_TYPE_BLANK) {
	                    if (riga.length() > 1) riga.append(", "); // se non è la prima cella

	                    if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	                        riga.append(cell.getNumericCellValue());
	                        hasValidData = true;
	                    } else {
	                        riga.append("null");
	                    }
	                } else {
	                    break; // interrompe la riga se trova cella non numerica
	                }
	            }

	            riga.append("}");

	            if (hasValidData) {
	                matrix.append(riga);
	                rowCount++;
	            } else {
	                // riga ignorata completamente
	                if (rowCount > 0) matrix.setLength(matrix.length() - 2); // rimuove ", " finale
	            }
	        }

	    } catch (IllegalArgumentException e) {
	        System.err.println("Errore di struttura: " + e.getMessage());
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	       //
	    }

	    matrix.append("]");
	    
	    result[3] = matrix.toString();
	    
	    return result;
		
	}
	
	
	private static String getFirstNumericValueInRow(Row row, int excludeIndex) {
		
		 for (int i = 0; i < row.getLastCellNum(); i++) {
		        if (i == excludeIndex) continue;

		        Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);

		        if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
		            return String.valueOf(cell.getNumericCellValue());
		        } else if (cell.getCellType() ==Cell.CELL_TYPE_STRING) {
		            String value = cell.getStringCellValue().trim();
		          
		                return value;
		        
		        }
		    }
		    return null;
//	    if (cell == null) return null;
//
//	    switch (cell.getCellType()) {
//	        case Cell.CELL_TYPE_NUMERIC:
//	            return String.valueOf(cell.getNumericCellValue());
//	        case Cell.CELL_TYPE_STRING:
//	            return cell.getStringCellValue();
//	        case Cell.CELL_TYPE_BLANK:
//	            return null;
//	        default:
//	            return null;
//	    }
	}
	
//	public static String getMatrix(String filePath) {
//		
//		 String[] spessori = new String[3];
//		StringBuilder matrix = new StringBuilder();
//		matrix.append("[");
//
//        try (FileInputStream fis = new FileInputStream(new File(filePath));
//             Workbook workbook = new XSSFWorkbook(fis)) {
//
//            Sheet sheet = workbook.getSheetAt(0);
//
//            if (sheet.getPhysicalNumberOfRows() == 0) {
//                throw new IllegalArgumentException("Il foglio è vuoto.");
//            }
//
//            int expectedCols = -1;
//            int rowCount = 0;
//
//            for (Row row : sheet) {
//                if (rowCount > 0) matrix.append(", ");
//                matrix.append("{");
//
//                int cellCount = 0;
//                int actualCols = row.getLastCellNum();
//
//                if (expectedCols == -1) {
//                    expectedCols = actualCols;
//                } else if (actualCols != expectedCols) {
//                    throw new IllegalArgumentException("Righe con numero diverso di colonne.");
//                }
//
//                for (int i = 0; i < actualCols; i++) {
//                    if (i > 0) matrix.append(", ");
//                    Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
//
//                    if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
//                    	matrix.append(cell.getNumericCellValue());
//                    } else if (cell.getCellType() == Cell.CELL_TYPE_BLANK) {
//                    	matrix.append("null");
//                    } else {
//                        throw new IllegalArgumentException("Cella non numerica alla riga " +
//                                                           (row.getRowNum() + 1) + ", colonna " + (i + 1));
//                    }
//                    cellCount++;
//                }
//
//                matrix.append("}");
//                rowCount++;
//            }
//
//        } catch (IllegalArgumentException e) {
//            System.err.println("Errore di struttura: " + e.getMessage());
//            return "[]";
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "[]";
//        }
//
//        matrix.append("]");
//        return matrix.toString();
//		
//	}

	public static AMTipoProvaDTO getTipoProvaFromID(int id_tipo_prova, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getTipoProvaFromID(id_tipo_prova, session);
		
	}

	public static AMProvaDTO getProvaFromID(int id_prova, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getProvaFromID(id_prova, session);
	}

	public static AMProgressivoDTO getProgressivo(String idCommessa, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getProgressivo(idCommessa, session);
	}



	public static ArrayList<AMOggettoProvaDTO> getListaStrumentiClienteSede(Integer id_cliente, Integer id_sede,
			Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getListaStrumentiClienteSede(id_cliente,id_sede, session);
	}

}
