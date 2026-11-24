<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />

<style>
    #dati_spedizione .text-right {
        color: #3c8dbc;
    }
</style>
  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio DDT
        <small></small>
      </h1>
         <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
         <a class="btn btn-default pull-right" href="#" onClick="tornaItem()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna agli Item</a>
         <a class="btn btn-default pull-right" href="#" onClick="tornaMagazzino()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna al Magazzino</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">

        <div class="col-xs-12">
          <div class="box">
          
            <div class="box-body">
              
            
            <div class="row">
               <c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('SR')}">
   <c:if test="${ddt.tipo_ddt.id != 1 and not empty sessionScope.spedizioneDdt}">
    <button type="button" class="btn btn-primary pull-right"
            style="margin-right: 20px; margin-left: 6px;"
            onclick="modalModificaSpedizione()">
        Modifica Spedizione <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
    </button>

    <button type="button" class="btn btn-primary pull-right"
            onclick="aggiornaStatoSpedizione('${sessionScope.spedizioneDdt.id}')">
        Aggiorna Stato Spedizione <i class="fa fa-refresh" aria-hidden="true"></i>
    </button>
</c:if>
</c:if>
      
	   <div class="col-xs-6">
	      <c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('SR')}">
	  <c:if test="${ddt.tipo_ddt.id != 1 and  empty sessionScope.spedizioneDdt}">
	   <button class="btn btn-primary pull-right" style="margin-left: 6px;"
        onclick="modalSpedizione('${pacco.id}', '${ddt.id}')">
    Invio Spedizione <i class="fa fa-tag" aria-hidden="true"></i>
</button>
	   </c:if>
	   </c:if>
	   <c:if test="${ddt.tipo_ddt.id!=1 }">
<button class="btn btn-danger pull-right" onClick="creaFileDDT('${ddt.numero_ddt}', '${pacco.id}', '${pacco.id_cliente}', '${pacco.id_sede}', '${ddt.id}')">Genera DDT <i class="fa fa-file-pdf-o"></i></button>

</c:if>
<button class="btn btn-primary pull-left" onClick="modificaDDT()">Modifica DDT <i class="fa fa-pencil-square-o"></i></button>
</div></div><br>

<div class="row">
<div class="col-xs-6">


<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" id="dati_ddt">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${ddt.id}</a>
                    
                </li>
                 <li class="list-group-item">
                  <b>Pacco</b> <a href="#" class="btn customTooltip customlink pull-right" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">PC_${pacco.id}</a>
                <%--   <a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dello strumento" onclick="dettaglioStrumento('${item_pacco.item.id_tipo_proprio}')">${item_pacco.item.id_tipo_proprio}</a></td></c:when> --%>                    
                </li>
                 <li class="list-group-item">
                  <b>Tipo DDT</b> <a class="pull-right">${ddt.tipo_ddt.descrizione}</a>
                </li>

                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <c:choose>
                <c:when test="${ddt.tipo_ddt.id==1 }">
                <b>Mittente</b>
                </c:when>
                <c:otherwise>
                
                <b>Destinatario</b>
                </c:otherwise>                
                </c:choose>
                  <a class="pull-right">${destinatario}</a>
                  </div></div>
                </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <c:choose>
                <c:when test="${ddt.tipo_ddt.id==1 }">
                <b>Indirizzo Mittente</b>
                </c:when>
                <c:otherwise>
                <b>Indirizzo Destinatario</b>
                </c:otherwise>                
                </c:choose>
                  <a class="pull-right">${sede_destinatario}</a>
                  </div>
                  </div>
                </li>
                <c:if test="${ddt.tipo_ddt.id==2}">
                   <li class="list-group-item">
                   <div class="row">
                     <div class="col-xs-12"> 
                  <b>Destinazione</b> 
                  <a class="pull-right" id="ddt_destinazione_testo">
    <c:out value="${destinazione}"/>
    </a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Indirizzo Destinazione</b>
<a class="pull-right" id="ddt_indirizzo_destinazione_testo">
    <c:out value="${sede_destinazione}"/>
