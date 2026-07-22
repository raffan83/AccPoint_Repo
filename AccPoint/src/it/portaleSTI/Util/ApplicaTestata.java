package it.portaleSTI.Util;
import java.io.FileOutputStream;

import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

public class ApplicaTestata {

    public static void main(String[] args) throws Exception {

        String inputPdf = "C:\\Users\\raffaele.fantini\\Desktop\\bilance.pdf";
        String outputPdf = "C:\\Users\\raffaele.fantini\\Desktop\\certificato_finale.pdf";
        String headerPng = "C:\\Users\\raffaele.fantini\\Desktop\\header.png";

        PdfReader reader = new PdfReader(inputPdf);
        PdfStamper stamper = new PdfStamper(reader,
                new FileOutputStream(outputPdf));

        for (int i = 1; i <= reader.getNumberOfPages(); i++) {

            Rectangle page = reader.getPageSize(i);

            Image header = Image.getInstance(headerPng);

            // Adatta l'immagine alla larghezza della pagina
            header.scaleAbsolute(page.getWidth(), 125);

            // Posizionamento in alto
            float x = 0;
            float y = page.getHeight() - 125;

            header.setAbsolutePosition(x, y);

            PdfContentByte cb = stamper.getOverContent(i);
            cb.addImage(header);
        }

        stamper.close();
        reader.close();
    }
}