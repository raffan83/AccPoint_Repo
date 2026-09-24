
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.CampionePrenotazioneDTO"%>

<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>


<%
	int anno = (Integer) request.getSession().getAttribute("anno");
%>


 <table id="tabPrenotazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
	<thead>
		<tr>
			<th>DIPENDENTE <input class="inputsearchtable" style="min-width: 80px" type="text" id="inputsearchtable_0" /></th>
			<c:set var="nuovoAnno" value="${anno + 1}"></c:set>
			<c:forEach var="day" begin="${start_date }" end="${end_date }"
				step="1">

				<%
					int dayValue = (Integer) pageContext.getAttribute("day");

						int end_date = (Integer) request.getSession().getAttribute("end_date");

						/*       if(LocalDate.ofYearDay(anno, 1).isLeapYear()){
						    	 if(dayValue>366){
						    		 System.out.println("Bisestile");
						    		 dayValue =  dayValue-366;
						    		 anno = Integer.parseInt(""+pageContext.getAttribute("nuovoAnno"));
						    	 }
						    	  
						      }else{ */
						if (dayValue > 365) {
							dayValue = dayValue - 365;
							anno = Integer.parseInt("" + pageContext.getAttribute("nuovoAnno"));
						}
						//  }
						if (dayValue <= 0) {
							dayValue = 1;
						}

						LocalDate localDate = LocalDate.ofYearDay(anno, dayValue);
						LocalDateTime localDateTime = localDate.atStartOfDay();
						Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
						ArrayList<LocalDate> festivitaItaliane = (ArrayList<LocalDate>) request.getSession()
								.getAttribute("festivitaItaliane");
						String dayOfWeekString = localDate.getDayOfWeek()
								.getDisplayName(java.time.format.TextStyle.FULL, Locale.ITALIAN).toUpperCase();

						if (localDate.getDayOfWeek().getValue() == 6 || localDate.getDayOfWeek().getValue() == 7) {
				%>
			    <!-- Weekend -->
<th class="weekend" style="text-align:center">
  <div class="day-header-pill">
    <span class="day-name"><c:out value="<%=dayOfWeekString %>"></c:out></span>
    <span class="day-date"><fmt:formatDate value="<%= date %>" pattern="dd/MM" /></span>
  </div>
</th>
            
            <%}else if(festivitaItaliane.contains(localDate)){ %>
             <th class="weekend" style="text-align:center">
  <div class="day-header-pill">
    <span class="day-name"><c:out value="<%=dayOfWeekString %>"></c:out></span>
    <span class="day-date"><fmt:formatDate value="<%= date %>" pattern="dd/MM" /></span>
  </div>
</th>
            <%}else{ %>
      
     <th style="text-align:center">
  <div class="day-header-pill">
    <span class="day-name"><c:out value="<%=dayOfWeekString %>"></c:out></span>
    <span class="day-date"><fmt:formatDate value="<%= date %>" pattern="dd/MM" /></span>
  </div>
</th>
				<%
					}
				%>



			</c:forEach>
		</tr>
	</thead>
	<tbody>

		<c:forEach items="${lista_utenti }" var="utente">
			<tr id="${utente.id}">

				<td id="col_1_${utente.id}"><b>${utente.nominativo}</b></td>

				<c:forEach var="day" begin="${start_date }" end="${end_date}"
					step="1">
					<c:if
						test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day>366 }">
						<td id="${utente.id}_${day-366}" style="position: relative"></td>
					</c:if>
					<c:if
						test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day>365 }">
						<td id="${utente.id}_${day-365}" style="position: relative"></td>
					</c:if>
					<c:if
						test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=366 }">
						<td id="${utente.id}_${day}" style="position: relative"></td>
					</c:if>
					<c:if
						test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=365 }">
						<td id="${utente.id}_${day}" style="position: relative"></td>
					</c:if>
					<%-- <td id="${veicolo.id}_${day}" ondblclick="modalPrenotazione('${day}', '${commessa.ID_COMMESSA }')"></td> --%>
					<%-- <td id="${veicolo.id}_${day}"></td> --%>
				</c:forEach>


				<%--   </c:forEach> --%>

			</tr>
		</c:forEach>



	</tbody>