</a>
                  </div>
                  </div>
                </li> 
				</c:if>

                <li class="list-group-item">
                  <b>Spedizioniere</b> <a class="pull-right">${ddt.spedizioniere}</a>
                </li>
                <li class="list-group-item">
                  <b>Data DDT</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ddt.data_ddt}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Numero DDT</b> <a class="pull-right">${ddt.numero_ddt} </a>
                </li>
                 <li class="list-group-item">
                  <b>LDV</b> <a class="pull-right">${ddt.ldv} </a>
                </li>
                 <li class="list-group-item">
                  <b>N. Prenotazione</b> <a class="pull-right">${ddt.n_prenotazione} </a>
                </li>
                <li class="list-group-item">
                  <b>Causale</b> <a class="pull-right">${ddt.causale.descrizione} </a>
                </li>
                <li class="list-group-item">
                <c:choose>
                <c:when test="${ddt.tipo_trasporto.id==2 }">
               <b>Tipo Trasporto</b> <a class="pull-right">${ddt.tipo_trasporto.descrizione} - ${ddt.operatore_trasporto } </a>                
                </c:when>
                 <c:otherwise>
                <b>Tipo Trasporto</b> <a class="pull-right">${ddt.tipo_trasporto.descrizione} </a>
                </c:otherwise>
                </c:choose>                  
                </li>
                <li class="list-group-item">
                  <b>Tipo Porto</b> <a class="pull-right">${ddt.tipo_porto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Aspetto</b> <a class="pull-right">${ddt.aspetto.descrizione} </a>
                </li>
                <li class="list-group-item">
                  <b>Annotazioni</b> <a class="pull-right">${ddt.annotazioni} </a>
                </li>
                <li class="list-group-item">
                  <b>Data Trasporto</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
       			  value="${ddt.data_trasporto}" /> </a>
                </li>     

                <li class="list-group-item">
                  <b>N. Colli</b> <a class="pull-right"> ${ddt.colli}  </a>
                </li>       
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Note</b>  <a class="pull-right">${ddt.note} </a> 
                </div>
                </div>
                </li>
                 <c:if test="${ddt.link_pdf!='' && ddt.link_pdf!=null}"> 
                <li class="list-group-item" id="link">
                
                   <b>Download</b> 
                  <c:url var="url" value="gestioneDDT.do">  					
  					<c:param name="action" value="download" />
  					<c:param name="id_ddt" value="${utl:encryptData(pacco.ddt.id) }"></c:param>
				  </c:url>
                 
<%-- <a   class="btn btn-danger customTooltip pull-right  btn-xs"  title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o"></i></a> --%>
<a  target="_blank"  class="btn btn-danger customTooltip pull-right  btn-xs" title="Click per scaricare il DDT"   href="${url}"><i class="fa fa-file-pdf-o fa-sm"></i></a>
                     
                </li>
                </c:if>
         
        </ul>

</div>
</div>






</div>

<c:if test="${not empty sessionScope.spedizioneDdt && ddt.tipo_ddt.id==2}">
  <div class="col-xs-6">
    <div class="box box-danger box-solid">
      <div class="box-header with-border">
        Dati spedizione
        <div class="box-tools pull-right">
          <button type="button" data-widget="collapse" class="btn btn-box-tool" aria-label="Espandi o comprimi i dati spedizione">
            <i class="fa fa-minus" aria-hidden="true"></i>
          </button>
        </div>
      </div>
      <div class="box-body" id="dati_spedizione">
        <ul class="list-group list-group-unbordered">
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>ID pacco</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.id_pacco}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Destinatario</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.destinatario}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Presso</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.presso}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Indirizzo</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.indirizzo}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>CAP</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.cap}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Città</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.citta}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Provincia</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.provincia}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Nazione</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.nazione}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Corriere</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.corriere}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Referente</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.referente}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Telefono</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.telefono}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Data spedizione</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><fmt:formatDate value="${sessionScope.spedizioneDdt.data_spedizione}" pattern="dd/MM/yyyy"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Codice tracking</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.codice_tracking}"/></div>
            </div>
          </li>
          <li class="list-group-item">
            <div class="row">
              <div class="col-xs-5"><b>Note</b></div>
              <div class="col-xs-7 text-right" style="overflow-wrap: break-word;"><c:out value="${sessionScope.spedizioneDdt.note}"/></div>
            </div>
          </li>
          
               <li class="list-group-item">
    <div class="row">
        <div class="col-xs-5"><b>Stato</b></div>
        <div class="col-xs-7 text-right" style="overflow-wrap: break-word;">
        <c:choose>
  <c:when test="${sessionScope.spedizioneDdt.stato.id == 4}">
		<span class="label label-success">${sessionScope.spedizioneDdt.stato.descrizione}</span>
  </c:when>
   <c:when test="${sessionScope.spedizioneDdt.stato.id == 1}">
		<span class="label label-warning">${sessionScope.spedizioneDdt.stato.descrizione}</span>
  </c:when>
  <c:when test="${sessionScope.spedizioneDdt.stato.id == 6}">
		<span class="label label-danger">${sessionScope.spedizioneDdt.stato.descrizione}</span>
  </c:when>
  <c:when test="${sessionScope.spedizioneDdt.stato.id == 7}">
		<span class="label label-default">${sessionScope.spedizioneDdt.stato.descrizione}</span>
  </c:when>
  </c:choose>
     
        </div>
    </div>
</li>
        </ul>
      </div>
    </div>
  </div>
</c:if>
</div>
             
             
             <div id="myModalInvioSpedizione" class="modal fade" tabindex="-1" role="dialog"
     aria-labelledby="titoloModalInvioSpedizione">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Chiudi">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="titoloModalInvioSpedizione">Dati Spedizione</h4>
      </div>

      <form id="formInvioSpedizione">
        <div class="modal-body">
          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label for="spedizione_id_pacco">ID pacco</label>
                <input type="text" class="form-control" id="Spedizione_id_pacco" name="id_pacco" readonly>
              </div>
            </div>
            <div class="col-sm-8">
              <div class="form-group">
                <label for="spedizione_destinatario">Destinatario</label>
                <input type="text" class="form-control" id="spedizione_destinatario" name="destinatario" required>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label for="spedizione_presso">Presso</label>
                <input type="text" class="form-control" id="spedizione_presso" name="presso">
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="spedizione_referente">Referente</label>
                <input type="text" class="form-control" id="spedizione_referente" name="referente">
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-8">
              <div class="form-group">
                <label for="spedizione_inidirizzo">Indirizzo</label>
                <input type="text" class="form-control" id="spedizione_indirizzo" name="indirizzo" required>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label for="spedizione_cap">CAP</label>
                <input type="text" class="form-control" id="spedizione_cap" name="cap" required>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label for="spedizione_citta">Città</label>
                <input type="text" class="form-control" id="spedizione_citta" name="citta" required>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label for="spedizione_provincia">Provincia</label>
                <input type="text" class="form-control" id="spedizione_provincia" name="provincia">
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label for="spedizione_nazione">Nazione</label>
                <input type="text" class="form-control" id="spedizione_nazione" name="nazione" required>
              </div>
            </div>
          </div>

          <div class="row">
           <div class="col-sm-6">
 <div class="form-group">
    <label for="spedizione_corriere">Corriere</label>
    <select class="form-control" id="spedizione_corriere"
            name="corriere" required style="width: 100%;">
        <option value=""></option>
        <c:forEach var="corriere" items="${lista_corrieri}">
            <option value="<c:out value='${corriere.nominativo}'/>">
                <c:out value="${corriere.nominativo}"/>
            </option>
        </c:forEach>
    </select>
