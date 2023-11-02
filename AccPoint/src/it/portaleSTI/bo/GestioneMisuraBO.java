package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.LatMasterDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.ContextListener;
import javassist.expr.NewArray;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Blob;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.fileupload.FileItem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.type.BlobType;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;

public class GestioneMisuraBO {

	public static MisuraDTO getMiruraByID(int idMisura, Session session)throws Exception
	{
		
			return GestioneMisuraDAO.getMiruraByID(idMisura, session);
		
	}
	
	
	public static int getMaxTabellePerMisura(Set<PuntoMisuraDTO> listaPunti) {
		
		  int max=0;
		  Iterator<PuntoMisuraDTO> iterator = listaPunti.iterator(); 
	      
		   // check values
		   while (iterator.hasNext())
		   
		   {
		    PuntoMisuraDTO punto = (PuntoMisuraDTO) iterator.next();	   
		    
		    if(punto.getId_tabella()>max)
		    {
		    	max =	punto.getId_tabella();
		    	
		    }
		   }
		return max;
	}
	
	public static ArrayList<PuntoMisuraDTO> getListaPuntiByIdTabella(Set<PuntoMisuraDTO> listaPunti, int idTabella) {
		  ArrayList<PuntoMisuraDTO> listaPuntiMisura = new ArrayList<>();
		  
		  
		  Iterator<PuntoMisuraDTO> iterator = listaPunti.iterator(); 
	      
		   // check values
		   while (iterator.hasNext())
		   
		   {
		    PuntoMisuraDTO punto = (PuntoMisuraDTO) iterator.next();	   
		    
		    if(punto.getId_tabella()==idTabella)
		    {
		    	listaPuntiMisura.add(punto);
		    }
		   }
		return listaPuntiMisura;
	}

	
	public static List<CampioneDTO> getListaCampioni(Set<PuntoMisuraDTO> listaPunti,TipoRapportoDTO tipoRapportoDTO) {
	
		List<CampioneDTO> listToReturn = new ArrayList();
		
		HashMap<String,String> listaCampioni = new HashMap<>();
		
		Iterator<PuntoMisuraDTO> iterator = listaPunti.iterator(); 
	      
		   // check values
		   while (iterator.hasNext())
		   
		   {
			   PuntoMisuraDTO punto = (PuntoMisuraDTO) iterator.next();	   
			   
			   if(punto.getNumero_certificato_campione()!=null) {
				   String[] array = punto.getDesc_Campione().split("\\|"); 
				   String[] cert = punto.getNumero_certificato_campione().split("\\|"); 
		    		for (int i = 0;i<array.length;i++) {
		    			if(!listaCampioni.containsKey(array[i]))
		    			{
		    				listaCampioni.put(array[i], cert[i]);
		    			}
		    		}
			   }else {
				   
				   String[] array = punto.getDesc_Campione().split("\\|"); 
		    		for (String codCamp : array) {
		    			if(!listaCampioni.containsKey(codCamp))
		    			{
		    				listaCampioni.put(codCamp, codCamp);
		    			}
		    		}
				   
			   }
			  
		    
		    	
		    
		    
		   }
		   
		   Iterator itCampioni=listaCampioni.entrySet().iterator();
		   
		   while (itCampioni.hasNext()) {
		        
			   Map.Entry pair = (Map.Entry)itCampioni.next();
		        
		        CampioneDTO campione =GestioneCampioneDAO.getCampioneFromCodice(pair.getKey().toString());
		        if(!pair.getValue().equals(pair.getKey())) {
		        	campione.setNumeroCertificatoPunto(pair.getValue().toString());
		        }
		       
		        if(campione==null) {
		        	campione = new CampioneDTO();
		        	campione.setCodice(pair.getKey().toString());
		        }else 
		        {
		          if(tipoRapportoDTO.getNoneRapporto().equals("RDP")) 
		          {
		        	campione.setCodice(campione.getCodice()+ " - " +campione.getNome());
		          }
		         }
		        
		        listToReturn.add(campione);
		        
		        itCampioni.remove(); // avoids a ConcurrentModificationException
		    }
		   
		return listToReturn;
	}


	public static PuntoMisuraDTO getPuntoMisuraById(String id) {
		// TODO Auto-generated method stub
		return GestioneMisuraDAO.getPuntoMisuraById(id);
	}


	public static boolean updatePunto(PuntoMisuraDTO punto, Session session) {
		try{			
			
			session.update(punto);
			
			return true;
		
		}catch(Exception ex)
		{
			return false;
		}
	}

	public static ArrayList<PuntoMisuraDTO> getListaPuntiByIdTabellaERipetizione(int idMisura, int idTabella, int idRipetizione) {

		return GestioneMisuraDAO.getListaPuntiByIdTabellaERipetizione(idMisura, idTabella,idRipetizione);
	}
	
	public static boolean updateValoriMediPunto(PuntoMisuraDTO punto, Session session) {
		try{			
			
		ArrayList<PuntoMisuraDTO>  punti = getListaPuntiByIdTabellaERipetizione(punto.getId_misura(), punto.getId_tabella(),punto.getId_ripetizione());
		
		for (PuntoMisuraDTO puntoMisuraDTO : punti) {
			if(puntoMisuraDTO.getId() != punto.getId()) {
				puntoMisuraDTO.setValoreMedioCampione(punto.getValoreMedioCampione());
				puntoMisuraDTO.setValoreMedioStrumento(punto.getValoreMedioStrumento());
				session.update(puntoMisuraDTO);
			}
		}

			return true;
		
		}catch(Exception ex)
		{
			return false;
		}
	}


