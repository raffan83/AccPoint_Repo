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
              <div class="row">
           <div class="col-xs-12" style="margin-bottom: 25px;">
      
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
    <fmt:formatDate value="${s.dataCreazione}" pattern="yyyy-MM-dd"/>
    </td>
                  <td>
    <fmt:formatDate value="${s.dataScadenza}" pattern="yyyy-MM-dd"/>
    </td>
                  <td>${s.nome_cliente}</td>
                  <td>${s.nome_sede}</td>
                  <td>${fn:replace(s.email_cliente, ';', '<wbr/>')}</td>
                     
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
    </section>
 
  </div><!-- fine content-wrapper -->


   <t:control-sidebar />
  <t:dash-footer/>
   
</div><!-- fine wrapper -->

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
  <script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>

  <script type="text/javascript">

  $('#selectAll').on('change', function () {
    $('input[name="selectedFiles"]').prop('checked', $(this).is(':checked'));
  });

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

  $(document).ready(function() {

  

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
        { targets: [5, 6], type: 'date' },
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

  });




  
  $("#select1").change(function(){	
  	
  	callAction('listaSessioni.do?year='+$("#select1").val(),null,true);
  	
  });

</script>
</jsp:attribute>

</t:layout>