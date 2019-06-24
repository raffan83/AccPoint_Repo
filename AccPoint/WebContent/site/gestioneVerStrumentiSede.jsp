<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<div class="row">
<div class="col-sm-12">
<a class="btn btn-primary" onClick="modalNuovoStrumento()"><i class="fa fa-plus"></i>Nuovo strumento</a>
</div>
</div><br>

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
<th>Data ultima verifica</th>
<th>Data prossima verifica</th>
<td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${loop.index}" >
	<td>${strumento.id }</td>	
	<td>${strumento.denominazione }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.modello }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.classe }</td>
	<td>${strumento.tipo.descrizione }</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_ultima_verifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_prossima_verifica }" /></td>
	<td><a class="btn btn-warning" onClick="modalModificaVerStrumento('${strumento.id }','${strumento.id_cliente }','${strumento.id_sede }','${strumento.denominazione }','${strumento.costruttore }',
	'${strumento.modello }','${strumento.matricola }','${strumento.classe }','${strumento.tipo.id }','${strumento.data_ultima_verifica }',
	'${strumento.data_prossima_verifica }','${strumento.um }','${strumento.portata_min_C1 }','${strumento.portata_max_C1 }','${strumento.div_ver_C1 }','${strumento.div_rel_C1 }','${strumento.numero_div_C1 }',
	'${strumento.portata_min_C2 }','${strumento.portata_max_C2 }','${strumento.div_ver_C2 }','${strumento.div_rel_C2 }','${strumento.numero_div_C2 }',
	'${strumento.portata_min_C3 }','${strumento.portata_max_C3 }','${strumento.div_ver_C3 }','${strumento.div_rel_C3 }','${strumento.numero_div_C3 }')"><i class="fa fa-edit"></i></a></td>
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
       		<select class="form-control select2" data-placeholder="Seleziona Unità di Misura..." id="um" name="um" style="width:100%" required>
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
               <input type='text' class="form-control input-small" id="data_ultima_verifica" name="data_ultima_verifica" required>
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
               <input type='text' class="form-control input-small" id="data_prossima_verifica" name="data_prossima_verifica" required>
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
       		<input type="number" step="any" class="form-control"  id="portata_min_c1" name="portata_min_c1" required>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_max_c1" name="portata_max_c1" required>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_ver_c1" name="div_ver_c1" required>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_rel_c1" name="div_rel_c1" required>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="numero_div_c1" name="numero_div_c1" required>
       	</div>
       </div> <br> 
       <div id="multipla">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_min_c2" name="portata_min_c2" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_max_c2" name="portata_max_c2" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_ver_c2" name="div_ver_c2" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_rel_c2" name="div_rel_c2" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="numero_div_c2" name="numero_div_c2" >
       	</div>
       </div> <br> 
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_min_c3" name="portata_min_c3" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_max_c3" name="portata_max_c3" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_ver_c3" name="div_ver_c3" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_rel_c3" name="div_rel_c3" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="numero_div_c3" name="numero_div_c3" >
       	</div>
       </div> <br> 
        </div>
       </div>

  		 
      <div class="modal-footer">
      <!-- <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label> -->

		<input type="hidden" id="id_cliente" name="id_cliente">
		<input type="hidden" id="id_sede" name="id_sede">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
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
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Strumento</h4>
      </div>
       <div class="modal-body">

         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente_mod" name="cliente_mod" style="width:100%" required>
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
       		<input class="form-control" id="costruttore_mod" name="costruttore_mod" style="width:100%">       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="modello_mod" name="modello_mod" style="width:100%">       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_mod" name="matricola_mod" style="width:100%">       	
       	</div>
       </div><br>
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" id="classe_mod" min="1" max="4" name="classe_mod" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Unità di misura</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Unità di Misura..." id="um_mod" name="um_mod" style="width:100%" required>
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
       		<div class='input-group date datepicker' id='datepicker_data_ultima_verifica_mod'>
               <input type='text' class="form-control input-small" id="data_ultima_verifica_mod" name="data_ultima_verifica_mod" required>
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
               <input type='text' class="form-control input-small" id="data_prossima_verifica_mod" name="data_prossima_verifica_mod" required>
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
       		<input type="number" step="any" class="form-control"  id="portata_min_c1_mod" name="portata_min_c1_mod" style="-webkit-appearance:none;margin:0;" required>
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_max_c1_mod" name="portata_max_c1_mod" required>
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_ver_c1_mod" name="div_ver_c1_mod" required>
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_rel_c1_mod" name="div_rel_c1_mod" required>
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C1</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="numero_div_c1_mod" name="numero_div_c1_mod" required>
       	</div>
       </div> <br> 
       <div id="multipla_mod">
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_min_c2_mod" name="portata_min_c2_mod" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_max_c2_mod" name="portata_max_c2_mod" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_ver_c2_mod" name="div_ver_c2_mod" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_rel_c2_mod" name="div_rel_c2_mod" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C2</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="numero_div_c2_mod" name="numero_div_c2_mod" >
       	</div>
       </div> <br> 
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Min C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_min_c3_mod" name="portata_min_c3_mod" >
       	</div>
       </div> <br>    
       <div class="row">
       	<div class="col-sm-3">
       		<label>Portata Max C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="portata_max_c3_mod" name="portata_max_c3_mod" >
       	</div>
       </div> <br>   
        <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione di verifica C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_ver_c3_mod" name="div_ver_c3_mod" >
       	</div>
       </div> <br> 
       <div class="row">
       	<div class="col-sm-3">
       		<label>Divisione reale C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="div_rel_c3_mod" name="div_rel_c3_mod" >
       	</div>
       </div> <br> 
        <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Divisioni C3</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" step="any" class="form-control"  id="numero_div_c3_mod" name="numero_div_c3_mod" >
       	</div>
       </div> <br> 
        </div>
       </div>

  		 
      <div class="modal-footer">
      <!-- <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label> -->

		<input type="hidden" id="id_strumento" name="id_strumento">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>

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


