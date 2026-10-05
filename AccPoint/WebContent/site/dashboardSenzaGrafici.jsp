<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@ page language="java" import="java.util.ArrayList" %>
 <%@page import="com.google.gson.Gson"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

%>

<c:choose>
<c:when test="${userObj.getListaRuoli().size()==1 && (userObj.checkRuolo('F1') || userObj.checkRuolo('F2')) }">
<c:set var="calver_color" value="blue"></c:set>
</c:when>
<c:when test="${userObj.getListaRuoli().size()==1 && (userObj.checkRuolo('D1') || userObj.checkRuolo('D2')) }">
<c:set var="calver_color" value="green"></c:set>
</c:when>
<c:otherwise>
<c:set var="calver_color" value="red"></c:set>
</c:otherwise>

</c:choose>


<t:layout title="Calver" bodyClass="skin-${calver_color }-light sidebar-mini wysihtml5-supported">



<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
     
     <section class="content-header">
       <h1 class="pull-left">
        Dashboard
        <small></small>
      </h1>
         <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    
    

    <div style="clear: both;"></div>    
    
<section class="content">
  <c:forEach items="${sidebarBlocchi}" var="b">
    <div class="row">
      <div class="col-xs-12">
        <div class="box">
          <c:if test="${not empty b.titolo}">
            <div class="box-header with-border">
              <h3 class="box-title">${b.titolo}</h3>
            </div>
          </c:if>
          <div class="box-body">
            <c:forEach items="${b.gruppi}" var="g">
              <div class="dash-gruppo">
                <h4 class="dash-gruppo-titolo">${g.titoloGruppo}</h4>
                <ul class="dash-voci">
                  <c:forEach items="${g.voci}" var="v">${v}</c:forEach>
                </ul>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
  </c:forEach>
</section>
		
     
     

  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

<style>
  .dash-gruppo-titolo {
    margin: 0 0 12px 0;
    font-size: 15px;
    font-weight: 600;
    color: #555;
  }

  /* mezza linea tra un gruppo e il successivo (non dopo l'ultimo) */
  .dash-gruppo:not(:last-child)::after {
    content: "";
    display: block;
    width: 50%;
    margin: 22px auto 18px auto;      /* usa "22px 0 18px 0" per allinearla a sinistra */
    border-bottom: 1px solid #d2d6de;
  }

  .dash-voci {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 12px;
  }
  .dash-voci li { display: contents; }

  .dash-voci li a {
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    min-height: 90px;
    padding: 12px;
    border-radius: 4px;
    color: #fff;
    font-size: 16px;
    font-weight: 600;
    text-decoration: none;
    background: #3c8dbc;
    box-shadow: 0 1px 3px rgba(0,0,0,.2);
    transition: filter .15s, transform .15s;
  }
  .dash-voci li a:hover { filter: brightness(.88); transform: translateY(-2px); color: #fff; }
  .dash-voci li a i { margin-right: 8px; }

  .skin-green-light .dash-voci li a { background: #00a65a; }
  .skin-red-light   .dash-voci li a { background: #dd4b39; }
</style>
<c:if test="${userObj.checkRuolo('F1')|| userObj.checkRuolo('F2') }">

<style>

.table th {
    background-color: #3c8dbc !important;
  }</style>

</c:if>




</style>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>
 	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
	<script src="https://cdn.datatables.net/plug-ins/1.10.16/sorting/date-euro.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.js"></script> 

<script type="text/javascript">

    	 
    	 
</script>
</jsp:attribute> 
</t:layout>


