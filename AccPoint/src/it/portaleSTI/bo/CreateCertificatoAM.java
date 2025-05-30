package it.portaleSTI.bo;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.field;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;
import static org.junit.Assert.assertNotNull;
import static net.sf.dynamicreports.report.builder.DynamicReports.grp;

import net.sf.dynamicreports.report.builder.style.BorderBuilder;
import net.sf.dynamicreports.report.builder.style.ConditionalStyleBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.builder.style.Styles;
import net.sf.dynamicreports.report.definition.ReportParameters;

import java.awt.Color;
import java.awt.Image;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.imageio.ImageIO;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfGState;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.AMProgressivoDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMRapportoDTO;
import it.portaleSTI.DTO.AMReportDTO;
import it.portaleSTI.DTO.AM_CertificatoWrapper;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.component.ComponentBuilder;
import net.sf.dynamicreports.report.builder.component.HorizontalListBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.VerticalListBuilder;
import net.sf.dynamicreports.report.builder.expression.Expressions;
import net.sf.dynamicreports.report.builder.group.GroupBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.constant.HorizontalImageAlignment;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.LineStyle;
import net.sf.dynamicreports.report.constant.Markup;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.StretchType;
import net.sf.dynamicreports.report.constant.VerticalAlignment;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.oasis.Style;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateCertificatoAM {
	
	
	public CreateCertificatoAM(AMProvaDTO prova, Session session, AMRapportoDTO rapporto, boolean isAnteprima) throws Exception {
		build(prova, session, rapporto,isAnteprima);
	}
	
	public static void build(AMProvaDTO prova, Session session, AMRapportoDTO rapporto, boolean isAnteprima) throws Exception 
	{
	

		InputStream is  = PivotTemplate.class.getResourceAsStream("ReportAM.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		report.setTemplateDesign(is);
		
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		String ubicazione="";
		
		if(prova.getIntervento().getNomeCliente()!=null) {
			
			ubicazione+=prova.getIntervento().getNomeCliente();
			
			if(!prova.getIntervento().getNomeSede().equals("Non Associate")) {
				ubicazione += " - "+prova.getIntervento().getNomeSede();
			}
			
		}
		
		
		if(prova.getIntervento().getId_cliente()!=prova.getIntervento().getId_cliente_utilizzatore()) {
			
			if(!prova.getIntervento().getNomeSedeUtilizzatore().equals("Non Associate")) {
				ubicazione+= "\nPresso "+ prova.getIntervento().getNomeSedeUtilizzatore();
			}else {
				ubicazione+= "\nPresso "+ prova.getIntervento().getNomeClienteUtilizzatore();
			}
			
		}
		
		if(prova.getUbicazione()!=null) {
			ubicazione+= " - "+prova.getUbicazione();
		}
		
		
		report.addParameter("cliente_utilizzatore", ubicazione);
		
		String nRapporto="";
		
		
		if(prova.getnRapporto()!=null && !prova.getnRapporto().equals("")) {
			
			report.addParameter("n_rapporto", prova.getnRapporto());
			
		}else {
			
			AMProgressivoDTO progressivo = GestioneAM_BO.getProgressivo(prova.getIntervento().getIdCommessa(), session);
			if(progressivo!=null) {
				
				nRapporto = prova.getIntervento().getIdCommessa().split("_")[1]+prova.getIntervento().getIdCommessa().split("_")[2].split("/")[0]+"-"+String.format("%03d", progressivo.getProgressivo()+1);
				progressivo.setProgressivo(progressivo.getProgressivo()+1);
				session.update(progressivo);
			}else {
				nRapporto = prova.getIntervento().getIdCommessa().split("_")[1]+prova.getIntervento().getIdCommessa().split("_")[2].split("/")[0]+"-"+String.format("%03d", 1);
				progressivo = new AMProgressivoDTO();
				progressivo.setCommessa(prova.getIntervento().getIdCommessa());
				progressivo.setProgressivo(1);
				session.save(progressivo);
			}
			report.addParameter("n_rapporto", nRapporto);
			prova.setnRapporto(nRapporto);
		}
		
		
		
		if(!isAnteprima) {
			session.update(prova);
		}
		
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

		if(prova.getCampione().getRilevatoreOut()!=null) {
			report.addParameter("rilevatore_out", " "+ prova.getCampione().getRilevatoreOut());
		}else {
			report.addParameter("rilevatore_out", "");
		}
		
		if(prova.getCampione().getMezzoAccoppiante()!=null) {
			report.addParameter("mezzo_accoppiante", " "+ prova.getCampione().getMezzoAccoppiante());
		}else {
			report.addParameter("mezzo_accoppiante", "");
		}
		
		if(prova.getCampione().getBloccoRiferimento()!=null) {
			report.addParameter("blocco_riferimento", " "+ prova.getCampione().getBloccoRiferimento());
		}else {
			report.addParameter("blocco_riferimento", "");
		}
		
		if(prova.getCampione().getMatricola()!=null) {
			report.addParameter("matricola_campione", " "+ prova.getCampione().getMatricola());
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
		
		if(prova.getStrumento().getSondaVelocita()!=null) {
			report.addParameter("velocita_sonda", prova.getStrumento().getSondaVelocita());
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
			report.addParameter("note", " " +prova.getNote());
		}else {
			report.addParameter("note", "");
		}
		
		if(prova.getData()!=null) {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			report.addParameter("data_prova", ""+df.format(prova.getData()));
		}else {
			report.addParameter("data_prova", "");
		}
		
		if(prova.getIntervento().getOperatore().getNomeOperatore()!=null) {
			if(prova.getIntervento().getOperatore().getDicituraPatentino()!=null){
				report.addParameter("firma", prova.getIntervento().getOperatore().getNomeOperatore()+"\n"+prova.getIntervento().getOperatore().getDicituraPatentino());
			}else {
				report.addParameter("firma", prova.getIntervento().getOperatore().getNomeOperatore());
			}
			
		}else {
			report.addParameter("firma", "");
		}
		
		if(prova.getIntervento().getOperatore().getFirma()!=null) {
			File file_firma = new File(Costanti.PATH_FOLDER+"\\AM_Interventi\\Firme\\"+prova.getIntervento().getOperatore().getId()+"\\"+prova.getIntervento().getOperatore().getFirma());
			try {
				Image image_firma = ImageIO.read(file_firma);
				report.addParameter("immagine_firma", image_firma);
			}catch(Exception e) {
				report.addParameter("immagine_firma", "");
			}
			
			
			
		}else {
			report.addParameter("immagine_firma", "");
		}
		
		
		SubreportBuilder subreportZone; 
		subreportZone = cmp.subreport(getTableReportZone(prova.getStrumento().getListaZoneRiferimento()));
		Image image = null;
		File file = new File(Costanti.PATH_FOLDER+"\\AM_Interventi\\Strumenti\\"+prova.getStrumento().getId()+"\\"+prova.getStrumento().getFilename_img());
		try {
		 image = ImageIO.read(file);
		
		}catch(Exception e) {
			 image = null;
		}
		String minimi = calcolaMinimi(prova);
				
		int max_colonne = calcolaMaxColonne(prova);
		int max_righe = calcolaMaxRighe(prova);
		
		VerticalListBuilder vl = null;
		int larghezzaPagina = 553;
		String str = "";	
		if(max_colonne <11 && max_righe <20) {
			
			int larghezzaDisponibileSubreport = larghezzaPagina - 270 - 25;
			
			SubreportBuilder subreport = cmp.subreport(getTableReport(prova, larghezzaDisponibileSubreport, max_colonne, max_righe));
			
			HorizontalListBuilder hl = cmp.horizontalList(
					cmp.image(image).setFixedWidth(270).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER),
					cmp.horizontalGap(25),
					cmp.verticalList(
							subreport, 
							cmp.verticalGap(5),
							cmp.text(minimi).setStyle(Styles.style().setForegroundColor(Color.blue).setFontSize(8))

							)
					);
			
			 vl = cmp.verticalList(cmp.verticalGap(5),hl, cmp.verticalGap(5));
		}else {
			
			 SubreportBuilder subreport = cmp.subreport(getTableReport(prova, larghezzaPagina, max_colonne, max_righe));
			 vl = cmp.verticalList(
					 cmp.verticalGap(5),
					 cmp.image(image).setFixedHeight(250).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER),
					 cmp.pageBreak(),
					 cmp.verticalGap(15),
					 subreport, 
					 cmp.verticalGap(5),
					 cmp.text(minimi).setStyle(Styles.style().setForegroundColor(Color.blue).setFontSize(8)));
					 
		}
		

		
		File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"\\immagine_am.png");
		report.addParameter("immagine_am", imageHeader);
	
		TextColumnBuilder<String> groupColumn = col.column("", "tabZone", type.stringType())
			    .setStyle(stl.style().setPadding(0).setTopPadding(0));

		
		GroupBuilder group = grp.group(groupColumn);

		// Aggiungo il subreport nella header del gruppo
		group.addHeaderComponent(subreportZone.setStyle(
		        stl.style().setPadding(0).setTopPadding(0).setBottomPadding(0)));
		

		report.addGroup(group);
		group.setHeaderSplitType(SplitType.IMMEDIATE).setPadding(0);
		report.addDetail(vl).setDetailSplitType(SplitType.IMMEDIATE);
		

		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);
		report.pageFooter(
				cmp.horizontalList(
						cmp.text("MOD-P0010-01").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text("Rev A. del 13/10/2022").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						)
				);

		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		String path_folder = Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\Certificati\\";
		File folder = new File(path_folder);
		
		if(folder.exists() == false) {
			folder.mkdirs();
		}
		
		String path = "";
		
		if(isAnteprima) {
			path = path_folder+"ANTEPRIMA.pdf";
		}else {
			path = path_folder+prova.getnRapporto()+".pdf";
		}
				
		
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		if(isAnteprima) {
			addBozza(path,"");
		}
		
		File file_report = new File(path);
		
		if(prova.getCampione().getFile_certificato()!=null) {
			File cert_campione = new File (Costanti.PATH_FOLDER+"\\AM_Interventi\\Campioni\\"+prova.getCampione().getId()+"\\"+prova.getCampione().getFile_certificato());
			addAllegato(file_report, cert_campione);
		}
		
		if(prova.getIntervento().getOperatore().getPathPatentino()!=null) {
			File patentino = new File (Costanti.PATH_FOLDER+"\\AM_Interventi\\Patentini\\"+prova.getIntervento().getOperatore().getId()+"\\"+prova.getIntervento().getOperatore().getPathPatentino());
			addAllegato(file_report, patentino);
		}
		
		if(!isAnteprima) {
			rapporto.setData(new Date());
			rapporto.setNomeFile(prova.getnRapporto()+".pdf");

			rapporto.setStato(new StatoCertificatoDTO(2));
		
			session.update(rapporto);
		}
		System.out.println("PDF generato con successo!");
		
		
		
	}
	
	private static int calcolaMaxRighe(AMProvaDTO prova) {
		
		return parseMatrice(prova.getMatrixSpess()).size();
	}

	public static void addBozza(String filepath, String newfile) {

		try {
			
			File tmpFile = new File(filepath+"tmp");
	        PdfReader reader = new PdfReader(filepath);
	        FileOutputStream tmpfos = new FileOutputStream(tmpFile);
	        PdfStamper stamper = new PdfStamper(reader, tmpfos);
	        Font f = new Font(FontFamily.HELVETICA, 50);
	        
	        String bozza = "BOZZA";
	        for(int i = 0; i<5;i++) {
	        	bozza=bozza+" - BOZZA";
	        }
	        
	        //f.setColor(BaseColor.RED);
	        int pages = reader.getNumberOfPages();
	        
		        for (int i=0; i<pages; i++) {	        
			        PdfContentByte over = stamper.getOverContent(i+1);
			        Phrase p = new Phrase(String.format(bozza, newfile), f);
			        over.saveState();
			        PdfGState gs1 = new PdfGState();
			        gs1.setFillOpacity(0.08f);			        
			        over.setGState(gs1);
			        for(int j = 0; j<13; j++) {
			        	ColumnText.showTextAligned(over, Element.ALIGN_CENTER, p, 300, (1000-(100*j)), 315);	
			        }
			        over.restoreState();
		        }
	        
	        stamper.close();
	        tmpfos.close();
	        reader.close();
	        File fil = new File (filepath);
	        if(fil.exists()) {
	        	fil.delete();
	        }
			tmpFile.renameTo(new File(filepath));
		} catch (IOException e) {
			System.out.println("IOException: " + e);
			e.printStackTrace();
		} catch (DocumentException e) {
			System.out.println("DocumentException: " + e);
			e.printStackTrace();
		}
		
		
	}
	
	


