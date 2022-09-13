<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista DPI
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista  DPI
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoDPI()"><i class="fa fa-plus"></i> Nuovo DPI</a> 



</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabDpi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipo DPI</th>
<th>Collettivo</th>
<th>Company</th>
<th>Descrizione</th>
<th>Modello</th>
<th>Conformità</th>

<th>Data scadenza</th>
<th>Data controllo</th>
<th>Frequenza</th>

<th>Data scadenza controllo</th>
<th>Archiviato</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_dpi}" var="dpi" varStatus="loop">
 	<c:if test="${dpi.collettivo == 1 }">
 	<tr id="row_${loop.index}" ondblclick="openStoricoModal('${dpi.id }')" >
 	</c:if>
 	 <c:if test="${dpi.collettivo == 0 }">
 	<tr id="row_${loop.index}" >
 	</c:if>
	

	<td>${dpi.id }</td>	
	<td>${dpi.tipo.descrizione }</td>
	<td>
	<c:if test="${dpi.collettivo == 1 }">
	SI
	</c:if>
	<c:if test="${dpi.collettivo == 0 }">
	NO
	</c:if>
</td>
	<td>${dpi.company.ragione_sociale }</td>
	<td>${dpi.descrizione }</td>
	<td>${dpi.modello }</td>
	<td>${dpi.conformita }</td>

	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${dpi.data_scadenza }"></fmt:formatDate></td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${dpi.data_controllo }"></fmt:formatDate></td>
	<td>${dpi.frequenza }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${dpi.data_scadenza_controllo }"></fmt:formatDate></td>
	<td>
	<c:if test="${dpi.disabilitato == 1 }">
	SI
	</c:if>
	</td>
	<td>	

 	  <a class="btn btn-warning customTooltip" onClicK="modalModificaDpi('${dpi.id }','${dpi.tipo.id }','${dpi.collettivo }','${dpi.company.id }','${utl:escapeJS(dpi.modello) }','${utl:escapeJS(dpi.conformita) }','${utl:escapeJS(dpi.descrizione) }','${dpi.data_scadenza }','${dpi.data_controllo }','${dpi.frequenza }','${dpi.data_scadenza_controllo }')" title="Click per modificare la dpi"><i class="fa fa-edit"></i></a>
 	  <c:if test="${dpi.assegnato == 0 && dpi.disabilitato == 0}">
 	  <a class="btn btn-danger customTooltip" onClicK="modalEliminaDpi('${dpi.id }')" title="Click per archiviare il dpi"><i class="fa fa-trash"></i></a>
 	  </c:if>   
 	  
 	  <a class="btn btn-primary customTooltip" onClick="modalAllegati('${dpi.id}')" title="Click per aprire gli allegati"><i class="fa fa-archive"></i></a>
<%-- 	  <c:if test="${dpi.is_restituzione==0 }">
	  <a class="btn btn-success customTooltip" onClicK="modalCreaRestituzione('${dpi.id }', ${dpi.quantita })" title="Crea restituzione DPI"><i class="fa fa-arrow-left"></i></a>
	  </c:if> --%>
 
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>


</section>



