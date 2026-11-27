<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%
    LocalDate oggi = LocalDate.now();
    Integer annoCalendario = (Integer) session.getAttribute("anno");
    Integer giornoInizio = (Integer) session.getAttribute("start_date");
    Integer giornoFine = (Integer) session.getAttribute("end_date");
    LocalDate inizio = null;
    LocalDate fine = null;

    if (annoCalendario != null && giornoInizio != null && giornoFine != null) {
        LocalDate primoGennaio = LocalDate.of(annoCalendario, 1, 1);
        if (giornoInizio >= 1 && giornoInizio <= primoGennaio.lengthOfYear() && giornoFine >= giornoInizio) {
            inizio = primoGennaio.plusDays(giornoInizio - 1L);
            fine = primoGennaio.plusDays(giornoFine - 1L);
        }
    }

    request.setAttribute("inizioCalendarioDocenti", inizio);
    request.setAttribute("fineCalendarioDocenti", fine);
    request.setAttribute("oggiCalendarioDocenti", oggi);
    pageContext.setAttribute("annoCorrenteCalendarioDocenti", oggi.getYear());

    // Il servlet, senza "move", apre la finestra dal mese precedente alla data di riferimento.
    if (inizio != null) {
        LocalDate precedente = inizio.minusMonths(2);
        LocalDate successivo = fine.plusDays(1).plusMonths(1).withDayOfMonth(1);
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.ITALIAN);
        pageContext.setAttribute("annoPrecedenteDocenti", precedente.getYear());
        pageContext.setAttribute("giornoPrecedenteDocenti", precedente.getDayOfYear());
        pageContext.setAttribute("annoSuccessivoDocenti", successivo.getYear());
        pageContext.setAttribute("giornoSuccessivoDocenti", successivo.getDayOfYear());
        pageContext.setAttribute("periodoDocenti", inizio.format(formato) + " – " + fine.format(formato));
    }
%>
<c:url var="urlFormazione" value="/gestioneFormazione.do" />
<c:url var="urlHome" value="/" />
<c:url var="urlPluginZoom" value="/plugins/zoom-in-out-entire-page/jquery.page_zoom.min.js" />
<c:url var="urlOggi" value="/gestioneFormazione.do">
    <c:param name="action" value="gestione_pianificazione" />
    <c:param name="tipo" value="docente" />
    <c:param name="anno" value="${annoCorrenteCalendarioDocenti}" />