</div>
</div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="spedizione_telefono">Telefono</label>
                <input type="tel" class="form-control" id="spedizione_telefono" name="telefono">
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label for="spedizione_data_spedizione">Data spedizione</label>
                <input type="text" class="form-control" id="spedizione_data_spedizione" name="data_spedizione">
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="spedizione_codice_tracking">Codice tracking</label>
                <input type="text" class="form-control" id="spedizione_codice_tracking" name="codice_tracking" required>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-12">
              <div class="form-group">
                <label for="spedizione_note">Note</label>
                <textarea class="form-control" id="spedizione_note" name="note" rows="3"></textarea>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">   
  <button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
<input type="hidden" id="spedizione_id_ddt" name="id_ddt">
  <button type="submit" id="btnSalvaSpedizione" class="btn btn-primary">INVIA</button>
</div>
      </form>
    </div>
  </div>
</div>


<c:if test="${ddt.tipo_ddt.id != 1 and not empty sessionScope.spedizioneDdt}">
    <fmt:formatDate var="dataSpedizioneModifica"
                    value="${sessionScope.spedizioneDdt.data_spedizione}"
                    pattern="yyyy-MM-dd"/>

    <div id="myModalModificaSpedizione" class="modal fade" tabindex="-1"
         role="dialog" aria-labelledby="titoloModalModificaSpedizione">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Chiudi">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 id="titoloModalModificaSpedizione" class="modal-title">
                        Modifica Spedizione
                    </h4>
                   <p class="text-muted" style="margin: 4px 0 0;">
    <strong>ATTENZIONE!! Le seguenti modifiche NON verrano salvate in Gestione STI Etichette</strong><br>
    Per mantenere allineati i dati, applica le stesse modifiche in Gestione STI Etichette.
    </p>
                </div>
                

                <form id="formModificaSpedizione">
                    <div class="modal-body">
                        <input type="hidden" name="id"
                               value="<c:out value='${sessionScope.spedizioneDdt.id}'/>">

                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label for="spedizione_mod_id_pacco">ID pacco</label>
                                <input type="text" id="spedizione_mod_id_pacco" name="id_pacco"
                                       class="form-control" readonly
                                       value="<c:out value='${sessionScope.spedizioneDdt.id_pacco}'/>">
                            </div>
                            <div class="col-sm-8 form-group">
                                <label for="spedizione_mod_destinatario">Destinatario</label>
                                <input type="text" id="spedizione_mod_destinatario" name="destinatario"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.destinatario}'/>">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="spedizione_mod_presso">Presso</label>
                                <input type="text" id="spedizione_mod_presso" name="presso"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.presso}'/>">
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="spedizione_mod_referente">Referente</label>
                                <input type="text" id="spedizione_mod_referente" name="referente"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.referente}'/>">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-8 form-group">
                                <label for="spedizione_mod_indirizzo">Indirizzo</label>
                                <input type="text" id="spedizione_mod_indirizzo" name="indirizzo"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.indirizzo}'/>">
                            </div>
                            <div class="col-sm-4 form-group">
                                <label for="spedizione_mod_cap">CAP</label>
                                <input type="text" id="spedizione_mod_cap" name="cap"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.cap}'/>">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-4 form-group">
                                <label for="spedizione_mod_citta">Città</label>
                                <input type="text" id="spedizione_mod_citta" name="citta"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.citta}'/>">
                            </div>
                            <div class="col-sm-4 form-group">
                                <label for="spedizione_mod_provincia">Provincia</label>
                                <input type="text" id="spedizione_mod_provincia" name="provincia"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.provincia}'/>">
                            </div>
                            <div class="col-sm-4 form-group">
                                <label for="spedizione_mod_nazione">Nazione</label>
                                <input type="text" id="spedizione_mod_nazione" name="nazione"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.nazione}'/>">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="spedizione_mod_corriere">Corriere</label>
                                <input type="text" id="spedizione_mod_corriere" name="corriere"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.corriere}'/>">
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="spedizione_mod_telefono">Telefono</label>
                                <input type="tel" id="spedizione_mod_telefono" name="telefono"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.telefono}'/>">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="spedizione_mod_data_spedizione">Data spedizione</label>
                                <input type="date" id="spedizione_mod_data_spedizione" name="data_spedizione"
                                       class="form-control"
                                       value="<c:out value='${dataSpedizioneModifica}'/>">
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="spedizione_mod_codice_tracking">Codice tracking</label>
                                <input type="text" id="spedizione_mod_codice_tracking" name="codice_tracking"
                                       class="form-control"
                                       value="<c:out value='${sessionScope.spedizioneDdt.codice_tracking}'/>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="spedizione_mod_note">Note</label>
                            <textarea id="spedizione_mod_note" name="note" class="form-control"
                                      rows="3"><c:out value="${sessionScope.spedizioneDdt.note}"/></textarea>
                        </div>
                    </div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
    <button type="submit" id="btnSalvaModificaSpedizione" class="btn btn-primary">
        Salva
    </button>
</div>
                </form>
            </div>
        </div>
    </div>
</c:if>


            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        

        
 </div>
</div>
       


      <form name="ModificaDdtForm" method="post" id="ModificaDdtForm" action="gestioneDDT.do?action=salva" enctype="multipart/form-data">
         <div id="myModalModificaDdt" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica DDT</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">


<div class="form-group" >

 <div id="collapsed_box" class="box box-danger box-solid collapsed-box" >
<div class="box-header with-border" >
	 DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-md-12">
<a class="btn btn-primary pull-right disabled" id="conf_button" onClick="importaConfigurazioneDDT()" title="Click per importare la configurazione"><i class="fa fa-arrow-down"></i></a>
</div>
</div>
<div class="row">
<div class="col-md-4">
<label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.numero_ddt}" id="numero_ddt" name="numero_ddt" ></a>
</div>
<div class="col-md-4">
<label>Data DDT</label>    
     
            <span class='date datepicker' id='datepicker_ddt'>
           		<span class="input-group">
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt" value="${ddt.data_ddt }"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </span>
        </span> 

</div>
<div class="col-md-4">
<label>N. Colli</label> <a class="pull-center"><input type="number" class="form-control" id="colli" name="colli"  min=0   value="${ddt.colli }"> </a>
</div>