</table>



<ul class='custom-menu'>
	<c:if test="${userObj.checkPermesso('MODIFICA_CAMPIONE')}">
		<!--  <li data-action = "copy">Copia</li>-->
		<!--   <li data-action = "paste">Incolla</li> -->
		<li data-action="delete">Elimina</li>
	</c:if>
</ul>


<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>


<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="https://cdn.datatables.net/fixedcolumns/3.2.2/js/dataTables.fixedColumns.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
<script src=" https://code.jquery.com/jquery-3.3.1.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src=" https://datatables.net/release-datatables/media/js/jquery.dataTables.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src=" https://datatables.net/release-datatables/media/js/dataTables.bootstrap4.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src=" https://datatables.net/release-datatables/extensions/FixedColumns/js/dataTables.fixedColumns.js"
	type="text/javascript" charset="utf-8"></script>

<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.css"> -->
<link rel="stylesheet"
	href="https://datatables.net/release-datatables/media/css/dataTables.bootstrap4.css">
<link rel="stylesheet"
	href="https://datatables.net/release-datatables/extensions/FixedColumns/css/fixedColumns.bootstrap4.css">


<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<style>

/* Colonne giorno piu' larghe */
#tabPrenotazione_wrapper table.dataTable thead th:nth-child(n+2),
#tabPrenotazione_wrapper table.dataTable tbody td:nth-child(n+2) {
  min-width: 115px;
}

/* Il <th> resta neutro: il colore vero lo porta il "pill" interno */
#tabPrenotazione_wrapper table.dataTable thead th:nth-child(n+2) {
  background: transparent !important;
  border: none !important;
  padding: 0 2px !important;
}

/* Pill arrotondato con il colore del giorno */
#tabPrenotazione_wrapper table.dataTable thead th:nth-child(n+2) .day-header-pill {
  display: block;
  background-color: #3d6fb4;
  color: #ffffff;
  border-radius: 12px;
  padding: 15px 8px;
  line-height: 1.3;
}

/* Colonne giorno - blu piu' chiaro (di riserva, il pill copre sopra) */
#tabPrenotazione_wrapper thead th:nth-child(n+2) {
  background-color: #3d6fb4 !important;
  color: #ffffff;
  font-weight: 500;
  border-color: #4b7ec2 !important;
}


/* Nessuna freccia sulle colonne giorno */
#tabPrenotazione_wrapper table.dataTable thead th:nth-child(n+2),
#tabPrenotazione_wrapper table.dataTable thead th.sorting_disabled {
  cursor: default;
  background-image: none !important;
}

#tabPrenotazione_wrapper table.dataTable thead th:nth-child(n+2)::before,
#tabPrenotazione_wrapper table.dataTable thead th:nth-child(n+2)::after,
#tabPrenotazione_wrapper table.dataTable thead th.sorting_disabled::before,
#tabPrenotazione_wrapper table.dataTable thead th.sorting_disabled::after {
  content: "" !important;
  display: none !important;
}

#tabPrenotazione_wrapper table.dataTable thead th.weekend .day-header-pill {
  background-color: #f7c9c9 !important;
  color: #a83232 !important;
}

</style>




