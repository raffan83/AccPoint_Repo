package it.portaleSTI.bo;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.field;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import it.arubapec.arubasignservice.ArubaSignService;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;

import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;

import java.awt.Color;
import java.awt.Image;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.component.ComponentBuilder;
import net.sf.dynamicreports.report.builder.component.HorizontalListBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.TextFieldBuilder;
import net.sf.dynamicreports.report.builder.component.VerticalListBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalImageAlignment;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.ImageScale;
import net.sf.dynamicreports.report.constant.Markup;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import org.apache.commons.lang3.StringUtils;
import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import TemplateReport.PivotTemplate;
import com.google.gson.JsonObject;

public class CreateCertificato {
	
	public File file;
	public JsonObject firmato;

	public CreateCertificato(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,String idoneo, Session session, ServletContext context, Boolean appenCertificati, Boolean multi, UtenteDTO utente) throws Exception {
		try {
			 Utility.memoryInfo();
			build(misura,certificato,lista, listaCampioni, listaProcedure, strumento,idoneo,session,context,appenCertificati,multi, utente);
			 Utility.memoryInfo();
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}

	@SuppressWarnings("deprecation")
	private void build(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,String idoneo, Session session, ServletContext context, Boolean appenCertificati, Boolean multi, UtenteDTO utente) throws Exception {
		String tipoScheda="";
		
		InputStream is = null;

		Iterator itLista = lista.entrySet().iterator();
		while (itLista.hasNext()) {

			Map.Entry pair = (Map.Entry)itLista.next();
			String pivot = pair.getKey().toString();		
			List<ReportSVT_DTO> listItem = (List<ReportSVT_DTO>) pair.getValue();
			SubreportBuilder subreport = null;
			
			if(pivot.startsWith("R_S") || pivot.startsWith("L_S") || pivot.startsWith("D_S")){
				is = PivotTemplate.class.getResourceAsStream("schedaVerificaHeaderSvt_EN.jrxml");
				tipoScheda="SVT";
			}
			if(pivot.startsWith("R_R") || pivot.startsWith("L_R") || pivot.startsWith("D_R")){
				is = PivotTemplate.class.getResourceAsStream("schedaVerificaHeaderRDT_EN.jrxml");
				tipoScheda="RDT";
			}
			if(pivot.equals("RDP")) 
			{
				is = PivotTemplate.class.getResourceAsStream("schedaVerificaHeaderRDP_EN.jrxml");
				tipoScheda="RDP";
			}
		
		}
	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		

		
		JasperReportBuilder report = DynamicReports.report();

		
			SubreportBuilder procedureSubreport = cmp.subreport(getTableProcedure(listaProcedure, tipoScheda));
		
		StyleBuilder styleTitleBold = Templates.rootStyle.setFontSize(10).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);
		TextFieldBuilder rifTextfield = null;
		if(!tipoScheda.equalsIgnoreCase("RDP")) {
			rifTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_CAMPIONI + " - " +CostantiCertificato.TITOLO_LISTA_CAMPIONI_EN);
			rifTextfield.setStyle(styleTitleBold);
		}else {
			rifTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_CAMPIONI_RDP + " - " +CostantiCertificato.TITOLO_LISTA_CAMPIONI_RDP_EN);
			rifTextfield.setStyle(styleTitleBold);
		}
		TextFieldBuilder ristTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_MISURE + " - " + CostantiCertificato.TITOLO_LISTA_MISURE_EN);
		ristTextfield.setStyle(styleTitleBold);
		if(tipoScheda.equals("RDP")) {
					
			ristTextfield = cmp.text("RISULTATI DELLA VERIFICA - <i>RESULTS</i>");
			ristTextfield.setStyle(styleTitleBold);
		}
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);
		
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);

		StyleBuilder style1test = stl.style().setBackgroundColor(new Color(230, 230, 230));

		try {
			File imageHeader = null;
			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany());
			ConfigurazioneClienteDTO conf = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(misura.getIntervento().getId_cliente(), misura.getIntervento().getIdSede(), misura.getStrumento().getTipoRapporto().getId(), session);
					if(conf != null && conf.getNome_file_logo()!=null && !conf.getNome_file_logo().equals("")) {
						imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+ "\\ConfigurazioneClienti\\"+misura.getIntervento().getId_cliente()+"\\"+misura.getIntervento().getIdSede()+"\\"+conf.getNome_file_logo());
					}else {
						imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany().getNomeLogo());
					}			

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
		
			report.addParameter("datiCliente",""+misura.getIntervento().getNome_cliente());
			report.addParameter("sedeCliente",""+misura.getIntervento().getNome_sede());
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			
			/*
			 * Aggiornata data Emissione su scadenzaDTO
			 */
		
				
				strumento.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
			//	scadenza.setDataEmissione(new java.sql.Date(System.currentTimeMillis()));
				
				if(tipoScheda.equals("SVT"))
				{
					
					if(!idoneo.equals("NON IDONEO - <i>UNSUITABLE</i>")) {
						Calendar c = Calendar.getInstance(); 
						c.setTime(misura.getDataMisura()); 
						c.add(Calendar.MONTH,strumento.getFrequenza());
						c.getTime();
						
						strumento.setDataProssimaVerifica(new java.sql.Date(c.getTime().getTime()));
					}else {
						
						strumento.setDataProssimaVerifica(null);
					}
					
					
					GestioneStrumentoBO.update(strumento, session);
					
					
					if(misura.getDataMisura()!=null){
						
						report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
											
						
					}else {
						report.addParameter("dataVerifica"," ");			
					}
					
				
					if(strumento.getDataProssimaVerifica()!=null){
						if(conf!=null && conf.getFmt_data_mese_anno()!=null && conf.getFmt_data_mese_anno().equals("S")) {
							LocalDate dataMisura = strumento.getDataProssimaVerifica().toLocalDate();
							
							 String formattedDate = dataMisura.format(DateTimeFormatter.ofPattern("MMMM/yyyy"));
							report.addParameter("dataProssimaVerifica",formattedDate.toUpperCase());
						}else {
							report.addParameter("dataProssimaVerifica",""+sdf.format(strumento.getDataProssimaVerifica()));
						}							
						
					}else {
						report.addParameter("dataProssimaVerifica","/");			
					}
					
					
					
					if(misura.getnCertificato()!=null){
						report.addParameter("svtNumber",misura.getnCertificato());
					}else {
						report.addParameter("svtNumber"," ");			
					}
					
					if(misura.getStatoRicezione() !=null && misura.getStatoRicezione().getNome()!=null){
						report.addParameter("comeRicevuto",misura.getStatoRicezione().getNome());
					}else {
						report.addParameter("comeRicevuto"," ");			
					}
					
				}

				if(tipoScheda.equals("RDT"))
				{
					
					Calendar c = Calendar.getInstance(); 
					c.setTime(misura.getDataMisura()); 
					c.add(Calendar.MONTH,12);
					c.getTime();
					
					strumento.setDataProssimaVerifica(new java.sql.Date(c.getTime().getTime()));
					
					GestioneStrumentoBO.update(strumento, session);
					if(!multi) {
						report.addParameter("dataEmissione",""+sdf.format(new Date()));
					//	report.addParameter("dataEmissione","17/03/2023");
					}else {
						report.addParameter("dataEmissione",""+sdf.format(certificato.getDataCreazione()));	
					}
					
					if(misura.getDataMisura() !=null){
						report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
					}else {
						report.addParameter("dataVerifica"," ");			
					}
					
					
					if(misura.getnCertificato() !=null){
						report.addParameter("rdtNumber",misura.getnCertificato());
					}else {
						report.addParameter("rdtNumber"," ");			
					}
				}
			
				if(tipoScheda.equals("RDP"))
				{
					GestioneStrumentoBO.update(strumento, session);
					
					if(!multi) {
						report.addParameter("dataEmissione",""+sdf.format(new Date()));
					}else {
						report.addParameter("dataEmissione",""+sdf.format(certificato.getDataCreazione()));	
					}
					if(misura.getDataMisura() !=null){
						report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
					}else {
						report.addParameter("dataVerifica"," ");			
					}
					
					
					if(misura.getnCertificato() !=null){
						report.addParameter("rdpNumber",misura.getnCertificato());
					}else {
						report.addParameter("rdpNumber"," ");			
					}
				}
				
				
				
			//if(tipoScheda.equals("RDP")) {
			if(strumento.getDenominazione()!=null && !strumento.getDenominazione().equals("")){
				report.addParameter("denominazione",strumento.getDenominazione());
			}else {
				report.addParameter("denominazione","/");			
			}
			
			
			if(strumento.getCodice_interno()!=null && !strumento.getCodice_interno().equals("")){
				report.addParameter("codiceInterno",strumento.getCodice_interno());
			}else {
				report.addParameter("codiceInterno","/");			
			}
			
			if(strumento.getCostruttore()!=null && !strumento.getCostruttore().equals("")){
				report.addParameter("costruttore",StringUtils.capitalize(strumento.getCostruttore().toLowerCase()));
			}else {
				report.addParameter("costruttore","/");
			}
			
			if(strumento.getModello()!=null && !strumento.getModello().equals("")){
				report.addParameter("modello",strumento.getModello());
			}else {
				report.addParameter("modello","/");
			}		
			
			if(strumento.getReparto()!=null && !strumento.getReparto().equals("")){
				report.addParameter("reparto",strumento.getReparto());
			}else {
				report.addParameter("reparto","/");
			}
			
			if(strumento.getUtilizzatore()!=null && !strumento.getUtilizzatore().equals("")){
				report.addParameter("utilizzatore",strumento.getUtilizzatore());
			}else {
				report.addParameter("utilizzatore","/");
			}
			
			if(strumento.getMatricola()!=null && !strumento.getMatricola().equals("")){
				report.addParameter("matricola",strumento.getMatricola());
			}else {
				report.addParameter("matricola","/");
			}
			
			if(strumento.getCampo_misura()!=null && !strumento.getCampo_misura().equals("")){
				report.addParameter("campoMisura",strumento.getCampo_misura());
			}else {
				report.addParameter("campoMisura","/");
			}
			if(strumento.getRisoluzione()!=null  && !strumento.getRisoluzione().equals("")){
				report.addParameter("risoluzione",strumento.getRisoluzione());
			}else {
				report.addParameter("risoluzione","/");
			}
			if(strumento.getClassificazione()!=null && strumento.getClassificazione().getDescrizione()!=null){
				report.addParameter("classificazione",strumento.getClassificazione().getDescrizione());
			}else {
				report.addParameter("classificazione","/");
			}
			
			if(strumento.getFrequenza()!=0){
				report.addParameter("frequenza",""+strumento.getFrequenza());
			}else {
				report.addParameter("frequenza","/");
			}
			
		    

		    LuogoVerificaDTO luogo =strumento.getLuogo();
		   
		    if(luogo!=null)
			{
		    	report.addParameter("luogoVerifica",luogo.getDescrizione());
			}else
			{
				report.addParameter("luogoVerifica","/");
			}
			

			
			if(misura.getTemperatura().setScale(2,RoundingMode.HALF_UP).toPlainString().equals("0.00")){
				report.addParameter("temperatura","/");
			}else{
				report.addParameter("temperatura",Utility.changeDotComma(misura.getTemperatura().setScale(2,RoundingMode.HALF_UP).toPlainString()));
			}
			if(misura.getUmidita().setScale(2,RoundingMode.HALF_UP).toPlainString().equals("0.00")){
				report.addParameter("umidita","/");
			}else{
				report.addParameter("umidita",Utility.changeDotComma(misura.getUmidita().setScale(2,RoundingMode.HALF_UP).toPlainString()));
			}
			
			
			if(imageHeader!=null) {
			report.addParameter("logo",imageHeader);
			if(!tipoScheda.equals("RDP"))
			report.addParameter("logo2",imageHeader);
			}

			report.setColumnStyle(textStyle); //AGG
			
			
			/*
			 * Dettaglio Campioni Utilizzati
			 */
			
			report.detail(rifTextfield);
			report.detail(cmp.verticalGap(2));
			
			
				SubreportBuilder campioniSubreport = cmp.subreport(getTableCampioni(listaCampioni, tipoScheda));
				//if(!tipoScheda.equals("RDP")) {
				report.detail(cmp.horizontalList(campioniSubreport.setFixedWidth(270),cmp.horizontalGap(20),procedureSubreport));
				report.detail(cmp.verticalGap(2));
				