<form id="nuovoDpiForm" name="nuovoDpiForm">
<div id="myModalNuovoDPI" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo DPI</h4>
      </div>
       <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo DPI</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_dpi" id="tipo_dpi" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipi DPI..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_dpi}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Collettivo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="collettivo" name="collettivo" class="form-control" type="checkbox" value="0"  style="width:100%" >
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="company" id="company" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Company..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                       <c:forEach items="${lista_company}" var="company">
                     
                           <option value="${company.id}">${company.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione" name="descrizione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello" name="modello" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Conformità</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="conformita" name="conformita" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza" name="data_scadenza" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_controllo" name="data_controllo" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza_controllo" name="data_scadenza_controllo" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
   
       
       </div>
  		 
      <div class="modal-footer">
<input type="hidden" id="nuovo_tipo_dpi" name="nuovo_tipo_dpi">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificadpiForm" name="modificadpiForm">
<div id="myModalmodificadpi" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
     <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica DPI</h4>
      </div>
              <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo DPI</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_dpi_mod" id="tipo_dpi_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipi DPI..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_dpi}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Collettivo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="collettivo_mod" name="collettivo_mod" class="form-control" type="checkbox"  style="width:100%" >
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="company_mod" id="company_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Company..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                       <c:forEach items="${lista_company}" var="company">
                     
                           <option value="${company.id}">${company.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_mod" name="modello_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Conformità</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="conformita_mod" name="conformita_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza_mod" name="data_scadenza_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_controllo_mod" name="data_controllo_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza_controllo_mod" name="data_scadenza_controllo_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
   
       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="id_dpi" name="id_dpi">
		<input type="hidden" id="nuovo_tipo_dpi_mod" name="nuovo_tipo_dpi_mod">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare il dpi?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_dpi">
      <a class="btn btn-primary" onclick="eliminaDpi($('#elimina_dpi').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="modalNuovoTipoDPI" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci descrizione</h4>
      </div>
       <div class="modal-body">    
       <div class="row">
       <div class="col-xs-12">
         <label>Descrizione</label>
      <input class="form-control" type="text" id="descrizione_nuovo_tipo">
       </div>
       </div>   <br>

    
      	</div>
      <div class="modal-footer">
<input type="hidden" id=isMod>
      <a class="btn btn-primary" onclick="assegnaValoreOpzione()" >Salva</a>
		<a class="btn btn-primary" onclick="$('#modalNuovoTipoDPI').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>

<form id="formScheda" name="formScheda" method="post" action="gestioneDpi.do">
<div id="modalScheda" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Crea Scheda DPI</h4>
      </div>
       <div class="modal-body">    
       <div class="row">
       <div class="col-xs-12">
         <label>Tipo Scheda</label>
     		<select id="tipo_scheda" class="form-control select2" id="tipo_scheda" name="tipo_scheda" data-placeholder="Seleziona tipo scheda..." style="width:100%" required>
     		<option value=""></option>
     		<option value="0">Scheda dpi</option>
     		<option value="1">Scheda Ridpi</option>
     		<option value="2">Scheda DPI Collettivi</option>
     		</select>
       </div>
       </div>   <br>
       
      <div class="row" style="display:none" id="content_lavoratore">
       
       	<div class="col-sm-12">
       		<label>Lavoratore</label>
    
       	  	
        
    <select name="lavoratore_scheda" id="lavoratore_scheda" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Lavoratore..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_dipendenti}" var="lavoratore">
                     
                           <option value="${lavoratore.id}">${lavoratore.nome} ${lavoratore.cognome}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div>

    
      	</div>
      <div class="modal-footer">
<input type="hidden" id=isMod>
<input type="hidden" id="action" name="action" value="nuova_scheda_dpi">
      <button class="btn btn-primary" type="submit" >Crea Scheda</button>
		
      </div>
    </div>
  </div>

</div>
</form>


  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">       
      <div id="content_allegati"></div>
      	</div>
      <div class="modal-footer">      
      
		<a class="btn btn-primary" onclick="$('#myModalAllegati').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>



<div id="myModalStorico" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Registro consegne e riconsegne DPI collettivo</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipo</th>
<th>Data consegna/riconsegna</th>
<th>Commessa</th>
<th>Lavoratore</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
         </div>
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

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalEliminaDpi(id_dpi){
	
	
	$('#elimina_dpi').val(id_dpi);
	$('#myModalYesOrNo').modal()
	
}


function modalAllegati(id_dpi){
	
	 exploreModal("gestioneDpi.do","action=lista_allegati_dpi&id_dpi="+id_dpi,"#content_allegati");
	 $('#myModalAllegati').modal();
}

function eliminaDpi(){
	
	dataObj = {};
	
	dataObj.id_dpi = $('#elimina_dpi').val();
	
	callAjax(dataObj, "gestioneDpi.do?action=elimina_dpi");
}

function openStoricoModal(id_dpi){
	
	 dataString ="action=storico&id_dpi="+ id_dpi;
     exploreModal("gestioneDpi.do",dataString,null,function(datab,textStatusb){
   	  	
   	  var result =datab;
   	  
   	  if(result.success){
   		  
   		 
   		  var table_data = [];
   		  
   		  var lista_eventi = result.lista_eventi;
   		  
   		  for(var i = 0; i<lista_eventi.length;i++){
   			  var dati = {};
   			   				     			  
   			  dati.id = lista_eventi[i].id;
   			  
   			  if(lista_eventi[i].is_restituzione==0){
   				dati.tipo = "CONSEGNA"
   			  }else{
   				dati.tipo = "RICONSEGNA"
   			  }   			  
   		
   			
   			  dati.data_consegna = lista_eventi[i].data_consegna;
   			  if(lista_eventi[i].commessa!=null){
   				dati.commessa = lista_eventi[i].commessa;
   			  }else{
   				dati.commessa = '';  
   			  }
   			  
   			  dati.lavoratore = lista_eventi[i].lavoratore.nome +" "+lista_eventi[i].lavoratore.cognome;
   				
   			 
   			  table_data.push(dati);
   			  
   		  }
   		  var table = $('#table_storico').DataTable();
   		  
    		   table.clear().draw();
    		   
    			table.rows.add(table_data).draw();
    			table.columns.adjust().draw();
  			
  		  $('#myModalStorico').modal();
  			
   	  }
   	  
   	  $('#myModalStorico').on('shown.bs.modal', function () {
   		  var table = $('#table_storico').DataTable();
   		  
   			table.columns.adjust().draw();
 			
   		})
   	  
     });
	
}




