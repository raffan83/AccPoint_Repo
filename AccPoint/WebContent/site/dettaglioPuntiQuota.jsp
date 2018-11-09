<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
    
<!-- <table id="tabPuntiQuota" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">   -->
 <table id="tabPuntiQuota" class="table table-bordered table-hover table-striped" style="display:none" role="grid" width="100%">  
 <thead><tr class="active">
 	<th>Quota</th>
	<th>Tolleranza -</th>
	<th>Tolleranza +</th>
	<th>Coordinata</th>
	<th>Simbolo</th>
	<th>Valore Nominale</th>
	<th>Quota Funzionale</th>
	<th>U.M.</th>
 	<c:if test="${lista_quote.size()>0}">
 	<c:forEach items="${listaPuntiQuota}" varStatus="loop">
		<th>Pezzo ${loop.index +1}</th>
	</c:forEach>
	</c:if> 
	<th>Note</th>
 </tr>
 
 </thead>
 
 <tbody>
 
 <c:forEach items="${lista_quote}" var="quota" varStatus="loop">
 <tr id="riga_${loop.index}">

 	<td>${quota.id }</td>
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.tolleranza_negativa.toPlainString()))}</td> 	
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.tolleranza_positiva.toPlainString()))}</td>
 	<td>${quota.coordinata }</td>
 	<td>${quota.simbolo.descrizione }</td> 
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.val_nominale.toPlainString()))}</td> 	
 	<td>${quota.quota_funzionale.descrizione }</td>
 	<td>${quota.um }</td>
 	
 	<c:forEach items="${quota.listaPuntiQuota}" var="punto" varStatus="loop">		
		<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,punto.valore_punto.toPlainString()))}</td>
	</c:forEach> 
	<c:if test="${quota.listaPuntiQuota.size()<listaPuntiQuota.size()}">
	<c:forEach items="${listaPuntiQuota}" var="p" varStatus="loop">		
		<c:choose>
		<c:when test="${loop.index<quota.listaPuntiQuota.size()}">
		</c:when>
		<c:otherwise>
		<td></td>
		</c:otherwise>
		</c:choose>
		
	</c:forEach> 
	</c:if>

	<td>${quota.note }</td>
	</tr>
	</c:forEach>

	
 </tbody>
 </table>

<div class="row">
<div class="col-xs-12">
</div>
</div><br>


 <form id="myModalXMLForm" name="myModalXMLForm"> 
   <div id="myModalXML" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Importa da XML</h4>
      </div>
       <div class="modal-body">       
      	<div id="pezzi_xml"></div>

  		 </div>
      <div class="modal-footer">
		<a class="btn btn-primary" onclick="importaDaXML('${id_impronta}', '${numero_pezzi}')" >Salva</a>
      </div>
    </div>
  </div>

</div>
   </form>


 <div id="myModalModificaParticolare" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Particolare</h4>
      </div>
       <div class="modal-body">
		<c:if test="${isImpronta==true }">
		<div class="row">
			<div class = "col-xs-3">
				<label>Nome Impronta</label>
			</div>
			<div class = "col-xs-9">		
				<input type="text"  class="form-control" id="nome_impronta_mod" name="nome_impronta_mod" style="width:100%" value="${particolare.nome_impronta}">
			</div>
		</div><br>		
		</c:if>
		<div class="row">
			<div class = "col-xs-3">
		<label>Numero Pezzi</label>
			</div>
			<div class = "col-xs-9">
				<input type="number" min="1"  class="form-control" id="n_pezzi_mod" name="n_pezzi_mod" style="width:100%" value="${numero_pezzi}">
			</div>
		</div><br>
  		<div class="row">
			<div class = "col-xs-3">
  		 <label>Note Particolare</label>
  		 	</div>
  		 	<div class = "col-xs-9">
  		 <textarea rows="3" style="width:100%" id="note_particolare_mod" name="note_particolare_mod">${particolare.note }</textarea>
  		 </div>
  		  </div>
      <div class="modal-footer">
      	<label id="label_errore_modifica" style="color:red;display:none">Attenzione! Inserisci un nome valido!</label>
		<a class="btn btn-primary"  onClick="validateModificaParticolare()">Salva</a>
      </div>
    </div>
  </div>