//			}else {
//				report.detail(cmp.horizontalList(campioniSubreport));
//				report.detail(cmp.verticalGap(2));
//			}
			/*
			 * Dettaglio Procedure
			 */
			
//			TO DO da gestire
			
//			report.detail(procedureSubreport);
			report.detail(cmp.verticalGap(2));

			report.detail(cmp.line());
			report.detail(cmp.verticalGap(1));
			report.detail(cmp.line());
			report.detail(cmp.verticalGap(2));
			
			report.detail(ristTextfield);
			report.detail(cmp.verticalGap(2));

			 Iterator it = lista.entrySet().iterator();
			 int numberOfRow = 0;
			 int numberOfRowBefore = 0;
			 boolean validated=false;
			 boolean isFirtsPage=true;

			while (it.hasNext()) {
				
				numberOfRowBefore = numberOfRow;
				
				Map.Entry pair = (Map.Entry)it.next();
				String pivot = pair.getKey().toString();
				
				List<ReportSVT_DTO> listItem = (List<ReportSVT_DTO>) pair.getValue();
				
				SubreportBuilder subreport = null;
				if(pivot.startsWith("R_S")){
					numberOfRow += 2 + listItem.get(0).getTipoVerifica().size() * listItem.size();
					subreport = cmp.subreport(getTableReportRip(listItem, "SVT"));
				}
				if(pivot.startsWith("R_R")){
					numberOfRow += 2 + listItem.get(0).getTipoVerifica().size() * listItem.size();
					subreport = cmp.subreport(getTableReportRip(listItem, "RDT"));
				}
				if(pivot.startsWith("L_S")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportLin(listItem, "SVT"));
				}
				if(pivot.startsWith("L_R")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportLin(listItem, "RDT"));
				}
				if(pivot.equals("RDP")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportRDP(listItem, "RDP"));
				}
				if(pivot.startsWith("D_S")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportDec(listItem, "SVT"));
				}
				if(pivot.startsWith("D_R")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportDec(listItem, "RDT"));
				}
				numberOfRow=numberOfRow - numberOfRowBefore;
