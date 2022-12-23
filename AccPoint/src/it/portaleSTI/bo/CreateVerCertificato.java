package it.portaleSTI.bo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.itextpdf.text.BaseColor;
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
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.GestioneVerMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerCodiceDocumentoDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;


public class CreateVerCertificato {
	
	public CreateVerCertificato(VerMisuraDTO misura, List<SedeDTO> listaSedi, boolean conforme, int motivo,  Session session) throws Exception {
		
		build(misura, listaSedi,conforme, motivo, session);
	}
	
	
	private void build(VerMisuraDTO misura,List<SedeDTO> listaSedi, boolean conforme, int motivo, Session session) throws Exception {
		
		InputStream is = null;
		

		if(misura.getVerStrumento().getTipo().getId()==1 || misura.getVerStrumento().getTipo().getId()==5) {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoCSP1.jrxml");
		}else if(misura.getVerStrumento().getTipo().getId()==2) {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoDPP1.jrxml");
		}else if(misura.getVerStrumento().getTipo().getId()==4) {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoCorredoEsternoP1.jrxml");
		}		
		else {
			is = PivotTemplate.class.getResourceAsStream("VerCertificatoCPP1.jrxml");
		}
	
		InputStream is2 =  null;
		
		 if(misura.getVerStrumento().getTipo().getId()==4) {
			 is2 = PivotTemplate.class.getResourceAsStream("VerCertificatoCorredoEsternoP2.jrxml");
		 }else {
			 is2 = PivotTemplate.class.getResourceAsStream("VerCertificatoP2NoFirma.jrxml");
		 }
		
		
		JasperReportBuilder report = DynamicReports.report();
		JasperReportBuilder reportP2 = DynamicReports.report();

		report.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver.png"));
		//report.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver_NEW.png"));
		report.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("logo_sti_indirizzo_ver.png"));	

		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			
		ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
	
		SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
		
		if(misura.getNumeroAttestato()!=null) {
			report.addParameter("numero_certificato", misura.getNumeroAttestato().replace("_", " - "));
		}else {
			
			
			String codice_attestato = GestioneVerMisuraBO.getCodiceAttestatoRapporto(misura,  session);
			
			report.addParameter("numero_certificato", codice_attestato.replace("_", " - "));
		}
		
		report.addParameter("allegato", misura.getNumeroRapporto().replace("_", " - ")); 
		
		report.addParameter("registro_laboratorio", ""); //MANCA REGISTRO
		
		if(misura.getDataVerificazione()!=null) {
			report.addParameter("data_verifica", df.format(misura.getDataVerificazione()));
		}
		
