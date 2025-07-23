package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.PaaSegnalazioneDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.expression.Expressions;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.Markup;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateRapportoSegnalazioniVeicoli {
	
	public CreateRapportoSegnalazioniVeicoli(ArrayList<PaaSegnalazioneDTO> lista_segnalazioni) throws Exception {
		build(lista_segnalazioni);
	}
	
	public static void build(ArrayList<PaaSegnalazioneDTO> lista_segnalazioni) throws Exception 
	{
		
		if(lista_segnalazioni.size()>0) {
			String veicolo = lista_segnalazioni.get(0).getPrenotazione().getVeicolo().getModello()+" "+lista_segnalazioni.get(0).getPrenotazione().getVeicolo().getTarga();
			
			InputStream is  = PivotTemplate.class.getResourceAsStream("TemplateRapportoDiSegnalazione.jrxml");
			
			JasperReportBuilder report = DynamicReports.report();
			
			report.setTemplateDesign(is);
			
			report.setTemplate(Templates.reportTemplate);

			report.setDataSource(new JREmptyDataSource());		
			report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
			
			report.addParameter("veicolo", veicolo);
			
			SubreportBuilder subreport; 
			subreport = cmp.subreport(getTableReportSegnalazioni(lista_segnalazioni));
			
			report.addDetail(subreport);
			
			
			String path_folder = Costanti.PATH_FOLDER+"\\ParcoAuto\\"+lista_segnalazioni.get(0).getPrenotazione().getVeicolo().getId()+"\\RapportoSegnalazione\\";
			File folder = new File(path_folder);
			
			if(folder.exists() == false) {
				folder.mkdirs();
			}
			
			String path = path_folder+"RAPPORTO"+lista_segnalazioni.get(0).getPrenotazione().getVeicolo().getTarga()+".pdf";
		
			
			List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
			JasperPrint jasperPrint1 = report.toJasperPrint();
			jasperPrintList.add(jasperPrint1);
			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
			SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
			configuration.setCreatingBatchModeBookmarks(true); 
			exporter.setConfiguration(configuration);
			exporter.exportReport();
			

			System.out.println("PDF generato con successo!");
			
			
		}
		
	}

	private static JasperReportBuilder getTableReportSegnalazioni(ArrayList<PaaSegnalazioneDTO> lista_segnalazioni) {
		JasperReportBuilder report = DynamicReports.report();

		try {			
			
			StyleBuilder styleTitle = stl.style().bold().setPadding(2).setFontName("Trebuchet MS").setFontSize(8);
			StyleBuilder styleTitle2 = stl.style(stl.style().setPadding(2).setFontName("Trebuchet MS").setFontSize(8)).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setBold(false).setBorder(stl.penThin())
                    .setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
                    .setBackgroundColor(Color.LIGHT_GRAY)
                    .bold()
                 .setMarkup(Markup.HTML);
			
			report.setColumnStyle((styleTitle).setBorder(stl.pen1Point()).setFontSize(9));
			
			report.addColumn(
		 		        Columns.column("TIPO SEGNALAZIONE", "tipo", type.stringType()).setFixedWidth(150).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			report.addColumn(
		 		        Columns.column("NOTE", "note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			
			report.getReport().getTitleBand().setPrintWhenExpression(Expressions.printNotInFirstPage());
			
			
			  
			  String[] listaCodici = null;
				
				listaCodici = new String[3];
				
				listaCodici[0]="tipo";
				listaCodici[1]="note";
				
				  DRDataSource ds = new DRDataSource(listaCodici);
			for (PaaSegnalazioneDTO s : lista_segnalazioni) {
				if(s.getStato()==0) {
					ArrayList<String> arrayPs = new ArrayList<String>();
					arrayPs.add(s.getTipo().getDescrizione());
					if(s.getNote()!=null) {
						arrayPs.add(s.getNote());
					}else {
						arrayPs.add("");
					}
					
					ds.add(arrayPs.toArray());
				}
				
			}
			

			
	 		report.setDataSource(ds);
		
	 		report.setColumnTitleStyle(styleTitle2.setFontName("SansSerif").setBold(false).setFontSize(8).setForegroundColor(Color.black).setBorder(stl.pen1Point()));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}

}
