<%@page import="it.portaleSTI.DTO.ArticoloMilestoneDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%

	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
	ArrayList<ArticoloMilestoneDTO> listaArticoli =(ArrayList<ArticoloMilestoneDTO>)request.getSession().getAttribute("listaArticoli");

	Gson gson = new Gson();
	JsonArray listaArticoliJson = gson.toJsonTree(listaArticoli).getAsJsonArray();
	request.setAttribute("listaArticoliJson", listaArticoliJson);
	request.setAttribute("utente", utente);


	//System.out.println("***"+listaUtentiJson);	
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
       Configurazione Associazioni Articoli

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
       							<div class="nav-tabs-custom">
						            <ul id="mainTabs" class="nav nav-tabs">
						              <li class="active"><a href="#articoliaccessori" data-toggle="tab" aria-expanded="true"   id="articoliaccessoriTab">Associazione Articoli Accessori</a></li>
						              <li><a href="#articolidotazioni" data-toggle="tab" aria-expanded="false"   id="articolidotazioniTab">Associazione Articoli Dotazioni</a></li>

						            </ul>
						            <div class="tab-content">
						              	<div class="tab-pane active" id="articoliaccessori">
	
											 <div class="form-group">
									                  <label>Articoli</label>
									                  <select name="selectArticoloAccessorio" id="selectArticoloAccessorio" data-placeholder="Seleziona Articolo..."  class="form-control selectArticoloAccessorio" aria-hidden="true" data-live-search="true">
									                    <option value=""></option>
									                      <c:forEach items="${listaArticoli}" var="articolo1">
									                           <option value="${articolo1.ID_ANAART}" >${articolo1.ID_ANAART} - ${articolo1.DESCR}</option> 
									                     </c:forEach>
									
									                  </select>
									        </div>
									        <div class="row">
												<div class="col-xs-12">
												
												 	<div id="boxLista" class="box box-danger box-solid">
														<div class="box-header with-border">
														 	 Accessori
															<div class="box-tools pull-right">
															
																<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
													
															</div>
														</div>
														<div class="box-body">
															<div id="posTabAccessori">LISTA VUOTA</div>
														</div>
													</div>
												</div>
											</div>

						    			</div> 
						
										<div class="tab-pane" id="articolidotazioni">
						                	 <div class="form-group">
									                  <label>Articoli</label>
									                  <select name="selectArticoloDotazione" id="selectArticoloDotazione" data-placeholder="Seleziona Articolo..."  class="form-control selectArticoloDotazione" aria-hidden="true" data-live-search="true">
									                    <option value=""></option>
									                      <c:forEach items="${listaArticoli}" var="articolo2">
									                           <option value="${articolo2.ID_ANAART}" >${articolo2.ID_ANAART} - ${articolo2.DESCR}</option> 
									                     </c:forEach>
									
									                  </select>
									        </div>
									        <div class="row">
												<div class="col-xs-12">
												
												 	<div id="boxLista" class="box box-danger box-solid">
														<div class="box-header with-border">
														 	 Dotazioni
															<div class="box-tools pull-right">
															
																<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
													
															</div>
														</div>
														<div class="box-body">
															<div id="posTabDotazioni">LISTA VUOTA</div>
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


    	
    	 $("#selectArticoloDotazione").select2({width:'100%'});
     $("#selectArticoloAccessorio").select2({width:'100%'});
       
    	
    	
  	$("#selectArticoloAccessorio").change(function(e){
		
        //get the form data using another method 
        var articolo = $("#selectArticoloAccessorio").val();

       

        dataString ="idArticolo="+ articolo;
        exploreModal("listaAccessori.do",dataString,"#posTabAccessori",function(data,textStatus){

        });

        
 	 });
	$("#selectArticoloDotazione").change(function(e){
		
		var articolo = $("#selectArticoloDotazione").val();

	       

        dataString ="idArticolo="+ articolo;
        exploreModal("listaDotazioni.do",dataString,"#posTabDotazioni",function(data,textStatus){

        });

        
 	 });
	
});

   
	   
	
	
	    $('#myModalError').on('hidden.bs.modal', function (e) {
			if($( "#myModalError" ).hasClass( "modal-success" )){

			}
 		
  		});

  </script>
</jsp:attribute> 
</t:layout>
  
 
