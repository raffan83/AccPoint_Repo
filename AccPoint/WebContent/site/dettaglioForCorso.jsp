<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Corso
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-6">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio Corso
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${corso.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${corso.commessa}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Corso</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_corso}" /></a>
                </li>
                
                <li class="list-group-item">
                  <b>Data Scadenza</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_scadenza}" /></a>
                </li>
                <li class="list-group-item">
                <b>Docente</b> <a class="pull-right">${corso.docente.nome } ${corso.docente.cognome }</a>
                </li>
                <li class="list-group-item">
              
                <b>Numero partecipanti</b> <a class="pull-right" id="n_partecipanti"></a>
                </li>
                
  				 <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <b>Descrizione</b>
                  
                 <a class="pull-right">${corso.descrizione}</a>
                 </div>
                 </div>
                </li>
  				 
                
               
        </ul>

</div>
</div>
</div>




<div class="col-md-6">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio Tipologia
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               <li class="list-group-item">
                  <b>Codice</b> <a class="pull-right">${corso.corso_cat.codice}</a>
                </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Descrizione</b> <a class="pull-right">${corso.corso_cat.descrizione}</a>
                  </div>
                  </div>
                </li>                
                
                <li class="list-group-item">
                  <b>Frequenza (mesi)</b> <a class="pull-right">${corso.corso_cat.frequenza}</a>
                </li>
                <li class="list-group-item">
                  <b>Durata (ore)</b> <a class="pull-right">${corso.corso_cat.durata}</a>
                </li>
               
			<li class="list-group-item">
                <b>Edizione</b> <a class="pull-right">${corso.edizione}</a>
                </li>
               
        </ul>

</div>
</div>
</div>

       
 </div>
        <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Allegati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div id="tab_allegati"></div>

</div>
</div>
</div>
    
    </div>
    
    
   	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
  <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Questionario
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-md-12">

<c:if test="${corso.questionario== null || corso.questionario.salvato==0 }">
<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Compila questionario</a>
</c:if>

<c:if test="${corso.questionario!= null && corso.questionario.salvato==1 }">


<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Visualizza o modifica questionario</a>

</c:if>

</div>
</div>

</div>
</div>
</div>
    
    </div>
 </c:if>   
 
 
    	<c:if test="${userObj.checkRuolo('F2') && corso.questionario!= null && corso.questionario.salvato==1 }">
    	  <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Questionario
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-md-12">




<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Visualizza questionario</a>


</div>
</div>

</div>
</div>
</div>
    
    </div>
    	
    	</c:if>
 
 
    
    <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Partecipanti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div id="tab_partecipanti"></div>


</div>
</div>
</div>
    
    </div>
        
        
        

</div>
</div>
</div>
 </div> 
</section>
</div>



  
 
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  
</div>
  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<link type="text/css" href="css/bootstrap.min.css" />


<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  
 <script type="text/javascript">
 
 
 var columsDatatables = [];

 $("#tabPartecipanti").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabPartecipanti thead th').each( function () {
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
     	
     	  //if($(this).index()!=0 && $(this).index()!=1){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
 	    	//}

     	} );
     
     


 } );
 
 

 
function modalArchivio(id_corso){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria=0&id_corso="+ id_corso;
    exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
    });
$('#myModalArchivio').modal();
}
   
    $(document).ready(function() {
    

    	 dataString ="action=dettaglio_partecipanti_corso";
        exploreModal("gestioneFormazione.do",dataString,"#tab_partecipanti",function(datab,textStatusb){
        });
        
        modalArchivio('${corso.id}')
    });

  </script>
  
</jsp:attribute> 
</t:layout>

