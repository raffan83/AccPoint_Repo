<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DAO.SessionFacotryDAO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="org.hibernate.Session"%>
<%@ page import = "javax.servlet.RequestDispatcher" %>
<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:layout title="Registrazione" bodyClass="hold-transition login-page">


	<jsp:attribute name="body_area"> 
 

  <div class="registrazione">
	
	
  <div class="login-logo">
    <img src="./images/logo_calver_v2.png" style="width: 200px">
  </div>
  <!-- /.login-logo -->
 


 <div class="box box-danger">
<div class="box-header with-border">

	
</div>
<div class="box-body">
<div class="row">


  <div class="col-xs-12">
  

  
  
<h4 style="text-align:center"><b>  INFORMATIVA PRIVACY</b><br></h4>

<h6 style="text-align:center">
(D. Lgs. 196/2003 e smi - Art. 13 del Regolamento Generale UE sulla protezione dei dati personali n. 2016/679)
</h6>
<textarea class="form-control" style="width:100%" rows="21" readonly id="text">
S.T.I. Sviluppo Tecnologie Industriali Srl (di seguito, per brevità, S.T.I. Srl), Titolare del trattamento dei dati personali ai sensi degli articoli 4, comma 7, e 24 del Regolamento UE 2016/679 del 27 aprile 2016 relativo alla Protezione delle persone fisiche con riguardo al trattamento dei dati personali (di seguito, "Regolamento") informa ai sensi dell'art. 13 del Regolamento che procederà al trattamento dei dati personali riferiti alla Società ed alle persone fisiche che ne hanno la rappresentanza legale per le finalità e con le modalità più oltre indicate.
	
Per trattamento di dati personali si intende qualsiasi operazione o insieme di operazioni, compiute con o senza l'ausilio di processi automatizzati e applicate a dati personali o insiemi di dati personali, anche se non registrati in una banca di dati, come la raccolta, la registrazione, l'organizzazione, la strutturazione, la conservazione, l'elaborazione, la selezione, il blocco, l'adattamento o la modifica, l'estrazione, la consultazione, l'uso, la comunicazione mediante trasmissione, la diffusione o qualsiasi altra forma di messa a disposizione, il raffronto o l'interconnessione, la limitazione, la cancellazione o la distruzione.
	
Secondo le norme del Regolamento, i trattamenti effettuati dalla S.T.I. Srl saranno improntati ai principi di correttezza, liceità e trasparenza e di tutela della riservatezza.
	
Ai sensi dell'articolo 13 del Regolamento, forniamo quindi le seguenti informazioni.

1	Titolare e Responsabili del trattamento

Gli estremi identificativi del Titolare del trattamento sono i seguenti:
S.T.I. Sviluppo Tecnologie Industriali S.r.l., nella persona del suo legale rappresentante
Via TOFARO, 42/B - 03039 Sora (FR)	
Indirizzo per l'esercizio dei diritti di cui all'art. 9 della presente Informativa: privacy@stisrl.com

L'elenco aggiornato dei Responsabili del trattamento, interni ed esterni, è reperibile presso la sede indicata.

2	Oggetto del trattamento

Il Titolare tratta i dati personali, identificativi (ad esempio, nome, cognome, ragione sociale, indirizzo, telefono, e-mail, ecc.,), in seguito, "dati personali" o anche "dati" da Lei comunicati in occasione della registrazione alla piattaforma Calver presente sul sito www.calver.it.

3	Finalità del trattamento

I Suoi dati personali sono trattati: 
a) senza il Suo consenso espresso sensi dell'art. 6 lett. b) del Regolamento, per le seguenti finalità di Servizio: 
-	per la gestione delle operazioni di registrazione alla piattaforma Calver;
-	per la creazione di un account individuale necessario all'utilizzo della piattaforma Calver e all'abilitazione della stessa;
-	per effettuare la manutenzione ed assistenza tecnica necessaria per assicurare il corretto funzionamento della piattaforma Calver e dei servizi ad essa connessi;
-	per migliorare la qualità e la struttura della piattaforma Calver;
-	per permettere a S.T.I. Srl di esercitare i propri diritti in sede giudiziaria e reprimere comportamenti illeciti;
-	per adempiere agli obblighi previsti dalla legge, da un regolamento, dalla normativa comunitaria o da Autorità.
b) Solo previo Suo specifico e distinto consenso (art. 130 del D. Lgs. 196/2003 e smi e art. 7 del Regolamento), per le seguenti finalità di Marketing: 
-	inviarLe via e-mail, posta e/o sms e/o contatti telefonici, newsletter, comunicazioni commerciali e/o materiale pubblicitario su prodotti o servizi offerti dal Titolare e rilevazione del grado di soddisfazione sulla qualità dei servizi.
Le segnaliamo che se siete già nostri clienti, potremo inviarLe comunicazioni commerciali relative a servizi del Titolare analoghi a quelli di cui ha già usufruito, salvo Suo dissenso (art. 130 c. 4 del D. Lgs. 196/2003 e smi).

4	Natura del conferimento dei dati e conseguenze del rifiuto di rispondere

