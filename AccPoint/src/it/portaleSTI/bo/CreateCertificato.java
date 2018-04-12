package it.portaleSTI.bo;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.field;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;

import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.RoundingMode;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;

import net.sf.dynamicreports.jasper.base.export.JasperPdfExporter;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.jasper.builder.export.JasperPdfExporterBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.component.ComponentBuilder;
import net.sf.dynamicreports.report.builder.component.HorizontalListBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.TextFieldBuilder;
import net.sf.dynamicreports.report.builder.style.FontBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
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
import org.apache.commons.lang3.text.WordUtils;
import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.omg.CORBA.CODESET_INCOMPATIBLE;

import TemplateReport.PivotTemplate;

import ar.com.fdvs.dj.domain.constants.Font;

import com.mysql.jdbc.Util;
import com.sun.corba.se.impl.orbutil.closure.Constant;
import com.sun.org.apache.bcel.internal.classfile.ConstantInterfaceMethodref;

public class CreateCertificato {
	
	public File file;

	public CreateCertificato(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,String idoneo, Session session, ServletContext context, Boolean appenCertificati) throws Exception {
		try {
			 Utility.memoryInfo();
			build(misura,certificato,lista, listaCampioni, listaProcedure, strumento,idoneo,session,context,appenCertificati);
			 Utility.memoryInfo();
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}

	@SuppressWarnings("deprecation")
	private void build(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,String idoneo, Session session, ServletContext context, Boolean appenCertificati) throws Exception {
		String tipoScheda="";
		
		InputStream is = null;

		Iterator itLista = lista.entrySet().iterator();
		while (itLista.hasNext()) {

			Map.Entry pair = (Map.Entry)itLista.next();
			String pivot = pair.getKey().toString();		
			List<ReportSVT_DTO> listItem = (List<ReportSVT_DTO>) pair.getValue();
			SubreportBuilder subreport = null;
			
			if(pivot.startsWith("R_S") || pivot.startsWith("L_S")){
				is = PivotTemplate.class.getResourceAsStream("schedaVerificaHeaderSvt_EN.jrxml");
				tipoScheda="SVT";
			}
			if(pivot.startsWith("R_R") || pivot.startsWith("L_R")){
				is = PivotTemplate.class.getResourceAsStream("schedaVerificaHeaderRDT_EN.jrxml");
				tipoScheda="RDT";
			}
		
		}
	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		


		JasperReportBuilder report = DynamicReports.report();
		
		SubreportBuilder campioniSubreport = cmp.subreport(getTableCampioni(listaCampioni));
		
		SubreportBuilder procedureSubreport = cmp.subreport(getTableProcedure(listaProcedure));
	
		StyleBuilder styleTitleBold = Templates.rootStyle.setFontSize(10).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);


		TextFieldBuilder rifTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_CAMPIONI + " - " +CostantiCertificato.TITOLO_LISTA_CAMPIONI_EN);
		rifTextfield.setStyle(styleTitleBold);
	
