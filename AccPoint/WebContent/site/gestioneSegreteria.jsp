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
        Segreteria
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
      <div class="box box-danger box-solid">
     <div class="box-header with-border">
	Segreteria
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<form id="nuovoItemSegreteriaForm">
<div class="box-body">
<div class="row">
  <div class="col-xs-6">


    <div class="form-group">
                  <label>Cliente</label>
                  <select name="cliente" id="cliente" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
                  <option value=""></option>
                      <c:forEach items="${lista_clienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome} </option> 
                     </c:forEach>
                  </select>
        </div>

  </div>


</div>

<div class="row">
      <div class="col-xs-12">
     <div class="row">
<div class="col-xs-3">
<label>Azienda</label>
	<input name="azienda" id="azienda" type="text" class="form-control" style="width:100%" required>
</div>
<div class="col-xs-3">
<label>Localit�</label>
	<input name="localita" id="localita" type="text" class="form-control" style="width:100%" >
</div>
<div class="col-xs-3">
<label>Telefono</label>
	<input name="telefono" id="telefono" type="text" class="form-control" style="width:100%;" >
</div>

<div class="col-xs-3">
<label>Referente</label>
	<input name="referente" id="referente" type="text" class="form-control" style="width:100%" >
</div>
</div>
<div class="row">
<div class="col-xs-3">
<label>Mail</label>
	<input name="mail" id="mail" type="text" class="form-control" style="width:100%" >
</div>
<div class="col-xs-3">
<label>Offerta Ricevuta</label>
	<input name="offerta" id="offerta" type="text" class="form-control" style="width:100%" >
</div>
</div>
<div class="row">
<div class="col-xs-7">
<label>Note</label>
<textarea  name="note" id="note" rows="3" class="form-control" style="width:100%" ></textarea>
</div>
<div class="col-xs-5">

<button class="btn btn-primary pull-right" style="margin-top:60px" type="submit">Inserisci</button>
</div>

</div>
</div>
</div>
</div>


</form>
</div>

     
     
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	Segreteria
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary" onClick="exploreModal('gestioneSegreteria.do','action=lista','#lista_segreteria')"><i class="fa fa-refresh"></i> Aggiorna</a>
</div>
</div>

<div class="row">
<div class="col-xs-12">
<div id="lista_segreteria"></div>
</div>
</div>


</div>
</div>

 
</div>
</div>


<form id="modificaItemSegreteriaForm" name="modificaItemSegreteriaForm">
<div id="myModalModificaItemSegreteria" class="modal fade" role="dialog" aria-labelledby="myLargeModalModificaItemSegreteria">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Item</h4>
      </div>
       <div class="modal-body">

        <div class="row">
        
  <div class="col-sm-3">
       <label>Cliente</label>
   </div>
     	<div class="col-sm-9">  
                  <select name="cliente_mod" id="cliente_mod" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
                  <option value=""></option>
                      <c:forEach items="${lista_clienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome} </option> 
                     </c:forEach>
                  </select>
        </div>

  </div><br>

<div class="row">
       	<div class="col-sm-3">
       		<label>Azienda</label>
       	</div>
       	<div class="col-sm-9">       	
       		<input name="azienda_mod" id="azienda_mod" type="text" class="form-control" style="width:100%" required>     	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Localit�</label>
       	</div>
       	<div class="col-sm-9">
       		<input name="localita_mod" id="localita_mod" type="text" class="form-control" style="width:100%" >
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Telefono</label>
       	</div>
       	<div class="col-sm-9">
       		<input name="telefono_mod" id="telefono_mod" type="text" class="form-control" style="width:100%" >
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Referente</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="referente_mod" name="referente_mod" style="width:100%" >       	
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Mail</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mail_mod" name="mail_mod" style="width:100%">       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Offerta Ricevuta</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="offerta_mod" name="offerta_mod" style="width:100%">       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">
       	<textarea  name="note_mod" id="note_mod" rows="3" class="form-control" style="width:100%" ></textarea>    	
       	</div>
       </div><br>
       

       </div>
		<input type="hidden" id="id_rilievo" name= "id_rilievo">
  		 
      <div class="modal-footer">
      
		<input type="hidden" id="id_segreteria" name="id_segreteria">
		 <button class="btn btn-primary" type="submit">Modifica</button> 
		
       
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
      	Sei sicuro di voler eliminare l'item?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_item">
      <a class="btn btn-primary" onclick="eliminaItemSegreteria($('#id_item').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>






</section>



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
<script type="text/javascript" src="plugins/datejs/date.js"></script>


<script type="text/javascript">


	$('#nuovoItemSegreteriaForm').on('submit', function(e){
		 e.preventDefault();
		 inserisciItemSegreteria();
	 });  
	$('#modificaItemSegreteriaForm').on('submit', function(e){
		 e.preventDefault();
		 modificaItemSegreteria();
	 });  
 
$(document).ready(function() {
	$('.select2').select2();
	$('.dropdown-toggle').dropdown();
	
	var inserimento = ${inserimento}
	if(!inserimento) {
		exploreModal('gestioneSegreteria.do','action=lista','#lista_segreteria');	
	}
	
	
	
});

$("#cliente").change(function() {
    

	 var id = $(this).val();
	
	$('#azienda').val($('#cliente option[value="'+id+'"]').text())
	
	});

	
$("#cliente_mod").change(function() {
    
	  var id = $(this).val();
	 
		if(id!=''){
			$('#azienda_mod').val($("#cliente_mod option[value="+id+"]").text());	
		}

	});
	


$('#myModalModificaItemSegreteria').on('hidden.bs.modal', function(){
	$('#cliente_mod').val("");
	$('#cliente_mod').change();
	$(document.body).css('padding-right', '0px');
});


  </script>
  
</jsp:attribute> 
</t:layout>


 
 