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

<a class="btn btn-success btn-xs customTooltip pull-right" title="Click per generare il certificato" onClick="modalYesOrNo('${prova.id}')" style="margin-left:2px"><i class="fa fa-check"></i></a>
<a class="btn btn-info btn-xs customTooltip pull-right" title="Click per generare l'anteprima di stampa" onClick="generaCertificatoAM('${prova.id}', 1)"><i class="fa fa-print"></i></a>

</c:if>
</c:if>
                  <c:if test="${rapporto.stato.id == 2}">
<a target="_blank"   class="btn btn-danger btn-xs customTooltip pull-right" title="Click per scaricare il Cerificato"  href="amGestioneInterventi.do?action=download_certificato&id_prova=${prova.id}" > <i class="fa fa-file-pdf-o"></i></a>
 
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
<c:if test="${fn:length(colonne)<=10}">
 <div class="col-xs-6">
</c:if>
<c:if test="${fn:length(colonne)>10}">
 <div class="col-xs-4">
 
 </div>
 <div class="col-xs-4">

 </c:if>

		<img src="amGestioneInterventi.do?action=immagine" alt="Immagine della prova" class="img-fluid d-block mx-auto" style="height: 300px; width: auto;" />
		
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
            <th colspan="${fn:length(colonne) + 1}" style="text-align:center">RISULTATI MISURE SPESSIMETRICHE [mm]</th>
        </tr>
        <tr>
            <th style="text-align:center"></th>
            <c:forEach var="col" items="${colonne}">
                <th style="text-align:center">${col}</th>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="riga" items="${matrix_spess}" varStatus="rowStatus">
            <tr>
                <th style="text-align:center">${rowStatus.index + 1}</th>
                <c:forEach var="valore" items="${riga}">
                    <td style="text-align:center"><fmt:formatNumber value="${valore}" pattern="#0.00" /></td>
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

<textarea rows="4" style="width:100%" class="form-control" id="label_minimi" readonly>${prova.label_minimi }</textarea>

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
			callAjax(dataObj, "amGestioneInterventi.do?action=genera_certificato",function(data){
				
				if(data.success){
					callAction("amGestioneInterventi.do?action=download_certificato&isAnteprima=1&id_prova="+id_prova)
				}
				
			});
		}else{
			callAjax(dataObj, "amGestioneInterventi.do?action=genera_certificato")
		}
		
		
	}
 
 $(document).ready(function(){
	 

	 
	var label_min = $('#label_minimi').val();
	$('#label_minimi').html("")
	
	var values=label_min.split(",");
	
	for (var i = 0; i < values.length; i++) {
		var str = values[i].replace(/[{}]/g, '')+"\n"; 
		$('#label_minimi').append(str)
	}
	
	
 
 })
 
 
 
 function abilitaModifica() {
	    // Rende tutte le celle della tabella editabili
	    $('#tabPM tbody td').attr('contenteditable', 'true');
	    $('#tabPM tbody td').css('background-color', '#f9f9b7'); // colore per indicare che è editabile
	    
	    $('#label_minimi').attr("readonly", false);
	    $('#note').attr("readonly", false);
	    $('#esito').attr("readonly", false);
	    $('#btn_salva').show()
	       
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
                }
            });
            if (row.length > 0) {
                result.push("{" + row.join(",") + "}");
            }
        });

        let formatted = "[" + result.join(",") + "]";
        
        var label_min = "";
        let righe = $('#label_minimi').val().trim().split('\n'); // divide il testo in righe
        for (var i = 0; i < righe.length; i++) {
			label_min += "{"+righe[i]+"},"
		}
	   
	    
	    dataObj ={};
	    dataObj.matrix = formatted;
	    dataObj.id_prova = "${prova.id}"
	    dataObj.label_minimi = label_min;
	    dataObj.note = $('#note').val();
	    dataObj.esito = $('#esito').val();
	    
	    callAjax(dataObj, "amGestioneInterventi.do?action=salva_prova_edit")
	    
	}

  </script>
  
</jsp:attribute> 
</t:layout>

