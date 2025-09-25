<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
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
        Schede di Consegna
        
      </h1>
      
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
       
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div style="clear: both;"></div>
<div class="row">
        <div class="col-xs-12">


 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Schede Consegna
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">



        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active" id="tab1"><a href="#standard" data-toggle="tab" aria-expanded="true"   id="standardTab">Schede di Consegna</a></li>
              		<li class="" id="tab2"><a href="#rilievi" data-toggle="tab" aria-expanded="false"   id="rilieviTab">Rilievi Dimensionali</a></li>
              		<li class="" id="tab3"><a href="#verificazione" data-toggle="tab" aria-expanded="false"   id="rilieviTab">Verificazione</a></li>
              <li class="" id="tab4"><a href="#report_interventi" data-toggle="tab" aria-expanded="false"   id="ReportTab">Report Interventi</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="standard">
              

<div class="row">
<div class="col-sm-12">
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraSchedePerData()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>

</div>
</div>
              
          
	<table id="tabSC" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Intervento</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Data Creazione Intervento</th>
 <th>Commessa</th>
 <th>Data Creazione Scheda</th>
 <th>Stato</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_schede_consegna}" var="scheda" varStatus="loop">
 <c:if test="${scheda.abilitato==1}">

	 <tr role="row" id="${scheda.id}-${loop.index}">

<td>

<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(scheda.intervento.id)}');">
		${scheda.intervento.id}
	</a>
</td>
<td>${scheda.intervento.nome_cliente }</td>
<td>${scheda.intervento.nome_sede }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scheda.intervento.dataCreazione }" /></td>
<td>${scheda.intervento.idCommessa }</td>
<td>${scheda.data_caricamento.split(' ')[0]}</td>
<td>
<c:choose>
<c:when test="${scheda.stato==0 }">
Da Fatturare
</c:when>
<c:otherwise>
Fatturata
</c:otherwise>
</c:choose>
</td>
<td>
<a  target="_blank" class="btn btn-danger customTooltip  pull-center" title="Click per scaricare la scheda di consegna"   onClick="scaricaSchedaConsegnaFile('${utl:encryptData(scheda.intervento.id)}', '${scheda.nome_file}')"><i class="fa fa-file-pdf-o"></i></a>
 <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','0')"><i class="glyphicon glyphicon-refresh"></i></a>  	
	</tr>
	</c:if>
	
	</c:forEach>
 
	
 </tbody>
 </table> 

    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="rilievi">
              
              
              <div class="row">
<div class="col-sm-12">
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarangeRil" name="datarangeRil" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraSchedePerDataRil()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				               
				             </span>	
				            			                     
  					</div>  		
  											
			 </div>	
			 
			 

	</div>
	<div class="col-xs-6">
	 <button type="button" style="margin-left:5px" class="btn btn-primary pull-right" onclick="modalCreaSchede()">Crea Schede Consegna</button>
	 
	 </div>

</div>
</div>
              
              
              
              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Mese</th>
 <th>Anno</th>
 <th>Commessa</th>
 <th>Data Creazione</th> 
 <th>Stato</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_schede_consegna_rilievi}" var="scheda" varStatus="loop">

<tr role="row" id="${scheda.id}-${loop.index}">
	
<td>${scheda.id}</td>
<td>${scheda.nome_cliente }</td>
<td>${scheda.nome_sede}</td>
<td>${scheda.mese}</td>
<td>${scheda.anno}</td>
<td>${scheda.commessa }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scheda.data_creazione}" /></td>
<td>
<c:choose>
<c:when test="${scheda.stato==0 }">
Da Fatturare
</c:when>
<c:otherwise>
Fatturata
</c:otherwise>
</c:choose>
</td>
<td>
 <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda di consegna"   onClick="scaricaSchedaConsegnaFile('','${scheda.file}', '${utl:encryptData(scheda.id)}')"><i class="fa fa-file-pdf-o"></i></a>
 <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','1')"><i class="glyphicon glyphicon-refresh"></i></a>  
<%-- <a  target="_blank" class="btn btn-primary customTooltip  pull-center" title="Click per eliminare la scheda di consegna"   onClick="eliminaSchedaConsegna(${scheda.id})"><i class="fa fa-remove" style="color:black"></i></a> --%>	
</td>
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table>  
                

         
			 </div>
			 
			 
			 
			 
			  <div class="tab-pane table-responsive" id="verificazione">
              
              
              <div class="row">
<div class="col-sm-12">
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarangeVer" name="datarangeVer" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraSchedePerDataVer()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>