<script type="text/javascript">
	$(document).off('input', '.inputsearchtable').on('input',
			'.inputsearchtable', function() {
				var columnIndex = $(this).closest('th').index();
				table.column(columnIndex).search(this.value).draw();
			});

	$(document).off('click', '.inputsearchtable').on('click',
			'.inputsearchtable', function(e) {
				e.stopPropagation();
			});

	var _lastDetailRequestId = null;

	function modalPrenotazione(day, id_veicolo, id_prenotazione) {

		var currentYear = $('#anno').val();
		var dayValue = parseInt(day, 10);

		var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
		var d = localDate.getUTCDate();
		var month = localDate.getUTCMonth() + 1;
		var year = localDate.getUTCFullYear();
		var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2)
				+ '/' + year;

		// riparto pulito
		$('#ora_inizio').timepicker('remove');
		$('#ora_fine').timepicker('remove');
		$('#day').val(day);

		// ===== NUOVA PRENOTAZIONE =====
		if (!id_prenotazione) {
			_lastDetailRequestId = null;

			$('#id_prenotazione').val('');
			$('#luogo').val('');
			$('#note').val('');

			$('#data_inizio').val(formattedDate);
			$('#data_fine').val(formattedDate);

			// default orari (modifica se vuoi)
			$('#ora_inizio').val('08:00');
			$('#ora_fine').val('17:00');
			initializeTimepicker('08:00', '17:00');

			setModalMode('new');
			lockDateTime(false);

			$('#modalPrenotazione').modal();
			return;
		}

		// ===== PRENOTAZIONE ESISTENTE =====
		_lastDetailRequestId = String(id_prenotazione);

		callAjax({
			id : id_prenotazione
		}, "gestionePrenotazioneCampione.do?action=dettaglio_prenotazione",
				function(data) {

					// anti-race: se nel frattempo ho cliccato altro, ignora
					if (_lastDetailRequestId !== String(id_prenotazione))
						return;

					var prenotazione = data.prenotazione;

					$('#luogo').val(prenotazione.luogo);
					$('#data_inizio')
							.val(
									prenotazione.data_inizio_prenotazione
											.split(" ")[0]);
					$('#data_fine').val(
							prenotazione.data_fine_prenotazione.split(" ")[0]);

					$('#ora_inizio')
							.val(
									prenotazione.data_inizio_prenotazione
											.split(" ")[1]);
					$('#ora_fine').val(
							prenotazione.data_fine_prenotazione.split(" ")[1]);

					initializeTimepicker(prenotazione.data_inizio_prenotazione
							.split(" ")[1], prenotazione.data_fine_prenotazione
							.split(" ")[1]);

					$('#id_prenotazione').val(id_prenotazione);
					$('#note').val(prenotazione.note);

					setModalMode('view');
					renderCampioniPrenotati(prenotazione.listaCampioni);
					lockDateTime(true);

					// apro qui: così sei sicuro che vedi il dettaglio
					$('#modalPrenotazione').modal();
				});
	}

	function initializeTimepicker(start, end) {
		$('#ora_inizio').timepicker(
				{
					minuteStep : 5,
					disableTextInput : true,
					showMeridian : false,
					defaultTime : start, // Imposta l'orario di inizio predefinito
					// Callback per disabilitare gli orari sovrapposti

					disableTimeRanges : orariDisabilitati,
					beforeShow : function(input, instance) {
						var inizioPrenotazione = moment($('#ora_inizio').val(),
								"HH:mm");
						var finePrenotazione = moment($('#ora_fine').val(),
								"HH:mm");

						instance.$input.timepicker('setTimeDisabled', function(
								time) {
							return time.isBetween(inizioPrenotazione,
									finePrenotazione, null, '[)')
									|| time.isBetween(inizioPrenotazione,
											finePrenotazione, null, '(]')
									|| inizioPrenotazione.isBetween(time,
											finePrenotazione, null, '(]')
									|| finePrenotazione.isBetween(time,
											finePrenotazione, null, '[)');
						});
					}
				}).on('changeTime.timepicker', function(e) {
			var inizio = moment($('#ora_inizio').val(), "HH:mm");
			var fine = moment($('#ora_fine').val(), "HH:mm");
		});

		$('#ora_fine').timepicker(
				{
					minuteStep : 5,
					disableTextInput : true,
					showMeridian : false,
					defaultTime : end, // Imposta l'orario di fine predefinito
					// Callback per disabilitare gli orari sovrapposti
					beforeShow : function(input, instance) {
						var inizio = moment($('#ora_inizio').val(), "HH:mm");
						var fine = moment($('#ora_fine').val(), "HH:mm");

						instance.$input.timepicker('setTimeDisabled',
								function(time) {
									return time.isBetween(inizio, fine)
											|| time.isSame(inizio)
											|| time.isSame(fine);
								});
					}
				}).on('changeTime.timepicker', function(e) {
			var inizio = moment($('#ora_inizio').val(), "HH:mm");
			var fine = moment($('#ora_fine').val(), "HH:mm");
		});
	}

	columsDatatables = []
	var columsDatatables = [];

	var settings = {
		language : {
			emptyTable : "Nessun dato presente nella tabella",
			info : "Vista da _START_ a _END_ di _TOTAL_ elementi",
			infoEmpty : "Vista da 0 a 0 di 0 elementi",
			infoFiltered : "(filtrati da _MAX_ elementi totali)",
			infoPostFix : "",
			infoThousands : ".",
			lengthMenu : "Visualizza _MENU_ elementi",
			loadingRecords : "Caricamento...",
			processing : "Elaborazione...",
			search : "Cerca:",
			zeroRecords : "La ricerca non ha portato alcun risultato.",
			paginate : {
				first : "Inizio",
				previous : "Precedente",
				next : "Successivo",
				last : "Fine",
			},

			aria : {
				srtAscending : ": attiva per ordinare la colonna in ordine crescente",
				sortDescending : ": attiva per ordinare la colonna in ordine decrescente",
			}
		},
		dom : 'rt<"bottom"ip>',
		pageLength : 100,
		"order" : [ [ 2, "asc" ] ],
		paging : false,
		ordering : true,
		info : true,
		searchable : false,
		//      targets: 0,
		responsive : false,
		scrollX : "100%",
		//scrollTo: 'cell',
		searching : true,
		scrollY : "700px",
		"autoWidth" : false,

		fixedColumns : {
			leftColumns : 1,
			heightMatch : 'auto'// Numero di colonne fisse
		},

		stateSave : true,
		columnDefs : [ {
			targets : '_all',
			createdCell : editableCell
		}

		],
		fixedHeader : true,

		buttons : [ {
			extend : 'excel',
			text : 'Esporta Excel'
		} ]

	}

	var scrollPos;

	function editableCell(cell) {
		$(cell).on(
				'click',
				function() {
					scrollPos = $(window).scrollTop();
					var scrollPosition = $(this).closest(
							'.dataTables_scrollBody').scrollTop();
					if (permesso == "true") {

						$('.selected-cell').removeClass('selected-cell');
						$('.button_add').remove();

						$(this).addClass('selected-cell');
						var cellId = $(this).attr('id');
						var rowId = $(this).closest('tr').attr('id');

						$('#id_utente').val(rowId)

						// Creazione del contenitore per il pulsante e il contenuto della cella
						var $container = $('<div>').css('position', 'relative')
								.css('height', 'auto');
						var $buttonContainer = $('<div>').css('position',
								'relative').css('top', '0').css('left', '0');
						var $contentContainer = $('<div>').css('margin-top',
								'0px'); // Aggiungi margine per il pulsante

						// Aggiungi il contenitore del pulsante e il contenitore del contenuto alla cella
						$container.appendTo($(this)).append($buttonContainer)
								.append($contentContainer);

						// Aggiungi il pulsante al contenitore del pulsante
						$('<button>').addClass(
								'button_add btn btn-primary btn-sm').attr('id',
								'button_add_' + cellId).attr(
								'onclick',
								"modalPrenotazione('" + cellId.split("_")[1]
										+ "', '" + cellId.split("_")[0] + "')")
								.html('<i class="fa fa-plus"></i>').appendTo(
										$buttonContainer);

						table = $('#tabPrenotazione').DataTable()
						table.draw();
						$(window).scrollTop(scrollPos);
						$(this).closest('.dataTables_scrollBody').scrollTop(
								scrollPosition);
					}
				});
	}

	function updatePosition(currentRow, newHeight, oldHeight, edit) {
		var nextRow = currentRow.next();
		while (nextRow.length > 0) {
			// Calcola la differenza tra l'altezza della riga precedente e quella successiva
			//  
			if (edit == 1) {
				var heightDifference = newHeight - oldHeight;
			} else {
				var heightDifference = 75;
			}

			// Aggiorna la posizione verticale di ciascun riquadro nella riga successiva
			nextRow.find('.riquadro').each(function() {
				var currentTop = $(this).position().top;
				var newTop = currentTop + heightDifference; // Aggiungi la differenza di altezza per mantenere la posizione relativa
				$(this).css('top', newTop);
			});

			nextRow = nextRow.next();
		}
	}

	$(window).on('load', function() {

		//pleaseWaitDiv.modal('hide');
	});

	var selectedDiv = null;
	var offsetX;
	var offsetY;