		TextFieldBuilder ristTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_MISURE + " - " + CostantiCertificato.TITOLO_LISTA_MISURE_EN);
		ristTextfield.setStyle(styleTitleBold);
		
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);
		
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);

		StyleBuilder style1test = stl.style().setBackgroundColor(new Color(230, 230, 230));

		try {

			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany());

			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+misura.getIntervento().getCompany().getNomeLogo());
			

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
		
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(misura.getIntervento().getIdCommessa());
			
			report.addParameter("datiCliente",""+commessa.getID_ANAGEN_NOME());
		
			String sedeCliente="";
			
			if(commessa.getANAGEN_INDR_INDIRIZZO()!=null && commessa.getANAGEN_INDR_INDIRIZZO().length()>0)
			{
				sedeCliente=commessa.getANAGEN_INDR_INDIRIZZO();
			}else
			{
				sedeCliente=commessa.getINDIRIZZO_PRINCIPALE(); 
			}
			
			report.addParameter("sedeCliente",""+sedeCliente);
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			
			/*
			 * Aggiornata data Emissione su scadenzaDTO
			 */
		
				ScadenzaDTO scadenza =strumento.getScadenzaDTO();
				scadenza.setIdStrumento(strumento.get__id());
				scadenza.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
				scadenza.setDataEmissione(new java.sql.Date(System.currentTimeMillis()));
				
				if(tipoScheda.equals("SVT"))
				{
					Calendar c = Calendar.getInstance(); 
					c.setTime(misura.getDataMisura()); 
					c.add(Calendar.MONTH,scadenza.getFreq_mesi());
					c.getTime();
					
					scadenza.setDataProssimaVerifica(new java.sql.Date(c.getTime().getTime()));
				
					
					GestioneStrumentoBO.updateScadenza(scadenza, session);
					
					report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
					report.addParameter("dataProssimaVerifica",""+sdf.format(scadenza.getDataProssimaVerifica()));
					report.addParameter("svtNumber",misura.getnCertificato());
					report.addParameter("comeRicevuto",misura.getStatoRicezione().getNome());
				}

				if(tipoScheda.equals("RDT"))
				{
					GestioneStrumentoBO.updateScadenza(scadenza, session);
					
					report.addParameter("dataEmissione",""+sdf.format(new Date()));
					report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
					report.addParameter("rdtNumber",misura.getnCertificato());
				}
			

		
			report.addParameter("denominazione",strumento.getDenominazione());
			report.addParameter("codiceInterno",strumento.getCodice_interno());
			report.addParameter("costruttore",StringUtils.capitalize(strumento.getCostruttore().toLowerCase()));
			report.addParameter("modello",strumento.getModello());
			
			if(strumento.getReparto()!=null){
				report.addParameter("reparto",strumento.getReparto());
			}
			if(strumento.getUtilizzatore()!=null){
				report.addParameter("utilizzatore",strumento.getUtilizzatore());
			}
			
			report.addParameter("matricola",strumento.getMatricola());
			report.addParameter("campoMisura",strumento.getCampo_misura());
			report.addParameter("risoluzione",strumento.getRisoluzione());

			report.addParameter("classificazione",strumento.getClassificazione().getDescrizione());
		    report.addParameter("frequenza",""+strumento.getScadenzaDTO().getFreq_mesi());

		    LuogoVerificaDTO luogo =strumento.getLuogo();
		   
		    if(luogo!=null)
			{
		    	report.addParameter("luogoVerifica",luogo.getDescrizione());
			}else
			{
				report.addParameter("luogoVerifica","");
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
			report.addParameter("logo2",imageHeader);
			}

			report.setColumnStyle(textStyle); //AGG
			
			
			/*
			 * Dettaglio Campioni Utilizzati
			 */
			report.detail(rifTextfield);
			report.detail(cmp.verticalGap(2));
			
			report.detail(cmp.horizontalList(campioniSubreport.setFixedWidth(340),cmp.horizontalGap(20),procedureSubreport));
			report.detail(cmp.verticalGap(2));

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

				report.detail(subreport);

				report.detail(cmp.verticalGap(10));
				it.remove();
			}


			report.pageFooter(cmp.verticalList(
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(
							cmp.text(getFooterLeft(tipoScheda, misura.getTipoFirma())).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							)
					)
				);
			
			//FOOTER CERTIFICATO

			//Firma OP + RL
			if(misura.getTipoFirma() == 0){
				
				report.lastPageFooter(cmp.verticalList(
						cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
						cmp.line().setFixedHeight(1),	
						cmp.verticalGap(1),
						cmp.line().setFixedHeight(1),	
						cmp.text(CostantiCertificato.NOTE_LABEL+ Utility.checkStringNull(strumento.getNote())).setStyle(footerStyle).setFixedHeight(3),
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
												cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
												
											),
										cmp.line().setFixedWidth(1),
										cmp.verticalList(
												cmp.text(CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
												cmp.text(misura.getIntervento().getUser().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
											)
										)
										
								
								
								)
						),

						cmp.line().setFixedHeight(1),
						
						cmp.horizontalList(
							cmp.text(getFooterLeft(tipoScheda, misura.getTipoFirma())).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						)
						
						
						
						),
						cmp.text("")
