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
       				
       			<%-- <option value=""></option>
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
       				</c:choose>   --%>
       				
       				
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


</div><br>


<div id="lista_rilievi"></div>

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
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="denominazione" name="denominazione" style="width:100%">       	
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
       		<label>Materiale</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="materiale" name="materiale" style="width:100%">       	
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
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Mese di Riferimento</label>
       	</div>
       	<div class="col-sm-9">
      		<div class='input-group' >
       		<select class="form-control select2" data-placeholder="Seleziona Mese di Riferimento..." id="mese_riferimento" name="mese_riferimento" style="width:100%" required>
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
       	      <select class="form-control select2" data-placeholder="Seleziona classe di tolleranza..." id="classe_tolleranza" name="classe_tolleranza" style="width:100%" required>
       		  <option value=""></option>
              <option value="f">f</option>
              <option value="m" selected>m</option>
              <option value="c">c</option>
              <option value="v">v</option>                
                </select>
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Cifre Decimali</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" min="0" max="10" id="cifre_decimali" name="cifre_decimali" value="3" required>
       	</div>
       </div> <br>    
         <div class="row">
      	<div class="col-xs-3">
      	<label>Note</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<textarea rows="3" style="width:100%" id="note_rilievo" name="note_rilievo"></textarea>
      	</div> 
      	</div>
       
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



<form id="formAllegati" name="formAllegati">
  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_pdf" accept=".pdf,.PDF"  type="file" name="fileupload_pdf" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

      <a class="btn btn-primary" onClick="validateAllegati()">Salva</a> 
     
      </div>
   
  </div>
  </div>
</div>
</form>

<form id="formAllegatiImg" name="formAllegatiImg">
  <div id="myModalAllegatiImg" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Immagine Frontespizio</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_img" accept=".jpg,.gif,.jpeg,.tiff,.png" type="file" name="fileupload_pimg" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label_img"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

      <a class="btn btn-primary" onClick="validateAllegatiImg()">Salva</a>
      </div>
   
  </div>
  </div>
</div>
</form>





  <div id="myModalAllegatiArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Archivio Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.tiff,.png,.doc,.docx,.xls,.xlsx,.dxf,.dwg,.stp,.igs,.iges,.catpart,.eml,.msg,.rar,.zip"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

     
      </div>
   
  </div>
  </div>
</div>


  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Archivio Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div id="tab_archivio"></div>

  		 </div>
  		 </div>
      <div class="modal-footer">
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

<!-- <div id="myModalListaSchedeConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg  modal-fullscreen" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Schede Consegna Rilievi</h4>
      </div>
       <div class="modal-body">
			<div id="content_schede_consegna">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>  -->


  <div id="myModalCertificatiCampione" class="modal fade" role="dialog" aria-labelledby="myModalCertificatiCampione">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scegli un campione</h4>
      </div>
       <div class="modal-body" id="body_certificati_campione">       
      
      	</div>
      <div class="modal-footer">
     <a class="btn btn-primary" id="aggiungiCertCampione">Salva</a>

      </div>
    </div>
  </div>

</div>



<form name="scaricaSchedaConsegnaRilieviForm" method="post" id="scaricaSchedaConsegnaRilieviForm" action="scaricaSchedaConsegna.do?action=rilievi_dimensionali">
<div id="myModalSchedaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">

    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scheda Consegna</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
 
 <div class="form-group">
		  <label for="cliente_scn">Cliente:</label>
		  <select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente_scn" name="cliente_scn" style="width:100%" required>
       		<option value=""></option>
       			 <c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach> 
       		</select> 
		</div>
		<div class="form-group">
		  <label for="sede_scn">Sede:</label>
		  <select class="form-control select2" data-placeholder="Seleziona Sede..." id="sede_scn" name="sede_scn" style="width:100%" disabled required>
       		<option value=""></option>
       			<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
       				<option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo }</option>
       			</c:forEach>
       		</select>
		</div>
		<div class="form-group">
		  <label for="commessa_scn">Commessa:</label>
		  <select class="form-control select2" data-placeholder="Seleziona Commessa..." id="commessa_scn" name="commessa_scn" style="width:100%" required>
       		<option value=""></option>
       		<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
		</div>
		<div class="form-group">
		  <label for="mese_scn">Mese di Riferimento:</label>
		 <select class="form-control select2" data-placeholder="Seleziona Mese Di Riferimento..." id="mese_scn" name="mese_scn" style="width:100%" required>
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
		</div>
		<div class="form-group">
		  <label for="anno_scn">Anno:</label>
		 <select class="form-control select2" data-placeholder="Seleziona Anno Di Riferimento..." id="anno_scn" name="anno_scn" style="width:100%" required>
			  <option value=""></option>
              <option value="2018">2018</option>
              <option value="2019" selected>2019</option>
              <option value="2020">2020</option>
              <option value="2021">2021</option>
                </select>
		</div>
        <div class="form-group">
		  <label for="notaConsegna">Consegna di:</label>
		  <textarea class="form-control" rows="5" name="notaConsegna" id="notaConsegna">EFFETTUATI CONTROLLI DIMENSIONALI SU N PARTICOLARI CON UN TOTALE DI N QUOTE</textarea>
		</div>
		
		<div class="form-group">
		  <label for="notaConsegna">Cortese Attenzione di:</label>
		  <input class="form-control" id="corteseAttenzione" name="corteseAttenzione" />
		</div>
		
      <fieldset class="form-group">
		  <label for="gridRadios">Stato Intervento:</label>
         <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="0" checked="checked">
            CONSEGNA DEFINITIVA
           </label>
        </div>
        <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="1">
            STATO AVANZAMENTO
          </label>

      </div>
    </fieldset>	     
 
  		 </div>
      
    </div>
     <div class="modal-footer">

