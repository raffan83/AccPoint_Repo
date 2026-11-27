<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Locale" %>
<%
    LocalDate inizio = (LocalDate) request.getAttribute("inizioCalendarioDocenti");
    LocalDate fine = (LocalDate) request.getAttribute("fineCalendarioDocenti");
    LocalDate oggi = (LocalDate) request.getAttribute("oggiCalendarioDocenti");
    Collection<?> festivita = (Collection<?>) session.getAttribute("festivitaItaliane");
    DateTimeFormatter formatoGiorno = DateTimeFormatter.ofPattern("dd/MM", Locale.ITALIAN);
%>
<c:url var="urlListaPianificazioniDocenti" value="/gestioneFormazione.do">
    <c:param name="action" value="lista_pianificazioni_docenti" />
</c:url>

<% if (inizio != null && fine != null) { %>
    <p id="statoCalendarioDocenti" class="calendario-docenti-stato" role="status">
        Caricamento delle pianificazioni…
    </p>
    <div id="calendarioDocenti" class="calendario-docenti-scroll" tabindex="0"
         role="region" aria-label="Calendario docenti, scorrimento orizzontale" aria-busy="true"
         data-url="<c:out value="${urlListaPianificazioniDocenti}" />">
        <table class="calendario-docenti-tabella" aria-label="Docenti pianificati per giorno">
            <thead>
                <tr>
                    <td class="colonna-docenti"></td>
                    <% for (LocalDate giorno = inizio; !giorno.isAfter(fine); giorno = giorno.plusDays(1)) {
                           DayOfWeek settimana = giorno.getDayOfWeek();
                           // L'elenco in sessione copre l'anno selezionato. Gestisce anche il passaggio a gennaio.
                           boolean festivo = settimana == DayOfWeek.SATURDAY || settimana == DayOfWeek.SUNDAY
                                   || (festivita != null && festivita.contains(giorno))
                                   || (giorno.getMonthValue() == 1
                                       && (giorno.getDayOfMonth() == 1 || giorno.getDayOfMonth() == 6));
                    %>
                        <th scope="col" class="calendario-docenti-giorno<%= festivo ? " festivo" : "" %>"
                            <%= giorno.equals(oggi) ? "data-oggi aria-current=\"date\"" : "" %>>
                            <time datetime="<%= giorno %>">
                                <%= settimana.getDisplayName(TextStyle.SHORT, Locale.ITALIAN).toUpperCase(Locale.ITALIAN) %>
                                <small><%= giorno.format(formatoGiorno) %></small>
                            </time>
                        </th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th scope="row" class="colonna-docenti">Docente</th>
                    <% for (LocalDate giorno = inizio; !giorno.isAfter(fine); giorno = giorno.plusDays(1)) { %>
                        <td class="calendario-docenti-cella" data-giorno="<%= giorno %>"></td>
                    <% } %>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
        (function () {
            'use strict';

            var calendario = document.getElementById('calendarioDocenti');
            var stato = document.getElementById('statoCalendarioDocenti');
            var celle = new Map();
            calendario.querySelectorAll('[data-giorno]').forEach(function (cella) {
                celle.set(cella.dataset.giorno, cella);
            });

            function dataIso(data) {
                var parti = typeof data === 'string' && data.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/);
                return parti ? parti[3] + '-' + parti[1].padStart(2, '0') + '-' + parti[2].padStart(2, '0') : '';
            }

            function oraBreve(ora) {
                return (ora || '').trim().replace(/^(\d{1,2}):(\d{2})(?::\d{2})?$/, function (_, ore, minuti) {
                    return ore.padStart(2, '0') + ':' + minuti;
                });
            }

            function caricaDatiPianificazioni() {
                var anni = new Set();
                celle.forEach(function (cella, data) {
                    anni.add(data.slice(0, 4));
                });

                var richieste = Array.from(anni, function (anno) {
                    var url = new URL(calendario.dataset.url, window.location.href);
                    url.searchParams.set('anno', anno);

                    return fetch(url, { credentials: 'same-origin' }).then(function (risposta) {
                        if (!risposta.ok) throw new Error('HTTP ' + risposta.status);
                        return risposta.json();
                    }).then(function (dati) {
                        if (dati.success !== true || !Array.isArray(dati.lista_pianificazioni)) {
                            throw new Error('Risposta pianificazioni non valida');
                        }
                        return dati.lista_pianificazioni;
                    });
                });

                return Promise.all(richieste).then(function (liste) {
                    var schedePerGiorno = new Map();
                    var pianificazioniViste = new Set();

                    liste.forEach(function (pianificazioni) {
                        pianificazioni.forEach(function (pianificazione) {
                            var giorno = dataIso(pianificazione.data);
                            if (!celle.has(giorno) || !Array.isArray(pianificazione.listaDocenti)) return;

                            var chiave = giorno + ':' + pianificazione.id;
                            if (pianificazioniViste.has(chiave)) return;
                            pianificazioniViste.add(chiave);

                            var inizio = oraBreve(pianificazione.ora_inizio);
                            var fine = oraBreve(pianificazione.ora_fine);
                            var fascia = [inizio, fine].filter(Boolean).join(' - ');

                            if (!schedePerGiorno.has(giorno)) schedePerGiorno.set(giorno, []);
                            var schede = schedePerGiorno.get(giorno);

                            pianificazione.listaDocenti.forEach(function (docente) {
                                if (!docente) return;
                                var nominativo = (docente.nominativo || '').trim()
                                    || [docente.nome, docente.cognome].filter(Boolean).join(' ').trim();

                                if (nominativo) {
                                    schede.push({ nominativo: nominativo, inizio: inizio, fascia: fascia });
                                }
                            });
                        });
                    });

                    var numeroRiquadri = 0;
                    celle.forEach(function (cella, giorno) {
                        var schede = schedePerGiorno.get(giorno) || [];
                        schede.sort(function (a, b) {
                            return (a.inizio || '99:99').localeCompare(b.inizio || '99:99')
                                || a.nominativo.localeCompare(b.nominativo, 'it');
                        });

                        var contenuto = document.createDocumentFragment();
                        schede.forEach(function (scheda) {
                            var riquadro = document.createElement('div');
                            riquadro.className = 'calendario-docenti-riquadro';

                            var nome = document.createElement('strong');
                            nome.textContent = scheda.nominativo;
                            riquadro.appendChild(nome);

                            if (scheda.fascia) {
                                var orario = document.createElement('span');
                                orario.textContent = scheda.fascia;
                                riquadro.appendChild(orario);
                            }

                            contenuto.appendChild(riquadro);
                        });
                        cella.textContent = '';
                        cella.appendChild(contenuto);
                        numeroRiquadri += schede.length;
                    });

                    stato.textContent = numeroRiquadri ? '' : 'Nessun docente pianificato nel periodo.';
                }).catch(function (errore) {
                    console.error(errore);
                    stato.textContent = 'Impossibile caricare le pianificazioni dei docenti.';
                    stato.classList.add('text-danger');
                }).finally(function () {
                    calendario.setAttribute('aria-busy', 'false');

                    var oggi = calendario.querySelector('[data-oggi]');
                    if (oggi) {
                        var primaColonna = calendario.querySelector('thead .colonna-docenti');
                        calendario.scrollLeft = oggi.getBoundingClientRect().left
                            - primaColonna.getBoundingClientRect().right;
                    }
                });
            }

            caricaDatiPianificazioni();
        }());
    </script>
<% } %>
