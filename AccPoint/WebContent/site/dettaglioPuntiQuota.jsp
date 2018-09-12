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
 	<td>${utl:changeDotComma(quota.tolleranza_negativa.toPlainString())}</td>
 	<td>${utl:changeDotComma(quota.tolleranza_positiva.toPlainString())}</td>
 	<td>${quota.coordinata }</td>
 	<td>${quota.simbolo.descrizione }</td>
 	<td>${utl:changeDotComma(quota.val_nominale.toPlainString())}</td> 	
 	<td>${quota.quota_funzionale.descrizione }</td>
 	<td>${quota.um }</td>
 	
 	<c:forEach items="${quota.listaPuntiQuota}" var="punto" varStatus="loop">		
		<td>${utl:changeDotComma(punto.valore_punto.toPlainString())}</td>
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
	</c:forEach>

	
 </tbody>
 </table>

      <div id="hot" class="handsontable" style="width:100%; height: 300px; overflow: auto" ></div>
    

	<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script>  
	<link rel="stylesheet" type="text/css" href="css/handsontable.css" />
	
  	<script type="text/javascript">

  
	var columsDatatables = [];
	 


	 function creaInputPezzo(n_pezzi){
		 var html="";
		 for(var i = 0;i<n_pezzi;i++){		 
			html = html+ '<div class="col-xs-1"><label>Pezzo '+(i+1)+'</label><input name="pezzo_'+(i+1)+'" id="pezzo_'+(i+1)+'" type="text" class="form-control" style="width:100%"></div>';
		 }
		 $('#pezzo_row').html(html);
	 }
	
  $(document).ready(function(){

	var numero_pezzi= "${numero_pezzi}";
	  if(numero_pezzi!=null && numero_pezzi!=""){
	 	creaInputPezzo(numero_pezzi);
	 } 
	  console.log("test");

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
	
	  var container = document.getElementById('hot');
	  var selectedRow;
	  var current_row;
	  var hot = new Handsontable(container, {
	    data: data,
	    rowHeaders: false,	  
	    filters: true,
	    dropdownMenu: true,	
	    currentRowClassName: 'currentRow',
	   // autoWrapRow: true,
	    manualColumnResize: true,
 		manualRowResize: true,
	   // contextMenu: true,
	    outsideClickDeselects: false,
	    stretchH: "all",
	    colHeaders: data_table[0],	    
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
	        			opt.push($(this).val().split("_")[1]);
	        		  }
					}); 
	        	   return{
	        		  editor: 'select',
	        	      selectOptions: opt
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
	    		for(var j = 8; j<cols; j++){	    			
	    				var val_corrente = parseFloat(this.getDataAtCell(i, j).replace(',','.'))
	    				var val_nominale = parseFloat(this.getDataAtCell(i, 5).replace(',','.'))
	    				var tolleranza_pos = parseFloat(this.getDataAtCell(i, 2).replace(',','.'))
	    				var tolleranza_neg = parseFloat(this.getDataAtCell(i, 1).replace(',','.'))
	    				var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
	    				if(value){	    	
	    					//$(this.getCellMeta(i, j)).removeClass('error');
	    					this.getCellMeta(i, j).renderer = defaultRenderer;	    					  					
	    				}else{
	    					//$(this.getCellMeta(i, j)).addClass('hoterror');
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
			    			//hot.render();	
		    			}else{		    				
		    				hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
			    			//hot.render();
		    			}
	    			}else{
	    				hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
	    				//hot.render();	
	    			}
	    			hot.render();
	    			send = true;
	    		}
	    	}
	    	if(col_change == 4){
	    		var data_cell = this.getDataAtCell(row_change, col_change);
	    		if(data_cell=="intersezione"){
	    			this.setDataAtCell(row_change, 7, "°"); 
	     	   	  }
	    		else{
	    			this.setDataAtCell(row_change, 7, "mm"); 
	    		}
	    	}
	    	if(col_change==this.countCols()-1){
	    		send=true;
	    	}

	    	if(send){		
	    	var dataObj = {};

			var data = this.getDataAtRow(row_change);
			if(data[0]!=null){
			dataObj.particolare = $('#particolare').val();
			dataObj.data = JSON.stringify( data);
			 $('#simbolo option').each(function() {
	       		  if($(this).val()!=""){
	       			if(data[4] == $(this).val().split("_")[1]){
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
				      if (res.result === 'ok') {
				    	 
				      }
				      else {
				       
				      }
				    },
				    error: function () {
				 
				    }
				  });
	    	}
	    	}
	    }

	      
	  });
	
	  hot.addHook('afterSelection', function(row,column){
	  selectedRow = hot.getDataAtRow(row);
	  $(this).addClass('currentRow');
		  $('#val_nominale').val(selectedRow[5]);
		  $('#tolleranza_neg').val(selectedRow[1]);
		  $('#tolleranza_pos').val(selectedRow[2]);
		  $('#coordinata').val(selectedRow[3]);
	     
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
					if(optionValues[i].split("_")[1]==selectedRow[4]){
						$('#simbolo').val(optionValues[i]);
						$('#simbolo').change();
					}
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
		        }	       	  
				$('#id_quota').val(selectedRow[0]);
				$('#mod_button').removeClass('disabled');				

	});  
	  
	  

	  
  });  
	
	
	
function calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg){
	
	var conforme = true;
	if(isNaN(val_corrente)){
		return true;
	}
		var x = val_nominale + tolleranza_pos;
		var y = val_nominale - Math.abs(tolleranza_neg);
	if(val_corrente <=(val_nominale + Math.abs(tolleranza_pos)) && val_corrente >=(val_nominale - Math.abs(tolleranza_neg))){
		confrome = true;
	}else{
		conforme = false;
	}
	return conforme;
	
}

	
  
 </script>
			
			 