<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@page import="it.portaleSTI.DTO.SessioneDTO"%>
<%@ page language="java" import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="extra_css">
  <link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.dataTables.min.css">
  
  <style>
  

  #tabMisuraUtente tbody tr:nth-child(odd) {
    background-color: #f9f9f9 !important;
}
#tabMisuraUtente tbody tr:nth-child(even) {
    background-color: #ffffff !important;
}
#tabMisuraUtente tbody tr:hover {
    background-color: #d9edf7 !important;
}

.row-invalidato td {
    background-color: #f2dede !important;
}
.row-invalidato {
    cursor: help;
}

.row-inviata td {
    background-color: #dff0d8 !important;
}
.action-icon {
    cursor: pointer;
    font-size: 16px;
    color: #3c8dbc;
}


.action-icon:hover {
    color: #1d6fa5;
}

#tabMisuraUtente th:nth-child(10),
#tabMisuraUtente td:nth-child(10) {
    width: 180px !important;
    max-width: 180px;
    white-space: normal;
    word-break: normal;
    overflow-wrap: normal;
}
</style>


</jsp:attribute>

<jsp:attribute name="body_area">
<div class="wrapper">

  <t:main-header />
  <t:main-sidebar />
 
    
  <div id="corpoframe" class="content-wrapper">

    <section class="content-header">
      <h1 class="pull-left">Lista Sessioni <small></small></h1>
   <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    
<div style="clear: both;"></div>    
    <section class="content">
    
      <div class="row">
        <div class="col-xs-12">
         <div class="box">
            <div class="box-body">
        
    <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

      
 <div class="box-body">
 
     <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active" id="tab1"><a href="#standard" data-toggle="tab" aria-expanded="true"   id="standardTab">Lista Sessioni</a></li>
              		<li class="" id="tab2"><a href="#interventi" data-toggle="tab" aria-expanded="false"   id="interventiTab">Lista Tutti Interventi</a></li>
              		
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="standard">
 
              <div class="row">
           <div class="col-xs-12" style="margin-bottom: 25px;">
            <div style="display: flex; align-items: center; gap: 10px;">
      
<label>Anno: </label>

   <select name="select1" id="select1" data-placeholder="Seleziona Cliente..." style="width:10%"  class="form-control select2" aria-hidden="true" data-live-search="true">
	
	 <c:forEach items="${yearList}" var="year">
	 	<c:choose>
                       <c:when test="${year == current_year}">
                           <option value="${year}" selected="selected">${year}</option> 
                        </c:when>
                        <c:otherwise>
                        <option value="${year}">${year}</option> 
                        </c:otherwise>
      	</c:choose>
      </c:forEach>
	</select>
	     
 </div>
  </div>
  </div>

           <!-- Legenda -->
    <div style="margin-bottom: 10px;">
      <span style="display:inline-flex; align-items:center; gap:6px;">
        <span style="width:18px; height:18px; background-color:#f2dede; 
                     border:1px solid #ebccd1; border-radius:3px; display:inline-block;"></span>
        <span style="font-size:17px; color:#555;">Sessione invalidata</span>
      </span>
    </div>
        
          <!-- Tabella sessioni -->
          <table id="tabMisuraUtente"
                class="table table-primary table-bordered table-hover dataTable table-striped"
                 width="100%">
            <thead>
              <tr class="active">
             
                <th>ID</th>
                <th>Username</th>
                 <th>Password</th>
                <th>Session Id</th>
                <th>Id Intervento </th>
                <th>Data Creazione</th>
                <th>Data Scadenza</th>
                <th>Cliente</th>
                <th>Sede</th>
                 <th>Email</th>
             
    

              </tr>
            </thead>
            <tbody>
              <c:forEach items="${listaSessioni}" var="s">
  <tr class="${s.abilitato == 0 ? 'row-invalidato' : ''}"
      title="<c:if test='${s.abilitato == 0}'>Sessione invalidata!&#10;Motivo: <c:if test='${not empty s.note_disab}'>${s.note_disab}</c:if></c:if>">
        
                  <td>${s.id}</td>
                  <td>${s.username}</td>
                   <td>${s.password}</td>
                  <td>${s.session_id}</td>
                  <td>${s.id_intervento} </td>
                  <td>
    <fmt:formatDate value="${s.dataCreazione}" pattern="dd/MM/yyyy"/>
    </td>
                  <td>
    <fmt:formatDate value="${s.dataScadenza}" pattern="dd/MM/yyyy"/>
    </td>
                  <td>${s.nome_cliente}</td>
                  <td>${s.nome_sede}</td>
                  <td>${fn:replace(s.email_cliente, ';', '<wbr/>')}</td>
                     
                </tr>
              </c:forEach>
            </tbody>
          </table>
          
       </div>   
          
         <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="interventi">    
          
          
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
				               <button type="button" class="btn btn-info btn-flat" onclick="cercaMisure()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>