Il trattamento dei Suoi dati personali è realizzato per mezzo delle operazioni indicate all'art. 4 comma 2) del Regolamento e precisamente: raccolta, registrazione, organizzazione, conservazione, consultazione, elaborazione, modificazione, selezione, estrazione, raffronto, utilizzo, interconnessione, blocco, comunicazione, cancellazione e distruzione dei dati. I Suoi dati personali sono sottoposti a trattamento sia cartaceo che elettronico e/o automatizzato. 
Il Titolare tratterà i dati personali per il tempo necessario per adempiere alle finalità di cui sopra e comunque per non oltre 10 anni dalla cessazione del rapporto per le Finalità di Servizio e per non oltre 2 anni dalla raccolta dei dati per le Finalità di Marketing.
Il trattamento sarà improntato ai principi di correttezza, liceità e trasparenza e potrà essere effettuato anche attraverso modalità automatizzate atte a memorizzarli, gestirli e trasmetterli ed avverrà mediante strumenti idonei, per quanto di ragione e allo stato della tecnica, a garantire la sicurezza e la riservatezza tramite l'utilizzo di idonee procedure che evitino il rischio di perdita, accesso non autorizzato, uso illecito e diffusione. Il trattamento dei Dati verrà svolto in via manuale (es: raccolta moduli cartacei) e in via elettronica o comunque con l'ausilio di strumenti informatizzati o automatizzati.
	
5   Modalità di trattamento

Il trattamento dei Suoi dati personali è realizzato per mezzo delle operazioni indicate all'art. 4 comma 2) del Regolamento e precisamente: raccolta, registrazione, organizzazione, conservazione, consultazione, elaborazione, modificazione, selezione, estrazione, raffronto, utilizzo, interconnessione, blocco, comunicazione, cancellazione e distruzione dei dati. I Suoi dati personali sono sottoposti a trattamento sia cartaceo che elettronico e/o automatizzato.

Il Titolare tratterà i dati personali per il tempo necessario per adempiere alle finalità di cui sopra e comunque per non oltre 10 anni dalla cessazione del rapporto per le Finalità di Servizio e per non oltre 2 anni dalla raccolta dei dati per le Finalità di Marketing e Commerciali.
	
Il trattamento sarà improntato ai principi di correttezza, liceità e trasparenza e potrà essere effettuato anche attraverso modalità automatizzate atte a memorizzarli, gestirli e trasmetterli ed avverrà mediante strumenti idonei, per quanto di ragione e allo stato della tecnica, a garantire la sicurezza e la riservatezza tramite l'utilizzo di idonee procedure che evitino il rischio di perdita, accesso non autorizzato, uso illecito e diffusione. Il trattamento dei Dati verrà svolto in via manuale (es: raccolta moduli cartacei) e in via elettronica o comunque con l'ausilio di strumenti informatizzati o automatizzati.

6	Accesso ai dati

I Suoi dati potranno essere resi accessibili per le finalità di cui all'art. 3a) e 3b):

-	a dipendenti e collaboratori del Titolare nella loro qualità di incaricati e/o responsabili interni ed esterni del trattamento e/o amministratori di sistema.

7	Comunicazione dei dati

Senza la necessità di un espresso consenso (art. 6 lett. b) e c) del Regolamento), il Titolare potrà comunicare i Suoi dati per le finalità di cui all'art. 3a) ai soggetti ai quali la comunicazione sia obbligatoria per legge per l'espletamento delle finalità dette.

Detti soggetti tratteranno i dati nella loro qualità di autonomi titolari del trattamento.
I Suoi dati potranno essere comunicati, in caso di manifestato consenso, anche a responsabili interni ed esterni del trattamento di dati per iniziative pubblicitarie e commerciali.

8	Trasferimento dati

I dati personali sono conservati su server ubicati all'interno dell'Unione Europea, di S.T.I. Srl e/o di società terze incaricate e debitamente nominate quali responsabili del trattamento. Resta in ogni caso inteso che il Titolare, ove si rendesse necessario, avrà facoltà di spostare i server anche extra-UE. In tal caso, il Titolare assicura sin d'ora che il trasferimento dei dati extra-UE avverrà in conformità alle disposizioni di legge applicabili, previa stipula delle clausole contrattuali standard previste dalla Commissione Europea.

9    Esercizio dei diritti da parte dell'interessato

Ai sensi degli articoli 13, comma 2, lettere (b) e (d), 15, 18, 19 e 21 del Regolamento, si informa l'interessato che:

a)	egli ha il diritto di chiedere al Titolare del trattamento l'accesso ai dati personali, la rettifica o la cancellazione degli stessi o la limitazione del trattamento che lo riguardano o di opporsi al loro trattamento, oltre al diritto alla portabilità dei dati;
b)	egli ha il diritto di proporre un reclamo al Garante per la protezione dei dati personali, seguendo le procedure e le indicazioni pubblicate sul sito web ufficiale dell'Autorità su www.garanteprivacy.it;
c)	le eventuali rettifiche o cancellazioni o limitazioni del trattamento effettuate su richiesta dell'interessato - salvo che ciò si riveli impossibile o implichi uno sforzo sproporzionato - saranno comunicate dal Titolare del trattamento a ciascuno dei destinatari cui sono stati trasmessi i dati personali.
Il Titolare del trattamento potrà comunicare all'interessato tali destinatari qualora l'interessato lo richieda. L'esercizio dei diritti non è soggetto ad alcun vincolo di forma ed è gratuito.

10   Data di ultima modifica

La presente informativa è stata aggiornata il 04/02/2020.

</textarea>
                
       </div>
   </div>
         </div> 
         

</div>
  </div>

		
</jsp:attribute>

<jsp:attribute name="extra_js_footer"> 
<script>

$('#text').css("text-align","justify");

</script>

	  
</jsp:attribute>

</t:layout>



