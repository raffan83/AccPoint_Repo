package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import TemplateReportLAT.PivotTemplateLAT;
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateReportAccredia {
	
public CreateReportAccredia(ArrayList<MisuraDTO> lista_misure,String dateFrom, String dateTo, Session session) throws Exception {
		
		build(lista_misure, dateFrom, dateTo, session);
	}


private void build(ArrayList<MisuraDTO> lista_misure, String dateFrom, String dateTo, Session session) throws Exception {
	
	InputStream is = PivotTemplateLAT.class.getResourceAsStream("ReportAccredia.jrxml");	
	
	JasperReportBuilder report = DynamicReports.report();
	
	report.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia.png"));	
	//report.addParameter("immagine_ilac",PivotTemplateLAT_Image.class.getResourceAsStream("ilac.jpg"));	
	
	report.setTemplateDesign(is);
	report.setTemplate(Templates.reportTemplate);
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	report.setDataSource(new JREmptyDataSource());		
	report.setPageFormat(PageType.A4, PageOrientation.LANDSCAPE);
	report.addParameter("periodo", "dal "+dateFrom+" al "+dateTo);
	
	SubreportBuilder subreport = cmp.subreport(getTableReport(lista_misure));	
	
	report.addDetail(subreport);
	report.setDetailSplitType(SplitType.IMMEDIATE);
	
	List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
	JasperPrint jasperPrint = report.toJasperPrint();
	jasperPrintList.add(jasperPrint);
	
	
	//String path ="C:\\Users\\antonio.dicivita\\Desktop\\ReportAccredia.pdf";
	String folder = Costanti.PATH_FOLDER+"\\ReportAccredia\\";
	File f = new File(folder);
	if(!f.exists()) {
		f.mkdirs();
	}
	


	SimpleDateFormat output = new SimpleDateFormat("ddMMyyyy");
	Date dateValueFrom = df.parse(dateFrom);
	Date dateValueTo = df.parse(dateTo);
	String path = Costanti.PATH_FOLDER+"\\ReportAccredia\\"+output.format(dateValueFrom)+output.format(dateValueTo)+".pdf";
	
	JRPdfExporter exporter = new JRPdfExporter();
	exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
	exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
	SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
	configuration.setCreatingBatchModeBookmarks(true); 
	exporter.setConfiguration(configuration);
	exporter.exportReport();
}


private JasperReportBuilder getTableReport(ArrayList<MisuraDTO> lista_misure) throws Exception {
	
	JasperReportBuilder report = DynamicReports.report();

	
		report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
		report.addColumn(col.column("Certificato","certificato", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(100));
 		report.addColumn(col.column("Data Emisssione","data_emissione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Oggetto","oggetto", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(100));
 		report.addColumn(col.column("Costruttore","costruttore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Modello","modello", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Matricola","matricola", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Destinatario","destinatario", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(100));
 		report.addColumn(col.column("Provincia","provincia", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Codice","codice", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Luogo","luogo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 		report.addColumn(col.column("Riemissione","riemissione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 			 	
		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
	
 		report.setDataSource(createDataSourceReport(lista_misure));
 		
 		report.highlightDetailEvenRows();
		
	

	return report;
}


private DRDataSource createDataSourceReport(ArrayList<MisuraDTO> lista_misure) throws Exception {

	DRDataSource dataSource = null;
	String[] listaCodici = null;
				
		listaCodici = new String[11];
		
		listaCodici[0]="certificato";
		listaCodici[1]="data_emissione";
		listaCodici[2]="oggetto";
		listaCodici[3]="costruttore";
		listaCodici[4]="modello";
		listaCodici[5]="matricola";	
		listaCodici[6]="destinatario";	
		listaCodici[7]="provincia";	
		listaCodici[8]="codice";	
		listaCodici[9]="luogo";	
		listaCodici[10]="riemissione";	
		

		dataSource = new DRDataSource(listaCodici);		
		
		for (MisuraDTO misura : lista_misure) {
			ArrayList<String> arrayPs = new ArrayList<String>();
			
			ArrayList<String> datiCert = DirectMySqlDAO.getCertificatoFromMisura(misura);
			System.out.println(misura.getId()+" - "+datiCert);
			if(!datiCert.get(0).equals("3") && misura.getnCertificato()!=null && !misura.getnCertificato().equals("")) {
				if(misura.getnCertificato()!=null) {
					arrayPs.add(misura.getnCertificato());
				}else {
					arrayPs.add("");
				}
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			
				//CertificatoDTO certificato = GestioneCertificatoDAO.getCertificatoByMisura(misura);
				if(datiCert.get(1)!=null) {
					arrayPs.add(df.format(df.parse(datiCert.get(1))));
				}else {
					arrayPs.add("");
				}
				
				if(misura.getStrumento().getDenominazione()!=null) {
					arrayPs.add(misura.getStrumento().getDenominazione());
				}else {
					arrayPs.add("");
				}
				
				if(misura.getStrumento().getCostruttore()!=null) {
					arrayPs.add(misura.getStrumento().getCostruttore());
				}else {
					arrayPs.add("");
				}

				if(misura.getStrumento().getModello()!=null) {
					arrayPs.add(misura.getStrumento().getModello());
				}else {
					arrayPs.add("");
				}

				if(misura.getStrumento().getMatricola()!=null) {
					arrayPs.add(misura.getStrumento().getMatricola());
				}else {
					arrayPs.add("");
				}
				
				if(misura.getIntervento().getNome_cliente()!=null) {
					arrayPs.add(misura.getIntervento().getNome_cliente());
				}else {
					arrayPs.add("");
				}
				
				if(misura.getIntervento().getId_cliente()!=0) {
					ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(""+misura.getIntervento().getId_cliente()); 
					arrayPs.add(cliente.getProvincia());
				}else {
					arrayPs.add("");
				}
				if(misura.getStrumento()!=null) {
					 
					arrayPs.add(""+misura.getStrumento().getTipo_strumento().getId_codice_accredia());
				}else {
					arrayPs.add("");
				}
				if(misura.getIntervento()!=null) {
					 if(misura.getIntervento().getPressoDestinatario()==0 || misura.getIntervento().getPressoDestinatario()==3) {
						 arrayPs.add("P");	 
					 }else {
						 arrayPs.add("E");
					 }				
				}else {
					arrayPs.add("");
				}
				if(misura.getObsoleto().equals("S")) {
					arrayPs.add("X");
				}else {
					arrayPs.add("");	
				}
				
				dataSource.add(arrayPs.toArray());
			}
			
			
		}
	

		
 		return dataSource;
}

}
