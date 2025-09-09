<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<br><br>
 <table id="tabCert" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

   <th>ID Certificato</th>
  <th>ID Misura</th>
  <th>ID Strumento</th>
  <th>ID Intervento</th>
  <th>Strumento</th>
  <th>Matricola | Cod</th>
 <th>Cliente</th>
 <th>Data Misura</th>
  <th>Data Emissione</th>
    <th>Operatore</th>
    <th>Numero certificato</th>
 <th style="min-width:60px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">

	<td>${certificato.id}</td>
	
 		<td>
 		<a  target="_blank"  class="customTooltip customlink"  href="dettaglioMisura.do?idMisura=${utl:encryptData(certificato.misura.id)}" >${certificato.misura.id }</a>
 		</td>
 		<td>
 		<a href="#" class="customTooltip customlink" onclick="dettaglioStrumento('${utl:encryptData(certificato.misura.strumento.__id) }')">${certificato.misura.strumento.__id }</a>
 		</td>
 		<td><a target="_blank" class=" customTooltip customlink" href="gestioneInterventoDati.do?idIntervento=${utl:encryptData(certificato.misura.intervento.id)}"> ${certificato.misura.intervento.id }</a></td>
		<td>${certificato.misura.strumento.denominazione}</td>
		<td>${certificato.misura.strumento.matricola} | ${certificato.misura.strumento.codice_interno}</td>
		<td>${certificato.misura.intervento.nome_cliente} - ${certificato.misura.intervento.nome_sede}</td>


		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataMisura}" /></td>
			<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.dataCreazione}" /></td>					


<td>${certificato.misura.interventoDati.utente.nominativo}</td>
<td>${certificato.misura.nCertificato}</td>
		<td  align="center" >
		
		<c:if test="${certificato.stato.id == 2 }">
		<c:if test="${certificato.misura.lat == 'N' }">
			<button class="btn btn-info  customTooltip" title="Rimetti certificato in lavorazione" onClick="rimettiInLavorazione(${certificato.id})"><i class="fa fa-arrow-left"></i></button>
			</c:if>
			<a target="_blank"   class="btn btn-danger customTooltip" title="Click per scaricare il Cerificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(certificato.misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
		</c:if>
		
		
		</td>
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table>  
 
 
  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
       
      
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
             </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div> 




<style>






        
 /*        .table th input {
    min-width: 45px !important;
} */

</style>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">





var columsDatatables = [];

 $("#tabCert").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabCert thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabCert thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    //	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

		    	if($(this).index() == 0){
	 				$(this).append( '<div><input class="inputsearchtable"  style="width:15px !important" type="text" /></div>');
	 			}
		    	else if($(this).index() ==11){
		    		
		    	}
		    	else{
	 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
	 			}
    	  
    	} );
    
    

} );
 
 function rimettiInLavorazione(id_certificato){
	 
	 dataObj={};
	 dataObj.id_certificato = id_certificato;
	 callAjax(dataObj, "gestioneModificheAdmin.do?action=cambia_stato",function(data){
		
		 if(data.success==true){
			 
			 $('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalErrorContent').html(data.messaggio);
				
				$('#myModalError').modal();
				
		 }
		 
		 
		 $('#myModalError').on("hidden.bs.modal", function(){
		
			 if($('#myModalError').hasClass("modal-success")){
				 exploreModal("gestioneModificheAdmin.do","action=ricerca&tipo_ricerca="+$('#tipo_ricerca').val()+"&id="+$('#id').val(),"#tabella");		 
			 }
		 });
		 
		 
		 
	 })
 }
 
 
	function dettaglioStrumento(id_strumento){

		$('#myModalLabelHeader').html("");
    	
		$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-success");
		$('#myModalError').css("z-index", "1070");
 	    	exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
 	    	$( "#myModal" ).modal();
 	    	//$('body').addClass('noScroll');
 
	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


       	var  contentID = e.target.id;

       	if(contentID == "dettaglioTab"){
       		exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
       	}
       	if(contentID == "misureTab"){
       		exploreModal("strumentiMisurati.do?action=ls&id="+id_strumento,"","#misure")
       	}
       	if(contentID == "modificaTab"){
       		exploreModal("modificaStrumento.do?action=modifica&id="+id_strumento,"","#modifica")
       	}
       	if(contentID == "documentiesterniTab"){
       		exploreModal("documentiEsterni.do?id_str="+id_strumento,"","#documentiesterni")
       
       	}
       	
       	
       	

 		});
	   
	}
 
	   $('#myModal').on('hidden.bs.modal', function (e) {

   	 	$('#dettaglioTab').tab('show');
   	 	
   	});

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2()
     
  


 		
 		

 	     table = $('#tabCert').DataTable({
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
 			      searchable: true, 
 			      targets: 0,
 			      responsive: true,
 			      scrollX: false,
 			      stateSave: true,	
 			           
 			      columnDefs: [
 			    	  
 			    	  { responsivePriority: 1, targets:11 },
 			    	  
 			    	  
 			               ], 	        
 		  	      buttons: [   
 		  	          {
 		  	            extend: 'colvis',
 		  	            text: 'Nascondi Colonne'  	                   
 		 			  } ]
 			               
 			    });
 		
 		
 	     
  
  		
     
		table.buttons().container().appendTo( '#tabCert_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabCert').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});



 
 


 
  </script>
  


