package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
import java.io.File;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMRapportoDTO;
import it.portaleSTI.DTO.AmScScadenzarioDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.action.ContextListener;
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



public class CreateRapportoScadenzarioAM {
	
	public CreateRapportoScadenzarioAM(ArrayList<AmScScadenzarioDTO> lista_scadenze, Session session ) throws Exception {
		build(lista_scadenze, session);
	}
	
	public static void build(ArrayList<AmScScadenzarioDTO> lista_scadenze, Session session ) throws Exception 
	{
	
		InputStream is  = PivotTemplate.class.getResourceAsStream("ReportScadenzarioAM.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		report.setTemplateDesign(is);
		
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"\\immagine_am.png");
		report.addParameter("immagine_am", imageHeader);
		
		report.addParameter("descrizione", lista_scadenze.get(0).getAttrezzatura().getDescrizione());
	
			
		if(lista_scadenze.get(0).getAttrezzatura().getNome_cliente()!=null) {
	
			if(lista_scadenze.get(0).getAttrezzatura().getIdSede()!=0) {
				report.addParameter("cliente", lista_scadenze.get(0).getAttrezzatura().getNome_cliente() +" - "+ lista_scadenze.get(0).getAttrezzatura().getNome_sede());	
			}else {
				String indirizzo="";
				String cap="";
				String citta="";
				String provincia="";
				ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(lista_scadenze.get(0).getAttrezzatura().getIdCliente()+"");
						if( cliente.getIndirizzo()!=null) {
							indirizzo = cliente.getIndirizzo();				
							}
							if(cliente.getCap()!=null) {
								cap = cliente.getCap();
							}
							if(cliente.getCitta()!=null) {
								citta = cliente.getCitta();
							}
							if(cliente.getProvincia()!=null) {
								provincia = cliente.getProvincia();
							}
							
							report.addParameter("cliente", lista_scadenze.get(0).getAttrezzatura().getNome_cliente() +" - "+indirizzo + ", " + cap + ", "+citta +" ("+ provincia+")");
			}
			
		}else {
			report.addParameter("cliente","");
		}
		
		report.setStartPageNumber(1);
		report.addPageFooter(cmp.pageXofY());
		 SubreportBuilder subreport = cmp.subreport(getTableReport(lista_scadenze));
		 
		 report.addDetail(subreport);
		 
		 List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
			JasperPrint jasperPrint1 = report.toJasperPrint();
			jasperPrintList.add(jasperPrint1);
			
			String path_folder = Costanti.PATH_FOLDER+"\\AMGestioneSistemi\\"+lista_scadenze.get(0).getAttrezzatura().getId()+"\\Report\\";
			File folder = new File(path_folder);
			
			if(folder.exists() == false) {
				folder.mkdirs();
			}
			
			Timestamp ts = new Timestamp(System.currentTimeMillis());

			String result = new SimpleDateFormat("ddMMHHhhmmss")
			                    .format(ts);
			
			String path = path_folder+"Report_"+lista_scadenze.get(0).getAttrezzatura().getId()+".pdf";
		
					
			
			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
			SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
			configuration.setCreatingBatchModeBookmarks(true); 
			exporter.setConfiguration(configuration);
			exporter.exportReport();
			
			System.out.println("fine");
		 
	
	}
	
	
	private static JasperReportBuilder getTableReport(ArrayList<AmScScadenzarioDTO> lista_scadenze) {
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
		 		        Columns.column("ID", "id", type.stringType()).setFixedWidth(30).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			
			report.addColumn(
	 		        Columns.column("Tipo attività", "tipo", type.stringType()).setFixedWidth(60).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );

			report.addColumn(
	 		        Columns.column("Data attivita", "data_attivita", type.stringType()).setFixedWidth(60).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
	
			report.addColumn(
	 		        Columns.column("Frequenza (Mesi)", "frequenza", type.stringType()).setFixedWidth(50).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
		
			report.addColumn(
	 		        Columns.column("Data prossima attività", "data_prossima", type.stringType()).setFixedWidth(60).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
			report.addColumn(
	 		        Columns.column("Esito", "esito", type.stringType()).setFixedWidth(60).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
			
			
			report.addColumn(
	 		        Columns.column("Note", "note", type.stringType()).setFixedWidth(80).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
			
			report.addColumn(
	 		        Columns.column("Descrizione attivita", "descrizione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
			report.addColumn(
	 		        Columns.column("Eseguita da", "eseguita_da", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(10).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
	 		    );
	
			
			
			report.getReport().getTitleBand().setPrintWhenExpression(Expressions.printNotInFirstPage());
			
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			  
			  String[] listaCodici = null;
				
				listaCodici = new String[9];
				
				listaCodici[0]="id";
				listaCodici[1]="tipo";
				listaCodici[2]="data_attivita";				
				listaCodici[3]="frequenza";
				listaCodici[4]="data_prossima";
				listaCodici[5]="esito";
				listaCodici[6]="note";
				listaCodici[7]="descrizione";
				listaCodici[8]="eseguita_da";
				
				  DRDataSource ds = new DRDataSource(listaCodici);
			for (AmScScadenzarioDTO s : lista_scadenze) {
		
					ArrayList<String> arrayPs = new ArrayList<String>();
					arrayPs.add(s.getId()+"");
					if(s.getTipo() == 0) {
						arrayPs.add("ORDINARIA");
					}else {
						arrayPs.add("STRAORDINARIA");
					}
					
					arrayPs.add(df.format(s.getDataAttivita()));
					
					if(s.getFrequenza()!=null) {
						arrayPs.add(s.getFrequenza()+"");
					}else {
						arrayPs.add("");
					}
					if(s.getDataProssimaAttivita()!=null) {
						arrayPs.add(df.format(s.getDataProssimaAttivita()));
					}else {
						arrayPs.add("");
					}
					if(s.getEsito().equals("P")) {
						arrayPs.add("POSITIVO");
					}else {
						arrayPs.add("NEGATIVO");
					}
					if(s.getNote()!=null) {
						arrayPs.add(s.getNote());
					}else {
						arrayPs.add("");
					}
					
					arrayPs.add(s.getAttivita().getDescrizione());
					if(s.getEseguito_da()!=null) {
						arrayPs.add(s.getEseguito_da());
					}else{
						arrayPs.add("");
					}
					ds.add(arrayPs.toArray());
				
				
			}
			

			
	 		report.setDataSource(ds);
		
	 		report.setColumnTitleStyle(styleTitle2.setFontName("SansSerif").setBold(false).setFontSize(8).setForegroundColor(Color.black).setBorder(stl.pen1Point()));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	public static void main(String[] args) throws HibernateException, Exception {
		new ContextListener().configCostantApplication();
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		ArrayList<AmScScadenzarioDTO> lista_scadenze = GestioneAM_ScadenzarioBO.getListaScadenzeAttrezzatura(3, 0, 2025, true, session);
		
		CreateRapportoScadenzarioAM cert = new CreateRapportoScadenzarioAM(lista_scadenze, session);

		session.getTransaction().commit();
		session.close();
	}
	

	public CreateRapportoScadenzarioAM() {
		// TODO Auto-generated constructor stub
	}

}