		if(cliente!=null) {
			report.addParameter("denominazione_titolare", cliente.getNome());
		}else {
			report.addParameter("denominazione_titolare", "");
		}
		
		
		if(misura.getVerStrumento().getLista_legalizzazione_bilance()!=null && misura.getVerStrumento().getLista_legalizzazione_bilance().size()>0) {
			
			report.addParameter("tipo_approvazione_header","Tipo di approvazione");
			report.addParameter("numero_provvedimento_header", "Numero \n provvedimento");		
			
			report.addParameter("data_provvedimento_header", "Data");
			report.addParameter("legalizzazione_title", "Dati relativi all'accertamento della conformità");
			report.addParameter("legalizzazione_title_small", "");
		
			int index = 1;
			for (VerLegalizzazioneBilanceDTO legalizzazione : misura.getVerStrumento().getLista_legalizzazione_bilance()) {
				if(index<5) {
					report.addParameter("tipo_approvazione_"+index, legalizzazione.getTipo_approvazione().getDescrizione());
					report.addParameter("numero_provvedimento_"+index, legalizzazione.getNumero_provvedimento());
					if(legalizzazione.getTipo_approvazione().getId()==1) {
						report.addParameter("data_provvedimento_"+index, df.format(legalizzazione.getData_provvedimento()));
					}else {
						report.addParameter("data_provvedimento_"+index, "");
						report.setParameter("data_provvedimento_header", "");
						report.setParameter("legalizzazione_title_small", "Dati relativi all'accertamento della conformità");
						report.setParameter("legalizzazione_title", "");
					}
					index++;
				}
			}
			if(index == 2) {
				report.addParameter("tipo_approvazione_2","");
				report.addParameter("numero_provvedimento_2", "");
				report.addParameter("data_provvedimento_2", "");
				
				report.addParameter("tipo_approvazione_3","");
				report.addParameter("numero_provvedimento_3", "");
				report.addParameter("data_provvedimento_3", "");
				
				report.addParameter("tipo_approvazione_4","");
				report.addParameter("numero_provvedimento_4", "");
				report.addParameter("data_provvedimento_4", "");
			}
			
			if(index == 3) {		
				
				report.addParameter("tipo_approvazione_3","");
				report.addParameter("numero_provvedimento_3", "");
				report.addParameter("data_provvedimento_3", "");
				
				report.addParameter("tipo_approvazione_4","");
				report.addParameter("numero_provvedimento_4", "");
				report.addParameter("data_provvedimento_4", "");
			}
			
			
			if(index == 4) {		
				
				report.addParameter("tipo_approvazione_4","");
				report.addParameter("numero_provvedimento_4", "");
				report.addParameter("data_provvedimento_4", "");
			}
			
		}else {
			
			report.addParameter("tipo_approvazione_header","");
			report.addParameter("numero_provvedimento_header", "");
			report.addParameter("data_provvedimento_header", "");
			report.addParameter("legalizzazione_title", "");
			report.addParameter("legalizzazione_title_small","");
			report.addParameter("tipo_approvazione_1","");
			report.addParameter("numero_provvedimento_1", "");
			report.addParameter("data_provvedimento_1", "");
			
			report.addParameter("tipo_approvazione_2","");
			report.addParameter("numero_provvedimento_2", "");
			report.addParameter("data_provvedimento_2", "");
			
			report.addParameter("tipo_approvazione_3","");
			report.addParameter("numero_provvedimento_3", "");
			report.addParameter("data_provvedimento_3", "");
		
			report.addParameter("tipo_approvazione_4","");
			report.addParameter("numero_provvedimento_4", "");
			report.addParameter("data_provvedimento_4", "");
			
		}
		
		
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
			if(cliente.getProvincia()!=null) {
				provincia = cliente.getProvincia();
			}
		
		
		if(cliente!=null && cliente.getIndirizzo()!=null) {
			report.addParameter("indirizzo", indirizzo + ", " + cap + ", "+citta +" ("+ provincia+")");
		}else {
			report.addParameter("indirizzo", "");
		}
		
		if(cliente!=null && cliente.getPartita_iva()!=null) {
			report.addParameter("partita_iva", cliente.getPartita_iva());
		}else {
			if(cliente!=null && cliente.getCf()!=null) {
				report.addParameter("partita_iva", cliente.getCf());
			}else {
				report.addParameter("partita_iva", "");
			}			
		}
			
		String indirizzo_sd="";
		String cap_sd="";
		String citta_sd="";
		String provincia_sd="";
		
		if(sede!=null) {
			if( sede.getIndirizzo()!=null) {
				indirizzo_sd = sede.getIndirizzo();				
				}
				if(sede.getCap()!=null) {
					cap_sd = sede.getCap();
				}
				if(sede.getComune()!=null) {
					citta_sd = sede.getComune();
				}
				if(sede.getSiglaProvincia()!=null) {
					provincia_sd = sede.getSiglaProvincia();
				}
		}else {
			if( cliente.getIndirizzo()!=null) {
				indirizzo_sd = cliente.getIndirizzo();				
				}
				if(cliente.getCap()!=null) {
					cap_sd = cliente.getCap();
				}
				if(cliente.getCitta()!=null) {
					citta_sd = cliente.getCitta();
				}
				if(cliente.getProvincia()!=null) {
					provincia_sd = cliente.getProvincia();
				}
		}
	
		
		report.addParameter("indirizzo_servizio", indirizzo_sd + ", " + cap_sd + ", "+citta_sd +" ("+ provincia_sd +")");
		
		
		if(cliente!=null && cliente.getTelefono()!=null) {
			report.addParameter("telefono", cliente.getTelefono());
		}else {
			report.addParameter("telefono", "");
		}
		if(sede!=null && sede.getN_REA()!=null) {
			report.addParameter("rea", sede.getN_REA());
		}else {
			if(cliente!=null && cliente.getNumeroREA()!=null) {
				report.addParameter("rea", cliente.getNumeroREA());	
			}else {
				report.addParameter("rea", "");	
			}
		}
		if(misura.getVerStrumento().getDenominazione()!=null) {
			report.addParameter("denominazione_strumento", misura.getVerStrumento().getDenominazione());
		}else{
			report.addParameter("denominazione_strumento", "");
		}
		
