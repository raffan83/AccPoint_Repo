<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<button class="btn btn-primary" onClick="openNuovoModal()"><i class="fa fa-plus"></i> Inserisci Riga</button><br><br>

 <table id="tabDB" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%"> 
 <thead><tr class="active">
  <c:forEach items="${lista_colonne}" var="colonna">

   <th>${colonna.name }</th>

  
  </c:forEach>
<th>Azione</th>
 </tr>
 
 </thead>
 
 <tbody>
 
 <c:forEach items="${dati_tabella}" var="riga" varStatus="loop">
 <tr role="row" id="riga_${loop.index}" title="Doppio click per modificare la riga">
 	<c:forEach items="${riga}" var="cella">
 	<td>${cella}</td>
 	</c:forEach>
 <td><button class="btn btn-warning" onClick="openModificaModal('#riga_${loop.index}')" title="Click per modificare la riga"><i class="glyphicon glyphicon-pencil"></i></button></td>
	</tr>
	
	</c:forEach>

	
 </tbody>
 </table> 
 
  <form id="modificaTabellaForm">
    <div id="modificaTabellaModal" class="modal" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica</h4>
      </div>
       <div class="modal-body">
		 <c:forEach items="${lista_colonne_noK}" var="colonna" varStatus="loop">
		  <div class="row">
				<div class="form-group">
         			<label class="col-sm-3 control-label">${colonna.name}:</label>
       				 <div class="col-sm-9">
       				 <c:choose>
       				 <c:when test="${colonna.isNullable==0 }">
       				 	<c:choose>
       				 	<c:when test="${colonna.isPKey==true }">
       						<input type="text" class="form-control" value="" id="colonna_${loop.index}" name="colonna_${loop.index}" readonly>
		
                     	</c:when>
                     	<c:when test="${colonna.isFkey==true }">
                     	<div class="row">
                     	<div class="col-xs-10">
       						<input type="text" class="form-control" value="" id="colonna_${loop.index}" name="colonna_${loop.index}" readonly>
       						<input type="hidden" id="table_hidden_${loop.index }" name="table_hidden_${loop.index }" value="${colonna.FKTable }">
       						<input type="hidden" id="colonna_hidden_${loop.index }" name="colonna_hidden_${loop.index }" value="${colonna.FKTableColumn }">
       						</div>
       						<div class="col-xs-2">
       						<a class="btn btn-info pull-right" id="select_option_${loop.index}" onClick="selectOption('#table_hidden_${loop.index }','#colonna_hidden_${loop.index }', '${loop.index }')"><i class="glyphicon glyphicon-menu-right"></i></a>
       						</div>
       						</div>
                     	</c:when>
                     	<c:otherwise>
                     	<c:choose>
       						<c:when test="${colonna.tipo_dato.toString().equals('class java.sql.Date')}">
       						
       						<div class="input-group date datepicker" style="padding:0px">
           						 <input class="form-control" id="colonna_${loop.index}" type="text" name="colonna_${loop.index}" style="width:100%"/> 
           						 <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>       						
       						</div>
       						</c:when>
       						<c:when test="${colonna.tipo_dato.toString().equals('class java.sql.Timestamp')}">
       						
       						 <div class="input-group date datetimepicker" style="padding:0px">
           						 <input type="text" class="form-control date input-small" id="colonna_${loop.index}"  name="colonna_${loop.index}"/> 
           						 <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>       						
       						</div>
       						
						</c:when>
       						
       						 <c:when test="${colonna.tipo_dato.toString().equals('class java.math.BigDecimal')||colonna.tipo_dato.toString().equals('class java.lang.Integer')||
       						 colonna.tipo_dato.toString().equals('class java.lang.Float')
       						 ||colonna.tipo_dato.toString().equals('class java.lang.Double')
       						  ||colonna.tipo_dato.toString().equals('class java.lang.Long')}">
       						 
           						 <input type="text" class="form-control" id="colonna_${loop.index}"  name="colonna_num_${loop.index}" required/> 
       						
       						</c:when> 
       						<c:otherwise>
                     		<input type="text" class="form-control" value="" id="colonna_${loop.index}" name="colonna_${loop.index}" required>
                     		</c:otherwise>
                     		</c:choose>    
                     	</c:otherwise>
                     	</c:choose>
       				 </c:when>
       				 <c:otherwise>
       				<c:choose>
       				 	<c:when test="${colonna.isPKey==true }">
       						<input type="text" class="form-control" value="" id="colonna_${loop.index}" name="colonna_${loop.index}" readonly>
		
                     	</c:when>
                     	<c:when test="${colonna.isFkey==true }">
                     	<div class="row">
                     	<div class="col-xs-10">
       						<input type="text" class="form-control" value="" id="colonna_${loop.index}" name="colonna_${loop.index}" readonly>
       						<input type="hidden" id="table_hidden_${loop.index }" name="table_hidden_${loop.index }" value="${colonna.FKTable }">
       						<input type="hidden" id="colonna_hidden_${loop.index }" name="colonna_hidden_${loop.index }" value="${colonna.FKTableColumn }">
       						</div>
       						<div class="col-xs-2">
       						<a class="btn btn-info pull-right" id="select_option_${loop.index}" onClick="selectOption('#table_hidden_${loop.index }','#colonna_hidden_${loop.index }', '${loop.index }')"><i class="glyphicon glyphicon-menu-right"></i></a>
       						</div>
       						</div>
                     	</c:when>
                     	<c:otherwise>
                     	<c:choose>
       						<c:when test="${colonna.tipo_dato.toString().equals('class java.sql.Date')}">
       						
       						 <div class="input-group date datepicker" style="padding:0px">
           						 <input class="form-control" id="colonna_${loop.index}" type="text" name="colonna_${loop.index}" style="width:100%"/> 
           						 <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>       						
       						</div>
     						
       						</c:when>
       						<c:when test="${colonna.tipo_dato.toString().equals('class java.sql.Timestamp')}">
       						
       						 <div class="input-group date datetimepicker" style="padding:0px">
           						 <input type="text" class="form-control date input-small" id="colonna_${loop.index}"  name="colonna_${loop.index}"/> 
           						 <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>       						
       						</div>
       						
					</c:when>
       						 <c:when test="${colonna.tipo_dato.toString().equals('class java.math.BigDecimal')||colonna.tipo_dato.toString().equals('class java.lang.Integer')||
       						 colonna.tipo_dato.toString().equals('class java.lang.Float')
       						 ||colonna.tipo_dato.toString().equals('class java.lang.Double')
       						  ||colonna.tipo_dato.toString().equals('class java.lang.Long')}">
       						 
           						 <input type="text" class="form-control" id="colonna_${loop.index}"  name="colonna_num_${loop.index}"/> 
       						
       						</c:when> 
       						<c:otherwise>
                     		<input type="text" class="form-control" value="" id="colonna_${loop.index}" name="colonna_${loop.index}">
                     		</c:otherwise>
                     		</c:choose>    
                     	</c:otherwise>
                     	</c:choose>
                     	
       				 </c:otherwise>
       				 </c:choose>
    				</div>
     			</div>
     		</div><br>			
     		
			</c:forEach>

  		 </div>
      <div class="modal-footer">
		<div class="row">
		<div class="col-xs-2">
         <button type="submit" class="btn btn-warning pull-left" >Salva</button> 
         </div>
         <div class="col-xs-10">
         <label class="pull-left" id="warning_label" style="display:none"></label>
         </div>
         </div>
      </div>
    </div>
  </div>
