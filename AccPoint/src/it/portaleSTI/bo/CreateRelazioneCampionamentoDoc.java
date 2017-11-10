package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.poi.util.Units;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
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
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTText;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STFldCharType;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STJc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTabJc;

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
		
		 
	      //Blank Document
	      XWPFDocument document = new XWPFDocument(); 
			
	      XWPFParagraph title = document.createParagraph();
	        title.setAlignment(ParagraphAlignment.CENTER);
	        XWPFRun titleRun = title.createRun();
	        titleRun.setText("Build Your REST API with Spring");
	        titleRun.setColor("009933");
	        titleRun.setBold(true);
	        titleRun.setFontFamily("Courier");
	        titleRun.setFontSize(20);

	        XWPFParagraph subTitle = document.createParagraph();
	        subTitle.setAlignment(ParagraphAlignment.CENTER);
	        XWPFRun subTitleRun = subTitle.createRun();
	        subTitleRun.setText("from HTTP fundamentals to API Mastery");
	        subTitleRun.setColor("00CC44");
	        subTitleRun.setFontFamily("Courier");
	        subTitleRun.setFontSize(16);
	        subTitleRun.setTextPosition(20);
	        subTitleRun.setUnderline(UnderlinePatterns.DOT_DOT_DASH);

	        
	        XWPFParagraph content1 = document.createParagraph();
	        content1.setAlignment(ParagraphAlignment.CENTER);
	        XWPFRun content1Run = content1.createRun();
	        content1Run.setText("from HTTP fundamentals to API Mastery");
	        content1Run.setColor("00CC44");
	        content1Run.setFontFamily("Courier");
	        content1Run.setFontSize(16);
	        content1Run.setTextPosition(20);
	        content1Run.setUnderline(UnderlinePatterns.DOT_DOT_DASH);
	        content1.setPageBreak(true);
	        
	        XWPFParagraph content2 = document.createParagraph();
	        content2.setAlignment(ParagraphAlignment.CENTER);
	        XWPFRun content2Run = content2.createRun();
	        content2Run.setText("from HTTP fundamentals to API Mastery");
	        content2Run.setColor("00CC44");
	        content2Run.setFontFamily("Courier");
	        content2Run.setFontSize(16);
	        content2Run.setTextPosition(20);
	        content2Run.setUnderline(UnderlinePatterns.DOT_DOT_DASH);
	      
			  
	        PDFDocument documentx = new PDFDocument();
	        File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//"+intervento.getNomePack()+".pdf");
		    documentx.load(d);
	        SimpleRenderer renderer = new SimpleRenderer();
		    
	        XWPFParagraph image = document.createParagraph();
		    image.setAlignment(ParagraphAlignment.CENTER);
		    // set resolution (in DPI)
		    //renderer.setResolution(300);
		    List<Image> images = renderer.render(documentx);
		    for (int i = 0; i < images.size(); i++) {
		    	
		    	
		    			BufferedImage imgRendered =	(BufferedImage) images.get(i);
		    	
		    			Image imgRotate = Utility.rotateImage(imgRendered, -Math.PI/2, true);
		    			 
		    			double w = ((BufferedImage)imgRotate).getWidth() * 0.75;
		    			double h = ((BufferedImage)imgRotate).getHeight() * w / ((BufferedImage)imgRotate).getWidth() ;
		    			ImageIO.write((RenderedImage) imgRotate, "png", new File("/Users/marcopagnanelli/Downloads/imageACC/"+(i + 1) + ".png"));


		    			
		    		    XWPFRun imageRun = image.createRun();
		    		    imageRun.setTextPosition(0);
		    		    Path imagePath = Paths.get("/Users/marcopagnanelli/Downloads/imageACC/"+(i + 1) + ".png");
		    	        imageRun.addPicture(Files.newInputStream(imagePath), XWPFDocument.PICTURE_TYPE_PNG, imagePath.getFileName().toString(), Units.toEMU(w), Units.toEMU(h));

		    		
		   
            }
	        
	        


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
		    
		    
		    
//		    
//		    
//		    
//		    // create footer start
//		    XWPFFooter footer = headerFooterPolicy.createFooter(XWPFHeaderFooterPolicy.DEFAULT);
//
//		    paragraph = footer.createParagraph();
//		    paragraph.setAlignment(ParagraphAlignment.CENTER);
//
//		    run = paragraph.createRun();  
//		    run.setText("SLR0067_01_17_RTL_0.doc");
//		    run.addTab();
//		    run = paragraph.createRun(); 
//		    
//
//		 // add style (s.th.)
//		    CTPPr ctppr = ctpFooter.addNewPPr();
//		    CTString pst = ctppr.addNewPStyle();
//		    pst.setVal("style21");
//		    CTJc ctjc = ctppr.addNewJc();
//		    ctjc.setVal(STJc.RIGHT);
//		    ctppr.addNewRPr();
//
//		    // Add in word "Page "   
//		    CTR ctr = ctpFooter.addNewR();
//		    CTText t = ctr.addNewT();
//		    t.setStringValue("Page ");
//		    t.setSpace(Space.PRESERVE);
//
//		    // add everything from the footerXXX.xml you need
//		    ctr = ctpFooter.addNewR();
//		    ctr.addNewRPr();
//		    CTFldChar fch = ctr.addNewFldChar();
//		    fch.setFldCharType(STFldCharType.BEGIN);
//
//		    ctr = ctpFooter.addNewR();
//		    ctr.addNewInstrText().setStringValue(" PAGE ");
//
//		    ctpFooter.addNewR().addNewFldChar().setFldCharType(STFldCharType.SEPARATE);
//
//		    ctpFooter.addNewR().addNewT().setStringValue("1");
//
//		    ctpFooter.addNewR().addNewFldChar().setFldCharType(STFldCharType.END);
		    
		    
		    
		    
		    
	      
	      
		  String nomePack=intervento.getNomePack();
	      //Write the Document in file system
	      FileOutputStream out = new FileOutputStream( new File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+".docx"));
	      document.write(out);
	      out.close();
	      document.close();
	      System.out.println("createdocument.docx written successully");
	}
	public static void main(String[] args) throws HibernateException, Exception {
		   
		 
		 InterventoCampionamentoDTO intervento = new InterventoCampionamentoDTO();
			intervento.setNomePack("CAMP413210102017042213");
			intervento.setId(20);
			
			LinkedHashMap<String, Object> componenti = new LinkedHashMap<>();

			componenti.put("text", "<p>aaaaa</p><p>aaaaa</p><p>cccc</p><p>dddd</p><p>aaaaa</p><p>wwww</p><p>aaaaa</p><p>aaaaa</p>");
			componenti.put("scheda", null);
			
			
			new CreateRelazioneCampionamentoDoc(componenti,intervento,null,null);
		 
	
	   }
}