		if(misura.getVerStrumento().getCostruttore()!=null) {
			report.addParameter("costruttore", misura.getVerStrumento().getCostruttore());
		}else{
			report.addParameter("costruttore", "");
		}
		
		if(misura.getVerStrumento().getModello()!=null) {
			report.addParameter("modello", misura.getVerStrumento().getModello());
		}else{
			report.addParameter("modello", "");
		}
		
		if(misura.getVerStrumento().getMatricola()!=null) {
			report.addParameter("matricola", misura.getVerStrumento().getMatricola());
		}else{
			report.addParameter("matricola", "");
		}
		
		if(misura.getVerStrumento().getClasse()!=0) {
			report.addParameter("classe_precisione",getClassePrecisione(misura.getVerStrumento().getClasse()));
		}else{
			report.addParameter("classe_precisione", "");
		}
		
		if(misura.getVerStrumento().getTipo()!=null && misura.getVerStrumento().getTipo().getDescrizione()!=null) {
			report.addParameter("tipo", misura.getVerStrumento().getTipo().getDescrizione());
		}else{
			report.addParameter("tipo", "");
		}
		if(misura.getVerStrumento().getTipologia().getId()!=0) {
			report.addParameter("tipologia", misura.getVerStrumento().getTipologia().getDescrizione());
		}else{
			report.addParameter("tipologia", "");
		}
		if(misura.getVerStrumento().getUm()!=null) {
			report.addParameter("um", misura.getVerStrumento().getUm());
		}else{
			report.addParameter("um", "");
		}
		
		if(misura.getTipoRisposta()==0) {
			report.addParameter("tipo_data_marcatura", "Anno di fabbricazione:");
		}else {
			report.addParameter("tipo_data_marcatura", "Anno di Marcatura CE:");
		}
		
		if(misura.getVerStrumento().getAnno_marcatura_ce()!=0) {
			report.addParameter("anno_marcatura_ce", misura.getVerStrumento().getAnno_marcatura_ce());
		}else {
			report.addParameter("anno_marcatura_ce", "");
		}
		if(misura.getVerStrumento().getData_messa_in_servizio()!=null) {
			report.addParameter("data_messa_in_servizio", df.format(misura.getVerStrumento().getData_messa_in_servizio()));
		}else {
			report.addParameter("data_messa_in_servizio", "");
		}
		
		if(misura.getVerStrumento().getMasse_corredo()!=null) {
			report.addParameter("masse_corredo",misura.getVerStrumento().getMasse_corredo());
		}else{
			if(misura.getVerStrumento().getTipo().getId()==1|| misura.getVerStrumento().getTipo().getId()==4|| misura.getVerStrumento().getTipo().getId()==5) {
			report.addParameter("masse_corredo", "");
			}
		}
		
