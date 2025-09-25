package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PaaSegnalazioneDTO;
import it.portaleSTI.DTO.RapportoInterventoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
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
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateRapportoIntervento {

	public CreateRapportoIntervento(ArrayList<MisuraDTO> listaMisure, RapportoInterventoDTO rapporto, InterventoDTO intervento) throws DRException, JRException {
		build(listaMisure, rapporto, intervento);
	}
	
	public void build(ArrayList<MisuraDTO> listaMisure, RapportoInterventoDTO rapporto, InterventoDTO intervento) throws DRException, JRException {

			
			InputStream is  = PivotTemplate.class.getResourceAsStream("TemplateRapportoIntervento.jrxml");
			
			JasperReportBuilder report = DynamicReports.report();
			
			report.setTemplateDesign(is);
			
			report.setTemplate(Templates.reportTemplate);

			report.setDataSource(new JREmptyDataSource());		
			report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
			
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti.png");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			
				}
			
			report.addParameter("commessa", intervento.getIdCommessa());
			report.addParameter("cliente", intervento.getNome_cliente());
			report.addParameter("indirizzo", intervento.getNome_sede());
			report.addParameter("tecnico", intervento.getUser().getNominativo());
			
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			String data = df.format(rapporto.getData_inizio())+"";
			
			if(rapporto.getData_fine()!=null) {
				data += " - "+df.format(rapporto.getData_fine());
			}
			
			report.addParameter("data", data);
			String ora_inizio = "";
			if(rapporto.getOra_inizio()!=null) {
				ora_inizio = rapporto.getOra_inizio();
			}
			String ora_fine = "";
			if(rapporto.getOra_fine()!=null) {
				ora_fine = rapporto.getOra_fine();
			}
			
			report.addParameter("ora_inizio", ora_inizio);
			report.addParameter("ora_fine", ora_fine);
			report.addParameter("durata", "");
			report.addParameter("tipologia_intervento", "");
			
			String note = "";
			if(rapporto.getNote()!=null) {
				note = " "+rapporto.getNote();
			}
			report.addParameter("note", note);
			report.addParameter("modulo", "MOD-PGI016-11");
			report.addParameter("revisione", "Rev. A del 14/03/2023");
			
			File firma = new File(Costanti.PATH_FOLDER + "FileFirme\\"+intervento.getUser().getFile_firma());
			if(imageHeader!=null) {
				report.addParameter("firma_operatore",firma);
			
				}
			
			
			
			SubreportBuilder subreport; 
			subreport = cmp.subreport(getTableReportIntervento(listaMisure));
			
			JasperReportBuilder report_table = DynamicReports.report();
			
			report_table.setTemplate(Templates.reportTemplate);
			
			report_table.setDataSource(new JREmptyDataSource());
			
			report_table.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
			
			report_table.addDetail(subreport);
			
			
			String path_folder = Costanti.PATH_FOLDER+"\\RapportoIntervento\\"+intervento.getId()+"\\";
			File folder = new File(path_folder);
			
			if(folder.exists() == false) {
				folder.mkdirs();
			}
			
			String path = path_folder+"RAPPORTO_INTERVENTO_"+intervento.getId()+".pdf";
		
			
			List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
			JasperPrint jasperPrint1 = report.toJasperPrint();
			jasperPrintList.add(jasperPrint1);
			JasperPrint jasperPrint2 = report_table.toJasperPrint();
			jasperPrintList.add(jasperPrint2);
			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
			SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
			configuration.setCreatingBatchModeBookmarks(true); 
			exporter.setConfiguration(configuration);
			exporter.exportReport();
			

			System.out.println("PDF generato con successo!");
		
		
	}
		
		
		private static JasperReportBuilder getTableReportIntervento(ArrayList<MisuraDTO> listaMisure) {
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
			 		        Columns.column("ID STRUMENTO", "id_strumento", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
			 		    );
				report.addColumn(
		 		        Columns.column("TIPO STRUMENTO", "tipo_strumento", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
				report.addColumn(
			 		        Columns.column("MATRICOLA", "matricola", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
			 		    );
				report.addColumn(
		 		        Columns.column("CODICE INTERNO", "codice_interno", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			
				report.addColumn(
		 		        Columns.column("COSTRUTTORE", "costruttore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
				
				report.addColumn(
		 		        Columns.column("MODELLO", "modello", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
				
				
				report.getReport().getTitleBand().setPrintWhenExpression(Expressions.printNotInFirstPage());
				
				
				  
				  String[] listaCodici = null;
					
					listaCodici = new String[6];
					
					listaCodici[0]="id_strumento";
					listaCodici[1]="tipo_strumento";
					listaCodici[2]="matricola";
					listaCodici[3]="codice_interno";
					listaCodici[4]="costruttore";
					listaCodici[5]="modello";
					
					
					  DRDataSource ds = new DRDataSource(listaCodici);
				for (MisuraDTO m : listaMisure) {
					if(m.getObsoleto().equals("N")) {
						
					
					StrumentoDTO s = m.getStrumento();
					
					
						ArrayList<String> arrayPs = new ArrayList<String>();
						arrayPs.add(s.get__id()+"");
						arrayPs.add(s.getTipo_strumento().getNome());
						arrayPs.add(s.getMatricola());
						arrayPs.add(s.getCodice_interno());
						arrayPs.add(s.getCostruttore());
						arrayPs.add(s.getModello());
						
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