</div>
<div class="row">
<div class="col-md-12">
 <div  class="box box-danger box-solid" >

<div class="box-body">

<div class="row" id="row_destinazione">
<div class="col-md-4">
<div style="display:none">
<select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="cliente_appoggio" name="cliente_appoggio" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select>
                 
</div>

<label>Destinazione</label> 
                  <a class="pull-center">

                  <input class="form-control" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%">
                  </a> 
</div>

<div class="col-md-4">

<label>Sede Destinazione</label> 
                  <a class="pull-center">
                 <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">               	  
               	 	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                  </c:forEach>
                  </select>
                                   
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
                  
                  
                  </c:otherwise>
                  </c:choose> 

                  
                  </a> 
</div>
</div>

<div class="row">
<div class="col-md-4">
<label id="dest_mitt">Destinatario</label> 
                  <a class="pull-center">
                  

                  <input class="form-control" data-placeholder="Seleziona Destinatario..." id="destinatario" name="destinatario" style="width:100%">
                  </a>

</div>
<div class="col-md-4">

<label id="sede_dest_mitt">Sede Destinatario</label> 
                  <a class="pull-center">
                   <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinatario..." id="sede_destinatario" name="sede_destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%> 
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                  </c:forEach>
                  </select>
                                   
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinatario..." id="sede_destinatario" name="sede_destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>  
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
                  
                  
                  </c:otherwise>
                  </c:choose> 
                
                  
                  </a> 

</div>
<div class="col-md-2">
<a class="btn btn-primary" style="margin-top:25px" onClick="importaInfoDaCommessa('${pacco.commessa}', 0)">Importa Da Commessa</a>

</div>

</div>