//				if(numberOfRow>11 && isFirtsPage){
//					report.detail(cmp.pageBreak());
//					validated=true;
//					isFirtsPage=false;
//					
//				}else if(numberOfRow>28 && !isFirtsPage){
//					report.detail(cmp.pageBreak());
//
//				}
				
				StyleBuilder styleTitleTableBold = stl.style(rootStyle).setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE).setBorder(stl.penThin());

				
if(listItem.get(0).getAsLeftAsFound() != null && listItem.get(0).getAsLeftAsFound().equals("ASF")){
	TextFieldBuilder rifTextfield1 = cmp.text("AS FOUND").setFixedWidth(120).setFixedHeight(15);
	rifTextfield1.setStyle(styleTitleTableBold);
	report.addDetail(rifTextfield1);
}
if(listItem.get(0).getAsLeftAsFound() != null && listItem.get(0).getAsLeftAsFound().equals("ASL")){
	TextFieldBuilder rifTextfield1 = cmp.text("AS LEFT").setFixedWidth(120).setFixedHeight(15);
	rifTextfield1.setStyle(styleTitleTableBold);
	report.addDetail(rifTextfield1);
}
			
				report.detail(subreport).setDetailSplitType(SplitType.IMMEDIATE);
				
				report.detail(cmp.verticalGap(10));
			
				
				it.remove();
			}

			int tipo_firma;
			if(conf!=null) {
				tipo_firma = conf.getId_firma();
			}else {
				tipo_firma = misura.getTipoFirma();
			}
			
			String nota_firma = "Documento firmato digitalmente con firma elettronica digitale certificata (PAdES)";
			
			
			String footer_right = CostantiCertificato.FOOTER_RIGHT;
			if(conf!=null && conf.getRevisione_certificato()!=null && !conf.getRevisione_certificato().equals("")) {
				footer_right = conf.getRevisione_certificato();
			}
			
			report.pageFooter(cmp.verticalList(
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(
							cmp.text(getFooterLeft(tipoScheda, tipo_firma, conf)).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							//cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							cmp.text(footer_right).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							)
					)
				);
			
			//FOOTER CERTIFICATO

			//Firma OP + RL
			String note_allegato = "";
			
			if(misura.getNote_allegato()!=null && !misura.getNote_allegato().equals("")) {
				note_allegato = " - " + misura.getNote_allegato();
			}
			
			
			if(tipo_firma == 0){
				
				String per ="";
				if(utente.getId()!=5) {
					per = "<i>per il </i>";
				}
				footer_right = CostantiCertificato.FOOTER_RIGHT;
				if(conf!=null && conf.getRevisione_certificato()!=null && !conf.getRevisione_certificato().equals("")) {
					footer_right = conf.getRevisione_certificato();
				}
				
				if(!tipoScheda.equals("RDP")) {					
					
				report.lastPageFooter(cmp.verticalList(
						cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
						cmp.line().setFixedHeight(1),	
						cmp.verticalGap(1),
						cmp.line().setFixedHeight(1),	
						
						
						cmp.text(CostantiCertificato.NOTE_LABEL+ Utility.checkStringNull(strumento.getNote()).concat(note_allegato)).setStyle(footerStyle).setFixedHeight(3),
						cmp.line().setFixedHeight(1),
						cmp.horizontalList(componentIdoneita(tipoScheda,cmp.horizontalList(
								cmp.verticalList(
										
										cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
										cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
										
								),cmp.verticalList(
										
										cmp.text(idoneo).setStyle(rootStyle)
										
								)
								)),								
				
							
							cmp.verticalList(
								
									cmp.horizontalList(
										cmp.verticalList(
//												cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
//												cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),												
//												cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+misura.getInterventoDati().getUtente().getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
												cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.verticalGap(10)
												
											),
										cmp.line().setFixedWidth(1),
										cmp.verticalList(
//												cmp.text(per+CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
//												cmp.text(utente.getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
//												cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
												cmp.text(per+CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.text(utente.getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.verticalGap(10)
											)
										)
										
								
								
								)
						),

						cmp.line().setFixedHeight(1),
						cmp.text(nota_firma).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(footerStyle),
						cmp.horizontalList(
							cmp.text(getFooterLeft(tipoScheda, tipo_firma, conf)).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							//cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							cmp.text(footer_right).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						)
						
						
						
						),
						cmp.text("")
//						,
//						cmp.text("")					
					);
			}else {
				report.lastPageFooter(cmp.verticalList(
						cmp.line().setFixedHeight(1),	
						cmp.verticalGap(1),
						cmp.line().setFixedHeight(1),	
						cmp.text(CostantiCertificato.NOTE_LABEL+ Utility.checkStringNull(strumento.getNote().concat(note_allegato))).setStyle(footerStyle).setFixedHeight(3),
						cmp.line().setFixedHeight(1),
						cmp.horizontalList(componentIdoneita(tipoScheda,cmp.horizontalList()),
							
							cmp.verticalList(
								
									cmp.horizontalList(
										cmp.verticalList(
												cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												//cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+misura.getInterventoDati().getUtente().getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
												cmp.verticalGap(10)
											),
										cmp.line().setFixedWidth(1),
										cmp.verticalList(
												cmp.text(per+CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.text(utente.getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.verticalGap(10)
												//cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
											)
										)
										
								
								
								)
						),

						cmp.line().setFixedHeight(1),
						cmp.text(nota_firma).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(footerStyle),
						cmp.horizontalList(
							cmp.text(getFooterLeft(tipoScheda, tipo_firma, conf)).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text(footer_right).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						)
						
						
						
						),
						cmp.text("")
//						,
//						cmp.text("")					
					);
				
			}
				
		}else if(tipo_firma == 2){//Firma OP + RL + CL
			
			String per ="";
			if(utente.getId()!=5) {
				per = "<i>per il </i>";
			}
			footer_right = CostantiCertificato.FOOTER_RIGHT;
			if(conf!=null && conf.getRevisione_certificato()!=null && !conf.getRevisione_certificato().equals("")) {
				footer_right = conf.getRevisione_certificato();
			}
			
			String cliente_label = "";
			if(misura.getNome_firma()!=null && !misura.getNome_firma().equals("")) {
				cliente_label = misura.getNome_firma();
			}
			VerticalListBuilder vertList = cmp.verticalList();
			if(misura.getFile_firma()!=null && !misura.getFile_firma().equals("")) {
				String path = Costanti.PATH_FOLDER+"\\"+misura.getIntervento().getNomePack()+"\\FileFirmaCliente\\" +misura.getFile_firma();
				File file = new File(path);
				Image image = ImageIO.read(file);
				vertList.add(
						cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.text(cliente_label).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						//cmp.verticalGap(10),
						//cmp.image(image).setFixedDimension(120, 15).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER));
						cmp.image(image).setHeight(20).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER));
			}else {
				vertList.add(					
						cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.text(cliente_label).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
			}
			
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+Utility.checkStringNull(strumento.getNote().concat(note_allegato))).setStyle(footerStyle).setFixedHeight(3),					
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(
							componentIdoneita(tipoScheda,
							cmp.horizontalList(
									cmp.verticalList(
											
											cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
											cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
									),cmp.verticalList(
											
											cmp.text(idoneo).setStyle(rootStyle)
									)
									))
							
						,
//						cmp.line().setFixedWidth(1),	
						
						cmp.verticalList(
							
								cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.verticalGap(10)
											//cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+misura.getInterventoDati().getUtente().getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text(per+CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text(utente.getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.verticalGap(10)
											//cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
										),
									cmp.line().setFixedWidth(1),
									vertList)
//									cmp.verticalList(
//											
//											
//											cmp.text(cliente_label).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
//										//	cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
//											cmp.image(image).setFixedDimension(120, 15).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER)
//										)
									//)
							
							
							)
					),

					cmp.line().setFixedHeight(1),
					cmp.text(nota_firma).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(footerStyle),
					cmp.horizontalList(
						cmp.text(getFooterLeft(tipoScheda, tipo_firma, conf)).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text(footer_right).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					)
					,
					cmp.text("")
					//,
					//cmp.text("")					
				);
		}else if(tipo_firma == 3){//Firma OP + CL
			
			String cliente_label = "";
			if(misura.getNome_firma()!=null && !misura.getNome_firma().equals("")) {
				cliente_label = misura.getNome_firma();
			}
			
			footer_right = CostantiCertificato.FOOTER_RIGHT;
			if(conf!=null && conf.getRevisione_certificato()!=null && !conf.getRevisione_certificato().equals("")) {
				footer_right = conf.getRevisione_certificato();
			}
			
			VerticalListBuilder vertList = cmp.verticalList();
			if(misura.getFile_firma()!=null && !misura.getFile_firma().equals("")) {
				String path = Costanti.PATH_FOLDER+"\\"+misura.getIntervento().getNomePack()+"\\FileFirmaCliente\\" +misura.getFile_firma();
				File file = new File(path);
				Image image = ImageIO.read(file);
				vertList.add(
						cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.text(cliente_label).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						//cmp.image(image).setFixedDimension(120, 15).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER));
				cmp.image(image).setHeight(20).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER));
			}else {
				vertList.add(
						cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.text(cliente_label).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
						cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
			}
			
			if(strumento.getNote()==null) {
				strumento.setNote("");
			}
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+Utility.checkStringNull(strumento.getNote().concat(note_allegato))).setStyle(footerStyle).setFixedHeight(3),
					
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(
							componentIdoneita(tipoScheda,
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
											cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
									),cmp.verticalList(
											cmp.text(idoneo).setStyle(rootStyle)
									)
									))
							
						,
//						cmp.line().setFixedWidth(1)	
//						,	
							
									cmp.verticalList(
											cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.verticalGap(10)
											//cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+misura.getInterventoDati().getUtente().getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
										)
									,
									cmp.line().setFixedWidth(1),
									vertList
//									cmp.verticalList(
//											cmp.text(cliente_label).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
//											//cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
//											cmp.image(image).setFixedDimension(50, 10)
//										)
									
					 
					),

					cmp.line().setFixedHeight(1),
					cmp.text(nota_firma).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(footerStyle),
					cmp.horizontalList(
						cmp.text(getFooterLeft(tipoScheda, tipo_firma, conf)).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						//cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						cmp.text(footer_right).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
//					,
//					cmp.text("")					
				);
		}else if(tipo_firma == 1){//Firma OP
			
			footer_right = CostantiCertificato.FOOTER_RIGHT;
			if(conf!=null && conf.getRevisione_certificato()!=null && !conf.getRevisione_certificato().equals("")) {
				footer_right = conf.getRevisione_certificato();
			}
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+Utility.checkStringNull(strumento.getNote().concat(note_allegato))).setStyle(footerStyle).setFixedHeight(3),
					
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(
							componentIdoneita(tipoScheda,
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
											cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
									),cmp.verticalList(
											cmp.text(idoneo).setStyle(rootStyle)
									)
									))
							
						,
