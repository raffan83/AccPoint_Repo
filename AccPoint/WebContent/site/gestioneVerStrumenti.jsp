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
        Lista strumenti
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
	 Lista Strumenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-3">

<a class="btn btn-primary" onClick="modalNuovoStrumento()"><i class="fa fa-plus"></i> Nuovo Strumento</a>

</div>

</div><br>


<%-- <div class="row">
<div class="col-md-5">
<label>Cliente</label>
<c:choose>
<c:when test="${cliente_filtro!=null }">
<select class="form-control select2" data-placeholder="Seleziona Cliente..."  aria-hidden="true" data-live-search="true" style="width:100%" id="cliente_filtro" name="cliente_filtro">
	       		<option value=""></option>
	       		<c:choose>
	       		<c:when test="${cliente_filtro=='0' }">
	       			<option value = "0" selected>TUTTI</option>
	       		</c:when>
	       		<c:otherwise>
	       		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
	       			<option value = "0">TUTTI</option>	
	       		</c:if>
	       		</c:otherwise>
	       		</c:choose>	       		
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       			<c:choose>
       			<c:when test="${cliente.__id == cliente_filtro }">
       				<option value="${cliente.__id}" selected>${cliente.nome }</option>
       			</c:when>
       			<c:otherwise>         				   			
       				<option value="${cliente.__id}">${cliente.nome }</option>       				
       			</c:otherwise>
       			</c:choose> 
       			</c:forEach>
</select>
</c:when>
<c:otherwise>
<select class="form-control select2" data-placeholder="Seleziona Cliente..."  aria-hidden="true" data-live-search="true" style="width:100%" id="cliente_filtro" name="cliente_filtro">
 	       		<option value=""></option>
	       		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
	       			<option value = "0">TUTTI</option>	
	       			</c:if>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       			<c:choose>
       				<c:when test="${lista_clienti.size()==1 }">
       				<option value="${cliente.__id}" selected>${cliente.nome }</option>
       				</c:when>
       				<c:otherwise>
       				<option value="${cliente.__id}">${cliente.nome }</option>
       				</c:otherwise>
       				</c:choose>   
       				
       			<option value=""></option>
	       		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
	       			<option value = "0">TUTTI</option>	
	       			</c:if>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       			<c:choose>
       				<c:when test="${lista_clienti.size()==1 }">
       				<option value="${cliente.split('_')[0]}" selected>${cliente.split('_')[1] }</option>
       				</c:when>
       				<c:otherwise>
       				<option value="${cliente.split('_')[0]}">${cliente.split('_')[1] }</option>
       				</c:otherwise>
       				</c:choose>  
       				
       				
       			</c:forEach>
</select>
</c:otherwise>
</c:choose>

</div>


<div class="col-md-5">
<label>Filtra Rilievi</label>
<c:choose>
<c:when test="${filtro_rilievi!=null }">
<select class="form-control select2" data-placeholder="Seleziona Rilievi..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_rilievi" name="filtro_rilievi">
	<option value=""></option>
	<c:choose>
	<c:when test="${filtro_rilievi=='0' }"> <option value="0" selected>TUTTI</option> </c:when>
	<c:otherwise><option value="0">TUTTI</option></c:otherwise>
	</c:choose>
	<c:choose>
	<c:when test="${filtro_rilievi=='1' }"> <option value="1" selected>IN LAVORAZIONE</option> </c:when>
	<c:otherwise><option value="1">IN LAVORAZIONE</option></c:otherwise>
	</c:choose>
	<c:choose>
	<c:when test="${filtro_rilievi=='2' }"><option value="2" selected>LAVORATI</option> </c:when>
	<c:otherwise><option value="2">LAVORATI</option></c:otherwise>
	</c:choose>
</select>
</c:when>
<c:otherwise>
<select class="form-control select2" data-placeholder="Seleziona Rilievi..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_rilievi" name="filtro_rilievi">
	<option value=""></option>
	<option value="0">TUTTI</option>
	<option value="1">IN LAVORAZIONE</option>
	<option value="2">LAVORATI</option>
</select>
</c:otherwise>
</c:choose>

</div>


</div><br> --%>


<div class="row">
<div class="col-sm-12">

 <table id="tabStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Denominazione</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Matricola</th>
