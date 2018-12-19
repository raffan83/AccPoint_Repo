
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
       <!-- Attenzione! -->
        <small><!-- Fai click per entrare nel dettaglio della commessa --></small>
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">



<div class="row">
        <div class="col-xs-12">
        
        

 </div>
</div>



    <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione!</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
		Non si dispone dei permessi necessari per accedere a quest'area!
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-default " data-dismiss="modal">Chiudi</button>
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
     $('#myModal').modal();
    });
    

    
    
  </script>
  
  
</jsp:attribute> 
</t:layout>