</div>
</div>

           <!-- Legenda -->
    <div style="margin-bottom: 10px;">
      <span style="display:inline-flex; align-items:center; gap:6px;">
        <span style="width:18px; height:18px; background-color:#dff0d8; 
                     border:1px solid #dff0d8; border-radius:3px; display:inline-block;"></span>
        <span style="font-size:17px; color:#555;">Sessione inviata</span>
      </span>
    </div>
        
          <!-- Tabella sessioni -->
          <table id="tabInterventi"
                 class="table table-primary table-bordered table-hover dataTable table-striped"
                 width="100%">
            <thead>
              <tr class="active">
             
                <th>ID</th>
                <th>Cliente Intervento</th>
                 <th>Sede</th>
                <th>Commessa</th>
                <th>Stato</th>
                <th>Data Creazione</th>
                <th>Email </th>
                <th>Company</th>
               
                             
    

              </tr>
            </thead>
            <tbody>
             <c:forEach items="${lista_interventi}" var="intervento">
    <tr class="${intervento.sessioneInvio != null ? 'row-inviata' : ''}">
                  <td>${intervento.id}</td>
                  <td>${intervento.nome_cliente}</td>
                   <td>${intervento.nome_sede}</td>
                  <td>${intervento.idCommessa}</td>
                 <td>
    <c:choose>
        <c:when test="${intervento.statoIntervento.id == 2}">
            <span class="label label-warning">
                ${intervento.statoIntervento.descrizione}
            </span>
        </c:when>
        <c:when test="${intervento.statoIntervento.id == 1}">
            <span class="label label-success">
                ${intervento.statoIntervento.descrizione}
            </span>
        </c:when>
        <c:when test="${intervento.statoIntervento.id == 0}">
            <span class="label label-info">
                ${intervento.statoIntervento.descrizione}
            </span>
        </c:when>
    </c:choose>
</td>

                  <td>
    <fmt:formatDate value="${intervento.dataCreazione}" pattern="dd/MM/yyyy"/>
    </td>
         <td>${intervento.email_cliente}</td>
                  <td>${intervento.company.denominazione}</td>
                 
                </tr>
              </c:forEach>
            </tbody>
          </table>
          </div>
</div>
</div>
</div>
</div>
</div>
</div>

        </div>
      </div>
    </section>
 
  </div><!-- fine content-wrapper -->


   <t:control-sidebar />
  <t:dash-footer/>
   
