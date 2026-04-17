package it.portaleSTI.bo;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import java.lang.reflect.Field;

import org.apache.pdfbox.cos.COSBase;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.interactive.annotation.PDAnnotation;
import org.apache.pdfbox.pdmodel.interactive.annotation.PDAnnotationWidget;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;
import org.apache.pdfbox.pdmodel.interactive.form.PDNonTerminalField;
import org.apache.pdfbox.pdmodel.interactive.form.PDTerminalField;

import it.portaleSTI.DTO.SondaggioRLDTO;

public class LettoreModuliPdfBO {

    public static void main(String[] args) throws Exception {
     //   String pdfPath = "C:\\Users\\edoardo.boccitto\\Desktop\\querstionari regione\\Linee-guida-soddisfazione.pdf";  
        String pdfPath = "C:\\Users\\edoardo.boccitto\\Desktop\\querstionari regione\\cati Sondaggio_RL_2026_v1-.pdf";   
      //  String pdfPath = "C:\\Users\\edoardo.boccitto\\Desktop\\querstionari regione\\rosi Sondaggio_RL_2026_v1-.pdf"; 
    //      String pdfPath = "C:\\Users\\edoardo.boccitto\\Desktop\\querstionari regione\\Sondaggio_Prova_Risp.pdf"; 
        
        
        InputStream inputStream = new FileInputStream(pdfPath);
        scan(inputStream, SondaggioRLDTO.class);
    }
/*
    public static void scan(InputStream pdfPath) throws IOException {
        try (PDDocument doc = PDDocument.load(pdfPath)) {
            PDAcroForm acroForm = doc.getDocumentCatalog().getAcroForm();
            if (acroForm == null) {
                System.out.println("Nessun AcroForm (modulo) presente nel PDF.");
                return;
            }

            // Indicizza: widget (annotazione) -> numero pagina
            IdentityHashMap<PDAnnotationWidget, Integer> widgetToPage = indexWidgetsByPage(doc);

            // Flatten di tutti i campi
            List<PDField> allFields = flattenFields(acroForm.getFields());

            System.out.println("=== ELENCO CAMPI MODULO ===");
            for (PDField f : allFields) {
                System.out.println("- " + f.getFullyQualifiedName() + " = " + safeValue(f));
            }
/*
            System.out.println("\n=== RICERCA CAMPI ===");
            for (String wanted : fieldsToFind) {
                PDField field = acroForm.getField(wanted);

                // fallback: se nel PDF il campo fosse gerarchico tipo "dati.annualita"
                if (field == null) {
                    field = findBySuffix(allFields, wanted);
                }

                if (field == null) {
                    System.out.println("Campo '" + wanted + "' NON trovato.");
                    continue;
                }

                System.out.println("Campo trovato: " + field.getFullyQualifiedName());
                System.out.println("Valore: " + safeValue(field));

                if (field instanceof PDTerminalField) {
                    PDTerminalField tf = (PDTerminalField) field;
                    List<Integer> pages = getWidgetPagesRobusto(doc, tf);
                    System.out.println("Compare nelle pagine: " + pages);
                  
                } else {
                    System.out.println("Campo non-terminale (contenitore), niente widget diretti.");
                }

                System.out.println();
            }
        }
    }

    */
    private static String safeValue(PDField f) {
        try {
            String v = f.getValueAsString();
            return (v == null) ? "" : v;
        } catch (Exception e) {
            return "(errore lettura valore: " + e.getClass().getSimpleName() + ")";
        }
    }

    private static List<PDField> flattenFields(List<PDField> fields) {
        List<PDField> out = new ArrayList<>();
        for (PDField f : fields) {
            out.add(f);
            if (f instanceof PDNonTerminalField) {
                out.addAll(flattenFields(((PDNonTerminalField) f).getChildren()));
            }
        }
        return out;
    }

    private static PDField findBySuffix(List<PDField> allFields, String suffix) {
        for (PDField f : allFields) {
            String name = f.getFullyQualifiedName();
            if (name == null) continue;
            if (name.equals(suffix) || name.endsWith("." + suffix)) return f;
        }
        return null;
    }

    /**
     * Crea un indice widget->pagina scansionando le annotazioni di ogni pagina.
     * � il modo pi� affidabile (in molti PDF widget.getPage() � null).
     */
    private static IdentityHashMap<PDAnnotationWidget, Integer> indexWidgetsByPage(PDDocument doc) throws IOException {
        IdentityHashMap<PDAnnotationWidget, Integer> map = new IdentityHashMap<>();
        int pageNum = 1;
        for (PDPage page : doc.getPages()) {
            List<PDAnnotation> annots = page.getAnnotations();
            for (PDAnnotation a : annots) {
                if (a instanceof PDAnnotationWidget) {
                    map.put((PDAnnotationWidget) a, pageNum);
                }
            }
            pageNum++;
        }
        return map;
    }

