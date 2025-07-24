<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
String[] nomiMesi = {
	    "GENNAIO", "FEBBRAIO", "MARZO", "APRILE", "MAGGIO", "GIUGNO",
	    "LUGLIO", "AGOSTO", "SETTEMBRE", "OTTOBRE", "NOVEMBRE", "DICEMBRE"
	};
    pageContext.setAttribute("nomiMesi", nomiMesi);
%>

<div class="row">
<div class="col-sm-12">
<a class="btn btn-primary" onClick="modalNuovaScadenza()"><i class="fa fa-plus"></i> Nuova Scadenza</a>
</div>
</div><br>

<!-- 
       	<div class="col-sm-9">       	
       		<input class="form-control" data-placeholder="Seleziona Cliente..." id="test" name="test" style="width:100%" >
       		 <input id="test" style="width:100%;" placeholder="type a number, scroll for more results" /> 	
       	</div>  -->

<div class="row">
<div class="col-sm-12">

 <table id="tabScadenzario" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  <thead>
    <tr class="active">
      <th></th>
      <th></th>
      <c:forEach items="${lista_attrezzature}" var="attrezzatura">
        <th>${attrezzatura.descrizione}</th>
      </c:forEach>
    </tr>
  </thead>

  <tbody>
    <c:set var="anno" value="2025" />
    <c:forEach var="mese" begin="0" end="11" varStatus="status">
      <tr>
        <c:if test="${status.first}">
          <td rowspan="12" class="vertical-text" style="width:20px; max-width:20px; min-width:20px;">${anno}</td>
        </c:if>

        <!-- Nome del mese -->
        <td>${nomiMesi[status.index]}</td>

        <!-- Celle per ogni attrezzatura -->
        <c:forEach items="${lista_attrezzature}" var="attrezzatura">
          <td style="text-align:center;">
            <c:choose>
              <c:when test="${attrezzatura.mapScadenze[nomiMesi[status.index]] != null}">
                <a class="btn customLink" target="_blank" href="amScGestioneScadenzario.do?action=lista_scadenze_mese&id_attrezzatura=${attrezzatura.id }&mese=${mese}&anno=${anno}">${attrezzatura.mapScadenze[nomiMesi[status.index]]}</a>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
        </c:forEach>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>
</div>


<form id="nuovaScadenzaForm" name="nuovoStrumentoForm">
<div id="myModalNuovaScadenza" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuova Attività</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Attrezzatura</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Attrezzatura..." id="attrezzatura" name="attrezzatura" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_attrezzature}" var="attrezzatura" varStatus="loop">
       				<option value="${attrezzatura.id}">${attrezzatura.descrizione }</option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
        <div class="row">
      	<div class="col-sm-3">
       		<label>Attività</label>
       	</div>
       	<div class="col-sm-9">
       	<a class="btn btn-primary" onclick="modalAggiungiAttivita()"><i class="fa fa-plus"></i></a>
       		<%-- <select class="form-control select2" data-placeholder="Seleziona Sede..." id="attivita" name="attivita" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_attivita}" var="attivita" varStatus="loop">
       				<option value="${attivita.id}">${attivita.descrizione}</option>
       			</c:forEach>
       		</select> --%>
       	</div>
       </div><br>
     
       <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="frequenza" type="number" step="1" min="0" name="frequenza" style="width:100%" required>       	
       	</div>
       </div><br>
      
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data scadenza attività</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza" name="data_scadenza" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
        
        
       </div>

  		 
      <div class="modal-footer">
    
		<input type="hidden" id="id_attivita" name="id_attivita" >
		<input type="hidden" id="id_cliente" name="id_cliente" value="$('#cliente).val()">
		<input type="hidden" id="id_sede" name="id_sede" value="$('#sede).val()">

		 
		<button class="btn btn-primary" type="submit" id="save_btn" disabled>Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



<div id="myModalNuovaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuova Attività</h4>
      </div>
       <div class="modal-body">

        <div class="row">
        <div class="col-xs-12">
        
         <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  <thead>
    <tr class="active">
      <th></th>
      <th>ID</th>
      <th>Descrizione attività</th>
     
    </tr>
  </thead>

  <tbody>
  
    <c:forEach items="${lista_attivita }" var="attivita" varStatus="status">
      <tr>
     
     <td></td>
        <td>${attivita.id }</td>
        <td>${attivita.descrizione }</td>

      </tr>
    </c:forEach>
  </tbody>
