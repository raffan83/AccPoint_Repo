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
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${misura.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Misura</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataMisura}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Strumento</b> <a href="#" onClick="dettaglioStrumentoFromMisura('${misura.strumento.__id}')" class="pull-right customTooltip" title="Click per aprire il dettaglio dello stumento" >${misura.strumento.denominazione} (${misura.strumento.matricola} | ${misura.strumento.codice_interno})</a>
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
		                  
							 <a href="#" class="customTooltip pull-right" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${intervento.id}');">${misura.intervento.id}</a>
		  				 </li>
		  				 
		  				 <li class="list-group-item">
		                  <b>Download Pack</b> 
		                  <a href="#" class="pull-right customTooltip" title="Click per scaricare il pacchetto" onClick="scaricaPacchettoUploaded('${misura.interventoDati.nomePack}')">${misura.interventoDati.nomePack}</a>
		  				 </li>
					
					</c:if>

  				 
  				 
                
               
        </ul>

</div>
</div>
</div>
<div class="col-md-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Grafico Incertezze Misure
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="graficoIncertezza">
	<canvas id="graficoIncertezza"></canvas>
</div>
</div>
</div>
</div>
</div>
            
            
            
            
              <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Punti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <c:forEach items="${arrayPunti}" var="punti" varStatus="loopArrayPunti">
 
<table id="tabPM" class="table table-bordered table-inverse dataTable tabPM"  role="grid" width="100%">
 <thead><tr class="active">
  
  
  <c:if test = "${fn:startsWith(punti[0].tipoProva, 'L')}">
   <th>Tipo verifica</th>
 <th>Unità di misura</th>
 <th>Valore Campione</th>
 <th>Valore Strumento</th>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		  <th>Scostamento</th>
  		   <th>Accettabilità</th>
  		    <th>Incertezza</th>
    		<th>Esito</th>
  </c:if>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		  <th>Correzione</th>
  		   <th>Incertezza</th>
   			
  </c:if>
   
  </c:if>
    
    <c:if test = "${fn:startsWith(punti[0].tipoProva, 'R')}">
  <th>Tipo verifica</th>
 <th>Unità di misura</th>
 <th>Valore Campione</th>
 <th>Valore Medio Campione</th>
 <th>Valore Strumento</th>
  <th>Valore Medio Strumento</th>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		  <th>Scostamento</th>
  		   <th>Accettabilità</th>
  		    <th>Incertezza</th>
    		<th>Esito</th>
  </c:if>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		  <th>Correzione</th>
  		   <th>Incertezza</th>
  </c:if>
   
  
  </c:if>


 </tr></thead>
 
 <tbody>
<c:if test = "${fn:startsWith(punti[0].tipoProva, 'L')}">
 <c:forEach items="${punti}" var="puntoMisura" varStatus="loopPunti">
 
 
 <tr role="row" id="${puntoMisura.id}">

	<td>
	
		<a href="#" class="customTooltip" title="Click per aprire il dettaglio del Punto di Misura"  onClick="openDettaglioPunto('${loopArrayPunti.index}','${loopPunti.index}')">${puntoMisura.tipoVerifica}</a>
	
	</td>
		
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${puntoMisura.um}</c:if>
	</td>
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.valoreCampione}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}"/></c:if>
	</td>

	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.valoreStrumento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
	</td>

	 <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		 <td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.scostamento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)+1}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
	</td>
  		  <td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.accettabilita}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
	</td>
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${utl:getIncertezzaNormalizzata(puntoMisura.incertezza)}</c:if>
	</td>
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${puntoMisura.esito}</c:if>
	</td>
  	</c:if>
	<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		 <td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.scostamento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
	</td>
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${utl:getIncertezzaNormalizzata(puntoMisura.incertezza)}</c:if>
	</td>
  </c:if>
	
	</tr>
  
	</c:forEach>

