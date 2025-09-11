<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%
    // Recupero attributi da session (messi dalla servlet prima di forward)
    it.portaleSTI.DTO.StrumentoDTO strumento = (it.portaleSTI.DTO.StrumentoDTO) session.getAttribute("strumento");
    String idSede = (String) session.getAttribute("id_Sede");
    String idCliente = (String) session.getAttribute("id_Cliente");
    it.portaleSTI.DTO.UtenteDTO user = (it.portaleSTI.DTO.UtenteDTO) session.getAttribute("userObj");
%>

<c:set var="strumento" value="<%= strumento %>" scope="request"/>
<c:set var="idSede" value="<%= idSede %>" scope="request"/>
<c:set var="idCliente" value="<%= idCliente %>" scope="request"/>
<c:set var="user" value="<%= user %>" scope="request"/>

<form class="form-horizontal" id="formModificaStrumento">

  <!-- Denominazione -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Denominazione:</label>
    <div class="col-sm-10">
      <input class="form-control" id="denominazione_mod" type="text" name="denominazione_mod"
             required value="<c:out value='${strumento.denominazione}'/>"/>
    </div>
  </div>

  <!-- Codice Interno -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Codice Interno:</label>
    <div class="col-sm-10">
      <input class="form-control" id="codice_interno_mod" type="text" name="codice_interno_mod"
             maxlength="22" required value="<c:out value='${strumento.codice_interno}'/>"/>
    </div>
  </div>

  <!-- Costruttore -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Costruttore:</label>
    <div class="col-sm-10">
      <input class="form-control" id="costruttore_mod" type="text" name="costruttore_mod"
             required value="<c:out value='${strumento.costruttore}'/>"/>
    </div>
  </div>

  <!-- Modello -->

  <div class="form-group">
    <label class="col-sm-2 control-label">Modello:</label>
    <div class="col-sm-10">
      <input class="form-control" id="modello_mod" type="text" name="modello_mod"
             required value="<c:out value='${strumento.modello}'/>"/>
    </div>
  </div>

  <!-- Matricola -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Matricola:</label>
    <div class="col-sm-10">
      <input class="form-control" id="matricola_mod" type="text" name="matricola_mod"
             maxlength="22" required value="<c:out value='${strumento.matricola}'/>"/>
    </div>
  </div>

  <!-- Divisione -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Divisione:</label>
    <div class="col-sm-10">
      <input class="form-control" id="risoluzione_mod" type="text" name="risoluzione_mod"
             required value="<c:out value='${strumento.risoluzione}'/>"/>
    </div>
  </div>

  <!-- Altre matricole -->
    <div class="form-group">
    <label class="col-sm-2 control-label">Altre matricole:</label>
    <div class="col-sm-10">
      <input class="form-control" id="altre_matricole_mod" type="text" name="altre_matricole_mod"
             value="<c:out value='${strumento.altre_matricole}'/>"/>
    </div>
  </div>

  <!-- Campo Misura -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Campo Misura:</label>
    <div class="col-sm-10">
      <input class="form-control" id="campo_misura_mod" type="text" name="campo_misura_mod"
             required value="<c:out value='${strumento.campo_misura}'/>"/>
    </div>
  </div>

  <!-- Tipo Strumento -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Tipo Strumento:</label>
    <div class="col-sm-10">
      <select class="form-control" id="ref_tipo_strumento_mod" name="ref_tipo_strumento_mod" required>
        <option></option>
        <c:forEach var="str" items="${sessionScope.listaTipoStrumento}">
          <option value="${str.id}" <c:if test="${strumento.tipo_strumento != null and strumento.tipo_strumento.id == str.id}">selected</c:if>>
            <c:out value="${str.nome}"/>
          </option>
        </c:forEach>
      </select>
    </div>
  </div>

  <!-- Reparto -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Reparto:</label>
    <div class="col-sm-10">
      <input class="form-control" id="reparto_mod" type="text" name="reparto_mod"
             value="<c:out value='${strumento.reparto}'/>"/>
    </div>
  </div>

  <!-- Utilizzatore -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Utilizzatore:</label>
    <div class="col-sm-10">
      <input class="form-control" id="utilizzatore_mod" type="text" name="utilizzatore_mod"
             value="<c:out value='${strumento.utilizzatore}'/>"/>
    </div>
  </div>

  <!-- Procedura -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Procedura:</label>
    <div class="col-sm-10">
      <input class="form-control" id="procedura_mod" type="text" name="procedura_mod"
             value="<c:out value='${strumento.procedura}' default=''/>"/>
    </div>
  </div>

  <!-- Note -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Note:</label>
    <div class="col-sm-10">
      <textarea class="form-control" id="note_mod" name="note_mod"><c:out value='${strumento.note}'/></textarea>
    </div>
  </div>

  <!-- Luogo Verifica -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Luogo Verifica:</label>
    <div class="col-sm-10">
      <select class="form-control" id="luogo_verifica_mod" name="luogo_verifica_mod" required>
        <option></option>
        <c:forEach var="luogo" items="${sessionScope.listaLuogoVerifica}">
          <option value="${luogo.id}" <c:if test="${strumento.luogo != null and strumento.luogo.id == luogo.id}">selected</c:if>>
            <c:out value="${luogo.descrizione}"/>
          </option>
        </c:forEach>
      </select>
    </div>
  </div>

  <!-- Classificazione -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Classificazione:</label>
    <div class="col-sm-10">
      <select class="form-control" id="classificazione_mod" name="classificazione_mod" required>
        <option></option>
        <c:forEach var="clas" items="${sessionScope.listaClassificazione}">
          <option value="${clas.id}" <c:if test="${strumento.classificazione != null and strumento.classificazione.id == clas.id}">selected</c:if>>
            <c:out value="${clas.descrizione}"/>
          </option>
        </c:forEach>
      </select>
    </div>
  </div>

  <!-- Note tecniche -->
  <div class="form-group">
    <label class="col-sm-2 control-label">Note tecniche:</label>
    <div class="col-sm-10">
      <textarea class="form-control" id="note_tecniche_mod" name="note_tecniche_mod"><c:out value='${strumento.note_tecniche}'/></textarea>
    </div>
  </div>

  <!-- Switch Presenza IC -->
  <c:if test="${user.checkRuolo('AM') or user.checkRuolo('OP') or user.checkRuolo('CI')}">
    <div class="form-group">
      <label class="col-sm-2 control-label">Presenza Ic:</label>
      <div class="col-sm-10">
        <label class="switch">
          <input type="checkbox" id="switchAttivo"
                 <c:if test="${strumento.ip == 1}">checked</c:if>
                 onClick="cambiaStatoIp('${strumento.__id}')">
          <span class="slider round"></span>
        </label>
      </div>
    </div>
  </c:if>

  <!-- Bottone Salva -->
  <button type="submit" class="btn btn-primary">Salva</button>