    private static List<Integer> getWidgetPages(PDTerminalField tf,
                                               IdentityHashMap<PDAnnotationWidget, Integer> widgetToPage) {
        Set<Integer> pages = new LinkedHashSet<>();
        for (PDAnnotationWidget w : tf.getWidgets()) {
            Integer p = widgetToPage.get(w);
            if (p != null) pages.add(p);
        }
        return new ArrayList<>(pages);
    }
    
    private static List<Integer> getWidgetPagesRobusto(PDDocument doc, PDTerminalField field) throws IOException {
        // Set dei COS object dei widget del campo
        Set<COSBase> widgetCos = new HashSet<>();
        for (PDAnnotationWidget w : field.getWidgets()) {
            widgetCos.add(w.getCOSObject());
        }

        Set<Integer> pages = new LinkedHashSet<>();
        int pageNum = 1;
        for (PDPage page : doc.getPages()) {
            for (PDAnnotation ann : page.getAnnotations()) {
                if (ann instanceof PDAnnotationWidget) {
                    PDAnnotationWidget pw = (PDAnnotationWidget) ann;
                    if (widgetCos.contains(pw.getCOSObject())) {
                        pages.add(pageNum);
                    }
                }
            }
            pageNum++;
        }

        return new ArrayList<>(pages);
    }
    
