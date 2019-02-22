<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> --%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
    
    <div class="row">
    <div class="col-xs-12">
    <c:choose>  

    <c:when test="${lista_quote.size()>0}">
	    <c:choose>
	    <c:when test="${userObj.checkRuolo('AM') || userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
	    <c:if test="${rilievo.stato_rilievo.id==2 }">
	     <a class="btn btn-danger pull-right " onClick="esportaQuotePDF()"> Esporta PDF</a>
	     </c:if>
	    <a class="btn btn-primary pull-right " onClick="modalSicuro()" style="margin-right:5px"> Svuota</a>
	    </c:when>
	    <c:otherwise>
	    <c:if test="${rilievo.stato_rilievo.id==2 }">
	     <a class="btn btn-danger pull-right " onClick="esportaQuotePDF()"> Esporta PDF</a>
	     </c:if>
	    <a class="btn btn-primary pull-right disabled" onClick="modalSicuro()" style="margin-right:5px"> Svuota</a> 
	    </c:otherwise>
	    </c:choose>     
    </c:when>
    <c:otherwise>
   <c:if test="${rilievo.stato_rilievo.id==2 }">
    <a class="btn btn-danger pull-right disabled" onClick="esportaQuotePDF()"> Esporta PDF</a>
    </c:if>
    <a class="btn btn-primary pull-right disabled" onClick="modalSicuro()" style="margin-right:5px"> Svuota</a>
    </c:otherwise>
     </c:choose>
     <c:choose>
    <c:when test="${filtro_delta==true }">
   <div id="button_tabella"><a class="btn btn-primary pull-right" style="margin-right:5px" onClick="nascondiTabellaDelta()"> Nascondi Tabella Delta</a></div>
    </c:when>
    <c:otherwise>    
     <div id="button_tabella"><a class="btn btn-primary pull-right" style="margin-right:5px" onClick="mostraTabellaDelta()"> Mostra Tabella Delta</a></div>
    </c:otherwise>
    </c:choose>
    
    <a class="btn btn-primary pull-left "  onClick="filtraNonConformi('${id_impronta}')"> Filtra Non Conformi</a>
    <a class="btn btn-primary pull-left " style="margin-left:5px"  onClick="resetFiltro('${id_impronta}')"> Reset Filtro</a>

</div><br><br>

    <div class="row">
    <div class="col-xs-12">
    
     <div class="col-xs-2 pull-right">
     <c:choose>
     <c:when test="${filtro_delta==true }">     
     <select id="select_delta" name="select_delta" class="form-contol select2" aria-hidden="true" data-placeholder="Filtra &#x0394" data-live-search="true" style="width:100%;">
     <c:forEach items = "${delta_options }" var = "opt" varStatus="loop">
     <c:choose>
     <c:when test="${opt == '0' }">
     <option value="${opt}">Tutti</option>
     </c:when>
     <c:when test="${opt == delta}">
      <option value="${opt }" selected>${opt }</option>
     </c:when>
     <c:otherwise>
     <option value="${opt }">${opt }</option>
     </c:otherwise>
     </c:choose>     
     </c:forEach>
     </select>
     </c:when>
     <c:otherwise>
     <select id="select_delta" name="select_delta" class="form-contol select2" aria-hidden="true" data-placeholder="Filtra &#x0394" data-live-search="true" style="width:100%;display:none"></select>
     </c:otherwise>
     </c:choose>  
     </div>
     
     
      <div id="filtra_da_a" class="col-xs-6 pull-right" style="display:none">
      <div class="col-xs-3">
   <label for="filtra_da" class="pull-right">Filtra da</label>
      </div>
    <div class="col-xs-3"> 
   	<c:choose>
   <c:when test="${filtro_delta==true }">  
   	<input type="text" id="filtra_da" style="width:100%" name="filtra_da" class="form-control" value="${filtro_da }">
   	</c:when>
   	<c:otherwise>
   	<input type="text" id="filtra_da" style="width:100%" name="filtra_da" class="form-control">
   	</c:otherwise>
   	</c:choose>     
     </div>
     <div class="col-xs-1">
     <label>a</label>
     </div>
     <div class="col-xs-3">
     <c:choose>
 	  <c:when test="${filtro_delta==true }">  
   	 <input type="text" id="filtra_a" style="width:100%" name="filtra_a" class="form-control" value="${filtro_a }">
   	</c:when>
   	<c:otherwise>
   	 <input type="text" id="filtra_a" style="width:100%" name="filtra_a" class="form-control">
   	</c:otherwise>
   	</c:choose>   
 	 </div>
 	 <div class="col-xs-2" >
 	  <a class="btn btn-primary pull-right" style="margin-left:10px" onClick="filtraDaA()"> Filtra</a>
 	  </div> 
     </div> 
     
     
