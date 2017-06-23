package it.portaleSTI.bo;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.field;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;

import java.awt.Color;
import java.io.FileOutputStream;
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

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.TextFieldBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;

import org.hibernate.Session;
import org.omg.CORBA.CODESET_INCOMPATIBLE;

import com.mysql.jdbc.Util;
/**
 * @author Ricardo Mariaca (r.mariaca@dynamicreports.org)
 */
public class CreateCertificato {

	public CreateCertificato(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,String idoneo, Session session, ServletContext context) throws Exception {
		try {
			build(misura,certificato,lista, listaCampioni, listaProcedure, strumento,idoneo,session,context);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}

	private void build(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,String idoneo, Session session, ServletContext context) throws Exception {
		String tipoScheda="";
		
		InputStream is = null;

		Iterator itLista = lista.entrySet().iterator();
		while (itLista.hasNext()) {

			Map.Entry pair = (Map.Entry)itLista.next();
			String pivot = pair.getKey().toString();		
			List<ReportSVT_DTO> listItem = (List<ReportSVT_DTO>) pair.getValue();
			SubreportBuilder subreport = null;
			if(pivot.equals("R_S") || pivot.equals("L_S")){
				is = CreateCertificato.class.getResourceAsStream("schedaVerificaHeaderSvt.jrxml");
				tipoScheda="SVT";
			}
			if(pivot.equals("R_R") || pivot.equals("L_R")){
				is = CreateCertificato.class.getResourceAsStream("schedaVerificaHeaderRDT.jrxml");
				tipoScheda="RDT";
			}
		
		}
	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		


		JasperReportBuilder report = DynamicReports.report();
		
		SubreportBuilder campioniSubreport = cmp.subreport(getTableCampioni(listaCampioni));
		
		SubreportBuilder procedureSubreport = cmp.subreport(getTableProcedure(listaProcedure));
	
		StyleBuilder styleTitleBold = Templates.rootStyle.setFontSize(10).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);


		TextFieldBuilder rifTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_CAMPIONI);
		rifTextfield.setStyle(styleTitleBold);
	
		TextFieldBuilder ristTextfield = cmp.text(CostantiCertificato.TITOLO_LISTA_MISURE);
		ristTextfield.setStyle(styleTitleBold);
		
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder style1test = stl.style().setBackgroundColor(new Color(230, 230, 230));

		try {

			Object imageHeader = context.getResourceAsStream("images/header.jpg");

			Object imageHeaderAzienda = context.getResourceAsStream("images/logo_acc_bg.jpg");
			

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
		

			report.addParameter("datiCliente",""+misura.getIntervento().getNome_sede());
		
			
			report.addParameter("sedeCliente","");
			
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
					report.addParameter("dataPropssimaVerifica",""+sdf.format(scadenza.getDataProssimaVerifica()));
				}

				if(tipoScheda.equals("RDT"))
				{
					GestioneStrumentoBO.updateScadenza(scadenza, session);
					
					report.addParameter("dataEmissione",""+sdf.format(new Date()));
					report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
				}
			

		
			report.addParameter("denominazione",strumento.getDenominazione());
			report.addParameter("codiceInterno",strumento.getCodice_interno());
			report.addParameter("costruttore",strumento.getCostruttore());
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

		    if(misura.getIntervento().getPressoDestinatario()==0)
			{
		    	report.addParameter("luogoVerifica","In sede");
			}else
			{
				report.addParameter("luogoVerifica","PressoCliente");
			}
			
			
			report.addParameter("comeRicevuto",misura.getStatoRicezione().getNome());
			
			if(misura.getTemperatura().setScale(2,RoundingMode.HALF_UP).toPlainString().equals("0.00")){
				report.addParameter("temperatura","/");
			}else{
				report.addParameter("temperatura",misura.getTemperatura().setScale(2,RoundingMode.HALF_UP).toPlainString());
			}
			if(misura.getUmidita().setScale(2,RoundingMode.HALF_UP).toPlainString().equals("0.00")){
				report.addParameter("umidita","/");
			}else{
				report.addParameter("umidita",misura.getUmidita().setScale(2,RoundingMode.HALF_UP).toPlainString());
			}
			
			report.addParameter("rdtNumber","number");
			
			report.addParameter("logo",imageHeader);
			report.addParameter("logo2",imageHeader);
			report.addParameter("logoAzienda",imageHeaderAzienda);
			report.setColumnStyle(textStyle); //AGG
			
			
			/*
			 * Dettaglio Campioni Utilizzati
			 */
			report.detail(rifTextfield);
			report.detail(cmp.verticalGap(2));
			
			report.detail(cmp.horizontalList(campioniSubreport,cmp.horizontalGap(20),procedureSubreport));
			report.detail(cmp.verticalGap(2));

