package it.portaleSTI.certificatiLAT;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.InputStream;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReportLAT.PivotTemplateLAT;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneLivellaBollaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreaCertificatoLivellaBolla {

	public CreaCertificatoLivellaBolla(CertificatoDTO certificato, LatMisuraDTO misura, String path_immagine, Session session) throws Exception {
		
		build(certificato, misura, path_immagine, session);
	}
	
	
	private void build(CertificatoDTO certificato, LatMisuraDTO misura, String path_immagine, Session session) throws Exception {
		
		InputStream is =  PivotTemplateLAT.class.getResourceAsStream("LivellaBollaP1.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		if(misura.getnCertificato()!=null) {
			report.addParameter("numero_certificato", misura.getnCertificato());	
		}else{
			report.addParameter("numero_certificato", "");
		}
		
		
		SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy"); 
		
		report.addParameter("data_emissione", dt.format(new Date()));
		
		CommessaDTO commessa = GestioneCommesseBO.getCommessaById(misura.getIntervento().getIdCommessa());
		//ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getIntervento().getId_cliente()));
		ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(commessa.getID_ANAGEN()));
		if(cliente!=null) {
			report.addParameter("cliente", cliente.getNome());	
		}else {
			report.addParameter("cliente", "");
		}
		if(cliente!=null && cliente.getIndirizzo()!=null) {
			report.addParameter("indirizzo_cliente", commessa.getANAGEN_INDR_DESCR() + " " +cliente.getIndirizzo());
		}else{
			report.addParameter("indirizzo_cliente", "");
		}
		
		
		ClienteDTO cliente_util = null;
		if(commessa!=null) {
			cliente_util = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(commessa.getID_ANAGEN_UTIL()));	
		}		
		if(cliente_util!=null && cliente_util.getNome()!=null) {
			report.addParameter("destinatario", cliente_util.getNome());	
		}else {
			if(cliente!=null) {
				report.addParameter("destinatario", cliente.getNome());				
			}else {
				report.addParameter("destinatario", "");		
			}
		}
	
		if(commessa!=null && commessa.getANAGEN_INDR_INDIRIZZO()!=null && !commessa.getANAGEN_INDR_INDIRIZZO().equals("")) {
			report.addParameter("indirizzo_destinatario", commessa.getANAGEN_INDR_INDIRIZZO());
		}else {
			if(cliente!=null && cliente.getIndirizzo()!=null) {
				report.addParameter("indirizzo_destinatario", commessa.getANAGEN_INDR_DESCR() + " " +cliente.getIndirizzo());
			}else {
				report.addParameter("indirizzo_destinatario", "");
			}			
		}
		
		report.addParameter("richiesta", "RICHIESTA");
		report.addParameter("data", "DATA");
		
		if(misura.getStrumento().getCostruttore()!=null) {
			report.addParameter("costruttore", misura.getStrumento().getCostruttore());	
		}else {
			report.addParameter("costruttore", "");
		}		
		if(misura.getStrumento().getModello()!=null) {
			report.addParameter("modello", misura.getStrumento().getModello());	
		}else {
			report.addParameter("modello", "");	
		}
		if(misura.getStrumento().getMatricola()!=null) {
			report.addParameter("matricola", misura.getStrumento().getMatricola());	
		}else {
			report.addParameter("matricola", "");
		}
		
		report.addParameter("data_ricevimento_oggetto", "DATA RICEVIMENTO OGGETTO");
		
		if(misura.getData_misura()!=null) {
			report.addParameter("data_misure", dt.format(misura.getData_misura()));
		}else {
			report.addParameter("data_misure", "");
		}
		if(misura.getMisura_lat()!=null) {
			if(misura.getMisura_lat().getSigla_registro()!=null) {
				report.addParameter("registro_laboratorio",  misura.getMisura_lat().getSigla_registro());		
			}else {
				report.addParameter("registro_laboratorio",  "");
			}
		}else {
			report.addParameter("registro_laboratorio", "");
		}
		
		InputStream is2 =  PivotTemplateLAT.class.getResourceAsStream("LivellaBollaP2.jrxml");
		
		JasperReportBuilder reportP2 = DynamicReports.report();
		
		reportP2.setTemplateDesign(is2);
		reportP2.setTemplate(Templates.reportTemplate);

		reportP2.setDataSource(new JREmptyDataSource());		
		reportP2.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		if(misura.getnCertificato()!=null) {
			reportP2.addParameter("numero_certificato", misura.getnCertificato());	
		}else {
			reportP2.addParameter("numero_certificato", "");
		}		
		if(misura.getStrumento().getCostruttore()!=null) {
			reportP2.addParameter("costruttore", misura.getStrumento().getCostruttore());	
		}else {
			reportP2.addParameter("costruttore", "");
		}
		if(misura.getStrumento().getModello()!=null) {
			reportP2.addParameter("modello", misura.getStrumento().getModello());	
		}else {
			reportP2.addParameter("modello", "");
		}
		if(misura.getStrumento().getMatricola()!=null) {
			reportP2.addParameter("matricola", misura.getStrumento().getMatricola());
		}else {
			reportP2.addParameter("matricola", "");
		}
		
		reportP2.addParameter("um", "UM");
		if(misura.getStrumento().getCampo_misura()!=null) {
			reportP2.addParameter("campo_misura", misura.getStrumento().getCampo_misura());
		}else {
			reportP2.addParameter("campo_misura", "");	
		}
		if(misura.getStrumento().getRisoluzione()!=null) {
			reportP2.addParameter("sensibilita", misura.getStrumento().getRisoluzione());	
		}else {
			reportP2.addParameter("sensibilita", "");
		}
		String certificato_campione = "";
		if(misura.getRif_campione()!=null) {
			reportP2.addParameter("campione_riferimento", misura.getRif_campione().getCodice());
			certificato_campione = certificato_campione + misura.getRif_campione().getNumeroCertificato();
		}else {
			reportP2.addParameter("campione_riferimento", "");
		}
		if(misura.getRif_campione_lavoro()!=null) {
			reportP2.addParameter("campione_lavoro", misura.getRif_campione_lavoro().getCodice());
			if(!misura.getRif_campione().getCodice().equals(misura.getRif_campione_lavoro().getCodice())) {
				certificato_campione = certificato_campione + "; " + misura.getRif_campione_lavoro().getNumeroCertificato();
			}
		}else {
			reportP2.addParameter("campione_lavoro", "");
		}		
		
		reportP2.addParameter("certificati_campione", certificato_campione);
		
		if(misura.getRif_campione_lavoro()!=null)
		
		if(certificato.getMisura().getTemperatura()!=null) {
			reportP2.addParameter("temperatura", certificato.getMisura().getTemperatura().setScale(3, RoundingMode.HALF_UP));	
		}else {
			reportP2.addParameter("temperatura", "");
		}
		if(certificato.getMisura().getUmidita()!=null) {
			reportP2.addParameter("umidita", certificato.getMisura().getUmidita().setScale(3, RoundingMode.HALF_UP));	
		}else {
			reportP2.addParameter("umidita", "");
		}
		
		
		ArrayList<LatPuntoLivellaDTO> lista_punti = GestioneLivellaBollaBO.getListaPuntiLivella(misura.getId(), session);
		if(misura.getIncertezza_estesa()!=null) {
			reportP2.addParameter("incertezza_estesa", misura.getIncertezza_estesa().setScale(3, RoundingMode.HALF_EVEN));	
		}else {
			reportP2.addParameter("incertezza_estesa", "");
		}
		
		String val_medio_divisione = String.valueOf(Utility.getAverageLivella(lista_punti, null, 0).setScale(3, RoundingMode.HALF_EVEN));
		
		if(val_medio_divisione!=null) {
			reportP2.addParameter("val_medio_divisione", val_medio_divisione);	
		}else {
			reportP2.addParameter("val_medio_divisione", "");
		}
		
		if(misura.getIncertezza_media()!=null) {
			reportP2.addParameter("incertezza_ass_media", misura.getIncertezza_media().setScale(3, RoundingMode.HALF_EVEN));	
		}else {
			reportP2.addParameter("incertezza_ass_media", "");
		}
		
		
		//String image_path = "C:\\Users\\antonio.dicivita\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\";
		File image = new File(path_immagine + "\\livella.png");
		if(image!=null) {
			reportP2.addParameter("immagine",image);	
		}
		InputStream is3 =  PivotTemplateLAT.class.getResourceAsStream("LivellaBollaP3.jrxml");
		JasperReportBuilder reportP3 = DynamicReports.report();
		reportP3.setTemplateDesign(is3);
		reportP3.setTemplate(Templates.reportTemplate);

		reportP3.setDataSource(new JREmptyDataSource());		
		reportP3.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		if(misura.getnCertificato()!=null) {
			reportP3.addParameter("numero_certificato", misura.getnCertificato());
		}else {
			reportP3.addParameter("numero_certificato", "");
		}
		
		
		SubreportBuilder subreport; 
		subreport = cmp.subreport(getTableReport(lista_punti));
		
	//	reportP3.addDetail(subreport).;
		reportP3.detail(cmp.horizontalList(cmp.horizontalGap(80),subreport));
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		JasperPrint jasperPrint2 = reportP2.toJasperPrint();
		jasperPrintList.add(jasperPrint2);
		JasperPrint jasperPrint3 = reportP3.toJasperPrint();
		jasperPrintList.add(jasperPrint3);
		
	//	String path ="C:\\Users\\antonio.dicivita\\Desktop\\";
		String path = Costanti.PATH_FOLDER+"\\"+misura.getIntervento().getNomePack()+"\\"+misura.getIntervento().getNomePack()+"_"+misura.getIntervento_dati().getId()+""+misura.getStrumento().get__id()+".pdf";
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		certificato.setNomeCertificato(misura.getIntervento().getNomePack()+"_"+misura.getIntervento_dati().getId()+""+misura.getStrumento().get__id()+".pdf");
		certificato.setDataCreazione(new Date());
		certificato.setStato(new StatoCertificatoDTO(2));		
		session.update(certificato);
		
	}
	
	
	
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport(ArrayList<LatPuntoLivellaDTO> lista_punti) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Tacca","Tacca", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(40));
	 		report.addColumn(col.column("Valore indicato livella in taratura","val_nominale_tratto_mm", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 		report.addColumn(col.column("Correzione cumulativa dal valore di riferimento","correzione_cumulativa_mm", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 		report.addColumn(col.column("Valore indicato livella in taratura","val_nominale_tratto_sec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 		report.addColumn(col.column("Correzione cumulativa dal valore di riferimento","correzione_cumulativa_sec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSource(Utility.ordinaPuntiLivella(lista_punti)));
	 		
	 		report.highlightDetailEvenRows();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	private JRDataSource createDataSource(ArrayList<LatPuntoLivellaDTO> lista_punti)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
			listaCodici = new String[5];
			
			listaCodici[0]="Tacca";
			listaCodici[1]="val_nominale_tratto_mm";
			listaCodici[2]="correzione_cumulativa_mm";
			listaCodici[3]="val_nominale_tratto_sec";
			listaCodici[4]="correzione_cumulativa_sec";		

			dataSource = new DRDataSource(listaCodici);
			
			int i = 0;
			for (LatPuntoLivellaDTO punto : lista_punti) {
					
					if(punto!=null)
					{
						ArrayList<String> arrayPs = new ArrayList<String>();
						if(punto.getRif_tacca()!=0 && punto.getSemisc() != null && punto.getSemisc().equals("SX")) {
							arrayPs.add("-"+String.valueOf(punto.getRif_tacca()));
						}else {
							arrayPs.add(String.valueOf(punto.getRif_tacca()));	
						}
						
						if(punto.getValore_nominale_tratto()!=null) {
							arrayPs.add(String.valueOf(punto.getValore_nominale_tratto().setScale(2, RoundingMode.HALF_UP)));	
						}else {
							arrayPs.add("");
						}
						if(punto.getMedia_corr_mm()!=null && punto.getValore_nominale_tratto()!=null) {
							arrayPs.add(String.valueOf((punto.getMedia_corr_mm().subtract(punto.getValore_nominale_tratto())).setScale(3, RoundingMode.HALF_UP)));	
						}else {
							arrayPs.add("");
						}
						if(punto.getValore_nominale_tratto_sec()!=null) {
							arrayPs.add(String.valueOf(punto.getValore_nominale_tratto_sec().setScale(2, RoundingMode.HALF_UP)));	
						}else {
							arrayPs.add("");
						}
						if(punto.getValore_nominale_tratto_sec()!=null && punto.getMedia_corr_sec()!=null) {
							arrayPs.add(String.valueOf((punto.getMedia_corr_sec().subtract(punto.getValore_nominale_tratto_sec())).setScale(3, RoundingMode.HALF_UP)));	
						}else {
							arrayPs.add("");
						}
						
		 				Object[] listaValori = arrayPs.toArray();
		 				if(i==0) {
		 					Object[] firstRow = {"", "mm/m", "mm/m", "sec", "sec"};
		 					dataSource.add(firstRow);		
		 				}		 				
				         dataSource.add(listaValori);				 
				         i++;
					}				
				}
	 		    return dataSource;
	 	}
	
	
//	public static void main(String[] args) throws HibernateException, Exception {
//		new ContextListener().configCostantApplication();
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
//		
//		LatMisuraDTO misura = GestioneLivellaBollaBO.getMisuraLivellaById(1, session);
//			new CreaCertificatoLivellaBolla(misura, session);
//			session.close();
//			System.out.println("FINITO");
//	}
	
	
	
}
