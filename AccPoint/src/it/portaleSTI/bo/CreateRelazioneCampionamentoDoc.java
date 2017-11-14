package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.poi.util.Units;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.IBodyElement;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.xmlbeans.XmlCursor;
import org.apache.xmlbeans.impl.xb.xmlschema.SpaceAttribute.Space;
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
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTString;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTabStop;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTText;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STFldCharType;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTabJc;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;

public class CreateRelazioneCampionamentoDoc {
	public CreateRelazioneCampionamentoDoc(LinkedHashMap<String, Object> componenti, InterventoCampionamentoDTO intervento, Session session, ServletContext context) throws Exception {
		try {
			
			build(componenti,context,intervento);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(LinkedHashMap<String, Object> componenti,ServletContext context, InterventoCampionamentoDTO intervento) throws Exception {
		
		 
		CommessaDTO commessa = GestioneCommesseBO.getCommessaById(intervento.getID_COMMESSA());
		
	      Path path = Paths.get( Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//relazioneTemp.docx");
			byte[] byteData = Files.readAllBytes(path);

			// read as XWPFDocument from byte[]
		XWPFDocument document = new XWPFDocument(new ByteArrayInputStream(byteData));
		
       
		
		String clienteplaceholer = "CLIENTEPLACEHOLDER";
		String scehdeplaceholer = "SEDEPLACEHOLDER";
		String societaplaceholer = "SOCIETAPLACEHOLDER";
		String cvoperatoreplaceholer = "CVOPERATOREPLACEHOLER";
		String dotazioniplaceholer = "DOTAZIONIPLACEHOLDER";
		String allegatodotazioniplaceholer = "ALLEGATIDOTAZIONIPLACEHOLDER";
		String punticampionamentoplaceholer = "PUNTICAMPIONAMENTOPLACEHOLDER";
		String scehdecampionamentoplaceholer = "SCHEDECAMPIONAMENTOPLACEHOLDER";
		String rapportidiprovaplaceholer = "RAPPORTIDIPROVAPLACEHOLDER";

		XWPFParagraph ptempAllegatiDotazioni = null;
		XWPFParagraph ptempCVOperatore = null;
		XWPFParagraph ptempDotazioni = null;
		XWPFParagraph ptempPunti = null;
		XWPFParagraph ptempSchedeCamp = null;
		XWPFParagraph ptempRappProva = null;

		Iterator<IBodyElement> iter = document.getBodyElementsIterator();
		while (iter.hasNext()) {
		   IBodyElement elem = iter.next();
		   if (elem instanceof XWPFParagraph) {
			   List<XWPFRun> runs = ((XWPFParagraph) elem).getRuns();
	            if (runs != null) {
	                for (XWPFRun r : runs) {
	                    String text = r.getText(0);
	                    
	                    if (text != null && text.contains("CODICE RIFERIMENTO")) {
	                    	
                   			ptempAllegatiDotazioni = (XWPFParagraph) elem;
                   			text = text.replace(allegatodotazioniplaceholer, "XXXXXXXXX");
                   			r.setText(text, 0);
	            	        
	                    }
	                    if (text != null && text.contains(allegatodotazioniplaceholer)) {
	                    	
	                    		ptempAllegatiDotazioni = (XWPFParagraph) elem;
	                        text = text.replace(allegatodotazioniplaceholer, "");
	                        r.setText(text, 0);
		            	        
	                    }
	                    
	                    if (text != null && text.contains(clienteplaceholer)) {
	                    		text = text.replace(clienteplaceholer, commessa.getID_ANAGEN_NOME());
	                    		r.setText(text, 0);
	            	        
	                    }
	                    if (text != null && text.contains(societaplaceholer)) {
		                    	if(intervento.getUser().getCompany().getDenominazione()!=null) {
	                    			text = text.replace(societaplaceholer, intervento.getUser().getCompany().getDenominazione());
		                    	}else {
		                    		text = text.replace(societaplaceholer, "");
		                    	}
                    			r.setText(text, 0);
            	        
	                    }
	                    if (text != null && text.contains(cvoperatoreplaceholer)) {
	                    		ptempCVOperatore = (XWPFParagraph) elem;
                				text = text.replace(cvoperatoreplaceholer, "");
                				r.setText(text, 0);
        	        
	                    }
	                    if (text != null && text.contains(dotazioniplaceholer)) {
                    			ptempDotazioni = (XWPFParagraph) elem;
            					text = text.replace(dotazioniplaceholer, "");
            					r.setText(text, 0);
    	        
	                    }
	                    
	                    if (text != null && text.contains(punticampionamentoplaceholer)) {
                				ptempPunti = (XWPFParagraph) elem;
        						text = text.replace(punticampionamentoplaceholer, "");
        						r.setText(text, 0);
	        
	                    }
	                    if (text != null && text.contains(scehdecampionamentoplaceholer)) {
            					ptempSchedeCamp = (XWPFParagraph) elem;
    							text = text.replace(scehdecampionamentoplaceholer, "");
    							r.setText(text, 0);
        
	                    }
	                    
	                    if (text != null && text.contains(rapportidiprovaplaceholer)) {
        						ptempRappProva = (XWPFParagraph) elem;
							text = text.replace(rapportidiprovaplaceholer, "");
							r.setText(text, 0);
    
	                    }
	                    
	                    if (text != null && text.contains(scehdeplaceholer)) {
	                    		if(commessa.getANAGEN_INDR_INDIRIZZO() != null) {
	                    			text = text.replace(scehdeplaceholer, commessa.getANAGEN_INDR_INDIRIZZO());
	               				
	                    		}else if(commessa.getINDIRIZZO_PRINCIPALE() != null) {
	                    			text = text.replace(scehdeplaceholer, commessa.getINDIRIZZO_PRINCIPALE());
	                    		}else {
	                    			text = text.replace(scehdeplaceholer, "");
	                    			
	                    		}
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
				                    
				                    if (text != null && text.contains("CODICE RIFERIMENTO")) {
				                    	
			                   			ptempAllegatiDotazioni = (XWPFParagraph) parag;
			                   			text = text.replace(allegatodotazioniplaceholer, "XXXXXXXXX");
			                   			r.setText(text, 0);
				            	        
				                    }
				                    if (text != null && text.contains(allegatodotazioniplaceholer)) {
				                    	
				                    		ptempAllegatiDotazioni = (XWPFParagraph) parag;
				                        text = text.replace(allegatodotazioniplaceholer, "");
				                        r.setText(text, 0);
					            	        
				                    }
				                    
				                    if (text != null && text.contains(clienteplaceholer)) {
				                    		text = text.replace(clienteplaceholer, commessa.getID_ANAGEN_NOME());
				                    		r.setText(text, 0);
				            	        
				                    }
				                    if (text != null && text.contains(societaplaceholer)) {
		                    				text = text.replace(societaplaceholer, intervento.getUserUpload().getCompany().getDenominazione());
		                    				r.setText(text, 0);
		            	        
				                    }
				                    if (text != null && text.contains(scehdeplaceholer)) {
				                    		if(commessa.getANAGEN_INDR_INDIRIZZO() != null) {
				                    			text = text.replace(scehdeplaceholer, commessa.getANAGEN_INDR_INDIRIZZO());
			                   				
				                    		}else if(commessa.getINDIRIZZO_PRINCIPALE() != null) {
				                    			text = text.replace(scehdeplaceholer, commessa.getINDIRIZZO_PRINCIPALE());
				                    		}else {
				                    			text = text.replace(scehdeplaceholer, "");
				                    			
				                    		}
				                    		r.setText(text, 0);
				                    }
				                }
				            }

				        }
				   }
			   }

		   }
		}
		

		
		
		

//		  ptempCVOperatore 
//		  ptempDotazioni 
//		  ptempPunti 
//		  ptempSchedeCamp  
//		  ptempRappProva 
//		
		Path pathDotazione = Paths.get( Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//microflow.docx");
		byte[] byteDataDotazione = Files.readAllBytes(pathDotazione);

		// read as XWPFDocument from byte[]
		XWPFDocument documentDotazione = new XWPFDocument(new ByteArrayInputStream(byteDataDotazione));
		
		
		Iterator<IBodyElement> iterDoc = documentDotazione.getBodyElementsIterator();
		while (iterDoc.hasNext()) {
		   IBodyElement elem = iterDoc.next();
		   if (elem instanceof XWPFParagraph) {
			   List<XWPFRun> runs = ((XWPFParagraph) elem).getRuns();
	            if (runs != null) {
	                for (XWPFRun r : runs) {
	                		ptempDotazioni.addRun(r);
	                }
	            }

			   
		   } else if (elem instanceof XWPFTable) {
			    
			   XmlCursor cursor = ptempDotazioni.getCTP().newCursor();
			   document.insertTable(0, (XWPFTable) elem);

		   }
		}
		
		
		 
		PDFDocument documentx = new PDFDocument();
        File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//"+intervento.getNomePack()+".pdf");
	    documentx.load(d);
        SimpleRenderer renderer = new SimpleRenderer();
        
	    List<Image> images = renderer.render(documentx);
	    for (int i = 0; i < images.size(); i++) {
	    	
	    	
	    			BufferedImage imgRendered =	(BufferedImage) images.get(i);
	    	
	    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
	    			 
	    			double w = ((BufferedImage)imgRotate).getWidth() * 0.75;
	    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
	    			ImageIO.write((RenderedImage) imgRotate, "png", new File("/Users/marcopagnanelli/Downloads/imageACC/"+(i + 1) + ".png"));


	    			
	    		    XWPFRun imageRun = ptempSchedeCamp.createRun();
	    		    imageRun.setTextPosition(0);
	    		    Path imagePath = Paths.get("/Users/marcopagnanelli/Downloads/imageACC/"+(i + 1) + ".png");
	    	        imageRun.addPicture(Files.newInputStream(imagePath), XWPFDocument.PICTURE_TYPE_PNG, imagePath.getFileName().toString(), Units.toEMU(w), Units.toEMU(h));

	    		
	   
        }
		
	    
	    
	      //Blank Document
	      //XWPFDocument document = new XWPFDocument(); 
			
//	      XWPFParagraph title = document.createParagraph();
//	        title.setAlignment(ParagraphAlignment.CENTER);
//	        XWPFRun titleRun = title.createRun();
//	        titleRun.setText("Build Your REST API with Spring");
//	        titleRun.setColor("009933");
//	        titleRun.setBold(true);
//	        titleRun.setFontFamily("Courier");
//	        titleRun.setFontSize(20);
//
//	        XWPFParagraph subTitle = document.createParagraph();
//	        subTitle.setAlignment(ParagraphAlignment.CENTER);
//	        XWPFRun subTitleRun = subTitle.createRun();
//	        subTitleRun.setText("from HTTP fundamentals to API Mastery");
//	        subTitleRun.setColor("00CC44");
//	        subTitleRun.setFontFamily("Courier");
//	        subTitleRun.setFontSize(16);
//	        subTitleRun.setTextPosition(20);
//	        subTitleRun.setUnderline(UnderlinePatterns.DOT_DOT_DASH);
//
//	        
//	        XWPFParagraph content1 = document.createParagraph();
//	        content1.setAlignment(ParagraphAlignment.CENTER);
//	        XWPFRun content1Run = content1.createRun();
//	        content1Run.setText("from HTTP fundamentals to API Mastery");
//	        content1Run.setColor("00CC44");
//	        content1Run.setFontFamily("Courier");
//	        content1Run.setFontSize(16);
//	        content1Run.setTextPosition(20);
//	        content1Run.setUnderline(UnderlinePatterns.DOT_DOT_DASH);
//	        content1.setPageBreak(true);
//	 		
//	        XWPFParagraph content2 = document.createParagraph();
//	        content2.setAlignment(ParagraphAlignment.CENTER);
//	        XWPFRun content2Run = content2.createRun();
//	        content2Run.setText("CERTIFICATI CAMPIONI");
//	        content2Run.setColor("000000");
//	        content2Run.setFontFamily("Arial");
//	        content2Run.setFontSize(16);
//	        content2Run.setTextPosition(20);
//	        
//			  
//	        PDFDocument documentx = new PDFDocument();
//	        File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//"+intervento.getNomePack()+".pdf");
//		    documentx.load(d);
//	        SimpleRenderer renderer = new SimpleRenderer();
//		    
//	        XWPFParagraph image = document.createParagraph();
//		    image.setAlignment(ParagraphAlignment.CENTER);
//		    // set resolution (in DPI)
//		    //renderer.setResolution(300);
//		    List<Image> images = renderer.render(documentx);
//		    for (int i = 0; i < images.size(); i++) {
//		    	
//		    	
//		    			BufferedImage imgRendered =	(BufferedImage) images.get(i);
//		    	
//		    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
//		    			 
//		    			double w = ((BufferedImage)imgRotate).getWidth() * 0.75;
//		    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
//		    			ImageIO.write((RenderedImage) imgRotate, "png", new File("/Users/marcopagnanelli/Downloads/imageACC/"+(i + 1) + ".png"));
//
//
//		    			
//		    		    XWPFRun imageRun = image.createRun();
//		    		    imageRun.setTextPosition(0);
//		    		    Path imagePath = Paths.get("/Users/marcopagnanelli/Downloads/imageACC/"+(i + 1) + ".png");
//		    	        imageRun.addPicture(Files.newInputStream(imagePath), XWPFDocument.PICTURE_TYPE_PNG, imagePath.getFileName().toString(), Units.toEMU(w), Units.toEMU(h));
//
//		    		
//		   
//            }
	        
	        

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
		    String imgFile="./WebContent/images/header.jpg";
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
		    ctppr.addNewRPr();

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
		    
		    
		    

		    
		    
	      
	      
		  String nomePack=intervento.getNomePack();
	      //Write the Document in file system
	      FileOutputStream out = new FileOutputStream( new File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+".docx"));
	      document.write(out);
	      out.close();
	      document.close();
	      System.out.println("createdocument.docx written successully");
	}
	
	
	public static void main(String[] args) throws HibernateException, Exception {
		   
		 
		 InterventoCampionamentoDTO intervento = GestioneCampionamentoBO.getIntervento("21");
	

			
			LinkedHashMap<String, Object> componenti = new LinkedHashMap<>();

			componenti.put("text", "<p>aaaaa</p><p>aaaaa</p><p>cccc</p><p>dddd</p><p>aaaaa</p><p>wwww</p><p>aaaaa</p><p>aaaaa</p>");
			componenti.put("scheda", null);
			
			
			new CreateRelazioneCampionamentoDoc(componenti,intervento,null,null);
		 
	
	   }
}