//						cmp.line().setFixedWidth(1)	
//						,	
							
									cmp.verticalList(
											cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.verticalGap(10)
											//cmp.image(Costanti.PATH_FOLDER + "FileFirme\\"+misura.getInterventoDati().getUtente().getFile_firma()).setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedHeight(25)
										)
									
					),

					cmp.line().setFixedHeight(1),
					cmp.text(nota_firma).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(footerStyle),
					cmp.horizontalList(
						cmp.text(getFooterLeft(tipoScheda, tipo_firma, conf)).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						//cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						cmp.text(footer_right).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
//					,
//					cmp.text("")					
				);
		}

			

			 // report.pageFooter(Templates.footerComponent);
			  report.setDataSource(new JREmptyDataSource());
			
			  
		//	  report.show();
			  String nomePack=misura.getIntervento().getNomePack();
			  java.io.File file = null;
			  
			  if(appenCertificati) {
				  file  = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+"_"+misura.getInterventoDati().getId()+""+misura.getStrumento().get__id()+".pdf");
			  }else {
				  File theDir = new File(Costanti.PATH_FOLDER+"//temp//");

					// if the directory does not exist, create it
					if (!theDir.exists()) {
	 				    boolean result = false;
	 
					        theDir.mkdir();
					        result = true;

					}
				  file = new java.io.File(Costanti.PATH_FOLDER+"//temp//"+nomePack+"_"+misura.getInterventoDati().getId()+""+misura.getStrumento().get__id()+".pdf");
			  }
			  FileOutputStream fos = new FileOutputStream(file);
			
			  report.toPdf(fos);
			  
			  certificato.setNomeCertificato(file.getName());
			  if(!multi) {
				  certificato.setDataCreazione(new Date());  
			  }
			  
			  certificato.setUtenteApprovazione(utente);
			  session.update(certificato);
			  fos.close();
			 
			  
			  /*
			   * add allegato se c'è
			   */
			  
			  if(misura.getFile_allegato()!=null && !misura.getFile_allegato().equals("")) {
					  addAllegato(misura, file);
			  }			  
			  
			  this.file = file;
			  if(tipoScheda.equals("RDP")) {
				  appenCertificati= false;
			  }
			  
			  if(appenCertificati) {
				  addCertificatiCampioni(file,misura,strumento.getTipoRapporto());
			  }
			  
			  
			  System.out.println("Generato Certificato: "+nomePack+"_"+misura.getInterventoDati().getId()+""+misura.getStrumento().get__id()+".pdf");
			  
			  JsonObject jsonOP = new JsonObject();
			  JsonObject jsonRL = new JsonObject();
			  this.firmato = new JsonObject();
			  String messaggio = "";
			  
			//multi serve per non aggiungere la firma in caso di stampa di tanti certificati 
			  if(!multi && certificato.getMisura().getInterventoDati().getUtente().getFile_firma()!=null && certificato.getMisura().getInterventoDati().getUtente().getIdFirma()!=null && !certificato.getMisura().getInterventoDati().getUtente().getIdFirma().equals("")) {
				  jsonOP = ArubaSignService.signCertificatoPades(certificato.getMisura().getInterventoDati().getUtente(), CostantiCertificato.OPERATORE_LABEL,false, certificato);				  
			  }			 
			  else if(multi || (certificato.getMisura().getInterventoDati().getUtente().getFile_firma()!=null && (certificato.getMisura().getInterventoDati().getUtente().getIdFirma()==null || certificato.getMisura().getInterventoDati().getUtente().getIdFirma().equals("")))) {
				  jsonOP = GestioneCertificatoBO.addSign(certificato.getMisura().getInterventoDati().getUtente(), CostantiCertificato.OPERATORE_LABEL, multi,certificato);
			  }
			  
			  if(jsonOP.get("success")==null || !jsonOP.get("success").getAsBoolean() || certificato.getMisura().getInterventoDati().getUtente().getIdFirma()==null) {
				  
				  messaggio = "Non è stato possibile appore la firma digitale dell'operatore";				  
			  }
			  
			  utente.setIdFirma(GestioneUtenteBO.getIdFirmaDigitale(utente.getId(), session));
			  if(!multi && utente.getFile_firma()!=null && utente.getIdFirma()!=null&& (tipo_firma == 0 || tipo_firma == 2)) {
				 jsonRL =  ArubaSignService.signCertificatoPades(utente, CostantiCertificato.RESPONSABILE_LABEL,false, certificato);
			  }else if(multi || (utente.getFile_firma()!=null&& (tipo_firma == 0 || tipo_firma == 2) && (utente.getIdFirma()==null || certificato.getMisura().getInterventoDati().getUtente().getIdFirma()== null || certificato.getMisura().getInterventoDati().getUtente().getIdFirma().equals("")))) {
				  jsonRL = GestioneCertificatoBO.addSign(utente, CostantiCertificato.RESPONSABILE_LABEL, multi, certificato);
			  }
			  
			  if(jsonRL.get("success")==null || !jsonRL.get("success").getAsBoolean() || utente.getIdFirma()==null ) {
				  
				  if(messaggio.equals("")) {
					  messaggio = "Non è stato possibile appore la firma digitale del responsabile";  
				  }else {
					  messaggio += " e del responsabile";
				  }				  
				 
			  }
			
			  if(multi) {
				  messaggio="";
			  }
			  firmato.addProperty("messaggio", messaggio);
			  if(context == null) {
				  report.show();
			  }
			  
		} catch (Exception e) 
		{
			e.printStackTrace();
			throw e;
		}
		//return report;
	}

	
	private void addAllegato(MisuraDTO misura, File f) throws IOException {
		
		PDFMergerUtility ut = new PDFMergerUtility();
		ut.addSource(f);
		
		
		File allegato = new File(Costanti.PATH_FOLDER+misura.getIntervento().getNomePack()+"\\"+misura.getId()+"\\Allegati\\"+misura.getFile_allegato());
		ut.addSource(allegato);
		ut.setDestinationFileName(f.getPath());
		ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
	}

	public void addCertificatiCampioni(File d, MisuraDTO misura,TipoRapportoDTO tipoRapporto) throws IOException {
		
 		

			ArrayList<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();
			List<CampioneDTO> listaCampioniMisura = GestioneMisuraBO.getListaCampioni(misura.getListaPunti(),tipoRapporto);
			listaCampioni.addAll(listaCampioniMisura);
		
		
		PDFMergerUtility ut = new PDFMergerUtility();
		ut.addSource(d);
		
		for (CampioneDTO campioneDTO : listaCampioni) {
			if(campioneDTO != null) {
				CertificatoCampioneDTO certificato = null;
				if(campioneDTO.getNumeroCertificatoPunto()!=null) {
					
					certificato = campioneDTO.getCertificatoFromPunto(campioneDTO.getListaCertificatiCampione(), campioneDTO.getNumeroCertificatoPunto());
					
				}else {
					
					certificato = campioneDTO.getCertificatoCorrente(campioneDTO.getListaCertificatiCampione());
					
				}				
				
				if(certificato != null) {
					String folder = Costanti.PATH_FOLDER+"//Campioni//"+campioneDTO.getId()+"//"+certificato.getFilename();
					File x = new File(folder);
					if(x.exists() && !x.isDirectory()) {
						ut.addSource(x);
					}
				}
			}
		}
		
		ut.setDestinationFileName(d.getPath());
		ut.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
		
		
		
	}
	
	
	public JasperReportBuilder getTableReportRip(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7).setPadding(0);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv","left",null)).setDataSource(new SubreportData("tipoVerifica"));
		SubreportBuilder subreportUM = cmp.subreport(new SubreportDesign("um","center",null)).setDataSource(new SubreportData("unitaDiMisura"));
		SubreportBuilder subreportVC = cmp.subreport(new SubreportDesign("vc","center",null)).setDataSource(new SubreportData("valoreCampione"));
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs","center",null)).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);


			report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			  
			report.setColumnStyle(textStyle); //AGG
	
			report.addColumn(col.componentColumn("Tipo Verifica<br/><i>Verification Type</i>", subreport).setFixedWidth(120).setTitleFixedHeight(15));
			report.addColumn(col.componentColumn("UM", subreportUM).setFixedWidth(35));
			report.addColumn(col.componentColumn("Valore Campione<br/><i>Reference Value</i>", subreportVC));
			report.addColumn(col.column("Valore Medio Campione<br/><i>Reference Average</i>", "valoreMedioCampione", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));
			report.addColumn(col.componentColumn("Valore Strumento<br/><i>Unit under Test reading</i>", subreportVS));
			report.addColumn(col.column("Valore Medio Strumento<br/><i>Average</i>", "valoreMedioStrumento", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));
			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("Scostamento<br/><i>Average deviation</i>", "scostamento_correzione", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));

			}else{
				report.addColumn(col.column("Correzione<br/><i>Average correction</i>", "scostamento_correzione", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));
			}
			
			
			
			if(tipoProva.equals("SVT")) {
				report.addColumn(col.column("Accettabilità <br/><i>Acceptability</i>", "accettabilita", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false).setFixedWidth(100));
			}

			report.addColumn(col.column("Incertezza <i>U</i><br /><i>Uncertainty U</i>", "incertezza", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));

			if(tipoProva.equals("SVT")) {
				report.addColumn(col.column("ESITO<br/><i>RESULTS</i>", "esito", type.stringType()).setFixedHeight(11).setFixedWidth(50).setStretchWithOverflow(false));
			}

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	public JasperReportBuilder getTableReportLin(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7).setPadding(0);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv","left",null)).setDataSource(new SubreportData("tipoVerifica"));
		SubreportBuilder subreportUM = cmp.subreport(new SubreportDesign("um","center",null)).setDataSource(new SubreportData("unitaDiMisura"));
		SubreportBuilder subreportVC = cmp.subreport(new SubreportDesign("vc","center",null)).setDataSource(new SubreportData("valoreCampione"));
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs","center",null)).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
		

			report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			
			report.setColumnStyle(textStyle); //AGG
		
			report.addColumn(col.componentColumn("Tipo Verifica <br/><i>Verification Type</i>", subreport).setFixedWidth(120).setTitleFixedHeight(15));
			report.addColumn(col.componentColumn("UM", subreportUM).setFixedWidth(30));
			report.addColumn(col.componentColumn("Valore Campione<br/><i>Reference Value</i>", subreportVC));

			report.addColumn(col.componentColumn("Valore Strumento<br/><i>Unit under Test reading</i>", subreportVS));

			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("Scostamento<br/><i>Average deviation</i>", "scostamento_correzione", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));

			}else{

				report.addColumn(col.column("Correzione<br /><i>Average correction</i>", "scostamento_correzione", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));
			}
			if(tipoProva.equals("SVT")) {
				report.addColumn(col.column("Accettabilità<br /><i>Acceptability</i>", "accettabilita", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false).setFixedWidth(100));
			}

			report.addColumn(col.column("Incertezza <i>U</i><br /><i>Uncertainty U</i>", "incertezza", type.stringType()).setFixedHeight(11).setStretchWithOverflow(false));

			
			if(tipoProva.equals("SVT")) {
				report.addColumn(col.column("ESITO<br/><i>RESULTS</i>", "esito", type.stringType()).setFixedWidth(50).setFixedHeight(11).setStretchWithOverflow(false));
			}
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	
	
	
	public JasperReportBuilder getTableReportRDP(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7).setPadding(0);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv","center",null)).setDataSource(new SubreportData("tipoVerifica"));
		
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs","center",null)).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);

			//report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			report.fields(field("tipoVerifica", List.class),field("valoreStrumento", List.class));
			report.setColumnStyle(textStyle); //AGG
			//report.addColumn(col.column("Campione<br/><i>Cahampion</i>", "descrizioneCampione", type.stringType()).setFixedWidth(70).setFixedHeight(11).setStretchWithOverflow(false));
			report.addColumn(col.componentColumn("Tipo Verifica <br/><i>Verification Type</i>", subreport));			
			
			report.addColumn(col.componentColumn("Misura<br/><i>Measure</i>", subreportVS).setFixedWidth(70).setTitleFixedHeight(15));
			
			report.addColumn(col.column("ESITO<br/><i>results</i>", "esito", type.stringType()).setFixedWidth(70).setFixedHeight(11).setStretchWithOverflow(false));
			
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	
	public JasperReportBuilder 	getTableReportDec(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7).setPadding(0);//AGG
		StyleBuilder colStyle = stl.style(Templates.columnTitleStyle).setFontSize(7);
		
