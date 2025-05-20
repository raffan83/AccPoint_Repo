package it.portaleSTI.bo;

import java.io.File;
import java.io.FileInputStream;
import java.text.ParseException;
import java.util.ArrayList;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAM_DAO;
import it.portaleSTI.DAO.GestioneVerStrumentiDAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaAllegatoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMProgressivoDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMRapportoDTO;
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

	
	
//	public static String[] getMatrix(String filePath) {
//		
//		StringBuilder matrix = new StringBuilder();
//	    matrix.append("[");
//	    String[] result = new String[4];
//
//	    try (FileInputStream fis = new FileInputStream(new File(filePath));
//	         Workbook workbook = new XSSFWorkbook(fis)) {
//
//	        Sheet sheet = workbook.getSheetAt(0);
//
//	        if (sheet.getPhysicalNumberOfRows() == 0) {
//	            throw new IllegalArgumentException("Il foglio è vuoto.");
//	        }
//
//	        int expectedCols = -1;
//	        int rowCount = 0;
//
//	        for (Row row : sheet) {
//	            // --- Estrazione spessori ---
//	            for (int i = 0; i < row.getLastCellNum(); i++) {
//	                Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
//
//	                if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
//	                    String testo = cell.getStringCellValue().trim().toLowerCase();
//
//	                    if (testo.contains("spessore minimo fasciame")) {
//	                    	result[0] = getFirstNumericValueInRow(row, i);
//	                    } else if (testo.contains("spessore minimo fondo superiore")) {
//	                    	result[1] = getFirstNumericValueInRow(row, i);
//	                    } else if (testo.contains("spessore minimo fondo inferiore")) {
//	                    	result[2] = getFirstNumericValueInRow(row, i);
//	                    }
//	                }
//	            }
//
//	            // --- Costruzione della matrice ---
//	            if (rowCount > 0) matrix.append(", ");
//	            StringBuilder riga = new StringBuilder();
//	            riga.append("{");
//
//	            boolean hasValidData = false;
//
//	            for (int i = 0; i < row.getLastCellNum(); i++) {
//	                Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
//
//	                if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC || cell.getCellType() == Cell.CELL_TYPE_BLANK) {
//	                    if (riga.length() > 1) riga.append(", "); // se non è la prima cella
//
//	                    if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
//	                        riga.append(cell.getNumericCellValue());
//	                        hasValidData = true;
//	                    } else {
//	                        riga.append("null");
//	                    }
//	                } else {
//	                    break; // interrompe la riga se trova cella non numerica
//	                }
//	            }
//
//	            riga.append("}");
//
//	            if (hasValidData) {
//	                matrix.append(riga);
//	                rowCount++;
//	            } else {
//	                // riga ignorata completamente
//	                if (rowCount > 0) matrix.setLength(matrix.length() - 2); // rimuove ", " finale
//	            }
//	        }
//
//	    } catch (IllegalArgumentException e) {
//	        System.err.println("Errore di struttura: " + e.getMessage());
//	        
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	       //
//	    }
//
//	    matrix.append("]");
//	    
//	    result[3] = matrix.toString();
//	    
//	    return result;
//		
//	}
	
	
	public static String[] getMatrix(String filePath) {

	    StringBuilder matrix = new StringBuilder();
	    matrix.append("[");
	    StringBuilder testoSottoTabella = new StringBuilder();
	    String[] result = new String[5]; // Aggiungiamo una 5ª posizione per il testo sotto la tabella

	    try (FileInputStream fis = new FileInputStream(new File(filePath));
	         Workbook workbook = new XSSFWorkbook(fis)) {

	        Sheet sheet = workbook.getSheetAt(0);

	        if (sheet.getPhysicalNumberOfRows() == 0) {
	            throw new IllegalArgumentException("Il foglio è vuoto.");
	        }
	        FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
	        int expectedCols = -1;
	        int rowCount = 0;
	        boolean inTabella = true; // Indica se siamo ancora nella parte numerica

	        for (Row row : sheet) {
	            boolean hasNumericData = false;

	            // Estrazione spessori
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

	            // Costruzione matrice numerica
	            StringBuilder riga = new StringBuilder();
	            riga.append("{");
	            for (int i = 0; i < row.getLastCellNum(); i++) {
	                Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);

	                if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC || cell.getCellType() == Cell.CELL_TYPE_BLANK) {
	                    if (riga.length() > 1) riga.append(", ");
	                    if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	                        riga.append(cell.getNumericCellValue());
	                        hasNumericData = true;
	                    } else {
	                        riga.append("null");
	                    }
	                } else {
	                    // Appena troviamo una cella non numerica, assumiamo che la tabella sia finita
	                    inTabella = false;
	                    break;
	                }
	            }
	            riga.append("}");

	            if (inTabella && hasNumericData) {
	                if (rowCount > 0) matrix.append(", ");
	                matrix.append(riga);
	                rowCount++;
	            } else if (!inTabella) {
	                // Testo sotto tabella
	            	
	            	StringBuilder testoRiga = new StringBuilder();
	            	for (Cell cell : row) {
	            	    String valore = "";

	            	    if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
	            	        CellValue cellValue = evaluator.evaluate(cell);

	            	        if (cellValue != null) {
	            	            if (cellValue.getCellType() == Cell.CELL_TYPE_STRING) {
	            	                valore = cellValue.getStringValue();
	            	            } else if (cellValue.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	            	                valore = String.valueOf(cellValue.getNumberValue());
	            	            } else if (cellValue.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
	            	                valore = String.valueOf(cellValue.getBooleanValue());
	            	            }
	            	        }

	            	    } else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
	            	        valore = cell.getStringCellValue();

	            	    } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	            	        valore = String.valueOf(cell.getNumericCellValue());

	            	    } else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
	            	        valore = String.valueOf(cell.getBooleanCellValue());
	            	    }

	            	    valore = valore.trim();
	            	    if (!valore.isEmpty()) {
	            	        if (testoRiga.length() > 0) testoRiga.append(" ");
	            	        testoRiga.append(valore);
	            	    }
	            	}
	            	
	            	if (testoRiga.length() > 0) {
	                    if (testoSottoTabella.length() > 0) testoSottoTabella.append(",");
	                    testoSottoTabella.append("{").append(testoRiga).append("}");
	                }
	            }
	        }
	    } catch (IllegalArgumentException e) {
	        System.err.println("Errore di struttura: " + e.getMessage());
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    matrix.append("]");
	    result[3] = matrix.toString();
	    result[4] = testoSottoTabella.toString();

	    return result;
	}
	
	
	private static String getFirstNumericValueInRow(Row row, int excludeIndex) {
	    for (int i = 0; i < row.getLastCellNum(); i++) {
	        if (i == excludeIndex) continue;

	        Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
	        if (cell == null) continue;

	        if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
	            double num = cell.getNumericCellValue();
	            return String.valueOf(num).replace(".", ",");

	        } else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
	            String value = cell.getStringCellValue().trim();

	            java.util.regex.Matcher matcher = java.util.regex.Pattern.compile("[-+]?\\d*\\.?\\d+").matcher(value);
	            if (matcher.find()) {
	                String number = matcher.group();
	                return number.replace(".", ",");
	            }

	        } else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
	            int resultType = cell.getCachedFormulaResultType();

	            if (resultType == Cell.CELL_TYPE_NUMERIC) {
	                double num = cell.getNumericCellValue();
	                return String.valueOf(num).replace(".", ",");

	            } else if (resultType == Cell.CELL_TYPE_STRING) {
	                String value = cell.getStringCellValue().trim();

	                java.util.regex.Matcher matcher = java.util.regex.Pattern.compile("[-+]?\\d*\\.?\\d+").matcher(value);
	                if (matcher.find()) {
	                    String number = matcher.group();
	                    return number.replace(".", ",");
	                }
	            }
	        }
	    }
	    return null;
	}


	
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

	public static ArrayList<AMProvaDTO> getListaProve(Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getListaProve(session);
	}

	public static AMRapportoDTO getRapportoFromProva(int id, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getRapportoFromProva(id, session);
	}

	public static ArrayList<AMRapportoDTO> getListaRapportiIntervento(int id_intervento, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getListaRapportiIntervento(id_intervento, session);
	}

	public static AMOggettoProvaZonaRifDTO getZonaRiferimentoFromID(int idValue, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getZonaRiferimentoFromID(idValue, session);
	}

	public static ArrayList<AMOggettoProvaAllegatoDTO> getListaAllegatiStrumento(int id_strumento, Session session) {
		
		return GestioneAM_DAO.getListaAllegatiStrumento(id_strumento, session);
	}

	public static AMOggettoProvaAllegatoDTO getAllegatoStrumentoFormId(int id_allegato, Session session) {
		
		return GestioneAM_DAO.getAllegatoStrumentoFormId(id_allegato, session);
	}

}
