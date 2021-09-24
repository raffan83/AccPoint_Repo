package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.field;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;
import ar.com.fdvs.dj.domain.entities.columns.PropertyColumn;
import it.portaleSTI.DAO.GestioneDpiDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;
import net.sf.jasperreports.view.JasperViewer;

public class CreateSchedaDPI {
	
	
	public CreateSchedaDPI(int tipo_scheda, DocumDipendenteFornDTO lavoratore,Session session) throws Exception {
		try {
		
			build(tipo_scheda, lavoratore, session);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(int tipo_scheda, DocumDipendenteFornDTO lavoratore, Session session) throws Exception {
		
		InputStream is = null;
		
		if(tipo_scheda == 0) {
			is = PivotTemplate.class.getResourceAsStream("SchedaConsegnaDPI.jrxml"); 
		}else if(tipo_scheda == 1) {
			is = PivotTemplate.class.getResourceAsStream("SchedaRiconsegnaDPI.jrxml");
		}else if(tipo_scheda ==2) {
			is = PivotTemplate.class.getResourceAsStream("SchedaDPICollettivi.jrxml");
		}
		
		ArrayList<ConsegnaDpiDTO> lista = GestioneDpiDAO.getListaConsegnaRiconsegnaDPI(lavoratore, tipo_scheda, session);
				
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {

 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			if(tipo_scheda!=2) {
				report.addParameter("sottoscritto",lavoratore.getNome().toUpperCase() +" " +lavoratore.getCognome().toUpperCase());
				report.addParameter("societa", lavoratore.getFornitore().getRagione_sociale());
			}
				
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = null;
			
			if(tipo_scheda!=2) {
				subreport = cmp.subreport(getTableReport(lista, tipo_scheda));
			}else {
				subreport = cmp.subreport(getTableReportCollettivi(lista, tipo_scheda));
			}
			
			
			report.addDetail(subreport);
		
			report.setDataSource(new JREmptyDataSource());
			
			String folder = Costanti.PATH_FOLDER + "\\GestioneDPI\\";
			String path = "";
			if(tipo_scheda == 0) {
				path = folder + "SchedaConsegnaDPI.pdf"; 
			}else if(tipo_scheda == 1) {
				path = folder + "SchedaRiconsegnaDPI.pdf";
			}else if(tipo_scheda ==2) {
				path = folder + "SchedaDPICollettivi.pdf";
			}
			
			java.io.File fileFolder = new java.io.File(folder);
			
			if(!fileFolder.exists()) {
				fileFolder.mkdirs();
			}
			
			 // java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNome_pack()+"//SchedaDiConsegna.pdf");
			 java.io.File file = new java.io.File(path);
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			  fos.flush();
			  fos.close();
			 //report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<ConsegnaDpiDTO> lista, int tipo_scheda) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

			report.setColumnStyle(textStyle); //AGG
			report.addColumn(col.column("ID", "id", type.stringType()));
			report.addColumn(col.column("DPI", "dpi", type.stringType()));
	 		report.addColumn(col.column("MODELLO", "modello", type.stringType()));
	 		report.addColumn(col.column("CONFORMITÀ", "conformita", type.stringType()));
	 		 		
	 		if(tipo_scheda == 0) {
	 			report.addColumn(col.column("DATA ACCETTAZIONE", "data_accettazione", type.stringType()));	
	 			report.addColumn(col.column("SCADENZA DPI", "scadenza", type.stringType()));
	 		}else {
	 			report.addColumn(col.column("DATA RICONSEGNA", "data_accettazione", type.stringType()));
	 			report.addColumn(col.column("MOTIVAZIONE", "scadenza", type.stringType()));
	 		}
	 		
	 			 		
	 		
//	 		report.addColumn(col.column("Note", "note", type.stringType()));

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(lista, tipo_scheda));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<ConsegnaDpiDTO> lista, int tipo_scheda)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		
		String[] listaCodici = new String[7];
		
		listaCodici[0]="id";
		listaCodici[1]="dpi";
		listaCodici[2]="modello";
		listaCodici[3]="conformita";		
		listaCodici[4]="data_accettazione";
		listaCodici[5]="scadenza";

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
		int i=1;
			for (ConsegnaDpiDTO consegna : lista) {
						
				if(tipo_scheda == 0 && consegna.getRestituzione()== null) {
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					arrayPs.add(consegna.getId()+"");
					arrayPs.add(consegna.getDpi().getTipo().getDescrizione());
					arrayPs.add(consegna.getDpi().getModello());
					arrayPs.add(consegna.getDpi().getConformita());
					
					if(consegna.getData_accettazione()!=null) {
						arrayPs.add(df.format(consegna.getData_accettazione()));	
					}else {
						arrayPs.add("");
					}			
					if(consegna.getDpi().getData_scadenza()!=null) {
						arrayPs.add(df.format(consegna.getDpi().getData_scadenza()));
					}else {
						arrayPs.add("");
					}
					
					
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}else if(tipo_scheda == 1){
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					arrayPs.add(consegna.getId()+"");
					arrayPs.add(consegna.getDpi().getTipo().getDescrizione());
					arrayPs.add(consegna.getDpi().getModello());
					arrayPs.add(consegna.getDpi().getConformita());
					
				
					if(consegna.getData_accettazione()!=null) {
						arrayPs.add(df.format(consegna.getData_accettazione()));	
					}else {
						arrayPs.add("");
					}

					arrayPs.add(consegna.getMotivazione());
									
					
					
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
				
		         i++;
			}
 		    return dataSource;
 	}
	
	
	public JasperReportBuilder getTableReportCollettivi(ArrayList<ConsegnaDpiDTO> lista, int tipo_scheda) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

				report.setTemplate(Templates.reportTemplate);
				report.setColumnStyle(textStyle); //AGG				
			
				report.addColumn(col.column("ID DPI", "id", type.stringType()).setFixedWidth(30));
				report.addColumn(col.column("Data", "data_accettazione", type.stringType()).setFixedWidth(75));
	 	 		report.addColumn(col.column("Nominativo", "nominativo", type.stringType()).setFixedWidth(190));
		 		report.addColumn(col.column("Codice commessa", "commessa", type.stringType()).setFixedWidth(65));
		 		report.addColumn(col.column("Data", "data_riconsegna", type.stringType()).setFixedWidth(75));
		 		report.addColumn(col.column("note", "note", type.stringType()).setFixedWidth(115));
				report.setDetailSplitType(SplitType.PREVENT);
				
				report.setDataSource(createDataSourceCollettivi(lista, tipo_scheda));

				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	
	
	private JRDataSource createDataSourceCollettivi(ArrayList<ConsegnaDpiDTO> lista, int tipo_scheda)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		
		String[] listaCodici = new String[6];
		
		listaCodici[0]="id";
		listaCodici[1]="data_accettazione";
		listaCodici[2]="nominativo";
		listaCodici[3]="commessa";
		listaCodici[4]="data_riconsegna";
		listaCodici[5]="note";

		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
	
			for (ConsegnaDpiDTO consegna : lista) {
							
				if(consegna.getIs_restituzione()==0) {
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					
					arrayPs.add(consegna.getDpi().getTipo().getId()+"");
					if(consegna.getData_accettazione()!=null) {
						arrayPs.add(df.format(consegna.getData_accettazione()));	
					}else {
						arrayPs.add("");
					}
					
					arrayPs.add(consegna.getLavoratore().getCognome()+" "+consegna.getLavoratore().getNome());
					if(consegna.getCommessa()!=null) {
						arrayPs.add(consegna.getCommessa());
					}else {
						arrayPs.add("");	
					}
		
					if(consegna.getRestituzione()!=null && consegna.getRestituzione().getData_consegna()!=null) {
						arrayPs.add(df.format(consegna.getRestituzione().getData_consegna()));	
					}else {
						arrayPs.add("");	
					}
									
					arrayPs.add("");
					
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
				
			}
 		    return dataSource;
 	}

	
	public static void main(String[] args) throws HibernateException, Exception {
		
		
	}
	

}
