<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Misura
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body graficoIncertezza" >

        <ul class="list-group list-group-unbordered" id="ul_dati_misura">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${misura.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Misura</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataMisura}" /></a>
                </li>
                <li class="list-group-item">
                <div class="row">
                <div class="col-md-2">
                  <b>Strumento</b>
                  </div>
                  <div class="col-md-10">
                   <a href="#" onClick="dettaglioStrumentoFromMisura('${utl:encryptData(misura.strumento.__id)}')" class="pull-right customTooltip" title="Click per aprire il dettaglio dello stumento" ><c:out value="${misura.strumento.denominazione} (${misura.strumento.matricola} | ${misura.strumento.codice_interno})"/></a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <b>Temperatura</b> <a class="pull-right">
                  <fmt:formatNumber value="${misura.temperatura}" minFractionDigits="3"/>
                  
                  </a>
                </li>
                <li class="list-group-item">
                  <b>Umidità</b> <a class="pull-right">
                   <fmt:formatNumber value="${misura.umidita}" minFractionDigits="3"/></a>
                </li>
                 <li class="list-group-item">
                  <b>Tipo Firma</b> <a class="pull-right">
                   <fmt:formatNumber value="${misura.tipoFirma}" minFractionDigits="0"/></a>
                </li>
                 <c:if test = '${misura.obsoleto == "S"}'>
                <li class="list-group-item">
                  <b>Misura Obsoleta</b> 
                  
					 <a class="pull-right label label-danger">Obsoleta</a>
  				 </li>
  				</c:if>
  				<li class="list-group-item">
                  <b>Stato Ricezione</b> 
                  
					 <a class="pull-right">${misura.statoRicezione.nome}</a>
  				 </li>
  				

					<c:if test="${!user.checkRuolo('CL')}">
						<li class="list-group-item">
		                  <b>Intervento</b> 
		                  
							 <a href="#" class="customTooltip pull-right" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(misura.intervento.id)}');">${misura.intervento.id}</a>
		  				 </li>
		  				 
		  				 <li class="list-group-item">
		                  <b>Download Pack</b> 
		                  <a href="#" class="pull-right customTooltip" title="Click per scaricare il pacchetto" onClick="scaricaPacchettoUploaded('${misura.interventoDati.nomePack}')">${misura.interventoDati.nomePack}</a>
		  				 </li>
					<c:if test="${misura.file_allegato!= null && misura.file_allegato!= '' }">
					<li class="list-group-item">
		                  <b>Allegato</b> 
		                  <a target ="_blank" class="pull-right customTooltip" title="Click per scaricare l'allegato" href='scaricaCertificato.do?action=download_allegato&id_misura=${utl:encryptData(misura.id)}'>${misura.file_allegato }</a>
		  				 </li>
		  				 <li class="list-group-item">
		                  <b>Note Allegato</b> 
		                  <a> ${misura.note_allegato}</a>
		  				 </li>
					
					</c:if>
					</c:if>
					<c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || userObj.checkRuolo("CI")}'>
					<c:if test="${misura.indice_prestazione !=null }">
						<li class="list-group-item">
		                  <b>Indice di Prestazione</b> 
		            	 <c:if test="${misura.indice_prestazione=='V' }">
								<div class="lamp lampGreen pull-right" style="margin:auto"></div>
								<a class="pull-right" style="margin-right:3px">PERFORMANTE</a>
								</c:if>
								
								<c:if test="${misura.indice_prestazione=='G' }">
								 <div class="lamp lampYellow pull-right"  style="margin:auto"></div>
								 <a class="pull-right"  style="margin-right:3px">STABILE</a> 
								</c:if>
								
								<c:if test="${misura.indice_prestazione=='R' }">
								 <div class="lamp lampRed pull-right" style="margin:auto"></div>
								 <a class="pull-right"  style="margin-right:3px">ALLERTA</a> 
								</c:if>
								
								<c:if test="${misura.indice_prestazione=='X' }">
								<div class="lamp lampNI pull-right" style="margin:auto"></div>
								<a class="pull-right"  style="margin-right:3px">NON IDONEO</a> 
								</c:if>
		  				 </li>
		  				 </c:if>
  				 </c:if>
  				 
  				 <c:if test="${cert.stato.id == 2 }">
                 <li class="list-group-item" >
               
                  <b>Download Certificato</b> <a target="_blank"  class="btn btn-danger customTooltip pull-right btn-xs" title="Click per scaricare il Cerificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(cert.nomeCertificato)}&pack=${utl:encryptData(misura.intervento.nomePack)}" >Certificato <i class="fa fa-file-pdf-o"></i></a>
               
                </li>
            
               </c:if>
        </ul>

</div>
</div>
</div>
</div>
         
         
         
     
            <br>
              <div class="row">
        <div class="col-xs-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Risultati della verifica di taratura - Calibration Results

