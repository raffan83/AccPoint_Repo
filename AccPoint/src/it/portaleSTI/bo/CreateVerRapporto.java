package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import TemplateReport.ImageReport.PivotTemplateImage;
import TemplateReportLAT.ImageReport.PivotTemplateLAT_Image;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
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
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.StretchType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.expression.DRIExpression;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.components.list.VerticalFillList;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

public class CreateVerRapporto {
	
	public CreateVerRapporto(VerMisuraDTO misura, List<SedeDTO> listaSedi, boolean conforme, int motivo,  Session session) throws Exception {
		
		build(misura, listaSedi, conforme, motivo, session);
	}

	private void build(VerMisuraDTO misura, List<SedeDTO> listaSedi, boolean conforme, int motivo,  Session session) throws Exception {
		
		InputStream is = null;
		if(misura.getVerStrumento().getTipo().getId()==1) {
			is = PivotTemplate.class.getResourceAsStream("VerRapportoCSP1.jrxml");
		}else if(misura.getVerStrumento().getTipo().getId()==2) {
			is = PivotTemplate.class.getResourceAsStream("VerRapportoDPP1.jrxml");
		}else {
			is = PivotTemplate.class.getResourceAsStream("VerRapportoCPP1.jrxml");
		}
		
		ArrayList<VerAccuratezzaDTO> lista_accuratezza = GestioneVerMisuraBO.getListaAccuratezza(misura.getId(), session);
		ArrayList<VerLinearitaDTO> lista_linearita = GestioneVerMisuraBO.getListaLinearita(misura.getId(), session);
		ArrayList<VerDecentramentoDTO> lista_decentramento = GestioneVerMisuraBO.getListaDecentramento(misura.getId(), session);
		ArrayList<VerMobilitaDTO> lista_mobilita = GestioneVerMisuraBO.getListaMobilita(misura.getId(), session);
		ArrayList<VerRipetibilitaDTO> lista_ripetibilita = GestioneVerMisuraBO.getListaRipetibilita(misura.getId(), session);
		
		InputStream is2 =  PivotTemplate.class.getResourceAsStream("VerCheckList.jrxml");
		InputStream is3 =  PivotTemplate.class.getResourceAsStream("VerRapportoHeader.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		JasperReportBuilder reportP2 = DynamicReports.report();
		JasperReportBuilder reportP3 = DynamicReports.report();
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);

		report.setDataSource(new JREmptyDataSource());		
		report.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		reportP2.setTemplateDesign(is2);
		reportP2.setTemplate(Templates.reportTemplate);

		reportP2.setDataSource(new JREmptyDataSource());		
		reportP2.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		reportP3.setTemplateDesign(is3);
		reportP3.setTemplate(Templates.reportTemplate);

		reportP3.setDataSource(new JREmptyDataSource());		
		reportP3.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
	
		SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
		
		report.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		report.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));
		
		if(misura.getNumeroAttestato()!=null) {
			report.addParameter("numero_rapporto", misura.getNumeroRapporto());
		}else {
			report.addParameter("numero_rapporto", "");
		}
		
		if(cliente!=null) {
			report.addParameter("denominazione_titolare", cliente.getNome());
		}else {
			report.addParameter("denominazione_titolare", "");
		}
		if(cliente!=null && cliente.getIndirizzo()!=null) {
			report.addParameter("indirizzo", cliente.getIndirizzo());
		}else {
			report.addParameter("indirizzo", "");
		}
		
		if(cliente!=null && cliente.getPartita_iva()!=null) {
			report.addParameter("partita_iva", cliente.getPartita_iva());
		}else {
			report.addParameter("partita_iva", "");
		}
			
		if(sede!=null && sede.getIndirizzo()!=null) {
			report.addParameter("indirizzo_servizio", sede.getIndirizzo());
		}else {
			report.addParameter("indirizzo_servizio", "");
		}
		
		if(cliente!=null && cliente.getTelefono()!=null) {
			report.addParameter("telefono", cliente.getTelefono());
		}else {
			report.addParameter("telefono", "");
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
			report.addParameter("classe_precisione", misura.getVerStrumento().getClasse());
		}else{
			report.addParameter("classe_precisione", "");
		}
		
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
		
		if(misura.getVerStrumento().getUm()!=null) {
			report.addParameter("um", misura.getVerStrumento().getUm());
		}else{
			report.addParameter("um", "");
		}
		
		if(misura.getVerStrumento().getPortata_max_C1()!=null) {
			report.addParameter("portata_max_c1", misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros());
		}else{
			report.addParameter("portata_max_c1", "");
		}
		
		if(misura.getVerStrumento().getPortata_min_C1()!=null) {
			report.addParameter("portata_min_c1", misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros());
		}else{
			report.addParameter("portata_min_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_ver_C1()!=null) {
			report.addParameter("divisione_verifica_c1", misura.getVerStrumento().getDiv_ver_C1().stripTrailingZeros());
		}else{
			report.addParameter("divisione_verifica_c1", "");
		}
		
		if(misura.getVerStrumento().getDiv_rel_C1()!=null) {
			report.addParameter("divisione_reale_c1", misura.getVerStrumento().getDiv_rel_C1().stripTrailingZeros());
		}else{
			report.addParameter("divisione_reale_c1", "");
		}
		
		if(misura.getVerStrumento().getNumero_div_C1()!=null) {
			report.addParameter("numero_divisioni_c1", misura.getVerStrumento().getNumero_div_C1().stripTrailingZeros().toPlainString());
		}else{
			report.addParameter("numero_divisioni_c1", "");
		}
		if(misura.getVerStrumento().getTipo().getId()!=1) {
			if(misura.getVerStrumento().getTipo().getId()==2) {
				
				if(misura.getVerStrumento().getPortata_max_C3()!=null) {
					report.addParameter("portata_max", misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros());
				}else{
					if(misura.getVerStrumento().getPortata_max_C2()!=null) {
						report.addParameter("portata_max",  misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros());	
					}else {
						report.addParameter("portata_max",  "");
					}				
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null) {
					report.addParameter("portata_min", misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros());
				}else{
					report.addParameter("portata_min", "");
				}
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("min1", misura.getVerStrumento().getPortata_min_C1().stripTrailingZeros());	
				}else {
					report.addParameter("min1", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("min2",  misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros());
				}else {
					report.addParameter("min2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("min3", misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros());	
				}else {
					report.addParameter("min3", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("max1", misura.getVerStrumento().getPortata_max_C1().stripTrailingZeros());	
				}else {
					report.addParameter("max1", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("max2",misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros());
				}else {
					report.addParameter("max2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C1()!=null && misura.getVerStrumento().getPortata_max_C1()!=null) {
					report.addParameter("max3", misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros());	
				}else {
					report.addParameter("max3", "");
				}
				
				
			}	
			else if(misura.getVerStrumento().getTipo().getId()==3) {
				
				if(misura.getVerStrumento().getPortata_max_C2()!=null) {
					report.addParameter("portata_max_c2", misura.getVerStrumento().getPortata_max_C2().stripTrailingZeros());
				}else{
					report.addParameter("portata_max_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C2()!=null) {
					report.addParameter("portata_min_c2", misura.getVerStrumento().getPortata_min_C2().stripTrailingZeros());
				}else{
					report.addParameter("portata_min_c2", "");
				}
				
				if(misura.getVerStrumento().getPortata_max_C3()!=null) {
					report.addParameter("portata_max_c3", misura.getVerStrumento().getPortata_max_C3().stripTrailingZeros());
				}else{
					report.addParameter("portata_max_c3", "");
				}
				
				if(misura.getVerStrumento().getPortata_min_C3()!=null) {
					report.addParameter("portata_min_c3", misura.getVerStrumento().getPortata_min_C3().stripTrailingZeros());
				}else{
					report.addParameter("portata_min_c3", "");
				}
			}			
			
			if(misura.getVerStrumento().getDiv_ver_C2()!=null) {
				report.addParameter("divisione_verifica_c2", misura.getVerStrumento().getDiv_ver_C2().stripTrailingZeros());
			}else{
				report.addParameter("divisione_verifica_c2", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C2()!=null) {
				report.addParameter("divisione_reale_c2", misura.getVerStrumento().getDiv_rel_C2().stripTrailingZeros());
			}else{
				report.addParameter("divisione_reale_c2", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C2()!=null) {
				report.addParameter("numero_divisioni_c2", misura.getVerStrumento().getNumero_div_C2().stripTrailingZeros().toPlainString());
			}else{
				report.addParameter("numero_divisioni_c2", "");
			}
			
			
			if(misura.getVerStrumento().getDiv_ver_C3()!=null) {
				report.addParameter("divisione_verifica_c3", misura.getVerStrumento().getDiv_ver_C3().stripTrailingZeros());
			}else{
				report.addParameter("divisione_verifica_c3", "");
			}
			
			if(misura.getVerStrumento().getDiv_rel_C3()!=null) {
				report.addParameter("divisione_reale_c3", misura.getVerStrumento().getDiv_rel_C3().stripTrailingZeros());
			}else{
				report.addParameter("divisione_reale_c3", "");
			}
			
			if(misura.getVerStrumento().getNumero_div_C3()!=null) {
				report.addParameter("numero_divisioni_c3", misura.getVerStrumento().getNumero_div_C3().stripTrailingZeros().toPlainString());
			}else{
				report.addParameter("numero_divisioni_c3", "");
			}
		}
		
		report.addParameter("registro", ""); //MANCA REGISTRO
		report.addParameter("procedura", ""); //MANCA PROCEDURA
		report.addParameter("firma_operatore", ""); //MANCA FIRMA
		
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
		
		if(misura.getDataVerificazione()!=null) {
			report.addParameter("data", df.format(misura.getDataVerificazione()));
		}else {
			report.addParameter("data","");
		}
		
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		reportP2.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		reportP2.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));
		
		if(misura.getNumeroAttestato()!=null) {
			reportP2.addParameter("numero_rapporto", misura.getNumeroRapporto());
		}else {
			reportP2.addParameter("numero_rapporto", "");
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
		
		reportP2.addParameter("firma_operatore", ""); //MANCA FIRMA
		
		if(misura.getDataVerificazione()!=null) {
			reportP2.addParameter("data", df.format(misura.getDataVerificazione()));
		}else {
			reportP2.addParameter("data","");
		}
		
		JasperPrint jasperPrint2 = reportP2.toJasperPrint();
		jasperPrintList.add(jasperPrint2);
		
		reportP3.addParameter("logo_accredia",PivotTemplateLAT_Image.class.getResourceAsStream("accredia.png"));
		reportP3.addParameter("logo",PivotTemplateLAT_Image.class.getResourceAsStream("sti.jpg"));
		
		VerticalListBuilder vl_general = cmp.verticalList();
		
		SubreportBuilder subreport_ripetibilita = cmp.subreport(getTableRipetibilita(lista_ripetibilita));		
		SubreportBuilder subreport_ripetibilita_2 = cmp.subreport(getTableRipetibilitaSmall(lista_ripetibilita, misura.getVerStrumento().getUm()));
		
		HorizontalListBuilder hl_ripetibilita = cmp.horizontalList(subreport_ripetibilita,cmp.horizontalGap(10), subreport_ripetibilita_2).setFixedWidth(550);
		
		VerticalListBuilder vl_ripetibilita = cmp.verticalList(cmp.text("Prova di Ripetibilità (Rif.UNI CEI EN 45501:2015: A.4.10)"), cmp.verticalGap(10),hl_ripetibilita, cmp.verticalGap(10),cmp.horizontalList(cmp.horizontalGap(400), cmp.text("ESITO: "+ lista_ripetibilita.get(0).getEsito()) ));
		
		vl_general.add(vl_ripetibilita);
		
		SubreportBuilder subreport_decentramento = cmp.subreport(getTableDecentramento(lista_decentramento));
		
		VerticalListBuilder vl_decentramento = cmp.verticalList(cmp.text("Prova di Decentramento (Rif.UNI CEI EN 45501:2015: A.4.7)"), cmp.text("Esempio di tipici ricettori di carico").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		
		//InputStream im1 = new BufferedInputStream(new FileInputStream("source.gif")); 
		InputStream im0 = PivotTemplateImage.class.getResourceAsStream("tipo_0.png");
		InputStream im1 = PivotTemplateImage.class.getResourceAsStream("tipo_1.png");
		InputStream im2 = PivotTemplateImage.class.getResourceAsStream("tipo_2.png");
		HorizontalListBuilder hl_ricettori = cmp.horizontalList(cmp.horizontalGap(190),cmp.image(im0).setFixedDimension(60, 60), cmp.horizontalGap(5), cmp.image(im1).setFixedDimension(60, 60), cmp.horizontalGap(5), cmp.image(im2).setFixedDimension(60, 60));
		HorizontalListBuilder hl_rettangoli = cmp.horizontalList(cmp.horizontalGap(215));
		StyleBuilder style = stl.style().setBorder(stl.penThin()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFontSize(14);
		String lbl0 = "";
		String lbl1 = "";
		String lbl2 = "";
		
		if(lista_decentramento.get(0).getTipoRicettore()==0) {
			lbl0="X";
			lbl1="";
			lbl2="";
		}else if(lista_decentramento.get(0).getTipoRicettore()==1) {
			lbl0="";
			lbl1="X";
			lbl2="";
		}else {
			lbl0="";
			lbl1="";
			lbl2="X";
		}
		
		hl_rettangoli.add(cmp.text(lbl0).setStyle(style).setFixedDimension(15, 15),cmp.horizontalGap(47),cmp.text(lbl1).setStyle(style).setFixedDimension(15, 15),cmp.horizontalGap(47),cmp.text(lbl2).setStyle(style).setFixedDimension(15, 15));
		String speciale = "";
		if(lista_decentramento.get(0).getSpeciale().equals("N")) {
			speciale = "No";
		}else {
			speciale = "Si";
		}
		vl_decentramento.add(hl_ricettori,
				hl_rettangoli,
				cmp.verticalGap(5),
				cmp.horizontalList(cmp.text("Numero punti di appoggi del ricettore di carico: "+ lista_decentramento.get(0).getPuntiAppoggio()),
						cmp.horizontalGap(20), 
						cmp.text("Carico: " + lista_decentramento.get(0).getCarico() +" " + misura.getVerStrumento().getUm())),
				cmp.verticalGap(5),
				cmp.text("Strumento \"Speciale\": "+ speciale),								
				subreport_decentramento);
				
				
		vl_general.add(cmp.verticalGap(10), 
				vl_decentramento,
				cmp.horizontalList(cmp.horizontalGap(400),
				cmp.text("ESITO: "+lista_decentramento.get(0).getEsito())));
		
		reportP3.addDetail(vl_general);
		reportP3.ignorePagination();
		
		JasperPrint jasperPrint3 = reportP3.toJasperPrint();
		jasperPrintList.add(jasperPrint3);
		
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
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		
	}
	
	
	private JasperReportBuilder getTableDecentramento(ArrayList<VerDecentramentoDTO> lista_decentramento) throws Exception {
		
		JasperReportBuilder report = DynamicReports.report();
			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Posizione n°","n_posizione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Massa","massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Indicazione","indicazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));
	 		report.addColumn(col.column("Carico aggiuntivo","carico_aggiuntivo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Errore","e", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Er. Corretto","ec", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("MPE","mpe", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 			 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSourceDecentramento(lista_decentramento));
	 		
	 		report.highlightDetailEvenRows();


		return report;
	}


	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableRipetibilita(ArrayList<VerRipetibilitaDTO> lista_ripetibilita) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("N° Ripet.","n_ripetizioni", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Massa","massa", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Indicazione","indicazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));
	 		report.addColumn(col.column("Carico aggiuntivo","carico_aggiuntivo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("P","p", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 			 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSourceRipetibilita(lista_ripetibilita));
	 		
	 		report.highlightDetailEvenRows();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableRipetibilitaSmall(ArrayList<VerRipetibilitaDTO> lista_ripetibilita, String um) throws Exception{

		JasperReportBuilder report = DynamicReports.report();

		try {			

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Pmax - Pmin.","1", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(70));
	 		report.addColumn(col.column(lista_ripetibilita.get(0).getDeltaPortata().toPlainString(),"2", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column(um,um, type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(20));
	 	
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.highlightDetailEvenRows();
			
	 		String[] listaCodici = null;
			
			listaCodici = new String[5];
			
			listaCodici[0]="1";
			listaCodici[1]="2";
			listaCodici[2]= um;
	 		
			DRDataSource dataSource = new DRDataSource(listaCodici);		
	 		
			dataSource.add("MPE (asocciato al carico di prova):", lista_ripetibilita.get(0).getMpe().toPlainString(), um);
			report.setDataSource(dataSource);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return report;
	}
	
	private JRDataSource createDataSourceRipetibilita(ArrayList<VerRipetibilitaDTO> lista_ripetibilita)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
					
			listaCodici = new String[5];
			
			listaCodici[0]="n_ripetizioni";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";
			listaCodici[3]="carico_aggiuntivo";
			listaCodici[4]="p";	

			dataSource = new DRDataSource(listaCodici);			
		
			for (VerRipetibilitaDTO item : lista_ripetibilita) {				
				if(item.getMassa()!=null) {
					ArrayList<String> arrayPs = new ArrayList<String>();
					arrayPs.add(String.valueOf(item.getNumeroRipetizione()));
					arrayPs.add(String.valueOf(item.getMassa()));
					arrayPs.add(item.getIndicazione().toString());
					arrayPs.add(item.getCaricoAgg().toString());
					arrayPs.add(item.getPortata().toString());		
					dataSource.add(arrayPs.toArray());
					
				}				
			}			
			
			
	 		return dataSource;
	 	}
	
	
	
	
	private JRDataSource createDataSourceDecentramento(ArrayList<VerDecentramentoDTO> lista_decentramento)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
					
			listaCodici = new String[7];			
			
			listaCodici[0]="n_posizione";
			listaCodici[1]="massa";
			listaCodici[2]="indicazione";
			listaCodici[3]="carico_aggiuntivo";
			listaCodici[4]="e";
			listaCodici[5]="ec";
			listaCodici[6]="mpe";

			dataSource = new DRDataSource(listaCodici);			
		
			for (VerDecentramentoDTO item : lista_decentramento) {				
				if(item.getMassa()!=null) {
					ArrayList<String> arrayPs = new ArrayList<String>();
					arrayPs.add(String.valueOf(item.getPosizione()));
					arrayPs.add(String.valueOf(item.getMassa()));
					arrayPs.add(item.getIndicazione().toString());
					arrayPs.add(item.getCaricoAgg().toString());
					arrayPs.add(item.getErrore().toString());		
					arrayPs.add(item.getErroreCor().toString());
					arrayPs.add(item.getMpe().toString());
					dataSource.add(arrayPs.toArray());
					
				}				
			}			
			
			
	 		return dataSource;
	 	}
	
	
	public static void main(String[] args) throws Exception {
	new ContextListener().configCostantApplication();
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	
	VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(13, session);
	//String pathImage="C:\\Users\\raffaele.fantini\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\livella.png";
	List<SedeDTO> listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	

	new CreateVerRapporto(misura, listaSedi, false, 3, session);
		session.getTransaction().commit();
		session.close();
		System.out.println("FINITO");
}
	
}
