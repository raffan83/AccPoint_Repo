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
        Lista Consegne DPI
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Consegne DPI
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-left" onClick="$('#modalScheda').modal()"><i class="fa fa-plus"></i> Crea Scheda Dispositivi</a> 
<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> -->
 
   <c:if test="${!utente.checkRuolo('DP') }">
<a class="btn btn-primary pull-right" onClick="modalnuovaConsegna()"><i class="fa fa-plus"></i> Nuova Consegna Dispositivo</a> 
</c:if>


</div>
</div><br>

<div class="row">
<div class="col-xs-12">
 
<button class="btn btn-info pull-left" id="btn_tutti" onClick="callAction('gestioneDpi.do?action=lista_schede_consegna')"><i class="fa fa-plus" ></i> Tutti</button> 
<button class="btn btn-info pull-left" style="margin-left:5px"  id="btn_filtro" onClick="callAction('gestioneDpi.do?action=filtra_non_riconsegnati')"><i class="fa fa-plus"></i> Filtra non riconsegnati</button>
</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabConsegne" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>

<th>Tipo</th>
<th>ID DPI</th>
<th>Ricevuto</th>
<th>Descrizione DPI</th>
<th>DPI Collettivo</th>
<th>Modello</th>
<th>Conformità</th>
<th>Data consegna/riconsegna</th>
<th>Data scadenza</th>
<th>Commessa</th>
<th>Lavoratore</th>

<th>Riconsegnato</th>
<th>Tipologia</th>
<th>Tipo Accessorio</th>
<th>Motivazione</th>
<th>ID Riconsegna</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_consegne}" var="consegna" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${consegna.id }</td>	
	<td>
	<c:if test="${consegna.is_restituzione==0 }">CONSEGNA</c:if>
	<c:if test="${consegna.is_restituzione==1 }">RICONSEGNA</c:if>
	</td>
	<td>${consegna.dpi.id }</td>
		<td>
	<c:if test="${consegna.is_restituzione==0 && consegna.ricevuto == 0}">NO</c:if>
	<c:if test="${consegna.is_restituzione==0 && consegna.ricevuto == 1}">SI</c:if>
	<c:if test="${consegna.is_restituzione==1}"></c:if>
	</td>
	<td>${consegna.dpi.descrizione }</td>
	<td>
	<c:if test="${consegna.dpi.collettivo == 1 }">
	SI
	</c:if>
	<c:if test="${consegna.dpi.collettivo == 0 }">
	NO
	</c:if>
	</td>
	<td>${consegna.dpi.modello }</td>
	<td>${consegna.dpi.conformita }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${consegna.data_consegna }"></fmt:formatDate></td>	
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${consegna.dpi.data_scadenza }"></fmt:formatDate></td>
	<td>${consegna.commessa}</td>
	<td>${consegna.lavoratore.nome } ${consegna.lavoratore.cognome }</td>

	<td>
	<c:if test="${consegna.riconsegnato == 0}">NO</c:if>
	<c:if test="${consegna.riconsegnato == 1}">SI</c:if>
</td>
<td>
	<c:if test="${consegna.dpi.tipologia == 1 }">
	DPI
	</c:if>
	<c:if test="${consegna.dpi.tipologia == 2 }">
	Accessorio
	</c:if>
	</td>
	<c:if test="${consegna.dpi.tipo_accessorio.id!=null }">
	<td>${consegna.dpi.tipo_accessorio.descrizione }</td>
	</c:if>
	<c:if test="${consegna.dpi.tipo_accessorio.id==null }">
	<td></td>
	</c:if>
<td>${consegna.motivazione }</td>
	<td>${consegna.restituzione.id }</td>		
	<td>	
  <c:if test="${!utente.checkRuolo('DP') }">
	   <a class="btn btn-warning customTooltip" onClicK="modalModificaConsegna('${consegna.id }','${consegna.dpi.id }','${consegna.lavoratore.id }', '${consegna.dpi.tipologia }')" title="Click per modificare la consegna"><i class="fa fa-edit"></i></a>   
	  <c:if test="${consegna.is_restituzione==0 && consegna.restituzione == null}">
	  <a class="btn btn-success customTooltip" onClicK="modalCreaRestituzione('${consegna.id }')" title="Crea restituzione DPI"><i class="fa fa-arrow-left"></i></a>
	  </c:if> 
