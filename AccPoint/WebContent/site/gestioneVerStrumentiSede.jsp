<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="row">
<div class="col-sm-12">
<a class="btn btn-primary" onClick="modalNuovoStrumento()"><i class="fa fa-plus"></i> Nuovo strumento</a>
</div>
</div><br>

<!-- 
       	<div class="col-sm-9">       	
       		<input class="form-control" data-placeholder="Seleziona Cliente..." id="test" name="test" style="width:100%" >
       		 <input id="test" style="width:100%;" placeholder="type a number, scroll for more results" /> 	
       	</div>  -->

<div class="row">
<div class="col-sm-12">

 <table id="tabStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Denominazione</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Matricola</th>
<th>Classe</th>
<th>Tipo</th>
<th>Tipologia</th>
<th>Data ultima verifica</th>
<th>Data prossima verifica</th>
<td style="min-width:145px">Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${strumento.id }" >
	<td>${strumento.id }</td>	
	<td>${strumento.denominazione }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.modello }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.classe }</td>
	<td>${strumento.tipo.descrizione }</td>
	<td>${strumento.tipologia.descrizione }</td>		
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_ultima_verifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_prossima_verifica }" /></td>
	<td style="min-width:130px">
	<a class="btn btn-info" onClick="modalDettaglioVerStrumento('${strumento.famiglia_strumento.id }','${strumento.freqMesi }','${utl:escapeJS(strumento.denominazione) }','${utl:escapeJS(strumento.costruttore) }','${utl:escapeJS(strumento.modello) }','${strumento.matricola }',
	'${strumento.classe }','${strumento.tipo.id }','${strumento.data_ultima_verifica }','${strumento.data_prossima_verifica }','${strumento.um }','${strumento.portata_min_C1 }',
	'${strumento.portata_max_C1 }','${strumento.div_ver_C1 }','${strumento.div_rel_C1 }','${strumento.numero_div_C1 }',	'${strumento.portata_min_C2 }','${strumento.portata_max_C2 }',
	'${strumento.div_ver_C2 }','${strumento.div_rel_C2 }','${strumento.numero_div_C2 }','${strumento.portata_min_C3 }','${strumento.portata_max_C3 }','${strumento.div_ver_C3 }',
	'${strumento.div_rel_C3 }','${strumento.numero_div_C3 }','${strumento.anno_marcatura_ce }','${strumento.data_messa_in_servizio }','${strumento.tipologia.id }')"><i class="fa fa-search"></i></a>
	
	<a class="btn btn-warning" onClick="modalModificaVerStrumento('${strumento.id }','${strumento.freqMesi }','${strumento.famiglia_strumento.id }','${strumento.id_cliente }','${strumento.id_sede }','${utl:escapeJS(strumento.denominazione) }','${utl:escapeJS(strumento.costruttore) }',
	'${utl:escapeJS(strumento.modello) }','${strumento.matricola }','${strumento.classe }','${strumento.tipo.id }','${strumento.data_ultima_verifica }',
	'${strumento.data_prossima_verifica }','${strumento.um }','${strumento.portata_min_C1 }','${strumento.portata_max_C1 }','${strumento.div_ver_C1 }','${strumento.div_rel_C1 }','${strumento.numero_div_C1 }',
	'${strumento.portata_min_C2 }','${strumento.portata_max_C2 }','${strumento.div_ver_C2 }','${strumento.div_rel_C2 }','${strumento.numero_div_C2 }',
	'${strumento.portata_min_C3 }','${strumento.portata_max_C3 }','${strumento.div_ver_C3 }','${strumento.div_rel_C3 }','${strumento.numero_div_C3 }','${strumento.anno_marcatura_ce }','${strumento.data_messa_in_servizio }','${strumento.tipologia.id }')"><i class="fa fa-edit"></i></a>
	
	<a class="btn btn-primary customTooltip customLink" title="Associa a provvedimento di legalizzazione bilance" onClick="modalAssociaProvvedimento('${strumento.id}')"><i class="fa fa-plus"></i></a>
	<a href="#" class="btn btn-primary customTooltip customLink" title="Click per visualizzare gli allegati" onclick="modalAllegati('${strumento.id }')"><i class="fa fa-archive"></i></a>
	</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>