function modalModificaVerStrumento(id_strumento, id_cliente, id_sede, denominazione, costruttore, modello, matricola, classe, id_tipo, data_ultima_verifica,
		data_prossima_verifica, um, portata_min_c1, portata_max_c1, div_ver_c1, div_rel_c1, numero_div_c1,
		portata_min_c2, portata_max_c2, div_ver_c2, div_rel_c2, numero_div_c2, portata_min_c3, portata_max_c3, div_ver_c3, div_rel_c3, numero_div_c3){
	
	$('#multipla_mod').hide();
	$('#cliente_mod').val(id_cliente);
	$('#cliente_mod').change();
	
	if(id_sede!='0'){
		$('#sede_mod').val(id_sede + "_" + id_cliente);	
	}else{
		$('#sede_mod').val(0);
	}
	$('#sede_mod').change();
	$('#id_strumento').val(id_strumento);
	$('#denominazione_mod').val(denominazione);
	$('#costruttore_mod').val(costruttore);
	$('#modello_mod').val(modello);
	$('#matricola_mod').val(matricola);
	$('#classe_mod').val(classe);
	$('#tipo_ver_strumento_mod').val(id_tipo);
	$('#tipo_ver_strumento_mod').change();
	$('#um_mod').val(um);
	$('#um_mod').change();
	if(data_ultima_verifica!=null && data_ultima_verifica!=""){
		  $('#data_ultima_verifica_mod').val(Date.parse(data_ultima_verifica).toString("dd/MM/yyyy"));
	  }
	if(data_prossima_verifica!=null && data_prossima_verifica!=""){
		  $('#data_prossima_verifica_mod').val(Date.parse(data_prossima_verifica).toString("dd/MM/yyyy"));
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

function modalNuovoStrumento(){
	
	$('#multipla').hide();
	$('#myModalNuovoStrumento').modal();
	
}

$('#tipo_ver_strumento').change(function(){
	if($(this).val()==1){
		$('#multipla').hide();		
		$('#portata_min_c2').attr("required", false);
		$('#portata_max_c2').attr("required", false);		
		$('#div_ver_c2').attr("required", false);
		$('#div_rel_c2').attr("required", false);
		$('#numero_div_c2').attr("required", false);
		$('#portata_min_c3').attr("required", false);
		$('#portata_max_c3').attr("required", false);		
		$('#div_ver_c3').attr("required", false);
		$('#div_rel_c3').attr("required", false);
		$('#numero_div_c3').attr("required", false);
		
	}else{
		$('#multipla').show();
		$('#portata_min_c2').attr("required", true);
		$('#portata_max_c2').attr("required", true);		
		$('#div_ver_c2').attr("required", true);
		$('#div_rel_c2').attr("required", true);
		$('#numero_div_c2').attr("required", true);
		$('#portata_min_c3').attr("required", true);
		$('#portata_max_c3').attr("required", true);		
		$('#div_ver_c3').attr("required", true);
		$('#div_rel_c3').attr("required", true);
		$('#numero_div_c3').attr("required", true);
	}
});


$('#tipo_ver_strumento_mod').change(function(){
	if($(this).val()==1){
		$('#multipla_mod').hide();		
		$('#portata_min_c2_mod').attr("required", false);
		$('#portata_max_c2_mod').attr("required", false);		
		$('#div_ver_c2_mod').attr("required", false);
		$('#div_rel_c2_mod').attr("required", false);
		$('#numero_div_c2_mod').attr("required", false);
		$('#portata_min_c3_mod').attr("required", false);
		$('#portata_max_c3_mod').attr("required", false);		
		$('#div_ver_c3_mod').attr("required", false);
		$('#div_rel_c3_mod').attr("required", false);
		$('#numero_div_c3_mod').attr("required", false);
		
	}else{
		$('#multipla_mod').show();
		$('#portata_min_c2_mod').attr("required", true);
		$('#portata_max_c2_mod').attr("required", true);		
		$('#div_ver_c2_mod').attr("required", true);
		$('#div_rel_c2_mod').attr("required", true);
		$('#numero_div_c2_mod').attr("required", true);
		$('#portata_min_c3_mod').attr("required", true);
		$('#portata_max_c3_mod').attr("required", true);		
		$('#div_ver_c3_mod').attr("required", true);
		$('#div_rel_c3_mod').attr("required", true);
		$('#numero_div_c3_mod').attr("required", true);
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


$(document).ready(function() {

	console.log("test");
    $('.dropdown-toggle').dropdown();
    $('.select2').select2();
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
		    	  { responsivePriority: 2, targets: 9 }
		    	  
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


$('#modificaVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaVerStrumento();
});



$('#nuovoVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoVerStrumento();
});

$("#cliente_mod").change(function() {
	  
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

</script>