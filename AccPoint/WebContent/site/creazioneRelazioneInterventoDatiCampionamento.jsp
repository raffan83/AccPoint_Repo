<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Creazione Relazione
        <small></small>
      </h1>
    </section>
<div style="clear: both;"></div>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            
      
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	Informazioni Intervento
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               
             
   
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
		  	<c:if test="${not empty interventoCampionamento.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataCreazione}" />
			</c:if>  
		</a>
                </li>
                
                <li class="list-group-item">
                  <b>Date Intervento</b> <a class="pull-right">
	
 			   				dal <fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataInizio}" /> al <fmt:formatDate pattern="dd/MM/yyyy" value="${interventoCampionamento.dataFine}" />
 					</a>
                </li>
                
               
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventoCampionamento.user.nominativo}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Lista Attività</b>
                  <div class=" list-group-no-border" >
                    <c:set var = "values" value = "${fn:split(interventoCampionamento.idAttivita, '|')}" />
                   <c:forEach items="${values}" var="it" varStatus="loop"><div class="list-group-item"><a class="">${it}</a></div></c:forEach>
                   	</div>
                </li>
                
                 
                <li class="list-group-item">
                  <b>Scheda Campionamento</b>  
     						<a href="scaricaSchedaCampionamento.do?action=schedaCampionamento&nomePack=${interventoCampionamento.nomePack}" id="downloadScheda" class="pull-right btn btn-info"><i class="glyphicon glyphicon-download"></i> Download Scheda</a>
	              	 
		 			<div class="spacer" style="clear: both;"></div>
                </li>
                
                <c:if test="${relazioneExist}">
                 <li class="list-group-item">
                  <b>Relazione Campionamento</b>  
     						<a href="creazioneRelazioneCampionamento.do?action=scaricaRelazioneCampionamento&idIntervento=${interventoCampionamento.id}" id="downloadRelazioone" class="pull-right btn btn-info"><i class="glyphicon glyphicon-download"></i> Download Relazione esistente</a>
	              	 
		 			<div class="spacer" style="clear: both;"></div>
                </li>
                </c:if>
              
               
        </ul>
  
	</div>
</div>
</div>
</div>      
            
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	Relazione
	<div class="box-tools pull-right">

		<!-- <button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button> -->

	</div>
</div>
	<div class="box-body">
		<div>
			<label>Allega Relazione</label>
			<input type="file" class="form-data" name="relazione" id="relazione">
		</div>
		
		<div>
			<label>Allega Relazione Laboratorio</label>
			<input type="file" class="form-data" name="relazioneLab" id="relazioneLab">
		</div>
	
		
	
		<div>
		
			<label>Conclusioni</label>
	       	<textarea class="form-control" id="editor1" rows="20" name="editor1" ></textarea>
	 	</div>
  
	</div>
	<div class="box-footer">

			<button class="btn btn-default pull-right" onClick="salvaRelazione(${interventoCampionamento.id})" >Genera Nuova Relazione</button>
  
	</div>
</div>
</div>
</div>      
                
            
           
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 </div>
</div>




  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>

 
  
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

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


 
 <script type="text/javascript">
   
 
    $(document).ready(function() { 
    	 $("#relazione").on('change', function(event) {
             var file = event.target.files[0];
         
             if(!file.type.match('application/pdf')) {
            	 	$('#myModalErrorContent').html("Inserire solo file in formato PDF");
   			  	$('#myModalError').removeClass();
   				$('#myModalError').addClass("modal modal-danger");
   				$('#myModalError').modal('show');
                 $("#relazione").val(''); //the tricky part is to "empty" the input file here I reset the form.
                 return false;
             }

           
         });
    	 
    	 $("#relazioneLab").on('change', function(event) {
             var file = event.target.files[0];
         
             if(!file.type.match('application/pdf')) {
                 $('#myModalErrorContent').html("Inserire solo file in formato PDF");
    			  	$('#myModalError').removeClass();
       				$('#myModalError').addClass("modal modal-danger");
       				$('#myModalError').modal('show');
                 $("#relazioneLab").val(''); //the tricky part is to "empty" the input file here I reset the form.
                 return false;
             }

           
         });

    
    		
    });
    function salvaRelazione(id){

    		//var objEditor1 = CKEDITOR.instances["editor1"].getData();
    		
    		var objEditor1 = $("#editor1").val();
    		var data = new FormData();
    		data.append('text', objEditor1);
    		data.append('relazione', $("#relazione")[0].files[0],"relazione.pdf");
    		data.append('relazioneLab', $("#relazioneLab")[0].files[0],"relazioneLab.pdf");
    		
    		
    	        $.ajax({
    	            type: 'POST',
    	            url: "creazioneRelazioneCampionamento.do?action=gerneraRelazioneCampionamento&idIntervento="+id,
    	            data: data,
    	            cache: false,
    	            contentType: false,
    	            processData: false,
    	            method: 'POST',
    	            success: function(data) {
    	                $("#show_tree").html(data);

    	            },
    	            error: function(req, status, error) { }
    	        });
	}
  </script>
</jsp:attribute> 
</t:layout>