</div>
</div>
              
              
              
              <table id="tabVer" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
<thead><tr class="active">
 <th>ID Intervento</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Data Creazione Intervento</th>
 <th>Commessa</th>
 <th>Data Creazione Scheda</th>
 <th>Stato</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_schede_consegna_verificazione}" var="scheda" varStatus="loop">
 <c:if test="${scheda.abilitato==1}">

 	<tr role="row" id="${scheda.id}-${loop.index}">
			<td>
			
			<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dell'Intervento Verificazione" onclick="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(scheda.ver_intervento.id)}')">
					${scheda.ver_intervento.id}
				</a>
			</td>
			<td>${scheda.ver_intervento.nome_cliente }</td>
			<td>${scheda.ver_intervento.nome_sede }</td>
			<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scheda.ver_intervento.data_creazione }" /></td>
			<td>${scheda.ver_intervento.commessa }</td>
			<td>${scheda.data_caricamento.split(' ')[0]}</td>
			<td>
			<c:choose>
			<c:when test="${scheda.stato==0 }">
			Da Fatturare
			</c:when>
			<c:otherwise>
			Fatturata
			</c:otherwise>
			</c:choose>
			</td>
			<td>
			<a  target="_blank" class="btn btn-danger customTooltip  pull-center" title="Click per scaricare la scheda di consegna"   onClick="scaricaSchedaConsegnaFile('${utl:encryptData(scheda.ver_intervento.id)}', '${scheda.nome_file}',null,true)"><i class="fa fa-file-pdf-o"></i></a>
			 <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','0')"><i class="glyphicon glyphicon-refresh"></i></a>  	
				</tr>
 	
 	</c:if>
     </c:forEach>    
     </tbody>
     </table>
			 </div>



<div class="tab-pane table-responsive" id="report_interventi">
              
              
              <div class="row">
<div class="col-sm-12">
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarangeRap" name="datarangeRap" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraSchedePerDataRap()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>

</div>
</div>
              
              
              
              <table id="tabRap" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
<thead><tr class="active">
 <th>ID Rapporto</th>
  <th>Intervento</th>
  <th>Data Intervento</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Commessa</th>
 <th>Email Destinatario</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_rapporti_intervento}" var="rapporto" varStatus="loop">

 	<tr role="row" id="${scheda.id}-${loop.index}">
 	
 	<td>${rapporto.id}</td>
			<td>
			
			<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(rapporto.intervento.id)}')">
					${rapporto.intervento.id}
				</a>
			</td>
			<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rapporto.intervento.dataCreazione }" /></td>
			<td>${rapporto.intervento.nome_cliente }</td>
			<td>${rapporto.intervento.nome_sede }</td>			
			<td>${rapporto.intervento.idCommessa }</td>
			
			<td><input type="text" id="destinatario_${rapporto.id }" name="destinatario_${rapporto.id }" style="width:100%" class="form-control"></td>

			<td>
			<a  target="_blank" class="btn btn-danger customTooltip  pull-center" title="Click per scaricare il rapporto intervento"  href="gestioneRapportoIntervento.do?action=download&id_intervento=${rapporto.intervento.id}"><i class="fa fa-file-pdf-o"></i></a>
			<%--  <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','0')"><i class="glyphicon glyphicon-refresh"></i></a> --%>  	
				</tr>
 	
 	
     </c:forEach>    
     </tbody>
     </table>
			 </div>


              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>


</div>
</div>
</div>
</div>



  <div id="modalCreaSchede" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Cerca Rilievi</h4>
      </div>
       <div class="modal-body">
              <div class="row">
			<div class="col-sm-6">
				
						 <div class="form-group">
							 <label for="datarange" class="control-label">Ricerca Data:</label>
								<div class="col-md-12 input-group" >
									<div class="input-group-addon">
							             <i class="fa fa-calendar"></i>
							        </div>				                  	
									 <input type="text" class="form-control" id="datarangeSchede" name="datarangeSchede" value=""/> 						    
										 <span class="input-group-btn">
							               <button type="button" class="btn btn-info btn-flat" onclick="cercaRilieviSchede()">Cerca</button>
							               
							             </span>				                     
			  					</div>  								
						 </div>	
						 </div>
						 </div>
						 <div class="row" id="content_schede" style="display:none">
      	<div class="col-xs-12">
      	<table id="table_crea_schede" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
      	 <thead><tr class="active">

		<td align="center"><input style="margin-top:15px" id="selectAlltabPM" type="checkbox" /></td>
		<th>Commessa</th>
		<th>Cliente</th>
		<th>Sede</th>
		
		
		 </tr></thead>
		 
		 <tbody>
		</tbody>
      	</table>
      	 </div>
      	
      	
      	</div>
						 
			
			
			
		
  		 </div>
      <div class="modal-footer">
      
      <a class="btn btn-primary" onclick="creaSchedeCosegna()">Crea Schede Consegna</a>
      
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

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<script type="text/javascript">
  
  
  