<form id="nuovoVerStrumentoForm" name="nuovoStrumentoForm">
<div id="myModalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Strumento</h4>
      </div>
       <div class="modal-body">

        <%-- <div class="row">
       
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
       </div><br> --%>
      <%--   <div class="row">
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
       </div><br> --%>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Famiglia Strumento</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Famiglia Strumento..." id="famiglia_strumento" name="famiglia_strumento" style="width:100%" required>
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
       		<select class="form-control select2" data-placeholder="Seleziona Tipo..." id="tipo_ver_strumento" name="tipo_ver_strumento" style="width:100%" required>
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
       		<select class="form-control select2" data-placeholder="Seleziona Tipologia..." id="tipologia" name="tipologia" style="width:100%" required>
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
       		<input class="form-control" id="denominazione" name="denominazione" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="costruttore" name="costruttore" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="modello" name="modello" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola" name="matricola" style="width:100%" required>       	
       	</div>
       </div><br>
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">
       	<select class="form-control select2" data-placeholder="Seleziona Classe..." id="classe" name="classe" style="width:100%" required>
       		<option value=1>1</option>
       		<option value=2>2</option>
       		<option value=3>3</option>
       		<option value=4>4</option>
       		
       		</select>
       		<!-- <input type="number" class="form-control" id="classe" min="1" max="4" name="classe" style="width:100%" required> -->       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Unità di misura</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Unità di Misura..." id="um" name="um" style="width:100%" required>
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
       		<input type="number" class="form-control" id="anno_marcatura_ce" min="1900" max="2999" step="1" name="anno_marcatura_ce" style="width:100%" required>
       	</div>
       </div><br> 
       <div class="row">
       <div class="col-sm-3">
       		<label>Frequenza mesi</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="freq_mesi" min="1" max="2999" step="1" name="freq_mesi" value=12 style="width:100%" required>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data messa in servizio</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_messa_in_servizio'>
               <input type='text' class="form-control input-small" id="data_messa_in_servizio" name="data_messa_in_servizio" required>
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
       		<div class='input-group date datepicker' id='datepicker_data_ultima_verifica'>
               <input type='text' class="form-control input-small" id="data_ultima_verifica" name="data_ultima_verifica" >
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
               <input type='text' class="form-control input-small" id="data_prossima_verifica" name="data_prossima_verifica" >
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
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c1" name="portata_min_c1" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c1" name="portata_max_c1" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c1" name="div_ver_c1" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c1" name="div_rel_c1" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c1" name="numero_div_c1" >
       	</div>
       </div> <br> 
       <div id="multipla">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c2" name="portata_min_c2" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any"  min="0" class="form-control"  id="portata_max_c2" name="portata_max_c2" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c2" name="div_ver_c2" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c2" name="div_rel_c2" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c2" name="numero_div_c2" >
       	</div>
       </div> <br> 
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_min_c3" name="portata_min_c3" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="portata_max_c3" name="portata_max_c3" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_ver_c3" name="div_ver_c3" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="div_rel_c3" name="div_rel_c3" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" min="0" class="form-control"  id="numero_div_c3" name="numero_div_c3" >
       	</div>
       </div> <br> 
       
        </div>
        
         <div class="row">
       <div class="col-sm-4">
      
        <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload_str" type="file" name="files[]" multiple>
		       
		   	 </span>

       </div>
       		   	 <div class="col-sm-8">
		   	 <label id="label_file"></label>
       </div>
       </div>
       
        
       </div>

  		 
      <div class="modal-footer">
      <label id="label_matricola" style="display:none;color:red" class="pull-left">Attenzione! La matricola inserita è già esistente!</label>
	
		<input type="hidden" id="id_cliente" name="id_cliente">
		<input type="hidden" id="id_sede" name="id_sede">
		<button class="btn btn-primary" type="submit" id="save_btn">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



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
       	 <%-- <div class="col-sm-9" style="display:none">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente_appoggio" name="cliente_appoggio" style="display:none">
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>       	
       	</div>    --%>  
       	
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
       		<option value=1>1</option>
       		<option value=2>2</option>
       		<option value=3>3</option>
       		<option value=4>4</option>
       		
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
       		<input type="number" class="form-control" id="classe_dtl" min="1" max="4" name="classe_dtl" style="width:100%" disabled>       	
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

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      
      <input type="hidden" id="id_strumento_legalizzazione" name="id_strumento_legalizzazione">
      <a class="btn btn-primary" onClick="associaStrumentoLegalizzazione()">Salva</a>
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