</div>
<div id="tabPM_container">

  <c:forEach items="${blocchiPerTabella}" var="entry" varStatus="es">

    <table class="table table-bordered tabPM" style="width:99%; border-collapse:collapse; margin-top:5px; margin-left:5px; margin-right:5px;margin-bottom:5px;">
      <thead class="pm-header">
        <tr>
          <th>Massa</th>
          <th>UM</th>
          <th>Differenze rilevate dalla bilancia*</th>
          <th>Scostamento (Sc)</th>
        </tr>
      </thead>

      <tbody>
        <c:forEach items="${entry.value}" var="blocco">

          <c:forEach items="${blocco.rows}" var="riga" varStatus="st">

            <c:set var="rowClass" value="blocco-row" />
            <c:if test="${st.first}">
              <c:set var="rowClass" value="${rowClass} blocco-top" />
            </c:if>
            <c:if test="${st.last}">
              <c:set var="rowClass" value="${rowClass} blocco-bottom" />
            </c:if>

            <tr class="${rowClass}">
              <td class="blocco-cell"><c:out value="${riga.mabba}" /></td>
              <td class="blocco-cell text-center"><c:out value="${riga.um}" /></td>
              <td class="blocco-cell text-center"><c:out value="${riga.diff}" /></td>

              <c:if test="${st.first}">
                <td rowspan="${fn:length(blocco.rows)}"
                    class="blocco-cell text-center blocco-right">
                  <c:choose>
                    <c:when test="${empty blocco.scostamento}">-</c:when>
                    <c:otherwise><c:out value="${blocco.scostamento}" /></c:otherwise>
                  </c:choose>
                </td>
              </c:if>
            </tr>

          </c:forEach>

         

          <c:set var="lastBlocco" value="${blocco}" />
        </c:forEach>
      </tbody>
    </table>

<li class="list-group-item">
  <div class="row">
    <div class="col-xs-4">
      <b>Valore convenzionale misurato (mc):</b>
    </div>
    <div class="col-xs-3 text-left val-compact">
      <c:out value="${lastBlocco.valoreConvenzionale}" />
    </div>
  </div>
</li>

<li class="list-group-item">
  <div class="row">
    <div class="col-xs-4">
      <b>Incertezza associata allo strumento:</b>
    </div>
    <div class="col-xs-3 text-left val-compact">
      <c:out value="${lastBlocco.incertezza}" />
    </div>
  </div>
</li>

  </c:forEach>

</div>
    
 </div>
</div>



 
  </div>
  </div>

  

</section>
   
  </div>
  <!-- /.content-wrapper -->

<div id="myModalDettaglioStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
             <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
		 
		 <li class=""><a href="#notestrumento" data-toggle="tab" aria-expanded="false" onclick="" id="noteStrumentoTab">Note Strumento</a></li>
             </ul>
            </ul>
            <div class="tab-content">
               <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              			<div class="tab-pane" id="notestrumento">
              			   		

              			</div> 
              </div>  
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>

<!--   <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div> -->