</div>
</div>





      <div id="hot" class="handsontable" style="width:100%; height: 300px; overflow: auto" ></div>
    
<input type="hidden" id="isImpronta" value="${isImpronta }">
	<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script>  
	<link rel="stylesheet" type="text/css" href="css/handsontable.css" />
	
  	<script type="text/javascript">

  	
	var columsDatatables = [];
	 
	 function modalModificaParticolare(){
		 $('#myModalModificaParticolare').modal();
	 }

	 function modificaParticolare(){
		 var id_particolare = '${id_impronta}';
		 var nome_impronta_mod = $('#nome_impronta_mod').val();
		 var n_pezzi_mod = $('#n_pezzi_mod').val();
		 var note_particolare_mod = $('#note_particolare_mod').val();

		 salvaModificaParticolare(id_particolare, nome_impronta_mod, n_pezzi_mod, note_particolare_mod);	 
	 }

	 
	 function validateModificaParticolare(){
		 var esito=true;
		 
		 if($('#nome_impronta_mod').val()==""){
			 $('#nome_impronta_mod').css('border', '1px solid #f00');
			 esito=false;
		 }else{
			 $('#nome_impronta_mod').css('border', '1px solid #d2d6de');
		 }
		 
		 if(esito){
			 $('#label_errore_modifica').hide();			 		
			 $('#nome_impronta_mod').css('border', '1px solid #d2d6de');					 
			 modificaParticolare();
		 }else{
			 $('#label_errore_modifica').show();
		 }
	 }
	 
	 
 	 function creaInputPezzo(n_pezzi){
		 var html='';
		 for(var i = 0;i<n_pezzi;i++){		 
			html = html+ '<div class="col-xs-1"><label>Pezzo '+(i+1)+'</label><input name="pezzo_'+(i+1)+'" id="pezzo_'+(i+1)+'" type="text" class="form-control" style="width:100%"></div>'; 
		 }
		 $('#pezzo_row').html(html);
	 }


	 function creaModalXML(n_pezzi){
		 var html="";
		 for(var i = 0;i<n_pezzi;i++){		 
			html = html+ '<div class="row"><div class="col-xs-3"><label>Pezzo '+(i+1)+'</label></div><div class="col-xs-9"><input class="form-control" type="file" accept=".xml, .XML" id="file_pezzo_'+(i+1)+'" name="file_pezzo_'+(i+1)+'" style="width:100%"></div></div><br>';
			//html = html + '<div class="row"><div class="col-xs-3"><label>Pezzo '+(i+1)+'</label></div><div class="col-xs-6"><span class="btn btn-primary fileinput-button"> <i class="glyphicon glyphicon-plus"></i> <span>Seleziona un file...</span><input class="form-control" type="file" accept=".xml, .XML" id="file_pezzo_'+(i+1)+'" name="file_pezzo_'+(i+1)+'" style="width:100%"></span></div><div class="col-xs-3"><label id=label_pezzo_'+(i+1)+'></label></div></div><br>';
		 }
		 $('#pezzi_xml').html(html);
	 }
	 

	 function modalXML(){
		 var numero_pezzi= "${numero_pezzi}";
		 if(numero_pezzi!=null && numero_pezzi!=""){
			 creaModalXML(numero_pezzi);
			 } 
		 
		 $('#myModalXML').modal();
		 
	 }
	 
	 
  $(document).ready(function(){
	  
	var numero_pezzi= "${numero_pezzi}";
	  if(numero_pezzi!=null && numero_pezzi!=""){
	 	creaInputPezzo(numero_pezzi);
	 } 
	  console.log("test");

	  $('#note_part').val("${particolare.note}");
	  $('#xml_button').removeClass('disabled');
	var data_table  = $('#tabPuntiQuota tr').map(function(tr){
		return [$(this).children().map(function(td){			
			return $(this).text();}).get()]
	}).get()
	  var data = [];
	for(var i=1; i<data_table.length;i++){
		data.push(data_table[i]);
	}

	
	  function errorRenderer(instance, td, row, col, prop, value, cellProperties) {
		    Handsontable.renderers.TextRenderer.apply(this, arguments);
		    td.style.fontWeight = 'bold';
		    td.style.color = 'black';
		    td.style.background = '#ff8080';
		  }
	  function defaultRenderer(instance, td, row, col, prop, value, cellProperties) {
		    Handsontable.renderers.TextRenderer.apply(this, arguments);		    
		    td.style.fontWeight = 'normal';
		    td.style.color = 'black';		
			if($(td).hasClass('currentRow')){
				 td.style.background = '##ADD8E6';
		    }else{
		    	 td.style.background = '#ffffff';
		    }
		  }
	  function defaultSelectedRenderer(instance, td, row, col, prop, value, cellProperties) {
		    Handsontable.renderers.TextRenderer.apply(this, arguments);
		    td.style.fontWeight = 'normal';
		    td.style.color = 'black';		
		    td.style.background = '#ADD8E6';		    
		  }
	 function imageRenderer(instance, td, row, col, prop, value, cellProperties) {
			Handsontable.renderers.cellDecorator.apply(this, arguments);
			if(value!=""){
				Handsontable.dom.fastInnerHTML(td, '<img class="img" src=./images/simboli_rilievi/' + value + '.bmp style="height:20px">');
			}
		  } 
	
	  var container = document.getElementById('hot');
	  var selectedRow;
	  var current_row;
	  var hot = new Handsontable(container, {
	    data: data,
	    rowHeaders: false,	  
	    filters: true,
	    dropdownMenu: true,	
	    currentRowClassName: 'currentRow',
	    manualColumnResize: true,
 		manualRowResize: true,
	    outsideClickDeselects: false,
	    stretchH: "all",
	    colHeaders: data_table[0],	   
	   // fixedColumnsLeft: 8,
	   	maxCols: data_table[0].length,
	    cells: function(row,col){
	          if(col == 0){
	              return {
	                  readOnly: true
	              };   
	          }
 	          else if(col == 4){	
 	        	      var opt =[];
	        	   $('#simbolo option').each(function() {
	        		  if($(this).val()!=""){
	        			  if($(this).val().split("_")[0]<10){
	        				  var filename = $(this).val().substring(2, $(this).val().length);
	        			  }else{
	        				  var filename = $(this).val().substring(3, $(this).val().length);
	        			  }	  
	        			opt.push(filename);
	        		  }
					});  
	        	   return{
	        		 editor: 'select',	        		 
	        	     selectOptions: opt,
	        	  } 
	          } 
	          else if (col == 6){
	        	  var opt = [];
	        			  $('#quota_funzionale option').each(function() {
	    	        		  if($(this).val()!=""){
	    	        			opt.push($(this).val().split("_")[1]);
	    	        		  }
	    					}); 
	        	  return{
	        		  editor: 'select',
	        	      selectOptions: opt
	        	  }
	          }	          
	      },
	    afterInit: function(){
	    	var rows = this.countRows();
	    	var cols = this.countCols();
	    	
	    	for(var i = 0; i<rows;i++ ){
	    		if(this.getDataAtCell(i, 4)!=""){
	    			this.getCellMeta(i, 4).renderer = imageRenderer;	
	    		}else{
	    			this.getCellMeta(i, 4).renderer = defaultRenderer;
	    		}
	    				    		
	    		for(var j = 8; j<cols; j++){	    			
	    				var val_corrente = parseFloat(this.getDataAtCell(i, j).replace(',','.'))
	    				var val_nominale = parseFloat(this.getDataAtCell(i, 5).replace(',','.'))
	    				var tolleranza_pos = parseFloat(this.getDataAtCell(i, 2).replace(',','.'))
	    				var tolleranza_neg = parseFloat(this.getDataAtCell(i, 1).replace(',','.'))
	    				var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
	    				if(value){	    		    					
	    					this.getCellMeta(i, j).renderer = defaultRenderer;	    					  					
	    				}else{
	    					this.getCellMeta(i, j).renderer = errorRenderer;	    					
	    				}
	    		}
	    	}
	    	this.render();
	    	
	    },
	    afterChange: function (change, source) {
	    	var send = true;
	    	
	    	if(change!=null){
	    		var row_change = change[0][0];
	    		var col_change = change[0][1];
	    	}	    
	    	
	    	if((col_change > 7 && col_change!=(this.countCols()-1)) || col_change == 1 || col_change == 2 || col_change == 5){
	    		var data_cell = this.getDataAtCell(row_change, col_change).replace(",", ".");
	    		if(isNaN(data_cell)){
	    			hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
	    			hot.render();
	    			send = false;
	    		}
	    		else{	  
	    			if( col_change>7){
	    				var val_corrente = parseFloat(data_cell);
	    				var val_nominale = parseFloat(this.getDataAtCell(row_change, 5).replace(',','.'))
	    				var tolleranza_pos = parseFloat(this.getDataAtCell(row_change, 2).replace(',','.'))
	    				var tolleranza_neg = parseFloat(this.getDataAtCell(row_change, 1).replace(',','.'))
	    				var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
	    				if(value){	 	    					
	    					hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
		    			}else{		    				
		    				hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
		    			}
 	    			}
	    			else if(col_change == 1 || col_change == 2 || col_change == 5){
	    				var cols = this.countCols();
	    	    		for(var j = 8; j<cols; j++){	    			
		    				var val_corrente = parseFloat(this.getDataAtCell(row_change, j).replace(',','.'))
		    				var val_nominale = parseFloat(this.getDataAtCell(row_change, 5).replace(',','.'))
		    				var tolleranza_pos = parseFloat(this.getDataAtCell(row_change, 2).replace(',','.'))
		    				var tolleranza_neg = parseFloat(this.getDataAtCell(row_change, 1).replace(',','.'))
		    				var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
		    				if(value){	    		    					
		    					this.getCellMeta(row_change, j).renderer = defaultRenderer;	    					  					
		    				}else{
		    					this.getCellMeta(row_change, j).renderer = errorRenderer;	    					
		    				}
		    			}
	    	    		hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
	    			}
	    			else{
	    				hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;	    			
	    			}  
	    			hot.render();
	    			send = true;
	    		}
	    	}
	    	if(col_change == 4){
	    		var data_cell = this.getDataAtCell(row_change, col_change);
	    		if(data_cell=="ANGOLO"){
	    			this.setDataAtCell(row_change, 7, "°"); 
	     	   	  }
	    		else{
	    			this.setDataAtCell(row_change, 7, "mm"); 
	    		}
	    		
	    			hot.getCellMeta(row_change, col_change).renderer = imageRenderer;	
	    			hot.render();
	    	}
	    	if(col_change==this.countCols()-1){
	    		send=true;
	    	}

	    	if(send){		
		    	var dataObj = {};	
				var data = this.getDataAtRow(row_change);
				
				if(data[0]!=null){
					dataObj.particolare = $('#particolare').val();
					dataObj.data = JSON.stringify(data);
					$('#simbolo option').each(function() {
		      		 	 if($(this).val()!=""){	
		      				if($(this).val().split("_")[0]<10){
		  				 		var simbolo = $(this).val().substring(2, $(this).val().length);
		  			 		}else{
		  				 		var simbolo = $(this).val().substring(3, $(this).val().length);
		  			  	 	}
		      				if(data[4] == simbolo){
		      					dataObj.simbolo = $(this).val();
		      			 	}	       			
		      		  	}
					 });   
					 $('#quota_funzionale option').each(function() {
			       		  if($(this).val()!=""){
			       			if(data[6] == $(this).val().split("_")[1]){
			       				dataObj.quota_funzionale = $(this).val();
			       			}
			       		  }
					}); 
				 
					var url = "";
					if($('#applica_tutti').prop('checked')){
						url = "gestioneRilievi.do?action=update_celle"
					}else{
						url = "gestioneRilievi.do?action=update_celle_replica"
					}
				  $.ajax({
					    url: url,
					    data: dataObj, //returns all cells' data
					    dataType: 'json',
					    type: 'POST',
					    success: function (res) {
					    
					    },
					    error: function () {
					 
					    }
					});
		    	}
	    	}
	    },
		  afterSelection: function(row,column){
			  selectedRow = hot.getDataAtRow(row);
			  $(this).addClass('currentRow');
				  $('#val_nominale').val(selectedRow[5]);
				  $('#tolleranza_neg').val(selectedRow[1]);
				  $('#tolleranza_pos').val(selectedRow[2]);
				  $('#coordinata').val(selectedRow[3]);				 				
				  $('#note_quota').val(selectedRow[(selectedRow.length-1)]);
			        var n_pezzi = ${numero_pezzi};
			        var j = 8;
			        for(var i = 0; i<n_pezzi;i++){
			        	 $('#pezzo_'+(i+1)).val(selectedRow[j]);
			        	 j++;
			        }
			        var optionValues = [];
			        $('#simbolo option').each(function() {
					    optionValues.push($(this).val());
					});
			       
					for(var i = 0; i<optionValues.length;i++){
						if(optionValues[i]!=''){							        		
			        			  if(optionValues[i].split("_")[0]<10){
			        				  if(optionValues[i].substring(2, optionValues[i].length) == selectedRow[4]){
			        				  	$('#simbolo').val(optionValues[i]);
										$('#simbolo').change();	 
			        				  }
			        			  }else{
			        				  if(optionValues[i].substring(3, optionValues[i].length) == selectedRow[4]){
				        				  	$('#simbolo').val(optionValues[i]);
											$('#simbolo').change();	 
				        				  }			        			  
			        			  }	  
						}else{
							$('#simbolo').val(optionValues[i]);
							$('#simbolo').change();	
						}
			        }
				     var optionValues2 = [];

						$('#quota_funzionale option').each(function() {
						    optionValues2.push($(this).val());
						});
						for(var i = 0; i<optionValues2.length;i++){
							if(optionValues2[i]!=''){
								if(optionValues2[i].split("_")[1]==selectedRow[6]){
									$('#quota_funzionale').val(optionValues2[i]);
									$('#quota_funzionale').change();
								}
							}
							if(optionValues2[i]=='0_nessuna'){
								$('#quota_funzionale').val('0_nessuna');
								$('#quota_funzionale').change();
							}
				        }	       	  
						$('#id_quota').val(selectedRow[0]);
						$('#mod_button').removeClass('disabled');				
						$('#elimina_button').removeClass('disabled');	
		  } 	
	  });
	  
  });  
	

  $('#pleaseWaitDialog').on('hidden.bs.modal', function(){
		$(document.body).css('padding-right', '0px');	
	});

  
function calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg){
	
	var conforme = true;
	if(isNaN(val_corrente)){
		return true;
	}
	if(val_corrente <=(val_nominale + Math.abs(tolleranza_pos)) && val_corrente >=(val_nominale - Math.abs(tolleranza_neg))){
		confrome = true;
	}else{
		conforme = false;
	}
	return conforme;
	
}

	
	


	
  
 </script>
			
			 