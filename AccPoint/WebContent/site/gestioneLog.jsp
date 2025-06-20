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
       Logs
        </h1>
           <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">
   	
    <c:choose>
        <c:when test="${not empty lines}">
            <c:forEach var="line" items="${lines}">
                <div class="line">${line}</div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>Nessun contenuto disponibile.</p>
        </c:otherwise>
    </c:choose>
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