//						,
//						cmp.text("")					
					);
			
		}else if(misura.getTipoFirma() == 2){//Firma OP + RL + CL
			
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+Utility.checkStringNull(strumento.getNote())).setStyle(footerStyle).setFixedHeight(3),					
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
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
											
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text(CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text(misura.getIntervento().getUser().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
										)
									)
							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text(getFooterLeft(tipoScheda, misura.getTipoFirma())).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					)
					,
					cmp.text("")
					//,
					//cmp.text("")					
				);
		}else if(misura.getTipoFirma() == 3){//Firma OP + CL
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+Utility.checkStringNull(strumento.getNote())).setStyle(footerStyle).setFixedHeight(3),
					
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
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
										)
									,
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),
											cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
										)
									
					 
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text(getFooterLeft(tipoScheda, misura.getTipoFirma())).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
//					,
//					cmp.text("")					
				);
		}else if(misura.getTipoFirma() == 1){//Firma OP
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+Utility.checkStringNull(strumento.getNote())).setStyle(footerStyle).setFixedHeight(3),
					
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
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
										)
									
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text(getFooterLeft(tipoScheda, misura.getTipoFirma())).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
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
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+"_"+misura.getInterventoDati().getId()+""+misura.getStrumento().get__id()+".pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			 
			  
			  certificato.setNomeCertificato(file.getName());
			  certificato.setDataCreazione(new Date());
			  session.update(certificato);
			  fos.close();
			 
			  this.file = file;
			  if(appenCertificati) {
				  addCertificatiCampioni(file,misura);
			  }
			  System.out.println("Generato Certificato: "+nomePack+"_"+misura.getInterventoDati().getId()+""+misura.getStrumento().get__id()+".pdf");
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

	
	public void addCertificatiCampioni(File d, MisuraDTO misura) throws IOException {
		
 		

			ArrayList<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();
			List<CampioneDTO> listaCampioniMisura = GestioneMisuraBO.getListaCampioni(misura.getListaPunti());
			listaCampioni.addAll(listaCampioniMisura);
		
		
		PDFMergerUtility ut = new PDFMergerUtility();
		ut.addSource(d);
		
		for (CampioneDTO campioneDTO : listaCampioni) {
			if(campioneDTO != null) {
				CertificatoCampioneDTO certificato = campioneDTO.getCertificatoCorrente(campioneDTO.getListaCertificatiCampione());
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

	public JasperReportBuilder getTableCampioni(List<CampioneDTO> listaCampioni){

		StyleBuilder textStyle = stl.style(Templates.columnTitleStyleWhite).setBorder(stl.penThin()).setFontSize(6).setMarkup(Markup.HTML);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);

			   
			report.setColumnStyle(textStyle); //AGG
		
			report.addColumn(col.column("Campione<br/><i>Standard</i>", "codice", type.stringType()).setWidth(40));
			report.addColumn(col.column("Matricola<br/><i>Standard Code</i>", "matricola", type.stringType()));
			report.addColumn(col.column("N° Certificato<br/><i>N° Report</i>", "numeroCertificato", type.stringType()).setWidth(90));
			TextColumnBuilder<Date> column = col.column("Data Scandenza<br/><i>Standard expiration</i>", "dataScadenza", type.dateType());
			column.setPattern("MM/yyyy");
			report.addColumn(column.setWidth(40).setTitleFixedHeight(18));

			report.setDataSource(new JRBeanCollectionDataSource(listaCampioni));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	public JasperReportBuilder getTableProcedure(DRDataSource listaProcedure){

		StyleBuilder textStyle = stl.style(Templates.columnTitleStyleWhite).setBorder(stl.penThin()).setFontSize(6);
		
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);

			  
			report.setColumnStyle(textStyle); //AGG


			report.addColumn(col.column("Procedura di Taratura<br/><i>Calibration Procedure</i>","listaProcedure", type.stringType()).setTitleFixedHeight(18));

			
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
	  
	  private String getFooterLeft(String tipoProva, int tipoFirma) {
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
		  }else {
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
		  return "";
	  }
		public static void main(String[] args) throws HibernateException, Exception {
			
			Session session =SessionFacotryDAO.get().openSession();
			session.beginTransaction();

			

			GestioneCertificatoBO.createCertificato("83",session,null);

			
			
		}
}