</c:if>
	<c:if test = "${fn:startsWith(punti[0].tipoProva, 'R')}">

  <c:set var="rowspanenabled" value="0"/>
   <c:set var="rowsiteration" value="1"/>
  
  
  
  <c:forEach items="${punti}" var="puntoMisura" varStatus="loopPunti">
 


 	<c:set var="rowspan" value="${fn:substring(punti[0].tipoProva, 2, 3)}"/>
 	<c:if test = '${rowsiteration > rowspan}'>
 	  	<c:set var="rowspanenabled" value="0"/>
   		<c:set var="rowsiteration" value="1"/>
 	</c:if>

 	
 <tr role="row" id="${puntoMisura.id}">
	<td>
	
		<a href="#" onClick="openDettaglioPunto('${loopArrayPunti.index}','${loopPunti.index}')">${puntoMisura.tipoVerifica}</a>
	
	</td>
		
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${puntoMisura.um}</c:if>
	</td>
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.valoreCampione}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}"/></c:if>
	</td>
	
	
	
	<c:if test = '${rowspanenabled == 0}'>
	<td rowspan="${rowspan}" >
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.valoreMedioCampione}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}"/></c:if>
	</td>
	</c:if>
	
	<td>
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.valoreStrumento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_campione)}"/></c:if>
	</td>
	
	<c:if test = '${rowspanenabled == 0}'>
		<td rowspan="${rowspan}">
		<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
		<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.valoreMedioStrumento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
	</td>
	
	 	<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		 	<td rowspan="${rowspan}">
				<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
				<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.scostamento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)+1}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
  		 	</td>
  		  	<td rowspan="${rowspan}">
				<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
				<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.accettabilita}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
			</td>
					<td rowspan="${rowspan}">
			<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
			<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${utl:getIncertezzaNormalizzata(puntoMisura.incertezza)}</c:if>
		</td>
		<td rowspan="${rowspan}">
			<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
			<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${puntoMisura.esito}</c:if>
		</td>
  		</c:if>
  	
		<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		 	<td rowspan="${rowspan}">
				<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
				<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'><fmt:formatNumber value="${puntoMisura.scostamento}" maxFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}" minFractionDigits="${utl:getScale(puntoMisura.risoluzione_misura)}"/></c:if>
			</td>
					<td rowspan="${rowspan}">
			<c:if test='${puntoMisura.applicabile != null && puntoMisura.applicabile == "N"}'>N/A</c:if>
			<c:if test='${puntoMisura.applicabile == null || puntoMisura.applicabile == "S"}'>${utl:getIncertezzaNormalizzata(puntoMisura.incertezza)}</c:if>
		</td>
  		</c:if>
  

		
	</c:if>
	
	</tr>
   <c:set var="rowspanenabled" value="1"/>
   <c:set var="rowsiteration" value="${rowsiteration + 1}"/>
	</c:forEach>
	
	</c:if>

 </tbody>
 </table> 
 </c:forEach> 
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
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

  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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