function modalAssociaProvvedimento(id_strumento){
	
$('#id_strumento_legalizzazione').val(id_strumento);
	
	dataString ="action=strumento_legalizzazione_bilance&id_strumento="+id_strumento;
    exploreModal("gestioneVerLegalizzazioneBilance.do",dataString,null,function(datab,textStatusb){
  	  	
  	  var result = datab;
  	  
  	  if(result.success){  		  
  		 
  		  var table_data = [];
  		  
  		  var lista_provvedimenti = result.lista_provvedimenti;
  		  var lista_provvedimenti_associati = result.lista_provvedimenti_associati;
  		  
  		  for(var i = 0; i<lista_provvedimenti.length;i++){
  			  var dati = {};
  			  dati.empty = '<td></td>';
  			  dati.check = '<td></td>';
  			  dati.id = lista_provvedimenti[i].id;
  			  dati.descrizione_strumento = lista_provvedimenti[i].descrizione_strumento;
  			  dati.costruttore = lista_provvedimenti[i].costruttore;
  			  dati.modello = lista_provvedimenti[i].modello;
  			  dati.classe = lista_provvedimenti[i].classe;
  			  dati.tipo_approvazione = lista_provvedimenti[i].tipo_approvazione.descrizione;
  			  dati.tipo_provvedimento = lista_provvedimenti[i].tipo_provvedimento.descrizione;
  			  dati.numero_provvedimento = lista_provvedimenti[i].numero_provvedimento;
  			  dati.data_provvedimento =  formatDate(moment(lista_provvedimenti[i].data_provvedimento, "DD, MMM YY"));
  			  dati.rev = lista_provvedimenti[i].rev;  			 
  			 
  			  
  			  table_data.push(dati);
  			
  		  }
  		  var table = $('#table_legalizzazione').DataTable();
  		  
   		   table.clear().draw();
   		   
   			table.rows.add(table_data).draw();
   			
   			table.columns.adjust().draw();
 			
   			$('#table_legalizzazione tr').each(function(){
   				var val  = $(this).find('td:eq(2)').text();
   				$(this).attr("id", val)
   			});
   			controllaAssociati(table,lista_provvedimenti_associati );
 		  $('#myModalAssociaLegalizzazione').modal();
 			
  	  }
  	  
  	  $('#myModalAssociaLegalizzazione').on('shown.bs.modal', function () {
  		  var table = $('#table_legalizzazione').DataTable();
  			table.columns.adjust().draw();
  			
  		})
  	  
    });
	  
	
}


function associaStrumentoLegalizzazione(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  var table = $('#table_legalizzazione').DataTable();
		var dataSelected = table.rows( { selected: true } ).data();
		var selezionati = "";
		for(i=0; i< dataSelected.length; i++){
			dataSelected[i];
			selezionati = selezionati +dataSelected[i].id+";";
		}
		console.log(selezionati);
		table.rows().deselect();
		associaProvvedimentiVerStrumento(selezionati, $('#id_strumento_legalizzazione').val());
		
	}

function controllaAssociati(table, lista_provvedimenti_associati){
	
	//var dataSelected = table.rows( { selected: true } ).data();
	var data = table.rows().data();
	for(var i = 0;i<lista_provvedimenti_associati.length;i++){
	
		table.row( "#"+lista_provvedimenti_associati[i].id ).select();
			
		}
		
		
	
}