/*   $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {


  	var  contentID = e.target.id;

  	
/*   	if(contentID == "standardTab"){
  		
  		//exploreModal("showSchedeConsegna.do","","#standard");
  	} */
/*   	if(contentID == "rilieviTab"){
  		
  		exploreModal("showSchedeConsegna.do","action=rilievi","#rilievi");
  		$('#rilieviTab').show();
  	} 
  	

	}); */
	
	
	
	function modalCreaSchede(){
		
			$('#modalCreaSchede').modal();

	}
  
  
  function filtraSchedePerData(){
		
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
		var endDatePicker = $("#datarange").data('daterangepicker').endDate;
		
		dataString = "?action=filtra_date&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD')+"&rilievo=0&verificazione=0";
			 	
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();

		callAction("listaSchedeConsegna.do"+ dataString, false,true);
			 	
				
			}
	
	  function filtraSchedePerDataRil(){
			
			
			var startDatePicker = $("#datarangeRil").data('daterangepicker').startDate;
			var endDatePicker = $("#datarangeRil").data('daterangepicker').endDate;
			
			dataString = "?action=filtra_date&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD')+"&rilievo=1";
				 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();

			callAction("listaSchedeConsegna.do"+ dataString, false,true);
				 	
					
	}
	
	  function filtraSchedePerDataVer(){
			
			
			var startDatePicker = $("#datarangeVer").data('daterangepicker').startDate;
			var endDatePicker = $("#datarangeVer").data('daterangepicker').endDate;
			
			dataString = "?action=filtra_date&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD')+"&verificazione=1";
				 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();

			callAction("listaSchedeConsegna.do"+ dataString, false,true);
				 	
					
	}
	  
	  function filtraSchedePerDataRap(){
			
			
			var startDatePicker = $("#datarangeRap").data('daterangepicker').startDate;
			var endDatePicker = $("#datarangeRap").data('daterangepicker').endDate;
			
			dataString = "?action=filtra_date&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD')+"&rapporto=1";
				 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();

			callAction("listaSchedeConsegna.do"+ dataString, false,true);
				 	
					
	}
	
	  function cercaRilieviSchede(){
		  
			var startDatePicker = $("#datarangeSchede").data('daterangepicker').startDate;
			var endDatePicker = $("#datarangeSchede").data('daterangepicker').endDate;
			
			dataString = "?action=cerca_rilievi_schede&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + +"&verificazione=1";
				 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
			
			 dataObj={};
			 dataObj.dateFrom = startDatePicker.format('YYYY-MM-DD');
			 dataObj.dateTo = endDatePicker.format('YYYY-MM-DD');
			 
			 callAjax(dataObj,"listaRilieviDimensionali.do?action=cerca_rilievi_schede", function(data){
				
				 if(data.success){
					 var table_data = [];
					 var lista_clienti = data.lista_clienti;
					 
					 for(var i = 0; i<lista_clienti.length;i++){
			  			  var dati = {};
			  			  
			  			  
			  			  dati.select = '<td></td>';		  		
			  			  dati.commessa = lista_clienti[i].split(";")[0];
			  			dati.cliente = lista_clienti[i].split(";")[1];
			  			if(lista_clienti[i].split(";")[2]!=null && lista_clienti[i].split(";")[2]!="null"){
			  				dati.sede = lista_clienti[i].split(";")[2];	
			  			}else{
			  				dati.sede ="";
			  			}
			  			
			  			
			  			  
			  			  table_data.push(dati);
			  			
			  		  }
				   
				   
				   var table = $('#table_crea_schede').DataTable();
			  		  
		   		   table.clear().draw();
		   		   
		   			table.rows.add(table_data).draw();
		   			
		   			table.columns.adjust().draw();
		 			
		   			
		   			$('#content_schede').show();
					 
				 }
				 
			 });


		  
	  }
	  
	  
	 function resetDate(){
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
			callAction("listaSchedeConsegna.do");

		}
  

	 var columsDatatables = [];
	 var columsDatatables2 = [];
	 var columsDatatables3 = [];
	 
	$("#tabSC").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabSC thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabSC thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    } );

	} ); 

	
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables2 = state.columns;
	    }
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables2[$(this).index()].search.search+'" /></div>');
	    } );

	} );

	
	$("#tabVer").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables3 = state.columns;
	    }
	    $('#tabVer thead th').each( function () {
	     	if(columsDatatables3.length==0 || columsDatatables3[$(this).index()]==null ){columsDatatables3.push({search:{search:""}});}
	        var title = $('#tabVer thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables3[$(this).index()].search.search+'" /></div>');
	    } );

	} );

	$("#tabRap").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables3 = state.columns;
	    }
	    $('#tabRap thead th').each( function () {
	     	if(columsDatatables3.length==0 || columsDatatables3[$(this).index()]==null ){columsDatatables3.push({search:{search:""}});}
	        var title = $('#tabRap thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables3[$(this).index()].search.search+'" /></div>');
	    } );

	} );
	
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}

  
    $(document).ready(function() {
    	 $('.dropdown-toggle').dropdown();
    	 
    	 
		var rilievo_attivo = "${rilievo_attivo}";
		var verificazione_attivo = "${verificazione_attivo}";
		var rapporto_attivo = "${rapporto_attivo}";
		
		if(rilievo_attivo!=null && rilievo_attivo!=''){

			$('#tab1').removeClass('active');
			$('#tab3').removeClass('active');
			$('#tab4').removeClass('active');
			$('#tab2').addClass('active');
			
			
			 //$('.nav-tabs a[href="#rilievi"]').tab('show');
			 $('a[data-toggle="tab2"]').tab('show');
			 
	  
		}
		if(verificazione_attivo!=null && verificazione_attivo!=''){

			$('#tab1').removeClass('active');
			$('#tab2').removeClass('active');
			$('#tab3').addClass('active');
			$('#tab4').removeClass('active');
			
			 //$('.nav-tabs a[href="#rilievi"]').tab('show');
			 $('a[data-toggle="tab3"]').tab('show');
			 
	    
		}
		if(rapporto_attivo!=null && rapporto_attivo!=''){

			$('#tab1').removeClass('active');
			$('#tab2').removeClass('active');
			$('#tab4').addClass('active');
			$('#tab3').removeClass('active');
			
			 //$('.nav-tabs a[href="#rilievi"]').tab('show');
			 $('a[data-toggle="tab4"]').tab('show');
			 
	    
		}
	    	
	 	 $('input[name="datarange"]').daterangepicker({
			    locale: {
			      format: 'DD/MM/YYYY'
			    
			    }
			}, 
			function(start, end, label) {

			});
		 
		 
		 

	 	 $('input[name="datarangeRil"]').daterangepicker({
			    locale: {
			      format: 'DD/MM/YYYY'
			    
			    }
			}, 
			function(start, end, label) {

			});
		 
		 
		 
		
	 	 $('input[name="datarangeVer"]').daterangepicker({
			    locale: {
			      format: 'DD/MM/YYYY'
			    
			    }
			}, 
			function(start, end, label) {

			});
	 	 
	 	 $('input[name="datarangeRap"]').daterangepicker({
			    locale: {
			      format: 'DD/MM/YYYY'
			    
			    }
			}, 
			function(start, end, label) {

			});
	 	 
			
	 	 $('input[name="datarangeSchede"]').daterangepicker({
			    locale: {
			      format: 'DD/MM/YYYY'
			    
			    }
			}, 
			function(start, end, label) {

			});
 	 
	 	 
	 	
	 	 
 	 var startScheda = "${dateFromScheda}";
 	 var endScheda = "${dateToScheda}";
 	 var startSchedaRil = "${dateFromRil}";
	 var endSchedaRil = "${dateToRil}";
	 var startSchedaVer = "${dateFromVer}";
	 var endSchedaVer = "${dateToVer}";
	 
	 var startSchedaRap = "${dateFromRap}";
	 var endSchedaRap = "${dateToRap}";
	 
 	 if(startScheda!=null && startScheda!=""){
 		 	$('#datarange').data('daterangepicker').setStartDate(formatDate(startScheda));
 		 	$('#datarange').data('daterangepicker').setEndDate(formatDate(endScheda));
 		
 		 	/* $("#tipo_data option[value='']").remove();
 		 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true); */
 		 }
    	 
 	 
 	 if(startSchedaRil!=null && startSchedaRil!=""){
		 	$('#datarangeRil').data('daterangepicker').setStartDate(formatDate(startSchedaRil));
		 	$('#datarangeRil').data('daterangepicker').setEndDate(formatDate(endSchedaRil));
		
		 	/* $("#tipo_data option[value='']").remove();
		 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true); */
		 }
 	 
 	 if(startSchedaVer!=null && endSchedaVer!=""){
		 	$('#datarangeVer').data('daterangepicker').setStartDate(formatDate(startSchedaVer));
		 	$('#datarangeVer').data('daterangepicker').setEndDate(formatDate(endSchedaVer));
		 	
		 	/* $("#tipo_data option[value='']").remove();
		 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true); */
		 }
 	 
 	 if(startSchedaRap!=null && endSchedaRap!=""){
		 	$('#datarangeRap').data('daterangepicker').setStartDate(formatDate(startSchedaRap));
		 	$('#datarangeRap').data('daterangepicker').setEndDate(formatDate(endSchedaRap));
		 	
		 	/* $("#tipo_data option[value='']").remove();
		 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true); */
		 }
 	 
 	 

    	
    	table = $('#tabSC').DataTable({
    		language: {
  	        	emptyTable : 	"Nessun dato presente nella tabella",
  	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
  	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
  	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
  	        	infoPostFix:	"",
  	        infoThousands:	".",
  	        lengthMenu:	"Visualizza _MENU_ elementi",
  	        loadingRecords:	"Caricamento...",
  	        	processing:	"Elaborazione...",
  	        	search:	"Cerca:",
  	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
  	        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
  	        	},
  	        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
  	        }
	        },
	        pageLength: 100,
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: true, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	      columnDefs: [
					   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 7 }
  	               ],

  	    	
  	    });
    	
  

     	    $('.inputsearchtable').on('click', function(e){
     	       e.stopPropagation();    
     	    });
  // DataTable
	table = $('#tabSC').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  	table.columns.adjust().draw();
    	
	
	$('#tabSC').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });
	
	
	
	
	tablePM = $('#tabPM').DataTable({
		language: {
	        	emptyTable : 	"Nessun dato presente nella tabella",
	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
	        	infoPostFix:	"",
	        infoThousands:	".",
	        lengthMenu:	"Visualizza _MENU_ elementi",
	        loadingRecords:	"Caricamento...",
	        	processing:	"Elaborazione...",
	        	search:	"Cerca:",
	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
	        	paginate:	{
  	        	first:	"Inizio",
  	        	previous:	"Precedente",
  	        	next:	"Successivo",
  	        last:	"Fine",
	        	},
	        aria:	{
  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
	        }
        },
        pageLength: 100,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: true, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	    stateSave: true,
	      columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 8 },
	                   { responsivePriority: 4, targets: 7 }
	               ],

	    	
	    });
	


  	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    }); 