</div>     

</div>
    

 <table id="tabPuntiQuota" class="table table-bordered table-hover table-striped" style="display:none" role="grid" width="100%">  
 <thead><tr class="active">
<%--  <c:choose>
 <c:when test="${rilievo.tipo_rilievo.id==2 }">
 <th>Progressivo</th>
 </c:when>
 <c:otherwise>
 <th>Quota</th>
 </c:otherwise> 
 </c:choose> 	 --%>

 <c:if test="${rilievo.tipo_rilievo.id==2 }">
 <th>Capability</th> 
 </c:if>  
 	<th>Quota</th>
 	<th>Coordinata</th>
 	<th>Simbolo</th>
 	<th>Valore Nominale</th>
 	<th>Funzionale</th>
 	<th>U.M.</th>
	<th>Tolleranza -</th>		
	<th>Tolleranza +</th>
 	<c:if test="${lista_quote.size()>0}">
 	<c:forEach items="${listaPuntiQuota}" varStatus="loop">
		<th>Pezzo ${loop.index +1}</th>
	</c:forEach>
	</c:if> 
	<th>Note</th>
	<c:if test="${lista_quote.size()>0}">
	<c:forEach items="${listaPuntiQuota}" varStatus="loop">
		<th>&#x0394  ${loop.index +1 }</th>
		<th>&#x0394  ${loop.index +1 } %</th>
	</c:forEach>
	</c:if> 
	<th>Max Dev</th>
	<th>Max Dev %</th>
	
 </tr>
 
 </thead>
 
 <tbody>
 
 <c:forEach items="${lista_quote}" var="quota" varStatus="loop">
 <tr id="riga_${loop.index}">
 	<c:if test="${rilievo.tipo_rilievo.id==2 }">
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.capability)) }</td> 
 	</c:if> 
	<td>${quota.id }</td>
 	<td>${quota.coordinata }</td>
 	<td>${quota.simbolo.descrizione }</td>  	
 	<c:choose>
 	<c:when test="${quota.val_nominale.contains('M') }"> 
 	 	<td>${quota.val_nominale}</td> 	 	 	
 	</c:when>
 	<c:otherwise>
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.val_nominale))}</td> 	
 	</c:otherwise>
 	</c:choose>
 	
 	<td>${quota.quota_funzionale.descrizione }</td>
 	
 	<td>${quota.um }</td>
 	
 	<c:choose>
 	<c:when test="${quota.tolleranza_negativa.equals('/') }"> 
 	 	<td>${utl:changeDotComma(quota.tolleranza_negativa)}</td> 	
 	</c:when>
 	<c:otherwise>
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.tolleranza_negativa))}</td> 	 	
 	</c:otherwise>
 	</c:choose> 	
 	<c:choose>
 	<c:when test="${quota.tolleranza_positiva.equals('/') }"> 
 	 	<td>${utl:changeDotComma(quota.tolleranza_positiva)}</td> 	
 	</c:when>
 	<c:otherwise>
 	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,quota.tolleranza_positiva))}</td>
 	</c:otherwise>
 	</c:choose>
 	
 	<c:forEach items="${quota.listaPuntiQuota}" var="punto" varStatus="loop">	
 		<c:choose>
 		<c:when test="${punto.valore_punto!='OK' && punto.valore_punto!='KO' && punto.valore_punto!='/'}">
 			<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,punto.valore_punto))}</td>
 		</c:when>
 		<c:otherwise>
 			<td>${utl:changeDotComma(punto.valore_punto)}</td>
 		</c:otherwise>
 		</c:choose>	
	
	</c:forEach> 

	<td>${quota.note }</td>
	
	<c:forEach items="${quota.listaPuntiQuota}" var="punto" varStatus="loop">	
		<td>${utl:changeDotComma(punto.delta) }</td>
		<c:choose>
		<c:when test="${punto.delta_perc!=null && punto.delta_perc!='' }">
		<td>${utl:changeDotComma(punto.delta_perc )}%</td>
		</c:when>
		<c:otherwise>
		<td></td>
		</c:otherwise>
		</c:choose>		
	</c:forEach>
	<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,utl:getMaxDelta(quota, false))) }</td>
	<c:choose>
		<c:when test="${utl:getMaxDelta(quota, true)!='' }">
		<td>${utl:changeDotComma(utl:setDecimalDigits(rilievo.cifre_decimali,utl:getMaxDelta(quota, true)))}%</td>
		</c:when>
		<c:otherwise>
		<td></td>
		</c:otherwise>
		</c:choose>	
	
	</tr>
	</c:forEach>

 </tbody>
 </table>