			/*
			 * Dettaglio Procedure
			 */
			
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
				if(pivot.equals("R_S")){
					numberOfRow += 2 + listItem.get(0).getTipoVerifica().size() * listItem.size();
					subreport = cmp.subreport(getTableReportRip(listItem, "SVT"));
				}
				if(pivot.equals("R_R")){
					numberOfRow += 2 + listItem.get(0).getTipoVerifica().size() * listItem.size();
					subreport = cmp.subreport(getTableReportRip(listItem, "RDT"));
				}
				if(pivot.equals("L_S")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportLin(listItem, "SVT"));
				}
				if(pivot.equals("L_R")){
					numberOfRow += 2 + listItem.size();
					subreport = cmp.subreport(getTableReportLin(listItem, "RDT"));
				}
				numberOfRow=numberOfRow - numberOfRowBefore;
				if(numberOfRow>11 && isFirtsPage){
					report.detail(cmp.pageBreak());
					validated=true;
					isFirtsPage=false;
					
				}else if(numberOfRow>28 && !isFirtsPage){
					report.detail(cmp.pageBreak());

				}

				
				report.detail(subreport);

				report.detail(cmp.verticalGap(10));
				it.remove();
			}


			
			report.pageFooter(cmp.verticalList(
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(
							cmp.text(CostantiCertificato.FOOTER_LEFT).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							)
					)
				);
			if(false){
				report.lastPageFooter(cmp.verticalList(
						cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
						cmp.line().setFixedHeight(1),	
						cmp.verticalGap(1),
						cmp.line().setFixedHeight(1),	
						cmp.text(CostantiCertificato.NOTE_LABEL+strumento.getNote()).setStyle(footerStyle).setFixedHeight(3),
						cmp.line().setFixedHeight(1),
						cmp.horizontalList(

								cmp.horizontalList(
										cmp.verticalList(
												cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
												cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
										),
										cmp.text(idoneo))
								
							,
							cmp.line().setFixedWidth(1),	
							cmp.verticalList(
								

								cmp.horizontalList(
										cmp.verticalList(
												cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
												cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
												cmp.text("")
											),
										cmp.line().setFixedWidth(1),
										cmp.verticalList(
												cmp.text(CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
												cmp.text(misura.getIntervento().getUser().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
												cmp.text("")
											)
										)
								
								
								)
						),

						cmp.line().setFixedHeight(1),
						
						cmp.horizontalList(
							cmp.text(CostantiCertificato.FOOTER_LEFT).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
						)
						
						
						
						),
						cmp.text(""),
						cmp.text("")					
					);
			
		}else if(false){
			
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+strumento.getNote()).setStyle(footerStyle).setFixedHeight(3),					
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(

							cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
											cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
									),
									cmp.text(idoneo))
							
						,
						cmp.line().setFixedWidth(1),	
						cmp.verticalList(
							

							cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text(CostantiCertificato.RESPONSABILE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text(misura.getIntervento().getUser().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										)
									)
							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text(CostantiCertificato.FOOTER_LEFT).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text(""),
					cmp.text("")					
				);
		}else{
			
			report.lastPageFooter(cmp.verticalList(
					cmp.text(CostantiCertificato.DESCRIZIONE_INCERTEZZA).setStyle(footerStyle),	
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.text(CostantiCertificato.NOTE_LABEL+strumento.getNote()).setStyle(footerStyle).setFixedHeight(3),
					
					cmp.line().setFixedHeight(1),
					cmp.horizontalList(

							cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.ESITO_TITLE).setStyle(footerStyle),
											cmp.text(CostantiCertificato.ACCETTABILITA_DESC).setStyle(footerStyle)
									),
									cmp.text(idoneo)).setFixedHeight(10)
							
						,
						cmp.line().setFixedWidth(1).setFixedHeight(10).removeLineWhenBlank(),	
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text(CostantiCertificato.OPERATORE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedHeight(3).removeLineWhenBlank(),
											cmp.text(misura.getInterventoDati().getUtente().getNominativo()).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedHeight(3).removeLineWhenBlank(),
											cmp.text("").setFixedHeight(7).removeLineWhenBlank()
										).removeLineWhenBlank(),
									cmp.line().setFixedWidth(1).setFixedHeight(10).removeLineWhenBlank(),
									cmp.verticalList(
											cmp.text(CostantiCertificato.CLIENTE_LABEL).setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedHeight(3).removeLineWhenBlank(),
											cmp.text("").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedHeight(3).removeLineWhenBlank(),
											cmp.text("").setFixedHeight(7).removeLineWhenBlank()
										).removeLineWhenBlank()
									)
					 
					).removeLineWhenBlank(),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text(CostantiCertificato.FOOTER_LEFT).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text(CostantiCertificato.FOOTER_RIGHT).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text(""),
					cmp.text("")					
				);
		}


			 // report.pageFooter(Templates.footerComponent);
			  report.setDataSource(new JREmptyDataSource());
			//  report.show();
			  String nomePack=misura.getIntervento().getNomePack();
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+"_"+misura.getInterventoDati().getId()+""+misura.getStrumento().get__id()+".pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  certificato.setNomeCertificato(file.getName());
			  certificato.setDataCreazione(new Date());
			  session.update(certificato);
			  fos.close();
		} catch (Exception e) 
		{
			e.printStackTrace();
			throw e;
		}
		//return report;
	}

	public JasperReportBuilder getTableReportRip(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv","left")).setDataSource(new SubreportData("tipoVerifica"));
		SubreportBuilder subreportUM = cmp.subreport(new SubreportDesign("um","left")).setDataSource(new SubreportData("unitaDiMisura"));
		SubreportBuilder subreportVC = cmp.subreport(new SubreportDesign("vc","center")).setDataSource(new SubreportData("valoreCampione"));
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs","center")).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

			report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			  
			report.setColumnStyle(textStyle); //AGG
	
			report.addColumn(col.componentColumn("Tipo Verifica", subreport).setFixedWidth(120).setTitleFixedHeight(15));
			report.addColumn(col.componentColumn("UM", subreportUM));
			report.addColumn(col.componentColumn("Valore Campione", subreportVC));
			report.addColumn(col.column("Valore Medio Campione", "valoreMedioCampione", type.stringType()).setStretchWithOverflow(false));
			report.addColumn(col.componentColumn("Valore Strumento", subreportVS));
			report.addColumn(col.column("Valore Medio Strumento", "valoreMedioStrumento", type.stringType()).setStretchWithOverflow(false));
			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("Scostamento", "scostamento_correzione", type.stringType()).setStretchWithOverflow(false));

			}else{
				report.addColumn(col.column("Correzione", "scostamento_correzione", type.stringType()).setStretchWithOverflow(false));
			}
			report.addColumn(col.column("Accettabilità ", "accettabilita", type.stringType()).setStretchWithOverflow(false));
			report.addColumn(col.column("Incertezza U", "incertezza", type.stringType()).setStretchWithOverflow(false));
			report.addColumn(col.column("ESITO", "esito", type.stringType()).setFixedWidth(50).setStretchWithOverflow(false));

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	public JasperReportBuilder getTableReportLin(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv","left")).setDataSource(new SubreportData("tipoVerifica"));
		SubreportBuilder subreportUM = cmp.subreport(new SubreportDesign("um","left")).setDataSource(new SubreportData("unitaDiMisura"));
		SubreportBuilder subreportVC = cmp.subreport(new SubreportDesign("vc","center")).setDataSource(new SubreportData("valoreCampione"));
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs","center")).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

			report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			  
		
			report.addColumn(col.componentColumn("Tipo Verifica", subreport).setFixedWidth(120).setTitleFixedHeight(15));
			report.addColumn(col.componentColumn("UM", subreportUM));
			report.addColumn(col.componentColumn("Valore Campione", subreportVC));

			report.addColumn(col.componentColumn("Valore Strumento", subreportVS));

			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("Scostamento", "scostamento_correzione", type.stringType()).setStretchWithOverflow(false));

			}else{
				report.addColumn(col.column("Correzione", "scostamento_correzione", type.stringType()).setStretchWithOverflow(false));
			}

			report.addColumn(col.column("Accettabilità", "accettabilita", type.stringType()).setStretchWithOverflow(false));


			report.addColumn(col.column("Incertezza U", "incertezza", type.stringType()).setStretchWithOverflow(false));
			report.addColumn(col.column("ESITO", "esito", type.stringType()).setFixedWidth(50).setStretchWithOverflow(false));
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	public JasperReportBuilder getTableCampioni(List<CampioneDTO> listaCampioni){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);

			   
			report.setColumnStyle(textStyle); //AGG
		
			report.addColumn(col.column("Campione", "codice", type.stringType()).setWidth(30));
			report.addColumn(col.column("Matricola", "matricola", type.stringType()));
			TextColumnBuilder<Date> column = col.column("Data Scandenza", "dataScadenza", type.dateType());
			column.setPattern("dd/MM/yyyy");
			report.addColumn(column.setWidth(30));

			report.setDataSource(new JRBeanCollectionDataSource(listaCampioni));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	public JasperReportBuilder getTableProcedure(DRDataSource listaProcedure){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);

			  
			report.setColumnStyle(textStyle); //AGG


			report.addColumn(col.column("Procedura di Taratura","listaProcedure", type.stringType()));

			
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
		public SubreportDesign(String tipo, String alignment) {
			_tipo = tipo;
			_alignment = alignment;
		}

		@Override
		public JasperReportBuilder evaluate(ReportParameters reportParameters) {
			JasperReportBuilder report = report();
			if(_alignment.equals("center")){
				report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFontSize(7).setPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(15).setStretchWithOverflow(false));

			}else if(_alignment.equals("left")){
				report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFontSize(7).setPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(15).setStretchWithOverflow(false));

			}else{
				report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFontSize(7).setPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(15).setStretchWithOverflow(false));

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



	
}