// DataTable
tablePM = $('#tabPM').DataTable();
// Apply the search
tablePM.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tablePM.column( colIdx ).header() ).on( 'keyup', function () {
      tablePM
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} ); 
tablePM.columns.adjust().draw();
	

$('#tabVer').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
        theme: 'tooltipster-light'
    });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});
	
	
	
	
tableVer = $('#tabVer').DataTable({
	language: {
        	emptyTable : 	"Nessun dato presente nella tabella",
        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
        	infoPostFix:	"",
        infoThousands:	".",
        lengthMenu:	"Visualizza _MENU_ elementi",
        loadingRecords:	"Caricamento...",
        	processing:	"Elaborazione...",
        	search:	"Cerca:",
        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
        	paginate:	{
	        	first:	"Inizio",
	        	previous:	"Precedente",
	        	next:	"Successivo",
	        last:	"Fine",
        	},
        aria:	{
	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
        }
    },
    pageLength: 100,
      paging: true, 
      ordering: true,
      info: true, 
      searchable: true, 
      targets: 0,
      responsive: true,
      scrollX: false,
    stateSave: true,
      columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   
                   { responsivePriority: 4, targets: 7 }
               ],

    	
    });



	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    }); 
//DataTable
tableVer = $('#tabVer').DataTable();
//Apply the search
tableVer.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tableVer.column( colIdx ).header() ).on( 'keyup', function () {
	tableVer
      .column( colIdx )
      .search( this.value )
      .draw();
} );
} ); 
tableVer.columns.adjust().draw();