	public static byte[] getFileBlob(int parseInt) throws Exception {
		return GestioneMisuraDAO.getFileFromPuntoMisura(parseInt);
	}


	public static boolean uploadAllegatoPdf(FileItem item, String pack, String id_misura) {
		
		boolean esito = false;
		String filename=item.getName();
		File folder = new File(Costanti.PATH_FOLDER+pack+"\\"+id_misura+"\\Allegati\\");
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		File file = new File(folder.getPath() +"\\"+ filename);
		
			while(true) {		
				
				try {
					item.write(file);
					
					break;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					break;
				}
				
		
			}
		

		return esito;
	}


	public static void eliminaAllegato(int id_misura, Session session) {

		GestioneMisuraDAO.eliminaAllegato(id_misura, session);
		
	}


	public static ArrayList<LatMasterDTO> getListaLatMaster() {
		
		return GestioneMisuraDAO.getListaLatMaster();
	}


	public static ArrayList<MisuraDTO> getListaMisurePerData(Date start, Date now, boolean lat, Session session) {
	
		return GestioneMisuraDAO.getListaMisurePerData(start, now, lat, session);
	}


	public static String calcolaIndicePrestazione(MisuraDTO misura) {
		
		BigDecimal max = BigDecimal.ZERO;
		String indice = null;
		
		if(misura.getListaPunti().size()==0) 
		{
			return null;
		}
		for (PuntoMisuraDTO punto : misura.getListaPunti()) {
			if(!punto.getTipoProva().equals("D")) {
				if(punto.getAccettabilita()!=null && punto.getAccettabilita().compareTo(BigDecimal.ZERO)==1) {
					BigDecimal indice_prestazione = punto.getIncertezza().multiply(new BigDecimal(100)).divide(punto.getAccettabilita(),5,RoundingMode.HALF_UP);
					if(indice_prestazione.compareTo(max)==1) {
						max = indice_prestazione;
					}
				}
			}
			
			
					
		}
		
		if(max.compareTo(new BigDecimal(25))==-1 || max.compareTo(new BigDecimal(25))==0) {
			indice = "V";
		}else if(max.compareTo(new BigDecimal(25))==1 && (max.compareTo(new BigDecimal(75))==-1 || max.compareTo(new BigDecimal(75))==0)) {
			indice = "G";
		}else if(max.compareTo(new BigDecimal(75))==1 && (max.compareTo(new BigDecimal(100))==-1 || max.compareTo(new BigDecimal(100))==0)) {
			indice = "R";
		}else {
			indice = "X";
		}
		
		return indice;
	}

	
	
	public static class ExcelReader {
	    public static boolean confrontaStringaConPrimaColonna(String filePath, String searchString, Session session) throws Exception {
	        try {
	            FileInputStream fileInputStream = new FileInputStream(filePath);
	            Workbook workbook = new XSSFWorkbook(fileInputStream);
	            ArrayList<String> lista_ci = new ArrayList<String>();
	            ArrayList<String> lista_ci2 = new ArrayList<String>();
	            
	            // Assumiamo che vogliamo lavorare con il primo foglio del file Excel
	            Sheet sheet = workbook.getSheetAt(0);
	            
	            // Iteriamo sulle righe del foglio Excel
	            int count = 1;
	            for (Row row : sheet) {
	                // Otteniamo il valore della cella nella prima colonna (indice 0)
	            
	                Cell cell = row.getCell(0);
		                if (cell != null) {
		                    // Confrontiamo il valore della cella con la stringa desiderata
		                    String cellValue = cell.getStringCellValue();
		                    
		                   lista_ci.add(cellValue);
	            	}
		                count++;
	            }
	            
	            
	            ArrayList<MisuraDTO> lista_misure= GestioneInterventoBO.getListaMirureByIntervento(7884, session);
	            for (MisuraDTO misuraDTO : lista_misure) {
	            	if(!lista_ci2.contains(misuraDTO.getStrumento().getCodice_interno())) {
	            		lista_ci2.add(misuraDTO.getStrumento().getCodice_interno());	
	            	}
					
				}
	            
	            for (String s : lista_ci2) {
					if(!lista_ci.contains(s)) {
						 System.out.println("strumento non misurato "+s);
					}else {
						 System.out.println("strumento  misurato "+s);
					}
				}
	            
	            
	            System.out.println("righe "+count);
	            // Chiudiamo il file Excel
	            fileInputStream.close();
	            workbook.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        
	        // La stringa non è stata trovata nella prima colonna
	        return false;
	    }

	    public static void main(String[] args) throws Exception {
	        String filePath = "C:\\Users\\antonio.dicivita\\Desktop\\Cartel1.xlsx";
	        String searchString = "stringaDaCercare";
	        new ContextListener().configCostantApplication();
	        Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
	        boolean trovato = confrontaStringaConPrimaColonna(filePath, searchString, session);
	        session.close();

	        if (trovato) {
	            System.out.println("La stringa è stata trovata nella prima colonna.");
	        } else {
	            System.out.println("La stringa non è stata trovata nella prima colonna.");
	        }
	    }
	}
	






	
	
}
