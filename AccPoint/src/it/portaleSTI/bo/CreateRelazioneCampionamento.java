package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.log4j.chainsaw.Main;
import org.ghost4j.document.PDFDocument;
import org.ghost4j.renderer.SimpleRenderer;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.id.CompositeNestedGeneratedValueGenerator.GenerationContextLocator;

import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.TestReport2;
import it.portaleSTI.Util.Utility;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.component.DRImage;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.ComponentBuilder;
import net.sf.dynamicreports.report.builder.component.DimensionComponentBuilder;
import net.sf.dynamicreports.report.builder.component.ImageBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.ImageScale;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;

public class CreateRelazioneCampionamento {
	public CreateRelazioneCampionamento(LinkedHashMap<String, Object> componenti, InterventoCampionamentoDTO intervento, Session session, ServletContext context) throws Exception {
		try {
			
			build(componenti,context,intervento);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(LinkedHashMap<String, Object> componenti,ServletContext context, InterventoCampionamentoDTO intervento) throws Exception {
		
		InputStream is = CreateSchedaCampionamento.class.getResourceAsStream("relazioneCampionamento.jrxml");

		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 

		try {

			Object imageHeader;
		if(context == null) {	
			imageHeader = new File("./WebContent/images/header.jpg");			
		}else {
			 imageHeader = context.getResourceAsStream("images/header.jpg");
		}
 			report.setTemplate(Templates.reportTemplate); 
 			report.setTemplateDesign(is);
 			report.addParameter("logo",imageHeader);
			report.setColumnStyle(textStyle); //AGG
			
			
			Iterator<Entry<String, Object>> iter = componenti.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry<java.lang.String, java.lang.Object> entry = (Map.Entry<java.lang.String, java.lang.Object>) iter
						.next();
				
				  String key = entry.getKey();
				  
				  if(key.equals("html")) {
					    String value = (String) entry.getValue();
					    report.addDetail(cmp.text(value));

				  }
				  if(key.equals("pdf")) {
					  String value = (String) entry.getValue();
					  PDFDocument document = new PDFDocument();
					    File d = new File(value);
					    document.load(d);
					    
					    SimpleRenderer renderer = new SimpleRenderer();
					    

					    // set resolution (in DPI)
					    renderer.setResolution(300);
					    List<Image> images = renderer.render(document);
					    for (int i = 0; i < images.size(); i++) {
					    	
					    			Image imgRotate = Utility.rotateImage((BufferedImage)images.get(i), -Math.PI/2, true);
					    	
					    		
					    			SubreportBuilder subreport = cmp.subreport(createSubreport(imgRotate));
					    		report.addDetail(subreport);
					    		
					   
			            }
				  }
				  if(key.equals("imgurl")) {
					  String value = (String) entry.getValue();
					  URL imageURL = new URL(value);
					    // Case 1
					  RenderedImage img = ImageIO.read(imageURL);
					  Image imgRotate = Utility.rotateImage((BufferedImage)img, -Math.PI/2, true);

		    			 SubreportBuilder subreport = cmp.subreport(createSubreport(imgRotate));
		    			 report.addDetail(subreport);
				  }
				  if(key.equals("img")) {
					  Image value = (Image) entry.getValue();
					  Image imgRotate = Utility.rotateImage((BufferedImage)value, -Math.PI/2, true);

		    			 SubreportBuilder subreport = cmp.subreport(createSubreport(imgRotate));
		    			 report.addDetail(subreport);
				  }
				  if(key.equals("scheda")) {
					  PDFDocument document = new PDFDocument();
					    File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//"+intervento.getNomePack()+".pdf");
					    document.load(d);
					    
					    SimpleRenderer renderer = new SimpleRenderer();
					    

					    // set resolution (in DPI)
					    renderer.setResolution(300);
					    List<Image> images = renderer.render(document);
					    for (int i = 0; i < images.size(); i++) {
					    	
					    			Image imgRotate = Utility.rotateImage((BufferedImage)images.get(i), -Math.PI/2, true);
					    	
					    		
					    			SubreportBuilder subreport = cmp.subreport(createSubreport(imgRotate));
					    		report.addDetail(subreport);
					    		
					   
			            }
				  }
				
			}
			   

		
			
		



			  report.setDataSource(new JREmptyDataSource());
			  
			  String nomePack=intervento.getNomePack();
			  //java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+".docx");
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+".docx");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toDocx(fos);
			  
			//  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}
	

	private JasperReportBuilder createSubreport(Image imgRotate) {

		JasperReportBuilder report = DynamicReports.report();
		
		try {
			report.setTemplate(Templates.reportTemplate);
 
			report.setDetailSplitType(SplitType.IMMEDIATE);

			ImageBuilder image = cmp.image(imgRotate).setFixedHeight(700);
			report.addDetail(image);

			
		
			
			  report.setDataSource(new JREmptyDataSource());
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	
	}
	public static void main(String[] args) throws HibernateException, Exception {
		
		InterventoCampionamentoDTO intervento = new InterventoCampionamentoDTO();
		intervento.setNomePack("CAMP413205102017103259");
		intervento.setId(20);
		new CreateRelazioneCampionamento(null,intervento,null,null);
	}


}
