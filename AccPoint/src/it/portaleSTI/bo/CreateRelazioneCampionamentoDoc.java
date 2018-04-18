
package it.portaleSTI.bo;



import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Header;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.Units;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.IBodyElement;
import org.apache.poi.xwpf.usermodel.IRunBody;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFPicture;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.xmlbeans.XmlCursor;
import org.apache.xmlbeans.impl.xb.xmlschema.SpaceAttribute.Space;
import org.ghost4j.document.Document;
import org.ghost4j.document.PDFDocument;
import org.ghost4j.renderer.SimpleRenderer;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTFldChar;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTP;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTPPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTR;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTSectPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTShd;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTString;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTabStop;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTText;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTVMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTVerticalJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STFldCharType;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STShd;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTabJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STVerticalJc;

import com.sun.xml.internal.ws.server.sei.InvokerTube;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.RapportoCampionamentoDTO;
import it.portaleSTI.DTO.RelazioneCampionamentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;

public class CreateRelazioneCampionamentoDoc {
	public int idRelazione = 0;
	public String errorcode = "";
	public String errordesc = "";
	public CreateRelazioneCampionamentoDoc(LinkedHashMap<String, Object> componenti, ArrayList<InterventoCampionamentoDTO> interventi, UtenteDTO user, Session session, ServletContext context) throws Exception {
		try {
			
			build(componenti,context,interventi,user,session);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(LinkedHashMap<String, Object> componenti,ServletContext context,  ArrayList<InterventoCampionamentoDTO> interventi, UtenteDTO user, Session session) throws Exception {
		
		RelazioneCampionamentoDTO relazione =GestioneInterventoCampionamentoBO.getTipoRelazione(interventi.get(0).getTipoMatrice().getId(),interventi.get(0).getTipologiaCampionamento().getId());	 
	
		
		if(relazione == null || relazione.getNomeRelazione() == null) {
			errorcode = "TRNF";
			errordesc = "Template Relazione non trovato. Contattare l'amministratore del sistema.";
			return;
		}
		
		CommessaDTO commessa = GestioneCommesseBO.getCommessaById(interventi.get(0).getID_COMMESSA());
		
		String idCommessaNormalizzata = interventi.get(0).getID_COMMESSA().replaceAll("/", "_");
		 
		 java.util.Date datea = new java.util.Date();
		  
		 SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMddHHmmss");
		  
		String nomeRelazione="REL_"+idCommessaNormalizzata+""+sdf.format(datea);
		
	      Path path = Paths.get( Costanti.PATH_FOLDER+"//templateRelazioni//"+relazione.getNomeRelazione());
		  byte[] byteData = Files.readAllBytes(path);

			// read as XWPFDocument from byte[]
		XWPFDocument document = new XWPFDocument(new ByteArrayInputStream(byteData));
		
       
		
		String clienteplaceholer = Costanti.CLIENTEPLACEHOLDER;
		String sedeplaceholer = Costanti.SEDEPLACEHOLDER;
		
  		String codicecommessaplaceholer = Costanti.CODICECOMMESSAPLACEHOLDER;
		String nomefileplaceholer = Costanti.NOMEFILEPLACEHOLDER;
		String dateprelieviplaceholer = Costanti.DATEPRELIEVIPLACEHOLDER;
		String notestabilimentoplaceholer = Costanti.NOTESTABILIMENTOPLACEHOLDER;
		String laboratorioplaceholer = Costanti.LABORATORIOPLACEHOLDER;
		
		String societaplaceholer = Costanti.SOCIETAPLACEHOLDER;
		String cvoperatoreplaceholer = Costanti.CVOPERATOREPLACEHOLER;
		//String operatoreplaceholer = Costanti.OPERATOREPLACEHOLDER;
		String dotazioniplaceholer = Costanti.DOTAZIONIPLACEHOLDER;
 		//String punticampionamentoplaceholer = Costanti.PUNTICAMPIONAMENTOPLACEHOLDER;
		String scehdecampionamentoplaceholer = Costanti.SCHEDECAMPIONAMENTOPLACEHOLDER;
 		String conclusioniplaceholer = Costanti.CONCLUSIONIPLACEHOLDER;
		
		String relazioneplaceholder = Costanti.RELAZIONEPLACEHOLDER;
		String relazionelabplaceholder = Costanti.RELAZIONELABPLACEHOLDER;
		
 

 		XWPFParagraph ptempCVOperatore = null;
 		XWPFParagraph ptempOperatore = null;
		XWPFParagraph ptempDotazioni = null;
		XWPFParagraph ptempPunti = null;
		XWPFParagraph ptempSchedeCamp = null;
 		XWPFParagraph ptempConclusioni = null;
		XWPFParagraph ptempRelazione = null;
		XWPFParagraph ptempRelazioneLab = null;
		
		
		
		
		HashMap<String,UtenteDTO> cvOperatori = new HashMap<String,UtenteDTO>();
		HashMap<String,DotazioneDTO> prenotazioni = new HashMap<String,DotazioneDTO>();
		String operatori = "";
		String datePrelievi="";
		String notestabilimento="";
 		for (InterventoCampionamentoDTO intervento : interventi) {

		    if(intervento.getListaPrenotazioniDotazioni().size()>0) {
			    		List<PrenotazioniDotazioneDTO> listPrenotazioni = new ArrayList<PrenotazioniDotazioneDTO>(intervento.getListaPrenotazioniDotazioni());
			    		
			    		for (PrenotazioniDotazioneDTO prenotazioniDotazioneDTO : listPrenotazioni) {
							if(!prenotazioni.containsKey(""+prenotazioniDotazioneDTO.getDotazione().getId())) {
								prenotazioni.put(""+prenotazioniDotazioneDTO.getDotazione().getId(), prenotazioniDotazioneDTO.getDotazione());
							}
						}
			    
		    }
		    if(!cvOperatori.containsKey(""+intervento.getUserUpload().getId())) {
		    		cvOperatori.put(""+intervento.getUserUpload().getId(), intervento.getUserUpload());
		    		operatori += intervento.getUserUpload().getNominativo()+", ";
			}
		    if(!datePrelievi.equals("")) {
		    	 	datePrelievi+=" - ";
		    }
		    SimpleDateFormat sdfs= new SimpleDateFormat("dd/MM/yyyy");
			  if(intervento.getDataInizio().toString() == intervento.getDataFine().toString()) {
				  datePrelievi+=sdfs.format(intervento.getDataInizio());
			  }else {
				  datePrelievi+="dal "+sdfs.format(intervento.getDataInizio())+" al "+sdfs.format(intervento.getDataFine());
			  }
			  //TO_DO AGGIUNGERE NOTE SU VERSIONE DESKTOP E RIPORTARLO QUI
			  notestabilimento+="TO_DO AGGIUNGERE NOTE SU VERSIONE DESKTOP E RIPORTARLO QUI";

		}
		
		
 		 
 		
 		
		Iterator<IBodyElement> iter = document.getBodyElementsIterator();
		while (iter.hasNext()) {
		   IBodyElement elem = iter.next();
		   if (elem instanceof XWPFParagraph) {
			   List<XWPFRun> runs = ((XWPFParagraph) elem).getRuns();
	            if (runs != null) {
	                for (XWPFRun r : runs) {
	                    String text = r.getText(0);

	              
	                    
	                    if (text != null && text.contains(clienteplaceholer)) {
	                    		text = text.replace(clienteplaceholer, commessa.getID_ANAGEN_NOME());
	                    		r.setText(text, 0);
	            	        
	                    }
	                    if (text != null && text.contains(societaplaceholer)) {
		                    	if(interventi.get(0).getUser().getCompany().getDenominazione()!=null) {
	                    			text = text.replace(societaplaceholer, interventi.get(0).getUser().getCompany().getDenominazione());
		                    	}else {
		                    		text = text.replace(societaplaceholer, "");
		                    	}
                    			r.setText(text, 0);
            	        
	                    }
	                    
	                    if (text != null && text.contains(codicecommessaplaceholer)) {
 	                    			text = text.replace(codicecommessaplaceholer, commessa.getID_COMMESSA());
		                    
	                			r.setText(text, 0);
	        	        
	                    }
	                    if (text != null && text.contains(nomefileplaceholer)) {
 	                    			text = text.replace(nomefileplaceholer, nomeRelazione+".docx");
		                    	 
	                			r.setText(text, 0);
	        	        
	                    }
	                    
	                    if (text != null && text.contains(dateprelieviplaceholer)) {
 	                    			text = text.replace(dateprelieviplaceholer, datePrelievi);
		                    
	                			r.setText(text, 0);
	        	        
	                    }
	                    
	                    if (text != null && text.contains(notestabilimentoplaceholer)) {
                 			text = text.replace(notestabilimentoplaceholer, notestabilimento);
                    
			            			r.setText(text, 0);
			    	        
	                    	}
	           
	                    
	                    if (text != null && text.contains(cvoperatoreplaceholer)) {
	                    		ptempCVOperatore = (XWPFParagraph) elem;
                				text = text.replace(cvoperatoreplaceholer, "");
                				r.setText(text, 0);
        	        
	                    }
//	                    if (text != null && text.contains(operatoreplaceholer)) {
//	                    		ptempOperatore = (XWPFParagraph) elem;
//	            				text = text.replace(operatoreplaceholer, operatori);
//	            				r.setText(text, 0);
//	    	        
//	                    }
	                    if (text != null && text.contains(dotazioniplaceholer)) {
                    			ptempDotazioni = (XWPFParagraph) elem;
            					text = text.replace(dotazioniplaceholer, "");
            					r.setText(text, 0);
    	        
	                    }
	                    
//	                    if (text != null && text.contains(punticampionamentoplaceholer)) {
//                				ptempPunti = (XWPFParagraph) elem;
//        						text = text.replace(punticampionamentoplaceholer, "");
//        						r.setText(text, 0);
//	        
//	                    }
	                    if (text != null && text.contains(scehdecampionamentoplaceholer)) {
            					ptempSchedeCamp = (XWPFParagraph) elem;
    							text = text.replace(scehdecampionamentoplaceholer, "");
    							r.setText(text, 0);
        
	                    }
	            
	                    
	                    if (text != null && text.contains(sedeplaceholer)) {
	                    		if(commessa.getANAGEN_INDR_INDIRIZZO() != null && !commessa.getANAGEN_INDR_INDIRIZZO().equals("")) {
	                    			text = text.replace(sedeplaceholer, commessa.getANAGEN_INDR_INDIRIZZO());
	               				
	                    		}else if(commessa.getINDIRIZZO_PRINCIPALE() != null) {
	                    			text = text.replace(sedeplaceholer, commessa.getINDIRIZZO_PRINCIPALE());
	                    		}else {
	                    			text = text.replace(sedeplaceholer, "");
	                    			
	                    		}
	                    		r.setText(text, 0);
	                    }
	                    
	                    if (text != null && text.contains(conclusioniplaceholer)) {
		                    	ptempConclusioni = (XWPFParagraph) elem;
							text = text.replace(conclusioniplaceholer, componenti.get("text").toString());
							r.setText(text, 0);

	                    }
	                    if (text != null && text.contains(laboratorioplaceholer)) {
	                    			text = text.replace(laboratorioplaceholer, componenti.get("laboratorio").toString());
	                    			r.setText(text, 0);

	                    }
	                    
	                    if (text != null && text.contains(relazioneplaceholder)) {
	                    		ptempRelazione = (XWPFParagraph) elem;
							text = text.replace(relazioneplaceholder, "");
							r.setText(text, 0);
							
    
	                    }
	                    if (text != null && text.contains(relazionelabplaceholder)) {
	                    		ptempRelazioneLab = (XWPFParagraph) elem;
							text = text.replace(relazionelabplaceholder, "");
							r.setText(text, 0);
    
	                    }
	                }
	            }

			   
		   } else if (elem instanceof XWPFTable) {
			   List<XWPFTableRow> rown = ((XWPFTable) elem).getRows();
			   for (XWPFTableRow xwpfTableRow : rown) {
				   List<XWPFTableCell> cells = xwpfTableRow.getTableCells();
				   for (XWPFTableCell xwpfTableCell : cells) {

					   for (XWPFParagraph parag : xwpfTableCell.getParagraphs()) {

						   List<XWPFRun> runs = ((XWPFParagraph) parag).getRuns();
				            if (runs != null) {
				                for (XWPFRun r : runs) {
				                    String text = r.getText(0);
				                    

				                    if (text != null && text.contains(clienteplaceholer)) {
				                    		text = text.replace(clienteplaceholer, commessa.getID_ANAGEN_NOME());
				                    		r.setText(text, 0);
				            	        
				                    }
				                    if (text != null && text.contains(societaplaceholer)) {
		                    				text = text.replace(societaplaceholer, interventi.get(0).getUserUpload().getCompany().getDenominazione());
		                    				r.setText(text, 0);
		            	        
				                    }
				                    if (text != null && text.contains(sedeplaceholer)) {
				                    		if(commessa.getANAGEN_INDR_INDIRIZZO() != null) {
				                    			text = text.replace(sedeplaceholer, commessa.getANAGEN_INDR_INDIRIZZO());
			                   				
				                    		}else if(commessa.getINDIRIZZO_PRINCIPALE() != null) {
				                    			text = text.replace(sedeplaceholer, commessa.getINDIRIZZO_PRINCIPALE());
				                    		}else {
				                    			text = text.replace(sedeplaceholer, "");
				                    			
				                    		}
				                    		r.setText(text, 0);
				                    }
				                    
				                    if (text != null && text.contains(conclusioniplaceholer)) {
				                    		ptempConclusioni = (XWPFParagraph) elem;
				                    		text = text.replace(conclusioniplaceholer, componenti.get("text").toString());
				                    		r.setText(text, 0);

				                    }
				                    if (text != null && text.contains(relazioneplaceholder)) {
				                    		ptempRelazione = (XWPFParagraph) elem;
										text = text.replace(relazioneplaceholder, "");
										r.setText(text, 0);
									
		    
				                    }
				                    if (text != null && text.contains(codicecommessaplaceholer)) {
		 	                    			text = text.replace(codicecommessaplaceholer, commessa.getID_COMMESSA());
				                    
				                			r.setText(text, 0);
				        	        
				                    }
				                    if (text != null && text.contains(nomefileplaceholer)) {
			 	                    			text = text.replace(nomefileplaceholer, nomeRelazione+".docx");
					                    	 
				                			r.setText(text, 0);
				        	        
				                    }
				                }
				            }

				        }
				   }
			   }

		   }
		}
		
		
 
		String idsInterventi = "";
		for (InterventoCampionamentoDTO intervento : interventi) {
			
			if(idsInterventi.equals("")) {
				idsInterventi+=""+intervento.getId();
			}else {
				idsInterventi+="|"+intervento.getId();
			}
		
			PDFDocument documentx = new PDFDocument();
	        File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//"+intervento.getNomePack()+".pdf");
		    documentx.load(d);
	        SimpleRenderer renderer = new SimpleRenderer();
	        renderer.setResolution(150);
		    List<Image> images = renderer.render(documentx);
		    for (int i = 0; i < images.size(); i++) {
		    	
		    	
		    			BufferedImage imgRendered =	(BufferedImage) images.get(i);
		    	
		    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
		    			 
		    			
		    			
		    		    File f =File.createTempFile("temp", Long.toString(System.nanoTime())+".png");
		    			
		    			double w = ((BufferedImage)imgRotate).getWidth() * 0.35;
		    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
		    			ImageIO.write((RenderedImage) imgRotate, "png",f);
	
	
		    			
		    		    XWPFRun imageRun = ptempSchedeCamp.createRun();
		    		    imageRun.setTextPosition(0);
		    		    InputStream fis = (InputStream) Files.newInputStream(Paths.get(f.getPath()));
		    	        imageRun.addPicture(fis, XWPFDocument.PICTURE_TYPE_PNG, f.getName(), Units.toEMU(w), Units.toEMU(h));
		    	        fis.close();
		    	        f.delete();
		    		
		   
	        }
		    
		    

		}
		
		if(ptempCVOperatore != null) {
			Iterator operatoriIterator = cvOperatori.entrySet().iterator();
			while (operatoriIterator.hasNext()) {
					Map.Entry pair = (Map.Entry)operatoriIterator.next();
					
	 				UtenteDTO operatore = (UtenteDTO) pair.getValue();
					
					if(operatore.getCv() != null) {
						
						PDFDocument cvOperatore = new PDFDocument();
						cvOperatore.load(new File(Costanti.PATH_FOLDER+"//Curriculum//"+operatore.getCv()));
						
						  SimpleRenderer rendererRelazione = new SimpleRenderer();
						  rendererRelazione.setResolution(150);
						  List<Image> imagesRelazione = rendererRelazione.render(cvOperatore);
						    for (int i = 0; i < imagesRelazione.size(); i++) {
						    	
						    	
						    			BufferedImage imgRendered =	(BufferedImage) imagesRelazione.get(i);
						    	
						    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
						    			
						    			File fd =new File(Costanti.PATH_FOLDER+"//Relazioni//"+idCommessaNormalizzata+"//temp//"+(i + 1) + "cv.png");
						    			double w = ((BufferedImage)imgRotate).getWidth() * 0.35;
						    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
						    			ImageIO.write((RenderedImage) imgRotate, "png",fd );
	
	
						    			
						    		    XWPFRun imageRun = ptempCVOperatore.createRun();
						    		    imageRun.setTextPosition(0);
						    		    Path imagePath = Paths.get(fd.getPath());
						    		    
						    		    InputStream fis = (InputStream) Files.newInputStream(imagePath);
						    		    
						    	        imageRun.addPicture(fis, XWPFDocument.PICTURE_TYPE_PNG, imagePath.getFileName().toString(), Units.toEMU(w), Units.toEMU(h));
						    	        fis.close();
						    	        fd.delete();
						   
					        }
	
				}
			}
		}
		if(ptempDotazioni!= null) {
			
			Iterator dotazioniIterator = prenotazioni.entrySet().iterator();
			while (dotazioniIterator.hasNext()) {
					Map.Entry pair = (Map.Entry)dotazioniIterator.next();
					
	 				DotazioneDTO dotazione = (DotazioneDTO) pair.getValue();
					
					if(dotazione.getSchedaTecnica() != null) {
						
						PDFDocument dotazionePdf = new PDFDocument();
						dotazionePdf.load(new File(Costanti.PATH_FOLDER+"//Dotazioni//"+dotazione.getId()+"//"+dotazione.getSchedaTecnica()));
						
						  SimpleRenderer rendererRelazione = new SimpleRenderer();
						  rendererRelazione.setResolution(150);
						  List<Image> imagesRelazione = rendererRelazione.render(dotazionePdf);
						    for (int i = 0; i < imagesRelazione.size(); i++) {
						    	
						    	
						    			BufferedImage imgRendered =	(BufferedImage) imagesRelazione.get(i);
						    	
						    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
						    			
						    			File fd =new File(Costanti.PATH_FOLDER+"//Relazioni//"+idCommessaNormalizzata+"//temp//"+(i + 1) + "d.png");
						    			double w = ((BufferedImage)imgRotate).getWidth() * 0.35;
						    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
						    			ImageIO.write((RenderedImage) imgRotate, "png",fd );
	
	
						    			
						    		    XWPFRun imageRun = ptempDotazioni.createRun();
						    		    imageRun.setTextPosition(0);
						    		    Path imagePath = Paths.get(fd.getPath());
						    		    
						    		    InputStream fis = (InputStream) Files.newInputStream(imagePath);
						    		    
						    	        imageRun.addPicture(fis, XWPFDocument.PICTURE_TYPE_PNG, imagePath.getFileName().toString(), Units.toEMU(w), Units.toEMU(h));
						    	        fis.close();
						    	        fd.delete();
						   
					        }
	
				}
			}
		}
		if(ptempRelazione!= null) {
			
		
		
	    SimpleRenderer rendererRelazione = new SimpleRenderer();
	    rendererRelazione.setResolution(150);
	    
	    
	    XmlCursor cursorTable = ptempRelazione.getCTP().newCursor();//this is the key!
	    
	    ArrayList<XSSFWorkbook> relazioni = (ArrayList<XSSFWorkbook>) componenti.get("relazione");
	    for (XSSFWorkbook docRel : relazioni) {

		   
		   XWPFTable table2 = document.insertNewTbl(cursorTable);
		   XWPFTableRow rowy = table2.getRow(0);
		   
		   cursorTable = ptempRelazione.getCTP().newCursor();
		   document.insertNewParagraph(cursorTable);
		   cursorTable = ptempRelazione.getCTP().newCursor();
		   
		   if(docRel!=null)
		   {	   
			   
			   DataFormatter formatter = new DataFormatter();
			   XSSFSheet sheet1 = docRel.getSheet("Dati Campionamento");
			   XSSFSheet sheet2 = docRel.getSheet("Risultati Laboratorio");
			   
			   
			   int rowsCountsheet1 = sheet1.getLastRowNum()+1;
			   int rowsCountsheet2 = sheet2.getLastRowNum()+1;
			   
			   int colsCountsheet1 = sheet1.getRow(0).getPhysicalNumberOfCells();
			   int colsCountsheet2 = sheet2.getRow(0).getPhysicalNumberOfCells();
			   
			   ArrayList<ArrayList<String>> strutture = new ArrayList<ArrayList<String>>();
			   
			   for(int i=0; i<rowsCountsheet2; i++) {
				   Row row = sheet2.getRow(i);
				   int colCounts = row.getLastCellNum();
				   ArrayList<String> struttura = new ArrayList<String>();
				   for (int j = 0; j < colCounts; j++) {
	                    Cell cell = row.getCell(j);
	                    
	                    String val = formatter.formatCellValue(cell);
	                    if(j==0) {
	                    		if(i==0) {
 			                    		 Row rowz = sheet1.getRow(0);
			                    		 int colCountsz = rowz.getLastCellNum();
			                    		 String valCellx = formatter.formatCellValue(rowz.getCell(0));
			                    		 for (int x = 0; x < colCountsz; x++) {
			                    			 Cell cellx = rowz.getCell(x);
			                    			 String valx = formatter.formatCellValue(cellx);
			                    			 struttura.add(valx);
			                    		 }

	                    		}else {
	                    			for (int z= 1; z < rowsCountsheet1; z++) {
			                    		 Row rowz = sheet1.getRow(z);
			                    		 int colCountsz = rowz.getLastCellNum();
			                    		 String valCellx = formatter.formatCellValue(rowz.getCell(0));
			                    		 if(valCellx.equals(val)) {
				                    		 for (int x = 0; x < colCountsz; x++) {
				                    			 Cell cellx = rowz.getCell(x);
				                    			 String valx = formatter.formatCellValue(cellx);
				                    			 struttura.add(valx);
				                    		 }
			                    		 }
			                    	 }
	                    		}
	                    	
	                    }
	                    if(j!=0) {
	                    		struttura.add(val);
	                    }
	                    
	                    
					}
					   
						   strutture.add(struttura);
					   
						   
					   
				   }
				   
				   
				  
	     
				   XWPFTableCell cell11 = rowy.getCell(0);
				   
				   XWPFParagraph paragraph = rowy.getCell(0).getParagraphArray(0);
	               setRun(paragraph.createRun() , "Calibre LIght" , 6, "000000" , strutture.get(0).get(0) , true, false);
	               addStyleToCell(rowy.getCell(0),"A7BFDE",ParagraphAlignment.CENTER);
				   
	 			   for (int j = 1; j < strutture.get(0).size(); j++) {
	 			  
						XWPFTableCell cellh = rowy.createCell();
						//cellh.setText(strutture.get(0).get(j));
						  XWPFParagraph paragraph2 = cellh.getParagraphArray(0);
			               setRun(paragraph2.createRun() , "Calibre LIght" , 6, "000000" , strutture.get(0).get(j) , true, false);
			               addStyleToCell(cellh,"A7BFDE",ParagraphAlignment.CENTER);
	               }
	
	
	
	 	            String punto = "";
		            int iteratorInit = 1;
		            int iteratorFine = 1;
		            int iteradd = 1;
		            for (int i = 1; i < strutture.size(); i++) {
		            		ArrayList<String> struttura = strutture.get(i);
		            		 rowy = table2.createRow();
		                for (int j = 0; j < struttura.size(); j++) {
	 	                    
		                    String val = struttura.get(j);
		                   	               
		                    
							 XWPFTableCell cellb = rowy.getCell(j);
							 
							 XWPFParagraph paragraph2 = cellb.getParagraphArray(0);
				               setRun(paragraph2.createRun() , "Calibre LIght" , 6, "000000" , val , false, false);
				               addStyleToCell(cellb,"FFFFFF",ParagraphAlignment.CENTER);
							 //cellb.setText(val);
	 						 if(j==0) {
				                    
		                    	 	if(!punto.equals("") && !punto.equals(val)) {
		                    	 		if(iteratorInit != iteratorFine) {
		                    	 			for(int y = 0; y<colsCountsheet1; y++) {
		                    	 				mergeCellVertically(table2, y, iteratorInit, iteratorFine-1); 
		                    	 			}
		                    	 			iteratorInit = iteratorFine;
		                    	 			iteratorFine++;
		                    	 			iteradd = 1;
		                    	 		}
		     	                }else if(punto.equals(val) || punto.equals("")){
		     	                		iteratorFine++;
		     	                }
		                    	
		                    		punto = val;
		                    }
	
		                }
		               
		            }
		            System.out.println(rowsCountsheet1);    
		            if(iteratorInit != iteratorFine) {
		            		for(int y = 0; y<colsCountsheet1; y++) {
		            			mergeCellVertically(table2, y, iteratorInit, iteratorFine-iteradd); 
		            		}
	    	 			}
			   


		   		}
		   
	    		}
		}  
		if(ptempRelazioneLab!=null) {
		    SimpleRenderer rendererRelazioneLab = new SimpleRenderer();
		    rendererRelazioneLab.setResolution(150);
	        Document docRelLab =(Document) componenti.get("relazioneLab");
		     
	        if(docRelLab!=null) 
	        {
		    List<Image> imagesRelazioneLab = rendererRelazioneLab.render(docRelLab);
		    
		    for (int i = 0; i < imagesRelazioneLab.size(); i++) {
		    	
		    	
		    			BufferedImage imgRendered =	(BufferedImage) imagesRelazioneLab.get(i);
		    	
		    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
		    			
		    			File fd =new File(Costanti.PATH_FOLDER+"//Relazioni//"+idCommessaNormalizzata+"//temp//"+(i + 1) + "l.png");
		    			double w = ((BufferedImage)imgRotate).getWidth() * 0.35;
		    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
		    			ImageIO.write((RenderedImage) imgRotate, "png",fd );
	
		    			
		    			
		    		    XWPFRun imageRun = ptempRelazioneLab.createRun();
		    		    imageRun.setTextPosition(0);
		    		    Path imagePath = Paths.get(fd.getPath());
		    		    
		    		    InputStream fis = (InputStream) Files.newInputStream(imagePath);
		    	        
		    		    imageRun.addPicture(fis, XWPFDocument.PICTURE_TYPE_PNG, imagePath.getFileName().toString(), Units.toEMU(w), Units.toEMU(h));
		    		    fis.close();
		    	        fd.delete();  
		    	        
		   
	        	}		
			
	        }
		}
// SET HEADER E FOOTER DINAMICAMENTE
		    XWPFParagraph paragraph = document.createParagraph();
		    XWPFRun run=paragraph.createRun();  
		    // create header start
		    CTSectPr sectPr = document.getDocument().getBody().addNewSectPr();
		    XWPFHeaderFooterPolicy headerFooterPolicy = new XWPFHeaderFooterPolicy(document, sectPr);

		    XWPFHeader header = headerFooterPolicy.createHeader(XWPFHeaderFooterPolicy.DEFAULT);

		    paragraph = header.createParagraph();
		    
		    paragraph.setAlignment(ParagraphAlignment.LEFT);

		    CTTabStop tabStop = paragraph.getCTP().getPPr().addNewTabs().addNewTab();
		    tabStop.setVal(STTabJc.RIGHT);
		    int twipsPerInch =  1440;
		    tabStop.setPos(BigInteger.valueOf(6 * twipsPerInch));

		    run = paragraph.createRun();  
		  

		    run = paragraph.createRun();  
		    String imgFile=Costanti.PATH_FOLDER_LOGHI+"/"+interventi.get(0).getUser().getCompany().getNomeLogo();

		    run.addPicture(new FileInputStream(imgFile), XWPFDocument.PICTURE_TYPE_PNG, imgFile, Units.toEMU(450), Units.toEMU(50));


		 // create footer

		    CTP ctpFooter = CTP.Factory.newInstance();

		    XWPFParagraph[] parsFooter;

		    // add style (s.th.)
		    CTPPr ctppr = ctpFooter.addNewPPr();
		    CTString pst = ctppr.addNewPStyle();
		    pst.setVal("style21");
		    CTJc ctjc = ctppr.addNewJc();
		    ctjc.setVal(STJc.RIGHT);
		    //ctppr.addNewRPr();

		    // Add in word "Page "   
		    CTR ctr = ctpFooter.addNewR();
		    CTText t = ctr.addNewT();
		    t.setStringValue("Pag. ");
		    t.setSpace(Space.PRESERVE);

		    // add everything from the footerXXX.xml you need
		    ctr = ctpFooter.addNewR();
		    ctr.addNewRPr();
		    CTFldChar fch = ctr.addNewFldChar();
		    fch.setFldCharType(STFldCharType.BEGIN);

		    ctr = ctpFooter.addNewR();
		    ctr.addNewInstrText().setStringValue(" PAGE ");

		    ctpFooter.addNewR().addNewFldChar().setFldCharType(STFldCharType.SEPARATE);

		    ctpFooter.addNewR().addNewT().setStringValue("1");

		    ctpFooter.addNewR().addNewFldChar().setFldCharType(STFldCharType.END);
		    
		    
		    ctr = ctpFooter.addNewR();
		    CTText t2 = ctr.addNewT();
		    t2.setStringValue(" di ");
		    t2.setSpace(Space.PRESERVE);
		    
		    
		    ctr = ctpFooter.addNewR();
		    ctr.addNewRPr();
		    CTFldChar fch2 = ctr.addNewFldChar();
		    fch2.setFldCharType(STFldCharType.BEGIN);

		    ctr = ctpFooter.addNewR();
		    ctr.addNewInstrText().setStringValue(" NUMPAGES ");
		    
		    
		    ctpFooter.addNewR().addNewFldChar().setFldCharType(STFldCharType.SEPARATE);

		    ctpFooter.addNewR().addNewT().setStringValue("1");

		    ctpFooter.addNewR().addNewFldChar().setFldCharType(STFldCharType.END);

		    XWPFParagraph footerParagraph = new XWPFParagraph(ctpFooter, document);

		    parsFooter = new XWPFParagraph[1];

		    parsFooter[0] = footerParagraph;

		    headerFooterPolicy.createFooter(XWPFHeaderFooterPolicy.DEFAULT, parsFooter);

		
		
	      
		  //Write the Document in file system
	      FileOutputStream out = new FileOutputStream( new File(Costanti.PATH_FOLDER+"//Relazioni//"+idCommessaNormalizzata+"//"+nomeRelazione+".docx"));
	      document.write(out);
	      out.close(); 
	      document.close();
	      
	      
	      RapportoCampionamentoDTO rapportoCampionamento = new RapportoCampionamentoDTO();
	      rapportoCampionamento.setIdCommessa(commessa.getID_COMMESSA());
	      rapportoCampionamento.setIdsInterventi(idsInterventi);
	      rapportoCampionamento.setNomeFile(nomeRelazione);
	      rapportoCampionamento.setTipoRelazione(relazione);
	      rapportoCampionamento.setUserCreation(user);
	      
	      Date dNow = new Date(Calendar.getInstance().getTime().getTime());
	      rapportoCampionamento.setDataCreazione(dNow);
	      
	      session.save(rapportoCampionamento);
	      
	      idRelazione = rapportoCampionamento.getId();

	      System.out.println("createdocument.docx written successully");
	      
	    
	      
	}
	
	
	public static void main(String[] args) throws HibernateException, Exception {
		   
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		 ArrayList<InterventoCampionamentoDTO> interventi = new ArrayList<InterventoCampionamentoDTO>();
		 InterventoCampionamentoDTO intervento1 = GestioneCampionamentoBO.getIntervento("52");

		 InterventoCampionamentoDTO intervento2 = GestioneCampionamentoBO.getIntervento("53");
		 
		 interventi.add(intervento1);
		 interventi.add(intervento2);

			LinkedHashMap<String, Object> componenti = new LinkedHashMap<>();

			componenti.put("text", "aaaaa aaaaa cccc dddd aaaaa wwww aaaaa aaaaa");
			componenti.put("laboratorio", "Edr srl");
			componenti.put("scheda", null);
			
			new CreateRelazioneCampionamentoDoc(componenti,interventi,null,null,null);
			session.getTransaction().commit();
			session.close();	
	   }
	
	private static void mergeCellVertically(XWPFTable table, int col, int fromRow, int toRow) {

        for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {

            XWPFTableCell cell = table.getRow(rowIndex).getCell(col);

            if ( rowIndex == fromRow ) {
                // The first merged cell is set with RESTART merge value
                cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.RESTART);
            } else {
                // Cells which join (merge) the first one, are set with CONTINUE
                cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.CONTINUE);
            }
        }
    }
	private static void setRun (XWPFRun run , String fontFamily , int fontSize , String colorRGB , String text , boolean bold , boolean addBreak) {
        run.setFontFamily(fontFamily);
        run.setFontSize(fontSize);
        run.setColor(colorRGB);
        run.setText(text);
        run.setBold(bold);
        if (addBreak) run.addBreak();
    }
	private static void addStyleToCell(XWPFTableCell cell, String bgColor, ParagraphAlignment alignment) {
		 // get a table cell properties element (tcPr)
        CTTcPr tcpr = cell.getCTTc().addNewTcPr();
        // set vertical alignment to "center"
        CTVerticalJc va = tcpr.addNewVAlign();
        va.setVal(STVerticalJc.CENTER);

        // create cell color element
        CTShd ctshd = tcpr.addNewShd();
        ctshd.setColor("auto");
        ctshd.setVal(STShd.CLEAR);
      
            ctshd.setFill(bgColor);
    

        // get 1st paragraph in cell's paragraph list
        XWPFParagraph para = cell.getParagraphs().get(0);
        para.setAlignment(alignment);
   
        
	}
	
}
