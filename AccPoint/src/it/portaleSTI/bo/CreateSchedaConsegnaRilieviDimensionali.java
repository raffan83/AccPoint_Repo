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
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.action.ContextListener;
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

public class CreateSchedaConsegnaRilieviDimensionali {
	public CreateSchedaConsegnaRilieviDimensionali(ArrayList<RilMisuraRilievoDTO> lista_rilievi, String consegnaDi, int checkStato, String ca, List<SedeDTO> listaSedi, String path_firma, UtenteDTO utente, Session session) throws Exception {
	
			build(lista_rilievi,consegnaDi,checkStato, ca, listaSedi, path_firma, utente,session);
		
	}
	
	private void build(ArrayList<RilMisuraRilievoDTO> lista_rilievi, String consegnaDi, int checkStato, String ca, List<SedeDTO> listaSedi, String path_firma, UtenteDTO utente, Session session) throws Exception {

		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaConsegnaRilieviMOD-SGI-031.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

 	
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(lista_rilievi.get(0).getCommessa());
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			int tot_quote = 0;
			int tot_pezzi = 0;
			
			for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
				tot_quote = tot_quote + rilievo.getN_quote();
				tot_pezzi = tot_pezzi + rilievo.getN_pezzi_tot();
				rilievo.setScheda_consegna(1);
			}

			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/1428_header_sc.jpg");
			