<th>Cliente</th>
<th>Sede</th>
<th>Classe</th>
<th>Tipo</th>
<th>Data ultima verifica</th>
<th>Data prossima verifica</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${loop.index}" >
	<td>${strumento.id }</td>	
	<td>${strumento.denominazione }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.modello }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.nome_cliente }</td>
	<td>${strumento.nome_sede }</td>
	<td>${strumento.classe }</td>
	<td>${strumento.tipo.descrizione }</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_ultima_verifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_prossima_verifica }" /></td>
	
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
<form id="nuovoStrumentoForm" name="nuovoStrumentoForm">
<div id="myModalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Strumento</h4>
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
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo..." id="tipo_ver_strumento" name="tipo_ver_strumento" style="width:100%" disabled required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_ver_strumento}" var="tipo" varStatus="loop">
       				<option value="${tipo.id}">${tipo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="denominazione" name="denominazione" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="costruttore" name="costruttore" style="width:100%">       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="modello" name="modello" style="width:100%">       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola" name="matricola" style="width:100%">       	
       	</div>
       </div><br>
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="classe" min="1" max="4" name="classe" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Unità di misura</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Unità di Misura..." id="um" name="um" style="width:100%" disabled required>
       		<option value="Kg">Kg</option>
       		<option value="g">g</option>
       		
       		</select>
       	</div>
       </div><br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Ultima Verifica</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_ultima_verifica'>
               <input type='text' class="form-control input-small" id="data_ultima_verifica" name="data_ultima_verifica">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_prossima_verifica'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica" name="data_prossima_verifica">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control"  id="portata_min_c1" name="portata_min_c1" required>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control"  id="portata_max_c1" name="portata_max_c1" required>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control"  id="portata_max_c1" name="portata_max_c1" required>
       	</div>
       </div> <br> 
               
       </div>

  		 
      <div class="modal-footer">
      <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label>

		 <!-- <a class="btn btn-primary"  onClick="inserisciRilievo()">Salva</a>  -->
		<!--  <a class="btn btn-primary"  type="submit">Salva</a>  -->
		<button class="btn btn-primary" type="submit">Salva</button> 
       
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
       			<option value="${commessa.ID_COMMESSA}*${commessa.ID_ANAGEN}*${commessa.ID_ANAGEN_UTIL}">${commessa.ID_COMMESSA}</option>
       				<%-- <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option --%>
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
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_denominazione" name="mod_denominazione" style="width:100%">       	
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
       		<label>Materiale</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_materiale" name="mod_materiale" style="width:100%">       	
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
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Mese di Riferimento</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group'  id='mese_riferimento'>
       		<select class="form-control select2" data-placeholder="Seleziona Mese Di Riferimento..." id="mod_mese_riferimento" name="mod_mese_riferimento" style="width:100%" required>
			  <option value=""></option>
              <option value="Gennaio">Gennaio</option>
              <option value="Febbraio">Febbraio</option>
              <option value="Marzo">Marzo</option>
              <option value="Aprile">Aprile</option>
              <option value="Maggio">Maggio</option>
              <option value="Giugno">Giugno</option>
              <option value="Luglio">Luglio</option>
              <option value="Agosto">Agosto</option>
              <option value="Settembre">Settembre</option>
              <option value="Ottobre">Ottobre</option>
              <option value="Novembre">Novembre</option>
              <option value="Dicembre">Dicembre</option>
                
                </select>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Classe di tolleranza</label>
       	</div>
       	<div class="col-sm-9">
       	      <select class="form-control select2" data-placeholder="Seleziona classe di tolleranza..." id="mod_classe_tolleranza" name="mod_classe_tolleranza" style="width:100%" required>
       		  <option value=""></option>
              <option value="f">f</option>
              <option value="m">m</option>
              <option value="c">c</option>
              <option value="v">v</option>        
              <option value="ISO 130 DIN 16901 A">ISO 130 DIN 16901 A</option>                
              <option value="ISO 130 DIN 16901 B">ISO 130 DIN 16901 B</option>        
             	</select>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Cifre Decimali</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" min="0" max="10" id="mod_cifre_decimali" name="mod_cifre_decimali">
       	</div>
       </div><br>    
         <div class="row">
      	<div class="col-xs-3">
      	<label>Note</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<textarea rows="3" style="width:100%" id="mod_note_rilievo" name="mod_note_rilievo"></textarea>
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




var columsDatatables = [];

$("#tabStrumenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabStrumenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabStrumenti thead th').eq( $(this).index() ).text();
    	
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );


$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();

     table = $('#tabStrumenti').DataTable({
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
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,		     
		      columnDefs: [

		    	  { responsivePriority: 1, targets: 1 }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabStrumenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabStrumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
});
 $('#modificaRilievoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaRilievo();
});
 

 
 $('#nuovoRilievoForm').on('submit', function(e){
	 e.preventDefault();
	 inserisciRilievo();
});
 



  </script>
  
</jsp:attribute> 
</t:layout>

