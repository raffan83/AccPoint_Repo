<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.math.RoundingMode"%>
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
        Dettaglio Prova
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
<!-- <a class="btn btn-danger" onClick=""></a> -->
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dettaglio Prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
         <li class="list-group-item">
                  <b>ID Prova</b> <a class="pull-right">${prova.id}</a>
                </li>
                <li class="list-group-item">
                  <b>ID Intervento</b>  <a class=" customTooltip customlink pull-right"  href="amGestioneInterventi.do?action=dettaglio&id_intervento=${utl:encryptData(prova.intervento.id)}" >${prova.intervento.id }</a>
                </li>
                 <li class="list-group-item">
                  <b>Data Prova</b> <a class="pull-right"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${prova.data }" /></a>
                </li>
                 <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${prova.intervento.idCommessa }</a>
                </li>
                <li class="list-group-item">
                  <b>Cliente</b> <a class="pull-right">${prova.intervento.nomeCliente}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right">${prova.intervento.nomeSede}</a>
                </li>
                 <li class="list-group-item">
                  <b>Cliente Utilizzatore</b> <a class="pull-right">${prova.intervento.nomeClienteUtilizzatore}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede Utilizzatore</b> <a class="pull-right">${prova.intervento.nomeSedeUtilizzatore}</a>
                </li>
                
                <li class="list-group-item">
                  <b>Rapporto</b> 
                <c:if test="${rapporto.stato.id == 1}">
                  <c:if test="${prova.matrixSpess!=null && prova.matrixSpess!=''}">

<a class="btn btn-success btn-xs customTooltip pull-right" title="Click per generare il certificato" onClick="modalYesOrNo('${utl:encryptData(prova.id)}')" style="margin-left:2px"><i class="fa fa-check"></i></a>
<a class="btn btn-info btn-xs customTooltip pull-right"  title="Click per generare l'anteprima di stampa"  onClick="generaCertificatoAM('${utl:encryptData(prova.id)}', 1)"><i class="fa fa-print"></i></a>

</c:if>
</c:if>
                  <c:if test="${rapporto.stato.id == 2}">
<a target="_blank"   class="btn btn-danger btn-xs customTooltip pull-right" title="Click per scaricare il Cerificato"  href="amGestioneInterventi.do?action=download_certificato&id_prova=${utl:encryptData(prova.id)}" > <i class="fa fa-file-pdf-o"></i></a>
 
 </c:if>
                </li>
				




        </ul>

</div>
</div>
</div>