function modalNuovoDPI(){
	
	$('#myModalNuovoDPI').modal();
	
}

function modalNuovoTipoDPI(){
	
	$('#modalNuovoTipoDPI').modal();
}


$('input:checkbox').on('ifToggled', function() {
	
	$('#collettivo_nuovo').on('ifChecked', function(event){
		$('#collettivo').val(1);
		$('#collettivo_mod').val(1);
	});
	
	$('#collettivo_nuovo').on('ifUnchecked', function(event) {
		
		$('#collettivo').val(0);
		$('#collettivo_mod').val(0);
	});
})


$('#collettivo_mod').on('ifToggled', function() {
	
	$('#collettivo_mod').on('ifChecked', function(event){
		$('#collettivo_mod').val(1);	
	});
	
	$('#collettivo_mod').on('ifUnchecked', function(event) {
		
		$('#collettivo_mod').val(0);
	});
	
});


$('#collettivo').on('ifToggled', function() {
	
	$('#collettivo').on('ifChecked', function(event){
		$('#collettivo').val(1);	
	});
	
	$('#collettivo').on('ifUnchecked', function(event) {
		
		$('#collettivo').val(0);
	});
	
});


function assegnaValoreOpzione(){
	

	
	var data = {
		    id: 0,
		    text: $('#descrizione_nuovo_tipo').val()
		};

		var newOption = new Option(data.text, data.id, false, false);
		
		if($('#isMod').val()== 1){
			
			$('#tipo_dpi_mod').append(newOption).trigger('change');
			$('#tipo_dpi_mod').val(0)
			
			$('#nuovo_tipo_dpi_mod').val($('#descrizione_nuovo_tipo').val());
		

			$('#modalNuovoTipoDPI').modal('hide');
			
		}else{
			$('#tipo_dpi').append(newOption).trigger('change');
			$('#tipo_dpi').val(0)
			
			$('#nuovo_tipo_dpi').val($('#descrizione_nuovo_tipo').val());
		

			$('#modalNuovoTipoDPI').modal('hide');
		}
		

	
}


$('#data_controllo').change(function(){
	
	var frequenza_controllo = $('#frequenza').val()
	
	if(frequenza_controllo!=null && frequenza_controllo !=''){
		
		var date = $('#data_controllo').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza_controllo), day);
			    $('#data_scadenza_controllo').val(formatDate(c));
			    $('#datepicker_data_scadenza_controllo').datepicker("setDate", c );
			
		}
	}
	
	
});


$('#data_controllo_mod').change(function(){
	
	var frequenza_controllo = $('#frequenza_mod').val()
	
	if(frequenza_controllo!=null && frequenza_controllo !=''){
		
		var date = $('#data_controllo_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza_controllo), day);
			    $('#data_scadenza_controllo_mod').val(formatDate(c));
			    $('#datepicker_data_scadenza_controllo_mod').datepicker("setDate", c );
			
		}
	}
	
	
});

$('#frequenza').change(function(){
	
	var data_controllo = $('#data_controllo').val();
	var frequenza_controllo = $('#frequenza').val();
	
	if(data_controllo!=null && data_controllo !=''){
		
		var date = $('#data_controllo').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza_controllo), day);
			    $('#data_scadenza_controllo').val(formatDate(c));
			    $('#datepicker_data_scadenza_controllo').datepicker("setDate", c );
			
		}
	}
	
	
});


$('#frequenza_mod').change(function(){
	
	var data_controllo = $('#data_controllo_mod').val();
	var frequenza_controllo = $('#frequenza_mod').val();
	
	if(data_controllo!=null && data_controllo !=''){
		
		var date = $('#data_controllo_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza_controllo), day);
			    $('#data_scadenza_controllo_mod').val(formatDate(c));
			    $('#datepicker_data_scadenza_controllo_mod').datepicker("setDate", c );
			
		}
	}
	
	
});