</div>
</div>
</div>
</div>
<div class="row">
<div class= "col-md-4">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT" class="form-control "  aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
		<c:choose>
		<c:when test="${tipo_ddt.id==ddt.tipo_ddt.id }">
			<option value="${tipo_ddt.id}" selected>${tipo_ddt.descrizione}</option>		
			</c:when>	
			<c:otherwise>
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</div>
<div class= "col-md-4">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_aspetto}" var="aspetto">
		<c:choose>
		<c:when test="${aspetto.id==ddt.aspetto.id }">
			<option value="${aspetto.id}" selected>${aspetto.descrizione}</option>		
			</c:when>	
			<c:otherwise>
			<option value="${aspetto.id}">${aspetto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
	</select>

	


</div>

<div class= "col-md-4">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
		<c:choose>
		<c:when test="${tipo_porto.id==ddt.tipo_porto.id }">
			<option value="${tipo_porto.id}" selected>${tipo_porto.descrizione}</option>
			</c:when>	
			<c:otherwise>
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>


	</select>
</div>
</div>

<div class="row">
<div class="col-md-4">
<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto" class="form-control select2-drop "  aria-hidden="true" data-live-search="true">	
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
			<c:choose>
			<c:when test="${tipo_trasporto.id==pacco.ddt.tipo_trasporto.id }">
			<option value="${tipo_trasporto.id}" selected>${tipo_trasporto.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>

</div>
<div class="col-md-4">
<label>Causale</label> 
<select name="causale" id="causale" data-placeholder="Seleziona Causale..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
		<option value=""></option>
		<c:forEach items="${lista_causali}" var="causale">
			<c:choose>
			<c:when test="${causale.id==pacco.ddt.causale.id }">
			<option value="${causale.id}" selected>${causale.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${causale.id}">${causale.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</div>
<div class="col-md-4">
<label>Data Trasporto</label>    

 <span class="date datepicker"  id="datepicker_trasporto" > 
        <span class="input-group">
                     <input type="text" class="form-control date input-small" id="data_ora_trasporto" value="${ddt.data_trasporto }" name="data_ora_trasporto"/>
            
            <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
        </span>
         </span> 

</div>


</div>
<div class="row">

<div class="col-md-4">
 <div class="row" id="operatore_section" style="display:none">
<div class="col-md-12" >
<label>Operatore Trasporto</label>
	<input type="text" id="operatore_trasporto" name="operatore_trasporto" class="form-control">
</div>

</div>  
 <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.annotazioni }" id="annotazioni" name="annotazioni"> </a>
 
 <div class="row">
<div class="col-md-12" >
<label>Magazzino</label>
	<select id="magazzino" name="magazzino" class="form-control">
	<option value="Principale">Principale</option>
	</select>
	 <label>LDV</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.ldv }" id="ldv" name="ldv"> </a>
</div>
 
 

</div>
</div>

<div class="col-md-4">

<label>Spedizioniere</label> 
<a class="pull-center"><input type="text" class="form-control" value="${ddt.spedizioniere }" id="spedizioniere" name="spedizioniere"> </a>

 <div class="row">
<div class="col-md-12" >
<label>Peso (Kg)</label>
	<input type="text" id="peso" name="peso" class="form-control" value="${ddt.peso }">
	 <label>N. Prenotazione</label> <a class="pull-center"><input type="text" class="form-control" value="${ddt.n_prenotazione }" id="n_prenotazione" name="n_prenotazione"> </a>
</div>

</div> 
</div>
<div class="col-md-4">
 <div class="row">
<div class="col-md-12" >
<label>Account Spedizioniere</label>
<input type="text" id="account" name="account" class="form-control" value="${pacco.ddt.account }"/> 
</div>

</div> 
<label>Cortese Attenzione</label>
	<input type="text" id="cortese_attenzione" name="cortese_attenzione" class="form-control" value="${ddt.cortese_attenzione }">

</div>
</div>
<div class= "row">
<div class="col-md-6">
<label>Note DDT</label>
<select  id= tipo_note_ddt data-placeholder="Seleziona Note..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
	<option value=""></option>
		<c:forEach items="${lista_note_ddt}" var="nota_ddt">
			<option value="${nota_ddt.descrizione}">${nota_ddt.descrizione}</option>
		</c:forEach>
	</select>

</div>
<div class="col-md-2">
<a class="btn btn-primary" id="addNotaButton" onClick="aggiungiNotaDDT($('#tipo_note_ddt').val())" style="margin-top:25px"><i class="fa fa-plus"></i></a>
</div>
<div class="col-md-4">
<label>Allega File</label>
 <input id="fileupload_pdf" type="file" name="file" class="form-control"/>
</div>
</div><br>
<div class= "row">
 <div class="col-md-12">
 <a class="pull-center">
	<textarea name="note" form="ModificaDdtForm" id="note" class="form-control" rows=3 style="width:100%">${ddt.note }</textarea></a> 
 
 </div>

</div>

</div>
</div>
</div>
	


</div>


    
     <div class="modal-footer">

		<input type="hidden" class="pull-right" id="configurazione_ddt" name="configurazione_ddt" > 
		<input type="hidden" class="pull-right" id="id_ddt" name="id_ddt">
		<input type="hidden" class="pull-right" id ="pdf_path" name="pdf_path" value="${ddt.link_pdf }">
		<p align='center'><button class="btn btn-default " onClick="chooseSubmit()"><i class="glyphicon glyphicon"></i> Modifica DDT</button></p>
        
    </div>
    </div>
      </div>
    
      </div>

 </form>
  
  
  
        <div id="myModalSaveStato" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Salva Configurazione</h4>
      </div>
       <div class="modal-body">
       Vuoi salvare la configurazione del DDT per la sede selezionata?
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  id = "yes_button" onClick="salvaConfigurazione(1)">SI</button>
		<button class="btn btn-primary"  id = "no_button"  onClick="salvaConfigurazione(0)">NO</button>
       
      </div>
    </div>
  </div>
</div>

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 
</jsp:attribute>



<jsp:attribute name="extra_js_footer">

		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>

 <script type="text/javascript">
 
	function aggiungiNotaDDT(nota){
		if(nota!=""){
			$('#note').append(nota+ " ");
		}
	}

	function salvaConfigurazione(si_no){

		if(si_no==1){
			modificaDdtSubmit(1);
		}else{
			modificaDdtSubmit(0);
		}

}
	
    $(function () {
        var modal = $('#myModalInvioSpedizione');
        var select = modal.find('#spedizione_corriere');

        if (!select.length) {
            return;
        }

        modal.one('shown.bs.modal', function () {
            select.select2({
                tags: true,
                placeholder: 'Scegli o scrivi un corriere',
                dropdownParent: modal,
                width: '100%'
            });
        });
    });


	function importaConfigurazioneDDT(){
		
		 var lista_save_stato = '${lista_save_stato_json}';
		  var id_cliente = $('#destinazione').val();
		  var id_sede = $('#sede_destinazione').val().split('_')[0];
		  
		  if(lista_save_stato!=null && lista_save_stato!=''){
		  var save_stato_json = JSON.parse(lista_save_stato);
		  
		  save_stato_json.forEach(function(item){
		  	
			  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
				  $('#spedizioniere').val(item.spedizioniere);
				  $('#account').val(item.account);
				  $('#cortese_attenzione').val(item.ca);
				  $('#tipo_porto').val(item.tipo_porto);
				  $('#aspetto').val(item.aspetto);				  
			  }
		  
		  
		  });
		  }
	} 
	
	
 	function modalConfigurazione(){

			if($('#numero_ddt').val()!=null && $('#numero_ddt').val()!=""){
				var esito = validateForm();
				if(esito){
					$('#myModalSaveStato').modal();
				}
			}else{
				modificaDdtSubmit(0);
			}
		 		
	}
	
	
 	function destinazioneBox(){
		
 		
		var destinatario = "${ddt.id_destinatario}";
		var sede_destinatario = "${ddt.id_sede_destinatario}";
		var destinazione = "${ddt.id_destinazione}";
		var sede_destinazione = "${ddt.id_sede_destinazione}";
		 $('#destinatario').val(destinatario);
			$('#destinatario').change();	
			if(sede_destinatario==0){
				$('#sede_destinatario option[value="0"]').attr("selected", true);
			}else{
				$('#sede_destinatario option[value="'+sede_destinatario+'_'+destinatario+'"]').attr("selected", true);
			}
			
			
			$('#destinazione').val(destinazione);
			$('#destinazione').change();		
			if(sede_destinazione==0){
				$('#sede_destinazione option[value="0"]').attr("selected", true); 
			}else{
				$('#sede_destinazione option[value="'+sede_destinazione+'_'+destinazione+'"]').attr("selected", true); 	
			}
			
			
			initSelect2('#destinazione');
			initSelect2('#destinatario');
		 
	} 
 	
	function tornaMagazzino(){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  callAction('listaPacchi.do');
	}
	
	
	function tornaItem(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  callAction('listaItem.do?action=lista');
	}
	
	function chooseSubmit(){
		if($('#tipo_ddt').val()==1){
			modificaDdtSubmit(0);
		}else{
			modalConfigurazione();
		}
	}

	  $('#sede_destinazione').change(function(){
		  $('#conf_button').addClass("disabled");
		  if($('#tipo_ddt').val() != 1){
		  var id_cliente = $('#destinazione').val();
		  var id_sede = $('#sede_destinazione').val().split('_')[0];
		  var lista_save_stato = '${lista_save_stato_json}';
		 
		  
 		  if(lista_save_stato!=null && lista_save_stato!=''){
		 	 var save_stato_json = JSON.parse(lista_save_stato);
		  
		  	save_stato_json.forEach(function(item){
		  	
			  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
				  $('#conf_button').removeClass("disabled");
			  }
		  
		  
		 	 });
		 
		  }

		  }
	  });
 	
 function modificaDDT(){
	 
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal('show');
	
	
	 $('#collapsed_box').removeClass("collapsed-box");
	 $("#myModalModificaDdt").modal('show');
	 destinazioneBox();
	 pleaseWaitDiv.modal('hide');
	 
 }
 
 $('#tipo_trasporto').change(function(){
		
	 var sel =  $('#tipo_trasporto').val();
	 if(sel==2){
		 $('#operatore_section').show();
	 }else{
		 $('#operatore_trasporto').val("");
		 $('#operatore_section').hide();
	 }
	 
 });
 
	function modificaDdtSubmit(configurazione){
		
		var id_pacco= ${pacco.id};
		var id_ddt = ${pacco.ddt.id};
		
		$('#id_pacco').val(id_pacco);
		$('#id_ddt').val(id_ddt);
		$('#configurazione_ddt').val(configurazione);
		var pdf = $('#pdf_path').val();
		var esito = validateForm();
		if(esito==true){
		document.getElementById("ModificaDdtForm").submit();
		
		
		}
		else{};
	}

	function validateForm() {
	  
	    var numero_ddt = document.forms["ModificaDdtForm"]["numero_ddt"].value;
	    $('#data_ddt').css('border', '1px solid #d2d6de');
	    if (numero_ddt=="") {	
	    	$('#myModalError').removeClass();
			$("#myModalErrorContent").html("Attenzione! inserisci il numero del DDT!");
			$('#myModalError').addClass("modal modal-danger");   
			$('#myModalError').modal('show');
	        return false;	    	
	    }
	    
	    if($('#data_ddt').val()!=''&&!isDate($('#data_ddt').val())){
	    	
	    	$('#data_ddt').css('border', '1px solid #f00');
			$('#myModalError').removeClass();
			$("#myModalErrorContent").html("Attenzione! Formato data errato!");
			$('#myModalError').addClass("modal modal-danger");   
			$('#myModalError').modal('show');
			return false;
	    }	    
	    	return true;
	    
	}

 	function formatDate(data, container){
	
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   if(container == '#data_ora_trasporto'){
			 str = mydate.toString("dd/MM/yyyy");
		   }else{
			   str = mydate.toString("dd/MM/yyyy");
		   }
	   $(container).val(str );
 	}
	
	}
 
 	
 	
	$("#fileupload").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        	$('#myModalLabel').html("Attenzione!");
        	$('#myModalError').css("z-index", "1070");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalErrorContent').html("Inserisci solo pdf!");
			$('#myModalError').modal('show');
        	
			$(this).val("");
        }
		
	});
 

  $("#myModalError").on("hidden.bs.modal", function () {
	  
	  if($('#myModalError').hasClass("modal-success")){
	  location.reload();
  	}
	    
	}); 
    

 function creaFileDDT(numero_ddt, id_pacco, id_cliente, id_sede, id_ddt){
 	
 	creaDDTFile(numero_ddt,id_pacco, id_cliente, id_sede, id_ddt);
 	
 }
 
 $('#tipo_ddt').on('change', function(){
	
	 if($('#tipo_ddt').val()==1){
		 $('#dest_mitt').html("Mittente");
		 $('#sede_dest_mitt').html("Sede Mittente");
		 $('#row_destinazione').hide();
		 $('#sede_destinazione').change();
	 }else{
		  $('#dest_mitt').html("Destinatario");
		  $('#sede_dest_mitt').html("Sede Destinatario");
		  $('#row_destinazione').show();
		  $('#sede_destinazione').val("");
		  $('#sede_destinazione').change();
	 }
	 
 });
 
 
 $(document).ready(function() {
	 
	
	 $.fn.modal.Constructor.prototype.enforceFocus = function() {};
	 
	 $('.select2').select2({
	        dropdownParent: $('#myModalModificaDdt'),
	        width: '100%'
	    });
	 
	  var data_ora_trasporto = $('#data_ora_trasporto').val()
	   var data_ddt = $('#data_ddt').val();
	  var data_arrivo = $('#data_arrivo').val();
	  
	  var tipo_ddt=${ddt.tipo_ddt.id};
	  
	  if(tipo_ddt==1){
		  $('#dest_mitt').html("Mittente");
		  $('#sede_dest_mitt').html("Sede Mittente");
		  $('#row_destinazione').hide();
	  }else{
		  $('#dest_mitt').html("Destinatario");
		  $('#sede_dest_mitt').html("Sede Destinatario");
		  $('#row_destinazione').show();
	  }
	 
	 formatDate(data_ora_trasporto, '#data_ora_trasporto');
	   
	   formatDate(data_ddt, '#data_ddt');
	   formatDate(data_arrivo, '#data_arrivo');
	 
	  
 $('.datepicker').datepicker({
		format : "dd/mm/yyyy"
	});
		
 });
 
 
 
 $("#destinatario").change(function() {         
	  if ($(this).data('options') == undefined) 
	  {
	   
	    $(this).data('options', $('#sede_destinatario option').clone());
	  }
	  
	  var id = $(this).val();
	  var options = $(this).data('options');
	//  var id_sede = ${pacco.ddt.id_sede_destinazione };      	  
	  var opt=[];      	
	  opt.push("<option value = 0 >Non associate</option>");
	   for(var  i=0; i<options.length;i++)
	   {
		   
		var str=options[i].value.split("_");       		
		if(str[1]==id)
		{
			opt.push(options[i]);      			
		}   
	   }
	 $("#sede_destinatario").prop("disabled", false);   	 
	  $('#sede_destinatario').html(opt);   	  
	  $("#sede_destinatario").trigger("chosen:updated");   	  
		//$("#sede_destinatario").change();  
	});