<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Oggetto in Prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
          <li class="list-group-item">
                  <b>ID Oggetto in Prova</b> <a class="pull-right">${prova.strumento.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Matricola</b> <a class="pull-right">${prova.strumento.matricola}</a>
                </li>
                <li class="list-group-item">
                  <b>N. Fabbrica</b> <a class="pull-right">${prova.strumento.nFabbrica}</a>
                </li>
                <li class="list-group-item">
                  <b>Tipo</b> <a class="pull-right">${prova.strumento.tipo}</a>
                </li>
                <li class="list-group-item">
                  <b>Descrizione</b> <a class="pull-right">${prova.strumento.descrizione}</a>
                </li>
                <li class="list-group-item">
                  <b>Pressione</b> <a class="pull-right">${prova.strumento.pressione}</a>
                </li>
                <li class="list-group-item">
                  <b>Volume</b> <a class="pull-right">${prova.strumento.volume}</a>
                </li>
                <li class="list-group-item">
                  <b>Anno</b> <a class="pull-right">${prova.strumento.anno}</a>
                </li>
                <li class="list-group-item">
                  <b>Costruttore</b> <a class="pull-right">${prova.strumento.costruttore}</a>
                </li>
                
               
               
               
        </ul>
        
<div class="row">
<div class="col-xs-12">
<label>Zone di riferimento</label>
       		
       		 <table id="tabZone" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    <thead>
        <tr>
            <th style="text-align:center">Zona</th>
            <th style="text-align:center">Materiale</th>
            <th style="text-align:center">Spessore</th>
        </tr>
    </thead>
    <tbody>
     <c:forEach items="${prova.strumento.getListaZoneRiferimento() }" var="item">
     <tr>
     <td style="text-align:center">${item.zonaRiferimento }</td>
     <td style="text-align:center">${item.materiale }</td>
     <td style="text-align:center">${item.spessore }</td>
     </tr>
     </c:forEach>
    </tbody>
</table>

</div>

</div>


</div>
</div>
</div>


<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Strumentazione di misura utilizzata
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
         
                <li class="list-group-item">
                  <b>Matricola</b> <a class="pull-right">${prova.campione.matricola}</a>
                </li>
                <li class="list-group-item">
                  <b>Rilevatore out tipo</b> <a class="pull-right">${prova.campione.rilevatoreOut}</a>
                </li>
                <li class="list-group-item">
                  <b>Mezzo accoppiante</b> <a class="pull-right">${prova.campione.mezzoAccoppiante}</a>
                </li>
                  <li class="list-group-item">
                  <b>Blocco riferimento</b> <a class="pull-right">${prova.campione.bloccoRiferimento}</a>
                </li>
                <li class="list-group-item">
                  <b>Costruttore sonda</b> <a class="pull-right">${prova.campione.sondaCostruttore}</a>
                </li>
                <li class="list-group-item">
                  <b>Modello sonda</b> <a class="pull-right">${prova.campione.sondaModello}</a>
                </li>
                <li class="list-group-item">
                  <b>Matricola sonda</b> <a class="pull-right">${prova.campione.sondaMatricola}</a>
                </li>
                <li class="list-group-item">
                  <b>Frequenza sonda</b> <a class="pull-right">${prova.campione.sondaFrequenza}</a>
                </li>
                <li class="list-group-item">
                  <b>Dimensione sonda</b> <a class="pull-right">${prova.campione.sondaDimensione}</a>
                </li>
                <li class="list-group-item">
                  <b>Angolo sonda</b> <a class="pull-right">${prova.campione.sondaAngolo}</a>
                </li>
                <li class="list-group-item">
                  <b>Velocità sonda</b> <a class="pull-right">${prova.strumento.sondaVelocita}</a>
                </li>
                
               
        </ul>
        



</div>
</div>
</div>


<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Prova
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-xs-12">
<a class ="btn btn-primary pull-right" id="btn_rigenera" onclick="rigeneraTabella('${prova.id}')" style="display:none">Rigenera tabella</a>
</div>
</div>
<div class="row">
<c:if test="${fn:length(colonne)<=10}">
 <div class="col-xs-6">
</c:if>
<c:if test="${fn:length(colonne)>10}">
 <div class="col-xs-4">
 
 </div>
 <div class="col-xs-4">

 </c:if>
 <c:choose>
 <c:when test="${prova.strumento.filename_img !=null && prova.strumento.filename_img != '' }">
		<img src="amGestioneInterventi.do?action=immagine" alt="Immagine della prova" class="img-fluid d-block mx-auto" style="height: 300px; width: auto;" />
		</c:when>
		 <c:otherwise>
		<label>Immagine assente</label>
		</c:otherwise>
 </c:choose>

	
 </div><br>
 
 <c:if test="${fn:length(colonne)<=10}">
 <div class="col-xs-6">
</c:if>
<c:if test="${fn:length(colonne)>10}">
 <div class="col-xs-12">
 </c:if>
  
<table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    <thead >
        <tr>
            <th colspan="${fn:length(colonne) + 2}" style="text-align:center">RISULTATI MISURE SPESSIMETRICHE [mm]</th>
        </tr>
        <tr>
            <th style="text-align:center"></th>
            <th style="text-align:center"></th>
            <c:forEach var="col" items="${colonne}">
                <th style="text-align:center">${col}</th>
            </c:forEach>
        </tr>
    </thead>
    <tbody>

    <c:set var="row_span_index" value="0"></c:set>
    <c:set var="indice" value="0"></c:set>
        <c:forEach var="riga" items="${matrix_spess}" varStatus="rowStatus">
            <tr>
           
             <c:if test="${rowStatus.index == 0 || rowStatus.index == row_span_index  }">
            <th style="text-align:center;vertical-align: middle" rowspan="${entryList[indice].value - rowStatus.index }">${entryList[indice].key }</th>
            <c:set var="row_span_index" value="${entryList[indice].value  }"></c:set>
             <c:set var="indice" value="${indice +1 }"></c:set>
            </c:if>
          
           
                       
                <th style="text-align:center">${rowStatus.index + 1}</th>
                <c:forEach var="valore" items="${riga}">
                <c:choose>
                 <c:when test="${valore!= 'NA' && valore!= 'na' && valore!= 'N/A' && valore!= 'n/a'}">
                    <td style="text-align:center"><fmt:formatNumber value="${valore}" pattern="#0.00" /></td>
                </c:when>
                <c:otherwise>
                <td style="text-align:center">${valore} </td>
                </c:otherwise>
                </c:choose>
        
                
                </c:forEach>
            </tr>
        </c:forEach>
    </tbody>
</table>
<br>

<%-- <c:forEach items="${prova.label_minimi.split(',') }" var="item" varStatus="loop">
 <div class="row">
 <div class="col-xs-6">

  <input class="form-control label_minimi" readonly type="text" value="${item}">
  </div>
 
  </div><br>
 </c:forEach> --%>
 
 <div class="row">

<div class="col-xs-6">
<table id="tabMinimi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    <thead >
        <tr>
            <th style="text-align:center">Spessori Minimi</th>
            <th style="min-width:100px">Valore</th>
        </tr>
      
    </thead>
    <tbody>

   
    </tbody>
</table>
<%-- <textarea rows="4" style="width:100%" class="form-control" id="label_minimi" readonly></textarea> --%>

</div>
</div><br>


<c:if test="${rapporto!=null && rapporto.stato.id == 1 }">
<div class="row" style="margin-top: 20px;">
    <div class="col-xs-12 text-center">
        <button class="btn btn-warning" onclick="abilitaModifica()">Abilita Modifica</button>
        <button class="btn btn-success" id="btn_salva" onclick="salvaModifiche()" style="display:none">Salva</button>
    </div>
</div>
</c:if>
<div class="row">

<div class="col-xs-12">
<label>Note Prova</label>
<textarea rows="3" style="width:100%" class="form-control" id="note" readonly>${prova.note }</textarea>

</div>
</div>
 </div>

</div>


  </div>
       
 </div>
    
        
        

<div class="row">
<div class="col-xs-12">

<div class="box box-danger box-solid">
<div class="box-header with-border">
	Esito Verifica
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="row">
 <div class="col-xs-4">
 </div>
 <div class="col-xs-4 text-center">
 
 <c:choose>
 <c:when test="${prova.esito=='POSITIVO' }">
 <%-- <textarea rows="2" style="width:100%" class="form-control" id="esito" class="form-control">ESITO DELLA VERIFICA: CONFORME A SPECIFICA</textarea> --%>
 <input id="esito" value="ESITO DELLA VERIFICA: CONFORME A SPECIFICA" class="form-control" readonly> 
<label></label>
  </c:when>
  <c:when test="${prova.esito=='NEGATIVO' }"> 
<input id="esito" value="ESITO DELLA VERIFICA: NON CONFORME A SPECIFICA" class="form-control" readonly> 
   <%-- <textarea rows="2" style="width:100%" class="form-control" id="esito" class="form-control">ESITO DELLA VERIFICA: NON CONFORME A SPECIFICA</textarea> --%>
  
  </c:when>
 </c:choose>

 </div>
 <div class="col-xs-4">
 </div>
 
 
 </div>


 </div>

</div>

</div>
</div>


</div>
</div>
 </div> 
 </div>
</section>
</div>

<div id="lista_zone_minimi" style="display:none">${lista_zone_minimi}</div>

	<div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler generare il rapporto?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_prova_rapporto">
      <a class="btn btn-primary" onclick="generaCertificatoAM($('#id_prova_rapporto').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>
  

  
   
  </div>
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  

  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="plugins/datejs/date.js"></script>
  
 <script type="text/javascript">
 
 
 function modalYesOrNo(id_prova){

	 
		$('#id_prova_rapporto').val(id_prova)
		 
		 
		 $('#myModalYesOrNo').modal();
	
	

}

 function generaCertificatoAM(id_prova, isAnteprima){
		
		dataObj={};
		dataObj.id_prova = id_prova;
		dataObj.isAnteprima = isAnteprima;
		pleaseWaitDiv.modal()
		
		if(isAnteprima!=null && isAnteprima ==1){
			
			var newTab = window.open('', '_blank');
			callAjax(dataObj, "amGestioneInterventi.do?action=genera_certificato", function(data) {
				
				if (data.success) {
					var url = "amGestioneInterventi.do?action=download_certificato&isAnteprima=1&id_prova=" + id_prova;

					newTab.location.href = url;
				} else {

					newTab.close();
				}
			});
		}else{
			callAjax(dataObj, "amGestioneInterventi.do?action=genera_certificato")
		}
		
		
	}
 
 
 var jsonText = document.getElementById('lista_zone_minimi').textContent;
  var listaEntry = JSON.parse(jsonText);
 $(document).ready(function(){
	 
	 var table =   $('#tabMinimi').DataTable({
	        paging: false,        
	        ordering: false,      
	        searching: false,     
	        info: false           
	    });
	 
calcolaMinimi()
 })
 
 function calcolaMinimi(){
	
	 
	 var table =   $('#tabMinimi').DataTable();

	 table.clear();
      // riga iniziale (assumendo che le righe sono 1-based)

     listaEntry.forEach(function(entry, index) {
     	let startRow = parseInt(entry.punto_intervallo_inizio); 
         var endRow = parseInt(entry.punto_intervallo_fine); // punto_intervallo_fine per la zona
         var minVal = Infinity;
         
         str = entry.spessore.replace(',', '.');
            
         const match = str.match(/[\d.]+/);
              
         if(parseFloat(match[0])!=null){
        	  var minimo_spessore = match[0];
         }else{
        	 var minimo_spessore = null;
         }
         
       

         // Ciclo sulle righe della tabella dal numero startRow a endRow
         for (var r = startRow; r <= endRow; r++) {
             // Seleziono la riga r-esima (attenzione: l'indice jQuery parte da 0)
             var row = $('#tabPM tbody tr').eq(r - 1);
             if (row.length === 0) continue;

             // Prendo il testo della prima cella della riga, convertita a numero
             
             row.find('td').each(function() {
		        var val = parseFloat($(this).text().replace(",","."));
		        if (!isNaN(val)) {
		        	if(val < minVal) {
		        		minVal = val;	
		        	}  
		        }else{
		        	minVal = "NA"
		        }
		      });
             
         }

     
         if(minVal!="NA"){
             var r = table.row.add([
         	    entry.zonaRiferimento,
         	    minVal + ' mm'
         	]).node();
             
             
             if (minVal < minimo_spessore) {
         	    $(r).css('background-color', '#FA8989');
         	}
         }else{
        	 
        	 
        	 var r = table.row.add([
          	    entry.zonaRiferimento,
          	    minVal 
          	]).node();
        	 
        	 $(r).css('background-color', '#FA8989');
         }

         
        
         
     });


     table.draw();
 }
 
 function rigeneraTabella(id_prova){
	 
	 dataObj = {};
	 dataObj.id_prova = id_prova;
	 
	 callAjax(dataObj,"amGestioneInterventi.do?action=rigenera_tabella")
	 
	 
 }
		 
 
 
 function abilitaModifica() {
	    // Rende tutte le celle della tabella editabili
	    $('#tabPM tbody td').attr('contenteditable', 'true');
	    $('#tabPM tbody td').css('background-color', '#f9f9b7'); // colore per indicare che è editabile
	    
	    $('#label_minimi').attr("readonly", false);
	    $('#note').attr("readonly", false);
	    $('#esito').attr("readonly", false);
	    $('#btn_salva').show()
	    $('#btn_rigenera').show()
	    
	    
	 	  $('#tabPM tbody td').off('input').on('input', function() {
	 	       calcolaMinimi();
	 	  });
	    
	    $('#tabPM tbody td').off('focus').on('focus', function() {
	        const range = document.createRange();
	        const sel = window.getSelection();
	        range.selectNodeContents(this);
	        sel.removeAllRanges();
	        sel.addRange(range);
	    });
	}
 
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy HH:mm:ss");
		   }			   
		   return str;	 		
	}
 
 
	function salvaModifiche() {
		let result = [];

	    $('#tabPM tbody tr').each(function () {
            let row = [];
            $(this).find('td').each(function () {
                let value = $(this).text().trim().replace(',', '.'); // per compatibilità decimali
                if (!isNaN(parseFloat(value))) {
                    row.push(parseFloat(value));
                }else if(value == 'NA' || value == 'na' || value == 'N/A'|| value == 'n/a'){
                	row.push(value);
                }else{
                	row.push("NA");
                }
            });
            if (row.length > 0) {
                result.push("{" + row.join(",") + "}");
            }
        });

       
	    var formatted = "["+result.join(',')+"]";
	    
	    dataObj ={};
	    dataObj.matrix = formatted;
	    dataObj.id_prova = "${prova.id}"
	    dataObj.note = $('#note').val();
	    dataObj.esito = $('#esito').val();
	    
	    callAjax(dataObj, "amGestioneInterventi.do?action=salva_prova_edit")
	    
	}

	
	
	
	
	
  </script>
  
</jsp:attribute> 
</t:layout>