<div id="myModalDettaglioPunto" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Punto Misura</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
            <LI>
             <ul class="nav nav-tabs">
              <li class="active"><a href="#dettagliopunto" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioPuntoTab">Dettaglio Punto</a></li>
         
 		<c:if test="${userObj.checkPermesso('MODIFICA_PUNTO_METROLOGIA')}">
               <li class=""><a href="#modificapunto" data-toggle="tab" aria-expanded="false" onclick="" id="modificaPuntoTab">Modifica Punto</a></li>
		</c:if>		
              </ul>
              </LI>
            </ul>
            <div class="tab-content">
               <div class="tab-pane active" id="dettagliopunto">

			<div class="row">
			<ul class="list-group list-group-unbordered">
				<div class="col-sm-6 list-group-unbordered">
					
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>ID</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoID"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7">  <b>ID Tabella</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoIdTabella"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                <div class="row"><div class="col-sm-7">   <b>Ordine</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoOrdine"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		               <div class="row"><div class="col-sm-7">    <b>Tipo Prova</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoTipoProva"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		               <div class="row"><div class="col-sm-7">    <b>Unita di Misura</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoUM"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7">  <b>Valore Campione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoValoreCampione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                <div class="row"><div class="col-sm-7">   <b>Valore Medio Campione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoValoreMedioCampione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7">  <b>Valore Strumento</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoValoreStrumento"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                <div class="row"><div class="col-sm-7">   <b>Valore Medio Strumento</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoValoreMedioStrumento"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                <div class="row"><div class="col-sm-7">   <b>Scostamento</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoScostamento"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                <div class="row"><div class="col-sm-7">   <b>Accettabilità</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoAccettabilita"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		              <div class="row"><div class="col-sm-7">     <b>Incertezza</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoIncertezza"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		               <div class="row"><div class="col-sm-7">    <b>Esito</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoEsito"></a></div></div>
		                </li>

     					<li class="list-group-item">
		               <div class="row"><div class="col-sm-7">    <b>Dgt</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoDigit"></a></div></div>
		                </li>
		        	
				</div>
				<div class="col-sm-6 list-group-unbordered">


		                <li class="list-group-item">
		                  <div class="row"><div class="col-sm-7"><b>Descrizione Campione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoDescrizioneCampione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Descrizione Parametro</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoDescrizioneParametro"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Misura</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoMisura"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Unità di misura calcolata</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoUMCalcolata"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Risoluzione Misura</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoRisoluzioneMisura"></a></div></div>
		                </li>
		                
		                 <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Risoluzione Campione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoRisoluzioneCampione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Fondo Scala</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoFondoScala"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Interpolazione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoInterpolazione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>FM</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoFM"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Sel Conversione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoSelConversione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Sel Tolleranza</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoSelTolleranza"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Lettura Campione</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoLetturaCampione"></a></div></div>
		                </li>
		                
		                <li class="list-group-item">
		                 <div class="row"><div class="col-sm-7"> <b>Percentuale Util</b></div> <div class="col-sm-3"> <a class="pull-left" id="dettaglioPuntoPercUtil"></a></div></div>
		                </li>
		                
		            
		           
		           
		    
		        	
				</div>
				</ul>
			
			</div>
			
    			</div> 

              <!-- /.tab-pane -->
     


               		<c:if test="${userObj.checkPermesso('MODIFICA_PUNTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modificapunto">
     <form class="form-horizontal" id="formModificaPunto">
              	<div class="row">
			<ul class="list-group list-group-unbordered">
				<div class="col-sm-6 list-group-unbordered">
					
		                <input type="hidden" class="pull-right" id="dettaglioPuntoIDmod" />
		                 <input type="hidden" class="pull-right" id="dettaglioPuntoIdTabellamod"/>
		             

		                <li class="list-group-item">
		                  <b>Unita di Misura</b> <input class="pull-right" id="dettaglioPuntoUMmod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Campione</b> <input class="onlynumber pull-right" id="dettaglioPuntoValoreCampionemod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Medio Campione</b> <input class="onlynumber pull-right" id="dettaglioPuntoValoreMedioCampionemod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Strumento</b> <input class="onlynumber pull-right" id="dettaglioPuntoValoreStrumentomod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Medio Strumento</b> <input class="onlynumber pull-right" id="dettaglioPuntoValoreMedioStrumentomod"/>
		                </li>
		              
		                <li class="list-group-item">
		                  <b>Scostamento</b> <input class="onlynumber pull-right" id="dettaglioPuntoScostamentomod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Accettabilità</b> <input class="onlynumber pull-right" id="dettaglioPuntoAccettabilitamod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Incertezza</b> <input class="onlynumber pull-right" id="dettaglioPuntoIncertezzamod"/>
		                </li>
		                  
		                <li class="list-group-item">
		                  <b>Esito</b>  
		                      <select class="pull-right" id="dettaglioPuntoEsitomod" name="dettaglioPuntoEsitomod" required>
                      
                       			<option val="IDONEO">IDONEO</option>
                         		 <option val="NON IDONEO">NON IDONEO</option>                 
                                            
                      </select>
		                </li>

		        	</div>
		                <div class="col-sm-6 list-group-unbordered">
	 
		                <li class="list-group-item">
		                  <b>Misura</b> <input class="onlynumber pull-right" id="dettaglioPuntoMisuramod"/>
		                </li>
		                
		            
		                <li class="list-group-item">
		                  <b>Risoluzione Misura</b> <input class="onlynumber pull-right" id="dettaglioPuntoRisoluzioneMisuramod"/>
		                </li>
		                
		                 <li class="list-group-item">
		                  <b>Risoluzione Campione</b> <input class="onlynumber pull-right" id="dettaglioPuntoRisoluzioneCampionemod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Fondo Scala</b> <input class="onlynumber pull-right" id="dettaglioPuntoFondoScalamod"/>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Interpolazione</b> <input class="onlynumber pull-right" id="dettaglioPuntoInterpolazionemod"/>
		                </li>
		                
		             <li class="list-group-item">
		                  <b>Percentuale Util</b> <input class="onlynumber pull-right" id="dettaglioPuntoPercUtilmod" />
		                </li>
		                
		          
		        
		            
		           
		           
		    
		        	
				</div>
				</ul>
			</div>
          <button type="submit" class="btn btn-primary" >Salva</button>
        
     
        </form>
              			</div> 
              		</c:if>		
              		
              	
              </div>  
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
			
  		 </div>
      <div class="modal-footer">
       
        	<button type="button" class="btn btn-primary" data-dismiss="modal" >Chiudi</button>

      </div>
    </div>
  </div>
</div>


	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<style>
