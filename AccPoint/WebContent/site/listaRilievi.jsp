<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
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
        Lista Rilievi Dimensionali
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
	 Lista Rilievi Dimensionali
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-md-5">
<label>Filtra Rilievi</label>
<select class="form-control select2" data-placeholder="Seleziona Rilievi..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_rilievi" name="filtro_rilievi">
	<option value=""></option>
	<option value="1">IN LAVORAZIONE</option>
	<option value="2">LAVORATI</option>
</select>
</div>
</div><br>








<!-- <div class="row">
<div class="col-sm-12">
<button class="btn btn-primary" onClick="modalNuovoRilievo()"><i class="fa fa-plus"></i> Nuovo Rilievo</button>

</div>
</div><br> -->

<div id="lista_rilievi"></div>
<%-- <div class="row">
<div class="col-sm-12">


 <table id="tabRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Data Inizio Rilievo</th>
<th>Disegno</th>
<th>Variante</th>
<th>Fornitore</th>
<th>Apparecchio</th>
<th>Tipo Rilievo</th>
<th>Stato Rilievo</th>
<th>Cliente</th>
<th>Sede</th>
<th>Commessa</th>
<th>Data Consegna</th>
<th>Utente</th>
<th>Azioni</th>


 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_rilievi }" var="rilievo" varStatus="loop">
	<tr id="row_${loop.index}" >
		<td>${rilievo.id }</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_inizio_rilievo }" /></td>	
		<td>${rilievo.disegno }</td>
		<td>${rilievo.variante }</td>
		<td>${rilievo.fornitore }</td>
		<td>${rilievo.apparecchio }</td>	
		<td>${rilievo.tipo_rilievo.descrizione }</td>
		<td>${rilievo.stato_rilievo.descrizione }</td>
		<td>${rilievo.nome_cliente_util }</td>
		<td>${rilievo.nome_sede_util }</td>
		<td>${rilievo.commessa}</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_consegna }" /></td>	
		<td>${rilievo.utente.nominativo }</td>
		<td>
		<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${rilievo.id}')"><i class="fa fa-search"></i></a>
		<a href="#" class="btn btn-warning customTooltip" title="Click per modificare il rilievo" onclick="modalModificaRilievo('${rilievo.id }','${rilievo.data_inizio_rilievo }','${rilievo.tipo_rilievo.id }','${rilievo.id_cliente_util }','${rilievo.id_sede_util }','${rilievo.commessa}',
		'${rilievo.disegno }', '${rilievo.variante }', '${rilievo.fornitore }', '${rilievo.apparecchio }', '${rilievo.data_inizio_rilievo }')">		
		<i class="fa fa-edit"></i></a>
		<a href="#" class="btn btn-danger customTooltip" title="Click per chiudere il rilievo" onclick="chiudiRilievo('${rilievo.id}')"><i class="glyphicon glyphicon-remove"></i></a>
		</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div> --%>
</div>
</div>



 
 
</div>
</div>


</section>
<form id="nuovoRilievoForm" name="nuovoRilievoForm">
<div id="myModalNuovoRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Rilievo</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente" name="cliente" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="sede" name="sede" style="width:100%" disabled required>
       		<option value=""></option>
       			<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
       				<option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo }</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Commessa..." id="commessa" name="commessa" style="width:100%">
       		<option value=""></option>
       			<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Disegno</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="disegno" name="disegno" style="width:100%" required>       	
       	</div>
       </div><br>
        <div class="row">
        <div class="col-sm-3">
       		<label>Variante</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="variante" name="variante" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="fornitore" name="fornitore" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Apparecchio</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="apparecchio" name="apparecchio" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo Rilievo..." id="tipo_rilievo" name="tipo_rilievo" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_rilievo }" var="tipo_rilievo" varStatus="loop">
       				<option value="${tipo_rilievo.id}">${tipo_rilievo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Inizio Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_rilievo'>
               <input type='text' class="form-control input-small" id="data_inizio_rilievo" name="data_inizio_rilievo">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
       </div>

  		 
      <div class="modal-footer">
      <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label>

		 <a class="btn btn-primary"  onClick="inserisciRilievo()">Salva</a> 
		
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaRilievoForm" name="modificaRilievoForm">
<div id="myModalModificaRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalModificaRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Rilievo</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="mod_cliente" name="mod_cliente" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="mod_sede" name="mod_sede" style="width:100%" disabled required>
       		<option value=""></option>
       			<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
       				<option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo }</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Commessa..." id="mod_commessa" name="mod_commessa" style="width:100%">
       		<option value=""></option>
       			<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Disegno</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_disegno" name="mod_disegno" style="width:100%" value=""required>       	
       	</div>
       </div><br>
        <div class="row">
        <div class="col-sm-3">
       		<label>Variante</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_variante" name="mod_variante" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_fornitore" name="mod_fornitore" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Apparecchio</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_apparecchio" name="mod_apparecchio" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo Rilievo..." id="mod_tipo_rilievo" name="mod_tipo_rilievo" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_rilievo }" var="tipo_rilievo" varStatus="loop">
       				<option value="${tipo_rilievo.id}">${tipo_rilievo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Inizio Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' >
               <input type='text' class="form-control input-small" id="mod_data_inizio_rilievo" name="mod_data_inizio_rilievo">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
       </div>
		<input type="hidden" id="id_rilievo" name= "id_rilievo">
  		 
      <div class="modal-footer">
      <label id="mod_label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label>

		 <button class="btn btn-primary" type="submit">Modifica</button> 
		
       
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
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

 <script type="text/javascript">
 

     $(document).ready(function() {
    	 $('.select2').select2();
     });

	

 $('#filtro_rilievi').change(function(){
	
	 var value = $('#filtro_rilievi').val();	 

		 dataString ="action=filtra&id_stato_lavorazione="+ value;
	       exploreModal("listaRilieviDimensionali.do",dataString,"#lista_rilievi",function(datab,textStatusb){

	
	       });
	 
 });
 
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