$('#fileupload_str').change(function(){
	
	var files = $("#fileupload_str")[0].files;
	var str ="";

	for (var i = 0; i < files.length; i++)
	{
	 str = str+files[i].name+"<br>";
	}
	$('#label_file').html(str);
});


function modalAllegati(id_strumento){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=allegati&id_strumento="+ id_strumento;
   exploreModal("gestioneVerStrumenti.do",dataString,"#tab_allegati",function(datab,textStatusb){
	   $('#myModalAllegati').modal();	   
	   
   });

}


$('#myModalAllegati').on('hidden.bs.modal',function(){
	
	$(document.body).css('padding-right', '0px');
});

function modalModificaVerStrumento(id_strumento, freq_mesi, famiglia_strumento, id_cliente, id_sede, denominazione, costruttore, modello, matricola, classe, id_tipo, data_ultima_verifica,
		data_prossima_verifica, um, portata_min_c1, portata_max_c1, div_ver_c1, div_rel_c1, numero_div_c1,
		portata_min_c2, portata_max_c2, div_ver_c2, div_rel_c2, numero_div_c2, portata_min_c3, portata_max_c3, div_ver_c3, div_rel_c3, numero_div_c3, anno_marcatura_ce, data_messa_in_servizio,tipologia){
	
	
	$('#multipla_mod').hide();
	$('#cliente_mod').val(id_cliente);	
	$('#cliente_mod').change();
	initSelect2('#cliente_mod');
	
	
	$('#sede_mod').select2();
	$('#classe_mod').select2();
	if(id_sede!='0'){
		$('#sede_mod').val(id_sede + "_" + id_cliente);	
	}else{
		$('#sede_mod').val(0);
	}
	$('#sede_mod').change();
	$('#id_strumento').val(id_strumento);
	$('#freq_mesi_mod').val(freq_mesi);
	$('#denominazione_mod').val(denominazione);
	$('#costruttore_mod').val(costruttore);
	$('#modello_mod').val(modello);
	$('#matricola_mod').val(matricola);
	$('#classe_mod').val(classe);
	$('#anno_marcatura_ce_mod').val(anno_marcatura_ce);
	$('#data_messa_in_servizio_mod').val(data_messa_in_servizio);
	$('#tipo_ver_strumento_mod').val(id_tipo);
	$('#tipo_ver_strumento_mod').change();
	$('#tipologia_mod').val(tipologia);
	$('#tipologia_mod').change();
	$('#um_mod').val(um);
	$('#famiglia_strumento_mod').val(famiglia_strumento);
	$('#famiglia_strumento_mod').change();
	$('#um_mod').change();
	if(data_ultima_verifica!=null && data_ultima_verifica!=""){
		  $('#data_ultima_verifica_mod').val(Date.parse(data_ultima_verifica).toString("dd/MM/yyyy"));
	  }
	if(data_prossima_verifica!=null && data_prossima_verifica!=""){
		  $('#data_prossima_verifica_mod').val(Date.parse(data_prossima_verifica).toString("dd/MM/yyyy"));
	  }
	if(data_messa_in_servizio!=null && data_messa_in_servizio!=""){
		  $('#data_messa_in_servizio_mod').val(Date.parse(data_messa_in_servizio).toString("dd/MM/yyyy"));
	  }

	$('#portata_min_c1_mod').val(portata_min_c1);
	$('#portata_max_c1_mod').val(portata_max_c1);
	$('#div_ver_c1_mod').val(div_ver_c1);
	$('#div_rel_c1_mod').val(div_rel_c1);
	$('#numero_div_c1_mod').val(numero_div_c1);
	
	if(id_tipo!='1'){
		$('#multipla_mod').show();
		$('#portata_min_c2_mod').val(portata_min_c2);
		$('#portata_max_c2_mod').val(portata_max_c2);
		$('#div_ver_c2_mod').val(div_ver_c2);
		$('#div_rel_c2_mod').val(div_rel_c2);
		$('#numero_div_c2_mod').val(numero_div_c2);
		$('#portata_min_c3_mod').val(portata_min_c3);
		$('#portata_max_c3_mod').val(portata_max_c3);
		$('#div_ver_c3_mod').val(div_ver_c3);
		$('#div_rel_c3_mod').val(div_rel_c3);
		$('#numero_div_c3_mod').val(numero_div_c3);
	}
	
	
	
	$('#myModalModificaVerStrumento').modal();
	
}