</div>
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
   
   
  <div id="myModalSicuro" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare tutte le quote?
      	</div>
      <div class="modal-footer">
      <a class="btn btn-primary" onclick="svuotaTabella($('#particolare').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalSicuro').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


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
			<c:choose>
			<c:when test="${rilievo.tipo_rilievo.id==2 }">
			<input type="number" min="1"  class="form-control" id="n_pezzi_mod" name="n_pezzi_mod" style="width:100%" value="${numero_pezzi}" disabled>
			</c:when>
			<c:otherwise>
			<input type="number" min="1"  class="form-control" id="n_pezzi_mod" name="n_pezzi_mod" style="width:100%" value="${numero_pezzi}">
			</c:otherwise>
			</c:choose>
				
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

	 function modalSicuro(){
		 $('#myModalSicuro').modal();
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
	 
	 var hot;
	 var settings;
	 var container = document.getElementById('hot');
	 var tipo_rilievo;
  $(document).ready(function(){
	  
	  max_riferimento = '${max_riferimento}';
	  tipo_rilievo = ${rilievo.tipo_rilievo.id};
	  
	  if(tipo_rilievo==2){
	  var opt = [];
	  
	  var options = JSON.parse('${lista_quote_riferimento}');
	  var checkRiferimento = "${checkRiferimento}";
	  options.forEach(function(item){
		   if(item.riferimento == "${riferimento}" && checkRiferimento!=''){
			  opt.push('<option value="'+item.riferimento+'" selected>'+item.value+'</option>')
		  }else{
			  opt.push('<option value="'+item.riferimento+'">'+item.value+'</option>')	  
		  }
		   //opt.push('<option value="'+item.riferimento+'">'+item.value+'</option>')
	  });
	  
	  $('#quota_riferimento').html(opt);
	 // $('#quota_riferimento option[value="'+"${riferimento}"+'"').prop("selected", true);
	  }
	
	var numero_pezzi= "${numero_pezzi}";
	  if(numero_pezzi!=null && numero_pezzi!=""){
	 	creaInputPezzo(numero_pezzi);
	 } 
	  console.log("test");

	  $('#note_part').val("${particolare.note}");
	  if(permesso){
	  	$('#xml_button').removeClass('disabled');
	  }
	 var data_table  = $('#tabPuntiQuota tr').map(function(tr){
		return [$(this).children().map(function(td){			
			return $(this).text();}).get()]
	}).get(); 

	  var data = [];

	var n= ${numero_pezzi};
	var capability = [];
	 
	if(tipo_rilievo == 2){
		n=n+1;
	}
		
	
	  	for(var i=1; i<data_table.length;i++){
				var data_row =[];
				for(var j=0; j<9+n;j++){	
					if(j==0 && tipo_rilievo == 2 ){
						capability.push(data_table[i][j]);
					}else{
						data_row.push(data_table[i][j]);
					}
				}
				data.push(data_row);
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
				 td.style.background = '#ADD8E6';
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
			if(value!="" && value!="Nessuno"){				
				Handsontable.dom.fastInnerHTML(td, '<img class="img" src=./images/simboli_rilievi/' + value + '.bmp style="height:20px">');
				
			}
		  } 
	
 	colhead = [];
 	if(tipo_rilievo==2){
		for(var i = 1; i<data_table[0].length;i++){		
				colhead.push(data_table[0][i]);		
		} 
 	}else{
 		colhead = data_table[0];
 	}
	  var selectedRow;
	  var current_row;
	  //var hot = new Handsontable(container, {
		settings = {
	    data: data,
	    rowHeaders: false,	  
	    currentRowClassName: 'currentRow',
	    manualColumnResize: true,
	    outsideClickDeselects: true,
 		manualRowResize: true,	  
	    stretchH: "all",	    
	    colHeaders: colhead,
	   	maxCols: data_table[0].length,	
	   	headerTooltips: true,
	   	className: "htCenter",
	   	colWidths: function(index) {
	   	    if(index == 0){
	   	    	return 25;
	   	    }
	   	    if(index == 1){
	   	    	return 30;
	   	    }
	  		if(index == 2){
	   	    	return 25;
	   	    }
	   		if(index == 3){
   	    		return 45;
   	  	   }
	  	 	if(index == 4){
   	    		return 30;
   	       }
	    	if(index == 5){
   	    		return 15;
   	       }
	    	if(index == 6){
   	    		return 32;
   	   	   }
	   		if(index == 7){
   	    		return 32;
   	   	   }
	   	    return;
	   	},

	    cells: function(row,col){
	    	if(!permesso){
	        	  return{
	        		  readOnly: true
	        	  };
	          }else{
	            if(col == 0){
	              return {
	                  readOnly: true
	              };   
	          }  
 	           if(col == 2){	
 	        	      var opt =[];
	        	   $('#simbolo option').each(function() {
	        		   var x = $(this).val();
	        		  if($(this).val()!=""&& $(this).val()!="Nessuno"){
	        			  if($(this).val().split("_")[0]<10){
	        				  var filename = $(this).val().substring(2, $(this).val().length);
	        			  }else{	        				 
	        				  	var filename = $(this).val().substring(3, $(this).val().length);
	        			  }
	        			  
	        			opt.push(filename);
	        		  }
	        		  else if($(this).val()=="Nessuno"){
	        			  var filename = $(this).val();
	        			  opt.push(filename);
	        		  }
					});  
	        	   return{
	        		 editor: 'select',	        		 
	        	     selectOptions: opt,
	        	  } 
	          } 
	          else if (col == 4){
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
 	           
 	          if(col > 8+n){
	        	  return {
	                  readOnly: true
	              }; 
	          } 
 	          
	          }
	      },
	    afterInit: function(){
	    	var rows = this.countRows();
	    	var cols = this.countCols();
	    	if(rows>=1 && this.getDataAtCell(0, 0)!=''){    
	    	for(var i = 0; i<rows;i++ ){
	    		if(this.getDataAtCell(i, 2)!="" && this.getDataAtCell(i, 2)!="Nessuno"){
	    			this.getCellMeta(i, 2).renderer = imageRenderer;	
	    		}else{
	    			this.getCellMeta(i, 2).renderer = defaultRenderer;
	    		}
	    		
	    		for(var j = 8; j<8+n; j++){	
	    				var calcola = true; 
	    				if(this.getDataAtCell(i, j)!="OK" && this.getDataAtCell(i, j)!="KO" && this.getDataAtCell(i, j)!="/"){
	    					var val_corrente = parseFloat(this.getDataAtCell(i, j).replace(',','.'));	    			
	    				}else{
	    					calcola = false;
	    				}
	    				if(!this.getDataAtCell(i, 3).includes("M")){
	    					var val_nominale = parseFloat(this.getDataAtCell(i, 3).replace(',','.'));
	    					
	    				}else{
	    					calcola = false;
	    				}
	    				if(this.getDataAtCell(i, 7)!="/"){
	    					var tolleranza_pos = parseFloat(this.getDataAtCell(i, 7).replace(',','.'));	    					
	    				}else{
	    					calcola = false;
	    				}
	    				if(this.getDataAtCell(i, 6)){
	    					var tolleranza_neg = parseFloat(this.getDataAtCell(i, 6).replace(',','.'));
	    				
	    				}else{
	    					calcola = false;
	    				}
	    				if(calcola){
	    					var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
	    					if(value){	    		    					
		    					this.getCellMeta(i, j).renderer = defaultRenderer;	    					  					
		    				}else{
		    					this.getCellMeta(i, j).renderer = errorRenderer;	    					
		    				}
	    				}else{
	    					if(this.getDataAtCell(i, j)!="KO"){
	    						this.getCellMeta(i, j).renderer = defaultRenderer;	
	    					}else{
	    						this.getCellMeta(i, j).renderer = errorRenderer;
	    					}	    						 
	    				}
	    				
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
	    	
	    	if((col_change > 7 && col_change!=(n+8)) || col_change == 3 || col_change == 6 || col_change == 7){
	    		var data_cell = this.getDataAtCell(row_change, col_change).replace(",", ".");
	    		if(isNaN(data_cell)){	    		
	    			if((col_change > 7 && col_change!=n+8)){
	    				if(data_cell=="OK" || data_cell=="/"){
	    					hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
	    	    			hot.render();
	    	    			send = true;
	    				}
	    				else if(data_cell == "KO"){
	    					hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
	    	    			hot.render();
	    	    			send = true;
	    				}
	    				else{
		    				hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
			    			hot.render();
			    			send = false;
		    			}	
	    			}
	    			else if(col_change == 6 || col_change == 7){
	    				if(data_cell=="/"){
	    					hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
	    	    			hot.render();
	    	    			send = true;
	    				}
	    				else{
	    					hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
			    			hot.render();
			    			send = false;
	    				}
	    			}
	    			else{
	    				if(data_cell.includes("M")){
	    					var index = data_cell.indexOf("M");	    				
	    					if(!isNaN(data_cell.charAt(index+1)) && data_cell.charAt(index+1)!=""){
	    						var number1 = parseInt(data_cell.charAt(index+1));
	    						var number2 = null;
	    						if(data_cell.length>index+1){
	    							if(!isNaN(data_cell.charAt(index+2))){
	    								number2 = parseInt(data_cell.charAt(index+2));
	    							}
	    						} 
	    						
	    						if(number2 != null && !isNaN(number2)){
	    							if(number1 < 2 && number2<=9){
		    							hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
		    	    	    			hot.render();
		    	    	    			send = true;
		    	    	    			
		    	    	    			for(var j = 8; j<this.countCols(); j++){
		    	    	    				if(this.getCellMeta(row_change, j)!="KO"){
		    			    					this.getCellMeta(row_change, j).renderer = defaultRenderer;
		    	    	    				}
		    			    			}		    	    	    			
		    						}else{
		    							hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
		    	    	    			hot.render();
		    	    	    			send = false;
		    						}
	    							hot.render();
	    						}else{
	    							hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
	    	    	    			hot.render();
	    	    	    			
	    	    	    			for(var j = 8; j<this.countCols(); j++){
	    	    	    				if(this.getCellMeta(row_change, j)!="KO"){
	    			    					this.getCellMeta(row_change, j).renderer = defaultRenderer;
	    	    	    				}
	    			    			}
	    	    	    			send = true;
	    	    	    			hot.render();
	    						}
	    						
	    					}else{
	    						hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
    	    	    			hot.render();
    	    	    			send = false;
	    					}
	    				}else{
	    					hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
	    	    			hot.render();
	    	    			send = false;
	    				}
	    			}
	    		}
	    		else{	  
	    		
	    			if( (col_change > 7 &&  col_change<n+8)){	    				
	    				var calcola = true;
	    				var val_corrente = parseFloat(data_cell);
	    				var val_nominale = parseFloat(this.getDataAtCell(row_change, 3).replace(',','.'));
	    				var tolleranza_pos = parseFloat(this.getDataAtCell(row_change, 7).replace(',','.'));
	    				var tolleranza_neg = parseFloat(this.getDataAtCell(row_change, 6).replace(',','.'));
	    				
 	    				if(isNaN(this.getDataAtCell(row_change, col_change).replace(',','.')) || isNaN(this.getDataAtCell(row_change, 3).replace(',','.')) ||
	    						isNaN(this.getDataAtCell(row_change, 7).replace(',','.')) || isNaN(this.getDataAtCell(row_change, 6).replace(',','.'))){
	    					calcola = false
	    				}
	    				if(calcola){
		    				var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
		    				if(value){	 	    					
		    					hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
			    			}else{		    				
			    				hot.getCellMeta(row_change, col_change).renderer = errorRenderer;
			    			}
	    				}else{
	    					hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;
	    				}
 	    			}
	    			else if(col_change == 6 || col_change == 7 || col_change == 3){
	    				var calcola = true;
	    				var cols = this.countCols();
	    	    		for(var j = 8; j<n+8; j++){	    			
		    				var val_corrente = parseFloat(this.getDataAtCell(row_change, j).replace(',','.'))
		    				var val_nominale = parseFloat(this.getDataAtCell(row_change, 3).replace(',','.'))
		    				var tolleranza_pos = parseFloat(this.getDataAtCell(row_change, 7).replace(',','.'))
		    				var tolleranza_neg = parseFloat(this.getDataAtCell(row_change, 6).replace(',','.'))
		    				if(isNaN(this.getDataAtCell(row_change, j).replace(',','.')) || isNaN(this.getDataAtCell(row_change, 3).replace(',','.')) || isNaN(this.getDataAtCell(row_change, 7).replace(',','.')) || isNaN(this.getDataAtCell(row_change, 6).replace(',','.'))){
		    					calcola = false
		    				}
		    				if(calcola){
		    				var value = calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg);
			    				if(value){	    		    					
			    					this.getCellMeta(row_change, j).renderer = defaultRenderer;	    					  					
			    				}else{
			    					this.getCellMeta(row_change, j).renderer = errorRenderer;	    					
			    				}
		    				}else{
		    					this.getCellMeta(row_change, j).renderer = defaultRenderer;	
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
	    	if(col_change == 2){
	    		var data_cell = this.getDataAtCell(row_change, col_change);
	    		if(data_cell=="ANGOLO"){
	    			this.setDataAtCell(row_change, 5, "°"); 
	     	   	  }
	    		else{
	    			this.setDataAtCell(row_change, 5, "mm"); 
	    		}
	    		if(data_cell!="Nessuno"){
	    			hot.getCellMeta(row_change, col_change).renderer = imageRenderer;	
	    			hot.render();
	    		}else{
	    			hot.getCellMeta(row_change, col_change).renderer = defaultRenderer;	
	    			hot.render();
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
					dataObj.data = JSON.stringify(data);
					$('#simbolo option').each(function() {
		      		 	 if($(this).val()!="" && $(this).val()!="Nessuno"){	
		      				if($(this).val().split("_")[0]<10){
		  				 		var simbolo = $(this).val().substring(2, $(this).val().length);
		  			 		}else{
		  				 		var simbolo = $(this).val().substring(3, $(this).val().length);
		  			  	 	}
		      					       			
		      		  	}else{
		      		  	var simbolo = $(this).val();
		      		  	}
		      		 	if(data[2] == simbolo){
	      					dataObj.simbolo = $(this).val();
	      			 	}
					 });   
					 $('#quota_funzionale option').each(function() {
			       		  if($(this).val()!=""){
			       			if(data[4] == $(this).val().split("_")[1]){
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
			  if(permesso){
			  selectedRow = hot.getDataAtRow(row);
			  $(this).addClass('currentRow');			
				
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
			        				  if(optionValues[i].substring(2, optionValues[i].length) == selectedRow[2]){
			        				  	$('#simbolo').val(optionValues[i]);
										$('#simbolo').change();	 
			        				  }
			        			  }else{
			        				  if(optionValues[i].substring(3, optionValues[i].length) == selectedRow[2]){
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
								if(optionValues2[i].split("_")[1]==selectedRow[4]){
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
						if(permesso){
							$('#mod_button').removeClass('disabled');				
							$('#elimina_button').removeClass('disabled');	
						}
						  $('#val_nominale').val(selectedRow[3]);
						  $('#val_nominale').change();						 
						  $('#coordinata').val(selectedRow[1]);				 				
						  $('#note_quota').val(selectedRow[(selectedRow.length-1)]);
						  $('#tolleranza_neg').val(selectedRow[6]);
						  $('#tolleranza_pos').val(selectedRow[7]);
						  $('#capability').val(capability[row]);
						  
						  if($('#simbolo').val()=="2_ANGOLO"){
							  var classe_tolleranza = "${rilievo.classe_tolleranza}";
							  var campo_lunghezza = 0;
							  if(parseFloat($('#tolleranza_pos').val().replace(",","."))==1){
								  if(classe_tolleranza=="f" || classe_tolleranza=="m"){
									  campo_lunghezza = 1;
								  }		
								  else if(classe_tolleranza=="c"){
									  campo_lunghezza = 2;
								  }
								  else if(classe_tolleranza=="v"){
									  campo_lunghezza = 3;									  
								  }
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==0.5){
								  if(classe_tolleranza=="f" || classe_tolleranza=="m"){
									  campo_lunghezza = 2;
								  }
								  else if(classe_tolleranza=="c"){
									  campo_lunghezza = 3;
								  }
								  else if(classe_tolleranza=="v"){
									  campo_lunghezza = 4;									  
								  }
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==0.333){
								  if(classe_tolleranza=="f" || classe_tolleranza=="m"){
									  campo_lunghezza = 4;
								  }	
								  else if(classe_tolleranza=="v"){
									  campo_lunghezza = 5;									  
								  }								  
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==0.166){
								  if(classe_tolleranza=="f" || classe_tolleranza=="m"){
									  campo_lunghezza = 4;
								  }	
								  else if(classe_tolleranza=="c"){
									  campo_lunghezza = 5;									  
								  }								  
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==0.083){
								  if(classe_tolleranza=="f" || classe_tolleranza=="m"){
									  campo_lunghezza = 5;
								  }									  						  
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==1.5){
								  if(classe_tolleranza=="c"){
									  campo_lunghezza = 1;
								  }									  						  
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==2){
								  if(classe_tolleranza=="v"){
									  campo_lunghezza = 2;
								  }									  						  
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==3){
								  if(classe_tolleranza=="v"){
									  campo_lunghezza = 1;
								  }									  						  
							  }
							  else if(parseFloat($('#tolleranza_pos').val().replace(",","."))==0.25){
								  if(classe_tolleranza=="c"){
									  campo_lunghezza = 4;
								  }									  						  
							  }
							  
							  $('#campi_lunghezza').val(campo_lunghezza);
							  $('#campi_lunghezza').change();
							}
						  
		  } 	
	  //});
		} ,

	  }
		  $('#pulisci_campi').click(function(){
				$('#id_quota').val("");
					$('#mod_button').addClass('disabled');       
					$('#elimina_button').addClass('disabled');   
			        $('#val_nominale').val('');
			        $('#simbolo').val("");
			        $('#quota_funzionale').val("");
			        $('#simbolo').change();
			        $('#quota_funzionale').change();
			        $('#coordinata').val('');
			        $('#tolleranza_neg').val('');
			        $('#tolleranza_pos').val('');
			        $('#capability').val('');
			        $('#ripetizioni').val('');
			        $('#note_quota').val('');
			        $('#lettera').val('')
			        $('#lettera').change();
			        $('#numero').val('')
			        $('#numero').change();
			      $('#error_label').hide();
			        for(var i = 0; i<numero_pezzi;i++){
		        	 $('#pezzo_'+(i+1)).val('');
			      	}
		  });
		  var checkRiferimento = "${checkRiferimento}";
	  if( checkRiferimento!="" || tipo_rilievo !=2){
	  hot = new Handsontable(container, settings);
	  hot.selectRows(hot.countRows()-1);
	  }
	  $('#pulisci_campi').click();
		 var filtro_delta = ${filtro_delta};
		  if(filtro_delta){
			  $('#select_delta').select2();  
			  $('#filtra_da_a').show();
			 
			  	mostraTabellaDelta();
			
		  }
  });  
	

  $('#pleaseWaitDialog').on('hidden.bs.modal', function(){
		$(document.body).css('padding-right', '0px');	
	});

  
  function filtraNonConformi(id_particolare){
	  if(tipo_rilievo==2){
		  var riferimento = "${riferimento}";  
	  }else{
		  var riferimento = "";
	  }	  
	  dataString ="id_particolare="+ id_particolare+"&riferimento="+riferimento;
	  
      exploreModal("gestioneRilievi.do?action=filtra_non_conformi",dataString,"#tabella_punti_quota");
  }
  function resetFiltro(id_particolare){
	  if(tipo_rilievo==2){
		  var riferimento = "${riferimento}";  
	  }else{
		  var riferimento = "";
	  }	  
		 dataString ="id_impronta="+ id_particolare+"&riferimento="+riferimento;
	       exploreModal("gestioneRilievi.do?action=dettaglio_impronta",dataString,"#tabella_punti_quota");
  }
  
  
  function mostraTabellaDelta(){
	  var html = '<a class="btn btn-primary pull-right" style="margin-right:5px" onClick="nascondiTabellaDelta()"> Nascondi Tabella Delta</a>';
	  
	  var filtro_delta = ${filtro_delta};
	  
	  $('#button_tabella').html(html);
		  var data_table  = $('#tabPuntiQuota tr').map(function(tr){
				return [$(this).children().map(function(td){			
					return $(this).text();}).get()]
			}).get();  	  
		var data_init = hot.getData();
		var n = ${numero_pezzi};
		var data = [];
		if(!filtro_delta){
			var options = [];
			options.push('<option value=""></option>');
			options.push('<option value="0">Tutti</option>');
			for(var i=0; i<data_init.length;i++){
				/* var y =[]; */
				
				if(tipo_rilievo!=2){
					for(var j=9+n; j<data_table[i].length;j++){
						data_init[i][j] = (data_table[i+1][j]);
						if(j==data_table[i].length-2 && data_table[i+1][j]!="" && !options.includes('<option value="'+data_table[i+1][j]+'">'+data_table[i+1][j]+'</option>')){
							options.push('<option value="'+data_table[i+1][j]+'">'+data_table[i+1][j]+'</option>')
						}
					}
					
				}else{
					for(var j=9+n; j<data_table[i].length-1;j++){
						data_init[i][j] = (data_table[i+1][j+1]);
						if(j==data_table[i].length-2 && data_table[i+1][j]!="" && !options.includes('<option value="'+data_table[i+1][j]+'">'+data_table[i+1][j]+'</option>')){
							options.push('<option value="'+data_table[i+1][j]+'">'+data_table[i+1][j]+'</option>')
						}
					}
					
				}
			}
			
			hot.destroy();
			settings.data = data_init; // this is the new line				 
			hot = new Handsontable(container, settings);
				$('#select_delta').html(options);
				$('#select_delta').show();
				$('#filtra_da_a').show();			
				$('#select_delta').select2();
			
 	  }else{

			hot.destroy();
			  data = [];
			  
			  for(var i=1; i<data_table.length;i++){
					var data_row =[];
					var j
					if(tipo_rilievo==2){
						j=1;
					}else{
						j=0;
					}
					for(j; j<data_table[i].length;j++){
							data_row.push(data_table[i][j]);
						}					
					data.push(data_row);
			}
				if(data.length==0){
					var array = [];			
					 for(var i = 0; i<data_table[0].length;i++){
						 array.push("");
					  }
					data.push(array);
				}
				settings.data = data; // this is the new line				 
				hot = new Handsontable(container, settings); 
			
	  }  
  }
  
  
  $('#select_delta').change(function(){	
	  var id_particolare = '${id_impronta}';
	  
	  var opt = $('#select_delta option').clone();
	  var options = [];
	  for(var i = 0; i<opt.length;i++){
		  options.push(opt[i].value.replace(",","."));
	  }
	  if(tipo_rilievo==2){
		  var riferimento = "${riferimento}";  
	  }else{
		  var riferimento = "";
	  }	  	  
	
	  dataString ="id_particolare="+ id_particolare + "&delta="+ $('#select_delta').val() + "&options="+options+"&riferimento="+riferimento;
      exploreModal("gestioneRilievi.do?action=filtra_delta",dataString,"#tabella_punti_quota");
  });
  

  function nascondiTabellaDelta(){
	  
	  var filtro_delta = ${filtro_delta};
	  if(!filtro_delta){
	  	$('#select_delta').select2("destroy");
  
	  	$('#select_delta').hide();
	  	$('#filtra_da_a').hide();		
	  }
	  
	  var html = '<a class="btn btn-primary pull-right" style="margin-right:5px" onClick="mostraTabellaDelta()"> Mostra Tabella Delta</a>';
		  $('#button_tabella').html(html);

	 var data_table =  hot.getData();
	 var n = ${numero_pezzi};
	 var data = [];
		for(var j=0; j<data_table.length;j++){
					var array =[];
					for(var i=0; i<9+n;i++){					
						array.push(data_table[j][i]);
					}
					data.push(array);
				}
				 
	 hot.destroy();
	 settings.data = data; // this is the new line				 
	 hot = new Handsontable(container, settings);
  }
  
  
  function filtraDaA(){
	  $('#filtra_da').css('border', '1px solid #d2d6de');
	  $('#filtra_a').css('border', '1px solid #d2d6de');
	  var id_particolare = '${id_impronta}';
	  
	  var filtra_da = $('#filtra_da').val();
	  var filtra_a = $('#filtra_a').val();
	  
	  var esito = true; 
	  
	  if(filtra_da=='' || isNaN(filtra_da)){
		  esito = false;
		  $('#filtra_da').css('border', '1px solid #f00');
	  }
	  if(filtra_a=='' || isNaN(filtra_a)){
		  esito = false;
		  $('#filtra_a').css('border', '1px solid #f00');
	  }
	  
	  if(esito){
		  var opt = $('#select_delta option').clone();
		  var options = [];
		  
		  for(var i = 0; i<opt.length;i++){
			  options.push(opt[i].value.replace(",","."));
		  }
		  if(tipo_rilievo==2){
			  var riferimento = "${riferimento}";  
		  }else{
			  var riferimento = "";
		  }	  
		  dataString ="id_particolare="+ id_particolare + "&filtra_da="+ $('#filtra_da').val() + "&filtra_a="+ $('#filtra_a').val() + "&options="+options+"&riferimento="+riferimento;
	      exploreModal("gestioneRilievi.do?action=filtra_da_a",dataString,"#tabella_punti_quota");
	  }

  }
  
  function esportaQuotePDF(){
	  
	  var data = settings.data;
	  var ids = [];
	  for(var i = 0; i<data.length;i++){
		ids.push(data[i][0]);
	  }

	  dataIn = JSON.stringify(ids)
	  callAction('gestioneRilievi.do?action=esporta_pdf&dataIn='+ids);
	  
  }
  
function calcolaConformita(val_corrente, val_nominale, tolleranza_pos, tolleranza_neg){
	
	var conforme = true;
	if(isNaN(val_corrente)){
		return true;
	}
	if(val_corrente <=(val_nominale + tolleranza_pos) && val_corrente >=(val_nominale + tolleranza_neg)){
		confrome = true;
	}else{
		conforme = false;
	}
	return conforme;
	
}

	
	


	
  
 </script>
			
			 