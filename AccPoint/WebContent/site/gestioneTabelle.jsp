<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>


	
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
        Configurazione Tabelle

      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
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
       							<div class="nav-tabs-custom">
						            <ul id="mainTabs" class="nav nav-tabs">
						              <li class="active"><a href="#utentiruoli" data-toggle="tab" aria-expanded="true"   id="utentiruoliTab">Associazione Utenti Ruoli</a></li>
						               
						           
						            </ul>
						            <div class="tab-content">
						              	<div class="tab-pane active" id="utentiruoli">
	
											 <div class="form-group">
									                  <label>Utenti</label>
									                  <select name="selectUtente" id="selectUtente" data-placeholder="Seleziona Utente..."  class="form-control selectUtente" aria-hidden="true" data-live-search="true">
									                    <option value=""></option>
									                      <c:forEach items="${listaTabelle}" var="tabelle">
									                           <option value="${utente.id}">${utente.nominativo}</option> 
									                     </c:forEach>
									
									                  </select>
									        </div>
									        <div class="row">
												<div class="col-xs-12">
												
												 	<div id="boxLista" class="box box-danger box-solid">
														<div class="box-header with-border">
														 	Lista Ruoli
															<div class="box-tools pull-right">
															
																<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
													
															</div>
														</div>
														<div class="box-body">
															<div id="posTabRuoli">LISTA VUOTA</div>
														</div>
													</div>
												</div>
											</div>

						    			</div> 
						              <!-- /.tab-pane -->
						            </div>
						            <!-- /.tab-content -->
						          </div>
       						
       						</div>
        				</div>
        			</div>
       			</div>
        	</div>
        </div>







<!-- 
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
	       -->
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
    	$("#selectUtente").select2();
    	$("#selectRuolo").select2();
    	$("#selectRuoloUtente").select2();
    	
  	$("#selectRuolo").change(function(e){
		
        //get the form data using another method 
        var ruolo = $("#selectRuolo").val();

       

        dataString ="idRuolo="+ ruolo;
        exploreModal("listaPermessi.do",dataString,"#posTabPermessi",function(data,textStatus){

        });

        
 	 });
	$("#selectRuoloUtente").change(function(e){
		
        var ruolo = $("#selectRuoloUtente").val();

        

        dataString ="idRuolo="+ ruolo;
        exploreModal("listaUtenti.do",dataString,"#posTabUtenti",function(data,textStatus){

        });

        
 	 });
	
	$("#selectUtente").change(function(e){
		
        var utente = $("#selectUtente").val();

        

        dataString ="idUtente="+ utente;
        exploreModal("listaRuoli.do",dataString,"#posTabRuoli",function(data,textStatus){
			
        });

        
 	 });
  	
});

   
	   
	
	
	    $('#myModalError').on('hidden.bs.modal', function (e) {
			if($( "#myModalError" ).hasClass( "modal-success" )){
				callAction("listaUtenti.do");
			}
 		
  		});

  </script>
</jsp:attribute> 
</t:layout>
  
 