@SuppressWarnings("deprecation")
public static JasperReportBuilder getTableReport(AMProvaDTO prova, int larghezza_disponibile, int maxColonne, int maxRighe) throws Exception {
    JasperReportBuilder report = DynamicReports.report();
    
    StyleBuilder styleNormal = stl.style().setPadding(2).setFontName("Trebuchet MS").setFontSize(8);
//    StyleBuilder styleTitle = Templates.columnTitleStyle;
//    
//    StyleBuilder styleTitle = stl.style().bold().setPadding(2).setFontName("Trebuchet MS").setFontSize(8);
	StyleBuilder styleTitle = stl.style(stl.style().setPadding(2).setFontName("Trebuchet MS").setFontSize(8)).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setBold(false).setBorder(stl.penThin())
            .setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
            .setBackgroundColor(Color.LIGHT_GRAY)            
         .setMarkup(Markup.HTML);

    int totaleColonne = maxColonne + 2; // Riga + colonne dati
    double fattore = 0.20;
    
    if(maxColonne>=10 || maxRighe>=19) {
    	fattore = 0.10;
    }
    
    int larghezzaColonnaZona = (int)(larghezza_disponibile * fattore); 
    int larghezzaRimanente = larghezza_disponibile - larghezzaColonnaZona;
    int larghezzaColonna = larghezzaRimanente / (totaleColonne - 1);
    try {
        report.title(
            cmp.text("RISULTATI MISURE SPESSIMETRICHE [mm]")
               .setStyle(styleTitle).setFixedWidth(larghezzaColonna * (totaleColonne-1) + larghezzaColonnaZona)
        );

        String matrice = prova.getMatrixSpess();
        List<List<String>> data = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\{([^}]*)\\}");
        Matcher matcher = pattern.matcher(matrice);
        DecimalFormat df = new DecimalFormat("0.00");
        
        while (matcher.find()) {
            String[] values = matcher.group(1).split(",");
            List<String> row = new ArrayList<>();
            for (String v : values) {
            	v = v.trim();
                try {
                    double num = Double.parseDouble(v);
                    row.add(df.format(num));
                } catch (NumberFormatException e) {
                    row.add(v); 
                }
            }
            data.add(row);
        }


        String[] nomiColonne = new String[maxColonne + 1];
        nomiColonne[0] = "Riga";
        for (int i = 0; i < maxColonne; i++) {
            nomiColonne[i + 1] = Utility.indiceToLettere(i); // A, B, C...
        }

        Map<Integer, String> rigaToZona = new HashMap<>();
        Set<Integer> righeConZona = new HashSet<>();
        
        for (AMOggettoProvaZonaRifDTO z : prova.getStrumento().getListaZoneRiferimento()) {
            int inizio = z.getPunto_intervallo_inizio();
            int fine = z.getPunto_intervallo_fine();
            for (int i = inizio; i <= fine; i++) {
                rigaToZona.put(i, z.getIndicazione());
            }
            righeConZona.add(inizio);
        }

        // Raggruppa per zona
        Map<String, List<Object[]>> datiPerZona = new LinkedHashMap<>();
        for (int i = 0; i < data.size(); i++) {
            int rigaCorrente = i + 1;
            String zona = rigaToZona.getOrDefault(rigaCorrente, "");
            List<String> riga = data.get(i);

            Object[] valori = new Object[maxColonne + 1];
            valori[0] = String.valueOf(rigaCorrente);
            for (int j = 0; j < maxColonne; j++) {
                valori[j + 1] = (j < riga.size()) ? riga.get(j).replace(".", ",") : "";
            }

            datiPerZona.computeIfAbsent(zona, k -> new ArrayList<>()).add(valori);
        }

      
        // Contenuto complessivo del report
        VerticalListBuilder mainList = cmp.verticalList();
       
        // Intestazione unica
        HorizontalListBuilder header = cmp.horizontalList();
        header.add(cmp.text("") // dummy per allineare con zonaBox
                     .setStyle(styleTitle.setFontSize(6))
                     .setFixedWidth(larghezzaColonnaZona));
        for (String col : nomiColonne) {
        	if(col.equals("Riga")) {
//        		header.add(cmp.text("")
//                        .setStyle(Templates.columnTitleStyle.setFontSize(7))
//                        .setFixedWidth(larghezzaColonna));
        		
           		header.add(cmp.text("")
                      .setStyle(styleTitle.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
                      .setFixedWidth(larghezzaColonna));
        	}else {
        		header.add(cmp.text(col)
                        .setStyle(styleTitle.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
                        .setFixedWidth(larghezzaColonna));	
        	}
            
        }
        mainList.add(header);
        
        if(maxRighe != prova.getStrumento().getListaZoneRiferimento().size()) {
        	
        	 // Aggiungi blocchi zona + righe dati
          for (Map.Entry<String, List<Object[]>> entry : datiPerZona.entrySet()) {
              String zona = entry.getKey();
              List<Object[]> righe = entry.getValue();
  
              ComponentBuilder<?, ?> zonaBox = cmp.text(zona)
                      .setStyle(styleTitle.setFontSize(5))
                      .setHeight(15 * righe.size())
                      .setFixedWidth(larghezzaColonnaZona); // larghezza coerente
              
//              VerticalListBuilder zonaBox = cmp.verticalList();
//  
//              for (int i = 0; i < righe.size(); i++) {
//                  String text = (i == 0) ? zona : ""; 
//                  zonaBox.add(
//                      cmp.text(text)
//                         .setStyle(Templates.columnTitleStyle.setFontSize(5))
//                         .setStretchWithOverflow(true)
//                         .setFixedWidth(larghezzaColonnaZona)
//                         .setHeight(15) 
//                  );
//              }
  
              VerticalListBuilder righeList = cmp.verticalList();
              for (Object[] riga : righe) {
                  HorizontalListBuilder rigaComp = cmp.horizontalList();
                  for (int j = 0; j <= maxColonne; j++) {
                  	if(j==0) {
                  		 rigaComp.add(
                                   cmp.text((String) riga[j])
                                      .setStyle(styleTitle.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
                                      .setFixedWidth(larghezzaColonna)
                               );
                  	}else {
                  		 rigaComp.add(
                                   cmp.text((String) riga[j])
                                      .setStyle(styleNormal.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER))
                                      .setFixedWidth(larghezzaColonna)
                               );
                  	}
                     
                  }
                  righeList.add(rigaComp);
              }
  
              mainList.add(cmp.horizontalList(
                      zonaBox,
                      righeList
                  ));
          }
        	
        }else {
        	
        	 for (Map.Entry<String, List<Object[]>> entry : datiPerZona.entrySet()) {
                 String zona = entry.getKey();
                 List<Object[]> righe = entry.getValue();

                 for (int i = 0; i < righe.size(); i++) {
                     HorizontalListBuilder rigaComp = cmp.horizontalList();

                     // Zona: solo nella prima riga
                     String testoZona = (i == 0) ? zona : "";
                     rigaComp.add(
                         cmp.text(testoZona)
                             .setStyle(styleTitle.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
                             .setFixedWidth(larghezzaColonnaZona)
                             .setStretchWithOverflow(true)
                            
                     );

                     // Celle dati
                     Object[] riga = righe.get(i);
                     for (int j = 0; j <= maxColonne; j++) {
                         if (j == 0) {
                             rigaComp.add(
                                 cmp.text((String) riga[j])
                                     .setStyle(styleTitle.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
                                     .setFixedWidth(larghezzaColonna)
                             );
                         } else {
                             rigaComp.add(
                                 cmp.text((String) riga[j])
                                     .setStyle(styleNormal.setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER))
                                     .setStretchWithOverflow(true)
                                     .setFixedWidth(larghezzaColonna)
                             );
                         }
                     }

                     // Aggiungi la riga al report
                     mainList.add(rigaComp);
                 }
                 
                
             }
        	
        }

       

        
       

        report.summary(mainList).setSummarySplitType(SplitType.IMMEDIATE);

    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }

    return report;
}




	
	@SuppressWarnings("deprecation")
	public static JasperReportBuilder getTableReportZone( Set<AMOggettoProvaZonaRifDTO> listaZoneRiferimento) throws Exception{

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
		 		        Columns.column("ZONA DI RIFERIMENTO", "zona", type.stringType()).setFixedWidth(150).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			report.addColumn(
		 		        Columns.column("MATERIALE", "materiale", type.stringType()).setFixedWidth(150).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			report.addColumn(
		 		        Columns.column("SPESSORE", "spessore", type.stringType()).setFixedWidth(253).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(stl.style().setFontSize(8).setForegroundColor(Color.blue).setBorder(stl.pen1Point().setLineColor(Color.BLACK)))
		 		    );
			report.getReport().getTitleBand().setPrintWhenExpression(Expressions.printNotInFirstPage());
			
			
			  
			  String[] listaCodici = null;
				
				listaCodici = new String[3];
				
				listaCodici[0]="zona";
				listaCodici[1]="materiale";
				listaCodici[2]="spessore";	
				
				  DRDataSource ds = new DRDataSource(listaCodici);
			for (AMOggettoProvaZonaRifDTO zona : listaZoneRiferimento) {
				ArrayList<String> arrayPs = new ArrayList<String>();
				arrayPs.add(zona.getZonaRiferimento());
				arrayPs.add(zona.getMateriale());
				arrayPs.add(zona.getSpessore());
				
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
			AMProvaDTO prova = GestioneAM_BO.getProvaFromID(15, session);
		
			AMRapportoDTO r = GestioneAM_BO.getRapportoFromProva(prova.getId(), session);
			new CreateCertificatoAM(prova, session, r, false);
			session.getTransaction().commit();
			session.close();
		}

		
		
		
		private static int calcolaMaxColonne(AMProvaDTO prova) {
		    String matrice = prova.getMatrixSpess();
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
		    return data.stream().mapToInt(List::size).max().orElse(0);
		}
		

		
		private static String calcolaMinimi(AMProvaDTO prova) {
			
			List<List<Double>> matrice = parseMatrice(prova.getMatrixSpess());
		
			Set<AMOggettoProvaZonaRifDTO> lista = prova.getStrumento().getListaZoneRiferimento();
			List<AMOggettoProvaZonaRifDTO> sortedList = lista.stream()
				    .sorted(Comparator.comparing(AMOggettoProvaZonaRifDTO::getId)) // o getIdZona() 
				    .collect(Collectors.toList());
			
			StringBuilder sb = new StringBuilder();
		   

		    for (AMOggettoProvaZonaRifDTO zona : sortedList) {
		        int inizio = zona.getPunto_intervallo_inizio();
		        int fine = zona.getPunto_intervallo_fine();
		        
		        if(inizio>0) {
	        		inizio = inizio -1;
	        	}
		        if(fine>0) {
	        		fine = fine -1;
	        	}

		        if (inizio >= 0 && fine >= 0 && inizio < matrice.size() && fine < matrice.size()) {
		        	
		        	
		            int from = Math.min(inizio, fine);
		            int to = Math.max(inizio, fine);

		            double minimo = Double.MAX_VALUE;

		            for (int i = from; i <= to; i++) {
		                List<Double> riga = matrice.get(i);
		                if (!riga.isEmpty()) {
		                    double minRiga = Collections.min(riga);
		                    if (minRiga < minimo) {
		                        minimo = minRiga;
		                    }
		                }
		            }

		            sb.append("Spessore minimo ").append(zona.getZonaRiferimento()).append(": ")
		              .append(minimo).append(" mm").append("\n");
		        }
		    }

		    return sb.toString();
		}
		
		
		private static List<List<Double>> parseMatrice(String input) {
		    List<List<Double>> matrice = new ArrayList<>();

		    // Rimuove i primi e ultimi simboli quadri [ ]
		    input = input.trim();
		    if (input.startsWith("[")) input = input.substring(1);
		    if (input.endsWith("]")) input = input.substring(0, input.length() - 1);

		    // Divide per riga usando le parentesi graffe
		    String[] righe = input.split("\\},\\{");

		    for (String riga : righe) {
		        // Pulisce le graffe residue
		        riga = riga.replace("{", "").replace("}", "");
		        String[] valori = riga.split(",");
		        List<Double> rigaNumerica = new ArrayList<>();
		        for (String val : valori) {
		            rigaNumerica.add(Double.parseDouble(val.trim()));
		        }
		        matrice.add(rigaNumerica);
		    }

		    return matrice;
		}
}