</form>

<script>
$(function(){
  $('#formModificaStrumento').on('submit', function(e){
    e.preventDefault();
    console.log("modificaStr")
    modificaStrumento('${idSede}', '${idCliente}', '${strumento.__id}');
  });
});

function cambiaStatoIp(idStrumento){
  const stato = document.getElementById("switchAttivo").checked ? "1" : "0";
  pleaseWaitDiv = $('#pleaseWaitDialog');
  pleaseWaitDiv.modal();
  $.ajax({
    type: "POST",
    url: "listaStrumentiSedeNew.do?action=cambiaStatoIp&idStrumento="+idStrumento+"&stato="+stato,
    dataType: "json",
    success: function(data, textStatus) {
      if(data.success){
        pleaseWaitDiv.modal('hide');
        $('#report_button').hide();
        $('#visualizza_report').hide();
        $("#myModalErrorContent").html("Indice prestazione modificato con successo");
        $("#myModalError").addClass("modal modal-success");
        $("#myModalError").modal();

        $('#myModalError').on('hidden.bs.modal', function (e) {
          var sede = $("#select2").val();
          var cliente = $("#select1").val();
          var dataString ="idSede="+ sede+"&idCliente="+cliente;
          exploreModal("listaStrumentiSedeNew.do",dataString,"#posTab",function(datab,textStatusb){
            $('#myModal').modal('hide');
            $('.modal-backdrop').hide();
          });
        });
      }else{
        pleaseWaitDiv.modal('hide');
        $('#report_button').show();
        $('#visualizza_report').show();
        $("#myModalErrorContent").html("Errore modifica cambio stato Indice prestazione");
        $("#myModalError").modal();
      }
    },
    error: function(jqXHR, textStatus, errorThrown){
      $("#myModalErrorContent").html(textStatus);
      $('#report_button').show();
      $('#visualizza_report').show();
      $('#myModalError').modal('show');
    }
  });
}
</script>
 