//		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("posizione_massa","center",null)).setDataSource(new SubreportData("tipoVerifica"));
		
		JasperReportBuilder report_cell = DynamicReports.report();
		
		report_cell.addColumn(col.column("3","3",type.stringType()).setHeight(19));
		report_cell.addColumn(col.column("","empty",type.stringType()).setHeight(19));
		report_cell.addColumn(col.column("5","5",type.stringType()).setHeight(19));
	//	report_cell.setColumnTitleStyle(colStyle);
		report_cell.setColumnStyle(textStyle);
		report_cell.highlightDetailEvenRows();
		report_cell.setShowColumnTitle(false);
		
		DRDataSource dataSource = new DRDataSource("3","empty","5");
		dataSource.add("3","","5");
		dataSource.add("","1=6","");
		dataSource.add("2","","4");
		report_cell.setDataSource(dataSource);
		
		SubreportBuilder subreport = cmp.subreport(report_cell);
		
		
		JasperReportBuilder report_header = DynamicReports.report();
		
		report_header.setColumnTitleStyle(textStyle);
		report_header.setColumnStyle(textStyle);
		
		String um = (String) listaReport.get(0).getUnitaDiMisura().get(0).get("um");
		for(int i = 0; i<6;i++) {
			report_header.addColumn(col.column("posizione "+(i+1)+" <br> "+um,"posizione_"+(i+1),type.stringType()).setHeight(41));
		}
				
		String[] listaCodici = new String[6];		
	
		listaCodici[0]="posizione_1";
		listaCodici[1]="posizione_2";
		listaCodici[2]="posizione_3";
		listaCodici[3]="posizione_4";
		listaCodici[4]="posizione_5";
		listaCodici[5]="posizione_6";
		
		
		DRDataSource ds = new DRDataSource(listaCodici);
		ds.add(listaReport.get(0).getValoreStrumento().get(0).get("vs"),
				listaReport.get(1).getValoreStrumento().get(0).get("vs"),
				listaReport.get(2).getValoreStrumento().get(0).get("vs"),
				listaReport.get(3).getValoreStrumento().get(0).get("vs"),
				listaReport.get(4).getValoreStrumento().get(0).get("vs"),
				listaReport.get(5).getValoreStrumento().get(0).get("vs"));
	
	
		report_header.setDataSource(ds);
	
		SubreportBuilder subreport_header = cmp.subreport(report_header);
	

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
				
			report.setColumnStyle(textStyle); //AGG
			report.setColumnTitleStyle(colStyle);
			
			report.addColumn(col.componentColumn("Posizione Massa", subreport).setFixedWidth(80));
			report.addColumn(col.column("Massa Applicata <br/><i>"+um+"</i>","massa_applicata",type.stringType()).setFixedWidth(60));
			report.addColumn(col.componentColumn("Verifica all'eccentricità del carico 50% f.s", subreport_header));
			report.addColumn(col.column("Scostamento massimo ecc. <br/><i>"+um+"</i>","scostamento",type.stringType()).setFixedWidth(60));

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSourceDecentramento(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	
	
	
	
	
	private JRDataSource createDataSourceDecentramento(List<ReportSVT_DTO> listaReport)throws Exception {

		BigDecimal max=null;
		BigDecimal min=null;
		
		BigDecimal scostamento_res=null;
		
		for (ReportSVT_DTO reportSVT_DTO : listaReport) {
		
			BigDecimal scostamento=new BigDecimal(reportSVT_DTO.getScostamento_correzione().replace(",", "."));
			
			if(max==null && min==null && scostamento!=null) 
			{
				max=scostamento;
				min=scostamento;
			}
			
			if(scostamento!=null && scostamento.doubleValue()>max.doubleValue()) 
			{
				max=scostamento;
			} 
			
			if(scostamento!=null && scostamento.doubleValue()<min.doubleValue()) 
			{
				min=scostamento;
			}
			
		}
		
		
		if(max!=null) 
		{
			scostamento_res	=  max.subtract(min);
		}else 
		{
			scostamento_res =  BigDecimal.ZERO;
		}
		
		String[] listaCodici = new String[2];
		
		listaCodici[0]="massa_applicata";
	
		listaCodici[1]="scostamento";	
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		

		dataSource.add(listaReport.get(0).getValoreCampione().get(0).get("vc"), scostamento_res.toPlainString().replace(".", ","));

 		    return dataSource;
 	}
	

	
	
	public JasperReportBuilder getTableCampioni(List<CampioneDTO> listaCampioni, String tipoScheda){

		StyleBuilder textStyle = stl.style(Templates.columnTitleStyleWhite).setBorder(stl.penThin()).setFontSize(6).setMarkup(Markup.HTML);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);
			   
			report.setColumnStyle(textStyle); //AGG
			if(!tipoScheda.equals("RDP")) {
			report.addColumn(col.column("Campione<br/><i>Standard</i>", "codice", type.stringType()).setWidth(40));
			report.addColumn(col.column("Matricola<br/><i>Standard Code</i>", "matricola", type.stringType()));
			report.addColumn(col.column("N° Certificato<br/><i>N° Report</i>", "numeroCertificato", type.stringType()).setWidth(90));
			TextColumnBuilder<Date> column = col.column("Data Scandenza<br/><i>Standard expiration</i>", "dataScadenza", type.dateType());
			column.setPattern("MM/yyyy");
			
			report.addColumn(column.setWidth(40).setTitleFixedHeight(18));
			}else {
				
				report.addColumn(col.column("Strumentazione Utilizzata<br/><i>Used Tools</i>", "codice", type.stringType()).setTitleFixedHeight(18));
			}
			report.setDataSource(new JRBeanCollectionDataSource(listaCampioni).getData());
			
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	
	

	public JasperReportBuilder getTableRDT(List<CampioneDTO> listaCampioni, String tipoScheda){

		StyleBuilder textStyle = stl.style(Templates.columnTitleStyleWhite).setBorder(stl.penThin()).setFontSize(6).setMarkup(Markup.HTML);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);

			   
			report.setColumnStyle(textStyle); //AGG
			
			for(int i=0; i<listaCampioni.size();i++) {	
			report.addColumn(col.column("Campione<br/><i>Standard</i>", "codice", type.stringType()));
			
			report.setDataSource(new JRBeanCollectionDataSource(listaCampioni));
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	public JasperReportBuilder getTableProcedure(DRDataSource listaProcedure, String tipoScheda){

		StyleBuilder textStyle = stl.style(Templates.columnTitleStyleWhite).setBorder(stl.penThin()).setFontSize(6);
		
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);

			  
			report.setColumnStyle(textStyle); //AGG

			if(!tipoScheda.equals("RDP")) {
				report.addColumn(col.column("Procedura di Taratura<br/><i>Calibration Procedure</i>","listaProcedure", type.stringType()).setTitleFixedHeight(18));
			}else {
				report.addColumn(col.column("Procedura<br/><i>Procedure</i>","listaProcedure", type.stringType()).setTitleFixedHeight(18));
			}
			
			report.setDataSource(listaProcedure);
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	

	
	private class SubreportDesign extends AbstractSimpleExpression<JasperReportBuilder> {
		private static final long serialVersionUID = 1L;
		private String _tipo;
		private String _alignment;
		private Integer _fixedWidth;
		public SubreportDesign(String tipo, String alignment, Integer fixedWidth) {
			_tipo = tipo;
			_alignment = alignment;
			_fixedWidth = fixedWidth;
		}

		@Override
		public JasperReportBuilder evaluate(ReportParameters reportParameters) {
			JasperReportBuilder report = report();
			if(_alignment.equals("center")){
				if(_fixedWidth != null){
					report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.penThin()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFontSize(7).setLeftPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(11).setStretchWithOverflow(false).setFixedWidth(_fixedWidth));
				}else{
					report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.penThin()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFontSize(7).setLeftPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(11).setStretchWithOverflow(false));	
				}
			}else if(_alignment.equals("left")){
				if(_fixedWidth != null){
					report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.penThin()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFontSize(7).setLeftPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(11).setStretchWithOverflow(false).setFixedWidth(_fixedWidth));
				}else{
					report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.penThin()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFontSize(7).setLeftPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(11).setStretchWithOverflow(false));
				}
			}else{
				if(_fixedWidth != null){
					report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.penThin()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFontSize(7).setLeftPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(11).setStretchWithOverflow(false).setFixedWidth(_fixedWidth));
				}else{
					report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.penThin()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFontSize(7).setLeftPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(11).setStretchWithOverflow(false));
				}
			}
			return report;
		}
	}
	

	private class SubreportData extends AbstractSimpleExpression<JRDataSource> {
		private static final long serialVersionUID = 1L;
		private String _tipo;
		public SubreportData(String tipo) {
			_tipo = tipo;
		}

		@Override
		public JRDataSource evaluate(ReportParameters reportParameters) {
			Collection<Map<String, ?>> value = reportParameters.getValue(_tipo);
			return new JRMapCollectionDataSource(value);
		}
	}


	  private JRDataSource createDataSourceAll() {
		  List<Object> datasource = new ArrayList<Object>();
		  	datasource.add(new ReportSVT_DTO());

		//return new JRBeanCollectionDataSource(datasource);
		
		 return new JREmptyDataSource(2);
	  }

	  private ComponentBuilder<?, ?> componentIdoneita(String tipoScheda, ComponentBuilder<?, ?> component1) {
		  if(tipoScheda.equals("RDT")) {
			  	HorizontalListBuilder list = cmp.horizontalList();
			  	return list;
	      }else {
	    	  		HorizontalListBuilder list = cmp.horizontalList(component1, cmp.line().setFixedWidth(1));
		         return list;
	      }
	  }
	  
	  private String getFooterLeft(String tipoProva, int tipoFirma, ConfigurazioneClienteDTO conf) {
		  
		  if(conf!=null && conf.getModello_certificato()!=null && !conf.getModello_certificato().equals("")) {
			  return conf.getModello_certificato();
			  
		  }else {
			  if(tipoProva.equals("RDT")) {
				  if(tipoFirma == 0) {
					  return CostantiCertificato.FOOTER_LEFT_01;
				  }else if(tipoFirma == 1) {
					  return CostantiCertificato.FOOTER_LEFT_02;
				  }else if(tipoFirma == 2) {
					  return CostantiCertificato.FOOTER_LEFT_03;
				  }else if(tipoFirma == 3) {
					  return CostantiCertificato.FOOTER_LEFT_04;
				  }
			  }
			  else if(tipoProva.equals("RDP")) {
				  return CostantiCertificato.FOOTER_LEFT_09;
			  }
			  else {
				  if(tipoFirma == 0) {
					  return CostantiCertificato.FOOTER_LEFT_05;
				  }else if(tipoFirma == 1) {
					  return CostantiCertificato.FOOTER_LEFT_06;
				  }else if(tipoFirma == 2) {
					  return CostantiCertificato.FOOTER_LEFT_07;
				  }else if(tipoFirma == 3) {
					  return CostantiCertificato.FOOTER_LEFT_08;
				  }		
			  }
		  }
		  
		  
		  return "";
	  }
		public static void main(String[] args) throws HibernateException, Exception {
			new ContextListener().configCostantApplication();
			Session session =SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
			UtenteDTO utente = GestioneUtenteBO.getUtenteById("40", session);

			GestioneCertificatoBO.createCertificato("28735",session, null, utente);
			
		}
}
