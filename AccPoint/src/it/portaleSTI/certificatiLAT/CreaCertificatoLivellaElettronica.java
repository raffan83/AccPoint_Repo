package it.portaleSTI.certificatiLAT;

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
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneLivellaBollaBO;
import it.portaleSTI.bo.GestioneLivellaElettronicaBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreaCertificatoLivellaElettronica {
	
	public File file;
	
	public CreaCertificatoLivellaElettronica(CertificatoDTO certificato, LatMisuraDTO misura, UtenteDTO utente, Session session) throws Exception {
				
		build(certificato, misura, utente, session);
	}

	
	private void build(CertificatoDTO certificato, LatMisuraDTO misura, UtenteDTO utente, Session session) throws Exception {
		
		InputStream is =  PivotTemplateLAT.class.getResourceAsStream("LivellaElettronica_P1.jrxml");
		
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
		
		
		
//		if(commessa!=null && commessa.getANAGEN_INDR_INDIRIZZO()!=null && !commessa.getANAGEN_INDR_INDIRIZZO().equals("")) {
//			report.addParameter("indirizzo_cliente", commessa.getANAGEN_INDR_INDIRIZZO());
//		}else{
//			if(commessa.getK2_ANAGEN_INDR()==0) {
//				report.addParameter("indirizzo_cliente", commessa.getINDIRIZZO_PRINCIPALE());	
//			}else {
//				report.addParameter("indirizzo_cliente", "");	
//			}
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
		
		if(commessa.getK2_ANAGEN_INDR_UTIL()!=0) {
			
			ArrayList<SedeDTO> listaSedi = (ArrayList<SedeDTO>) GestioneAnagraficaRemotaBO.getListaSedi();
			
			SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, commessa.getK2_ANAGEN_INDR_UTIL(), commessa.getID_ANAGEN_UTIL());
			
			if( sede.getIndirizzo()!=null) {
				indirizzo_util = sede.getIndirizzo();				
				}
				if(sede.getCap()!=null) {
					cap_util = sede.getCap();
				}
				if(sede.getComune()!=null) {
					citta_util = sede.getComune();
				}
				if(sede.getSiglaProvincia()!=null && !sede.getSiglaProvincia().equals("")) {
					provincia_util =" (" +sede.getSiglaProvincia()+")";
				}
				
				if(sede!=null && sede.getIndirizzo()!=null) {
					report.addParameter("indirizzo_destinatario", indirizzo_util + ", " + cap_util + ", "+citta_util + provincia_util);
				}else {
					report.addParameter("indirizzo_destinatario", "");
				}
			
		}else {
			
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
		}
		
		
	
//		if(commessa!=null && commessa.getINDIRIZZO_UTILIZZATORE()!=null)
//		{
//			report.addParameter("indirizzo_destinatario", commessa.getINDIRIZZO_UTILIZZATORE());
//		}else
//		{
//				report.addParameter("indirizzo_destinatario", "");
//		}			
		
		if(commessa.getN_ORDINE()!=null)
		{
			report.addParameter("richiesta", commessa.getN_ORDINE());
		}else 
		{
			report.addParameter("richiesta","");
		}
		
		report.addParameter("oggetto", "Livella elettronica");
		report.addParameter("data", dt.format(commessa.getDT_COMMESSA()));
		
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
		
		if (data_ricevimento.length()==0) {data_ricevimento="\\";}
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
		report.addParameter("numero_pagine","2");
		
		InputStream is2 =  PivotTemplateLAT.class.getResourceAsStream("LivellaElettronica_P2.jrxml");
		
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
		
		reportP2.addParameter("um", "\"");
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
			reportP2.addParameter("campione_riferimento", misura.getRif_campione().getCodice()  +" "+misura.getRif_campione().getNome());
			certificato_campione = certificato_campione + misura.getRif_campione().getNumeroCertificato();
			if(!misura.getRif_campione().getAttivita_di_taratura().equals("INTERNA")) {
				certificato_campione= certificato_campione+" ("+misura.getRif_campione().getAttivita_di_taratura()+")";
			}else {
				certificato_campione= certificato_campione+" (S.T.I. SVILUPPO TECNOLOGIE INDUSTRIALI S.R.L.)";	
			}
		}else {
			reportP2.addParameter("campione_riferimento", "");
		}