</div><!-- fine wrapper -->

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
  <script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>

  <script type="text/javascript">

  function formatDate(data) {
    var mydate = new Date(data);
    if (!isNaN(mydate.getTime())) {
      str = mydate.toString("dd/MM/yyyy");
    }
    return str;
  }





  var columsDatatables = [];

  // Aggiunta input di ricerca per colonna nell'evento init.dt, come nel primo file
  $("#tabMisuraUtente").on('init.dt', function(e, settings) {
    var api = new $.fn.dataTable.Api(settings);
    var state = api.state.loaded();

    if (state != null && state.columns != null) {
      columsDatatables = state.columns;
    }

    var totalCols = $('#tabMisuraUtente thead th').length;

    $('#tabMisuraUtente thead th').each(function() {
      var colIndex = $(this).index();

      if (columsDatatables.length == 0 || columsDatatables[colIndex] == null) {
        columsDatatables.push({ search: { search: "" } });
      }

      if (colIndex === totalCols ) return;

      $(this).append(
        '<div><input class="inputsearchtable" style="width:100%" type="text" value="' +
        columsDatatables[colIndex].search.search + '"/></div>'
      );
    });
  });
  
  
  var columsDatatablesInterventi = [];

  $("#tabInterventi").on('init.dt', function(e, settings) {
    var api = new $.fn.dataTable.Api(settings);
    var state = api.state.loaded();

    if (state != null && state.columns != null) {
      columsDatatablesInterventi = state.columns;
    }

    var totalCols = $('#tabInterventi thead th').length;

    $('#tabInterventi thead th').each(function() {
      var colIndex = $(this).index();

      if (columsDatatablesInterventi.length == 0 || columsDatatablesInterventi[colIndex] == null) {
        columsDatatablesInterventi.push({ search: { search: "" } });
      }

      if (colIndex === totalCols) return;

      $(this).append(
        '<div><input class="inputsearchtable" style="width:100%" type="text" value="' +
        columsDatatablesInterventi[colIndex].search.search + '"/></div>'
      );
    });
  });

  $(document).ready(function() {
	  
	var intervento_attivo = "${intervento_attivo}";
		
		
	if (intervento_attivo != null && intervento_attivo != '') {
	    $('#interventiTab').tab('show');
	} else {
	    $('#standardTab').tab('show');
	}
	  
	  var date_before = "${date_before}";
	    var date_after   = "${date_after}";
	  
	    $('input[name="datarange"]').daterangepicker({
		      locale: { format: 'DD/MM/YYYY' },
		      autoUpdateInput: false
		    });
	    
	    if (date_before !== '' && date_after !== '') {
		      var mFrom = moment(date_before, 'YYYY-MM-DD');
		      var mTo   = moment(date_after,   'YYYY-MM-DD');
		      $('#datarange').data('daterangepicker').setStartDate(mFrom);
		      $('#datarange').data('daterangepicker').setEndDate(mTo);
		      $('#datarange').val(mFrom.format('DD/MM/YYYY') + ' - ' + mTo.format('DD/MM/YYYY'));
		    }

		    $('input[name="datarange"]').on('apply.daterangepicker', function(ev, picker) {
		      $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
		    });

		    $('input[name="datarange"]').on('cancel.daterangepicker', function(ev, picker) {
		      $(this).val('');
		    });
	  
	  $('.dropdown-toggle').dropdown();
 	 
 	 
	

  

    $(document).on('click', '.inputsearchtable', function(e) {
      e.stopPropagation();
    });

    table = $('#tabMisuraUtente').DataTable({
      language: {
        emptyTable:     "Nessun dato presente nella tabella",
        info:           "Vista da _START_ a _END_ di _TOTAL_ elementi",
        infoEmpty:      "Vista da 0 a 0 di 0 elementi",
        infoFiltered:   "(filtrati da _MAX_ elementi totali)",
        infoPostFix:    "",
        infoThousands:  ".",
        lengthMenu:     "Visualizza _MENU_ elementi",
        loadingRecords: "Caricamento...",
        processing:     "Elaborazione...",
        search:         "Cerca:",
        zeroRecords:    "La ricerca non ha portato alcun risultato.",
        paginate: {
          first:    "Inizio",
          previous: "Precedente",
          next:     "Successivo",
          last:     "Fine",
        },
        aria: {
          sortAscending:  ": attiva per ordinare la colonna in ordine crescente",
          sortDescending: ": attiva per ordinare la colonna in ordine decrescente",
        }
      },
      pageLength: 100,
      paging: true,
      ordering: true,
      order: [[0, "desc"]],
      info: true,
      responsive: true,
      scrollX: false,
      stateSave: true,
      autoWidth: false,
      columnDefs: [
      
        { responsivePriority: 1, targets: 9 },
        { responsivePriority: 2, targets: 3 },
        { responsivePriority: 4, targets: 4 },
        { responsivePriority: 4, targets: 5 },
        { responsivePriority: 4, targets: 6 },
        { responsivePriority: 5, targets: 7 },
        { responsivePriority: 6, targets: 8 },
        { width: "100px", targets: 9 }   
     
        
      ],
    
    });
    
    
    
    tableInt = $('#tabInterventi').DataTable({
        language: {
          emptyTable:     "Nessun dato presente nella tabella",
          info:           "Vista da _START_ a _END_ di _TOTAL_ elementi",
          infoEmpty:      "Vista da 0 a 0 di 0 elementi",
          infoFiltered:   "(filtrati da _MAX_ elementi totali)",
          infoPostFix:    "",
          infoThousands:  ".",
          lengthMenu:     "Visualizza _MENU_ elementi",
          loadingRecords: "Caricamento...",
          processing:     "Elaborazione...",
          search:         "Cerca:",
          zeroRecords:    "La ricerca non ha portato alcun risultato.",
          paginate: {
            first:    "Inizio",
            previous: "Precedente",
            next:     "Successivo",
            last:     "Fine",
          },
          aria: {
            sortAscending:  ": attiva per ordinare la colonna in ordine crescente",
            sortDescending: ": attiva per ordinare la colonna in ordine decrescente",
          }
        },
        pageLength: 100,
        paging: true,
        ordering: true,
        order: [[0, "desc"]],
        info: true,
        responsive: true,
        scrollX: false,
        stateSave: true,
        autoWidth: false,
        columnDefs: [
            { responsivePriority: 1, targets: 0 }, // ID
            { responsivePriority: 2, targets: 4 }, // Stato
            { responsivePriority: 3, targets: 5 }, // Data
            { responsivePriority: 4, targets: 3 }, // Commessa
            { responsivePriority: 5, targets: 1 }, // Cliente
            { responsivePriority: 6, targets: 2 }, // Sede
            { responsivePriority: 7, targets: 6 }, // Email
            { responsivePriority: 8, targets: 7 }  // Company
        ]
      
      });
    
    tableInt.columns().eq(0).each(function(colIdx) {
        $('input', tableInt.column(colIdx).header()).on('keyup', function() {
          tableInt
            .column(colIdx)
            .search(this.value)
            .draw();
        });
      });

      tableInt.columns.adjust().draw();

    table.buttons().container().appendTo('#tabMisuraUtente_wrapper .col-sm-6:eq(1)');

    // Listener ricerca per colonna, identico al primo file
    table.columns().eq(0).each(function(colIdx) {
      $('input', table.column(colIdx).header()).on('keyup', function() {
        table
          .column(colIdx)
          .search(this.value)
          .draw();
      });
    });

    table.columns.adjust().draw();

    $('#tabMisuraUtente').on('page.dt', function() {
      $('.customTooltip').tooltipster({ theme: 'tooltipster-light' });
      $('.removeDefault').each(function() {
        $(this).removeClass('btn-default');
      });
    });
    table.buttons().container().appendTo('#tabInterventi_wrapper .col-sm-6:eq(1)');
  });




  
  $("#select1").change(function(){	
  	
  	callAction('listaSessioni.do?year='+$("#select1").val(),null,true);
  	
  });
  


  function cercaMisure() {
    var picker = $("#datarange").data('daterangepicker');
    var dataString = "&date_before=" + picker.startDate.format('YYYY-MM-DD')
                   + "&date_after="   + picker.endDate.format('YYYY-MM-DD');
    $('#pleaseWaitDialog').modal();
    callAction("listaSessioni.do?action=lista_interventi_mensili" + dataString, false, true);
  }

  function resetDate() {
    $('#pleaseWaitDialog').modal();
    callAction("listaSessioni.do?action=lista_interventi_mensili");
  }

</script>
</jsp:attribute>

</t:layout>