		if(misura.getNote_combinazioni()!=null) {
			
			String note = "";
			String [] array = misura.getNote_combinazioni().split("\\r?\\n");
			
			for(int i = 0; i<array.length;i++) {
				note += " ["+array[i]+"] -";
			}
			if(!note.equals("")) {
				note = note.substring(0, note.length()-1);
			}
			
			report.addParameter("combinazioni_campioni",note);
		}else{
			if(misura.getVerStrumento().getTipo().getId()==4) {
			report.addParameter("combinazioni_campioni", "");
			}
		}
		
		
		if(misura.getVerStrumento().getPortata_max_C1()!=null) {
			report.addParameter("portata_max_c1", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
		}else{
			report.addParameter("portata_max_c1", "");
		}
		
		if(misura.getVerStrumento().getPortata_min_C1()!=null) {
			report.addParameter("portata_min_c1", Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
		}else{
			report.addParameter("portata_min_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_ver_C1()!=null) {
			report.addParameter("divisione_verifica_c1", Utility.changeDotComma(misura.getVerStrumento().getDiv_ver_C1().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
		}else{
			report.addParameter("divisione_verifica_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_rel_C1()!=null) {
			report.addParameter("divisione_reale_c1", Utility.changeDotComma(misura.getVerStrumento().getDiv_rel_C1().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
		}else{
			report.addParameter("divisione_reale_c1", "");
		}
		
		if(misura.getVerStrumento().getNumero_div_C1()!=null) {
			report.addParameter("numero_divisioni_c1", Utility.changeDotComma(misura.getVerStrumento().getNumero_div_C1().stripTrailingZeros().toPlainString()));
		}else{
			report.addParameter("numero_divisioni_c1", "");
		}
		if(misura.getVerStrumento().getTipo().getId()!=1 && misura.getVerStrumento().getTipo().getId()!=4 && misura.getVerStrumento().getTipo().getId()!=5) {
			if(misura.getVerStrumento().getTipo().getId()==2) {
				
				if(misura.getVerStrumento().getPortata_max_C3()!=null && misura.getVerStrumento().getPortata_max_C3().compareTo(BigDecimal.ZERO)==1) {
					report.addParameter("portata_max", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
				}else{
					if(misura.getVerStrumento().getPortata_max_C2()!=null) {
						report.addParameter("portata_max",  Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());	
					}else {
						report.addParameter("portata_max",  "");
					}				
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null) {
					report.addParameter("portata_min", Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
				}else{
					report.addParameter("portata_min", "");
				}
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("campo_1", "(" +  Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros().toPlainString()) + "÷" +  Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros().toPlainString()) + ")" +  misura.getVerStrumento().getUm());	
				}else {
					report.addParameter("campo_1", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C2()!=null && misura.getVerStrumento().getPortata_max_C2()!=null) {
					report.addParameter("campo_2", "(" +  Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros().toPlainString()) + "÷" +  Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros().toPlainString()) + ")" + misura.getVerStrumento().getUm());
				}else {
					report.addParameter("campo_2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C3()!=null && misura.getVerStrumento().getPortata_max_C3()!=null && misura.getVerStrumento().getPortata_max_C3().compareTo(BigDecimal.ZERO)==1) {
					report.addParameter("campo_3", "(" + Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros().toPlainString()) + "÷" +  Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros().toPlainString()) + ")" + misura.getVerStrumento().getUm());	
				}else {
					report.addParameter("campo_3", "");
				}
				

			}	
			else if(misura.getVerStrumento().getTipo().getId()==3) {
				
				if(misura.getVerStrumento().getPortata_max_C2()!=null) {
					report.addParameter("portata_max_c2", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
				}else{
					report.addParameter("portata_max_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C2()!=null) {
					report.addParameter("portata_min_c2", Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
				}else{
					report.addParameter("portata_min_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_max_C3()!=null && misura.getVerStrumento().getPortata_max_C3().compareTo(BigDecimal.ZERO)==1) {
					report.addParameter("campo_pesatura_3", "Campo di pesatura 3");
					report.addParameter("portata_max_c3", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
				}else{
					report.addParameter("campo_pesatura_3", "");
					report.addParameter("portata_max_c3", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C3()!=null && misura.getVerStrumento().getPortata_min_C3().compareTo(BigDecimal.ZERO)==1) {
					report.addParameter("portata_min_c3", Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
				}else{
					report.addParameter("portata_min_c3", "");
				}
			}			
			
			if(misura.getVerStrumento().getDiv_ver_C2()!=null) {
				report.addParameter("divisione_verifica_c2", Utility.changeDotComma(misura.getVerStrumento().getDiv_ver_C2().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
			}else{
				report.addParameter("divisione_verifica_c2", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C2()!=null) {
				report.addParameter("divisione_reale_c2", Utility.changeDotComma(misura.getVerStrumento().getDiv_rel_C2().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
			}else{
				report.addParameter("divisione_reale_c2", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C2()!=null) {
				report.addParameter("numero_divisioni_c2", Utility.changeDotComma(misura.getVerStrumento().getNumero_div_C2().stripTrailingZeros().toPlainString()));
			}else{
				report.addParameter("numero_divisioni_c2", "");
			}
			
			
			if(misura.getVerStrumento().getDiv_ver_C3()!=null && misura.getVerStrumento().getDiv_ver_C3().compareTo(BigDecimal.ZERO)==1) {				
				report.addParameter("divisione_verifica_c3", Utility.changeDotComma(misura.getVerStrumento().getDiv_ver_C3().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
			}else{			
				report.addParameter("divisione_verifica_c3", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C3()!=null && misura.getVerStrumento().getDiv_rel_C3().compareTo(BigDecimal.ZERO)==1) {
				report.addParameter("divisione_reale_c3", Utility.changeDotComma(misura.getVerStrumento().getDiv_rel_C3().stripTrailingZeros().toPlainString())+" "+misura.getVerStrumento().getUm());
			}else{
				report.addParameter("divisione_reale_c3", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C3()!=null && misura.getVerStrumento().getNumero_div_C3().compareTo(BigDecimal.ZERO)==1) {
				report.addParameter("numero_divisioni_c3", Utility.changeDotComma(misura.getVerStrumento().getNumero_div_C3().stripTrailingZeros().toPlainString()));
			}else{
				report.addParameter("numero_divisioni_c3", "");
			}
		}
		
		if(misura.getVerStrumento().getTipo().getId()!=4) {			
		
			if(misura.getMotivo_verifica().getId()==1) {
				report.addParameter("croce1", "X");
				report.addParameter("croce2", "");
				report.addParameter("croce3", "");
				report.addParameter("riparatore", "");
				report.addParameter("data_riparazione", "");
			}else if(misura.getMotivo_verifica().getId()==2) {
				report.addParameter("croce1", "");
				report.addParameter("croce2", "X");
				report.addParameter("croce3", "");
				report.addParameter("riparatore", misura.getNomeRiparatore());
				report.addParameter("data_riparazione",df.format(misura.getDataRiparazione()));
			}else{
				report.addParameter("croce1", "");
				report.addParameter("croce2", "");
				report.addParameter("croce3", "X");
				report.addParameter("riparatore", "");
				report.addParameter("data_riparazione", "");
			}
		}
		
		if(misura.getTipoRisposta()==0) {
			report.addParameter("codifica", "MOD-PDI001-03 Rev. 0 del 21/12/2022");
		}else {
			report.addParameter("codifica", "MOD-PDI001-05 Rev. 0 del 21/12/2022");
		}
		
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		
		reportP2.setTemplateDesign(is2);
		reportP2.setTemplate(Templates.reportTemplate);

		reportP2.setDataSource(new JREmptyDataSource());		
		reportP2.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
//		if(logo!=null) {
//			reportP2.addParameter("logo",logo);
//		
//			}
//	
//		if(logoAccredia!=null) {
//			reportP2.addParameter("logo_accredia",logoAccredia);
//		
//			}
		
		
		if(misura.getVerStrumento().getTipo().getId()==4 || misura.getVerStrumento().getTipo().getId()==5) {			
			
			if(misura.getMotivo_verifica().getId()==1) {
				reportP2.addParameter("croce1", "X");
				reportP2.addParameter("croce2", "");
				reportP2.addParameter("croce3", "");
				reportP2.addParameter("riparatore", "");
				reportP2.addParameter("data_riparazione", "");
			}else if(misura.getMotivo_verifica().getId()==2) {
				reportP2.addParameter("croce1", "");
				reportP2.addParameter("croce2", "X");
				reportP2.addParameter("croce3", "");
				reportP2.addParameter("riparatore", misura.getNomeRiparatore());
				reportP2.addParameter("data_riparazione", misura.getDataRiparazione());
			}else{
				reportP2.addParameter("croce1", "");
				reportP2.addParameter("croce2", "");
				reportP2.addParameter("croce3", "X");
				reportP2.addParameter("riparatore", "");
				reportP2.addParameter("data_riparazione", "");
			}
		}
		
		if(misura.getTipoRisposta()==0) {
			reportP2.addParameter("codifica", "MOD-PDI001-03 Rev. 0 del 21/12/2022");
		}else {
			reportP2.addParameter("codifica", "MOD-PDI001-05 Rev. 0 del 21/12/2022");
		}
		reportP2.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver.png"));
		//reportP2.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver_NEW.png"));
		reportP2.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("logo_sti_indirizzo_ver.png"));	
		
		if(misura.getNumeroAttestato()!=null) {
			reportP2.addParameter("numero_certificato", misura.getNumeroAttestato().replace("_", " - "));
		}else {
			reportP2.addParameter("numero_certificato", "");
		}
		
		reportP2.addParameter("allegato", misura.getNumeroRapporto().replace("_", " - ")); 
		
		if(misura.getCampioniLavoro()!=null) {
			reportP2.addParameter("campioni_lavoro", misura.getCampioniLavoro());
		}else {
			reportP2.addParameter("campioni_lavoro", "");
		}

		reportP2.addParameter("campioni_prima_linea", CostantiCertificato.CAMPIONI_PRIMA_LINEA);
		
		if(misura.getDataScadenza()!=null && conforme) {
			reportP2.addParameter("data_scadenza", df.format(misura.getDataScadenza()));	
		}else {
			reportP2.addParameter("data_scadenza", "");
		}
		
		if(conforme) {
			reportP2.addParameter("conforme", "X");
			reportP2.addParameter("non_conforme", "");
			reportP2.addParameter("motivo1", "");
			reportP2.addParameter("motivo2", "");
			reportP2.addParameter("motivo3", "");
		}else {
			reportP2.addParameter("conforme", "");
			reportP2.addParameter("non_conforme", "X");
			if(motivo==1) {
				reportP2.addParameter("motivo1", "X");
				reportP2.addParameter("motivo2", "");
				reportP2.addParameter("motivo3", "");
			}else if(motivo==3) {
				reportP2.addParameter("motivo1", "");
				reportP2.addParameter("motivo2", "X");
				reportP2.addParameter("motivo3", "");
			}else {
				reportP2.addParameter("motivo1", "");
				reportP2.addParameter("motivo2", "");
				reportP2.addParameter("motivo3", "X");
			}
		}
		
		if(misura.getNote_attestato()!=null) {
			reportP2.addParameter("note", misura.getNote_attestato());
		}else {
			reportP2.addParameter("note", "");	
		}
		
		reportP2.addParameter("nome_titolare", "");
		if(misura.getTecnicoVerificatore()!=null && misura.getTecnicoVerificatore().getNominativo()!=null) {
			reportP2.addParameter("nome_operatore", misura.getTecnicoVerificatore().getNominativo());	
		}else {
			reportP2.addParameter("nome_operatore", "");
		}
		
		reportP2.addParameter("data_emissione", df.format(new Date()));
		//reportP2.addParameter("responsabile", "Eliseo Crescenzi");
		
		report.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("logo_sti_indirizzo_ver.png"));	
	//	reportP2.addParameter("firma_responsabile", PivotTemplate.class.getResourceAsStream("FIRMA_ANTONIO_ACCETTOLA.png"));
		//reportP2.addParameter("firma_responsabile", PivotTemplate.class.getResourceAsStream("firma_eliseo_crescenzi.png"));
		
		JasperPrint jasperPrint2 = reportP2.toJasperPrint();
		jasperPrintList.add(jasperPrint2);
		
		
		//String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestVerCertificato.pdf";
		String path = Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\"+misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf";
		
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		
		if(misura.getId_misura_old()!=0) {
			addRiemessione(misura.getId_misura_old(), path, misura.getNumeroAttestato().replace("_", " - "), session);
		}
		
	};
	
	
	
	public  void addRiemessione(int misuraOld,String path,String nuovo_attestato, Session session) throws Exception {

		VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(misuraOld, session);
		
		File folderCopy = new File(Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\OLD\\"); 

		if(!folderCopy.exists()) {
			folderCopy.mkdirs();
		}
		
		Files.copy(Paths.get(path), Paths.get(folderCopy+"\\"+misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf"), StandardCopyOption.REPLACE_EXISTING);
			//System.out.println("filepath" + filepath);
			File tmpFile = new File(path+"tmp");
	        PdfReader reader = new PdfReader(path);
	        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(tmpFile));
	        Font f = new Font(FontFamily.HELVETICA, 12);
	        f.setColor(BaseColor.RED);
	        int pages = reader.getNumberOfPages();
	        for (int i=0; i<pages; i++) {	        
		        PdfContentByte over = stamper.getOverContent(i+1);
		        Phrase p = new Phrase(String.format("Questo attestato corregge l'attestato n. %s", misura.getNumeroAttestato().replaceAll("_", "-")), f);
		        over.saveState();
		        PdfGState gs1 = new PdfGState();
		        gs1.setFillOpacity(0.7f);
		        over.setGState(gs1);
		        ColumnText.showTextAligned(over, Element.ALIGN_CENTER, p, 580, 450, 90);
		        over.restoreState();
	        }
	        stamper.close();
	        reader.close();
	        File fil = new File (path);
	        if(fil.exists()) {
	        	fil.delete();
	        }
			tmpFile.renameTo(new File(path));
		
			addRiemessioneOld(misura, nuovo_attestato, session);
		
	}
	
	
	public  void addRiemessioneOld(VerMisuraDTO misuraOld,String nuovo_attestato, Session session) throws Exception {

		String path = Costanti.PATH_FOLDER+"\\"+misuraOld.getVerIntervento().getNome_pack()+"\\"+misuraOld.getVerIntervento().getNome_pack()+"_"+misuraOld.getId()+""+misuraOld.getVerStrumento().getId()+".pdf";
		
		
			File tmpFile = new File(path+"tmp");
	        PdfReader reader = new PdfReader(path);
	        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(tmpFile));
	        Font f = new Font(FontFamily.HELVETICA, 12);
	        f.setColor(BaseColor.RED);
	        int pages = reader.getNumberOfPages();
	        for (int i=0; i<pages; i++) {	        
		        PdfContentByte over = stamper.getOverContent(i+1);
		        Phrase p = new Phrase(String.format("Questo attestato è stato sostituito dall'attestato %s", nuovo_attestato), f);
		        over.saveState();
		        PdfGState gs1 = new PdfGState();
		        gs1.setFillOpacity(0.7f);
		        over.setGState(gs1);
		        ColumnText.showTextAligned(over, Element.ALIGN_CENTER, p, 580, 450, 90);
		        over.restoreState();
	        }
	        stamper.close();
	        reader.close();
	        File fil = new File (path);
	        if(fil.exists()) {
	        	fil.delete();
	        }
			tmpFile.renameTo(new File(path));
		
		
		
	}
	
	private String getClassePrecisione(int classe) {
		
		String cl = "";
		
		if(classe == 5) {
			cl = "I";
			
		}else if(classe == 6){
			cl="II";
			
		}else {
			
			for(int i = 0; i<classe; i++) {
				cl = cl +"I";
			}
			
		}
		return cl;
	}
	
	public static void main(String[] args) throws Exception {
	new ContextListener().configCostantApplication();
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	
	VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(30, session);

		List<SedeDTO> listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	

		new CreateVerCertificato(misura, listaSedi, false, 2, session);
		session.getTransaction().commit();
		session.close();
		System.out.println("FINITO");
}
}
