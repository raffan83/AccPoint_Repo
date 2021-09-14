<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<a class="btn btn-primary pull-right" onClick="$('#modalNuovaNota').modal()"><i class="fa fa-plus"></i>Nuova nota</a><br><br>

	 <table id="tabNote" class="table table-bordered table-hover dataTable table-striped" role="dialog" width="100%">
 <thead><tr class="active">

                       
                       
 						<th  hidden="hidden">ID</th>
  						<th>Modifiche</th>
 						  <th>Utente</th>
 						  <th>Data</th>                      
 </tr></thead>
 
 <tbody>
  <c:forEach items="${lista_note }" var="nota">

 <c:set var = "descrizione_nota" value = "${fn:split(nota.getDescrizione(), '|')}" />
 <tr>
 <td hidden="hidden" >${nota.id }</td>
 <td>
 <ul class="list-group ">
                

 <c:forEach items='${descrizione_nota}' var="descr" varStatus="loop">
 <c:if test="${loop.index == 0 }">
 <li class="list-group-item" style="background-color:#ffe6cc">${descr}<br></li>
 </c:if>
  <c:if test="${loop.index > 0 }">
 <li class="list-group-item" style="background-color:#ffffe6">${descr}<br></li>
 </c:if>
 </c:forEach> 
</ul>
 </td> 
<%--  <td>-${nota.descrizione.replace('|', '<br>-') }</td> --%>
 <td>${nota.user.nominativo }</td>
 <td><fmt:formatDate pattern="dd/MM/yyyy HH:mm:ss" value="${nota.data }"></fmt:formatDate></td>
 
 
 
 </tr>
 </c:forEach> 
 
 </tbody>
              			   		
              
</table> 



<form id="formNuovaNota" name="formNuovaNota" >
<div id="modalNuovaNota" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalNuovaNota').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Nota</h4>
      </div>
       <div class="modal-body">       
      
        <div class="row">
       <div class="col-xs-12">
       <label>Nota</label>

       <textarea id="nuova_nota" name="nuova_nota" rows="3" class="form-control" required></textarea>
       </div>
       </div>
      	
      	</div>
      <div class="modal-footer">

      
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>


<script>


console.log("test2")

/* function createTable(){
	
	var json = JSON.parse('${myObj}')
	
	var x = json;
	
}
 */


$(document).ready(function(){



	var tableNote = $('#tabNote').DataTable({
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
	     paging: true, 
	     ordering: true,
	     info: true, 
	     searchable: false, 
	     targets: 0,
	     responsive: true,
	     scrollX: false,
	     stateSave: true,
	     order:[[0, "desc"]],
	     columns : [
	    	 {"data" : "id"},  
	   	{"data" : "modifiche"},  
	     	{"data" : "utente"},
	     	{"data" : "data"}
	     	
			]
	   

	     
	   });




	$('#tabNote thead th').each( function () {
		var title = $('#tabNote thead th').eq( $(this).index() ).text();
		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
	} );
		
	$('.inputsearchtable').on('click', function(e){
			e.stopPropagation();    
	});

	// DataTable
		tableNote = $('#tabNote').DataTable();

	// Apply the search
	tableNote.columns().eq( 0 ).each( function ( colIdx ) {
		$( 'input', tableNote.column( colIdx ).header() ).on( 'keyup', function () {
			tableNote.column( colIdx ).search( this.value ).draw();		
		} );
	} ); 

	tableNote.columns.adjust().draw();
	
});

 
 $('#formNuovaNota').on('submit', function(e){
	
	 e.preventDefault();
	 nuovaNotaStrumento('#formNuovaNota', 'modificaStrumento.do?action=nuova_nota_strumento');
	 
 });
 
 
 
 

</script>