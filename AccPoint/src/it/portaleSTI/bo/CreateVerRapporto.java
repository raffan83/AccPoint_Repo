package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;

import com.itextpdf.text.BaseColor;
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
import TemplateReport.ImageReport.PivotTemplateImage;
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.HorizontalListBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.VerticalListBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.Markup;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateVerRapporto {
	
	private String um;
	
	
	private int classe_strumento;
	private int tipologia_strumento;
	private VerStrumentoDTO strumento;
	
	public CreateVerRapporto(VerMisuraDTO misura, List<SedeDTO> listaSedi, boolean conforme, int motivo,UtenteDTO utente,  Session session) throws Exception {
	
		build(misura, listaSedi, conforme, motivo,utente, session);
		
	}

	private void build(VerMisuraDTO misura, List<SedeDTO> listaSedi, boolean conforme, int motivo,UtenteDTO utente, Session session) throws Exception {
		
		InputStream is = null;
		
		if(misura.getVerStrumento().getTipo().getId()==1) {
			is = PivotTemplate.class.getResourceAsStream("VerRapportoCSP1.jrxml");
		}else if(misura.getVerStrumento().getTipo().getId()==2) {
			is = PivotTemplate.class.getResourceAsStream("VerRapportoDPP1.jrxml");
		}else {
			is = PivotTemplate.class.getResourceAsStream("VerRapportoCPP1.jrxml");
		}
		
		this.strumento = misura.getVerStrumento();
		this.um = misura.getVerStrumento().getUm();
		
		int numero_campi = 1;
		
		ArrayList<VerAccuratezzaDTO> lista_accuratezza = GestioneVerMisuraBO.getListaAccuratezza(misura.getId(), session);
		ArrayList<VerLinearitaDTO> lista_linearita = GestioneVerMisuraBO.getListaLinearita(misura.getId(), session);
		ArrayList<VerDecentramentoDTO> lista_decentramento = GestioneVerMisuraBO.getListaDecentramento(misura.getId(), session);
		ArrayList<VerMobilitaDTO> lista_mobilita = GestioneVerMisuraBO.getListaMobilita(misura.getId(), session);
		ArrayList<VerRipetibilitaDTO> lista_ripetibilita = GestioneVerMisuraBO.getListaRipetibilita(misura.getId(), session);
		
		InputStream is2 =  null;
				
		if(misura.getSeqRisposte().length()<31) {
			if(misura.getTipoRisposta()==0) {
				is2 = PivotTemplate.class.getResourceAsStream("VerCheckListNew_0.jrxml");	
			}else {
				is2 = PivotTemplate.class.getResourceAsStream("VerCheckListNew_1.jrxml");
			}
			
		}else {
			is2 = PivotTemplate.class.getResourceAsStream("VerCheckList.jrxml");
		}
			
		InputStream is3 =  null;
		
		if(misura.gettInizio()==0 && misura.gettFine()==0) {
			is3 = PivotTemplate.class.getResourceAsStream("VerRapportoHeader.jrxml");	
		}else {
			is3 = PivotTemplate.class.getResourceAsStream("VerRapportoHeaderTemperatura.jrxml");
		}
		
		
		JasperReportBuilder report = DynamicReports.report();
		JasperReportBuilder reportP2 = DynamicReports.report();
		JasperReportBuilder reportP3 = DynamicReports.report();
		report.setTemplate(Templates.reportTemplate);
		
		
		report.setTemplateDesign(is);
		
		if(misura.getVerStrumento().getLista_legalizzazione_bilance()!=null && misura.getVerStrumento().getLista_legalizzazione_bilance().size()>0) {
			
			report.addParameter("tipo_approvazione_header","Tipo di approvazione");
			report.addParameter("numero_provvedimento_header", "Numero \n provvedimento");		
			
			report.addParameter("data_provvedimento_header", "Data");
			report.addParameter("legalizzazione_title", "Dati relativi all'accertamento della conformità");
			report.addParameter("legalizzazione_title_small", "");
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			int index = 1;
			for (VerLegalizzazioneBilanceDTO legalizzazione : misura.getVerStrumento().getLista_legalizzazione_bilance()) {
				if(index<3) {
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
		}
		
		report.setStartPageNumber(1);
		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		reportP2.setTemplateDesign(is2);
		reportP2.setTemplate(Templates.reportTemplate);
		reportP2.setStartPageNumber(2);
		reportP2.setDataSource(new JREmptyDataSource());		
		reportP2.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		reportP3.setTemplateDesign(is3);
		reportP3.setTemplate(Templates.reportTemplate);

		reportP3.setDataSource(new JREmptyDataSource());		
		reportP3.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
	
		SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
		
		
		
	
		report.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver.png"));
		report.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("logo_sti_indirizzo_ver.png"));
		
		File firma = new File(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma());
		
		if(!firma.exists()) {
			firma = null;
		}

		
		
		if(misura.getNumeroRapporto()!=null) {
			report.addParameter("numero_rapporto", misura.getNumeroRapporto().replace("_"," - "));
		}else {
			report.addParameter("numero_rapporto", "");
		}
		
		if(misura.getNumeroAttestato()!=null) {
			report.addParameter("allegato", misura.getNumeroAttestato().replace("_"," - "));
		}else {
			report.addParameter("allegato", "");
		}
		
		if(cliente!=null) {
			report.addParameter("denominazione_titolare", cliente.getNome());
		}else {
			report.addParameter("denominazione_titolare", "");
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
			if(sede.getIndirizzo()!=null) {
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
		
		this.classe_strumento = misura.getVerStrumento().getClasse();
		this.tipologia_strumento = misura.getVerStrumento().getTipologia().getId();
		
		if(misura.getVerStrumento().getAnno_marcatura_ce()!=0) {
			report.addParameter("anno_marcatura_ce", misura.getVerStrumento().getAnno_marcatura_ce());
		}else{
			report.addParameter("anno_marcatura_ce", "");
		}
		
		if(misura.getVerStrumento().getData_messa_in_servizio()!=null) {
			report.addParameter("data_messa_in_servizio", df.format(misura.getVerStrumento().getData_messa_in_servizio()));
		}else{
			report.addParameter("data_messa_in_servizio", "");
		}
		
		if(misura.getVerStrumento().getTipo()!=null && misura.getVerStrumento().getTipo().getDescrizione()!=null) {
			report.addParameter("tipo_strumento", misura.getVerStrumento().getTipo().getDescrizione());
		}else{
			report.addParameter("tipo_strumento", "");
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
		

						
		
		if(misura.getVerStrumento().getPortata_max_C1()!=null) {
			report.addParameter("portata_max_c1", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros().toPlainString())+" "+um);
		}else{
			report.addParameter("portata_max_c1", "");
		}
		
		if(misura.getVerStrumento().getPortata_min_C1()!=null) {
			report.addParameter("portata_min_c1", Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros().toPlainString())+" "+um);
		}else{
			report.addParameter("portata_min_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_ver_C1()!=null) {
			report.addParameter("divisione_verifica_c1",Utility.changeDotComma( misura.getVerStrumento().getDiv_ver_C1().stripTrailingZeros().toPlainString())+" "+um);
			
		}else{
			report.addParameter("divisione_verifica_c1", "");
			
		}
		
		if(misura.getVerStrumento().getDiv_rel_C1()!=null) {
			report.addParameter("divisione_reale_c1", Utility.changeDotComma(misura.getVerStrumento().getDiv_rel_C1().stripTrailingZeros().toPlainString())+" "+um);
			
			
		}else{
			report.addParameter("divisione_reale_c1", "");
			
		}
		
		if(misura.getVerStrumento().getNumero_div_C1()!=null) {
			report.addParameter("numero_divisioni_c1", Utility.changeDotComma(misura.getVerStrumento().getNumero_div_C1().stripTrailingZeros().toPlainString()));
		}else{
			report.addParameter("numero_divisioni_c1", "");
		}
		if(misura.getVerStrumento().getTipo().getId()!=1) {

				
				numero_campi = 2;
				for (VerRipetibilitaDTO item : lista_ripetibilita) {
					if(item.getMpe()!=null && item.getCampo() == 3) {
						numero_campi = 3;
						break;
					}
				}
				
				
				if(misura.getVerStrumento().getPortata_max_C2()!=null) {
					report.addParameter("portata_max_c2", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros().toPlainString())+" "+um);
				}else{
					report.addParameter("portata_max_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C2()!=null) {
					report.addParameter("portata_min_c2", Utility.changeDotComma(misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros().toPlainString())+" "+um);
				}else{
					report.addParameter("portata_min_c2", "");
				}
				
				if(numero_campi==3) {
					
					if(misura.getVerStrumento().getTipo().getId()==2) {
						report.addParameter("campo1", "Campo di pesatura secondario 1");
						report.addParameter("campo2", "Campo di pesatura secondario 2");
						report.addParameter("campo3", "Campo di pesatura principale");
					}else {
						report.addParameter("campo3", "Campo di pesatura 3");
					}
					
					if(misura.getVerStrumento().getPortata_max_C3()!=null) {
						report.addParameter("portata_max_c3", Utility.changeDotComma(misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros().toPlainString())+" "+um);
					}else{
						report.addParameter("portata_max_c3", "");
					}
					
					if(misura.getVerStrumento().getPortata_min_C3()!=null) {
						report.addParameter("portata_min_c3", Utility.changeDotComma( misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros().toPlainString())+" "+um);
					}else{
						report.addParameter("portata_min_c3", "");
					}
				}else {
					if(misura.getVerStrumento().getTipo().getId()==2) {
						report.addParameter("campo1", "Campo di pesatura secondario");
						report.addParameter("campo2", "Campo di pesatura principale");						
					}
						report.addParameter("campo3", "");
						report.addParameter("portata_max_c3", "");
						report.addParameter("portata_min_c3", "");
									
				}
			//}			
			
			if(misura.getVerStrumento().getDiv_ver_C2()!=null) {
				report.addParameter("divisione_verifica_c2", Utility.changeDotComma(misura.getVerStrumento().getDiv_ver_C2().stripTrailingZeros().toPlainString())+" "+um);
			}else{
				report.addParameter("divisione_verifica_c2", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C2()!=null) {
				report.addParameter("divisione_reale_c2", Utility.changeDotComma(misura.getVerStrumento().getDiv_rel_C2().stripTrailingZeros().toPlainString())+" "+um);
			}else{
				report.addParameter("divisione_reale_c2", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C2()!=null) {
				report.addParameter("numero_divisioni_c2", Utility.changeDotComma(misura.getVerStrumento().getNumero_div_C2().stripTrailingZeros().toPlainString()));
			}else{
				report.addParameter("numero_divisioni_c2", "");
			}
			
			if(numero_campi==3) {
				if(misura.getVerStrumento().getDiv_ver_C3()!=null) {
					report.addParameter("divisione_verifica_c3",Utility.changeDotComma( misura.getVerStrumento().getDiv_ver_C3().stripTrailingZeros().toPlainString())+" "+um);
				}else{
					report.addParameter("divisione_verifica_c3", "");
				}
				
				if(misura.getVerStrumento().getDiv_rel_C3()!=null) {
					report.addParameter("divisione_reale_c3", Utility.changeDotComma(misura.getVerStrumento().getDiv_rel_C3().stripTrailingZeros().toPlainString())+" "+um);
				}else{
					report.addParameter("divisione_reale_c3", "");
				}
				
				if(misura.getVerStrumento().getNumero_div_C3()!=null) {
					report.addParameter("numero_divisioni_c3",Utility.changeDotComma( misura.getVerStrumento().getNumero_div_C3().stripTrailingZeros().toPlainString()));
				}else{
					report.addParameter("numero_divisioni_c3", "");
				}
			}else {
				report.addParameter("divisione_verifica_c3", "");
				report.addParameter("divisione_reale_c3", "");
				report.addParameter("numero_divisioni_c3", "");
			}
		}
		
		report.addParameter("registro", misura.getId()+"_"+misura.getVerStrumento().getId()); //MANCA REGISTRO
		report.addParameter("procedura", "PT-020 Rev. E"); 
		
		if(utente.getFile_firma()!=null) {
			if(firma!=null) {
				
				report.addParameter("firma_operatore", firma);
			}else {
				report.addParameter("firma_operatore", ""); 
			}
		}else {
			report.addParameter("firma_operatore", "");
		}
		
		
		if(misura.getDataVerificazione()!=null) {
			report.addParameter("data_verificazione", df.format(misura.getDataVerificazione()));
		}else {
			report.addParameter("data_verificazione","");
		}
		
		if(misura.getNomeRiparatore()!=null) {
			report.addParameter("nome_riparatore", misura.getNomeRiparatore());
		}else {
			report.addParameter("nome_riparatore","");
		}
		
		if(misura.getDataRiparazione()!=null) {
			report.addParameter("data_riparazione", df.format(misura.getDataRiparazione()));
		}else {
			report.addParameter("data_riparazione","");
		}
		
		
		report.addParameter("data_emissione", df.format(new Date()));
		
		
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		

		reportP2.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver.png"));
		reportP2.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("logo_sti_indirizzo_ver.png"));
		
		if(misura.getNumeroRapporto()!=null) {
			reportP2.addParameter("numero_rapporto", misura.getNumeroRapporto().replace("_"," - "));
		}else {
			reportP2.addParameter("numero_rapporto", "");
		}
		if(misura.getNumeroAttestato()!=null) {
			reportP2.addParameter("allegato", misura.getNumeroAttestato().replace("_"," - "));
		}else {
			reportP2.addParameter("allegato", "");
		}
				
		String[] risposte = misura.getSeqRisposte().split(";");
		
		boolean esito = true;
		for(int i = 0; i < risposte.length;i++) {
			if(risposte[i].equals("0")) {
				reportP2.addParameter("x_"+(i+1)+"1", "X");
				reportP2.addParameter("x_"+(i+1)+"2", "");
				reportP2.addParameter("x_"+(i+1)+"3", "");
			}else if(risposte[i].equals("1")) {
				reportP2.addParameter("x_"+(i+1)+"1", "");
				reportP2.addParameter("x_"+(i+1)+"2", "X");
				reportP2.addParameter("x_"+(i+1)+"3", "");
				esito = false;
			}else if(risposte[i].equals("2")) {
				reportP2.addParameter("x_"+(i+1)+"1", "");
				reportP2.addParameter("x_"+(i+1)+"2", "");
				reportP2.addParameter("x_"+(i+1)+"3", "X");
			}
		}

		if(esito) {
			reportP2.addParameter("esito", "SUPERATO");
		}else {
			reportP2.addParameter("esito", "NON SUPERATO");
		}
		
		
		if(utente.getFile_firma()!=null) {
			if(firma!=null) {
				
				reportP2.addParameter("firma_operatore", firma);
			}else {
				reportP2.addParameter("firma_operatore", ""); 
			}
		}else {
			reportP2.addParameter("firma_operatore", ""); 
		}
		
		reportP2.addParameter("data_emissione", df.format(new Date()));
		
		
				
		File logo_accredia = new File(PivotTemplateLAT_Image.class.getResource("accredia.png").getPath());
		File logo_sti = new File(PivotTemplateLAT_Image.class.getResource("logo_sti_indirizzo_ver.png").getPath());
		
		if(motivo!=2) {
				
			
			//reportP3.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
			//reportP3.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));
			reportP3.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("logo_accredia_ver.png"));
			reportP3.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("logo_sti_indirizzo_ver.png"));
			
			if(misura.getNumeroRapporto()!=null) {
				reportP3.addParameter("numero_rapporto", misura.getNumeroRapporto().replace("_"," - "));
			}else {
				reportP3.addParameter("numero_rapporto", "");
			}
			
			
			if(misura.getNumeroAttestato()!=null) {
				reportP3.addParameter("allegato", misura.getNumeroAttestato().replace("_"," - "));
			}else {
				reportP3.addParameter("allegato", "");
			}
			
			if(misura.gettInizio()!=0 && misura.gettFine()!=0) {
				
				//reportP3.addParameter("t_inizio", (""+misura.gettInizio()).replace(".", ","));				
				reportP3.addParameter("t_inizio",String.format("%.1f", misura.gettInizio()).replace(".", ","));
				reportP3.addParameter("t_fine",String.format("%.1f", misura.gettFine()).replace(".", ","));
				//reportP3.addParameter("t_fine", (""+misura.gettFine()).replace(".", ","));
				
				if(Math.abs(misura.gettInizio()-misura.gettFine())<5) {
					reportP3.addParameter("esito_temperatura", "ESITO: POSITIVO");	
				}else {
					reportP3.addParameter("esito_temperatura", "ESITO: NEGATIVO");
				}
				
				if(misura.getAltezza_org()!=0) {
					reportP3.addParameter("altezza_org",(""+ misura.getAltezza_org()).replace(".", ","));	
				}else {
					reportP3.addParameter("altezza_org","N.A.");
				}
				
				
				if(misura.getAltezza_util()!=0) {
					reportP3.addParameter("altezza_util", (""+misura.getAltezza_util()).replace(".", ","));
				}else {
					reportP3.addParameter("altezza_util","N.A.");
				}
				if(misura.getLatitudine_org()!=0) {
					reportP3.addParameter("latitudine_org", (""+misura.getLatitudine_org()).replace(".", ","));
				}else {
					reportP3.addParameter("latitudine_org","N.A.");
				}
				if(misura.getLatitudine_util()!=0) {
					reportP3.addParameter("latitudine_util", (""+misura.getLatitudine_util()).replace(".", ","));
				}else {
					reportP3.addParameter("latitudine_util","N.A.");
				}
				if(misura.getgOrg()!=0) {
					reportP3.addParameter("g_org",  String.format("%.5f", misura.getgOrg()).replace(".", ","));
				}else {
					reportP3.addParameter("g_org","N.A.");
				}
				if(misura.getgUtil()!=0) {
					reportP3.addParameter("g_util", String.format("%.5f", misura.getgUtil()).replace(".", ","));
				}else {
					reportP3.addParameter("g_util","N.A.");
				}
				if(misura.getgFactor()!=0) {
					reportP3.addParameter("g_factor", String.format("%.6f", misura.getgFactor()).replace(".", ","));
				}else {
					reportP3.addParameter("g_factor","N.A.");
				}
				
			}
			
			
			
			StyleBuilder boldStyle = Templates.boldStyle;
			int numero_pagine = 0;
			
			for(int i = 0; i<numero_campi; i++) {
				
					
				boolean esito_globale = true;			
				
				
				reportP3.setDetailSplitType(SplitType.IMMEDIATE);
				
				VerticalListBuilder vl_general = cmp.verticalList();
				
				SubreportBuilder subreport_ripetibilita = cmp.subreport(getTableRipetibilita(lista_ripetibilita, i+1));		
				SubreportBuilder subreport_ripetibilita_2 = cmp.subreport(getTableRipetibilitaSmall(lista_ripetibilita, i+1));
				
				HorizontalListBuilder hl_ripetibilita = cmp.horizontalList(cmp.horizontalGap(25),subreport_ripetibilita,cmp.horizontalGap(10), subreport_ripetibilita_2);
				
				String esito_ripetibilita = lista_ripetibilita.get(i*6).getEsito();
				if(esito_ripetibilita.equals("NEGATIVO")) {
					esito_globale = false;
				}
				
				VerticalListBuilder vl_ripetibilita = null;
				
				String campo = "";
				if(numero_campi>1) {					
					
					if(misura.getVerStrumento().getTipo().getId()==2 ) {	
						
						if(numero_campi == 2) {
							if(i==0) {
								campo = "Campo secondario";
							}else {
								campo = "Campo principale";
							}
						}else {
							if(i<2) {
								campo = "Campo secondario "+(i+1);
							}else {
								campo = "Campo principale";
							}
						}						
												
						
					}else {
						campo = "Campo " + (i+1);
					}
					
					
					
					
				     vl_ripetibilita= cmp.verticalList(
							cmp.text(campo).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(boldStyle),
							cmp.verticalGap(5),
							cmp.text("Prova di Ripetibilità (Rif.UNI CEI EN 45501:2015 - A.4.10)").setStyle(boldStyle),			
							cmp.verticalGap(8),
							hl_ripetibilita, 
							cmp.verticalGap(5),
							cmp.horizontalList(cmp.horizontalGap(400), 
									cmp.text("ESITO: "+ esito_ripetibilita).setStyle(boldStyle))
							);	
					
				}else{
					 vl_ripetibilita= cmp.verticalList(
							 cmp.text(campo).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(boldStyle),
								cmp.text("Prova di Ripetibilità (Rif.UNI CEI EN 45501:2015 - A.4.10)").setStyle(boldStyle),			
								cmp.verticalGap(8),
								hl_ripetibilita, 
								cmp.verticalGap(5),
								cmp.horizontalList(cmp.horizontalGap(400), 
										cmp.text("ESITO: "+ esito_ripetibilita).setStyle(boldStyle))
								);	
				}
				
				
				
	
				
				
				SubreportBuilder subreport_decentramento = cmp.subreport(getTableDecentramento(lista_decentramento, i+1));
	
				InputStream im0 = PivotTemplateImage.class.getResourceAsStream("tipo_0.png");
				InputStream im1 = PivotTemplateImage.class.getResourceAsStream("tipo_1.png");
				InputStream im2 = PivotTemplateImage.class.getResourceAsStream("tipo_2.png");
				InputStream im3 = PivotTemplateImage.class.getResourceAsStream("tipo_3.png");
				InputStream im4 = PivotTemplateImage.class.getResourceAsStream("tipo_4.png");
				HorizontalListBuilder hl_ricettori = cmp.horizontalList(cmp.horizontalGap(115),cmp.image(im0).setFixedDimension(60, 60), cmp.horizontalGap(5), cmp.image(im1).setFixedDimension(60, 60), cmp.horizontalGap(5), cmp.image(im2).setFixedDimension(60, 60),cmp.horizontalGap(5), cmp.image(im3).setFixedDimension(60, 60), cmp.horizontalGap(5),cmp.image(im4).setFixedDimension(60, 60));
				HorizontalListBuilder hl_rettangoli = cmp.horizontalList(cmp.horizontalGap(137));
				StyleBuilder style = stl.style().setBorder(stl.penThin()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFontSize(14);
				String lbl0 = "";
				String lbl1 = "";
				String lbl2 = "";
				String lbl3 = "";
				String lbl4 = "";
				
				if(lista_decentramento.get(i*6).getTipoRicettore()==0) {
					lbl0 = "X";
					lbl1 = "";
					lbl2 = "";
					lbl3 = "";
					lbl4 = "";
				}else if(lista_decentramento.get(i*6).getTipoRicettore()==1) {
					lbl0 = "";
					lbl1 = "X";
					lbl2 = "";
					lbl3 = "";
					lbl4 = "";
				}else if(lista_decentramento.get(i*6).getTipoRicettore()==2) {
					lbl0 = "";
					lbl1 = "";
					lbl2 = "X";
					lbl3 = "";
					lbl4 = "";
				}else if(lista_decentramento.get(i*6).getTipoRicettore()==3) {
					lbl0 = "";
					lbl1 = "";
					lbl2 = "";
					lbl3 = "X";
					lbl4 = "";
				}else {
					lbl0 = "";
					lbl1 = "";
					lbl2 = "";
					lbl3 = "";
					lbl4 = "X";
				}
				
				hl_rettangoli.add(cmp.text(lbl0).setStyle(style).setFixedDimension(15, 15),cmp.horizontalGap(50),cmp.text(lbl1).setStyle(style).setFixedDimension(15, 15),cmp.horizontalGap(50),cmp.text(lbl2).setStyle(style).setFixedDimension(15, 15),cmp.horizontalGap(50),cmp.text(lbl3).setStyle(style).setFixedDimension(15, 15),cmp.horizontalGap(50),cmp.text(lbl4).setStyle(style).setFixedDimension(15, 15));
				String speciale = "";
				if(lista_decentramento.get(0).getSpeciale().equals("N")) {
					speciale = "No";
				}else {
					speciale = "Si";
				}
				int appoggio = 0;
				if(lista_decentramento.get(i*10).getPuntiAppoggio()!=0) {
					appoggio = lista_decentramento.get(i*10).getPuntiAppoggio();	
				}else {
					appoggio = lista_decentramento.get((i*10)+1).getPuntiAppoggio();
				}
	
				String esito_decentramento = lista_decentramento.get(i*10).getEsito();
				
				if(esito_decentramento.equals("NEGATIVO")) {
					esito_globale = false;
				}
				
				
				
				VerticalListBuilder vl_decentramento = null;
				
				if(speciale.equals("Si")) {
					
				vl_decentramento = cmp.verticalList(
						cmp.text("Prova di Decentramento (Rif.UNI CEI EN 45501:2015 - A.4.7)").setStyle(boldStyle),
						//cmp.verticalGap(5),
						cmp.text("Esempio di tipici ricettori di carico").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(boldStyle),
						cmp.verticalGap(4),
						hl_ricettori,
						hl_rettangoli,
						cmp.verticalGap(5),
//						cmp.horizontalList(cmp.text("Numero punti di appoggi del ricettore di carico: "+ appoggio),
//								cmp.horizontalGap(20), 
//								cmp.text("Carico: " + Utility.changeDotComma(lista_decentramento.get(i*10).getCarico().stripTrailingZeros().toPlainString()) +" " + misura.getVerStrumento().getUm())),
						cmp.horizontalList(cmp.text("Numero punti di appoggi del ricettore di carico: "+ appoggio),cmp.horizontalGap(20), cmp.text("Strumento \"Speciale\": "+ speciale)),
						//cmp.verticalGap(5),
						//cmp.text("Strumento \"Speciale\": "+ speciale),		
						cmp.verticalGap(5),
						cmp.horizontalList(cmp.horizontalGap(100),subreport_decentramento),
						cmp.verticalGap(5),
						cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+ esito_decentramento).setStyle(boldStyle))
						);
				
				
				}else {
					
					 vl_decentramento = cmp.verticalList(
							cmp.text("Prova di Decentramento (Rif.UNI CEI EN 45501:2015 - A.4.7)").setStyle(boldStyle),
							cmp.verticalGap(5),
							cmp.text("Esempio di tipici ricettori di carico").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(boldStyle),
							cmp.verticalGap(8),
							hl_ricettori,
							hl_rettangoli,
							cmp.verticalGap(8),
//							cmp.horizontalList(cmp.text("Numero punti di appoggi del ricettore di carico: "+ appoggio),
//									cmp.horizontalGap(20), 
//									cmp.text("Carico: " + Utility.changeDotComma(lista_decentramento.get(i*10).getCarico().stripTrailingZeros().toPlainString()) +" " + misura.getVerStrumento().getUm())),
							cmp.horizontalList(cmp.text("Numero punti di appoggi del ricettore di carico: "+ appoggio)),
							cmp.verticalGap(5),
							cmp.text("Strumento \"Speciale\": "+ speciale),		
							cmp.verticalGap(8),
							cmp.horizontalList(cmp.horizontalGap(100),subreport_decentramento),
							cmp.verticalGap(8),
							cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+ esito_decentramento).setStyle(boldStyle))
							);
				}
				
				
				
				
				

						
				
				SubreportBuilder subreport_linearita = cmp.subreport(getTableLinearita(lista_linearita, i+1));
				
				String azzeramento = "Automatico";
				if(lista_linearita.get(0)!=null && lista_linearita.get(0).getTipoAzzeramento()==0) {
					azzeramento = "Non automatico o semiautomatico";
				}
				
				String esito_linearita = lista_linearita.get(i*6).getEsito();
				
				if(esito_linearita.equals("NEGATIVO")) {
					esito_globale = false;
				}
				
//				VerticalListBuilder vl_linearita = cmp.verticalList(
//						cmp.text(campo).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(boldStyle),
//						cmp.verticalGap(20),
//						cmp.text("Prova di Linearità (Rif.UNI CEI EN 45501:2015 - A.4.4.1 - A.4.2.3)").setStyle(boldStyle), 
//						cmp.text("Tipo dispositivo di azzeramento: " + azzeramento).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
//						cmp.verticalGap(10),
//						subreport_linearita,
//						cmp.verticalGap(10),
//						cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+lista_linearita.get(i*6).getEsito()).setStyle(boldStyle)));
				VerticalListBuilder vl_criteri = null;
				if(tipologia_strumento == 2 && lista_accuratezza.size()>0 && lista_accuratezza.get(0).getMassa()!=null) {
					 vl_criteri = cmp.verticalList(cmp.text("CRITERI").setStyle(stl.style().setFontName("Trebuchet MS")), 
								cmp.horizontalList(cmp.text("  - Per la/le prova/e di ripetibilità:").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(160),
										cmp.text("|Pmax - Pmin|").setStyle(stl.style().italic().setFontName("Trebuchet MS")).setFixedWidth(68),
										cmp.text(" < EMT").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(35)).setGap(0),
								cmp.horizontalList(cmp.text("  - Per le ulteriori prove: ").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(115), 
										cmp.text("|Ec").setStyle(stl.style().italic().setFontName("Trebuchet MS")).setFixedWidth(17),
										cmp.text("i").setFixedWidth(3).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS")),
										cmp.text("| < EMT").setFixedWidth(35).setStyle(stl.style().setFontName("Trebuchet MS")),
										cmp.text("i").setFixedWidth(3).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS"))),
								cmp.horizontalList(cmp.text("  - Per i punti E").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(70), 
										cmp.text("0").setFixedWidth(7).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS")),
										cmp.text("e E").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(15),
										cmp.text("T").setFixedWidth(5).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS")),
										cmp.text(":").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(8),
										cmp.text("Ec = E").setStyle(stl.style().italic().setFontName("Trebuchet MS")).setFixedWidth(35))
								);
				}else {
				
				
				 vl_criteri = cmp.verticalList(cmp.text("CRITERI").setStyle(stl.style().setFontName("Trebuchet MS")), 
						cmp.horizontalList(cmp.text("  - Per la/le prova/e di ripetibilità:").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(160),
								cmp.text("|Pmax - Pmin|").setStyle(stl.style().italic().setFontName("Trebuchet MS")).setFixedWidth(68),
								cmp.text(" < EMT").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(35)).setGap(0),
						cmp.horizontalList(cmp.text("  - Per le ulteriori prove: ").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(115), 
								cmp.text("|Ec").setStyle(stl.style().italic().setFontName("Trebuchet MS")).setFixedWidth(17),
								cmp.text("i").setFixedWidth(3).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS")),
								cmp.text("| < EMT").setFixedWidth(35).setStyle(stl.style().setFontName("Trebuchet MS")),
								cmp.text("i").setFixedWidth(3).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS"))),
						cmp.horizontalList(cmp.text("  - Per il punto E").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(75), 
								cmp.text("0").setFixedWidth(5).setStyle(stl.style().setVerticalAlignment(VerticalAlignment.BOTTOM).italic().setFontSize(7).setFontName("Trebuchet MS")),
								cmp.text(":").setStyle(stl.style().setFontName("Trebuchet MS")).setFixedWidth(8),
								cmp.text("Ec = E").setStyle(stl.style().italic().setFontName("Trebuchet MS")).setFixedWidth(35))
						);
				}
				VerticalListBuilder vl_linearita = cmp.verticalList(
						cmp.text(campo).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(boldStyle),
						cmp.verticalGap(10),
						cmp.text("Prova di Linearità (Rif.UNI CEI EN 45501:2015 - A.4.4.1 - A.4.2.3)").setStyle(boldStyle), 
						cmp.text("Tipo dispositivo di azzeramento: " + azzeramento).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.verticalGap(10),
						subreport_linearita,
						cmp.verticalGap(10),
						cmp.horizontalList(vl_criteri, cmp.horizontalGap(10),cmp.text("ESITO: "+lista_linearita.get(i*6).getEsito()).setStyle(boldStyle)));
				
				VerticalListBuilder vl_accuratezza = cmp.verticalList();
				
				numero_pagine = (2*numero_campi) + 2;
				
				if(lista_accuratezza.get(i*1).getMassa()!=null) {					
				
					SubreportBuilder subreport_accuratezza = cmp.subreport(getTableAccuratezza(lista_accuratezza, i+1));
					
					String tara = "Automatico";
					if(lista_accuratezza.get(0)!=null && lista_accuratezza.get(0).getTipoTara()==0) {
						tara = "Non automatico o semiautomatico";
					}
					
					String esito_accuratezza = lista_accuratezza.get(i*1).getEsito();
					
					if(esito_accuratezza.equals("NEGATIVO")) {
						esito_globale = false;
					}
					
					vl_accuratezza.add(					
							cmp.text("Prova di accuratezza del dispositivo di tara (Rif.UNI CEI EN 45501:2015 - A.4.6.1 - A.4.6.2)").setStyle(boldStyle), 
							cmp.text("Tipo dispositivo di tara: " + tara).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
							cmp.verticalGap(10),
							subreport_accuratezza,
							cmp.verticalGap(5),
							cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+ esito_accuratezza).setStyle(boldStyle)));
					
				}
				
				boolean caso1 = false;
				boolean caso2 = false;
				for (VerMobilitaDTO item : lista_mobilita) {
					if(item.getCampo() == (i+1) && item.getCaso()==1 && item.getMassa()!=null) {
						caso1 = true;
					}else if (item.getCampo() == (i+1) && item.getCaso()==2 && item.getMassa()!=null) {
						caso2 = true;
					}
				}
				SubreportBuilder subreport_mobilita1 = null;
				SubreportBuilder subreport_mobilita2 = null;
				
				if(caso1) {
					subreport_mobilita1 = cmp.subreport(getTableMobilita(lista_mobilita, 1, i+1));	
				}
				if(caso2) {
					subreport_mobilita2 = cmp.subreport(getTableMobilita(lista_mobilita, 2, i+1));	
				}
						
				VerticalListBuilder vl_mobilita = cmp.verticalList();
				VerticalListBuilder vl_mobilita_caso1 = null;
				VerticalListBuilder vl_mobilita_caso2 = null;
				
				if(caso1 || caso2) {
					vl_mobilita.add(cmp.text("Prova di mobilità (Rif.UNI CEI EN 45501:2015 - A.4.8)").setStyle(boldStyle));	
				}
				
				
				if(caso1) {
					String esito_mobilita1 = lista_mobilita.get(i*6).getEsito();
					
					if(esito_mobilita1.equals("NEGATIVO")) {
						esito_globale = false;
					}
					
					
					vl_mobilita_caso1 = cmp.verticalList(					
							cmp.text("Caso 1) - Strumenti ad equilibrio non automatico (con indicazione analogica)").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
							cmp.verticalGap(10),
							subreport_mobilita1,
							cmp.verticalGap(10),
							cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+ esito_mobilita1).setStyle(boldStyle)));
					
					vl_mobilita.add(vl_mobilita_caso1);
					numero_pagine = (2*numero_campi) + 2;
				}
				
				if(caso2) {
					String esito_mobilita2 = lista_mobilita.get((i*6)+3).getEsito();
					
					if(esito_mobilita2.equals("NEGATIVO")) {
						esito_globale = false;
					}
					
					
					if(caso1) {
						vl_mobilita_caso2 = cmp.verticalList(
								cmp.text(campo).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(boldStyle),
								cmp.verticalGap(10),
								cmp.text("Caso 2) - Strumenti ad equilibrio automatico o semiautomatico (con indicazione analogica)").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
								cmp.verticalGap(10),
								subreport_mobilita2,
								cmp.verticalGap(10),
								cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+esito_mobilita2).setStyle(boldStyle)));
						
						vl_mobilita.add(cmp.pageBreak(), vl_mobilita_caso2);
						numero_pagine = (3*numero_campi) +2;
					}else {
						vl_mobilita_caso2 = cmp.verticalList(										
								cmp.text("Strumenti ad equilibrio automatico o semiautomatico (con indicazione analogica)").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
								cmp.verticalGap(10),
								subreport_mobilita2,
								cmp.verticalGap(10),
								cmp.horizontalList(cmp.horizontalGap(400),cmp.text("ESITO: "+esito_mobilita2).setStyle(boldStyle)));
						
						vl_mobilita.add(vl_mobilita_caso2);
						numero_pagine = (2*numero_campi) + 2;
					}
					
				}
				
				
				String conformita = "ESITO ";
				if(misura.getVerStrumento().getTipo().getId()==3) {
					conformita = conformita +"Campo "+ (i+1) + ": "; 
				}else {
					conformita = conformita +"GLOBALE: ";
				}
				if(esito_globale) {
					conformita = conformita +"Positivo";
				}else {
					conformita = conformita +"Negativo";
				}
				
				int vartical_gap = 0;
				
				if(misura.gettInizio()!=0 && misura.gettFine()!=0) {
					vartical_gap = 7;
				}else {
					vartical_gap = 50;
				}
				
				if(!caso1 || !caso2) {
					vl_general.add(
							//cmp.verticalGap(20), 
							vl_ripetibilita,
							cmp.verticalGap(vartical_gap), 
							vl_decentramento,
							cmp.pageBreak(),
							vl_linearita,
							cmp.verticalGap(20),
							vl_accuratezza,
							cmp.verticalGap(20),
							vl_mobilita,
							cmp.verticalGap(20),
							cmp.text(conformita).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(boldStyle.setFontSize(12)),
							cmp.pageBreak()
							);
				}else {
					vl_general.add(
							//cmp.verticalGap(20), 
							vl_ripetibilita,
							cmp.verticalGap(vartical_gap), 
							vl_decentramento,
							cmp.pageBreak(),
							vl_linearita,
							cmp.verticalGap(50),
							vl_accuratezza,
							cmp.verticalGap(50),
							vl_mobilita,
							cmp.verticalGap(30),
							cmp.text(conformita).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(boldStyle.setFontSize(12)),
							cmp.pageBreak()
							);
				}
				
				
	
				
				reportP3.addDetail(vl_general);
				//reportP3.ignorePagination();
			}
			
			String data_emissione = df.format(new Date());
			
			if(utente.getFile_firma()!=null) {
				if(firma!=null) {
					
					reportP3.pageFooter(
							cmp.verticalList(
							cmp.horizontalList(
									cmp.horizontalGap(50),
									cmp.text("Data emissione"),
									cmp.horizontalGap(170),
									cmp.text("Firma operatore tecnico")
									),
							cmp.horizontalList(
									cmp.horizontalGap(60),
									cmp.text(data_emissione),
									cmp.horizontalGap(25),
									cmp.text(""),
									cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma()).setFixedHeight(18)
									)
							)
							);
				}
			}else {
				reportP3.pageFooter(
						cmp.verticalList(
						cmp.horizontalList(
								cmp.horizontalGap(5),
								cmp.text("Data emissione"),
								cmp.horizontalGap(170),
								cmp.text("Firma operatore tecnico")
								),
						cmp.horizontalList(
								cmp.horizontalGap(60),
								cmp.text(data_emissione),
								cmp.horizontalGap(178),
								cmp.text("........................................")
								)
						)
						);
			}

			report.addParameter("pagine_totali", numero_pagine);
			reportP2.addParameter("pagine_totali", numero_pagine);
			reportP3.setStartPageNumber(3);
			reportP3.addParameter("pagine_totali", numero_pagine);
			JasperPrint jasperPrint1 = report.toJasperPrint();
			jasperPrintList.add(jasperPrint1);
			JasperPrint jasperPrint2 = reportP2.toJasperPrint();
			jasperPrintList.add(jasperPrint2);
			JasperPrint jasperPrint3 = reportP3.toJasperPrint();
			jasperPrintList.add(jasperPrint3);
			
		}
		else {
			report.addParameter("pagine_totali", 2);
			JasperPrint jasperPrint1 = report.toJasperPrint();
			jasperPrintList.add(jasperPrint1);
			reportP2.addParameter("pagine_totali", 2);
			JasperPrint jasperPrint2 = reportP2.toJasperPrint();
			jasperPrintList.add(jasperPrint2);
		}
		

		
		File folder = new File(Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\Rapporto\\");
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		//String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestVerCertificato.pdf";
		String path = Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\Rapporto\\RAP"+misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf";
		//String path = Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\"+misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf";
		
	
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path)); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		
		configuration.setCreatingBatchModeBookmarks(false); 
		
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		
		if(misura.getId_misura_old()!=0) {
			addRiemessione(misura.getId_misura_old(), path, misura.getNumeroRapporto().replace("_", " - "), session);
		}
		
	}
	
	
	private JasperReportBuilder getTableLegalizzazione(Set<VerLegalizzazioneBilanceDTO> lista_legalizzazione_bilance) {
		
		JasperReportBuilder report = DynamicReports.report();
		

		report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
		report.addColumn(col.column("Tipo approvazione","tipo_approvazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));		
 		report.addColumn(col.column("N. provvedimeto","n_provvedimento", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
 		report.addColumn(col.column("Data provvedimeno","data_provvedimento", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));

 		report.setDataSource(createDataSourceLegalizzazione(lista_legalizzazione_bilance));
 		
 		report.highlightDetailEvenRows();
		
		return report;
	}



	private JasperReportBuilder getTableDecentramento(ArrayList<VerDecentramentoDTO> lista_decentramento, int campo) throws Exception {

		JasperReportBuilder report = DynamicReports.report();
		

		report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
		report.addColumn(col.column("Posizione n°","n_posizione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));		
 		report.addColumn(col.column("Massa  <br><i> L</i> <br>"+"/"+um,"massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
 		report.addColumn(col.column("Indicazione  <br><i> I </i> <br>"+"/"+um,"indicazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));

 		if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
 			report.addColumn(col.column("Carico aggiuntivo  <br><i> ΔL </i> <br>"+"/"+um,"carico_aggiuntivo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));	
 		}
 		
 		report.addColumn(col.column("Errore  <br><i> E </i> <br> "+"/"+um,"e", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
 	//	if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
 			report.addColumn(col.column("Errore Corretto <br><i> Ec </i> <br>"+"/"+um,"ec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
 	//	}
 		report.addColumn(col.column("Errore Massimo Tollerato <br> ± EMT  <br> " +"/"+um,"mpe", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(90));
 			 	
		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
	
 		report.setDataSource(createDataSourceDecentramento(lista_decentramento, campo));
 		
 		report.highlightDetailEvenRows();


	return report;
	}



	private JasperReportBuilder getTableLinearita(ArrayList<VerLinearitaDTO> lista_linearita, int campo) throws Exception {
		
		JasperReportBuilder report = DynamicReports.report();

		report.setTemplate(Templates.reportTemplate);
		//report.setColumnStyle(textStyle);
		//report.setColumnTitleStyle(textStyle);
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()).setMarkup(Markup.HTML));

			
			report.addColumn(col.column("Rif.","rif", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(25));			
	 		report.addColumn(col.column("Massa  <br> <i>L </i> <br> "+"/"+um,"massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	//	report.addColumn(col.column("Indicazione Salita </i> <br> I </i> <br> "+"/"+um,"indicazione_up", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		report.addColumn(col.column("Indicazione Salita <br> <i>I</i> <br> "+"/"+um,"indicazione_up", type.stringType()).setStretchWithOverflow(false).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		report.addColumn(col.column("Indicazione Discesa <br> <i>I</i> <br> "+"/"+um,"indicazione_down", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
	 			report.addColumn(col.column("Carico aggiuntivo Salita <br> <i> ΔL</i> <br> "+"/"+um,"carico_aggiuntivo_up", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		 		report.addColumn(col.column("Carico aggiuntivo Discesa <br> <i> ΔL</i> <br> "+"/"+um,"carico_aggiuntivo_down", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));	
	 		}
	 		
	 		report.addColumn(col.column("Errore Salita <br> <i> E </i> <br>"+"/"+um,"e_up", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		report.addColumn(col.column("Errore Discesa<br> <i> E </i> <br>"+"/"+um,"e_down", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		//if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
	 			report.addColumn(col.column("Errore Corretto Salita <br> <i> Ec </i> <br>"+"/"+um,"ec_up", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 			report.addColumn(col.column("Errore Corretto Discesa <br> <i> Ec </i> <br>" +"/"+ um,"ec_down", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		//}
	 		report.addColumn(col.column("Errore Massimo Tollerato <br> ± EMT  <br>"+"/"+um,"mpe", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	
			
		
	 		report.setDataSource(createDataSourceLinearita(lista_linearita, campo));
	 		
	 		report.highlightDetailEvenRows();


		return report;
	}


	private JasperReportBuilder getTableAccuratezza(ArrayList<VerAccuratezzaDTO> lista_accuratezza, int campo) throws Exception {
		
	
		JasperReportBuilder report = DynamicReports.report();			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Rif.","rif", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));			
	 		report.addColumn(col.column("Massa  <br><i> L </i> <br> "+"/"+um,"massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		report.addColumn(col.column("Indicazione  <br> <i>I </i> <br>"+"/"+um,"indicazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		if(tipologia_strumento == 1) {
	 			report.addColumn(col.column("Carico aggiuntivo  <br> <i>ΔL </i> <br>"+"/"+um,"carico_aggiuntivo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));	
	 		}
	 			 		
	 		report.addColumn(col.column("Errore <br> <i>E </i> <br>"+"/"+um,"e", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	//	if(tipologia_strumento == 1) {
	 			report.addColumn(col.column("Errore Corretto  <br><i> Ec </i> <br>"+"/"+um,"ec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	//	}
	 		report.addColumn(col.column("Errore Massimo Tollerato <br> ± EMT  <br> "+"/"+um,"mpe", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		
	 		//report.getReport().setColspan(2, 2, "Estimated");
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSourceAccuratezza(lista_accuratezza, campo));
	 		
	 		report.highlightDetailEvenRows();


		return report;
	}
	
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableRipetibilita(ArrayList<VerRipetibilitaDTO> lista_ripetibilita, int campo) throws Exception{

		
		JasperReportBuilder report = DynamicReports.report();

		try {			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("N° Ripet.","n_ripetizioni", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Massa  <br> <i>L </i> <br>"+"/"+um,"massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Indicazione  <br><i> I </i> <br>" +"/"+um,"indicazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));
	 		if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
	 			report.addColumn(col.column("Carico aggiuntivo   <br><i> ΔL </i> <br>"+"/"+um,"carico_aggiuntivo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		}
	 		report.addColumn(col.column("Indicazione  <br> <i>P </i> <br> "+"/"+um,"p", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));
	 			 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSourceRipetibilita(lista_ripetibilita, campo));
	 		
	 		report.highlightDetailEvenRows();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableRipetibilitaSmall(ArrayList<VerRipetibilitaDTO> lista_ripetibilita, int campo) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			
			int risoluzioneBilanciaE0=getE(campo,BigDecimal.ZERO).scale()+1;

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("<i>P</i>max - <i>P</i>min = ","1", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(80));
			
	 		report.addColumn(col.column( Utility.changeDotComma(lista_ripetibilita.get((campo-1)*6).getDeltaPortata().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()),"2", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column(um,um, type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(20));
	 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.highlightDetailEvenRows();
			
	 		String[] listaCodici = null;
			
			listaCodici = new String[5];
			
			listaCodici[0]="1";
			listaCodici[1]="2";
			listaCodici[2]= um;
	 		
			DRDataSource dataSource = new DRDataSource(listaCodici);
			for (VerRipetibilitaDTO item : lista_ripetibilita) {
				if(item.getMpe()!=null && item.getCampo() == campo) {
					dataSource.add("± EMT <br>(associato al \"carico di prova\"):", Utility.changeDotComma(item.getMpe().stripTrailingZeros().toPlainString()), um);
					break;
				}
			}
	
			
			report.setDataSource(dataSource);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	

	private JasperReportBuilder getTableMobilita(ArrayList<VerMobilitaDTO> lista_mobilita, int caso, int campo) throws Exception {
		

		JasperReportBuilder report = DynamicReports.report();			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			
			report.addColumn(col.column("Carico","carico", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));			
	 		report.addColumn(col.column("Massa <br> <i>L </i> <br> "+"/"+um,"massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		report.addColumn(col.column("Indicazione <br><i> I<sub>1</sub> </i> <br>"+"/"+um,"i1", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));	 		
	 		report.addColumn(col.column("Carico aggiuntivo =<br> |EMTcarico| <br> <i>ΔL</i> <br>"+"/"+um,"carico_aggiuntivo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));	 		
	 		report.addColumn(col.column("Indicazione <br><i> I<sub>2</sub> </i> <br>"+"/"+um,"i2", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));	 		
	 		report.addColumn(col.column("Differenza  <br><i> I<sub>2</sub> - I<sub>1</sub></i> <br>"+"/"+um,"differenza", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		if(caso==1) {
	 			report.addColumn(col.column("Div. reale strumento <br> d  <br>"+"/"+um,"div_reale", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		 		report.addColumn(col.column("Check <br> <i>|I<sub>2</sub> - I<sub>1</sub>| </i>≥ <i>d</i <br>","check", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));	
	 		}else {
	 			report.addColumn(col.column("0,7 Carico Aggiuntivo =  <br> 0,7 EMT </i> <br>"+"/"+um,"div_reale", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		 		report.addColumn(col.column("Check  <br> <i>|I<sub>2</sub> - I<sub>1</sub>|</i> ≥<br>0,7 EMT ","check", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 		}
	 		
	 		
	 		//report.getReport().setColspan(2, 2, "Estimated");
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSourceMobilita(lista_mobilita, caso, campo));
	 		
	 		report.highlightDetailEvenRows();


		return report;
	}
	
	
	
	private JRDataSource createDataSourceRipetibilita(ArrayList<VerRipetibilitaDTO> lista_ripetibilita,int campo)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
		if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
			listaCodici = new String[5];
			
			listaCodici[0]="n_ripetizioni";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";
			listaCodici[3]="carico_aggiuntivo";
			listaCodici[4]="p";	
		}else {
			listaCodici = new String[4];
			
			listaCodici[0]="n_ripetizioni";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";			
			listaCodici[3]="p";	
		}			
		


			dataSource = new DRDataSource(listaCodici);			
		
			for (VerRipetibilitaDTO item : lista_ripetibilita) {				
				if(item.getMassa()!=null && item.getCampo()== campo) {
					
					
					int risoluzioneBilanciaE0=getE(campo,BigDecimal.ZERO).scale()+1;
					int risoluzioneBilancia=getE(campo, item.getMassa()).scale()+1;
					int risoluzioneIndicazione=getE(campo, item.getMassa()).scale();
					
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					if(item.getNumeroRipetizione()!=0) {
						arrayPs.add(String.valueOf(item.getNumeroRipetizione()));
					}else {
						arrayPs.add("");
					}
					
					arrayPs.add(Utility.changeDotComma(item.getMassa().stripTrailingZeros().toPlainString()));
					
					if(item.getIndicazione()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getIndicazione().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));		
					}else {
						arrayPs.add("");
					}
					if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
						if(item.getCaricoAgg()!=null) {
							arrayPs.add(Utility.changeDotComma(item.getCaricoAgg().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));	
						}else {
							arrayPs.add("");
						}
					}
					if(item.getPortata()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getPortata().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));
					}else {
						arrayPs.add("");
					}
										
					dataSource.add(arrayPs.toArray());
					
				}				
			}			
			
			
	 		return dataSource;
	 	}
	
	
	
	
	private JRDataSource createDataSourceDecentramento(ArrayList<VerDecentramentoDTO> lista_decentramento, int campo)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;

		if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
			
			listaCodici = new String[7];			
			
			listaCodici[0]="n_posizione";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";
			listaCodici[3]="carico_aggiuntivo";
			listaCodici[4]="e";
			listaCodici[5]="ec";
			listaCodici[6]="mpe";
		}else {
			
			listaCodici = new String[6];			
			
			listaCodici[0]="n_posizione";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";			
			listaCodici[3]="e";
			listaCodici[4]="ec";
			listaCodici[5]="mpe";
		}
		
		
			dataSource = new DRDataSource(listaCodici);			
		
			for (VerDecentramentoDTO item : lista_decentramento) {				
				if(item.getMassa()!=null && item.getCampo()==campo) {
					
					
					int risoluzioneBilanciaE0=getE(campo, BigDecimal.ZERO).scale()+1;
					int risoluzioneBilancia=getE(campo,item.getMassa()).scale()+1;
					int risoluzioneIndicazione=getE(campo,item.getMassa()).scale();
					
					
					ArrayList<String> arrayPs = new ArrayList<String>();		
					if((item.getPosizione()%2)!=0) {
						arrayPs.add("<i><i>E<sub>0</sub></i></i>");
					}else {
						arrayPs.add(String.valueOf(item.getPosizione()/2));
					}					
					arrayPs.add(Utility.changeDotComma(item.getMassa().stripTrailingZeros().toPlainString()));
					if(item.getIndicazione()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getIndicazione().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));	
					}else {
						arrayPs.add("");
					}
					if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
						if(item.getCaricoAgg()!=null) {
							arrayPs.add(Utility.changeDotComma(item.getCaricoAgg().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));
						}else {
							arrayPs.add("");
						}
					}
					
					if(item.getErrore()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getErrore().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));	
					}else {
						arrayPs.add("");
					}
					if(item.getErroreCor()!=null) {
						if((item.getPosizione()%2)!=0) {
							arrayPs.add("/");
						}else {
							arrayPs.add(Utility.changeDotComma(item.getErroreCor().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));	
						}
							
					}else {
						arrayPs.add("");
					}
					if(item.getMpe()!=null) {
//						if((item.getPosizione()%2)!=0){
//							arrayPs.add(Utility.changeDotComma(item.getMpe().toPlainString()));	
//						}else {
							arrayPs.add(Utility.changeDotComma(item.getMpe().stripTrailingZeros().toPlainString()));		
//						}
						
					}else {
						arrayPs.add("");
					}
						
					dataSource.add(arrayPs.toArray());
					
				}				
			}			
			
			
	 		return dataSource;
	 	}
	
	private JRDataSource createDataSourceLinearita(ArrayList<VerLinearitaDTO> lista_linearita, int campo) {
		
		DRDataSource dataSource = null;
		String[] listaCodici = null;
					
		if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
			listaCodici = new String[11];			
			
			listaCodici[0]="rif";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione_up";
			listaCodici[3]="indicazione_down";
			listaCodici[4]="carico_aggiuntivo_up";
			listaCodici[5]="carico_aggiuntivo_down";
			listaCodici[6]="e_up";
			listaCodici[7]="e_down";
			listaCodici[8]="ec_up";
			listaCodici[9]="ec_down";
			listaCodici[10]="mpe";
		}else {
			
			listaCodici = new String[9];			
			
			listaCodici[0]="rif";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione_up";
			listaCodici[3]="indicazione_down";
			listaCodici[4]="e_up";
			listaCodici[5]="e_down";
			listaCodici[6]="ec_up";
			listaCodici[7]="ec_down";
			listaCodici[8]="mpe";
		}
			
			
			dataSource = new DRDataSource(listaCodici);			
			int rif = 0;
			for (VerLinearitaDTO item : lista_linearita) {				
				if(item.getMassa()!=null && item.getCampo()==campo) {
					
					int risoluzioneBilanciaE0=getE(campo, BigDecimal.ZERO).scale()+1;
					int risoluzioneBilancia=getE(campo, item.getMassa()).scale()+1;
					int risoluzioneIndicazione=getE(campo, item.getMassa()).scale();
					
					ArrayList<String> arrayPs = new ArrayList<String>();
					if(rif==0) {
						arrayPs.add("<i>E<sub>0</sub></i>");
					}else {
						arrayPs.add(""+rif);
					}					
					arrayPs.add(Utility.changeDotComma(item.getMassa().stripTrailingZeros().toPlainString()));
					if(item.getIndicazioneSalita()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getIndicazioneSalita().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));
					}else {
						arrayPs.add("");
					}
					if(item.getIndicazioneDiscesa()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getIndicazioneDiscesa().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));
					}else {
						arrayPs.add("");
					}
					
					if(tipologia_strumento == 1 && classe_strumento!=5 && classe_strumento!=6) {
						if(item.getCaricoAggSalita()!=null) {
							arrayPs.add(Utility.changeDotComma(item.getCaricoAggSalita().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));
						}else {
							arrayPs.add("");
						}
						if(item.getCaricoAggDiscesa()!=null) {
							arrayPs.add(Utility.changeDotComma(item.getCaricoAggDiscesa().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));
						}else {
							arrayPs.add("");
						}
					}
					
					if(item.getErroreSalita()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getErroreSalita().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));
					}else {
						arrayPs.add("");
					}
					if(item.getErroreDiscesa()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getErroreDiscesa().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));
					}else {
						arrayPs.add("");
					}
					if(item.getErroreCorSalita()!=null) {
						if(rif==0) {
							arrayPs.add("/");
						}else {
							arrayPs.add(Utility.changeDotComma(item.getErroreCorSalita().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));	
						}
							
					}else {
						arrayPs.add("");
					}
					if(item.getErroreCorDiscesa()!=null) {
						if(rif==0) {
							arrayPs.add("/");
						}else {
							arrayPs.add(Utility.changeDotComma(item.getErroreCorDiscesa().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));	
						}
						
					}else {
						arrayPs.add("");
					}
					if(item.getMpe()!=null) {						
						arrayPs.add(Utility.changeDotComma(item.getMpe().stripTrailingZeros().toPlainString()));	
					}else {
						arrayPs.add("");
					}
					
					dataSource.add(arrayPs.toArray());
					rif++;
				}				
			}			
			
			
	 		return dataSource;
	}
	
	
private JRDataSource createDataSourceAccuratezza(ArrayList<VerAccuratezzaDTO> lista_accuratezza, int campo) {
		
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
		
		if(tipologia_strumento == 1) {
			listaCodici = new String[7];			
			
			listaCodici[0]="rif";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";
			listaCodici[3]="carico_aggiuntivo";			
			listaCodici[4]="e";			
			listaCodici[5]="ec";			
			listaCodici[6]="mpe";
		
		}else {
			
			listaCodici = new String[6];			
			
			listaCodici[0]="rif";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";	
			listaCodici[3]="e";			
			listaCodici[4]="ec";	
			listaCodici[5]="mpe";
		}

			dataSource = new DRDataSource(listaCodici);			
		
			for (VerAccuratezzaDTO item : lista_accuratezza) {				
				if(item.getMassa()!=null && item.getCampo()==campo) {
					
					int risoluzioneBilanciaE0=getE(campo,BigDecimal.ZERO).scale()+1;
					int risoluzioneBilancia=getE(campo, item.getMassa()).scale()+1;
					int risoluzioneIndicazione=getE(campo, item.getMassa()).scale();
					
					ArrayList<String> arrayPs = new ArrayList<String>();
							
					arrayPs.add("<i>E<sub>T</sub></i>");
					
					
					arrayPs.add(Utility.changeDotComma(item.getMassa().stripTrailingZeros().toPlainString()));
					
					if(item.getIndicazione()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getIndicazione().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));		
					}else {
						arrayPs.add("");
					}
					if(tipologia_strumento == 1) {
						if(item.getCaricoAgg()!=null) {
							arrayPs.add(Utility.changeDotComma(item.getCaricoAgg().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));	
						}else {
							arrayPs.add("");
						}
					}
					if(item.getErrore()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getErrore().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));
					}else {
						arrayPs.add("");
					}
					
					if(tipologia_strumento == 2) {
						
						arrayPs.add("/");
						
					}else {
						if(item.getErroreCor()!=null) {
							arrayPs.add(Utility.changeDotComma(item.getErroreCor().setScale(risoluzioneBilanciaE0, RoundingMode.HALF_UP).toPlainString()));
						}else {
							arrayPs.add("/");
						}
					}
					if(item.getMpe()!=null) {
						arrayPs.add(Utility.changeDotComma(item.getMpe().stripTrailingZeros().toPlainString()));
					}else {
						arrayPs.add("");
					}
					
					dataSource.add(arrayPs.toArray());
					
				}				
			}			
			
			
	 		return dataSource;
	}
	

private JRDataSource createDataSourceMobilita(ArrayList<VerMobilitaDTO> lista_mobilita, int caso, int campo) {
	
	DRDataSource dataSource = null;
	String[] listaCodici = null;
				
		listaCodici = new String[8];			
		
		listaCodici[0]="carico";
		listaCodici[1]="massa";
		listaCodici[2]="i1";			
		listaCodici[3]="carico_aggiuntivo";			
		listaCodici[4]="i2";			
		listaCodici[5]="differenza";			
		listaCodici[6]="div_reale";
		listaCodici[7]="check";
		
		
		dataSource = new DRDataSource(listaCodici);			
	
		for (VerMobilitaDTO item : lista_mobilita) {				
			if(item.getMassa()!=null && item.getCaso() == caso && item.getCampo()==campo) {
				
				
				int risoluzioneBilancia=getE(campo, item.getMassa()).scale()+1;
				int risoluzioneIndicazione=getE(campo, item.getMassa()).scale();
				
				ArrayList<String> arrayPs = new ArrayList<String>();
				
				if(item.getCarico()==1) {
					arrayPs.add("Min");
				}else if(item.getCarico()==2){
					arrayPs.add("1/2 Max");
				}else {
					arrayPs.add("Max");
				}
				
				arrayPs.add(Utility.changeDotComma(item.getMassa().stripTrailingZeros().toPlainString()));
				
				if(item.getIndicazione()!=null) {
					arrayPs.add(Utility.changeDotComma(item.getIndicazione().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));		
				}else {
					arrayPs.add("");
				}
				if(item.getCaricoAgg()!=null) {
					arrayPs.add(Utility.changeDotComma(item.getCaricoAgg().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));	
				}else {
					arrayPs.add("");
				}
				if(item.getPostIndicazione()!=null) {
					arrayPs.add(Utility.changeDotComma(item.getPostIndicazione().setScale(risoluzioneIndicazione, RoundingMode.HALF_UP).toPlainString()));	
				}else {
					arrayPs.add("");
				}
				if(item.getDifferenziale()!=null) {
					arrayPs.add(Utility.changeDotComma(item.getDifferenziale().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));
				}else {
					arrayPs.add("");
				}
				if(item.getDivisione()!=null) {
					if(caso==1) {
						arrayPs.add(Utility.changeDotComma(item.getDivisione().setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));
					}else {						
						arrayPs.add(Utility.changeDotComma(item.getCaricoAgg().multiply(new BigDecimal(0.7).setScale(1, RoundingMode.HALF_UP)).setScale(risoluzioneBilancia, RoundingMode.HALF_UP).toPlainString()));
					}
					
				}else {
					arrayPs.add("");
				}
				if(item.getCheck_punto()!=null) {
					arrayPs.add(item.getCheck_punto().toString());
				}else {
					arrayPs.add("");
				}
				
				dataSource.add(arrayPs.toArray());
				
			}				
		}			
		
		
 		return dataSource;
}

private JRDataSource createDataSourceLegalizzazione(Set<VerLegalizzazioneBilanceDTO> lista_legalizzazione_bilance) {
	

	DRDataSource dataSource = null;
	String[] listaCodici = null;
				
		listaCodici = new String[3];			
		
		listaCodici[0]="tipo_approvazione";
		listaCodici[1]="n_provvedimento";
		listaCodici[2]="data_provvedimento";
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		dataSource = new DRDataSource(listaCodici);			
	
		for (VerLegalizzazioneBilanceDTO item : lista_legalizzazione_bilance) {		
			ArrayList<String> arrayPs = new ArrayList<String>();			
			
			if(item.getTipo_approvazione()!=null) {
				arrayPs.add(item.getTipo_approvazione().getDescrizione());
			}else {
				arrayPs.add("");
			}
				
			if(item.getNumero_provvedimento()!=null) {
				arrayPs.add(item.getNumero_provvedimento());
			}else {
				arrayPs.add("");
			}
			
			if(item.getData_provvedimento()!=null) {
				arrayPs.add(df.format(item.getData_provvedimento()));
			}else {
				arrayPs.add("");
			}
							
				dataSource.add(arrayPs.toArray());
					
		}			
		
		
 		return dataSource;
}


private BigDecimal getE(int campo,  BigDecimal carico)
{

	BigDecimal e = BigDecimal.ZERO;
	
	int id_tipo_strumento = strumento.getTipo().getId();
	
	if(id_tipo_strumento==1) 
	{
		e=strumento.getDiv_rel_C1().stripTrailingZeros();
	}


	if(id_tipo_strumento==2 ) 
	{
		if(carico.doubleValue()>=0 && carico.doubleValue() <=strumento.getPortata_max_C1().doubleValue()) 
		{
			e=strumento.getDiv_rel_C1().stripTrailingZeros();
			return e;
		}
		if( strumento.getPortata_min_C2().doubleValue()!=0 && carico.doubleValue()>=strumento.getPortata_min_C2().doubleValue() && carico.doubleValue() <=strumento.getPortata_max_C2().doubleValue()) 
		{
			e=strumento.getDiv_rel_C2().stripTrailingZeros();
			return e;
		}
		if(strumento.getPortata_min_C3().doubleValue()!=0 && carico.doubleValue()>strumento.getPortata_min_C3().doubleValue() && carico.doubleValue() <=strumento.getPortata_max_C3().doubleValue()) 
		{
			e=strumento.getDiv_rel_C3().stripTrailingZeros();
			return e;
		}
	}

	if(id_tipo_strumento==3) 
	{
		if(campo==1) 
		{
			e=strumento.getDiv_rel_C1().stripTrailingZeros();
		}
		if(campo==2) 
		{
			e=strumento.getDiv_rel_C2().stripTrailingZeros();
		}
		if(campo==3) 
		{
			e=strumento.getDiv_rel_C3().stripTrailingZeros();
		}
	}


	return e;
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


public  void addRiemessione(int misuraOld,String path,String nuovo_rapporto, Session session) throws Exception {

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
	        Phrase p = new Phrase(String.format("Questo rapporto corregge il rapporto n. %s", misura.getNumeroRapporto().replaceAll("_", "-")), f);
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
	
		addRiemessioneOld(misura, nuovo_rapporto, session);
	
}


public  void addRiemessioneOld(VerMisuraDTO misuraOld,String nuovo_rapporto, Session session) throws Exception {

	String path = Costanti.PATH_FOLDER+"\\"+misuraOld.getVerIntervento().getNome_pack()+"\\Rapporto\\RAP"+misuraOld.getVerIntervento().getNome_pack()+"_"+misuraOld.getId()+""+misuraOld.getVerStrumento().getId()+".pdf";
	
		File tmpFile = new File(path+"tmp");
        PdfReader reader = new PdfReader(path);
        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(tmpFile));
        Font f = new Font(FontFamily.HELVETICA, 12);
        f.setColor(BaseColor.RED);
        int pages = reader.getNumberOfPages();
        for (int i=0; i<pages; i++) {	        
	        PdfContentByte over = stamper.getOverContent(i+1);
	        Phrase p = new Phrase(String.format("Questo rapporto è stato sostituito dal rapporto %s", nuovo_rapporto), f);
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
	
	public static void main(String[] args) throws Exception {
	new ContextListener().configCostantApplication();
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	
	VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(131, session);
	//String pathImage="C:\\Users\\raffaele.fantini\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\livella.png";
	List<SedeDTO> listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
	UtenteDTO utente = GestioneUtenteBO.getUtenteById("11", session);

	new CreateVerRapporto(misura, listaSedi, false, 42,utente, session);
		session.getTransaction().commit();
		session.close();
		System.out.println("FINITO");
}
	
	
	
}
