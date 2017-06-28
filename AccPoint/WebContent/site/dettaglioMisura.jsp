<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
	String cifresign = ""+Costanti.CIFRE_SIGNIFICATIVE;
	session.setAttribute("cifresign", cifresign);
	
	ArrayList<ArrayList<PuntoMisuraDTO>> arrayPunti = (ArrayList<ArrayList<PuntoMisuraDTO>>)request.getSession().getAttribute("arrayPunti");

	
	Gson gson = new Gson();
	JsonArray listaPuntJson = gson.toJsonTree(arrayPunti).getAsJsonArray();
	request.setAttribute("listaPuntJson", listaPuntJson);
%>
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

    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-xs-12">
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
                  <b>Strumento</b> <a href="#" onClick="dettaglioStrumentoFromMisura('${misura.strumento.__id}')" class="pull-right">${misura.strumento.denominazione} (${misura.strumento.codice_interno})</a>
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
  				 
                
               
        </ul>

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
  </c:if>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		  <th>Correzione</th>
  </c:if>
    <th>Incertezza</th>
    <th>Esito</th>
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
  </c:if>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		  <th>Correzione</th>
  </c:if>
    <th>Incertezza</th>
    <th>Esito</th>
  
  </c:if>


 </tr></thead>
 
 <tbody>
<c:if test = "${fn:startsWith(punti[0].tipoProva, 'L')}">
 <c:forEach items="${punti}" var="puntoMisura" varStatus="loopPunti">
 
 
 <tr role="row" id="${puntoMisura.id}">

	<td>
	
		<a href="#" onClick="openDettaglioPunto('${loopArrayPunti.index}','${loopPunti.index}')">${puntoMisura.tipoVerifica}</a>
	
	</td>
		
	<td>${puntoMisura.um}</td>
	<td><fmt:formatNumber value="${puntoMisura.valoreCampione}" minFractionDigits="${cifresign}"/></td>

	<td><fmt:formatNumber value="${puntoMisura.valoreStrumento}" minFractionDigits="${cifresign}"/></td>

	 <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		 <td><fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/></td>
  		  <td><fmt:formatNumber value="${puntoMisura.accettabilita}" minFractionDigits="${cifresign}"/></td>
  	</c:if>
	<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		 <td><fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/></td>
  </c:if>
	<td><fmt:formatNumber value="${puntoMisura.incertezza}" minFractionDigits="${cifresign}"/></td>
	<td>${puntoMisura.esito}</td>
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
		
	<td>${puntoMisura.um}</td>
	<td>
	<fmt:formatNumber value="${puntoMisura.valoreCampione}" minFractionDigits="${cifresign}"/>
	</td>
	
	
	
	<c:if test = '${rowspanenabled == 0}'>
	<td rowspan="${rowspan}" >
	<fmt:formatNumber value="${puntoMisura.valoreMedioCampione}" minFractionDigits="${cifresign}"/>
	</td>
	</c:if>
	
	<td><fmt:formatNumber value="${puntoMisura.valoreStrumento}" minFractionDigits="${cifresign}"/></td>
	
	<c:if test = '${rowspanenabled == 0}'>
		<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.valoreMedioStrumento}" minFractionDigits="${cifresign}"/></td>
	
	 	<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		 	<td rowspan="${rowspan}">
  		 	<fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/>
  		 	</td>
  		  	<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.accettabilita}" minFractionDigits="${cifresign}"/></td>
  		</c:if>
  	
		<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		 	<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/></td>
  		</c:if>
  
		<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.incertezza}" minFractionDigits="${cifresign}"/></td>
		<td rowspan="${rowspan}">${puntoMisura.esito}</td>
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
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <!-- <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li> -->
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false" onclick="" id="aggiornaTab">Gestione Campione</a></li> -->
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             <!-- 
			  <div class="tab-pane" id="misure">
                

         
			 </div> 
 -->

              <!-- /.tab-pane -->

             <!--  <div class="tab-pane" id="prenotazione">
              

              </div> -->
              <!-- /.tab-pane -->
              <!-- <div class="tab-pane" id="aggiorna">
              

              </div> -->
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



<div id="myModalDettaglioPunto" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Punto Misura</h4>
      </div>
       <div class="modal-body">

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
 <script type="text/javascript">
   
    $(document).ready(function() {

    	$('.tabPM').DataTable({
  	      paging: false, 
  	      ordering: false,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      bFilter: false,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 2 }
  	                  
  	               ]
  	    	
  	      
  	    });
    
    	arrayListaPuntiJson = ${listaPuntJson};
    });
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



