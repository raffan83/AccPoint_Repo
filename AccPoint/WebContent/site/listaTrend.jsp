<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
  
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%

	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
	ArrayList<CompanyDTO> listaCompanyarr =(ArrayList<CompanyDTO>)request.getSession().getAttribute("listaCompany");

	Gson gson = new Gson();
	JsonArray listaCompanyJson = gson.toJsonTree(listaCompanyarr).getAsJsonArray();
	request.setAttribute("listaCompanyJson", listaCompanyJson);
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
        Trend

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
						              <li class="active"><a href="#companytrend" data-toggle="tab" aria-expanded="true"   id="companytrendTab">Company Trend</a></li>
						           	  <li class=""><a href="#tipologietrend" data-toggle="tab"   id="companytrendTab">Tipologie Trend</a></li>
						            </ul>
						            <div class="tab-content">
						              	<div class="tab-pane active" id="companytrend">
	 										<div class="row">
												<div class="col-md-4">
											 <div class="form-group">
									                  <label>Company</label>
									                  <select name="selectCompany" id="selectCompany" data-placeholder="Seleziona Company..."  class="form-control selectCompany" aria-hidden="true" data-live-search="true">
									                    <option value=""></option>
									                      <c:forEach items="${listaCompany}" var="company">
									                           <option value="${company.id}">${company.denominazione}</option> 
									                     </c:forEach>
									
									                  </select>
									                    </div>
									                      </div>
									        </div>
									        <div class="row">
												<div class="col-xs-12">
												
												 	<div id="boxLista" class="box box-danger box-solid">
														<div class="box-header with-border">
														 	Lista Trend
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
						    			
						    			<div class="tab-pane" id="tipologietrend">
						    				

									        <div class="row">
												<div class="col-xs-12">
												
												 	<div id="boxLista" class="box box-danger box-solid">
														<div class="box-header with-border">
														 	Lista Tipologie Trend
															<div class="box-tools pull-right">
															
																<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
													
															</div>
														</div>
														<div class="box-body">
															<div id="posTabListaTipoTrend"></div>
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
	
	
	<div id="modalEliminaTrend" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare il trend?
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaTrend()">Elimina</button>
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
    	$("#selectCompany").select2();
     	
  
	$("#selectCompany").change(function(e){
		
        var company = $("#selectCompany").val();

        

        dataString ="idCompany="+ company;
        exploreModal("listaTrend.do?action=listaTrend",dataString,"#posTabRuoli",function(data,textStatus){
			
        });

        
 	 });

	    $('#myModalError').on('hidden.bs.modal', function (e) {
			if($( "#myModalError" ).hasClass( "modal-success" )){
				callAction("listaTrend.do?action=listaTrend");
			}
 		
  		});
	

	
	
	
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		  var target = $(e.target).attr("href") // activated tab
		  if(target == "#companytrend"){
			   var company = $("#selectCompany").val();
			   if(company != ""){
		        		dataString ="idCompany="+ company;
		       		 exploreModal("listaTrend.do?action=listaTrend",dataString,"#posTabRuoli",function(data,textStatus){
					
		        		});
			   }else{
				   $("#posTabRuoli").html("LISTA VUOTA");
			   }
		  }
		  if(target == "#tipologietrend"){
			  exploreModal("listaTrend.do?action=listaTipoTrend",null,"#posTabListaTipoTrend",function(data,textStatus){
					
      		});

		  }
		  
		});
	
	
});

   
	   
    

	    
  </script>
</jsp:attribute> 
</t:layout>
  
 