			if(imageHeader!=null && imageHeader.exists()) {
				report.addParameter("logo",imageHeader);
			}else {
				report.addParameter("logo","");
			}
			
			ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(lista_rilievi.get(0).getId_cliente_util()));
			SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, lista_rilievi.get(0).getId_sede_util(), cliente.get__id());
			
			if(cliente!=null && cliente.getNome()!=null && !cliente.getNome().equals("")) {
				if(sede!=null && sede.getDescrizione()!=null && !sede.getDescrizione().equals("")) {
					report.addParameter("cliente",sede.getDescrizione());	
				}else {
					report.addParameter("cliente",cliente.getNome());
				}
				
			}else {
				report.addParameter("cliente","");
			}
			
			String indirizzo = "";
			
			if(sede!=null && sede.getDescrizione()!=null && !sede.getDescrizione().equals("")) {
				indirizzo = sede.getIndirizzo();
				
			}else {
				if(cliente.getIndirizzo()!=null) {
					indirizzo = indirizzo +cliente.getIndirizzo();
				}
				if(cliente.getCap()!=null) {
					indirizzo = indirizzo + " - " + cliente.getCap();
				}
				if(cliente.getCitta()!=null) {
					indirizzo = indirizzo + " - " + cliente.getCitta();
				}
				if(cliente.getProvincia()!=null) {
					indirizzo = indirizzo + " (" + cliente.getProvincia() +")";
				}
			}
			
			report.addParameter("indirizzo",indirizzo);
			
			report.addParameter("codCommessa",commessa.getID_COMMESSA());
			report.addParameter("ca",ca);
			
			if(consegnaDi!=null && !consegnaDi.equals("") && !consegnaDi.equals("EFFETTUATI CONTROLLI DIMENSIONALI SU N PARTICOLARI CON UN TOTALE DI N QUOTE")) {
				report.addParameter("consegnaDi",consegnaDi);	
			}else {
				report.addParameter("consegnaDi","EFFETTUATI CONTROLLI DIMENSIONALI SU N° "+tot_pezzi+" PARTICOLARI CON UN TOTALE DI "+tot_quote+" QUOTE");
			}
			
			if(commessa.getDESCR()!=null) {
				report.addParameter("oggettoCommessa",commessa.getDESCR());	
			}else {
				report.addParameter("oggettoCommessa","");
			}
			
			if(commessa.getN_ORDINE()!=null) {
				report.addParameter("numeroOrdineCommessa",commessa.getN_ORDINE());
			}else {
				report.addParameter("numeroOrdineCommessa","");
			}
			if(checkStato == 0) {
				report.addParameter("consegnaDefinitiva",true);
				report.addParameter("statoAvanzamento",false);
			}else {
				report.addParameter("consegnaDefinitiva",false);
				report.addParameter("statoAvanzamento",true);
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("dataConsegna",""+sdf.format(new Date()));
			report.addParameter("company",lista_rilievi.get(0).getUtente().getCompany().getDenominazione());
			report.addParameter("nota",CostantiCertificato.NOTA_CONSEGNA);
			Calendar cal = Calendar.getInstance();
			cal.setTime(lista_rilievi.get(0).getData_consegna());
			report.addParameter("mese",lista_rilievi.get(0).getMese_riferimento() + " " + cal.get(Calendar.YEAR));
			
			File firma = new File(path_firma + utente.getNominativo().replace(" ", "_").toUpperCase() + ".jpg" );
			
			if(firma.exists()) {
				report.addParameter("firma",firma);			
			}else {
				report.addParameter("firma","");
			}
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(lista_rilievi));
			SubreportBuilder subreport2 = cmp.subreport(getTableReport2(lista_rilievi, tot_quote, tot_pezzi));
			report.addDetail(subreport);
			
			report.addDetail(cmp.horizontalList(cmp.horizontalGap(400), subreport2));
			
			report.setDataSource(new JREmptyDataSource());
			File folder = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\SchedeConsegna\\"+lista_rilievi.get(0).getId_cliente_util()+"\\"+lista_rilievi.get(0).getId_sede_util()+
					"\\"+cal.get(Calendar.YEAR)+"\\"+lista_rilievi.get(0).getMese_riferimento());
			if(!folder.exists()) {
				folder.mkdirs();
			}
			String filename = lista_rilievi.get(0).getCommessa().replace("/", "_");
			File file = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\SchedeConsegna\\"+lista_rilievi.get(0).getId_cliente_util()+"\\"+lista_rilievi.get(0).getId_sede_util()+
					"\\"+cal.get(Calendar.YEAR)+"\\"+lista_rilievi.get(0).getMese_riferimento()+"\\SCN_"+filename+".pdf");
			
			
			FileOutputStream fos = new FileOutputStream(file);
			report.toPdf(fos);
			  
			fos.flush();
			fos.close();

	}
	
	
	
	public JasperReportBuilder getTableReport(ArrayList<RilMisuraRilievoDTO> lista_rilievi) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(10);//AGG
		
	
		JasperReportBuilder report = DynamicReports.report();


			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));

			report.setColumnStyle(textStyle); //AGG
			report.addColumn(col.column("Disegno", "disegno", type.stringType()).setFixedWidth(80));
 	 		report.addColumn(col.column("Variante", "variante", type.stringType()).setFixedWidth(80));
	 		report.addColumn(col.column("Fornitore", "fornitore", type.stringType()).setFixedWidth(80));
	 		report.addColumn(col.column("Apparecchio", "apparecchio", type.stringType()).setFixedWidth(80));
	 		report.addColumn(col.column("Mese", "mese", type.stringType()).setFixedWidth(80));
	 		report.addColumn(col.column("N° Pezzi", "n_pezzi", type.stringType()).setFixedWidth(75));
	 		report.addColumn(col.column("N° Quote", "n_quote", type.stringType()).setFixedWidth(75));

			report.setDetailSplitType(SplitType.PREVENT);
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));
			report.setDataSource(createDataSource(lista_rilievi));
			
			

		return report;
	}
	
	
	public JasperReportBuilder getTableReport2(ArrayList<RilMisuraRilievoDTO> lista_rilievi, int tot_quote, int tot_pezzi) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(10);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));

	 		report.addColumn(col.column("Tot. Pezzi", "tot_pezzi", type.stringType()).setFixedWidth(75));
	 		report.addColumn(col.column("Tot. Quote", "tot_quote", type.stringType()).setFixedWidth(75));
	 		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));
	 		report.setDetailSplitType(SplitType.PREVENT);
			report.setDataSource(createDataSource2(lista_rilievi, tot_quote, tot_pezzi));
		
		return report;
	}

	private JRDataSource createDataSource(ArrayList<RilMisuraRilievoDTO> lista_rilievi)throws Exception {
			
			
		String[] listaCodici = new String[7];
		
		listaCodici[0]="disegno";
		listaCodici[1]="variante";
		listaCodici[2]="fornitore";
		listaCodici[3]="apparecchio";
		listaCodici[4]="mese";
		listaCodici[5]="n_pezzi";
		listaCodici[6]="n_quote";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);

			for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
				ArrayList<String> arrayPs = new ArrayList<String>();
				
				arrayPs.add(rilievo.getDisegno());
				arrayPs.add(rilievo.getVariante());
				arrayPs.add(rilievo.getFornitore());
				arrayPs.add(rilievo.getApparecchio());
				arrayPs.add(rilievo.getMese_riferimento());
				arrayPs.add(String.valueOf(rilievo.getN_pezzi_tot()));
				arrayPs.add(String.valueOf(rilievo.getN_quote()));

		        Object[] listaValori = arrayPs.toArray();
		        
		        dataSource.add(listaValori);		    
			}
 		    return dataSource;
 	}
	
	
	private JRDataSource createDataSource2(ArrayList<RilMisuraRilievoDTO> lista_rilievi, int tot_quote, int tot_pezzi)throws Exception {		
		
		String[] listaCodici = new String[2];
		
		listaCodici[0]="tot_pezzi";
		listaCodici[1]="tot_quote";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);

		dataSource.add(String.valueOf(tot_pezzi),String.valueOf(tot_quote));
 		return dataSource;
 	}
	
	
//	
//	public static void main(String[] args) throws HibernateException, Exception {
//		new ContextListener().configCostantApplication();
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();	
//		
//		ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilieviSchedaConsegna(76, 51, "Gennaio", session);	
//		List<SedeDTO> listaSedi = GestioneAnagraficaRemotaBO.getListaSedi();
//		
//		new CreateSchedaConsegnaRilieviDimensionali(lista_rilievi,"",0,"",listaSedi, "",session);
//		session.close();
//		System.out.println("FINITO");
//	}
	
	
	
}
