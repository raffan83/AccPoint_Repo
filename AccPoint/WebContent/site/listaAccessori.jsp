<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.AccessorioDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%



	%>
	
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Accessori

      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoAccessorio')">Nuovo Accessorio</button><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Company</th>
 <th>Nome</th>
 <th>Descrizione</th>
 <th>Quantità Fisica</th>
 <th>Quantità Prenotata</th>
 <th>Quantità Effettiva</th>
 <th>Action</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaAccessori}" var="accessorio" varStatus="loop">

	 <tr role="row" id="${accessorio.id}-${loop.index}">

	<td>${accessorio.id}</td>
	<td>${accessorio.company.denominazione}</td>
	<td>${accessorio.nome}</td>
	<td>${accessorio.descrizione}</td>
	<td>${accessorio.quantitaFisica}</td>
	<td>${accessorio.quantitaPrenotata}</td>
	
		 <c:set var="quantitaEffettiva" value="${accessorio.quantitaPrenotata + accessorio.quantitaFisica}" />
	
	<td>${quantitaEffettiva}</td>
	<td>

		<%-- <a href="#" onClick="modalModificaAccessorio('${accessorio.id}','${accessorio.company.id}','${accessorio.nome}','${accessorio.descrizione}','${accessorio.quantitaFisica}','${accessorio.quantitaPrenotata}')" class="btn btn-warning "><i class="fa fa-edit"></i></a>  --%>
		<a href="#" onClick="modalEliminaAccessorio('${accessorio.id}','${accessorio.nome}')" class="btn btn-danger "><i class="fa fa-remove"></i></a>

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 </div>
</div>
</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





  


<div id="modalNuovoAccessorio" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Accessorio</h4>
      </div>
      <form class="form-horizontal"  id="formNuovoAccessorio">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
   
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovoAccessorio">


            
        <div class="form-group">
          	<label for="nome" class="col-sm-2 control-label">Nome:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="nome" type="text" name="nome" value=""  required />
     		</div>
     	 
   		</div>
    		<div class="form-group">
          	<label for="user" class="col-sm-2 control-label">Descrizione:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="descrizione" type="text" name="descrizione" value=""   required />
     		</div>
     	 
   		</div>
   		<div class="form-group">
          	<label for="user" class="col-sm-2 control-label">Quantità:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="quantita" type="text" name="quantita" value=""   required />
     		</div>
     	 
   		</div>



       
	 </div>

              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>



<div id="modalModificaAccessorio" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Accessorio</h4>
      </div>
      <form class="form-horizontal"  id="formModificaAccessorio">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
     
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="modificaAccessorio">

         			<input class="form-control" id="modid" name="modid" value="" type="hidden" />
        
            
                <div class="form-group">
          <label for="modnome" class="col-sm-2 control-label">Nome:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="modnome" type="text" name="modnome" value="" maxlength="2"  />
     	</div>
    
   </div>
    


    <div class="form-group">
          <label for="moddescrizione" class="col-sm-2 control-label">Descrizione:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="moddescrizione" type="text" name="moddescrizione" value=""  />
         
			
     	</div>
   </div>

 <div class="form-group">
          <label for="modquantita" class="col-sm-2 control-label">Quantita:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="modquantita" type="text" name="modquantita" value=""  />
         
			
     	</div>
   </div>
       
	 </div>

              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>

<div id="modalEliminaAccessorio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare l'accessorio <span id="accessorioElimina"></span>
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaAccessorio()">Elimina</button>
    </div>
  </div>
    </div>

</div>

<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
        
  		 </div>
      
    </div>
     <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
    </div>
  </div>
    </div>

</div>
</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<script type="text/javascript">



   </script>

  <script type="text/javascript">

  
    $(document).ready(function() {
    

    	

    	table = $('#tabPM').DataTable({
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 }

  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                   /* exportOptions: {
  	                       modifier: {
  	                           page: 'current'
  	                       }
  	                   } */
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
  
  $('#tabPM thead th').each( function () {
      var title = $('#tabPM thead th').eq( $(this).index() ).text();
      $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
  } );

  // DataTable
	table = $('#tabPM').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup change', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  	table.columns.adjust().draw();
    	
    	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    	
    	
    	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});

	$('#formNuovoAccessorio').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    nuovoAccessorio();

	});
   
	$('#formModificaAccessorio').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    modificaAccessorio();

	}); 
	      
	    });


	    var validator = $("#formNuovoAccessorio").validate({
	    	showErrors: function(errorMap, errorList) {
	    	  
	    	    this.defaultShowErrors();
	    	  },
	    	  errorPlacement: function(error, element) {
	    		  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");
	    		 },
	    		 
	    		    highlight: function(element) {
	    		        $(element).closest('.form-group').addClass('has-error');
	    		        $(element).closest('.ui-widget-content input').addClass('error');
	    		        
	    		    },
	    		    unhighlight: function(element) {
	    		        $(element).closest('.form-group').removeClass('has-error');
	    		        $(element).closest('.ui-widget-content input').removeClass('error');
	    		       
	    		    }
	    });

	  
	
	
	    $('#myModalError').on('hidden.bs.modal', function (e) {
			if($( "#myModalError" ).hasClass( "modal-success" )){
				callAction("listaAccessori.do");
			}
 		
  		});

  </script>
</jsp:attribute> 
</t:layout>
  
 