$('#tabVer').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});

$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})







});
	
	
	
tableRap = $('#tabRap').DataTable({
	language: {
        	emptyTable : 	"Nessun dato presente nella tabella",
        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
        	infoPostFix:	"",
        infoThousands:	".",
        lengthMenu:	"Visualizza _MENU_ elementi",
        loadingRecords:	"Caricamento...",
        	processing:	"Elaborazione...",
        	search:	"Cerca:",
        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
        	paginate:	{
	        	first:	"Inizio",
	        	previous:	"Precedente",
	        	next:	"Successivo",
	        last:	"Fine",
        	},
        aria:	{
	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
        }
    },
    pageLength: 100,
      paging: true, 
      ordering: true,
      info: true, 
      searchable: true, 
      targets: 0,
      responsive: true,
      scrollX: false,
    stateSave: true,
      columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   
                   { responsivePriority: 4, targets: 5 }
               ],

    	
    });



	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    }); 
//DataTable
tableRap = $('#tabRap').DataTable();
//Apply the search
tableRap.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tableRap.column( colIdx ).header() ).on( 'keyup', function () {
	tableRap
      .column( colIdx )
      .search( this.value )
      .draw();
} );
} ); 
tableRap.columns.adjust().draw();


$('#tabRap').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});

$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})
	
});
	
