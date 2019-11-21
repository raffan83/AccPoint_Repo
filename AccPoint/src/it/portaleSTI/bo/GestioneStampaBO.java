package it.portaleSTI.bo;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.EnumMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.swing.JTextField;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneStampaBO {

	public static int stampaEtichetta(StrumentoDTO strumento,boolean esito,Date dataMisura,String codice,String nomePacchetto,CompanyDTO cmp)
	{
		
	try{	
		
		
		if(codice==null)
		{
			return -1;
		}
		
		PrinterJob pj = PrinterJob.getPrinterJob();
		
		if (pj.printDialog()) {
		PageFormat pf = pj.defaultPage();
		Paper paper = pf.getPaper(); 
		double width = fromCMToPPI(11);
		double height = fromCMToPPI(2); 

		
		paper.setSize(width, height);
		paper.setImageableArea(
		12, 
		12, 
		fromCMToPPI(8), 
		fromCMToPPI(5)); 
	//	System.out.println("Before- " + dump(paper)); 
		pf.setOrientation(PageFormat.PORTRAIT);
		
		pf.setPaper(paper); 
	//	System.out.println("After- " + dump(paper));
	//	System.out.println("After- " + dump(pf)); 
		dump(pf); 
		PageFormat validatePage = pj.validatePage(pf);
	//	System.out.println("Valid- " + dump(validatePage)); 
		
		pj.setPrintable(new MyPrintable(strumento,codice,esito,dataMisura,nomePacchetto), pf);
		
		pj.print();
		}} catch 
		
		(Exception ex) {
			ex.printStackTrace();
		} 

		return 0;
		
	}

protected static double fromCMToPPI(double cm) { 
	return toPPI(cm * 0.393700787); 
	}


	protected static double toPPI(double inch) { 
	return inch * 72d; 
	}


	protected static String dump(Paper paper) { 
	StringBuilder sb = new StringBuilder(64);
	sb.append(paper.getWidth()).append("x").append(paper.getHeight())
	.append("/").append(paper.getImageableX()).append("x").
	append(paper.getImageableY()).append(" - ").append(paper
	.getImageableWidth()).append("x").append(paper.getImageableHeight()); 
	return sb.toString(); 
	}


	protected static String dump(PageFormat pf) { 
	Paper paper = pf.getPaper(); 
	return dump(paper); 
	}
	
	public static class MyPrintable implements Printable {

		StrumentoDTO strumento;
		Date dataMisura;
		String codice;
		JTextField nCertificatoField;
		boolean esito;
		String nomePacchetto;
		
		public MyPrintable(StrumentoDTO _strumento, String _codice, boolean _esito, Date _dataMisura,String _nomePacchetto)
		{
			strumento=_strumento;
			codice=_codice;
			esito=_esito;
			dataMisura=_dataMisura;
			nomePacchetto=_nomePacchetto;
			
		}
		
		@Override
		public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException { 
		
		int result = NO_SUCH_PAGE; 	
		try
		{	
		
	
		if (pageIndex < 1) { 
		Graphics2D g2d = (Graphics2D) graphics; 

		g2d.translate((int) pageFormat.getImageableX(), (int) pageFormat.getImageableY()); 
		FontMetrics fm = g2d.getFontMetrics();
		int corAscent=fm.getAscent()+5;
		int incrementRow=6;
		g2d.setFont(new Font("Arial", Font.ITALIC, 5)); 

		Image img1Header = Toolkit.getDefaultToolkit().getImage(Costanti.PATH_FOLDER_LOGHI+"/logo_etichetta.png");
	    g2d.drawImage(img1Header, 0,0,46, 18, null);
		
		corAscent=corAscent+incrementRow;    
		
	//	if(strumento.getCodice_interno()!=null && !strumento.getCodice_interno().equals("/") && 
	//			!strumento.getCodice_interno().equals("\\") && strumento.getCodice_interno().length()>0)
	//	{
		g2d.drawString("Codice Interno",0,corAscent);
		
		g2d.setFont(new Font("Arial", Font.BOLD, 5));
		corAscent=corAscent+incrementRow;
	    g2d.drawString(strumento.getCodice_interno(),0,corAscent);
	    corAscent=corAscent+incrementRow;
	//	}
	//	else
	//	{
	    g2d.setFont(new Font("Arial", Font.ITALIC, 5));
			g2d.drawString("Matricola",0,corAscent);
			
	//		if(strumento.getMatricola()!=null)
	//		{
			g2d.setFont(new Font("Arial", Font.BOLD, 5));
				corAscent=corAscent+incrementRow;
				g2d.drawString(strumento.getMatricola(),0,corAscent);
		//	}
	//	}
	    g2d.setFont(new Font("Arial", Font.ITALIC, 5));
	    corAscent=corAscent+incrementRow;
	    g2d.drawString("Data verifica",0,corAscent);
	    
	    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	    g2d.setFont(new Font("Arial", Font.BOLD, 5));
	    corAscent=corAscent+incrementRow;    
	    g2d.drawString(sdf.format(dataMisura),0,corAscent);
	        
	   
	    g2d.setFont(new Font("Arial", Font.ITALIC, 5));
	    corAscent=corAscent+incrementRow;
	    g2d.drawString("Pross. verifica",0,corAscent);
	    	
	    if(esito)
	    {
	    	Calendar c = Calendar.getInstance(); 
			c.setTime(dataMisura); 
	    	c.add(Calendar.MONTH,strumento.getFrequenza());
		    c.getTime();
	    g2d.setFont(new Font("Arial", Font.BOLD, 5));
	    corAscent=corAscent+incrementRow;
	    g2d.drawString(sdf.format(new java.sql.Date(c.getTime().getTime())),0,corAscent);
	    }else
	    {
	    	g2d.setFont(new Font("Arial", Font.BOLD, 5));
	  	    corAscent=corAscent+incrementRow;
	  	    g2d.drawString("- - ",0,corAscent);
	    }
	    
	    g2d.setFont(new Font("Arial", Font.ITALIC, 5));
	    corAscent=corAscent+incrementRow;
	    g2d.drawString("N° Scheda",0,corAscent);
	   
	  
	    g2d.setFont(new Font("Arial", Font.BOLD, 5));
	    corAscent=corAscent+incrementRow;
	    g2d.drawString(codice,0,corAscent);
	    	
	    
	   if(strumento.getCreato().equals("N"))
	   {
		String pathPacchetto= Costanti.PATH_FOLDER+"\\"+nomePacchetto;
	    createQR(strumento,pathPacchetto);
	    Image img1 = Toolkit.getDefaultToolkit().getImage(pathPacchetto+"\\qr.png");
	    int w11=img1.getWidth(null);
	    int h11=img1.getHeight(null);
	    g2d.drawImage(img1, -5,corAscent,w11, h11, null);
	   
	   }
		result = PAGE_EXISTS;
		pageIndex=1;
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result; 
		}

		}
	
	
	public static void createQR(StrumentoDTO strumento, String pathPacchetto)
	{
		String myCodeText = "http://www.calver.it/dettaglioStrumentoFull.do?id_str="+strumento.get__id();
		String filePath = pathPacchetto+"\\qr.png";
		int size = 60;
		String fileType = "png";
		File myFile = new File(filePath);
		try {
			
			Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
			hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			
			// Now with zxing version 3.2.1 you could change border size (white border size to just 1)
			hintMap.put(EncodeHintType.MARGIN, 0); /* default = 4 */
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
 
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size,
					size, hintMap);
			int CrunchifyWidth = byteMatrix.getWidth();
			BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,
					BufferedImage.TYPE_INT_RGB);
			image.createGraphics();
 
			Graphics2D graphics = (Graphics2D) image.getGraphics();
			graphics.setColor(Color.WHITE);
			graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
			graphics.setColor(Color.BLACK);
 
			for (int i = 0; i < CrunchifyWidth; i++) {
				for (int j = 0; j < CrunchifyWidth; j++) {
					if (byteMatrix.get(i, j)) {
						graphics.fillRect(i, j, 1, 1);
					}
				}
			}
			ImageIO.write(image, fileType, myFile);
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