    public static Object scan(InputStream pdfPath,Class<?> classe) throws IOException {
      
    	
    if (classe == SondaggioRLDTO.class) {
    	try (PDDocument doc = PDDocument.load(pdfPath)) {
    		System.out.println("Try eseguito");
            PDAcroForm acroForm = doc.getDocumentCatalog().getAcroForm();
            if (acroForm == null) {
                System.out.println("Nessun AcroForm (modulo) presente nel PDF.");
                return null;
            }


            SondaggioRLDTO obj = new SondaggioRLDTO();
           
            
            // Indicizza: widget (annotazione) -> numero pagina
            IdentityHashMap<PDAnnotationWidget, Integer> widgetToPage = indexWidgetsByPage(doc);

            // Flatten di tutti i campi
            List<PDField> allFields = flattenFields(acroForm.getFields());
            
      //      List<String> listKey = new ArrayList<String>();

         //   System.out.println("=== ELENCO CAMPI MODULO ===");
            int i=0;
            int j=0;
            Map<String, String>map = new LinkedHashMap<String, String>();
            for (PDField f : allFields) {
            	/*
            	if(safeValue(f)== null|| safeValue(f).equals("")) {
            		//System.out.println("è null");
            		j++;
            		obj.setByIndex(i, null);
            	}
            	obj.setByIndex(i, safeValue(f));
            	*/
              
              map.put(f.getFullyQualifiedName(), safeValue(f));
            
            	
            	i++;
               System.out.println("-- "+i+"  " + f.getFullyQualifiedName() + " = " + safeValue(f));
               
            }
            for (Map.Entry<String, String> entry : map.entrySet()) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
            }
            
            
            //controllare la funzione
            for (Map.Entry<String, String> entry : map.entrySet()) {

                String fieldName = entry.getKey();
                String value = entry.getValue();

                if (value == null || value.isEmpty()) {
                	 value = "";
                }

                try {
                    Field field = obj.getClass().getDeclaredField(fieldName);
                    field.setAccessible(true);

                    if (field.getType().equals(String.class)) {
                        field.set(obj, value);
                    } else if (field.getType().equals(int.class)) {
                        field.setInt(obj, Integer.parseInt(value));
                    }

                } catch (NoSuchFieldException e) {
                    // Campo presente nel PDF ma non nell'oggetto
                    System.out.println("Campo ignorato: " + fieldName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
    
            System.out.println("annualita " + obj.getAnnualita());
            System.out.println("Dom4 " + obj.getDom_4());
            
            obj.setCount(i-j);
       
     
            
           //modificare valori numerici con testo
           if(obj.getTipo_acc().equals("1")) {
        	   obj.setTipo_acc("Attività formativa Autorizzata e Finanziata");
           } else if(obj.getTipo_acc().equals("2")) {
        	   obj.setTipo_acc("Attività formativa Autorizzata");
           }
     
           
           
           if(obj.getFonte_fin().equals("1")) {
        	   obj.setFonte_fin("FSE");
        	   obj.setFonte_fin_txt_1(obj.getFonte_fin_txt_1());
           } else if(obj.getFonte_fin().equals("2")) {
        	   obj.setFonte_fin("Programma Garanzia per l’Occupabilità dei Lavoratori (GOL)");
        	   obj.setFonte_fin_txt_1(obj.getFonte_fin_txt_2());
           } else if(obj.getFonte_fin().equals("3")) {
        	   obj.setFonte_fin("Sistema Duale (SD)");
        	   obj.setFonte_fin_txt_1(obj.getFonte_fin_txt_3());
           } else if(obj.getFonte_fin().equals("4")) {
        	   obj.setFonte_fin("Altri Fondi pubblici");
        	   obj.setFonte_fin_txt_1(obj.getFonte_fin_txt_4());
           } else if(obj.getFonte_fin().equals("5")) {
        	   obj.setFonte_fin("Autofinanziamento");
           } 
         
           
           if(obj.getDurata().equals("1")) {
        	   obj.setDurata("fino a 30 ore");
           } else if(obj.getDurata().equals("2")) {
        	   obj.setDurata("da 31 a 60 ore");
           } else if(obj.getDurata().equals("3")) {
        	   obj.setDurata("da 61 a 100 ore");
           } else if(obj.getDurata().equals("4")) {
        	   obj.setDurata("da 101 a 300 ore");
           } else if(obj.getDurata().equals("5")) {
        	   obj.setDurata("da 301 a 900 ore");
           } else if(obj.getDurata().equals("6")) {
        	   obj.setDurata("oltre 900 ore");
           } 
         
           
           
           if(obj.getTitolo_ril().equals("1")) {
        	   obj.setTitolo_ril("attestato di frequenza");
           } else if(obj.getTitolo_ril().equals("2")) {
        	   obj.setTitolo_ril("idoneità all’annualità successiva");
           } else if(obj.getTitolo_ril().equals("3")) {
        	   obj.setTitolo_ril("certificazione competenze");
           } else if(obj.getTitolo_ril().equals("4")) {
        	   obj.setTitolo_ril("qualifica professionale");
           } else if(obj.getTitolo_ril().equals("5")) {
        	   obj.setTitolo_ril("diploma");
           } else if(obj.getTitolo_ril().equals("6")) {
        	   obj.setTitolo_ril("specializzazione");
           } else if(obj.getTitolo_ril().equals("7")) {
        	   obj.setTitolo_ril("abilitazione");
           } else if(obj.getTitolo_ril().equals("8")) {
        	   obj.setTitolo_ril("altro");
           } 
           
           
           if(obj.getTipologie_corso().equals("1")) {
        	   obj.setTipologie_corso("percorsi di istruzione e formazione professionale per l’assolvimento del "
        	   		+ " diritto/dovere all’istruzione e formazione "
        	   		+ " (macrotipologia “diritto/dovere”)");
           } else if(obj.getTipologie_corso().equals("2")) {
        	   obj.setTipologie_corso("formazione post diritto/dovere e formazione superiore ");
           } else if(obj.getTipologie_corso().equals("3")) {
        	   obj.setTipologie_corso("formazione continua: comprende la formazione "
        	   		+ "destinata a soggetti occupati, in Cassa Integrazione Guadagni e Mobilità "
        	   		+ "Fondi interprofessionali e nuovi ammortizzatori sociali (NASPI, DIS.COLL)");
           } else if(obj.getTipologie_corso().equals("4")) {
        	   obj.setTipologie_corso("formazione per target particolari (es. Programma GOL), "
        	   		+ "ovvero quelli ricondotti ad Avvisi specifici per utenze identificate come speciali, "
        	   		+ "ricomprese nelle aree di svantaggio");
           } else if(obj.getTipologie_corso().equals("5")) {
        	   obj.setTipologie_corso("Altro");
           } 
          
           
           
           if(obj.getMotivo_freq().equals("1")) {
        	   obj.setMotivo_freq("Per avere più opportunità di lavoro");
           } else if(obj.getMotivo_freq().equals("2")) {
        	   obj.setMotivo_freq("La formazione è prevista dal Patto di servizio personalizzato "
        	   		+ "(PSP) stipulato presso il Centro per l’impiego");
           } else if(obj.getMotivo_freq().equals("3")) {
        	   obj.setMotivo_freq("Perché rientrante nei percorsi di diritto/dovere");
           } else if(obj.getMotivo_freq().equals("4")) {
        	   obj.setMotivo_freq("Per interesse /crescita personale");
           } 
           
           
           if(obj.getCittadinanza().equals("1")) {
        	   obj.setCittadinanza("Italiana");
           } else if(obj.getCittadinanza().equals("2")) {
        	   obj.setCittadinanza("Unione Europea");
           } else if(obj.getCittadinanza().equals("3")) {
        	   obj.setCittadinanza("Extra UE");
           } 
           
           
           if(obj.getOccupazione().equals("1")) {
        	   obj.setOccupazione("Studente / Studente lavoratore");
           } else if(obj.getOccupazione().equals("2")) {
        	   obj.setOccupazione("Occupato");
           } else if(obj.getOccupazione().equals("3")) {
        	   obj.setOccupazione("Disoccupato");
           } else if(obj.getOccupazione().equals("4")) {
        	   obj.setOccupazione("Disoccupato beneficiario di sostegno al reddito (NASpI, DIS-COLL, altro)");
           } else if(obj.getOccupazione().equals("5")) {
        	   obj.setOccupazione("In cassa integrazione");
           } else if(obj.getOccupazione().equals("6")) {
        	   obj.setOccupazione("In apprendistato");
           } else if(obj.getOccupazione().equals("7")) {
        	   obj.setOccupazione("Lavoratore autonomo / Socio d’impresa");
           }
           
           
           if(obj.getTitolo_studio().equals("1")) {
        	   obj.setTitolo_studio("Nessun titolo di studio");
           } else if(obj.getTitolo_studio().equals("2")) {
        	   obj.setTitolo_studio("Licenza scuola media inferiore");
           } else if(obj.getTitolo_studio().equals("3")) {
        	   obj.setTitolo_studio("Qualifica professionale (triennale IeFP)");
           } else if(obj.getTitolo_studio().equals("4")) {
        	   obj.setTitolo_studio("Diploma professionale (percorso duale)");
           } else if(obj.getTitolo_studio().equals("5")) {
        	   obj.setTitolo_studio("Diploma scuola secondaria");
           } else if(obj.getTitolo_studio().equals("6")) {
        	   obj.setTitolo_studio("Diploma tecnico superiore (ITS)");
           } else if(obj.getTitolo_studio().equals("7")) {
        	   obj.setTitolo_studio("Laurea triennale");
           } else if(obj.getTitolo_studio().equals("8")) {
        	   obj.setTitolo_studio("Laurea specialistica/vecchio ordinamento");
           } else if(obj.getTitolo_studio().equals("9")) {
        	   obj.setTitolo_studio("Master/dottorato/post-laurea");
           } 
           
           
           if(obj.getDom_4().equals("1")) {
        	   obj.setDom_4("Sì");
           } else if(obj.getDom_4().equals("2")) {
        	   obj.setDom_4("No");
           }
        
           
           if(obj.getDom_5().equals("1")) {
        	   obj.setDom_5("Sì");
           } else if(obj.getDom_5().equals("2")) {
        	   obj.setDom_5("No");
           }
           //System.out.println("Dom_6: " + obj.getDom_6());
           //System.out.println("Dom_6_3: " + obj.getDom_6_3());
           if(obj.getDom_6().equals("1")) {
        	   obj.setDom_6("Sì");
           } else if(obj.getDom_6().equals("2")) {
        	   obj.setDom_6("No");
           }
         //  System.out.println("Dom_6: " + obj.getDom_6());
          // System.out.println("Dom_6_3: " + obj.getDom_6_3());
           if(obj.getDom_7().equals("1")) {
        	   obj.setDom_7("Sì");
           } else if(obj.getDom_7().equals("2")) {
        	   obj.setDom_7("No");
           }
           
           if(obj.getDom_7_1_1().equals("1")) {
        	   obj.setDom_7_1_1("Video lezioni in streaming in modalità sincrono");
           } else if(obj.getDom_7_1_1().equals("2")) {
        	   obj.setDom_7_1_1("Video lezioni in streaming in modalità sincrono e asincrono");
           }
           
           if(obj.getDom_8().equals("1")) {
        	   obj.setDom_8("Cercare un’occupazione");
           } else if(obj.getDom_8().equals("2")) {
        	   obj.setDom_8("Svolgere un tirocinio");
           } else if(obj.getDom_8().equals("3")) {
        	   obj.setDom_8("Continuare l’attuale percorso formativo fino al "
        	   		+ "raggiungimento della qualifica finale/diploma");
           } else if(obj.getDom_8().equals("4")) {
        	   obj.setDom_8("Riprendere un percorso d’istruzione");
           } else if(obj.getDom_8().equals("5")) {
        	   obj.setDom_8("Avviare un’attività imprenditoriale");
           } else if(obj.getDom_8().equals("6")) {
        	   obj.setDom_8("Migliorare le condizioni lavorative e/o avere uno sviluppo di carriera");
           }
           /*
           System.out.println("Dom_7_1_1: " + obj.getDom_7_1_1()); //giusta
           System.out.println("Dom_7_2_1: " + obj.getDom_7_2_1()); //esce 8
           System.out.println("Dom_8: " + obj.getDom_8()); //esce 8_1
           System.out.println("Dom_8_1: " + obj.getDom_8_1());   //esce 9
           System.out.println("Dom_9: " + obj.getDom_9()); //esce 7_2_1
           */
           
        return obj;
        }
		}
     
	return null;
    }
    
    
    
    
    
}
