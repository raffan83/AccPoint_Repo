<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="row">
<div class="col-sm-12">

 <table id="tabStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Cliente</th>
<th>Sede</th>
<th>Denominazione</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Matricola</th>
<th>Classe</th>
<th>Tipo</th>
<th>Tipologia</th>
<th>Portata max</th>
<th>Data ultima verifica</th>
<th>Data prossima verifica</th>
<th>Ultimo verificatore</th>
<td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${strumento.id }" >
	<td>${strumento.id }</td>	
	<td>${strumento.nome_cliente }</td>
	<td>${strumento.nome_sede }</td>
	<td>${strumento.denominazione }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.modello }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.classe }</td>
	<td>${strumento.tipo.descrizione }</td>
	<td>${strumento.tipologia.descrizione }</td>		
	<td>
	<c:if test="${(strumento.portata_max_C2 == null && strumento.portata_max_C3 == null) || (strumento.portata_max_C1 > strumento.portata_max_C3 && strumento.portata_max_C1 > strumento.portata_max_C2)}">
	
	${strumento.portata_max_C1 }
	</c:if>
	<c:if test="${strumento.tipo.id!=1 }">
	<c:if test="${strumento.portata_max_C3 == null || (strumento.portata_max_C2 >  strumento.portata_max_C3 && strumento.portata_max_C2 >  strumento.portata_max_C1)}">
	${strumento.portata_max_C2} 
	</c:if>
	<c:if test="${strumento.portata_max_C2 == null || (strumento.portata_max_C3 >=  strumento.portata_max_C2 && strumento.portata_max_C3 >=  strumento.portata_max_C1)}">
	${strumento.portata_max_C3} 
	</c:if>
	
	</c:if>
	
	</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_ultima_verifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_prossima_verifica }" /></td>
	<td>${strumento.ultimo_verificatore }</td>
	<td style="min-width:130px">
	<a class="btn btn-info" onClick="modalDettaglioVerStrumento('${strumento.famiglia_strumento.id }','${strumento.freqMesi }','${strumento.denominazione }','${strumento.costruttore }','${strumento.modello }','${strumento.matricola }',
	'${strumento.classe }','${strumento.tipo.id }','${strumento.data_ultima_verifica }','${strumento.data_prossima_verifica }','${strumento.um }','${strumento.portata_min_C1 }',
	'${strumento.portata_max_C1 }','${strumento.div_ver_C1 }','${strumento.div_rel_C1 }','${strumento.numero_div_C1 }',	'${strumento.portata_min_C2 }','${strumento.portata_max_C2 }',
	'${strumento.div_ver_C2 }','${strumento.div_rel_C2 }','${strumento.numero_div_C2 }','${strumento.portata_min_C3 }','${strumento.portata_max_C3 }','${strumento.div_ver_C3 }',
	'${strumento.div_rel_C3 }','${strumento.numero_div_C3 }','${strumento.anno_marcatura_ce }','${strumento.data_messa_in_servizio }','${strumento.tipologia.id }')"><i class="fa fa-search"></i></a>
	
	<%-- <a class="btn btn-warning" onClick="modalModificaVerStrumento('${strumento.id }','${strumento.freqMesi }','${strumento.famiglia_strumento.id }','${strumento.id_cliente }','${strumento.id_sede }','${strumento.denominazione }','${strumento.costruttore }',
	'${strumento.modello }','${strumento.matricola }','${strumento.classe }','${strumento.tipo.id }','${strumento.data_ultima_verifica }',
	'${strumento.data_prossima_verifica }','${strumento.um }','${strumento.portata_min_C1 }','${strumento.portata_max_C1 }','${strumento.div_ver_C1 }','${strumento.div_rel_C1 }','${strumento.numero_div_C1 }',
	'${strumento.portata_min_C2 }','${strumento.portata_max_C2 }','${strumento.div_ver_C2 }','${strumento.div_rel_C2 }','${strumento.numero_div_C2 }',
	'${strumento.portata_min_C3 }','${strumento.portata_max_C3 }','${strumento.div_ver_C3 }','${strumento.div_rel_C3 }','${strumento.numero_div_C3 }','${strumento.anno_marcatura_ce }','${strumento.data_messa_in_servizio }','${strumento.tipologia.id }')"><i class="fa fa-edit"></i></a> --%>
	
	<a href="#" class="btn btn-primary customTooltip" title="Click per visualizzare gli allegati" onclick="modalAllegati('${strumento.id }')"><i class="fa fa-archive"></i></a>
	</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>




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
       		<option value="Kg">Kg</option>
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


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>

 <script type="text/javascript" src="plugins/datejs/date.js"></script>
 <script type="text/javascript">
  

  function modalAllegati(id_strumento){
  	 
  	 $('#tab_archivio').html("");
  	 
  	 dataString ="action=allegati&id_strumento="+ id_strumento;
     exploreModal("gestioneVerStrumenti.do",dataString,"#tab_allegati",function(datab,textStatusb){
     });
  $('#myModalAllegati').modal();
  }


  $('#myModalAllegati').on('hidden.bs.modal',function(){
  	
  	$(document.body).css('padding-right', '0px');
  });

 

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
    	
	$('.select2').select2();
        $('.dropdown-toggle').dropdown();
        
        $('.datepicker').datepicker({
   		 format: "dd/mm/yyyy"
   	 }); 
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
		    	  { responsivePriority: 2, targets: 12 },
		    	  { responsivePriority: 2, targets: 10 },
		    	  { responsivePriority: 2, targets: 11 }
		    	  
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
        
    });




  </script>