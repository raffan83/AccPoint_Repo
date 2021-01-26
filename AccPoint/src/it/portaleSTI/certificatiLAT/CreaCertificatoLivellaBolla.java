package it.portaleSTI.certificatiLAT;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReportLAT.PivotTemplateLAT;
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneLivellaBollaBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
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

	public File file;
	public CreaCertificatoLivellaBolla(CertificatoDTO certificato, LatMisuraDTO misura, InputStream is, UtenteDTO utente, Session session) throws Exception {
		
		build(certificato, misura, is, utente, session);
	}
	
	
	private void build(CertificatoDTO certificato, LatMisuraDTO misura, InputStream inputStream, UtenteDTO utente, Session session) throws Exception {
		
		InputStream is =  PivotTemplateLAT.class.getResourceAsStream("LivellaBollaP1.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		/*Intestazione P1*/
		report.addParameter("immagine_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		report.addParameter("immagine_sti",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));	
		report.addParameter("immagine_ilac",PivotTemplateLAT_Image.class.getResourceAsStream("ilac.jpg"));	
		
		String n_certificato="";
		
		
		if(misura.getnCertificato()!=null && misura.getnCertificato().length()>0) {
			n_certificato=misura.getnCertificato();	
		}else{
			
			n_certificato ="LAT172"+misura.getMisura_lat().getSigla()+paddingZero(misura.getMisura_lat().getSeq())+"/"+Utility.getCurrentYear(2);
			misura.setnCertificato(n_certificato);
			misura.getMisura_lat().setSeq(misura.getMisura_lat().getSeq()+1);
			certificato.getMisura().setnCertificato(n_certificato);
			session.update(certificato.getMisura());
			session.update(misura.getMisura_lat());
			session.update(misura);
			
		}
		
		report.addParameter("numero_certificato",n_certificato);
		
		SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd"); 
		
		report.addParameter("data_emissione", dt.format(new Date()));
		report.addParameter("numero_pagine","3");
		CommessaDTO commessa = GestioneCommesseBO.getCommessaById(misura.getIntervento().getIdCommessa());
		
		if(commessa!=null && commessa.getID_ANAGEN_NOME()!=null) {
			report.addParameter("cliente", commessa.getID_ANAGEN_NOME());	
		}else {
			report.addParameter("cliente", "");
		}
		
		ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(commessa.getID_ANAGEN()));
		
				
		String indirizzo="";
		String cap="";
		String citta="";
		String provincia="";
		
		if( cliente.getIndirizzo()!=null) {
			indirizzo = cliente.getIndirizzo();				
			}
			if(cliente.getCap()!=null) {
				cap = cliente.getCap();
			}
			if(cliente.getCitta()!=null) {
				citta = cliente.getCitta();
			}
			if(cliente.getProvincia()!=null && !cliente.getProvincia().equals("")) {
				provincia = " ("+ cliente.getProvincia()+")";
			}
		
			if(cliente!=null && cliente.getIndirizzo()!=null) {
				report.addParameter("indirizzo_cliente", indirizzo + ", " + cap + ", "+citta +provincia);
			}else {
				report.addParameter("indirizzo_cliente", "");
			}
		
//		if(commessa!=null && commessa.getINDIRIZZO_PRINCIPALE()!=null) {
//			ClienteDTO
//			
//			indirizzo = indirizzo +commessa.getINDIRIZZO_PRINCIPALE() +", "+commessa.get
//			
//			report.addParameter("indirizzo_cliente", commessa.getINDIRIZZO_PRINCIPALE());
//		}else{
//			report.addParameter("indirizzo_cliente", "");
//		}

		if(commessa!=null && commessa.getNOME_UTILIZZATORE()!=null) {
			report.addParameter("destinatario", commessa.getNOME_UTILIZZATORE());	
		}else {
				report.addParameter("destinatario", "");		
			}
		
		ClienteDTO cliente_util = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(commessa.getID_ANAGEN_UTIL()));
		
		
		String indirizzo_util="";
		String cap_util="";
		String citta_util="";
		String provincia_util="";
		
		if( cliente_util.getIndirizzo()!=null) {
			indirizzo_util = cliente_util.getIndirizzo();				
			}
			if(cliente_util.getCap()!=null) {
				cap_util = cliente_util.getCap();
			}
			if(cliente_util.getCitta()!=null) {
				citta_util = cliente_util.getCitta();
			}
			if(cliente_util.getProvincia()!=null && !cliente_util.getProvincia().equals("")) {
				provincia_util =" (" +cliente_util.getProvincia()+")";
			}
		
			if(cliente_util!=null && cliente_util.getIndirizzo()!=null) {
				report.addParameter("indirizzo_destinatario", indirizzo_util + ", " + cap_util + ", "+citta_util + provincia_util);
			}else {
				report.addParameter("indirizzo_destinatario", "");
			}
	
//		if(commessa!=null && commessa.getINDIRIZZO_UTILIZZATORE()!=null)
//		{
//			report.addParameter("indirizzo_destinatario", commessa.getINDIRIZZO_UTILIZZATORE());
//		}else
//		{
//				report.addParameter("indirizzo_destinatario", "");
//		}			
		
//		if(commessa.getN_ORDINE()!=null)
//		{
//			report.addParameter("richiesta", commessa.getN_ORDINE());
//		}else 
//		{
//			report.addParameter("richiesta","");
//		}
		report.addParameter("oggetto", "Livella a bolla d'aria");
//		report.addParameter("data", dt.format(commessa.getDT_COMMESSA()));
		
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
			String matricola = misura.getStrumento().getMatricola();
			
			if(misura.getStrumento().getCodice_interno()!=null) {
				matricola = matricola +" - "+misura.getStrumento().getCodice_interno();
			}
			report.addParameter("matricola", matricola);	
		}else {
			report.addParameter("matricola", "");
		}
		
		String data_ricevimento = GestioneMagazzinoBO.getDataRicevimentoItem(misura.getStrumento(),session);
		
		report.addParameter("data_ricevimento_oggetto",data_ricevimento);
		
		if(misura.getData_misura()!=null) {
			report.addParameter("data_misure", dt.format(misura.getData_misura()));
		}else {
			report.addParameter("data_misure", "");
		}
		if(misura.getMisura_lat()!=null) {
			if(misura.getMisura_lat().getSigla_registro()!=null) {
				report.addParameter("registro_laboratorio",  misura.getIntervento().getId()+"_"+misura.getId()+"_"+misura.getStrumento().get__id());		
			}else {
				report.addParameter("registro_laboratorio",  "");
			}
		}else {
			report.addParameter("registro_laboratorio", "");
		}
		
		InputStream is2 =  PivotTemplateLAT.class.getResourceAsStream("LivellaBollaP2.jrxml");
		
		JasperReportBuilder reportP2 = DynamicReports.report();
		
		/*Intestazione P2*/
		reportP2.addParameter("immagine_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		reportP2.addParameter("immagine_sti",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));	
		reportP2.addParameter("immagine_ilac",PivotTemplateLAT_Image.class.getResourceAsStream("ilac.jpg"));	
		
		reportP2.setTemplateDesign(is2);
		reportP2.setTemplate(Templates.reportTemplate);

		reportP2.setDataSource(new JREmptyDataSource());		
		reportP2.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		reportP2.addParameter("numero_certificato", n_certificato);	
		
				
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
			String matricola = misura.getStrumento().getMatricola();
			
			if(misura.getStrumento().getCodice_interno()!=null) {
				matricola = matricola +" - "+misura.getStrumento().getCodice_interno();
			}
			reportP2.addParameter("matricola", matricola);	
		}else {
			reportP2.addParameter("matricola", "");
		}
		
		reportP2.addParameter("um", "mm/m");
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
			if(misura.getRif_campione().getAttivita_di_taratura()!=null && !misura.getRif_campione().getAttivita_di_taratura().equals("INTERNA")) {
				certificato_campione= certificato_campione+" ("+misura.getRif_campione().getAttivita_di_taratura()+")";
			}else {
				certificato_campione= certificato_campione+" (S.T.I. SVILUPPO TECNOLOGIE INDUSTRIALI S.R.L.)";	
			}
			
		}else {
			reportP2.addParameter("campione_riferimento", "");
		}
		if(misura.getRif_campione_lavoro()!=null) {
			reportP2.addParameter("campione_lavoro", misura.getRif_campione_lavoro().getCodice());
			if(!misura.getRif_campione().getCodice().equals(misura.getRif_campione_lavoro().getCodice())) {
				certificato_campione = certificato_campione + "; " + misura.getRif_campione_lavoro().getNumeroCertificato();
				if(misura.getRif_campione_lavoro().getAttivita_di_taratura()!=null && !misura.getRif_campione_lavoro().getAttivita_di_taratura().equals("INTERNA")) {
					certificato_campione= certificato_campione+" ("+misura.getRif_campione_lavoro().getAttivita_di_taratura()+")";
				}else {
					certificato_campione= certificato_campione+" (S.T.I. SVILUPPO TECNOLOGIE INDUSTRIALI S.R.L.)";	
				}
			}
		}else {
			reportP2.addParameter("campione_lavoro", "");
		}		
		
		reportP2.addParameter("certificati_campione", certificato_campione);
		
		if(misura.getTemperatura()!=null) {
			reportP2.addParameter("temperatura", "("+misura.getTemperatura().setScale(1, RoundingMode.HALF_UP).toPlainString().replaceAll("\\.",",")+" ± 1) °C");	
		}else {
			reportP2.addParameter("temperatura", "(20 ± 1) °C");
		}
		if(misura.getUmidita()!=null) {
			reportP2.addParameter("umidita", "("+misura.getUmidita().setScale(1, RoundingMode.HALF_UP).toPlainString().replaceAll("\\.",",")+" ± 10) %");	
		}else {
			reportP2.addParameter("umidita", "(50 ± 10) %");
		}
		
		
		ArrayList<LatPuntoLivellaDTO> lista_punti = GestioneLivellaBollaBO.getListaPuntiLivella(misura.getId(), session);
		if(misura.getIncertezza_estesa()!=null) {
			reportP2.addParameter("incertezza_estesa", misura.getIncertezza_estesa().setScale(3, RoundingMode.HALF_EVEN).toPlainString().replaceAll("\\.",","));	
		}else {
			reportP2.addParameter("incertezza_estesa", "");
		}
		
		String val_medio_divisione = String.valueOf(Utility.getAverageLivella(lista_punti, null, 0).setScale(3, RoundingMode.HALF_EVEN).toPlainString().replaceAll("\\.",","));
		
		if(val_medio_divisione!=null) {
			reportP2.addParameter("val_medio_divisione", val_medio_divisione);	
		}else {
			reportP2.addParameter("val_medio_divisione", "");
		}
		
		if(misura.getIncertezza_media()!=null) {
			reportP2.addParameter("incertezza_ass_media", misura.getIncertezza_media().setScale(3, RoundingMode.HALF_EVEN).toPlainString().replaceAll("\\.",","));	
		}else {
			reportP2.addParameter("incertezza_ass_media", "");
		}

		//File image = new File(inputStream);


		//if(image!=null) {
			reportP2.addParameter("immagine",inputStream);	
		//}


		InputStream is3 =  PivotTemplateLAT.class.getResourceAsStream("LivellaBollaP3.jrxml");
		JasperReportBuilder reportP3 = DynamicReports.report();
		reportP3.setTemplateDesign(is3);
		reportP3.setTemplate(Templates.reportTemplate);
		
		/*Intestazione P3*/
		reportP3.addParameter("immagine_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		reportP3.addParameter("immagine_sti",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));	
		reportP3.addParameter("immagine_ilac",PivotTemplateLAT_Image.class.getResourceAsStream("ilac.jpg"));	
		

		reportP3.setDataSource(new JREmptyDataSource());		
		reportP3.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		reportP3.addParameter("numero_certificato", n_certificato);
		
		if(misura.getStrumento().getNote()!=null) {
			reportP3.addParameter("note", misura.getStrumento().getNote());
		}else {
			reportP3.addParameter("note", "");
		}
		
		BigDecimal sensibilita = misura.getSensibilita().stripTrailingZeros();
		
		int scala = sensibilita.scale(); 
		
		SubreportBuilder subreport; 
		subreport = cmp.subreport(getTableReport(lista_punti, scala));
		
	//	reportP3.addDetail(subreport).;
		reportP3.detail(cmp.horizontalList(cmp.horizontalGap(80),subreport));
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		JasperPrint jasperPrint2 = reportP2.toJasperPrint();
		jasperPrintList.add(jasperPrint2);
		JasperPrint jasperPrint3 = reportP3.toJasperPrint();
		jasperPrintList.add(jasperPrint3);
		
	//	String path ="C:\\Users\\raffaele.fantini\\Desktop\\TestCeftificatoLAT.pdf";
		String path = Costanti.PATH_FOLDER+"\\"+misura.getIntervento().getNomePack()+"\\"+misura.getIntervento().getNomePack()+"_"+misura.getIntervento_dati().getId()+""+misura.getStrumento().get__id()+".pdf";
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		this.file = new File(path);
		
		certificato.setNomeCertificato(misura.getIntervento().getNomePack()+"_"+misura.getIntervento_dati().getId()+""+misura.getStrumento().get__id()+".pdf");
		certificato.setDataCreazione(new Date());
		certificato.setStato(new StatoCertificatoDTO(2));	
		certificato.setUtenteApprovazione(utente);
		session.update(certificato);
		
	}
	
	private String paddingZero(int seq) {
		
		int size=4-(""+seq).length();
		String pad="";
		for (int i = 0; i <size; i++) {
			
			pad=pad+"0";
		}
		
		return pad+seq;
	}


	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport(ArrayList<LatPuntoLivellaDTO> lista_punti,int scala) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Tacca","Tacca", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(40));
	 		report.addColumn(col.column("Valore indicato livella in taratura","val_nominale_tratto_mm", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 		report.addColumn(col.column("Correzione cumulativa dal valore di riferimento","correzione_cumulativa_mm", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 		report.addColumn(col.column("Valore indicato livella in taratura","val_nominale_tratto_sec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 		report.addColumn(col.column("Correzione cumulativa dal valore di riferimento","correzione_cumulativa_sec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
	 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSource(Utility.ordinaPuntiLivella(lista_punti), scala));
	 		
	 		report.highlightDetailEvenRows();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	private JRDataSource createDataSource(ArrayList<LatPuntoLivellaDTO> lista_punti, int scala)throws Exception {
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
							arrayPs.add(String.valueOf(punto.getValore_nominale_tratto().setScale(scala, RoundingMode.HALF_UP).toPlainString().replaceAll("\\.",",")));	
						}else {
							arrayPs.add("");
						}
						BigDecimal cor_mm = null;
						if(punto.getMedia_corr_mm()!=null && punto.getValore_nominale_tratto()!=null) {
							cor_mm = punto.getMedia_corr_mm().subtract(punto.getValore_nominale_tratto()).setScale((scala+1), RoundingMode.HALF_UP);
							arrayPs.add(String.valueOf((punto.getMedia_corr_mm().subtract(punto.getValore_nominale_tratto())).setScale((scala+1), RoundingMode.HALF_UP).toPlainString().replaceAll("\\.",",")));	
						}else {
							arrayPs.add("");
						}
						if(punto.getValore_nominale_tratto_sec()!=null) {
							arrayPs.add(String.valueOf(punto.getValore_nominale_tratto_sec().setScale(scala, RoundingMode.HALF_UP).toPlainString().replaceAll("\\.",",")));	
						}else {
							arrayPs.add("");
						}
						if(punto.getValore_nominale_tratto_sec()!=null && punto.getMedia_corr_sec()!=null) {
							
							if(cor_mm!= null && cor_mm.equals(BigDecimal.ZERO.setScale(scala+1))) {
								arrayPs.add("0,0");
							}else {
								arrayPs.add(String.valueOf((punto.getMedia_corr_sec().subtract(punto.getValore_nominale_tratto_sec())).setScale(1, RoundingMode.HALF_UP).toPlainString().replaceAll("\\.",",")));	
							}							
								
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
//		LatMisuraDTO misura = GestioneLivellaBollaBO.getMisuraLivellaById(7, session);
//		CertificatoDTO certificato=GestioneCertificatoBO.getCertificatoById("510");
//		String pathImage="C:\\Users\\raffaele.fantini\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\livella.png";
//			new CreaCertificatoLivellaBolla(certificato,misura,pathImage, session);
//			session.getTransaction().commit();
//			session.close();
//			System.out.println("FINITO");
//	}

	
	
	
}
