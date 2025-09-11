<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
StrumentoDTO strumento=(StrumentoDTO)gson.fromJson(jsonElem,StrumentoDTO.class); 
session.setAttribute("strumento", strumento);
SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");
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
          <h1 class="pull-left">
        Dettaglio Strumento
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            
           <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true"   id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false"   id="misureTab">Dettaglio Misure</a></li>
      <li class=""><a href="#notestrumento" data-toggle="tab" aria-expanded="false" onclick="" id="noteStrumentoTab">Note Strumento</a></li>
              
			</ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">



    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="misure">
                

         
			 </div>
			 <div class="tab-pane" id="notestrumento">
              			   		

              			</div> 

              <!-- /.tab-pane -->

			
            </div>
            <!-- /.tab-content -->
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
  <jsp:attribute name="extra_js_footer">
 <script type="text/javascript">
   
    $(document).ready(function() {
    	exploreModal("dettaglioStrumento.do?id_str=${utl:encryptData(strumento.__id)}","","#dettaglio");
    	 $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


    	       	var  contentID = e.target.id;


    	       	if(contentID == "dettaglioTab"){
    	       	
    	       		exploreModal("dettaglioStrumento.do?id_str=${utl:encryptData(strumento.__id)}","","#dettaglio")
    	       	}
    	       	if(contentID == "misureTab"){
    	       		exploreModal("strumentiMisurati.do?action=ls&id=${utl:encryptData(strumento.__id)}","","#misure")
    	       	}
    	     
    	       	if(contentID == "noteStrumentoTab"){
    	    		
    	       		exploreModal("listaStrumentiSedeNew.do?action=note_strumento&id_str=${utl:encryptData(strumento.__id)}","","#notestrumento")
    	       	 }
    	       	
    	       	

    	 		});
    });
  </script>
  
</jsp:attribute> 
  
  	  
  
  </t:layout>   
				