function modalDettaglioVerStrumento(famiglia_strumento, freq_mesi, denominazione, costruttore, modello, matricola, classe, id_tipo, data_ultima_verifica,
		data_prossima_verifica, um, portata_min_c1, portata_max_c1, div_ver_c1, div_rel_c1, numero_div_c1,
		portata_min_c2, portata_max_c2, div_ver_c2, div_rel_c2, numero_div_c2, portata_min_c3, portata_max_c3, div_ver_c3, div_rel_c3, numero_div_c3, anno_marcatura_ce, data_messa_in_servizio,tipologia){
	
	$('#multipla_dtl').hide();
	$('#denominazione_dtl').val(denominazione);
	$('#freq_mesi_dtl').val(freq_mesi);
	$('#costruttore_dtl').val(costruttore);
	$('#modello_dtl').val(modello);
	$('#matricola_dtl').val(matricola);
	$('#classe_dtl').val(classe);
	$('#anno_marcatura_ce_dtl').val(anno_marcatura_ce);
	$('#data_messa_in_servizio_dtl').val(data_messa_in_servizio);
	$('#tipo_ver_strumento_dtl').val(id_tipo);
	$('#tipo_ver_strumento_dtl').change();
	$('#tipologia_dtl').val(tipologia);
	$('#tipologia_dtl').change();
	$('#um_dtl').val(um);
	$('#um_dtl').change();
	$('#famiglia_strumento_dtl').val(famiglia_strumento);
	$('#famiglia_strumento_dtl').change();
	if(data_ultima_verifica!=null && data_ultima_verifica!=""){
		  $('#data_ultima_verifica_dtl').val(Date.parse(data_ultima_verifica).toString("dd/MM/yyyy"));
	  }
	if(data_prossima_verifica!=null && data_prossima_verifica!=""){
		  $('#data_prossima_verifica_dtl').val(Date.parse(data_prossima_verifica).toString("dd/MM/yyyy"));
	  }
	if(data_messa_in_servizio!=null && data_messa_in_servizio!=""){
		  $('#data_messa_in_servizio_dtl').val(Date.parse(data_messa_in_servizio).toString("dd/MM/yyyy"));
	  }

	$('#portata_min_c1_dtl').val(portata_min_c1);
	$('#portata_max_c1_dtl').val(portata_max_c1);
	$('#div_ver_c1_dtl').val(div_ver_c1);
	$('#div_rel_c1_dtl').val(div_rel_c1);
	$('#numero_div_c1_dtl').val(numero_div_c1);
	
	if(id_tipo!='1'){
		$('#multipla_dtl').show();
		$('#portata_min_c2_dtl').val(portata_min_c2);
		$('#portata_max_c2_dtl').val(portata_max_c2);
		$('#div_ver_c2_dtl').val(div_ver_c2);
		$('#div_rel_c2_dtl').val(div_rel_c2);
		$('#numero_div_c2_dtl').val(numero_div_c2);
		$('#portata_min_c3_dtl').val(portata_min_c3);
		$('#portata_max_c3_dtl').val(portata_max_c3);
		$('#div_ver_c3_dtl').val(div_ver_c3);
		$('#div_rel_c3_dtl').val(div_rel_c3);
		$('#numero_div_c3_dtl').val(numero_div_c3);
	}
		
	$('#myModalDettaglioVerStrumento').modal();
}


function modalNuovoStrumento(){
	
	$('#multipla').hide();
	$('#myModalNuovoStrumento').modal();
	
}

