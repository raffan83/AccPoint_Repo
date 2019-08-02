<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>



<div class="row">
<div class="col-sm-12">

 <table id="tabVerStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
  <th></th>
 <th style="max-width:65px" class="text-center"></th>
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
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
 
	<tr>
	<td></td>
	<td></td>
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
	
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script>
<!-- <script type="text/javascript" src="plugins/timepicker/bootstrap-timepicker.js"></script>  -->


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
   <script src="plugins/iCheck/icheck.js"></script>
  <script src="plugins/iCheck/icheck.min.js"></script> 
<script type="text/javascript">


function selectRow(){
	var table = $("#tabVerStrumenti").DataTable();
	
	 $('#tabVerStrumenti tbody tr').each(function(){
		 var td = $(this).find('td').eq(2);
		 var row =  $('#posTabSelezionati')[0].children;
			for(var j = 0;j<row.length;j++){
				if(row[j].id.split("_")[1]== td[0].innerText){					
					 table.rows(this).select()
				}
			}
		
	 });
}

var columsDatatables = [];

$("#tabVerStrumenti").on( 'init.dt', function ( e, settings ) {
   var api = new $.fn.dataTable.Api( settings );
   var state = api.state.loaded();

   if(state != null && state.columns!=null){
   		console.log(state.columns);
   
   columsDatatables = state.columns;
   }
   $('#tabVerStrumenti thead th').each( function () {
    	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
   	  var title = $('#tabVerStrumenti thead th').eq( $(this).index() ).text();
   	  
   	if($(this).index()!=0 && $(this).index()!=1){	
  	  var title = $('#tabVerStrumenti thead th').eq( $(this).index() -1 ).text();	
  /* 	$(this).append( '<input class="inputsearchtable" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/>'); */
  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
}
else if($(this).index() ==1){
	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
  }
   	$('#checkAll').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
      }); 
   	
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
     
   var table = $('#tabVerStrumenti').DataTable({
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
	        pageLength: 10,
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		       select: {		    	  
		        	style:    'multi+shift',
		        	selector: 'td:nth-child(2)'
		    	}, 
		      columnDefs: [
		    	  { className: "select-checkbox", targets: 1,  orderable: false },
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 9 }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabVerStrumenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabVerStrumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	selectRow();
	var array= [];	
	
 	table.on( 'select', function ( e, dt, type, indexes ) {
		console.log("inside")
		
		if($('#posTabSelezionati').text()== 'NESSUNO STRUMENTO SELEZIONATO'){
			 $('#posTabSelezionati').html("");
		}
	       
		var size = table.rows( indexes ).data().length;
		var add = true;
		for(var i = 0; i<size;i++){
			data = table.rows( indexes ).data()[i][2];	
			var row =  $('#posTabSelezionati')[0].children;
			for(var j = 0;j<row.length;j++){
				if(row[j].id == "row_"+data){
					add = false;
				}
			}
			if(add){
				var text ="<div class='row' id='row_"+data+"'><div class='col-xs-2'><label>ID</label><input class='form-control' type='text' id='id_"+data+"' readonly value='"+data +"'> </div><div class='col-xs-3'><label>Data prevista</label><div class='input-group date'>"
				+"<input type='text' id='data_"+data+"' class='form-control datepicker' style='width:100%'><span class='input-group-addon'>"
	            +"<span class='fa fa-calendar'></span></span></div></div>" 
				+"<div class='col-xs-3'><label>Ora prevista</label><div class='input-group time timepicker'>"
				+"<input type='text' id='ora_"+data+"' class='form-control timepicker' style='width:100%'><span class='input-group-addon'>"
	            +"<span class='fa fa-clock-o'></span></span></div></div><br></div>"
				$('#posTabSelezionati').append(text);		            
			}
		}
	     $('.datepicker').datepicker({
			 format: "dd/mm/yyyy"
		 });
	     $('.timepicker').timepicker({
	    	 showMeridian:false,
	    	 minuteStep: 1
	     });
	     
	}); 
	
 	
 	table.on( 'deselect', function ( e, dt, type, indexes ) {
		console.log("inside")
		  

		var size = table.rows( indexes ).data().length;
		
		for(var i = 0; i<size;i++){
			data = table.rows( indexes ).data()[i][2];	
			
			$('#row_'+data).remove();
			/* if(selected.includes(data)){
				$('#posTabSelezionati').html($('#posTabSelezionati').html().replace(data +";", ""));			
			} */
		}
	 	    if($('#posTabSelezionati').html()==""){
	 	    	$('#posTabSelezionati').html("NESSUNO STRUMENTO SELEZIONATO");	
	 	    }
	}); 
	
	$('#checkAll').on('ifChecked', function (ev) {

			$("#checkAll").prop('checked', true);
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();
			i = 0;
			table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
			    //if(i	<maxSelect){
					 this.select();
			   /*  }else{
			    		tableLoop.exit;
			    }
			    i++; */
			    
			} );

	  	});
		$('#checkAll').on('ifUnchecked', function (ev) {

			
				$("#checkAll").prop('checked', false);
				table.rows().deselect();
				var allData = table.rows({filter: 'applied'});
				table.rows().deselect();

		  	});
			
	
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