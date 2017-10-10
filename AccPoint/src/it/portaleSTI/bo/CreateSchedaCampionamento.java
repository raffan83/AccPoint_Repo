package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.hibernate.HibernateException;

import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
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
	public CreateSchedaCampionamento(int idInterventoCampionamento, int idTipoCampionamento, ServletContext context) {
		try {
			ArrayList<DatasetCampionamentoDTO> listaDataset = GestioneCampionamentoBO.getListaDataset(idTipoCampionamento);
			LinkedHashMap<Integer,ArrayList<PlayloadCampionamentoDTO>> listaPayload = GestioneCampionamentoBO.getListaPayload(idInterventoCampionamento);
			
			build(listaDataset,listaPayload, context);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(ArrayList<DatasetCampionamentoDTO> listaDataset, LinkedHashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> listaPayload, ServletContext context) {
		
		InputStream is = TestReport2.class.getResourceAsStream("schedaCampionamentoPO007HeaderSvt.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			String temperatura = "20°C";
		
			Object imageHeader = new File("./WebContent/images/header.jpg");
 		
			InterventoCampionamentoDTO intervento =  GestioneCampionamentoBO.getIntervento("17");
			
			
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);


			report.addParameter("dataPrelievo","21/08/2017");
			report.addParameter("codiceCommessa",intervento.getID_COMMESSA());
			report.addParameter("operatore",intervento.getUser().getNominativo());
			report.addParameter("titoloProcedura","PROCEDURA DI CAMPIONAMENTO PO-005");
			
 
			report.addParameter("logo",imageHeader);
			report.addParameter("logo2",imageHeader);
			
			report.setColumnStyle(textStyle); //AGG
			
			SubreportBuilder subreport = cmp.subreport(getTableReport(listaDataset, listaPayload));
			
			report.detail(subreport);
		
			
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
			  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<DatasetCampionamentoDTO> listaDataset, HashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> listaPayload){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
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
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<DatasetCampionamentoDTO> listaDataset, HashMap<Integer, ArrayList<PlayloadCampionamentoDTO>> listaPayload) {
			
		
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
		        
		        System.out.println(pair.getKey() + " = " + pair.getValue());
		        
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