</c:url>

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">
    <jsp:attribute name="body_area">
        <div class="wrapper">
            <t:main-header />
            <t:main-sidebar />

            <div id="corpoframe" class="content-wrapper">
                <section class="content-header">
                    <a class="btn btn-default pull-right" href="<c:out value="${urlHome}" />">
                        <i class="fa fa-home" aria-hidden="true"></i> Home
                    </a>
                    <h1>Calendario docenti</h1>
                </section>

                <section class="content">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="calendario-docenti-toolbar">
                                <form method="get" action="<c:out value="${urlFormazione}" />"
                                      class="form-inline" id="formAnnoCalendarioDocenti">
                                    <input type="hidden" name="action" value="gestione_pianificazione">
                                    <input type="hidden" name="tipo" value="docente">
                                    <label for="annoCalendarioDocenti">Anno</label>
                                    <select class="form-control" name="anno" id="annoCalendarioDocenti">
                                        <c:forEach var="annoOpzione" begin="${annoCorrenteCalendarioDocenti - 5}"
                                                   end="${annoCorrenteCalendarioDocenti + 5}">
                                            <option value="${annoOpzione}"
                                                ${annoOpzione == (empty sessionScope.anno ? annoCorrenteCalendarioDocenti : sessionScope.anno) ? 'selected' : ''}>
                                                ${annoOpzione}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit" class="btn btn-default">Vai</button>
                                </form>
                                <a class="btn btn-primary" href="<c:out value="${urlOggi}" />">Vai a oggi</a>
                                <div class="btn-group" role="group" aria-label="Zoom della pagina">
                                    <button type="button" class="btn btn-default zoom_in" aria-label="Aumenta zoom">
                                        <i class="fa fa-search-plus" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" class="btn btn-default zoom_out" aria-label="Diminuisci zoom">
                                        <i class="fa fa-search-minus" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" class="btn btn-default zoom_reset">Ripristina zoom</button>
                                </div>

                                <c:if test="${not empty periodoDocenti}">
                                    <nav class="calendario-docenti-periodo" aria-label="Periodo del calendario">
                                        <c:url var="urlPrecedente" value="/gestioneFormazione.do">
                                            <c:param name="action" value="gestione_pianificazione" />
                                            <c:param name="tipo" value="docente" />
                                            <c:param name="anno" value="${annoPrecedenteDocenti}" />
                                            <c:param name="data_inizio" value="${giornoPrecedenteDocenti}" />
                                        </c:url>
                                        <c:url var="urlSuccessivo" value="/gestioneFormazione.do">
                                            <c:param name="action" value="gestione_pianificazione" />
                                            <c:param name="tipo" value="docente" />
                                            <c:param name="anno" value="${annoSuccessivoDocenti}" />
                                            <c:param name="data_inizio" value="${giornoSuccessivoDocenti}" />
                                        </c:url>
                                        <a class="btn btn-default" href="<c:out value="${urlPrecedente}" />"
                                           aria-label="Periodo precedente"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
                                        <span><c:out value="${periodoDocenti}" /></span>
                                        <a class="btn btn-default" href="<c:out value="${urlSuccessivo}" />"
                                           aria-label="Periodo successivo"><i class="fa fa-chevron-right" aria-hidden="true"></i></a>
                                    </nav>
                                </c:if>
                            </div>

                            <c:choose>
                                <c:when test="${not empty periodoDocenti}">
                                    <jsp:include page="gestioneCalendarioDocentiTabella.jsp" />
                                </c:when>
                                <c:otherwise>
                                    <p class="alert alert-warning" role="status">Periodo del calendario non disponibile.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </section>
            </div>

            <t:dash-footer />
            <t:control-sidebar />
        </div>
    </jsp:attribute>

    <jsp:attribute name="extra_css">
        <style>
            .calendario-docenti-toolbar,
            .calendario-docenti-periodo {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 8px;
            }

            .calendario-docenti-toolbar { margin-bottom: 14px; }
            .calendario-docenti-periodo { margin-left: auto; }
            .calendario-docenti-periodo span { white-space: nowrap; }
            .calendario-docenti-stato:empty { display: none; }

            .calendario-docenti-scroll {
                max-width: 100%;
                overflow-x: auto;
                border: 1px solid #d8e0eb;
                border-radius: 6px;
            }

            .calendario-docenti-tabella {
                border-collapse: separate;
                border-spacing: 0;
                width: max-content;
                min-width: 100%;
            }

            .calendario-docenti-tabella th,
            .calendario-docenti-tabella td {
                box-sizing: border-box;
                vertical-align: top;
            }

            .calendario-docenti-tabella .colonna-docenti {
                position: sticky;
                left: 0;
                z-index: 1;
                min-width: 128px;
                width: 128px;
                padding: 14px;
                color: #fff;
                border-right: 1px solid #2d466d;
                text-align: left;
            }

            .calendario-docenti-tabella thead .colonna-docenti {
                background: #fff;
                border-right-color: #e1e6ed;
            }

            .calendario-docenti-tabella tbody .colonna-docenti { background: #1d3255; }

            .calendario-docenti-tabella thead tr > * {
                border-bottom: 5px solid #fff;
            }

            .calendario-docenti-giorno,
            .calendario-docenti-cella {
                min-width: 170px;
                width: 170px;
                padding: 8px;
                border-right: 1px solid #e1e6ed;
            }

            .calendario-docenti-giorno {
                background: #f0f2f5;
                color: #253247;
                text-align: center;
            }

            .calendario-docenti-giorno small { display: block; }
            .calendario-docenti-giorno.festivo { background: #f8e2e0; color: #952d2d; }
            .calendario-docenti-giorno[data-oggi] { box-shadow: inset 0 -3px #2d7464; }
            .calendario-docenti-cella { height: 76px; background: #fff; }

            .calendario-docenti-riquadro {
                margin-bottom: 5px;
                padding: 7px 8px;
                border: 1px solid #dce3e8;
                border-radius: 5px;
                background: #f6f8f8;
                overflow-wrap: anywhere;
            }

            .calendario-docenti-riquadro strong,
            .calendario-docenti-riquadro span { display: block; }
            .calendario-docenti-riquadro span { color: #4d5c65; white-space: nowrap; }

            @media (max-width: 767px) {
                .calendario-docenti-periodo { margin-left: 0; }
                #formAnnoCalendarioDocenti .form-control { display: inline-block; width: auto; }
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="extra_js_footer">
        <script src="<c:out value="${urlPluginZoom}" />"></script>
        <script>
            $(document).ready(function () {
                $.page_zoom({
                    selectors: {
                        zoom_in: '.zoom_in',
                        zoom_out: '.zoom_out',
                        zoom_reset: '.zoom_reset'
                    },
                    max_zoom: 1.5,
                    min_zoom: 0.5,
                    current_zoom: 1,
                    zoom_increment: 0.1
                });
            });
        </script>
    </jsp:attribute>
</t:layout>
