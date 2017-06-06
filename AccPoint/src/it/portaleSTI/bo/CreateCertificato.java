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
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;

import org.hibernate.Session;
/**
 * @author Ricardo Mariaca (r.mariaca@dynamicreports.org)
 */
public class CreateCertificato {

	public CreateCertificato(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento, Session session, ServletContext context) throws Exception {
		try {
			build(misura,certificato,lista, listaCampioni, listaProcedure, strumento,session,context);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}

	private void build(MisuraDTO misura, CertificatoDTO certificato, LinkedHashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure, StrumentoDTO strumento,Session session, ServletContext context) throws Exception {
		
		InputStream is = null;

		Iterator itLista = lista.entrySet().iterator();
		while (itLista.hasNext()) {

			Map.Entry pair = (Map.Entry)itLista.next();
			String pivot = pair.getKey().toString();		
			List<ReportSVT_DTO> listItem = (List<ReportSVT_DTO>) pair.getValue();
			SubreportBuilder subreport = null;
			if(pivot.equals("R_S") || pivot.equals("L_S")){
				is = CreateCertificato.class.getResourceAsStream("schedaVerificaHeaderSvt.jrxml");
			}
			if(pivot.equals("R_R") || pivot.equals("L_R")){
				is = CreateCertificato.class.getResourceAsStream("schedaVerificaHeaderRDT.jrxml");

			}



		}
	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		


		JasperReportBuilder report = DynamicReports.report();
		
		SubreportBuilder campioniSubreport = cmp.subreport(getTableCampioni(listaCampioni));
		
		SubreportBuilder procedureSubreport = cmp.subreport(getTableProcedure(listaProcedure));
	
		StyleBuilder styleTitleBold = Templates.rootStyle.setFontSize(10).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);


		TextFieldBuilder rifTextfield = cmp.text("Riferimenti Utilizzati e Metodo di Taratura");
		rifTextfield.setStyle(styleTitleBold);
	
		TextFieldBuilder ristTextfield = cmp.text("RISULTATI DELLA VERIFICA DI TARATURA");
		ristTextfield.setStyle(styleTitleBold);
		
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {

			URL header = null;//PannelloTOP.class.getResource
		
			//	FileInputStream stream1 = new FileInputStream(new File(header));
			
		//	FileInputStream stream2 = new FileInputStream(new File("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/header.jpg"));
			
		//	Object imageHeader = new File("/AccPoint/images/header.jpg");
			
			Object imageHeader = context.getResourceAsStream("images/header.jpg");
			
		//	FileInputStream streamFormula = new FileInputStream(new File("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/header.jpg"));


			
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
		//	report.pageHeader(Templates.createTitleComponent("JasperSubreport"),cmp.subreport(getJasperTitleSubreport()));

			report.addParameter("datiCliente",""+misura.getIntervento().getNome_sede());
		
			
				report.addParameter("sedeCliente","");
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("dataVerifica",""+sdf.format(misura.getDataMisura()));
			
			if(strumento.getScadenzaDTO().getDataProssimaVerifica()!=null)
				{
				report.addParameter("dataPropssimaVerifica",sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica()));
				
				}
			else
			{
				report.addParameter("dataPropssimaVerifica","");
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
			
			report.addParameter("temperatura",""+misura.getTemperatura());
			report.addParameter("umidita",""+misura.getUmidita());
			report.addParameter("rdtNumber","number");
			
			report.addParameter("logo",imageHeader);
			report.addParameter("logo2",imageHeader);
			
			report.setColumnStyle(textStyle); //AGG
			
			
			/*
			 * Dettaglio Campioni Utilizzati
			 */
			report.detail(rifTextfield);
			report.detail(cmp.verticalGap(5));
			
			report.detail(cmp.horizontalList(cmp.horizontalGap(20),campioniSubreport,cmp.horizontalGap(20),procedureSubreport,cmp.horizontalGap(20)));
			report.detail(cmp.verticalGap(5));

			/*
			 * Dettaglio Procedure
			 */
			
//			report.detail(procedureSubreport);
			report.detail(cmp.verticalGap(10));

			report.detail(cmp.line());
			report.detail(cmp.verticalGap(1));
			report.detail(cmp.line());
			report.detail(cmp.verticalGap(10));
			
			report.detail(ristTextfield);
			report.detail(cmp.verticalGap(10));

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
							cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							)
					)
				);
			if(false){
			report.lastPageFooter(cmp.verticalList(
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.horizontalList(
							
						cmp.verticalList(
							cmp.text("Incertezza associata allo strumento").setStyle(footerStyle),
							cmp.horizontalList(
									cmp.image("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/logo_acc_bg.jpg").setHeight(40),
									cmp.text("3,47 um").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(40)
								).setHeight(40),
							cmp.text("L'incertezze di misura dichiarate in questo documento sono espresse come due volte lo scarto tipo (corrispondente, nel caso di distribuzione normale, ad un livellodi confidenza di circa 95%)").setStyle(footerStyleFormula),
							cmp.line().setFixedHeight(1),	
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Esito della verifica:").setStyle(footerStyle),
											cmp.text("(U < Accettabilità)").setStyle(footerStyle)
									),
									cmp.text("IDONEO").setStyle(footerStyle))
							)
						,
						cmp.line().setFixedWidth(1),	
						cmp.verticalList(
							cmp.text("Note:").setStyle(footerStyle).setFixedHeight(3),
							cmp.text("Lorem ipsum dolor sitLorem ipsum dolor sit amet,  elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor i amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut la cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum").setStyle(footerStyleFormula),
							cmp.line().setFixedHeight(1),

							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Operatore (OT)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("Sig. Stefano Lucarelli").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("")
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text("Responsabile Laboratorio (RL)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("Sig. Terenzio Fantauzzi").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("")
										)
									)
							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
					
				);
		}else if(false){
			report.lastPageFooter(cmp.verticalList(
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.horizontalList(
							
						cmp.verticalList(
							cmp.text("Incertezza associata allo strumento").setStyle(footerStyle),
							cmp.horizontalList(
									cmp.image("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/logo_acc_bg.jpg").setHeight(40),
									cmp.text("3,47 um").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(40)
								).setHeight(40),
							cmp.text("L'incertezze di misura dichiarate in questo documento sono espresse come due volte lo scarto tipo (corrispondente, nel caso di distribuzione normale, ad un livellodi confidenza di circa 95%)").setStyle(footerStyleFormula),
							cmp.line().setFixedHeight(1),	
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Esito della verifica:").setStyle(footerStyle),
											cmp.text("(U < Accettabilità)").setStyle(footerStyle)
									),
									cmp.text("IDONEO").setStyle(footerStyle)
								)
							).setWidth(250)
						,
						cmp.line().setFixedWidth(1),	
						cmp.verticalList(
							cmp.text("Note:").setStyle(footerStyle).setHeight(1),
							cmp.text("sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolorm").setStyle(footerStyleFormula),
							cmp.line().setFixedHeight(1),

							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Operatore (OT)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("Sig. Stefano Lucarelli").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text("Responsabile Laboratorio (RL)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("Sig. Terenzio Fantauzzi").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										),
									cmp.line().setFixedWidth(1),
									cmp.verticalList(
											cmp.text("Per approvazione").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("Dott.ssa Emanuela Muscas").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										)
									)
							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
					
				);	
		}else{
			report.lastPageFooter(cmp.verticalList(
					cmp.line().setFixedHeight(1),	
					cmp.verticalGap(1),
					cmp.line().setFixedHeight(1),	
					cmp.horizontalList(
							
						cmp.verticalList(
							cmp.text("Incertezza associata allo strumento").setStyle(footerStyle),
							cmp.horizontalList(
									cmp.image("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/logo_acc_bg.jpg").setHeight(40),
									cmp.text("3,47 um").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(40)
								).setHeight(40),
							cmp.text("L'incertezze di misura dichiarate in questo documento sono espresse come due volte lo scarto tipo (corrispondente, nel caso di distribuzione normale, ad un livellodi confidenza di circa 95%)").setStyle(footerStyleFormula),
							cmp.line().setFixedHeight(1),	
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Esito della verifica:").setStyle(footerStyle),
											cmp.text("(U < Accettabilità)").setStyle(footerStyle)
									),
									cmp.text("IDONEO").setStyle(footerStyle)
								)
							).setWidth(250)
						,
						cmp.line().setFixedWidth(1),	
						cmp.verticalList(
							cmp.text("Note:").setStyle(footerStyle).setHeight(1),
							cmp.text("sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolorm").setStyle(footerStyleFormula),
							cmp.line().setFixedHeight(1),

							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Operatore (OT)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("Sig. Stefano Lucarelli").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setHeight(3),
											cmp.text("").setHeight(7)
										)
									
									)
							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
					)
					
					
					
					),
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
	
			report.addColumn(col.componentColumn("Tipo Verifica", subreport).setFixedWidth(100).setTitleFixedHeight(20));
			report.addColumn(col.componentColumn("UM", subreportUM));
			report.addColumn(col.componentColumn("Valore Campione", subreportVC));
			report.addColumn(col.column("Valore Medio Campione", "valoreMedioCampione", type.stringType()));
			report.addColumn(col.componentColumn("Valore Strumento", subreportVS));
			report.addColumn(col.column("Valore Medio Strumento", "valoreMedioStrumento", type.stringType()));
			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("scostamento", "scostamento_correzione", type.stringType()));

			}else{
				report.addColumn(col.column("correzione", "scostamento_correzione", type.stringType()));
			}
			report.addColumn(col.column("Accettabilit&agrave;�", "accettabilita", type.stringType()));
			report.addColumn(col.column("Incertezza U", "incertezza", type.stringType()));
			report.addColumn(col.column("ESITO", "esito", type.stringType()).setFixedWidth(70));

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
			  
		
			report.addColumn(col.componentColumn("Tipo Verifica", subreport).setFixedWidth(100).setTitleFixedHeight(20));
			report.addColumn(col.componentColumn("UM", subreportUM));
			report.addColumn(col.componentColumn("Valore Campione", subreportVC));

			report.addColumn(col.componentColumn("Valore Strumento", subreportVS));

			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("scostamento", "scostamento_correzione", type.stringType()));

			}else{
				report.addColumn(col.column("correzione", "scostamento_correzione", type.stringType()));
			}
			report.addColumn(col.column("Accettabilit&agrave;�", "accettabilita", type.stringType()));
			report.addColumn(col.column("Incertezza U", "incertezza", type.stringType()));
			report.addColumn(col.column("ESITO", "esito", type.stringType()).setFixedWidth(70));
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
		
			report.addColumn(col.column("Campione", "codice", type.stringType()));
			TextColumnBuilder<Date> column = col.column("Data Scandenza", "dataScadenza", type.dateType());
			column.setPattern("dd/MM/yyyy");
			report.addColumn(column);
		

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
				report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFontSize(7).setPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(25).setStretchWithOverflow(false));

			}else if(_alignment.equals("left")){
				report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFontSize(7).setPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(25).setStretchWithOverflow(false));

			}else{
				report.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontName("Trebuchet MS").setVerticalTextAlignment(VerticalTextAlignment.MIDDLE).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFontSize(7).setPadding(2).setVerticalTextAlignment(VerticalTextAlignment.MIDDLE)).setFixedHeight(25).setStretchWithOverflow(false));

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