//		if(misura.getRif_campione_lavoro()!=null) {
//			reportP2.addParameter("campione_lavoro", misura.getRif_campione_lavoro().getCodice());
//			if(!misura.getRif_campione().getCodice().equals(misura.getRif_campione_lavoro().getCodice())) {
//				certificato_campione = certificato_campione + "; " + misura.getRif_campione_lavoro().getNumeroCertificato();
//				if(misura.getRif_campione().getAttivita_di_taratura()!=null && !misura.getRif_campione().getAttivita_di_taratura().equals("")) {
//					if(!misura.getRif_campione_lavoro().getAttivita_di_taratura().equals("INTERNA")) {
//						certificato_campione= certificato_campione+" ("+misura.getRif_campione().getAttivita_di_taratura()+")";
//					}else {
//						certificato_campione= certificato_campione+" (S.T.I. SVILUPPO TECNOLOGIE INDUSTRIALI S.R.L.)";	
//					}
//					
//				}
//			}
//			
//		}else {
//			reportP2.addParameter("campione_lavoro", "");
//		}		
		
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
		
		if(misura.getUnita_formato()!=null) {
			reportP2.addParameter("unita_formato",Utility.changeDotComma(misura.getUnita_formato().stripTrailingZeros().toPlainString()+" \""));
		}else {
			reportP2.addParameter("unita_formato","");	
		}
		
		if(misura.getSensibilita()!=null) {
			reportP2.addParameter("risoluzione",Utility.changeDotComma(misura.getSensibilita().stripTrailingZeros().toPlainString()+" \""));
		}else {
			reportP2.addParameter("risoluzione", "");	
		}
		
		ArrayList<LatPuntoLivellaElettronicaDTO> lista_punti = GestioneLivellaElettronicaBO.getListaPuntiLivella(misura.getId(), session);
		if(misura.getIncertezza_estesa()!=null) {
			reportP2.addParameter("incertezza_estesa", misura.getIncertezza_estesa().setScale(1, RoundingMode.HALF_EVEN).toPlainString().replaceAll("\\.",","));	
		}else {
			reportP2.addParameter("incertezza_estesa", "");
		}
		
//		if(misura.getIntervento_dati().getUtente().getNominativo()!=null) {
//			reportP2.addParameter("operatore", misura.getIntervento_dati().getUtente().getNominativo());
//		}else {
//			reportP2.addParameter("operatore", "");
//		}
		
		reportP2.addParameter("cell00", "/\"");
		reportP2.addParameter("cell10", "/\"");
		for(int i = 0; i<lista_punti.size();i++) {
			if(lista_punti.get(i).getValore_nominale()!=null) {
				reportP2.addParameter("cell"+0+(i+1), Utility.changeDotComma(lista_punti.get(i).getValore_nominale().setScale(0,RoundingMode.HALF_UP).toString()));	
			}else {
				reportP2.addParameter("cell"+0+(i+1), "");
			}
			
			if(lista_punti.get(i).getScostamentoOff()!=null) {
				reportP2.addParameter("cell"+1+(i+1), Utility.changeDotComma(lista_punti.get(i).getScostamentoOff().setScale(1,RoundingMode.HALF_UP).toString()));	
			}else {
				reportP2.addParameter("cell"+1+(i+1), "");
			}
			
		}
		
		if(misura.getStrumento().getNote()!=null) {
			reportP2.addParameter("note", misura.getStrumento().getNote());
		}else {
			reportP2.addParameter("note", "");
		}
		
		reportP2.setDetailSplitType(SplitType.IMMEDIATE);
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		JasperPrint jasperPrint2 = reportP2.toJasperPrint();
		jasperPrintList.add(jasperPrint2);
		
		//String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestCeftificatoLAT.pdf";
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

	
	
//	public static void main(String[] args) throws HibernateException, Exception {
//	new ContextListener().configCostantApplication();
//	Session session=SessionFacotryDAO.get().openSession();
//	session.beginTransaction();
//	
//	LatMisuraDTO misura = GestioneLivellaBollaBO.getMisuraLivellaById(10, session);
//	CertificatoDTO certificato=GestioneCertificatoBO.getCertificatoById("1");
//	
//		new CreaCertificatoLivellaElettronica(certificato,misura, session);
//		session.getTransaction().commit();
//		session.close();
//		System.out.println("FINITO");
//}
//	
}