</div>

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
             <ul class="nav nav-tabs">
              <li class="active"><a href="#dettagliopunto" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioPuntoTab">Dettaglio Punto</a></li>
         
 		<c:if test="${userObj.checkPermesso('MODIFICA_PUNTO_METROLOGIA')}">
               <li class=""><a href="#modificapunto" data-toggle="tab" aria-expanded="false" onclick="" id="modificaPuntoTab">Modifica Punto</a></li>
		</c:if>		
              </ul>
            </ul>
            <div class="tab-content">
               <div class="tab-pane active" id="dettagliopunto">

			<div class="row">
			<ul class="list-group list-group-unbordered">
				<div class="col-sm-6 list-group-unbordered">
					
		                <li class="list-group-item">
		                  <b>ID</b> <a class="pull-right" id="dettaglioPuntoID"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>ID Tabella</b> <a class="pull-right" id="dettaglioPuntoIdTabella"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Ordine</b> <a class="pull-right" id="dettaglioPuntoOrdine"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Tipo Prova</b> <a class="pull-right" id="dettaglioPuntoTipoProva"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Unita di Misura</b> <a class="pull-right" id="dettaglioPuntoUM"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Campione</b> <a class="pull-right" id="dettaglioPuntoValoreCampione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Medio Campione</b> <a class="pull-right" id="dettaglioPuntoValoreMedioCampione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Strumento</b> <a class="pull-right" id="dettaglioPuntoValoreStrumento"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Valore Medio Strumento</b> <a class="pull-right" id="dettaglioPuntoValoreMedioStrumento"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Scostamento</b> <a class="pull-right" id="dettaglioPuntoScostamento"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Accettabilità</b> <a class="pull-right" id="dettaglioPuntoAccettabilita"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Incertezza</b> <a class="pull-right" id="dettaglioPuntoIncertezza"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Esito</b> <a class="pull-right" id="dettaglioPuntoEsito"></a>
		                </li>

     					<li class="list-group-item">
		                  <b>Dgt</b> <a class="pull-right" id="dettaglioPuntoDigit"></a>
		                </li>
		        	
				</div>
				<div class="col-sm-6 list-group-unbordered">


		                <li class="list-group-item">
		                  <b>Descrizione Campione</b> <a class="pull-right" id="dettaglioPuntoDescrizioneCampione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Descrizione Parametro</b> <a class="pull-right" id="dettaglioPuntoDescrizioneParametro"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Misura</b> <a class="pull-right" id="dettaglioPuntoMisura"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Unità di misura calcolata</b> <a class="pull-right" id="dettaglioPuntoUMCalcolata"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Risoluzione Misura</b> <a class="pull-right" id="dettaglioPuntoRisoluzioneMisura"></a>
		                </li>
		                
		                 <li class="list-group-item">
		                  <b>Risoluzione Campione</b> <a class="pull-right" id="dettaglioPuntoRisoluzioneCampione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Fondo Scala</b> <a class="pull-right" id="dettaglioPuntoFondoScala"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Interpolazione</b> <a class="pull-right" id="dettaglioPuntoInterpolazione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>FM</b> <a class="pull-right" id="dettaglioPuntoFM"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Sel Conversione</b> <a class="pull-right" id="dettaglioPuntoSelConversione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Sel Tolleranza</b> <a class="pull-right" id="dettaglioPuntoSelTolleranza"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Lettura Campione</b> <a class="pull-right" id="dettaglioPuntoLetturaCampione"></a>
		                </li>
		                
		                <li class="list-group-item">
		                  <b>Percentuale Util</b> <a class="pull-right" id="dettaglioPuntoPercUtil"></a>
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
		                  <b>Percentuale Util</b> <input class="onlynumber pull-right" id="dettaglioPuntoPercUtil" />
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>

  
 <script type="text/javascript">
   
    $(document).ready(function() {

    		arrayListaPuntiJson = ${listaPuntJson};
    		
    		
    		   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


    		       	var  contentID = e.target.id;

    		     	if(contentID == "dettaglioTab"){
    		       		exploreModal("dettaglioStrumento.do","id_str="+${misura.strumento.__id},"#dettaglio");
    		       	}
    		       	if(contentID == "misureTab"){
    		       		exploreModal("strumentiMisurati.do?action=ls&id="+${misura.strumento.__id},"","#misure")
    		       	}
    		       	if(contentID == "modificaTab"){
    		       		exploreModal("modificaStrumento.do?action=modifica&id="+${misura.strumento.__id},"","#modifica")
    		       	}
    		       	if(contentID == "documentiesterniTab"){
    		       		exploreModal("documentiEsterni.do?id_str="+${misura.strumento.__id},"","#documentiesterni")
    		       	//	exploreModal("dettaglioStrumento.do","id_str="+${misura.strumento.__id},"#documentiesterni");
    		       	}
    		    		
    		       	
    		    
    		       	
    		       	

    		 		});
    			   
    			   $('#myModalDettaglioStrumento').on('hidden.bs.modal', function (e) {

    		    	 	$('#dettaglioTab').tab('show');
    		    	 	
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
				
				

		    	/* GRAFICO incertezza*/
		    	

			var tipoRapporto = "${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto}";
		    	
		    	
		    	
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
		    		         'rgba(255, 99, 132, 0.8)',
		    		         'rgba(54, 162, 235, 0.8)',
		    		         'rgba(255, 206, 86, 0.8)',
		    		         'rgba(75, 192, 192, 0.8)',
		    		         'rgba(153, 102, 255, 0.8)',
		    		         'rgba(255, 159, 64, 0.8)'
		    		     ];
		    			
		    			newArrB = [
		    		         'rgba(255,99,132,1)',
		    		         'rgba(54, 162, 235, 1)',
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
		    		$(".graficoIncertezza").height("390");
 		    		
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
				
    		
    });
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