<!--      <button class="btn btn-default pull-left" onClick="scaricaSchedaConsegnaRilieviDimensionali()"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button> -->
      <button class="btn btn-default pull-left" type="submit" > <i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
   
    	
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
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript">
 
 
 var options_cliente =  $('#cliente option').clone();
 var options_sede =  $('#sede option').clone();
     $(document).ready(function() {
    	 $('.select2').select2();

    	 if($('#filtro_rilievi').val()!=""){
    		 $('#filtro_rilievi').change();
    	 }
     });
     $('.dropdown-toggle').dropdown();
	$("#fileupload_pdf").change(function(event){		
		
        if ($(this).val().split('.').pop()!= 'pdf' && $(this).val().split('.').pop()!= 'PDF') {
        	        
        	$('#myModalErrorContent').html("Attenzione! Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_pdf')[0].files[0].name;
       	 $('#filename_label').html(file );
        }        
	});
	
	$("#fileupload_img").change(function(event){
		
		var fileExtension = 'jpg';
		var fileExtension2 = 'JPG';
        if ($(this).val().split('.').pop()!= fileExtension && $(this).val().split('.').pop()!= fileExtension2) {        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci un'immagine .jpg!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_img')[0].files[0].name;
       	 $('#filename_label_img').html(file );
        }
        		
	});
	
	
	 function validateAllegati(){
		var filename = $('#fileupload_pdf').val();
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegatiRilievi($('#filtro_rilievi').val(), $('#cliente_filtro').val());
		}
	} 

	
	function validateAllegatiImg(){
		var filename = $('#fileupload_img').val();
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegatiRilieviImg($('#filtro_rilievi').val(), $('#cliente_filtro').val());
		}
	}
	
	
 $('#filtro_rilievi').change(function(){
	
	 var stato_lavorazione = $('#filtro_rilievi').val();	 
	 var cliente_filtro = $('#cliente_filtro').val();
	
		 dataString ="action=filtra&id_stato_lavorazione="+ stato_lavorazione+"&cliente_filtro="+cliente_filtro;
	       exploreModal("listaRilieviDimensionali.do",dataString,"#lista_rilievi",function(datab,textStatusb){
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
 
 $('#scaricaSchedaConsegnaRilieviForm').on('submit', function(e){
	 e.preventDefault();
	 $('#scaricaSchedaConsegnaRilieviForm')[0].submit();
	 $("#myModalSchedaConsegna").modal('hide');	
 });
 
 
 $('#myModalSchedaConsegna').on('hidden.bs.modal', function(){
		$('#anno_scn').val('2019');
		$('#anno_scn').change();
		$('#notaConsegna').val('EFFETTUATI CONTROLLI DIMENSIONALI SU N PARTICOLARI CON UN TOTALE DI N QUOTE');
		$('#corteseAttenzione').val('');
		$('#gridRadios2').iCheck('uncheck')
		$("#gridRadios1").iCheck('check')
		$('#mese_scn').val('');
		$('#mese_scn').change();
		$('#commessa_scn').val('');
		$('#commessa_scn').change();
	});
 
 
 $("#cliente_filtro").change(function() {
	  
	 var stato_lavorazione = $('#filtro_rilievi').val();	 
	 var cliente_filtro = $('#cliente_filtro').val();
	
	if(stato_lavorazione!=""){
		 dataString ="action=filtra&id_stato_lavorazione="+ stato_lavorazione+"&cliente_filtro="+cliente_filtro;
	       exploreModal("listaRilieviDimensionali.do",dataString,"#lista_rilievi",function(datab,textStatusb){
	       });
	}
	  
	});
 
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