/*
	$(window)
			.on(
					'scroll',
					function() {
						var windowScrollTop = $(window).scrollTop();
						var tableHeaderHeight = $('.dataTables_scrollHead')
								.outerHeight();
						var tableHeaderWidth = $('.dataTables_scrollHead')
								.outerWidth();
						var fixedColumnsHeaderHeight = $(
								'.DTFC_LeftHeadWrapper').outerHeight();
						var fixedColumnsHeaderWidth = $('.DTFC_LeftHeadWrapper')
								.outerWidth();

						var combinedHeaderHeight = tableHeaderHeight
								+ fixedColumnsHeaderHeight;
						// Se lo scroll della finestra è maggiore dell'altezza dell'header della tabella

						// sposta l'header sopra la finestra
						//  if (windowScrollTop >= tableHeaderHeight) {
						if (windowScrollTop > combinedHeaderHeight) {
							$('.dataTables_scrollHead').css({
								'position' : 'fixed',
								'top' : '0',
								//'left': '0',
								'width' : '100%',
								'z-index' : '99'
							});

							$('.DTFC_LeftHeadWrapper').css(
									{
										'position' : 'fixed',
										'top' : '0',
										'left' : $('.dataTables_scrollHead')
												.offset().left,
										'z-index' : '100', // Livello di z-index inferiore rispetto all'header principale
									});
						} else {
							// Altrimenti, ripristina lo stile predefinito dell'header
							$('.dataTables_scrollHead, .DTFC_LeftHeadWrapper')
									.css({
										'position' : 'static'
									});
						}
					});
					
					*/

	var order = 1;

	var permesso = "${userObj.checkPermesso('MODIFICA_CAMPIONE')}";

	var cellCopy;

	$(document).ready(function() {
	    initializeTimepicker("08:00", "17:00");
	  
	    zoom_level = parseFloat(Cookies.get('page_zoom'));

	    initTable("${anno}", '${filtro_tipo_pianificazioni}');   // <-- prima chiamava fillTable

	    $(document.body).css('padding-right', '0px');
	    initContextMenu(permesso);
	    $('.dropdown-menu').css('z-index', 200);
	});

	function getTextWidth(text, font) {
		var canvas = document.createElement('canvas');
		var context = canvas.getContext('2d');
		context.font = font;
		var metrics = context.measureText(text);
		return metrics.width;
	}
	
	function rangesOverlap(start1, end1, start2, end2) {
	    return !(end1 < start2 || start1 > end2);
	}

	function getRowBoxesBottomInfo($row, startIdx, endIdx, headerOffset, gapVerticale) {
	    var maxBottom = headerOffset;
	    var found = false;

	    $row.find('.riquadro').each(function () {
	        var $box = $(this);

	        var boxStart = parseInt($box.attr('data-start-idx'), 10);
	        var boxEnd   = parseInt($box.attr('data-end-idx'), 10);

	        if (isNaN(boxStart) || isNaN(boxEnd)) {
	            return;
	        }

	        if (rangesOverlap(boxStart, boxEnd, startIdx, endIdx)) {
	            var top = parseFloat($box.css('top')) || 0;
	            var h = $box.outerHeight() || 0;
	            var bottom = top + h;

	            if (!found || bottom > maxBottom) {
	                maxBottom = bottom;
	                found = true;
	            }
	        }
	    });

	    return {
	        found: found,
	        nextTop: found ? (maxBottom + gapVerticale) : headerOffset
	    };
	}

	function getRowCurrentHeight($row) {
	    var maxHeight = 0;
	    $row.children('td').each(function () {
	        var h = $(this).outerHeight() || 0;
	        if (h > maxHeight) {
	            maxHeight = h;
	        }
	    });
	    return maxHeight;
	}

	function ensureRowHeight($row, requiredHeight) {
	    var currentHeight = getRowCurrentHeight($row);
	    if (requiredHeight > currentHeight) {
	        $row.children('td').height(requiredHeight);
	    }
	}
	
	function initTable(anno, filtro) {

	    $('.riquadro').remove();
	    $('#tabPrenotazione td')
	        .removeClass('prenotato')
	        .removeClass('prenotato_multi')
	        .css('height', '');

	    if ($.fn.DataTable.isDataTable('#tabPrenotazione')) {
	        $('#tabPrenotazione').DataTable().destroy();
	    }

	    $("#tabPrenotazione")
	        .off('init.dt')
	        .on('init.dt', function (e, settingsObj) {
	            var api = new $.fn.dataTable.Api(settingsObj);
	            var state = api.state.loaded();
	            if (state != null && state.columns != null) {
	                columsDatatables = state.columns;
	            }
	            $('#tabPrenotazione thead th').each(function () {
	                if (columsDatatables != null && columsDatatables.length > 0) {
	                    $('#inputsearchtable_' + $(this).index())
	                        .val(columsDatatables[$(this).index()].search.search);
	                }
	            });
	        });

	    // IMPORTANTE: initComplete riceve i "settings" come primo argomento.
	    // NON usare la variabile globale "table" qui dentro: non è ancora assegnata.
	    settings.initComplete = function (settingsObj, json) {
	        var api = new $.fn.dataTable.Api(settingsObj);

	        $('#tabellaWrapperInit').css('visibility', 'visible');
	        api.columns.adjust();

	     
	        caricaDatiPrenotazioni(anno, filtro);  // apro subito la FASE 2
	    };

	    table = $('#tabPrenotazione').DataTable(settings);
	}	
	
	
	function caricaDatiPrenotazioni(anno, filtro) {

	 

	    $.ajax({
	        url: 'gestionePrenotazioneCampione.do?action=lista_prenotazioni&anno=' + anno,
	        method: 'GET',
	        dataType: 'json',
	        success: function (response) {

	            var lista_prenotazioni = response.lista_prenotazioni || [];

	            $('.riquadro').remove();
	            $('#tabPrenotazione td')
	                .removeClass('prenotato')
	                .removeClass('prenotato_multi')
	                .css('height', '');

	            orariDisabilitati = [];

	            var headerOffset = 42;
	            var gapVerticale = 6;
	            var extraBottomPadding = 10;

	            for (var i = 0; i < lista_prenotazioni.length; i++) {

	                var pren = lista_prenotazioni[i];
	                if (!pren || !pren.utente) {
	                    continue;
	                }

	                var idUtente = pren.utente.id;
	                var startIdx = parseInt(pren.cella_inizio, 10);
	                var endIdx = parseInt(pren.cella_fine, 10);

	                if (isNaN(startIdx) || isNaN(endIdx)) {
	                    continue;
	                }

	                if (endIdx < startIdx) {
	                    var tmpIdx = startIdx;
	                    startIdx = endIdx;
	                    endIdx = tmpIdx;
	                }

	                var id_inizio = idUtente + "_" + startIdx;
	                var id_fine = idUtente + "_" + endIdx;
	                var id_prenotazione = pren.id;

	                var obj = {
	                    inizio: pren.data_inizio_prenotazione,
	                    fine: pren.data_fine_prenotazione,
	                    id: id_prenotazione
	                };
	                orariDisabilitati.push(obj);

	                var cellaInizio = $("#" + id_inizio);
	                var cellaFine = $("#" + id_fine);

	                if (cellaInizio.length === 0) {
	                    continue;
	                }

	                if (cellaFine.length === 0) {
	                    cellaFine = cellaInizio;
	                    endIdx = startIdx;
	                }

	                var $row = cellaInizio.closest('tr');

	                var codici = [];
	                if (pren.listaCampioni != null && pren.listaCampioni.length > 0) {
	                    for (var z = 0; z < pren.listaCampioni.length; z++) {
	                        if (pren.listaCampioni[z] && pren.listaCampioni[z].codice != null) {
	                            codici.push(escapeHtml(pren.listaCampioni[z].codice));
	                        }
	                    }
	                }

	                var testo = codici.join("<br>");
	                if (testo === "") {
	                    testo = "&nbsp;";
	                }

	                var larghezza = 0;
	                for (var j = startIdx; j <= endIdx; j++) {
	                    var $cellaTmp = $("#" + idUtente + "_" + j);
	                    if ($cellaTmp.length > 0) {
	                        larghezza += $cellaTmp.outerWidth();
	                    }
	                }

	                if (larghezza <= 0) {
	                    larghezza = cellaInizio.outerWidth();
	                }

	                if (startIdx !== endIdx) {
	                    larghezza = Math.max(20, larghezza - 5);
	                }

	                var righeTesto = Math.max(1, codici.length);
	                var lineHeight = 16;
	                var paddingY = 12;
	                var altezza = Math.max(36, (righeTesto * lineHeight) + paddingY);
	           
	                var maxLen = 0;
	                for (var k = 0; k < codici.length; k++) {
	                    if (codici[k].length > maxLen) {
	                        maxLen = codici[k].length;
	                    }
	                }

	                var larghezzaTesto = getTextWidth(
	                    (maxLen > 0 ? "X".repeat(maxLen) : "XXXX"),
	                    '12px Arial'
	                ) + 20;

	                if (larghezzaTesto > larghezza) {
	                    altezza += 18;
	                }

	                // QUI la correzione vera:
	                // guardo tutti i box della riga che hanno intervallo sovrapposto
	                var bottomInfo = getRowBoxesBottomInfo($row, startIdx, endIdx, headerOffset, gapVerticale);
	                var topBox = bottomInfo.nextTop;

	                for (var c = startIdx; c <= endIdx; c++) {
	                    var $cella = $("#" + idUtente + "_" + c);
	                    $cella.addClass('prenotato');

	                    if (startIdx !== endIdx) {
	                        $cella.addClass('prenotato_multi');
	                    }
	                }

	                var border_color = "#E6C200";
	                var background_color = "#FFF9C4";

	                if (pren.stato_prenotazione == 1) {
	                    border_color = "#FFD700";
	                    background_color = "#FFFFE0";
	                } else if (pren.stato_prenotazione == 2) {
	                    border_color = "#A0CE00";
	                    background_color = "#90EE90";
	                } else if (pren.stato_prenotazione == 3) {
	                    if (pren.rifornimento == 1) {
	                        border_color = "#F2861B";
	                        background_color = "#F7BB80";
	                    } else {
	                        border_color = "#1E90FF";
	                        background_color = "#ADD8E6";
	                    }
	                }

	                var title = pren.luogo != null ? escapeHtml(pren.luogo) : '';

	                

	                $("<div data-toggle='tooltip' title='" + title + "' class='riquadro' id='riquadro_" + id_prenotazione + "'  ondblclick='modalPrenotazione(" 
	                    + startIdx + ", " + idUtente + ", " + id_prenotazione + ")'>" + testo + "</div>")
	                    .attr('data-start-idx', startIdx)
	                    .attr('data-end-idx', endIdx).css({
	                        left: 0,
	                        top: topBox,
	                        width: larghezza,
	                        height: altezza,
	                        'text-align': 'center',
	                        'font-weight': 'bold',
	                        'background-color': background_color,
	                        'border': '2px solid ' + border_color,
	                        'z-index': 200,
	                        'box-sizing': 'border-box'
	                    })
	                    .appendTo(cellaInizio);

	                var requiredHeight = topBox + altezza + extraBottomPadding;
	                ensureRowHeight($row, requiredHeight);
	            }

	            recalcolaAltezzeRighe();

	            var today = "${today}";
	            if (parseInt(today) > parseInt("${daysNumber}")) {
	                today = null;
	            } else {
	                order = parseInt(today) + 3;
	            }

	            $('.inputsearchtable').off('input').on('input', function () {
	                var columnIndex = $(this).closest('th').index();
	                table.column(columnIndex).search($(this).val()).draw();
	            });
	            $('.inputsearchtable').off('click').on('click', function (e) {
	                e.stopPropagation();
	            });

	            table.columns.adjust().draw(false);

	            if (today != null && !isNaN(parseInt(today))) {
	                var coltoday = getDaysUntilMonday(parseInt(today), parseInt("${start_date}")) + 1;
	                scrollToColumn(today - coltoday);
	            }

	            pleaseWaitDiv.modal('hide');   // chiudo clessidra FASE 2
	        },
	        error: function (xhr, status, error) {
	            console.error(status);
	            pleaseWaitDiv.modal('hide');
	        }
	    });
	}

	function fillTable(anno, filtro) {
	    initTable(anno, filtro);
	    pleaseWaitDiv.modal('hide');
	}

	function filterTable() {
		var table = $('#tabPrenotazione');
		var rows = table.find('tr:gt(0)');

		rows.each(function() {
			var row = $(this);
			var hideRow = true;

			row.find('td:gt(2)').each(function() { // Inizia dalla quarta colonna (indice 3)
				if ($(this).text() !== '') {
					hideRow = false;
					return false; // Esci dal loop interno se una cella non è vuota
				}
			});

			if (hideRow) {
				row.hide(); // Nascondi le righe con tutte le celle vuote a partire dalla quarta colonna
			} else {
				row.show(); // Mostra le righe con almeno una cella piena a partire dalla quarta colonna
			}
		});
	}

	function scrollToColumn(columnIndex) {

		var tableWrapper = $('#tabPrenotazione_wrapper');
		var scrollBody = tableWrapper.find('.dataTables_scrollBody');
		var scrollHead = tableWrapper.find('.dataTables_scrollHead');
		var columnWidths = scrollHead.find('th').map(function() {
			return $(this).outerWidth();
		}).get();

		var scrollLeft = 0;
		for (var i = 0; i < columnIndex; i++) {
			scrollLeft += columnWidths[i];
		}

		scrollBody.animate({
			scrollLeft : scrollLeft
		}, 500);

		pleaseWaitDiv.modal('hide');

	}

	function getDaysUntilMonday(today, start_date) {
		var currentYear = new Date().getFullYear();
		var startDate = new Date(currentYear, 0); // Imposta la data al 1° gennaio dell'anno corrente
		startDate.setDate((today + start_date)); // Imposta il giorno dell'anno fornito
		var dayOfWeek = startDate.getDay(); // Ottiene il giorno della settimana (0 = Domenica, 1 = Lunedì, ..., 6 = Sabato)
		var daysUntilMonday = (dayOfWeek === 0) ? 6 : dayOfWeek - 1; // Calcola i giorni che mancano al Lunedì
		//  return (today > daysUntilMonday) ? 7 - today + daysUntilMonday : daysUntilMonday - today;
		return daysUntilMonday;
	}

	function rgbToHex(rgb) {
		var parts = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
		delete parts[0];
		for (var i = 1; i <= 3; ++i) {
			parts[i] = parseInt(parts[i]).toString(16);
			if (parts[i].length === 1)
				parts[i] = '0' + parts[i];
		}
		return '#' + parts.join('');
	}
	
	function recalcolaAltezzeRighe() {
	    $('#tabPrenotazione tbody tr').each(function() {
	        var row = $(this);
	        var rowTop = row[0].getBoundingClientRect().top;
	        var maxBottom = 0;

	        row.find('.riquadro').each(function() {
	            var rect = this.getBoundingClientRect();
	            var relativeBottom = (rect.top - rowTop) + rect.height;
	            if (relativeBottom > maxBottom) {
	                maxBottom = relativeBottom;
	            }
	        });

	        var newHeight = maxBottom > 0 ? maxBottom : 42;
	        row.children('td').height(newHeight);
	    });
	}
</script>