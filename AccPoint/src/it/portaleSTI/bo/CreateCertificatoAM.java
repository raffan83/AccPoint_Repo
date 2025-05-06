package it.portaleSTI.bo;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMProgressivoDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AM_CertificatoWrapper;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.component.HorizontalListBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.VerticalListBuilder;
import net.sf.dynamicreports.report.constant.HorizontalImageAlignment;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateCertificatoAM {
	
	public CreateCertificatoAM(AMProvaDTO prova, Session session) {
		build(prova, session);
	}
	
	public static void build(AMProvaDTO prova, Session session) 
	{
		try {
		
		List<AM_CertificatoWrapper> listaWrapper = new ArrayList<>();
		
//		AMCampioneDTO campione =GestioneAM_BO.getCampioneFromID(1, session);
//		
//		AMOggettoProvaDTO strumento= GestioneAM_BO.getOggettoProvaFromID(1, session);
//
//		
//		listaWrapper.add(new AM_CertificatoWrapper(campione, strumento));
//		
		InputStream is  = PivotTemplate.class.getResourceAsStream("ReportAM.jrxml");
		
	//	JasperReport report = JasperCompileManager.compileReport(is);
		
		
		JasperReportBuilder report = DynamicReports.report();
		
		report.setTemplateDesign(is);
		
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		String ubicazione="";
		
		if(prova.getIntervento().getNomeCliente()!=null) {
			ubicazione+=prova.getIntervento().getNomeCliente();
		}
		
		if(prova.getIntervento().getNomeClienteUtilizzatore()!=null) {
			ubicazione+= "\nPresso "+prova.getIntervento().getNomeClienteUtilizzatore();
		}
		
		if(prova.getIntervento().getId_sede_utilizzatore()!=0) {
			ubicazione+= " - "+ prova.getIntervento().getNomeSedeUtilizzatore();
		}
		
		
		report.addParameter("cliente_utilizzatore", ubicazione);
		
		String nRapporto="";
		AMProgressivoDTO progressivo = GestioneAM_BO.getProgressivo(prova.getIntervento().getIdCommessa(), session);
		if(progressivo!=null) {
			
			nRapporto = prova.getIntervento().getIdCommessa().split("_")[1]+prova.getIntervento().getIdCommessa().split("_")[2].split("/")[0]+"-"+String.format("%03d", progressivo.getProgressivo()+1);
		}else {
			nRapporto = prova.getIntervento().getIdCommessa().split("_")[1]+prova.getIntervento().getIdCommessa().split("_")[2].split("/")[0]+"-"+String.format("%03d", 1);
			progressivo = new AMProgressivoDTO();
			progressivo.setCommessa(prova.getIntervento().getIdCommessa());
			progressivo.setProgressivo(1);
			session.save(progressivo);
		}
		
		report.addParameter("n_rapporto", nRapporto);
		
		prova.setnRapporto(nRapporto);
		session.update(prova);
		
		if(prova.getStrumento().getMatricola()!=null) {
			report.addParameter("matricola_strumento", prova.getStrumento().getMatricola());
		}else {
			report.addParameter("matricola_strumento", "");
		}
		
		
		if(prova.getStrumento().getnFabbrica()!=null) {
			report.addParameter("n_fabbrica", prova.getStrumento().getnFabbrica());
		}else {
			report.addParameter("n_fabbrica", "");
		}
		
		
		if(prova.getStrumento().getTipo()!=null) {
			report.addParameter("tipo", prova.getStrumento().getTipo());
		}else {
			report.addParameter("tipo", "");
		}
		
		if(prova.getStrumento().getDescrizione()!=null) {
			report.addParameter("descrizione", prova.getStrumento().getDescrizione());
		}else {
			report.addParameter("descrizione", "");
		}
		
		
		if(prova.getStrumento().getPressione()!=null) {
			report.addParameter("pressione", prova.getStrumento().getPressione());
		}else {
			report.addParameter("pressione", "");
		}
		
		if(prova.getStrumento().getVolume()!=null) {
			report.addParameter("volume", prova.getStrumento().getVolume());
		}else {
			report.addParameter("volume", "");
		}
		
		if(prova.getStrumento().getAnno()!=0) {
			report.addParameter("anno", ""+prova.getStrumento().getAnno());
		}else {
			report.addParameter("anno", "");
		}
		
		if(prova.getStrumento().getCostruttore()!=null) {
			report.addParameter("costruttore", prova.getStrumento().getCostruttore());
		}else {
			report.addParameter("costruttore", "");
		}
		
		if(prova.getStrumento().getMaterialeFondo()!=null) {
			report.addParameter("materiale_fondo", prova.getStrumento().getMaterialeFondo());
		}else {
			report.addParameter("materiale_fondo", "");
		}
		
		if(prova.getStrumento().getSpessoreFondo()!=null) {
			report.addParameter("spessore_fondo", prova.getStrumento().getSpessoreFondo());
		}else {
			report.addParameter("spessore_fondo", "");
		}
		
		if(prova.getStrumento().getSpessoreFasciame()!=null) {
			report.addParameter("spessore_fasciame", prova.getStrumento().getSpessoreFasciame());
		}else {
			report.addParameter("spessore_fasciame", "");
		}
		
		if(prova.getStrumento().getMaterialeFasciame()!=null) {
			report.addParameter("materiale_fasciame", prova.getStrumento().getMaterialeFasciame());
		}else {
			report.addParameter("materiale_fasciame", "");
		}
		
		if(prova.getCampione().getRilevatoreOut()!=null) {
			report.addParameter("rilevatore_out", prova.getCampione().getRilevatoreOut());
		}else {
			report.addParameter("rilevatore_out", "");
		}
		
		if(prova.getCampione().getMezzoAccoppiante()!=null) {
			report.addParameter("mezzo_accoppiante", prova.getCampione().getMezzoAccoppiante());
		}else {
			report.addParameter("mezzo_accoppiante", "");
		}
		
		if(prova.getCampione().getBloccoRiferimento()!=null) {
			report.addParameter("blocco_riferimento", prova.getCampione().getBloccoRiferimento());
		}else {
			report.addParameter("blocco_riferimento", "");
		}
		
		if(prova.getCampione().getMatricola()!=null) {
			report.addParameter("matricola_campione", prova.getCampione().getMatricola());
		}else {
			report.addParameter("matricola_campione", "");
		}
		
		if(prova.getCampione().getSondaCostruttore()!=null) {
			report.addParameter("costruttore_sonda", prova.getCampione().getSondaCostruttore());
		}else {
			report.addParameter("costruttore_sonda", "");
		}
		
		if(prova.getCampione().getSondaModello()!=null) {
			report.addParameter("modello_sonda", prova.getCampione().getSondaModello());
		}else {
			report.addParameter("modello_sonda", "");
		}
		
		if(prova.getCampione().getSondaMatricola()!=null) {
			report.addParameter("matricola_sonda", prova.getCampione().getSondaMatricola());
		}else {
			report.addParameter("matricola_sonda", "");
		}
		
		if(prova.getCampione().getSondaFrequenza()!=null) {
			report.addParameter("frequenza_sonda", prova.getCampione().getSondaFrequenza());
		}else {
			report.addParameter("frequenza_sonda", "");
		}
		
		if(prova.getCampione().getSondaDimensione()!=null) {
			report.addParameter("dimensione_sonda", prova.getCampione().getSondaDimensione());
		}else {
			report.addParameter("dimensione_sonda", "");
		}
		
		if(prova.getCampione().getSondaAngolo()!=null) {
			report.addParameter("angolo_sonda", prova.getCampione().getSondaAngolo());
		}else {
			report.addParameter("angolo_sonda", "");
		}
		
		if(prova.getCampione().getSondaVelocita()!=null) {
			report.addParameter("velocita_sonda", prova.getCampione().getSondaVelocita());
		}else {
			report.addParameter("velocita_sonda", "");
		}
		
		
		if(prova.getEsito().equals("POSITIVO")) {
			report.addParameter("esito_positivo", "X");
			report.addParameter("esito_negativo", "");
		}else {
			report.addParameter("esito_positivo", "");
			report.addParameter("esito_negativo", "X");
		}
		
		
		if(prova.getNote()!=null) {
			report.addParameter("note", prova.getNote());
		}else {
			report.addParameter("note", "");
		}
		
		if(prova.getData()!=null) {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			report.addParameter("data_prova", ""+df.format(prova.getData()));
		}else {
			report.addParameter("data_prova", "");
		}
		
		if(prova.getOperatore().getNomeOperatore()!=null) {
			report.addParameter("firma", prova.getOperatore().getNomeOperatore());
		}else {
			report.addParameter("firma", "");
		}
		
		
		SubreportBuilder subreport; 
		subreport = cmp.subreport(getTableReport(prova));
		
		File file = new File(Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\img\\"+prova.getFilename_img());
		Image image = ImageIO.read(file);
		
		String min_fasciame="";
		String min_fondo_sup="";
		String min_fondo_inf="";
		
		if(prova.getSpess_min_fasciame()!=null) {
			min_fasciame = "Spessore minimo FASCIAME "+prova.getSpess_min_fasciame();
		}
		if(prova.getSpess_min_fondo_inf()!=null) {
			min_fondo_inf = "Spessore minimo FONDO INFERIORE "+prova.getSpess_min_fondo_inf();
		}
		if(prova.getSpess_min_fondo_sup()!=null) {
			min_fondo_sup = "Spessore minimo FONDO SUPERIORE "+prova.getSpess_min_fondo_sup();
		}
		
		HorizontalListBuilder hl = cmp.horizontalList(
				cmp.image(image).setFixedWidth(270).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER),
				cmp.horizontalGap(25),
				cmp.verticalList(
						subreport, 
						cmp.verticalGap(10),
						cmp.text(min_fasciame).setStyle(Templates.rootStyle),
						cmp.text(min_fondo_sup).setStyle(Templates.rootStyle),
						cmp.text(min_fondo_inf).setStyle(Templates.rootStyle)
						)
				);
		
		VerticalListBuilder vl2 = cmp.verticalList(hl, cmp.verticalGap(25));
		
		report.detail(vl2);
		report.setDetailSplitType(SplitType.PREVENT);
		
		report.ignorePagination();
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		
	//	String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestCeftificatoSE.pdf";

		
		 // System.getProperty("user.home")+"\\Desktop\\RapportoMisuraSpessimetrica.pdf";
		String path_folder = Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\Certificati\\";
		File folder = new File(path_folder);
		
		if(folder.exists() == false) {
			folder.mkdirs();
		}
		
		String path = path_folder+prova.getnRapporto()+".pdf";
		
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		File file_report = new File(path);
		
		if(prova.getCampione().getFile_certificato()!=null) {
			File cert_campione = new File (Costanti.PATH_FOLDER+"\\AM_Interventi\\Campioni\\"+prova.getCampione().getId()+"\\"+prova.getCampione().getFile_certificato());
			addAllegato(file_report, cert_campione);
		}
		
	//	Map<String, Object> parameters = new HashMap<>(); // se hai parametri, altrimenti lascia vuoto

	//	JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(listaWrapper);
		
	
		
		//JasperPrint print = JasperFillManager.fillReport(report, parameters, dataSource);
		
		//JasperExportManager.exportReportToPdfFile(print, System.getProperty("user.home")+"\\Desktop\\RapportoMisuraSpessimetrica.pdf");
		System.out.println("PDF generato con successo!");
		
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	
	
	@SuppressWarnings("deprecation")
	public static JasperReportBuilder getTableReport(AMProvaDTO prova) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			

			 report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			//report.addColumn(col.column("RISULTATI MISURE SPESSIMETRICHE [mm]","matrix", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
			 report.title(
				        cmp.text("RISULTATI MISURE SPESSIMETRICHE [mm]")
				           .setStyle(Templates.columnTitleStyle));
			String matrice = prova.getMatrixSpess();
			
			 List<String> rows = new ArrayList<>();
			 
			 List<List<String>> data = new ArrayList<>();
			    Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
			    Matcher matcher = pattern.matcher(matrice);
			    while (matcher.find()) {
			        String[] values = matcher.group(1).split(",");
			        List<String> row = new ArrayList<>();
			        for (String v : values) {
			            row.add(v.trim());
			        }
			        data.add(row);
			    }
		        
			    int maxColonne = data.stream().mapToInt(List::size).max().orElse(0);
			    String[] nomiColonne = new String[maxColonne + 1];
			    nomiColonne[0] = "Riga";
			    for (int i = 0; i < maxColonne; i++) {
			        nomiColonne[i + 1] = Utility.indiceToLettere(i); // ad es. A, B, C, ...
			    }
			    
			    DRDataSource ds = new DRDataSource(nomiColonne);
			    for (int i = 0; i < data.size(); i++) {
			        List<String> riga = data.get(i);
			        Object[] valori = new Object[maxColonne + 1];
			        valori[0] = String.valueOf(i + 1); // numerazione riga
			        for (int j = 0; j < maxColonne; j++) {
			            valori[j + 1] = (j < riga.size()) ? riga.get(j) : "";
			        }
			        ds.add(valori);
			    }
			    
			
	 		report.setDataSource(ds);
	 		
	 		for (String colName : nomiColonne) {
	 			String text = colName;
	 			if(colName.equals("Riga")) {
	 				text = "";
	 			}
	 		    report.addColumn(
	 		        Columns.column(text, colName, type.stringType())
	 		               .setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
	 		    );
	 		}
	 	
	 		report.setColumnStyle(Templates.columnStyle.setBorder(stl.penThin())); // celle dati
	 		report.setColumnTitleStyle(Templates.columnTitleStyle);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
private static void addAllegato(File source, File allegato) throws IOException {
		
		PDFMergerUtility ut = new PDFMergerUtility();
		ut.addSource(source);
		
		
	
		ut.addSource(allegato);
		ut.setDestinationFileName(source.getPath());
		ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
	}

	
		public static void main(String[] args) throws HibernateException, Exception {
			new ContextListener().configCostantApplication();
			Session session =SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			AMProvaDTO prova = GestioneAM_BO.getProvaFromID(6, session);
		
			new CreateCertificatoAM(prova, session);
			session.getTransaction().commit();
			session.close();
		}

		
}
