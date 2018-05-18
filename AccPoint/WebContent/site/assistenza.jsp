<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:layout title="Assistenza" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
      <section class="content-header">
      <h1 class="pull-left">
        ASSISTENZA
        </h1>
           <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>

    <!-- Main content -->
    <section class="content">
   	
   
   <div class="item">


                <div class="content-header">
                  <h1><small>Per assistenza contattare i seguenti numeri</small></h1>
                  
                <br />
				<img alt="numeroVerde" src="images/Numero-Verde-300x120.png" />
                
              </div>
</section>
   
   
   
  </div>
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

</jsp:attribute> 
</t:layout>


