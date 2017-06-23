<%@page import="it.portaleSTI.Util.Costanti"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
	String cifresign = ""+Costanti.CIFRE_SIGNIFICATIVE;
	session.setAttribute("cifresign", cifresign);
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
        Dettaglio Misura
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
	 Dati Misura
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${misura.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Misura</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataMisura}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Strumento</b> <a class="pull-right">${misura.strumento.denominazione} (${misura.strumento.codice_interno})</a>
                </li>
                <li class="list-group-item">
                  <b>Temperatura</b> <a class="pull-right">
                  <fmt:formatNumber value="${misura.temperatura}" minFractionDigits="3"/>
                  
                  </a>
                </li>
                <li class="list-group-item">
                  <b>Umidità</b> <a class="pull-right">
                   <fmt:formatNumber value="${misura.umidita}" minFractionDigits="3"/></a>
                </li>
                 <c:if test = '${misura.obsoleto == "S"}'>
                <li class="list-group-item">
                  <b>Misura Obsoleta</b> 
                  
					 <a class="pull-right label label-danger">Obsoleta</a>
  				 </li>
  				</c:if>
  				<li class="list-group-item">
                  <b>Stato Ricezione</b> 
                  
					 <a class="pull-right">${misura.statoRicezione.nome}</a>
  				 </li>
  				 
                
               
        </ul>

</div>
</div>
</div>
</div>
            
            
            
            
              <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Punti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <c:forEach items="${arrayPunti}" var="punti">
 
<table id="tabPM" class="table table-bordered table-inverse dataTable" role="grid" width="100%">
 <thead><tr class="active">
  
  
  <c:if test = "${fn:startsWith(punti[0].tipoProva, 'L')}">
   <th>Tipo verifica</th>
 <th>Unità di misura</th>
 <th>Valore Campione</th>
 <th>Valore Strumento</th>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		  <th>Scostamento</th>
  		   <th>Accettabilità</th>
  </c:if>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		  <th>Correzione</th>
  </c:if>
    <th>Incertezza</th>
    <th>Esito</th>
  </c:if>
    
    <c:if test = "${fn:startsWith(punti[0].tipoProva, 'R')}">
  <th>Tipo verifica</th>
 <th>Unità di misura</th>
 <th>Valore Campione</th>
 <th>Valore Medio Campione</th>
 <th>Valore Strumento</th>
  <th>Valore Medio Strumento</th>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		  <th>Scostamento</th>
  		   <th>Accettabilità</th>
  </c:if>
    <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		  <th>Correzione</th>
  </c:if>
    <th>Incertezza</th>
    <th>Esito</th>
  
  </c:if>


 </tr></thead>
 
 <tbody>
<c:if test = "${fn:startsWith(punti[0].tipoProva, 'L')}">
 <c:forEach items="${punti}" var="puntoMisura">
 
 
 <tr role="row" id="${puntoMisura.id}">

	<td>
	
		${puntoMisura.tipoVerifica}
	
	</td>
		
	<td>${puntoMisura.um}</td>
	<td><fmt:formatNumber value="${puntoMisura.valoreCampione}" minFractionDigits="${cifresign}"/></td>

	<td><fmt:formatNumber value="${puntoMisura.valoreStrumento}" minFractionDigits="${cifresign}"/></td>

	 <c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		 <td><fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/></td>
  		  <td><fmt:formatNumber value="${puntoMisura.accettabilita}" minFractionDigits="${cifresign}"/></td>
  	</c:if>
	<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		 <td><fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/></td>
  </c:if>
	<td><fmt:formatNumber value="${puntoMisura.incertezza}" minFractionDigits="${cifresign}"/></td>
	<td>${puntoMisura.esito}</td>
	</tr>
  
	</c:forEach>

</c:if>
	<c:if test = "${fn:startsWith(punti[0].tipoProva, 'R')}">

  <c:set var="rowspanenabled" value="0"/>
   <c:set var="rowsiteration" value="1"/>
  
  
  
  <c:forEach items="${punti}" var="puntoMisura">
 


 	<c:set var="rowspan" value="${fn:substring(punti[0].tipoProva, 2, 3)}"/>
 	<c:if test = '${rowsiteration > rowspan}'>
 	  	<c:set var="rowspanenabled" value="0"/>
   		<c:set var="rowsiteration" value="1"/>
 	</c:if>

 	
 <tr role="row" id="${puntoMisura.id}">
	<td>
	
		${puntoMisura.tipoVerifica}
	
	</td>
		
	<td>${puntoMisura.um}</td>
	<td>
	<fmt:formatNumber value="${puntoMisura.valoreCampione}" minFractionDigits="${cifresign}"/>
	</td>
	
	
	
	<c:if test = '${rowspanenabled == 0}'>
	<td rowspan="${rowspan}" >
	<fmt:formatNumber value="${puntoMisura.valoreMedioCampione}" minFractionDigits="${cifresign}"/>
	</td>
	</c:if>
	
	<td><fmt:formatNumber value="${puntoMisura.valoreStrumento}" minFractionDigits="${cifresign}"/></td>
	
	<c:if test = '${rowspanenabled == 0}'>
		<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.valoreMedioStrumento}" minFractionDigits="${cifresign}"/></td>
	
	 	<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "SVT"}'>
  		 	<td rowspan="${rowspan}">
  		 	<fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/>
  		 	</td>
  		  	<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.accettabilita}" minFractionDigits="${cifresign}"/></td>
  		</c:if>
  	
		<c:if test = '${misura.strumento.scadenzaDTO.tipo_rapporto.noneRapporto == "RDT"}'>
  		 	<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.scostamento}" minFractionDigits="${cifresign}"/></td>
  		</c:if>
  
		<td rowspan="${rowspan}"><fmt:formatNumber value="${puntoMisura.incertezza}" minFractionDigits="${cifresign}"/></td>
		<td rowspan="${rowspan}">${puntoMisura.esito}</td>
	</c:if>
	
	</tr>
   <c:set var="rowspanenabled" value="1"/>
   <c:set var="rowsiteration" value="${rowsiteration + 1}"/>
	</c:forEach>
	
	</c:if>

 </tbody>
 </table> 
 </c:forEach> 
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
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
 <script type="text/javascript">
   
    $(document).ready(function() {
    	
    
    });
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



