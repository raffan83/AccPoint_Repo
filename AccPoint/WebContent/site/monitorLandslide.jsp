<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Monitor Landslide
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

	<div id="area">
	 <textarea rows="15" style="width:50%" id="lettore" readonly></textarea>
	 <a class="btn btn-danger pull-right" onClick="cambiaStato()" id="stop" style="display:none">Stop</a>
	<a class="btn btn-primary pull-right" onClick="cambiaStato()" id="start" style="display:none">Start</a>
	</div>
	


</div>
</div>


</section>



</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script type="text/javascript">
 
 
var start = true;

function cambiaStato(){
	 if(start){
		 start = false;	 
		 $('#start').show();
		 $('#stop').hide();
	 }else{
		 start = true;
		 sendRequest();
		 $('#stop').show();
		 $('#start').hide();
	 }		 
}
 
 

 $(document).ready(function()
{
	 $('#stop').show();
	  if(start){
		 sendRequest();	 
	 } 
	 
 
	
});
 var index = 0;
 
 function sendRequest(){
     $.ajax({
       url: "monitorLandslide.do?action=lettore",
       success: 
         function(data){
           if(index<100){
        	 if(index==0){
        		 $('#lettore').append(data); 
        	 }else{
        		 $('#lettore').append("\n"+data); 
        	 }        	 
          }else{
        	  $('#lettore').html(data);        	  
        	  index = 0;
          }
          index++; 
       },
      complete: function() {
       //setInterval(sendRequest, 5000); // The interval set to 5 seconds
      if(start){
    	sendRequest();        	
        $('#lettore').scrollTop($('#lettore')[0].scrollHeight);  
      }      	
    }
   });
 };
 
 


  </script>
  
</jsp:attribute> 
</t:layout>