function modalModificaDpi(id,id_tipo, collettivo,company, modello, conformita, descrizione, data_scadenza, data_controllo, frequenza, data_scadenza_controllo){
	
	$('#id_dpi').val(id);
	
	$('#tipo_dpi_mod').val(id_tipo);
	$('#tipo_dpi_mod').change();
		
	if(collettivo==1){
		$('#collettivo_mod').iCheck('check');
		$('#collettivo_mod').val(1);
	}else{
		$('#collettivo_mod').iCheck('uncheck');
		$('#collettivo_mod').val(0);
	}
	$('#modello_mod').val(modello);
	$('#conformita_mod').val(conformita);
	$('#descrizione_mod').val(descrizione);
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));	
	}
	if(data_scadenza_controllo!=null && data_scadenza_controllo!=''){
		$('#data_scadenza_controllo_mod').val(Date.parse(data_scadenza_controllo).toString("dd/MM/yyyy"));	
	}
	if(data_controllo!=null && data_controllo!=''){
		$('#data_controllo_mod').val(Date.parse(data_controllo).toString("dd/MM/yyyy"));	
	}
	if(frequenza!=null && frequenza!=''){
		$('#frequenza_mod').val(frequenza);	
	}
	
	$('#company_mod').val(company);
	$('#company_mod').change();
	
	$('#myModalmodificadpi').modal();
}


function modalCreaRestituzione(id_dpi, quantita){
	
	$('#id_dpi_restituzione').val(id_dpi);
	$('#quantita_rest').attr("max", quantita);
	$('#quantita_rest').val( quantita);
	
	$('#myModalRestituzione').modal();
}


var columsDatatables = [];

$("#tabDpi").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDpi thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDpi thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



function aggiungiOpzione(mod){

	if(mod){
		
		$('#isMod').val(1);
		$('#tipo_dpi_mod').select2('close');
		modalNuovoTipoDPI(true);
	}else{
		$('#isMod').val(0);
		$('#tipo_dpi').select2('close');
		modalNuovoTipoDPI(false);
	}
	
	
}


function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

$(document).ready(function() {
 
//$('.select2').select2();

$('#tipo_dpi')
    .select2()
    .on('select2:open', () => {
        $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(false)">Crea Nuovo Tipo DPI</a>');
});

$('#tipo_dpi_mod')
    .select2()
    .on('select2:open', () => {
        $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(true)">Crea Nuovo Tipo DPI</a>');
});

$('#lavoratore').select2();
$('#lavoratore_mod').select2();
$('#tipo_scheda').select2();
$('#lavoratore_scheda').select2();
$('#company').select2();
$('#company_mod').select2();
	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabDpi').DataTable({
			language: {
		        	emptyTable : 	"Nessun dato presente nella tabella",
		        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
		        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
		        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
		        	infoPostFix:	"",
		        infoThousands:	".",
		        lengthMenu:	"Visualizza _MENU_ elementi",
		        loadingRecords:	"Caricamento...",
		        	processing:	"Elaborazione...",
		        	search:	"Cerca:",
		        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
		        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
		        	},
		        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
		        }
	        },
	        pageLength: 25,
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 12 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, 
	 			 {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  }
	 			  ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDpi_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      table
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
		table.columns.adjust().draw();
		

	$('#tabDpi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	  tab = $('#table_storico').DataTable({
			language: {
		        	emptyTable : 	"Non sono presenti documenti antecedenti",
		        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
		        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
		        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
		        	infoPostFix:	"",
		        infoThousands:	".",
		        lengthMenu:	"Visualizza _MENU_ elementi",
		        loadingRecords:	"Caricamento...",
		        	processing:	"Elaborazione...",
		        	search:	"Cerca:",
		        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
		        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
		        	},
		        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
		        }
	        },
	        pageLength: 25,
	        "order": [[ 0, "desc" ]],
		      paging: false, 
		      ordering: true,
		      info: false, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,  
		      scrollX: false,
		      stateSave: true,	
		      columns : [
		      	{"data" : "id"},
		      	{"data" : "tipo"},
		      	{"data" : "data_consegna"},
		      	{"data" : "commessa"},
		      	{"data" : "lavoratore"}
		       ],	
		           
		      columnDefs: [
		    	  
		    	  
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		tab.buttons().container().appendTo( '#table_storico_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     tab.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      tab
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	 	     

	
	
});


$('#modificadpiForm').on('submit', function(e){
	 e.preventDefault();
	 modificaDPI();
});
 

 
 $('#nuovoDpiForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoDPI();
});
 
/*  $('#formScheda').on('submit', function(e){
	 e.preventDefault();
	 nuovaSchedaDPI();
}); */


$('#modalScheda').on('hidden.bs.modal', function(){
	
	$('#tipo_scheda').val("");
	$('#tipo_scheda').change();
	$('#lavoratore_scheda').val("");
	$('#lavoratore_scheda').change();
	
});

 
  </script>
  
</jsp:attribute> 
</t:layout>