</c:if>
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



<form id="nuovaConsegnaForm" name="nuovaConsegnaForm">
<div id="myModalnuovaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Consegna Dispositivo</h4>
      </div>
       <div class="modal-body">
       
                     <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipologia Dispositivo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipologia" id="tipologia" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipologia Dispositivo..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <option value="1">DPI</option>
                      <option value="2">Accessorio</option>
				
                  </select> 
       			
       	</div>       	
       </div>
       
       
             <div class="row" id="content_dpi" style="display:none">
       <br>
       	<div class="col-sm-3">
       		<label>DPI</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="id_dpi" id="id_dpi" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona DPI..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_dpi}" var="dpi">
                     
                     <c:if test="${dpi.assegnato == 0 && dpi.disabilitato==0}">
                     <option value="${dpi.id}">${dpi.descrizione} (ID ${dpi.id })</option> 
                     </c:if>
                     <c:if test="${dpi.assegnato == 1  && dpi.disabilitato==0 }">
                     <option value="${dpi.id}" disabled>${dpi.descrizione} (ID ${dpi.id })</option> 
                     </c:if>
                           
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div>
       
       
       
       <div class="row" id="content_accessorio" style="display:none">
       <br>
       	<div class="col-sm-3">
       		<label>Accessori</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="id_accessorio" id="id_accessorio" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona DPI..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_accessori}" var="accessorio">
                     
                     <c:if test="${accessorio.assegnato == 0 && accessorio.disabilitato==0}">
                     <option value="${accessorio.id}">${accessorio.descrizione} (ID ${accessorio.id })</option> 
                     </c:if>
                     <c:if test="${accessorio.assegnato == 1  && accessorio.disabilitato==0 }">
                     <option value="${accessorio.id}" disabled>${accessorio.descrizione} (ID ${accessorio.id })</option> 
                     </c:if>
                           
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Lavoratore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="lavoratore" id="lavoratore" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Lavoratore..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_dipendenti}" var="lavoratore">
                     
                           <option value="${lavoratore.id}">${lavoratore.nome} ${lavoratore.cognome}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="commessa" name="commessa" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div>
             
     <!--   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Quantità</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="quantita" name="quantita" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
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
       </div><br> -->
       
       