.lamp {
    height: 20px;
    width: 20px;
    border-style: solid;
    border-width: 2px;
    border-radius: 15px;
}
.lampRed {
    background-color: #FF8C00;
}
.lampGreen {
    background-color: green;
}
.lampYellow {
    background-color: yellow;
}

.lampNI {
    background-color: #8B0000;
}



/* header grigio */
.pm-header th{
  background:#f2f2f2 !important;
  border:1px solid #cfcfcf !important;
  text-align:center;
  vertical-align:middle;
}

/* griglia base più leggera */
.tabPM td, .tabPM th{
  border:1px solid #d0d0d0 !important;
  vertical-align: middle;
}

/* CORNICE BLOCCO: sx/dx su tutte le righe del blocco */
.tabPM tr.blocco-row td.blocco-cell{
  border-left: 2px solid #8f8f8f !important;
  border-right: 2px solid #8f8f8f !important;
}

/* CORNICE BLOCCO: top sulla prima riga */
.tabPM tr.blocco-top td{
  border-top: 2px solid #8f8f8f !important;
}

/* CORNICE BLOCCO: bottom sull ultima riga */
.tabPM tr.blocco-bottom td{
  border-bottom: 2px solid #8f8f8f !important;
}

/* la cella rowspan dello scostamento deve chiudere anche il bottom */
.tabPM td.blocco-right{
  border-right: 2px solid #8f8f8f !important;
  border-bottom: 2px solid #8f8f8f !important; /* chiude la cornice in basso */
  vertical-align:middle;
}
.val-right{
  display: inline-block;
  text-align: left; /* resta vicino, non attaccato al bordo */
  font-weight: 600;
}
.val-compact{
  padding-left: 0;     /* avvicina ancora di più */
  font-weight: 600;
}

.tabPM thead.pm-header {
  border: 2px solid #999;
}

/* evita il doppio bordo con i th */
.tabPM thead.pm-header th {
  border: 1px solid #cfcfcf;
}

</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
 <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!--   <script type="text/javascript" src="js/customCharts.js"></script> -->
<!--   <script src="path/to/chartjs/dist/chart.min.js"></script> -->
<script src="https://hammerjs.github.io/dist/hammer.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-zoom/1.0.1/chartjs-plugin-zoom.min.js"></script>
<!-- <script src="path/to/chartjs-plugin-zoom/dist/chartjs-plugin-zoom.min.js"></script> -->

  
 <script type="text/javascript">
 