</table>
        
       </div>
       </div>
        
        
       </div>

  		 
      <div class="modal-footer">

		 
		<button class="btn btn-primary" type="submit" id="save_btn" disabled>Salva</button> 
       
      </div>
    </div>
  </div>

</div>


<%--
<form id="modificaVerStrumentoForm" name="modificaVerStrumentoForm">
<div id="myModalModificaVerStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Strumento</h4>
      </div>
       <div class="modal-body">
 <div class="row">
       	<div class="col-sm-3">
       		<label>Famiglia Strumento</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Famiglia Strumento..." id="famiglia_strumento_mod" name="famiglia_strumento_mod" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_famiglie_strumento}" var="famiglia" varStatus="loop">
       				<option value="${famiglia.id}">${famiglia.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	 <div class="col-sm-9" style="display:none">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente_appoggio" name="cliente_appoggio" style="display:none">
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>       	
       	</div>     
       	
        	<div class="col-sm-9">       	
       		<input class="form-control" data-placeholder="Seleziona Cliente..." id="cliente_mod" name="cliente_mod" style="width:100%" required>
       		
       	</div>  
       	  	
       </div><br> 
        <div class="row">
      	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="sede_mod" name="sede_mod" style="width:100%" disabled required>
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
       		<select class="form-control select2" data-placeholder="Seleziona Tipo..." id="tipo_ver_strumento_mod" name="tipo_ver_strumento_mod" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_strumento}" var="tipo" varStatus="loop">
       				<option value="${tipo.id}">${tipo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipologia</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipologia..." id="tipologia_mod" name="tipologia_mod" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipologie_strumento}" var="tipologia" varStatus="loop">
       				<option value="${tipologia.id}">${tipologia.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="denominazione_mod" name="denominazione_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="costruttore_mod" name="costruttore_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="modello_mod" name="modello_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_mod" name="matricola_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Classe..." id="classe_mod" name="classe_mod" style="width:100%" required>
       		<option value="1">1</option>
       		<option value="2">2</option>
       		<option value="3">3</option>
       		<option value="4">4</option>
       		<option value="5">1 - lettura fine</option>
       		<option value="6">2 - lettura fine</option>
       		</select>
       		<!-- <input type="number" class="form-control" id="classe_mod" min="1" max="4" name="classe_mod" style="width:100%" required> -->       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Unità di misura</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Unità di Misura..." id="um_mod" name="um_mod" style="width:100%" required>
       		<option value="kg">kg</option>
       		<option value="g">g</option>
       		
       		</select>
       	</div>
       </div><br> 
       <div class="row">
       <div class="col-sm-3">
       		<label>Anno marcatura CE</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="anno_marcatura_ce_mod" min="1900" max="2999" step="1" name="anno_marcatura_ce_mod" style="width:100%" required>
       	</div>
       </div><br> 
       <div class="row">
       <div class="col-sm-3">
       		<label>Frequenza mesi</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="freq_mesi_mod" min="1" max="2999" step="1" name="freq_mesi_mod" style="width:100%" required>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data messa in servizio</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_messa_in_servizio'>
               <input type='text' class="form-control input-small" id="data_messa_in_servizio_mod" name="data_messa_in_servizio_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Ultima Verifica</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_ultima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_ultima_verifica_mod" name="data_ultima_verifica_mod" >
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
       		<div class='input-group date datepicker' id='datepicker_data_prossima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica_mod" name="data_prossima_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c1_mod" name="portata_min_c1_mod" style="-webkit-appearance:none;margin:0;" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c1_mod" name="portata_max_c1_mod" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c1_mod" name="div_ver_c1_mod" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c1_mod" name="div_rel_c1_mod" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c1_mod" name="numero_div_c1_mod" >
       	</div>
       </div> <br> 
       <div id="multipla_mod">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c2_mod" name="portata_min_c2_mod" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c2_mod" name="portata_max_c2_mod" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c2_mod" name="div_ver_c2_mod" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c2_mod" name="div_rel_c2_mod" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c2_mod" name="numero_div_c2_mod" >
       	</div>
       </div> <br> 
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c3_mod" name="portata_min_c3_mod" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c3_mod" name="portata_max_c3_mod" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c3_mod" name="div_ver_c3_mod" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c3_mod" name="div_rel_c3_mod" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c3_mod" name="numero_div_c3_mod" >
       	</div>
       </div> <br> 
       

       
        </div>
        
        
               
               <div class="row">
       	<div class="col-sm-3">
       		<label>Obsoleto</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-contol select2" id="obsoleto_mod" name="obsoleto_mod" >
       		<option value="1">SI</option>
       		<option value="0">NO</option>
       		</select>
       	</div>
       </div> <br> 
        
       </div>

  		 
      <div class="modal-footer">
<label id="label_matricola_mod" style="display:none;color:red" class="pull-left">Attenzione! La matricola inserita è già esistente!</label>

		<input type="hidden" id="id_strumento" name="id_strumento">
		<button class="btn btn-primary" type="submit" id="save_btn_mod">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>
 --%>



<div id="myModalDettaglioVerStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Strumento</h4>
      </div>
       <div class="modal-body">
<div class="row">
       	<div class="col-sm-3">
       		<label>Famiglia Strumento</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Famiglia Strumento..." id="famiglia_strumento_dtl" name="famiglia_strumento_dtl" style="width:100%" disabled>
       		<option value=""></option>
       			<c:forEach items="${lista_famiglie_strumento}" var="famiglia" varStatus="loop">
       				<option value="${famiglia.id}">${famiglia.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo..." id="tipo_ver_strumento_dtl" name="tipo_ver_strumento_dtl" style="width:100%" disabled>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_strumento}" var="tipo" varStatus="loop">
       				<option value="${tipo.id}">${tipo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Tipologia</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipologia..." id="tipologia_dtl" name="tipologia_dtl" style="width:100%" disabled>
       		<option value=""></option>
       			<c:forEach items="${lista_tipologie_strumento}" var="tipologia" varStatus="loop">
       				<option value="${tipologia.id}">${tipologia.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="denominazione_dtl" name="denominazione_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="costruttore_dtl" name="costruttore_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="modello_dtl" name="modello_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_dtl" name="matricola_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="classe_dtl" min="1" max="6" name="classe_dtl" style="width:100%" disabled>       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Unità di misura</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Unità di Misura..." id="um_dtl" name="um_dtl" style="width:100%" disabled>
       		<option value="kg">kg</option>
       		<option value="g">g</option>
       		
       		</select>
       	</div>
       </div><br> 
       <div class="row">
       <div class="col-sm-3">
       		<label>Anno marcatura CE</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="anno_marcatura_ce_dtl" min="1900" max="2999" step="1" name="anno_marcatura_ce_dtl" style="width:100%" disabled>
       	</div>
       </div><br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza mesi</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="freq_mesi_dtl" min="1900" max="2999" step="1" name="freq_mesi_dtl" style="width:100%" disabled>
        
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data messa in servizio</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date ' id='datepicker_data_messa_in_servizio'>
               <input type='text' class="form-control input-small" id="data_messa_in_servizio_dtl" name="data_messa_in_servizio_dtl" disabled>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Ultima Verifica</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date ' id='datepicker_data_ultima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_ultima_verifica_dtl" name="data_ultima_verifica_dtl" disabled>
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
       		<div class='input-group date ' id='datepicker_data_prossima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica_dtl" name="data_prossima_verifica_dtl" disabled>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c1_dtl" name="portata_min_c1_dtl" style="-webkit-appearance:none;margin:0;" disabled>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c1_dtl" name="portata_max_c1_dtl" disabled>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c1_dtl" name="div_ver_c1_dtl" disabled>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c1_dtl" name="div_rel_c1_dtl" disabled>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c1_dtl" name="numero_div_c1_dtl" disabled>
       	</div>
       </div> <br> 
       <div id="multipla_dtl">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c2_dtl" name="portata_min_c2_dtl" disabled>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c2_dtl" name="portata_max_c2_dtl" disabled>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c2_dtl" name="div_ver_c2_dtl" disabled>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c2_dtl" name="div_rel_c2_dtl" disabled>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c2_dtl" name="numero_div_c2_dtl" disabled>
       	</div>
       </div> <br> 
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c3_dtl" name="portata_min_c3_dtl" disabled>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c3_dtl" name="portata_max_c3_dtl" disabled>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c3_dtl" name="div_ver_c3_dtl" disabled>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c3_dtl" name="div_rel_c3_dtl" disabled>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c3_dtl" name="numero_div_c3_dtl" disabled>
       	</div>
       </div> <br> 


        </div>
        
        

        <div class="row">
       	<div class="col-sm-3">
       		<label>Obsoleto</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-contol select2" id="obsoleto_dtl" name="obsoleto_dtl" disabled>
       		<option value="1">SI</option>
       		<option value="0" selected>NO</option>
       		</select>
       	</div>
       </div> <br>
        
                <div class="row">
       	<div class="col-sm-6">
       		<label>Provvedimenti di Legalizzazione</label>
       	</div>
       	<div class="col-sm-12">
       		<table id="table_legalizzazione_strumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipo provvedimento</th>
<th>Numero provvedimento</th>
<th>Data provvedimento</th>

<th>Azioni</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
       	</div>
       </div> <br> 
        
       </div>

    </div>
  </div>

</div>


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
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
  </div>
  </div>
</div>


 <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 9900;">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati provvedimento legalizzazione bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">

 

       <div id="tab_allegati_provvedimento"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_provvedimento_allegato" name="id_provvedimento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
      </div>
   
  </div>
  </div>
</div>


  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" style="z-index: 9999;">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_allegato_elimina">
      <a class="btn btn-primary" onclick="eliminaAllegatoLegalizzazione($('#id_allegato_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="myModalAssociaLegalizzazione" class="modal modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Associazione Legalizzazione Bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
      <table id="table_legalizzazione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th style="max-width:15px"></th>
<th>ID</th>
<th>Descrizione Strumento</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Classe</th>
<th>Tipo approvazione</th>
<th>Tipo provvedimento</th>
<th>Numero provvedimento</th>
<th>Data provvedimento</th>
<th>Rev.</th>
<th>Azioni</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      
      <input type="hidden" id="id_strumento_legalizzazione" name="id_strumento_legalizzazione">
      <a class="btn btn-primary" onClick="associaStrumentoLegalizzazione(false)" id="button_salva">Salva</a>
      <a class="btn btn-primary" style="display:none" onClick="associaStrumentoLegalizzazione(true)" id="button_associa">Salva</a>
       <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalAssociaLegalizzazione').modal('hide')">Chiudi</a>
      </div>
   
  </div>
  </div>
</div>



 <style>
 input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}



.vertical-text {
  border-right: 1px solid #ddd !important;
  writing-mode: vertical-rl;
  transform: rotate(180deg);
  text-align: center;
  vertical-align: middle;
  padding: 5px;
  font-weight: bold;
  white-space: nowrap;
  font-size: 20px;
}
</style>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script>



<script type="text/javascript">


function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}






function modalNuovaScadenza(){
	

	$('#myModalNuovaScadenza').modal();
	
}

function modalAggiungiAttivita(){
	

	$('#myModalNuovaAttivita').modal();
	
}




var columsDatatables = [];





$(document).ready(function() {

	console.log("test");
    $('.dropdown-toggle').dropdown();
   
   

     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

    
     
     $('#id_cliente').val($('#cliente').val());
     $('#id_sede').val($('#sede').val());
    
   var table = $('#tabAttivita').DataTable({
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
	        order: [[1, "desc"]],
	        paging: false,
	        ordering: true,
	        info: true,
	        searchable: false,
	        targets: 0,
	        responsive: true,
	        scrollX: false,
	        stateSave: true,
	        select: {
	            style: 'multi+shift',
	            selector: 'td:nth-child(1)'
	        },
	        columnDefs: [
	            { responsivePriority: 1, targets: 1 },
	            { className: "select-checkbox", targets: 0, orderable: false }
	        ]	     
			        
	  	    
		               
		    });
		
 		table.buttons().container().appendTo( '#tabScadenzario_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAttivita').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});  
	
	
	
	
	
	
});


$('#modificaVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaVerStrumento();
});



$('#nuovaAttivitaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjax("#nuovaAttivitaForm", "amScGestioneScadenzario.do?action=nuova_attivita")
});






</script>