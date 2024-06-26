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
	public CreateSchedaConsegnaRilieviDimensionali(ArrayList<RilMisuraRilievoDTO> lista_rilievi, String commessa, String consegnaDi, int checkStato, String ca, List<SedeDTO> listaSedi, String path_firma, UtenteDTO utente, String anno, String mese, Session session) throws Exception {
	
			build(lista_rilievi, commessa, consegnaDi,checkStato, ca, listaSedi, path_firma, utente, anno, mese, session);
		
	}
	
	private void build(ArrayList<RilMisuraRilievoDTO> lista_rilievi, String id_commessa, String consegnaDi, int checkStato, String ca, List<SedeDTO> listaSedi, String path_firma, UtenteDTO utente, String anno, String mese,Session session) throws Exception {

		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaConsegnaRilieviMOD-SGI-031.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

 	
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(id_commessa);
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			int tot_quote = 0;
			int tot_pezzi = 0;
			double tot_ore = 0.0; 
			ArrayList<RilMisuraRilievoDTO> lista_non_lavorati = new ArrayList<RilMisuraRilievoDTO>();
			
			for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
				if(rilievo.getNon_lavorato()==0) {
					tot_quote = tot_quote + rilievo.getN_quote();
					tot_pezzi = tot_pezzi + rilievo.getN_pezzi_tot();
					if(rilievo.getTempo_scansione()!=null) {
						tot_ore = tot_ore + rilievo.getTempo_scansione();	
					}
				}
				else {
					lista_non_lavorati.add(rilievo);
				}
				rilievo.setScheda_consegna(1);
			}

			
		
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/1428_header_sc.jpg");
			
			if(imageHeader!=null && imageHeader.exists()) {
				report.addParameter("logo",imageHeader);
			}else {
				report.addParameter("logo","");
			}
			ClienteDTO cliente = null;
			SedeDTO sede = null;
			if(lista_rilievi.size()>0) {
			cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(lista_rilievi.get(0).getId_cliente_util()));
			sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, lista_rilievi.get(0).getId_sede_util(), cliente.get__id());
			}
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
				if(cliente!=null && cliente.getIndirizzo()!=null) {
					indirizzo = indirizzo +cliente.getIndirizzo();
				}
				if(cliente!=null && cliente.getCap()!=null) {
					indirizzo = indirizzo + " - " + cliente.getCap();
				}
				if(cliente!=null && cliente.getCitta()!=null) {
					indirizzo = indirizzo + " - " + cliente.getCitta();
				}
				if(cliente!=null && cliente.getProvincia()!=null) {
					indirizzo = indirizzo + " (" + cliente.getProvincia() +")";
				}
			}
			
			report.addParameter("indirizzo",indirizzo);
			
			report.addParameter("codCommessa",commessa.getID_COMMESSA());
			report.addParameter("ca",ca);
			
			if(consegnaDi!=null && !consegnaDi.equals("") && !consegnaDi.equals("EFFETTUATI CONTROLLI DIMENSIONALI SU N PARTICOLARI CON UN TOTALE DI N QUOTE E DI N ORE SCANSIONE")) {
				report.addParameter("consegnaDi",consegnaDi);	
			}else {
				if(lista_rilievi.get(0).getTipo_rilievo().getId()==3) {
					report.addParameter("consegnaDi","EFFETTUATA SCANSIONE LASER CON SOVRAPPOSIZIONE A MODELLO MATEMATICO PER CALCOLO DEVIAZIONE.");
				}else {
					report.addParameter("consegnaDi","EFFETTUATI CONTROLLI DIMENSIONALI SU N° "+tot_pezzi+" PARTICOLARI CON UN TOTALE DI "+tot_quote+" QUOTE E DI "+tot_ore+" ORE SCANSIONE");	
				}
				
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
			if(lista_rilievi.size()>0) {
				report.addParameter("company",lista_rilievi.get(0).getUtente().getCompany().getDenominazione());	
			}else {
				report.addParameter("company","");
			}
			
			report.addParameter("nota",CostantiCertificato.NOTA_CONSEGNA);
			Calendar cal = Calendar.getInstance();
			cal.setTime(lista_rilievi.get(0).getData_consegna());

		//	if(lista_rilievi.size()>0) {
	//			report.addParameter("mese",lista_rilievi.get(0).getMese_riferimento() + " " + anno);
			//}else {
				report.addParameter("mese","");	
		//	}
			
			
			//File firma = new File(path_firma + utente.getNominativo().replace(" ", "_").toUpperCase() + ".jpg" );
			File firma = new File(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma());
			if(firma.exists()) {
				report.addParameter("firma",firma);			
			}else {
				report.addParameter("firma","");
			}
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(lista_rilievi, false));
			SubreportBuilder subreport2 = cmp.subreport(getTableReport2(lista_rilievi, tot_quote, tot_pezzi, tot_ore));
			report.addDetail(subreport);
			
			report.addDetail(cmp.horizontalList(cmp.horizontalGap(335), subreport2));
			
		
			
			if(lista_non_lavorati.size()>0) {
				SubreportBuilder subreport3 = cmp.subreport(getTableReport(lista_non_lavorati, true));
				report.addDetail(cmp.verticalList(cmp.verticalGap(50), cmp.text("RILIEVI NON LAVORATI").setStyle(stl.style().setFontSize(16).setBold(true)), cmp.verticalGap(10)));
				report.addDetail(subreport3);
			}
			
			report.setDataSource(new JREmptyDataSource());
			File folder = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\SchedeConsegna\\"+lista_rilievi.get(0).getId_cliente_util()+"\\"+lista_rilievi.get(0).getId_sede_util()+
					"\\"+anno+"\\"+mese);
			if(!folder.exists()) {
				folder.mkdirs();
			}
			String filename = lista_rilievi.get(0).getCommessa().replace("/", "_");
			File file = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\SchedeConsegna\\"+lista_rilievi.get(0).getId_cliente_util()+"\\"+lista_rilievi.get(0).getId_sede_util()+
					"\\"+anno+"\\"+mese+"\\SCN_"+filename+".pdf");
			
			
			FileOutputStream fos = new FileOutputStream(file);
			report.toPdf(fos);
			  
			fos.flush();
			fos.close();

	}
	
	
	
	public JasperReportBuilder getTableReport(ArrayList<RilMisuraRilievoDTO> lista_rilievi, boolean non_lavorati) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(10);//AGG
		
	
		JasperReportBuilder report = DynamicReports.report();


			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));

			report.setColumnStyle(textStyle); //AGG
			if(!non_lavorati) {
				report.addColumn(col.column("Disegno", "disegno", type.stringType()).setFixedWidth(85));
	 	 		report.addColumn(col.column("Variante", "variante", type.stringType()).setFixedWidth(85));
		 		report.addColumn(col.column("Fornitore", "fornitore", type.stringType()).setFixedWidth(85));
		 		report.addColumn(col.column("Apparecchio", "apparecchio", type.stringType()).setFixedWidth(80));
			}else {
				report.addColumn(col.column("Disegno", "disegno", type.stringType()).setFixedWidth(140));
	 	 		report.addColumn(col.column("Variante", "variante", type.stringType()).setFixedWidth(140));
		 		report.addColumn(col.column("Fornitore", "fornitore", type.stringType()).setFixedWidth(140));
		 		report.addColumn(col.column("Apparecchio", "apparecchio", type.stringType()).setFixedWidth(135));
			}
	 		//report.addColumn(col.column("Mese", "mese", type.stringType()).setFixedWidth(65));
	 		if(!non_lavorati) {
	 			report.addColumn(col.column("N° Pezzi", "n_pezzi", type.stringType()).setFixedWidth(75));
	 			report.addColumn(col.column("N° Quote", "n_quote", type.stringType()).setFixedWidth(75));
	 			report.addColumn(col.column("Tempo scansione (Ore)", "tempo_scansione", type.stringType()).setFixedWidth(70));
	 		}
			report.setDetailSplitType(SplitType.PREVENT);
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));
			report.setDataSource(createDataSource(lista_rilievi, non_lavorati));
			
			

		return report;
	}
	
	
	public JasperReportBuilder getTableReport2(ArrayList<RilMisuraRilievoDTO> lista_rilievi, int tot_quote, int tot_pezzi, double tot_ore) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(10);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));

	 		report.addColumn(col.column("Tot. Pezzi", "tot_pezzi", type.stringType()).setFixedWidth(75));
	 		report.addColumn(col.column("Tot. Quote", "tot_quote", type.stringType()).setFixedWidth(75));
	 		report.addColumn(col.column("Tot. Ore", "tot_ore", type.stringType()).setFixedWidth(70));
	 		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));
	 		report.setDetailSplitType(SplitType.PREVENT);
			report.setDataSource(createDataSource2(lista_rilievi, tot_quote, tot_pezzi, tot_ore));
		
		return report;
	}

	private JRDataSource createDataSource(ArrayList<RilMisuraRilievoDTO> lista_rilievi, boolean non_lavorati)throws Exception {
			
			
		String[] listaCodici = null;
		
		if(non_lavorati) {
			listaCodici = new String[4];
		}else {
			listaCodici = new String[7];	
		}
		
		
		listaCodici[0]="disegno";
		listaCodici[1]="variante";
		listaCodici[2]="fornitore";
		listaCodici[3]="apparecchio";
	//	listaCodici[4]="mese";
		if(!non_lavorati) {
			listaCodici[4]="n_pezzi";
			listaCodici[5]="n_quote";
			listaCodici[6]="tempo_scansione";
		}
		DRDataSource dataSource = new DRDataSource(listaCodici);

			for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
				if(rilievo.getNon_lavorato()==0 || non_lavorati) {
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					arrayPs.add(rilievo.getDisegno());
					arrayPs.add(rilievo.getVariante());
					arrayPs.add(rilievo.getFornitore());
					arrayPs.add(rilievo.getApparecchio());
				//	arrayPs.add(rilievo.getMese_riferimento());
					if(!non_lavorati) {
						arrayPs.add(String.valueOf(rilievo.getN_pezzi_tot()));
						arrayPs.add(String.valueOf(rilievo.getN_quote()));
						if(rilievo.getTempo_scansione()!=null) {
							arrayPs.add(""+rilievo.getTempo_scansione());
						}else {
							arrayPs.add("");	
						}
					}
			        Object[] listaValori = arrayPs.toArray();
			        
			        dataSource.add(listaValori);	
				}
					    
			}
 		    return dataSource;
 	}
	
	
	private JRDataSource createDataSource2(ArrayList<RilMisuraRilievoDTO> lista_rilievi, int tot_quote, int tot_pezzi, double tot_ore)throws Exception {		
		
		String[] listaCodici = new String[3];
		
		listaCodici[0]="tot_pezzi";
		listaCodici[1]="tot_quote";
		listaCodici[2]="tot_ore";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);

		dataSource.add(String.valueOf(tot_pezzi),String.valueOf(tot_quote), String.valueOf(tot_ore));
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