<!--        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza" name="data_scadenza" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
        -->
   
       
       </div>
  		 
      <div class="modal-footer">
	
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaConsegnaForm" name="modificaConsegnaForm">
<div id="myModalmodificaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
     <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Consegna Dispositivo</h4>
      </div>
              <div class="modal-body">
       
       
             <div class="row" id="content_dpi_mod" style="display:none">
       
       	<div class="col-sm-3">
       		<label>DPI</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="id_dpi_mod" id="id_dpi_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona DPI..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_dpi}" var="dpi">
                     
                           <option value="${dpi.id}">${dpi.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div>
       
       <div class="row" id="content_accessorio_mod" style="display:none">
       <br>
       	<div class="col-sm-3">
       		<label>Accessori</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="id_accessorio_mod" id="id_accessorio_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Accessorio..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_accessori}" var="accessorio">
                 
                   
                     <option value="${accessorio.id}">${accessorio.descrizione} (ID ${accessorio.id })</option> 
                  
                           
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Lavoratore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="lavoratore_mod" id="lavoratore_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Lavoratore..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_dipendenti}" var="lavoratore">
                     
                           <option value="${lavoratore.id}">${lavoratore.nome} ${lavoratore.cognome}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="commessa_mod" name="commessa_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div>
             
     <!--   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Quantità</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="quantita" name="quantita" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
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
       </div><br> -->
       
       
<!--        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza" name="data_scadenza" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
        -->
   
       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="id_consegna" name="id_consegna">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



  <div id="myModalRestituzione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci una motivazione</h4>
      </div>
       <div class="modal-body">       
      	       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Motivazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="motivazione" name="motivazione" class="form-control " type="text" style="width:100%" >
        
       
       	</div>       	
       </div><br>
         <div class="row">
	<div class="col-sm-3">
       		<label>Archivia Dispositivo</label>
       	</div>
       	<div class="col-sm-9">      
               
       		<input id="archivia" name="archivia" type="checkbox">	
       	</div>       	
       </div><br>
       			
       	</div>       	

      <div class="modal-footer">
      <input type="hidden" id="id_consegna_restituzione">
      <input type="hidden" id="archivia_value">
      
      <a class="btn btn-primary" onclick="creaRestituzioneDPI($('#id_consegna_restituzione').val())" >Salva</a>
      </div>
    </div>
  </div>

</div>




  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare il rilievo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary" onclick="eliminaRilievo($('#elimina_rilievo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
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
     		<option value="0">Scheda Consegna</option>
     		<option value="1">Scheda Riconsegna</option>
     		<option value="2">Scheda DPI Collettivi</option>
     		<option value="3">Scheda Accessori</option>
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


$('#tipologia, #tipologia_mod').change(function(){
	
	var val = $(this).val();
	
	if(val==1){
		$('#content_dpi').show();
		$('#content_accessorio').hide();
	
		
	}else if(val==2){
		$('#content_dpi').hide();	
		$('#content_accessorio').show();

	}
	
	
	
});

$('#archivia').on('ifClicked',function(e){
	if($('#archivia').is( ':checked' )){
		$('#archivia').iCheck('uncheck');
		$('#archivia_value').val(0); 
	}else{
		$('#archivia').iCheck('check');
		$('#archivia_value').val(1); 
	}
});

$('#tipo_scheda').change(function(){
	
	var selection = $(this).val();
	if(selection!=2 && selection!=3 ){
		$('#content_lavoratore').show();
		$('#lavoratore_scheda').attr('required', true)
	}else{
		$('#content_lavoratore').hide();
		$('#lavoratore_scheda').attr('required', false)
	}
	
	
});


function modalnuovaConsegna(){
	
	$('#myModalnuovaConsegna').modal();
	
}

function modalNuovoTipoDPI(){
	
	$('#modalNuovoTipoDPI').modal();
}




function modalModificaConsegna(id,id_dpi, id_lavoratore, tipologia){
	
	$('#id_consegna').val(id);
	
	if(tipologia == 1){
		$('#content_accessorio_mod').hide();
		$('#content_dpi_mod').show();
		$('#id_dpi_mod').val(id_dpi);
		$('#id_dpi_mod').change();
	}else{
		$('#content_accessorio_mod').show();
		$('#content_dpi_mod').hide();
		$('#id_accessorio_mod').val(id_dpi);
		$('#id_accessorio_mod').change();
	}

		
	$('#lavoratore_mod').val(id_lavoratore);
	$('#lavoratore_mod').change();
	
	$('#myModalmodificaConsegna').modal();
}


function modalCreaRestituzione(id_consegna, quantita){
	
	$('#id_consegna_restituzione').val(id_consegna);
/* 	$('#quantita_rest').attr("max", quantita);
	$('#quantita_rest').val( quantita); */
	
	$('#myModalRestituzione').modal();
}


var columsDatatables = [];

$("#tabConsegne").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabConsegne thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabConsegne thead th').eq( $(this).index() ).text();
    	
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

$(document).ready(function() {
 
//$('.select2').select2();

var filtro_on = "${filtro_on}";

if(filtro_on ==1){
	$('#btn_filtro').attr("disabled", true);
	$('#btn_tutti').attr("disabled", false);
}else{
	$('#btn_filtro').attr("disabled", false);
	$('#btn_tutti').attr("disabled", true);
}

$('#id_dpi').select2()
$('#id_accessorio').select2()
$('#tipologia').select2()

$('#id_dpi_mod').select2()
$('#id_accessorio_mod').select2()

$('#lavoratore').select2();
$('#lavoratore_mod').select2();
$('#tipo_scheda').select2();
$('#lavoratore_scheda').select2();
	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabConsegne').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 10 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, 
		 			 {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabConsegne_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabConsegne').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaConsegnaForm').on('submit', function(e){
	 e.preventDefault();
	 modificaConsegnaDPI();
});
 

 
 $('#nuovaConsegnaForm').on('submit', function(e){
	 e.preventDefault();
	 nuovaConsegnaDPI();
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


