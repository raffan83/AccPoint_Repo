<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
    <%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClassificazioneDTO"%>
<%@page import="it.portaleSTI.DTO.LuogoVerificaDTO"%>
<%@page import="it.portaleSTI.DTO.StatoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>    
    <% 
/* JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo"); */
Gson gson = new Gson();
/* Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType); */


UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");


String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");



ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");


%>



<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoStrumento')">Nuovo Strumento</button>

<br><br>

 <table id="tabStrumentiItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th>ID</th>
 <th>Codice Interno</th>
 <th>Matricola</th>
 <th>Descrizione</th>
 <th>Attività</th>
 <th>Destinazione</th> 
 <th>Note</th>
 <td><label>Priorità</label></td>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti}" var="strumento" varStatus="loop">
<tr>

<td align="center">

<a   class="btn btn-primary pull-center"  title="Click per inserire l'item"   onClick="insertItem('${strumento.__id}','${strumento.denominazione}')"><i class="fa fa-plus"></i></a>

</td>
<td>${strumento.__id}</td>
<td>${strumento.codice_interno}</td>
<td>${strumento.matricola}</td>
<td>${strumento.denominazione }</td>
<td><input type="text" id="attivita_item${strumento.__id}"  style="width:100%"></td>
<td><input type="text" id="destinazione_item${strumento.__id }" style="width:100%"></td>
<td><input type="text" id="note_item${strumento.__id}"  style="width:100%"></td> 
<td><input type="checkbox" id="priorita_item${strumento.__id}"/></td> 

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 

 
 



<div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">

        <button type="button" class="close" id=close_button_modal aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Strumento</h4>
      </div>
       <div class="modal-body">

        <form class="form-horizontal" id="formNuovoStrumento">
              

       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <div class="col-sm-10">

                      
                      <select name="ref_tipo_strumento" id="ref_tipo_strumento" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                        <option></option> 
                                            <%
                                            for(TipoStrumentoDTO str :listaTipoStrumento)
                                            {
                                            	 %> 
                            	            	 <option value="<%=str.getId()+"_"+str.getNome() %>"><%=str.getNome() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                      </select>
    </div>
       </div> 
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Rapporto:</label>
        <div class="col-sm-10">

                                            <select class="form-control select2" aria-hidden="true" data-live-search="true" id="ref_tipo_rapporto" style="width:100%" required name="ref_tipo_rapporto"  >
                                             <option></option> 
                                            <%
                                            for(TipoRapportoDTO rapp :listaTipoRapporto)
                                            {
                                            	 %> 
                            	            	 <option value="<%=rapp.getId() %>"><%=rapp.getNoneRapporto() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
                      
    </div>
       </div> 

                      <input class="form-control" id="freq_mesi" type="hidden" max="120" name="freq_mesi"  disabled="disabled" value="12"/>


                      <input class="form-control datepicker" id="dataUltimaVerifica" type="hidden" name="dataUltimaVerifica" disabled="disabled" value="" data-date-format="dd/mm/yyyy"/>


                      <input class="form-control datepicker" id="dataProssimaVerifica" type="hidden" name="dataProssimaVerifica" disabled="disabled" value="" data-date-format="dd/mm/yyyy"/>
 

				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Classificazione:</label>
        <div class="col-sm-10">

                       
                       <select class="form-control select2" aria-hidden="true" data-live-search="true" id="classificazione" style="width:100%" required name="classificazione"  >
                                            <option></option>
                                            <%
                                            for(ClassificazioneDTO clas :listaClassificazione)
                                            {
                                            	 %> 
                            	            	 <option value="<%=clas.getId() %>"><%=clas.getDescrizione() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 
       
                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Quantità:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="quantita_strumento" type="number" min=1 name="quantita_strumento" required value=""/>
    </div>
       </div>
       
				
                <button type="submit" class="btn btn-primary" >Salva</button>
        
     
        </form>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>

 
 

 

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


 <script type="text/javascript">
 
 $('.select2').select2();

$('#close_button_modal').on('click', function(){
	$('#modalNuovoStrumento').modal('hide');
});
 
 	//var columsDatatables = []; 
	 
	$("#tabStrumentiItem").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
/*  	    $('#tabStrumentiItem thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabStrumentiItem thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );  */

	} );


 
	$('#formNuovoStrumento').on('submit',function(e){
	    e.preventDefault();
	    
	   if(nuovo){
		   var idPacco = ${pacco.id}+1; 
	   }else{
		   var idPacco = ${pacco.id};
	   }
	  
		nuovoStrumentoFromPacco(<%= idSede %>,<%= idCliente %>,idPacco);

	});

	
	$('#myModalError').on("hidden.bs.modal", function (){
		
		$('.modal-backdrop').remove();
		
	});
	
	
	
	 function insertItem(id, descrizione){
		 
		 var note = $('#note_item'+id).val();

		 var priorita = 0;
		 if($('#priorita_item'+id).is( ':checked' ) ){			
		 priorita = 1;
		 }
		 
		 var attivita = $('#attivita_item'+id).val();
		 var destinazione = $('#destinazione_item'+id).val();
		 insertEntryItem(id,descrizione, 'Strumento', 1, note, priorita, attivita, destinazione);
	 }
	
   $(document).ready(function() {
	   
	   
	   
 	   	var columsDatatables = []; 
	   
	   
	      $('#tabStrumentiItem thead th').each( function () {
    	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
   	var title = $('#tabStrumentiItem thead th').eq( $(this).index() ).text();
   	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
   	} );  
	   
	   
	   var today = moment();
	   $("#dataUltimaVerifica").attr("value", today.format('DD/MM/YYYY'));
	   
	   var futureMonth = moment(today).add(12, 'M');
		  var futureMonthEnd = moment(futureMonth).endOf('month');
		 

		  $("#dataProssimaVerifica").val(futureMonth.format('DD/MM/YYYY'));
		  $("#dataProssimaVerifica").attr("required", true);
	   

		 $('.customTooltip').tooltipster({
		        theme: 'tooltipster-light'
		    });
	   
	   
	   
	   
 table = $('#tabStrumentiItem').DataTable({
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
	      responsive: false,
	      scrollX: true,
	      stateSave: true,
	       columnDefs: [
				   { responsivePriority: 1, targets: 5 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
//DataTable
table = $('#tabStrumentiItem').DataTable();
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
	

$('#tabStrumentiItem').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	});


});



  });   


</script>