</div> 
</form>


   <div id="modalOptions" class="modal modal-fullscreen" aria-labelledby="myLargeModalLabel" style="fullscreen:true">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        
      </div>
       <div class="modal-body">
			<div id="modalOptionsContent">
				
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
 
    <!--     <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button> -->
      </div>
    </div>
  </div>
</div>


 <script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script> 


 <script type="text/javascript">
 var datax;
var n_colonne = ${lista_colonne_noK.size()};
var azione = "";


$('#modificaTabellaForm').on('submit', function(e){
	e.preventDefault();
	var esito = checkInput();
	if(esito){
		$('#warning_label').hide();
		for(var i = 0;i<n_colonne;i++){
			$('#colonna_'+i).attr('name','colonna_'+i);
		}
		
	modificaTabellaDB(n_colonne, azione);
	}else{
		
		$('#warning_label').html("Attenzione! Inserire il tipo di dato corretto!")
		$('#warning_label').css("color", "red");
		$('#warning_label').show();

	}
});

function checkInput()
{
	var esito = true;
    for(var i = 0; i<n_colonne; i++){
    	$('#colonna_'+i).css('border', '1px solid #d2d6de');
    	 var name=document.getElementsByName('colonna_num_'+i)[0];
    	if(name!=null){
    		var val = name.value;
    	 if (isNaN(val))
    	    {    	        
    	       esito=false;
    	       $('#colonna_'+i).css('border', '1px solid #f00');
    	    }    	 
    	}
    	
    }
    return esito;
}

	function openModificaModal(id_riga){
		azione= "modifica";
		 $('#myModalLabel').html("Modifica");
		var row = table.row(id_riga);
		
		datax = row.data();
		
		if(datax){
			row.child.hide();
	
		for(var i = 0; i<datax.length;i++){
			$('#colonna_'+i).val(datax[i]);
		}
			$("#modificaTabellaModal").modal();
		}
	

	}

 $('#tabDB').on( 'dblclick','tr', function () {  
	 $('#myModalLabel').html("Modifica");
	 azione= "modifica";
	 
		var id = $(this).attr('id');
		
		var row = table.row('#'+id);
		datax = row.data();
	
		if(datax){
			row.child.hide();
	
		for(var i = 0; i<datax.length;i++){
			$('#colonna_'+i).val(datax[i]);
		}
			$("#modificaTabellaModal").modal();
		}
	

	});
 
 
 function openNuovoModal(){
	 $('#myModalLabel').html("Inserisci nuova riga");
	 azione= "nuovaRiga";
	 for(var i = 0; i<n_colonne;i++){
			$('#colonna_'+i).val("");
		}
			$("#modificaTabellaModal").modal();

 }
 
 
 var columsDatatables = [];
 
	$("#tabDB").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabDB thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabDB thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');

	} );

	} );
 
 
 $(document).ready(function() {
	 
 	 $('.datepicker').datepicker({
			format: "yyyy-mm-dd"
		}); 
 	 
  	$('.datetimepicker').datetimepicker({
		format : "yyyy-mm-dd hh:ii:ss.0",
		startDate : new Date()
	});
	 
	 table = $('#tabDB').DataTable({
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
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,
		       columnDefs: [
					   { responsivePriority: 1, targets: n_colonne }
		                  /*  { responsivePriority: 2, targets: 1 },
		                   { responsivePriority: 3, targets: 2 } */
		               ], 

		    	
		    });
		


		    $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
	table = $('#tabDB').DataTable();
	//Apply the search
	table.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	   table
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
		table.columns.adjust().draw();
		

	$('#tabDB').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});

	
	

	

	 }); 

 $("#modificaTabellaModal").on('hidden.bs.modal', function(){
	 for(var i = 0; i<n_colonne;i++){
	 $('#colonna_'+i).css('border', '1px solid #d2d6de');
	 }
	 $('#warning_label').hide();
 });
 
 
 function selectOption(table, column, index){
	 
	 var tabella = $(table).val();
		dataString = "tabella="+$(table).val()+"&colonna="+$(column).val()+"&index="+index;
		exploreModal('gestioneTabelle.do?action=scegli_valore_fk', dataString, '#modalOptionsContent', null);
		
		$("#modalOptions").modal();
 }

 
 </script>