$('#tipo_ver_strumento').change(function(){
	if($(this).val()==1){
		$('#multipla').hide();		
/* 		$('#portata_min_c2').attr("required", false);
		$('#portata_max_c2').attr("required", false);		
		$('#div_ver_c2').attr("required", false);
		$('#div_rel_c2').attr("required", false);
		$('#numero_div_c2').attr("required", false);
		$('#portata_min_c3').attr("required", false);
		$('#portata_max_c3').attr("required", false);		
		$('#div_ver_c3').attr("required", false);
		$('#div_rel_c3').attr("required", false);
		$('#numero_div_c3').attr("required", false); */
		
	}else{
		$('#multipla').show();
/* 		$('#portata_min_c2').attr("required", true);
		$('#portata_max_c2').attr("required", true);		
		$('#div_ver_c2').attr("required", true);
		$('#div_rel_c2').attr("required", true);
		$('#numero_div_c2').attr("required", true);
		$('#portata_min_c3').attr("required", true);
		$('#portata_max_c3').attr("required", true);		
		$('#div_ver_c3').attr("required", true);
		$('#div_rel_c3').attr("required", true);
		$('#numero_div_c3').attr("required", true); */
	}
});


$('#tipo_ver_strumento_mod').change(function(){
	if($(this).val()==1){
		$('#multipla_mod').hide();		
/* 		$('#portata_min_c2_mod').attr("required", false);
		$('#portata_max_c2_mod').attr("required", false);		
		$('#div_ver_c2_mod').attr("required", false);
		$('#div_rel_c2_mod').attr("required", false);
		$('#numero_div_c2_mod').attr("required", false);
		$('#portata_min_c3_mod').attr("required", false);
		$('#portata_max_c3_mod').attr("required", false);		
		$('#div_ver_c3_mod').attr("required", false);
		$('#div_rel_c3_mod').attr("required", false);
		$('#numero_div_c3_mod').attr("required", false); */
		
	}else{
		$('#multipla_mod').show();
/* 		$('#portata_min_c2_mod').attr("required", true);
		$('#portata_max_c2_mod').attr("required", true);		
		$('#div_ver_c2_mod').attr("required", true);
		$('#div_rel_c2_mod').attr("required", true);
		$('#numero_div_c2_mod').attr("required", true);
		$('#portata_min_c3_mod').attr("required", true);
		$('#portata_max_c3_mod').attr("required", true);		
		$('#div_ver_c3_mod').attr("required", true);
		$('#div_rel_c3_mod').attr("required", true);
		$('#numero_div_c3_mod').attr("required", true); */
	}
});


$('#classe').change(function(){

	var val = $(this).val();
	
	if(val<=0){
		$(this).val(1);
	}else if(val >4){
		$(this).val(4);
	}
	
});


$('#classe_mod').change(function(){

	var val = $(this).val();
	
	if(val<=0){
		$(this).val(1);
	}else if(val >4){
		$(this).val(4);
	}
	
});

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

var columsDatatables1 = [];

$("#table_legalizzazione").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    		columsDatatables1 = state.columns;
    }
    $('#table_legalizzazione thead th').each( function () {
     	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
    	  var title = $('#table_legalizzazione thead th').eq( $(this).index() ).text();
    	
    	  if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
	    	}

    	} );
    
    

} );



$('#matricola').change(function(){
	$('#matricola').css('border', '1px solid #d2d6de');
	$('#label_matricola').hide();
	$('#save_btn').attr('disabled', false);
	 $('#tabStrumenti tbody tr').each(function(){		 
			 var td = $(this).find('td').eq(4);
			if(td!=null && td[0].innerText== $('#matricola').val()){
				$('#matricola').css('border', '1px solid #f00');
				$('#label_matricola').show();
				$('#save_btn').attr('disabled', true);
			}
	 });
});


