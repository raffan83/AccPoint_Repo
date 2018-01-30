package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.apache.commons.lang3.ArrayUtils;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.TestReport2;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;

public class CreateSchedaCampionamento {
	public CreateSchedaCampionamento(InterventoCampionamentoDTO intervento, Session session, ServletContext context) throws Exception {
		try {
			ArrayList<DatasetCampionamentoDTO> listaDataset = GestioneCampionamentoBO.getListaDataset(intervento.getTipoCampionamento().getId());
			LinkedHashMap<Integer,ArrayList<PlayloadCampionamentoDTO>> listaPayload = GestioneCampionamentoBO.getListaPayload(intervento.getId(),session);
			
			build(listaDataset,listaPayload, context,intervento);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(ArrayList<DatasetCampionamentoDTO> listaDataset, LinkedHashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> listaPayload, ServletContext context, InterventoCampionamentoDTO intervento) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaCampionamentoPO007HeaderSvt.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			String temperatura = "";
			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getUser().getCompany().getNomeLogo());
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getUser().getCompany().getNomeLogo());

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);


			SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("dataPrelievo",sdf.format(intervento.getDataChiusura()));
			
			report.addParameter("codiceCommessa",intervento.getID_COMMESSA());
			report.addParameter("operatore",intervento.getUser().getNominativo());
			report.addParameter("titoloProcedura","PROCEDURA DI CAMPIONAMENTO PO-005");
			
			if(imageHeader!=null) {
			report.addParameter("logo",imageHeader);
			report.addParameter("logo2",imageHeader);
			}
			
			report.setColumnStyle(textStyle); //AGG
			
			SubreportBuilder subreport = cmp.subreport(getTableReport(listaDataset, listaPayload));
			
			report.detail(subreport);
		
			
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(intervento.getID_COMMESSA());
			
			HashMap<String, ArrayList<AttivitaMilestoneDTO>> hadshAttivita = new HashMap<String, ArrayList<AttivitaMilestoneDTO>>();
			
			String[] attivitaIntervento = intervento.getIdAttivita().split(Pattern.quote("|"));
			
			for (AttivitaMilestoneDTO attivita : commessa.getListaAttivita()) {
				if(ArrayUtils.contains(attivitaIntervento, attivita.getCodiceAggregatore())) {
					if(hadshAttivita.containsKey(attivita.getCodiceAggregatore())) {
						ArrayList<AttivitaMilestoneDTO> listaAtt = hadshAttivita.get(attivita.getCodiceAggregatore());
						listaAtt.add(attivita);
					}else {
						ArrayList<AttivitaMilestoneDTO> listaAtt = new ArrayList<AttivitaMilestoneDTO>();
						listaAtt.add(attivita);
						hadshAttivita.put(attivita.getCodiceAggregatore(), listaAtt);
					}
				}
			}
		
			Iterator it = hadshAttivita.entrySet().iterator();
		    while (it.hasNext()) {
		    	 	Map.Entry pair = (Map.Entry)it.next();
		    	 	
		    	 	ArrayList<AttivitaMilestoneDTO> listaAtt = (ArrayList<AttivitaMilestoneDTO>) pair.getValue();
		    		SubreportBuilder subreportx = cmp.subreport(getTableReportAttivita(listaAtt));
		    		report.addDetail(cmp.pageBreak());
		    		report.addDetail(cmp.text(" "));
		    		report.addDetail(cmp.text(""+pair.getKey()).setStyle(textStyle));
				report.addDetail(subreportx);
		    }
			
			
			
			
			report.pageFooter(cmp.verticalList(
 					cmp.horizontalList(
							
						cmp.verticalList(
							cmp.text("Temperatura trasporto campioni: "+temperatura).setStyle(footerStyle).setHeight(1),
							cmp.verticalGap(10),
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Firma Operatore (OT)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT),
											cmp.text("_____________________________________________________________").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT)


										),
									cmp.horizontalGap(100),
  									cmp.verticalList(
											cmp.text("Firma Cliente Per approvazione").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT),
											cmp.text("_____________________________________________________________").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT)

										)
 									),
							cmp.verticalGap(10)

							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(footerStyle),
						cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
					
				);	
		


			 // report.pageFooter(Templates.footerComponent);
			  report.setDataSource(new JREmptyDataSource());
			  
			  String nomePack=intervento.getNomePack();
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+".pdf");
			  
			  
			  
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			//  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	
	public JasperReportBuilder getTableReportAttivita(ArrayList<AttivitaMilestoneDTO> arrayList) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);
			report.setColumnStyle(textStyle); //AGG
 
 	 		report.addColumn(col.column("Descrizione", "descrizione", type.stringType()));
	 		report.addColumn(col.column("Codice Articolo", "codice", type.stringType()));


			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSourceAttivita(arrayList));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSourceAttivita(ArrayList<AttivitaMilestoneDTO> listaAttivitai)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		String[] listaCodici = new String[5];
		
		listaCodici[0]="descrizione";
		listaCodici[1]="codice";

		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
			for (AttivitaMilestoneDTO attivita : listaAttivitai) {
				
				if(attivita!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					
	 				arrayPs.add(attivita.getDescrizioneArticolo());
	 				arrayPs.add(attivita.getCodiceArticolo());

					
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
			
			}
 		    return dataSource;
 	}
	
	public JasperReportBuilder getTableReport(ArrayList<DatasetCampionamentoDTO> listaDataset, HashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> listaPayload) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

 	

			  
			report.setColumnStyle(textStyle); //AGG


			for (DatasetCampionamentoDTO campionamentoDataset : listaDataset) {
	 			report.addColumn(col.column(campionamentoDataset.getNomeCampo(), campionamentoDataset.getCodiceCampo(), type.stringType()));
			}
			

			
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(listaDataset, listaPayload));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<DatasetCampionamentoDTO> listaDataset, HashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> listaPayload)throws Exception {

		ArrayList<String> listaString = new ArrayList<String>();

			

			for (DatasetCampionamentoDTO dataset : listaDataset) {
				listaString.add(dataset.getCodiceCampo());
				
			
			}
			
			String[] listaCodici = new String[listaString.size()];
			
			for(int j=0; j < listaString.size(); j++) {
				listaCodici[j]=listaString.get(j).toString();
			}
			
			DRDataSource dataSource = new DRDataSource(listaCodici);
			
			Iterator it = listaPayload.entrySet().iterator();
		    while (it.hasNext()) {
		        Map.Entry pair = (Map.Entry)it.next();
		        
		     //   System.out.println(pair.getKey() + " = " + pair.getValue());
		        
		        ArrayList<PlayloadCampionamentoDTO> arrayPay = (ArrayList<PlayloadCampionamentoDTO>) pair.getValue();
		        ArrayList<String> arrayPs = new ArrayList<String>();
		        for (PlayloadCampionamentoDTO campionamentoPlayloadDTO : arrayPay) {
		        		arrayPs.add(campionamentoPlayloadDTO.getValore_misurato());

				}
		       
		         Object[] listaValori = arrayPs.toArray();
		        dataSource.add(listaValori);
		        it.remove(); // avoids a ConcurrentModificationException
		    }

 		      return dataSource;
 	}
}