table_crea_schede = $('#table_crea_schede').DataTable({
	language: {
        	emptyTable : 	"Nessun dato presente nella tabella",
        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
        	infoPostFix:	"",
        infoThousands:	".",
        lengthMenu:	"Visualizza _MENU_ elementi",
        loadingRecords:	"Caricamento...",
        	processing:	"Elaborazione...",
        	search:	"Cerca:",
        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
        	paginate:	{
	        	first:	"Inizio",
	        	previous:	"Precedente",
	        	next:	"Successivo",
	        last:	"Fine",
        	},
        aria:	{
	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
        }
    },
    pageLength: 25,
    "order": [[ 1, "desc" ]],
      paging: false, 
      ordering: false,
      info: false, 
      searchable: true, 
      targets: 0,
      responsive: true,  
      scrollX: false,
      stateSave: false,	
      "searching": false,
      select: {
        	style:    'multi',
        	selector: 'td:nth-child(1)'
    	},
      columns : [


		{"data" : "select"},	
      	{"data" : "commessa"},	
      	{"data" : "cliente"},
      	{"data" : "sede"}
       ],	
           
      columnDefs: [
    	  
    	  { responsivePriority: 1, targets: 1 },
    	  { className: "select-checkbox", targets: 0,  orderable: false }
    	  ],
    	  
     	          
	 
               
    });


$('#table_crea_schede thead th').each( function () {
var title = $('#table_crea_schede thead th').eq( $(this).index() ).text();
$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} );




 table_crea_schede.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table_crea_schede.column( colIdx ).header() ).on( 'keyup', function () {
	table_crea_schede
  .column( colIdx )
  .search( this.value )
  .draw();
} );
} ); 



	
	
});
    
    
function creaSchedeCosegna(){
	
	
	  var table = $('#table_crea_schede').DataTable();
		var dataSelected = table.rows( { selected: true } ).data();

		var commesse = "";
		for (var i = 0; i < dataSelected.length; i++) {
			commesse += dataSelected[i].commessa;
		}
	
		console.log(dataSelected);
		
	
		if(commesse != null && commesse==""){
			
				$('#myModalErrorContent').html("Seleziona una commessa!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
	
				$('#myModalError').modal('show')
		}else{
			var startDatePicker = $("#datarangeSchede").data('daterangepicker').startDate;
			var endDatePicker = $("#datarangeSchede").data('daterangepicker').endDate;
			 dataObj={};
			 dataObj.dateFrom = startDatePicker.format('YYYY-MM-DD');
			 dataObj.dateTo = endDatePicker.format('YYYY-MM-DD');
			 dataObj.commesse = commesse;
			   	pleaseWaitDiv = $('#pleaseWaitDialog');
			 	pleaseWaitDiv.modal();
			 
			callAjax(dataObj,"scaricaSchedaConsegna.do?action=rilievi_dimensionali")
			
		}
		table.rows().deselect();
	
}    
    
    
    
    
	$('#selectAlltabPM').on('ifChecked', function(event){  		
  		
		 var table = $('#table_crea_schede').DataTable();
		   table.rows({ filter : 'applied'}).select();
		      	  
});
$('#selectAlltabPM').on('ifUnchecked', function(event){
	 var table = $('#table_crea_schede').DataTable();
		 table.rows().deselect();
	  
});
    	
  </script>
</jsp:attribute> 
</t:layout>
  
 