$('#matricola_mod').change(function(){
	$('#matricola_mod').css('border', '1px solid #d2d6de');
	$('#label_matricola_mod').hide();
	$('#save_btn_mod').attr('disabled', false);
	
	var id = $('#id_strumento').val();
	 $('#tabStrumenti tbody tr').each(function(){		 
			 var td = $(this).find('td').eq(4);
			 var id_row = $(this)[0].id;
			if(td!=null && td[0].innerText== $('#matricola_mod').val() && id_row != 'row_'+$('#id_strumento').val()){
				$('#matricola_mod').css('border', '1px solid #f00');
				$('#label_matricola_mod').show();
				$('#save_btn_mod').attr('disabled', true);
			}
	 });
});

$(document).ready(function() {

	console.log("test");
    $('.dropdown-toggle').dropdown();
    $('#famiglia_strumento').select2();
    $('#tipo_ver_strumento').select2();
    $('#tipologia').select2();
    $('#um').select2();
    $('#famiglia_strumento_mod').select2();
    $('#tipo_ver_strumento_mod').select2();
    $('#tipologia_mod').select2();
    $('#um_mod').select2();
    $('#classe').select2();
   

     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

    
     
     $('#id_cliente').val($('#cliente').val());
     $('#id_sede').val($('#sede').val());
    
   var table = $('#tabStrumenti').DataTable({
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

		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 10 }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  },
	 			 {
	 	                extend: 'excel',
	 	                text: 'Esporta Excel',
	 	                 exportOptions: {
	 	                    modifier: {
	 	                        page: 'current'
	 	                    }
	 	                } 
	 	            }
	 			  ]
		               
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
	
	
	
	
	
	tab = $('#table_legalizzazione').DataTable({
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
        "order": [[ 2, "desc" ]],
	      paging: false, 
	      ordering: true,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,  
	      scrollX: false,
	      stateSave: true,	
	      select: {
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	},
	      columns : [
	    	  {"data" : "empty"},  
	    	{"data" : "check"},  
	      	{"data" : "id"},
	      	{"data" : "descrizione_strumento"},
	      	{"data" : "costruttore"},
	      	{"data" : "modello"},
	      	{"data" : "classe"},
	      	{"data" : "tipo_approvazione"},
	      	{"data" : "tipo_provvedimento"},
	      	{"data" : "numero_provvedimento"},
	      	{"data" : "data_provvedimento"},
	      	{"data" : "rev"}
	       ],	
	           
	      columnDefs: [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  { responsivePriority: 2, targets: 9 },
	    	  
	    	  { className: "select-checkbox", targets: 1,  orderable: false }
	    	  ],
	    	  
	     	          
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	tab.buttons().container().appendTo( '#table_legalizzazione_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	     tab.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
      tab
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  

	
	
});


$('#modificaVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaVerStrumento();
});



$('#nuovoVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoVerStrumento();
});

$('#myModalAssociaLegalizzazione').on('hidden.bs.modal', function(){
	
	$(document.body).css('padding-right', '0px');
});

$("#cliente_mod").on('change',function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_mod option').clone());
	  }
	
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_mod").prop("disabled", false);
	 
	  $('#sede_mod').html(opt);
	  
	  $("#sede_mod").trigger("chosen:updated");
	  

		$("#sede_mod").change();  
		
		  var id_cliente = selection.split("_")[0];
		  

		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			   if(str!='' && str.split("_")[1]==id)
				{
					opt.push(options[i]);
				}   
		   } 

	});
	
	
var options =  $('#cliente_appoggio option').clone();
function mockData() {
	  return _.map(options, function(i) {		  
	    return {
	      id: i.value,
	      text: i.text,
	    };
	  });
	}
	


function initSelect2(id_input) {

	$(id_input).select2({
	    data: mockData(),
	    placeholder: 'search',
	    multiple: false,
	    // query with pagination
	    query: function(q) {
	      var pageSize,
	        results,
	        that = this;
	      pageSize = 20; // or whatever pagesize
	      results = [];
	      if (q.term && q.term !== '') {
	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
	        results = _.filter(x, function(e) {
	        	
	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
	        });
	      } else if (q.term === '') {
	        results = that.data;
	      }
	      q.callback({
	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
	        more: results.length >= q.page * pageSize,
	      });
	    },
	  });
	
	
}


</script>