/*  function downloadFileBlob(id_puntoMisura){
	 
	 callAction("dettaglioMisura.do?action=download&id_punto="+id_puntoMisura);
 } */
 
 
 function attivatab(){
	 
 }

   
    $(document).ready(function() {
    	
    	

		//$('#tab_grafico_1').addClass('active');
		
		
		 //$('.nav-tabs a[href="#rilievi"]').tab('show');
		 $('a[data-toggle="tab2"]').tab('show');


		  var arrayListaPuntiJson = [];
		    <c:choose>
		      <c:when test="${not empty listaPuntJson}">
		        arrayListaPuntiJson = <c:out value="${listaPuntJson}" escapeXml="false"/>;
		      </c:when>
		      <c:otherwise>
		        arrayListaPuntiJson = [];
		      </c:otherwise>
		    </c:choose>
    		
    		
    		   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


    		       	var  contentID = e.target.id;

    		     	if(contentID == "dettaglioTab"){
    		       		exploreModal("dettaglioStrumento.do","id_str=${utl:encryptData(misura.strumento.__id)}","#dettaglio");
    		       	}
    		       	if(contentID == "misureTab"){
    		       		exploreModal("strumentiMisurati.do?action=ls&id=${utl:encryptData(misura.strumento.__id)}","","#misure")
    		       	}
    		       	if(contentID == "modificaTab"){
    		       		exploreModal("modificaStrumento.do?action=modifica&id=${utl:encryptData(misura.strumento.__id)}","","#modifica")
    		       	}
    		       	if(contentID == "documentiesterniTab"){
    		       		exploreModal("documentiEsterni.do?id_str=${utl:encryptData(misura.strumento.__id)}","","#documentiesterni")
    		       	//	exploreModal("dettaglioStrumento.do","id_str="+${misura.strumento.__id},"#documentiesterni");
    		       	}
    		       	
    		       	if(contentID == "noteStrumentoTab"){
    		    		
    		       		exploreModal("listaStrumentiSedeNew.do?action=note_strumento&id_str=${utl:encryptData(misura.strumento.__id)}","","#notestrumento")
    		       	 }
    		       	
    		    		
    		 		});
    			   
    			   $('#myModalDettaglioStrumento').on('hidden.bs.modal', function (e) {

    		    	 	$('#dettaglioTab').tab('show');
    		    	 	$('body').removeClass('noScroll');
    		    	 	$(document.body).css('padding-right', '0px');
    		    	});
    			   
    			  inputOld = "";
    			   $('.onlynumber').on('focusin', function(){
    				   
    				   inputOld = $(this).val();
    				});
    			   
    			   $(".onlynumber").keyup(function (e) {
    			       
					if(this.value == "-"){
						return true;
					}
					
					if(this.value == ""){
						return true;
					}
					
    				   if(!$.isNumeric(this.value)){
    					   $(this).val(inputOld);
    				
    				   		return false;
    			   		}else{
    			   			inputOld = $(this).val();
    			   			return true;
    			   		}
    			    });
    			   
				$('.onlynumber').on('focusout', function(){
    				   
					if(this.value == "-"){
						$(this).val("");
					}
    				});
				
				$('#formModificaPunto').on('submit',function(e){
				    e.preventDefault();
					modificaPunto();

				});
				
				
				
				

		    	/* GRAFICO DERIVA*/
		    	

			var tipoRapporto = "${misura.strumento.tipoRapporto.noneRapporto}";
			
		    	if(tipoRapporto=='RDP'){
		    		$('#grafico').hide();
		    		$('#grafico_deriva').hide();
		    	}
		    	
		    	
		    if(tipoRapporto!='RDP')	{
		   for (var i = 0;i<arrayListaPuntiJson.length;i++){
			   
			   
			   var  myChart2 = null;	
		    	numberBack2 = Math.ceil(Object.keys(arrayListaPuntiJson).length/6);
		    	if(numberBack2>0){
		    		var grafico2 = {};
		    		
		    		grafico2.labels = [];
		    		 
		    		dataset1 = {};
		    		dataset1.data = [];
		    		dataset1.label = "Accettabilità +";
		    		dataset2 = {};
		    		dataset2.data = [];
		    		dataset2.label =  "Accettabilità -";
		    		dataset3 = {};
		    		dataset3.data = [];
		    		dataset3.label ="Punto + U";
		    		dataset4 = {};
		    		dataset4.data = [];
		    		dataset4.label = "Punto";
		    		dataset5 = {};
		    		dataset5.data = [];
		    		dataset5.label =  "Punto - U" ;
		    		
		   
		    		
		    			dataset1.backgroundColor = [];
		    			dataset1.borderColor = [];
		    			dataset2.backgroundColor = [];
		    			dataset2.borderColor = [];
		    			dataset3.backgroundColor = [];
		    			dataset3.borderColor = [];
		    			dataset4.backgroundColor = [];
		    			dataset4.borderColor = [];
		    			dataset5.backgroundColor = [];
		    			dataset5.borderColor = [];

		    		     
		    		      newArr = [		    		         
		    		         'rgba(54, 162, 235, 0.8)',
		    		         'rgba(255, 99, 132, 0.8)',
		    		         'rgba(255, 206, 86, 0.8)',
		    		         'rgba(75, 192, 192, 0.8)',
		    		         'rgba(153, 102, 255, 0.8)',
		    		         'rgba(255, 159, 64, 0.8)'
		    		     ];
		    			
		    			newArrB = [		    		         
		    		         'rgba(54, 162, 235, 1)',
		    		         'rgba(255,99,132,1)',
		    		         'rgba(255, 206, 86, 1)',
		    		         'rgba(75, 192, 192, 1)',
		    		         'rgba(153, 102, 255, 1)',
		    		         'rgba(255, 159, 64, 1)'
		    		     ]; 
		    			
		    			colorBg=[];
		    			colorLine=[];
		    	
		    			colorBg2=[];
		    			colorLine2=[];
		    			
		    			colorBg3=[];
		    			colorLine3=[];
		    			
		    			colorBg4=[];
		    			colorLine4=[];
		    			
		    			colorBg5=[];
		    			colorLine5=[];
		    			
		    			
		    			dataset1.borderWidth = 2;
		    			dataset2.borderWidth = 2;
		    			dataset3.borderWidth = 2;
		    			dataset4.borderWidth = 2;
		    			dataset5.borderWidth = 2;

		    		
		    		var itemHeight1 = 200;
		    		var total1 = 0;
		    		
/* 		    		$.each(arrayListaPuntiJson, function(i,val){
		    		
		    			idRip=0;
		    			var tab_index = 1; */
		    			var val = arrayListaPuntiJson[i];
			    		$.each(val, function(j,punto){
			    						    			
			    			
					    	tipoProva = punto.tipoProva.substring(0, 1);
			    			
			    			if(tipoProva == "L"){
			    				var val = punto.risoluzione_misura.toString().split(".");
			    				var scale = 0;
			    				if(val.length>1){
			    					scale = val[1].length;
			    				}
			    				
			    				grafico2.labels.push(punto.tipoVerifica);
			    				if(scale==0){
			    					dataset1.data.push(punto.valoreStrumento + Math.round(punto.accettabilita));
			    					dataset2.data.push(punto.valoreStrumento - Math.round(punto.accettabilita));
			    					dataset3.data.push(punto.valoreStrumento + Math.round(punto.incertezza));
			    					dataset5.data.push(punto.valoreStrumento -  Math.round(punto.incertezza));
			    				}else{
			    					dataset1.data.push((punto.valoreStrumento + parseFloat(punto.accettabilita.toFixed(scale))).toFixed(scale));
			    					dataset2.data.push((punto.valoreStrumento - parseFloat(punto.accettabilita.toFixed(scale))).toFixed(scale));
			    					dataset3.data.push((punto.valoreStrumento + parseFloat(punto.incertezza.toFixed(scale))).toFixed(scale));
			    					dataset5.data.push((punto.valoreStrumento - parseFloat(punto.incertezza.toFixed(scale))).toFixed(scale));
			    					/* dataset3.data.push((punto.valoreStrumento + punto.incertezza));
			    					dataset5.data.push(punto.valoreStrumento - punto.incertezza); */
			    				}
				    			
				    			
				    			dataset4.data.push(punto.valoreStrumento );
				    			
				    			
			    			}else if(tipoProva == "R"){
			    				
			    				var val = punto.risoluzione_misura.toString().split(".");
			    				var scale = 0;
			    				if(val.length>1){
			    					scale = val[1].length;
			    				}
			    				
			    				grafico2.labels.push(punto.tipoVerifica);
			    				if(scale==0){
			    					dataset1.data.push(punto.valoreMedioStrumento + Math.round(punto.accettabilita));	
			    					dataset2.data.push(punto.valoreMedioStrumento - Math.round(punto.accettabilita));
			    					dataset3.data.push(punto.valoreMedioStrumento + Math.round(punto.incertezza));
			    					dataset5.data.push(punto.valoreMedioStrumento -  Math.round(punto.incertezza));
			    				}else{
			    					dataset1.data.push((punto.valoreMedioStrumento + parseFloat(punto.accettabilita.toFixed(scale))).toFixed(scale));
			    					dataset2.data.push((punto.valoreMedioStrumento - parseFloat(punto.accettabilita.toFixed(scale))).toFixed(scale));
			    					dataset3.data.push((punto.valoreMedioStrumento + parseFloat(punto.incertezza.toFixed(scale))).toFixed(scale));
			    					dataset5.data.push((punto.valoreMedioStrumento - parseFloat(punto.incertezza.toFixed(scale))).toFixed(scale));
			    				}
				    			
				    			
				    			//dataset3.data.push(punto.valoreMedioStrumento + punto.incertezza);
				    			dataset4.data.push(punto.valoreMedioStrumento );
				    			//dataset5.data.push(punto.valoreMedioStrumento - punto.incertezza);

			    			}
			    			
			    			itemHeight1 += 12;
			    			total1 += val;
			    			colorBg.push(newArr[0]);
					    	colorLine.push(newArrB[0]);
					    	
					    	colorBg2.push(newArr[1]);
					    	colorLine2.push(newArrB[1]);
					    	
					    	colorBg3.push(newArr[2]);
					    	colorLine3.push(newArrB[2]);
					    	
					    	colorBg4.push(newArr[3]);
					    	colorLine4.push(newArrB[3]);
					    	
					    	colorBg5.push(newArr[4]);
					    	colorLine5.push(newArrB[4]);
					  
			    			
		    			});
		    		//});
		    		
		    		dataset1.backgroundColor = dataset1.backgroundColor.concat(colorBg2);
	    			dataset1.borderColor = dataset1.borderColor.concat(colorLine2);
	    			dataset2.backgroundColor = dataset2.backgroundColor.concat(colorBg2);
	    			dataset2.borderColor = dataset2.borderColor.concat(colorLine2);
	    			dataset3.backgroundColor = dataset3.backgroundColor.concat(colorBg);
	    			dataset3.borderColor = dataset3.borderColor.concat(colorLine);
	    			dataset4.backgroundColor = dataset4.backgroundColor.concat(colorBg3);
	    			dataset4.borderColor = dataset4.borderColor.concat(colorLine3);
	    			dataset5.backgroundColor = dataset5.backgroundColor.concat(colorBg);
	    			dataset5.borderColor = dataset5.borderColor.concat(colorLine);
	    			dataset1.fill = false,
	    			dataset2.fill = false,
	    			dataset3.fill = false,	    			
	    			dataset4.fill = false,
	    			dataset5.fill = false,
	    			dataset1.tension = 0.2,
	    			dataset2.tension = 0.2,
	    			dataset3.tension = 0.2,	    			
	    			dataset4.tension = 0.2,
	    			dataset5.tension = 0.2,
	    			
		    		//$(".graficoDeriva").height("290");
		    		
/* 		    		if(tipoRapporto=="SVT"){
		    			dataset2.backgroundColor = dataset.backgroundColor.concat(colorBg2);
		    			dataset2.borderColor = dataset.borderColor.concat(colorLine2);
		    			grafico1.datasets = [dataset1,dataset2];
		    		}else{ */
		    			grafico2.datasets = [dataset1, dataset2, dataset3, dataset4, dataset5];
	//	    		}
		    		 var ctx2 = document.getElementById("graficoDeriva"+i).getContext("2d");
		    		
		    		
		    		 var config2 = {
		        		     data: grafico2,		        		    
		        		     options: {
		        		    	 responsive: true, 
		        		    	 maintainAspectRatio: true,
		        		    	 scales: {
		        		    	        yAxes: [{
		        		    	            ticks: {
		        		    	                beginAtZero: false
		        		    	            }
		        		    	        }],
		        		    	        xAxes: [{
		        		    	            ticks: {
		        		    	                autoSkip: true
		        		    	            }
		        		    	        }]
		        		    	    },
		    		 plugins: {
		    		      zoom: {
		    		        zoom: {
		    		          wheel: {
		    		            enabled: true,
		    		          },
		    		          pinch: {
		    		            enabled: true
		    		          },
		    		          mode: 'y',
		    		        },
		    		        pan: {
		    		        	enabled: true,
		    		        	mode : 'xy'
		    		        	
		    		        }
		    		      },
		    		      
		    		      tooltip:{
		    		    	  
		    		    	   callbacks: {
	 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
	 			    		      // data : the chart data item containing all of the datasets
	 			    		      label: function(tooltipItem, data) {
	 			    		    	  
	 			    		    	 var label = tooltipItem.dataset.label;
	 			    		    	var index = tooltipItem.dataIndex;	 			    		    	
	 			    		    	  	 			    		    	  
	 			    		    	  if(tooltipItem.datasetIndex == 3){
	 			    		    		  
	 			    		    		  var ret = [];
	 			    		    		  var x = $(this)
	 			    		    		 var accettabilita = tooltipItem.chart.config._config.data.datasets[0].data;
		 			    		    	  var U = tooltipItem.chart.config._config.data.datasets[2].data;	 			    		    	  
		 			    		    	  
		 			    		    	 var value = tooltipItem.formattedValue;		 		
		 			    		    	var val = accettabilita[index].toString().split(".");
					    				var scale = 0;
					    				if(val.length>1){
					    					scale = val[1].length;
					    				}
					    				
	 			    		    		  
	 			    		    		var lab = "Accettabilita: " + (accettabilita[index] - tooltipItem.dataset.data[index]).toFixed(scale);
	 			    		    		var U = "U: " + (U[index] - tooltipItem.dataset.data[index]).toFixed(scale)

	 			    		    		ret.push(label + ": "+value);
	 			    		    		ret.push(lab);
	 			    		    		ret.push(U);
	 			    		    		
	 			    		    		//return label + ": "+value+" " + lab + U;
	 			    		    		return ret;
	 			    		    		
	 			    		    	  }else{
	 			    		    		  return label +": " + tooltipItem.dataset.data[index]
	 			    		    	  }
	
	 			    		      }
	 			    		    } 
		    		    	  
		    		    	  
		    		      }
		        		    	    
		        		    	    
		        		    	    
		    		    }
		        		     }
		        		 };
		 			 
		 				config2.type = "line";
/* 		 				config2.options.tooltips = {
		 			    		 callbacks: {
		 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
		 			    		      // data : the chart data item containing all of the datasets
		 			    		      label: function(tooltipItem, data) {
		 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
		 			                      var label = data.labels[tooltipItem.index];
		 			                      var percentage =  value / total1 * 100;
		 			                     
		 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

		 			    		      }
		 			    		    }
		 	  		 		 }; */
		 		
		    		  myChart2 = new Chart(ctx2, config2);
		    	 
		    	}else{
		    		if(myChart2!= null){
		    		 	myChart2.destroy();
		    		 }
		    	}

			   
			   
			   
		   } 	
		    	
    }
    		
 	
				

		    	/* GRAFICO incertezza*/
		    	

			var tipoRapporto = "${misura.strumento.tipoRapporto.noneRapporto}";
			
		    	if(tipoRapporto=='RDP'){
		    		$('#grafico').hide();
		    	}
		    	
		        if(tipoRapporto!='RDP')	{  	
		    var  myChart1 = null;	
		    	numberBack1 = Math.ceil(Object.keys(arrayListaPuntiJson).length/6);
		    	if(numberBack1>0){
		    		grafico1 = {};
		    		grafico1.labels = [];
		    		 
		    		dataset1 = {};
		    		dataset1.data = [];
		    		dataset1.label = "Andamento Incertezza";
		    		
		   
		    		
		    			dataset1.backgroundColor = [];
		    			dataset1.borderColor = [];

		    		     
		    		      newArr = [		    		         
		    		         'rgba(54, 162, 235, 0.8)',
		    		         'rgba(255, 99, 132, 0.8)',
		    		         'rgba(255, 206, 86, 0.8)',
		    		         'rgba(75, 192, 192, 0.8)',
		    		         'rgba(153, 102, 255, 0.8)',
		    		         'rgba(255, 159, 64, 0.8)'
		    		     ];
		    			
		    			newArrB = [		    		         
		    		         'rgba(54, 162, 235, 1)',
		    		         'rgba(255,99,132,1)',
		    		         'rgba(255, 206, 86, 1)',
		    		         'rgba(75, 192, 192, 1)',
		    		         'rgba(153, 102, 255, 1)',
		    		         'rgba(255, 159, 64, 1)'
		    		     ]; 
		    			
		    			colorBg=[];
		    			colorLine=[];
		    	
		    			colorBg2=[];
		    			colorLine2=[];
		    			
		    			dataset1.borderWidth = 1;
		    		
		    		
		    		
		    			dataset2 = {};
			    		dataset2.data = [];
			    		dataset2.label = "Andamento Accettabilità";
			    		dataset2.borderWidth = 1;
			    		dataset2.backgroundColor = [];
		    			dataset2.borderColor = [];
		
		    		
		    		var itemHeight1 = 200;
		    		var total1 = 0;
		    		$.each(arrayListaPuntiJson, function(i,val){
		    		
		    			idRip=0;
			    		$.each(val, function(j,punto){
			    			
			    			
			    			
					    	tipoProva = punto.tipoProva.substring(0, 1);
			    			
			    			if(tipoProva == "L"){
			    				grafico1.labels.push(punto.tipoVerifica);
				    			dataset1.data.push(punto.incertezza);
				    			if(tipoRapporto=="SVT"){
				    				dataset2.data.push(punto.accettabilita);
				    			  	colorBg2.push(newArr[1]);
							    	colorLine2.push(newArrB[1]);
				    			}
				    			itemHeight1 += 12;
				    			total1 += val;
				    			colorBg.push(newArr[0]);
						    	colorLine.push(newArrB[0]);
						  
			    			}else if(tipoProva == "R"){
			    				if(idRip!=punto.id_ripetizione){
			    					grafico1.labels.push(punto.tipoVerifica);
					    			dataset1.data.push(punto.incertezza);
					    			if(tipoRapporto=="SVT"){
					    				dataset2.data.push(punto.accettabilita);
					    				colorBg2.push(newArr[1]);
								    	colorLine2.push(newArrB[1]);
					    			}
					    			itemHeight1 += 12;
					    			total1 += val;
					    			idRip = punto.id_ripetizione;
					    			colorBg.push(newArr[0]);
							    	colorLine.push(newArrB[0]);
			    				}
			    				
			    			}
			    			
		    			});
		    		});
		    		
		    		dataset1.backgroundColor = dataset1.backgroundColor.concat(colorBg);
	    			dataset1.borderColor = dataset1.borderColor.concat(colorLine);
		    		/* $(".graficoIncertezza").height("430"); */
		    		$(".graficoIncertezza").height($('#ul_dati_misura').height());
 		    		
		    		if(tipoRapporto=="SVT"){
		    			dataset2.backgroundColor = dataset2.backgroundColor.concat(colorBg2);
		    			dataset2.borderColor = dataset2.borderColor.concat(colorLine2);
		    			grafico1.datasets = [dataset1,dataset2];
		    		}else{
		    			grafico1.datasets = [dataset1];
		    		}
		    		 var ctx1 = document.getElementById("graficoIncertezza").getContext("2d");
		    		
		    		
		    		 var config1 = {
		        		     data: grafico1,
		        		     options: {
		        		    	 responsive: true, 
		        		    	 maintainAspectRatio: false,
		        		    	 scales: {
		        		    	        yAxes: [{
		        		    	            ticks: {
		        		    	                beginAtZero:true
 		        		    	            }
		        		    	        }],
		        		    	        xAxes: [{
		        		    	            ticks: {
 		        		    	                autoSkip: false
		        		    	            }
		        		    	        }]
		        		    	    }
		        		         
		        		     }
		        		 };
		 			 
		 				config1.type = "bar";	
		 				config1.options.tooltips = {
		 			    		 callbacks: {
		 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
		 			    		      // data : the chart data item containing all of the datasets
		 			    		      label: function(tooltipItem, data) {
		 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
		 			                      var label = data.labels[tooltipItem.index];
		 			                      var percentage =  value / total1 * 100;
		 			                     
		 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

		 			    		      }
		 			    		    }
		 	  		 		 };
 		 		
		    		  myChart1 = new Chart(ctx1, config1);
		    	 
		    	}else{
		    		if(myChart1!= null){
		    		 	myChart1.destroy();
		    		 }
		    	}
		        }
    		
    });
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