$("#destinazione").change(function() {    
  

  
	  if ($(this).data('options') == undefined) 
	  {
	    
	    $(this).data('options', $('#sede_destinazione option').clone());
	  }
	var id2 = $(this).val();
	var id = null;
	if($(this).val()!=""){
		id = $(this).val().split("_");
	}else{
		id=$(this).val();
	}
	
	  var options = $(this).data('options');
	  var id_sede = ${pacco.id_sede };      	  
	  var opt=[];      	

	  opt.push("<option value = ''></option>");
	opt.push("<option value = 0>Non Associate</option>");
	  
	   for(var  i=0; i<options.length;i++)
	   {
		var str=[]
	str=options[i].value.split("_");       		
	if(str[1]==id[0])
		{
			opt.push(options[i]);      			
		}   
	   }
	 $("#sede_destinazione").prop("disabled", false);   	 
	  $('#sede_destinazione').html(opt);   	  
	  if(id==0){
		  $("#sede_destinazione").val('');
	  }
	  $("#sede_destinazione").trigger("chosen:updated");   	  
		$("#sede_destinazione").change();  
	}); 
 
 
	 $('#ModificaDdtForm').on('submit',function(e){
	 	    e.preventDefault();

	 	});   
	 
	 
		function isDate(ExpiryDate) { 
	   	    var objDate,  // date object initialized from the ExpiryDate string 
	   	        mSeconds, // ExpiryDate in milliseconds 
	   	        day,      // day 
	   	        month,    // month 
	   	        year;     // year    	    
	    	    if (ExpiryDate.length !== 10) { 
	   	        return false; 
	   	    }  
	   	    
	   	    if (ExpiryDate.substring(2, 3) !== '/' || ExpiryDate.substring(5, 6) !== '/') { 
	   	        return false; 
	   	    } 
	   	  
	   		day = ExpiryDate.substring(0, 2) - 0; 
	   	    month = ExpiryDate.substring(3, 5) - 1; 
	   	    year = ExpiryDate.substring(6, 10) - 0; 
	   	    
	   	    if (year < 1000 || year > 3000) { 
	   	        return false; 
	   	    } 
	   	    mSeconds = (new Date(year, month, day)).getTime(); 
	   	  
	   	    objDate = new Date(); 
	   	    objDate.setTime(mSeconds); 
	   	    
	   	    if (objDate.getFullYear() !== year || 
	   	        objDate.getMonth() !== month || 
	   	        objDate.getDate() !== day) { 
	   	        return false; 
	   	    } 
	   	  
	   	    return true; 
	   	}
	 
		  var options =  $('#cliente_appoggio option').clone();
		  function mockData() {
		  	  return _.map(options, function(i) {		  
		  	    return {
		  	      id: i.value,
		  	      text: i.text,
		  	    };
		  	  });
		  	}
	 
		  function initSelect2(id_input) {
			    $(id_input).select2({
			        data: mockData(),
			        placeholder: "",
			        multiple: false,
			        dropdownParent: $('#myModalModificaDdt'),
			        query: function(q) {
			            var pageSize = 20;
			            var results = [];
			            var that = this;

			            if (q.term && q.term !== '') {
			                results = _.filter(that.data, function(e) {
			                    return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
			                });
			            } else if (q.term === '') {
			                results = that.data;
			            }

			            q.callback({
			                results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
			                more: results.length >= q.page * pageSize
			            });
			        }
			    });
			}
		  
		  
		  function modalSpedizione(id_pacco, id_ddt) {

			    var pleaseWaitDiv = $('#pleaseWaitDialog');
			    pleaseWaitDiv.modal();

			    var destinazione = $('#dati_ddt #ddt_destinazione_testo').text().trim();
			    var indirizzo = $('#dati_ddt #ddt_indirizzo_destinazione_testo').text().trim();
			    
			    var dataObj = {};
			    dataObj.id_pacco = id_pacco;
			    dataObj.id_ddt = id_ddt;
			    dataObj.destinazione = destinazione;
			    dataObj.indirizzo = indirizzo;

			    $.ajax({
			        type: "POST",
			        url: "gestioneSpedizione.do?action=recupero_dati_spedizione",
			        data: dataObj,
			        dataType: "json",

			        success: function (data, textStatus) {
			            

			            if (data && data.success) {
			                var spedizione = data.spedizione || {};
			                var form = $('#formInvioSpedizione');

			                form[0].reset();

			                form.find(':input[name]').not('#spedizione_corriere').each(function () {
                                var valore = spedizione[this.name];
                                $(this).val(valore == null ? '' : valore);
                            });

                            var selectCorriere = form.find('#spedizione_corriere');
                            var corriere = $.trim(spedizione.corriere || '');

                            selectCorriere.find('option[data-corriere-precompilato]').remove();
                            var presente = selectCorriere.find('option').filter(function () {
                                return this.value === corriere;
                            }).length > 0;

                            if (corriere && !presente) {
                                selectCorriere.append($('<option>', {
                                    value: corriere,
                                    text: corriere,
                                    'data-corriere-precompilato': 'true'
                                }));
                            }
                            selectCorriere.val(corriere).trigger('change');
                            form.find('#spedizione_id_ddt').val(id_ddt);

                            function apriModaleSpedizione() {
                                $('#myModalInvioSpedizione').modal('show');
                            }

                            var modaleAttesa = pleaseWaitDiv.data('bs.modal');
                            if (modaleAttesa && modaleAttesa.isShown) {
                                pleaseWaitDiv.one('hidden.bs.modal', apriModaleSpedizione);
                                if (pleaseWaitDiv.hasClass('in')) {
                                    pleaseWaitDiv.modal('hide');
                                } else {
                                    pleaseWaitDiv.one('shown.bs.modal', function () {
                                        pleaseWaitDiv.modal('hide');
                                    });
                                }
                            } else {
                                apriModaleSpedizione();
                            }
                        } else {
                            pleaseWaitDiv.modal('hide');
			                $('#myModalErrorContent').text(
			                    (data && data.messaggio) || "Errore nel recupero dei dati della spedizione."
			                );

			                $('#myModalError').removeClass();
			                $('#myModalError').addClass("modal modal-danger");
			                $('#report_button').hide();
			                $('#visualizza_report').hide();
			                $('#myModalError').modal('show');
			            }
			        },

			        error: function (jqXHR, textStatus, errorThrown) {
			            pleaseWaitDiv.modal('hide');

			            var data = jqXHR.responseJSON;

			            $('#myModalErrorContent').text(
			                (data && data.messaggio) || "Errore nel recupero dei dati della spedizione."
			            );

			            $('#myModalError').removeClass();
			            $('#myModalError').addClass("modal modal-danger");
			            $('#report_button').hide();
			            $('#visualizza_report').hide();
			            $('#myModalError').modal('show');
			        }
			    });
			}
		  
		  $(function(){
			  $('#formInvioSpedizione').on('submit', function(e){
			    e.preventDefault();
			    invioSpedizione();
			  });
			});
		  
		  
		  function invioSpedizione() {

			    var pleaseWaitDiv = $('#pleaseWaitDialog');
			    pleaseWaitDiv.modal();

			    var dataObj = $('#formInvioSpedizione').serializeArray();
			  

			    console.log("prima di ajax");
			    $.ajax({
			        type: "POST",
			        url: "gestioneSpedizione.do?action=invio_spedizione",
			        data: dataObj,
			        dataType: "json",

			        success: function (data, textStatus) {
			            pleaseWaitDiv.modal('hide');

			            if (data && data.success) {
			                $('#myModalInvioSpedizione')
			                    .one('hidden.bs.modal', function () {
			                        $('#report_button, #visualizza_report').hide();
			                        $('#myModalErrorContent').text(
			                            data.messaggio || "Spedizione inviata e salvata con successo."
			                        );

			                        $('#myModalError')
			                            .removeClass('modal-danger')
			                            .addClass('modal-success')
			                            .modal('show');
			                    })
			                    .modal('hide');
			            }  else {
			                $('#myModalErrorContent').text(
			                    (data && data.messaggio) || "Errore durante l'invio della spedizione."
			                );

			                $('#myModalError').removeClass();
			                $('#myModalError').addClass("modal modal-danger");
			            	$('#report_button').show();
			  				$('#visualizza_report').show();
			                $('#myModalError').modal('show');
			            }
			        },

			        error: function (jqXHR, textStatus, errorThrown) {
			            pleaseWaitDiv.modal('hide');

			            var data = jqXHR.responseJSON;

			            $('#myModalErrorContent').text(
			                (data && data.messaggio) || "Errore durante l'invio della spedizione."
			            );

			            $('#myModalError').removeClass();
			            $('#myModalError').addClass("modal modal-danger");
			        	$('#report_button').show();
		  				$('#visualizza_report').show();
			            $('#myModalError').modal('show');
			        }
			    });
			}
		  
		  
		  function modalModificaSpedizione() {
			    $('#formModificaSpedizione')[0].reset();
			    $('#myModalModificaSpedizione').modal('show');
			}

		  $(function () {
			    $('#formModificaSpedizione').on('submit', function (event) {
			        event.preventDefault();
			        salvaModificaSpedizione();
			    });
			});

		  function salvaModificaSpedizione() {
			    var pleaseWaitDiv = $('#pleaseWaitDialog');
			    var form = $('#formModificaSpedizione');
			    var btnSalva = $('#btnSalvaModificaSpedizione');

			    if (btnSalva.prop('disabled')) {
			        return;
			    }

			    var dataObj = form.serializeArray();
			    btnSalva.prop('disabled', true);
			    pleaseWaitDiv.modal('show');

			    function mostraErrore(data) {
			        $('#myModalErrorContent').text(
			            (data && data.messaggio) || "Errore durante la modifica della spedizione."
			        );

			        $('#report_button, #visualizza_report').show();
			        $('#myModalError')
			            .removeClass('modal-success')
			            .addClass('modal-danger')
			            .modal('show');
			    }

			    $.ajax({
			        type: "POST",
			        url: "gestioneSpedizione.do?action=salva_modifica",
			        data: dataObj,
			        dataType: "json",

			        success: function (data) {
			            pleaseWaitDiv.modal('hide');

			            if (data && data.success === true) {
			                // Alla prossima apertura, reset() riparte dai valori salvati.
			                $.each(dataObj, function (i, campo) {
			                    form[0].elements.namedItem(campo.name).defaultValue = campo.value;
			                });

			                $('#myModalModificaSpedizione')
			                    .one('hidden.bs.modal', function () {
			                        $('#report_button, #visualizza_report').hide();

			                        $('#myModalErrorContent').text(
			                            data.messaggio || "Spedizione modificata con successo."
			                        );

			                        $('#myModalError')
			                            .removeClass('modal-danger')
			                            .addClass('modal-success')
			                            .modal('show');
			                    })
			                    .modal('hide');
			            } else {
			                mostraErrore(data);
			            }
			        },

			        error: function (jqXHR) {
			            pleaseWaitDiv.modal('hide');
			            mostraErrore(jqXHR.responseJSON);
			        },

			        complete: function () {
			            btnSalva.prop('disabled', false);
			        }
			    });
			}
		  
		  
		  function aggiornaStatoSpedizione(id_spedizione){
			   var pleaseWaitDiv = $('#pleaseWaitDialog');
			    pleaseWaitDiv.modal();

			    var dataObj = {};
			    dataObj.id_spedizione = id_spedizione;
			    
			    $.ajax({
			        type: "POST",
			        url: "gestioneSpedizione.do?action=aggiorna_stato_spedizione",
			        data: dataObj,
			        dataType: "json",

			        success: function (data, textStatus) {
			            pleaseWaitDiv.modal('hide');

			            if (data && data.success) {
			            	  location.reload();
			            }  else {
			                $('#myModalErrorContent').text(
			                    (data && data.messaggio) || "Errore durante l'invio della spedizione."
			                );

			                $('#myModalError').removeClass();
			                $('#myModalError').addClass("modal modal-danger");
			            	$('#report_button').show();
			  				$('#visualizza_report').show();
			                $('#myModalError').modal('show');
			            }
			        },

			        error: function (jqXHR, textStatus, errorThrown) {
			            pleaseWaitDiv.modal('hide');

			            var data = jqXHR.responseJSON;

			            $('#myModalErrorContent').text(
			                (data && data.messaggio) || "Errore durante l'invio della spedizione."
			            );

			            $('#myModalError').removeClass();
			            $('#myModalError').addClass("modal modal-danger");
			        	$('#report_button').show();
		  				$('#visualizza_report').show();
			            $('#myModalError').modal('show');
			        }
			    });
		  }
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






