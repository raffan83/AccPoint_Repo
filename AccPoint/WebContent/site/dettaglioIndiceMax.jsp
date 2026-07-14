<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:forEach items="${sessionScope.arrayPunti}" var="gruppo" varStatus="loopGruppo">
  <div class="box box-danger box-solid" style="margin-bottom:15px;">
    <div class="box-header with-border">
<c:if test="${fn:startsWith(gruppo[0].tipoProva, 'L')}">
    <h4 class="box-title">Tipo di prova: linearit&agrave;</h4>
</c:if>

<c:if test="${fn:startsWith(gruppo[0].tipoProva, 'R')}">
    <h4 class="box-title">Tipo di prova: ripetibilit&agrave;</h4>
</c:if>
    </div>
    <div class="box-body">
      <table class="table table-bordered table-striped table-condensed" data-gruppo="${loopGruppo.index}">
        <thead>
          <tr>
            <th>Tipo verifica</th>
            <th>Indice di prestazione</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${gruppo}" var="punto" varStatus="loopPunto">
            <tr>
              <td>${punto.tipoVerifica}</td>
              <td class="cella-indice" data-gruppo="${loopGruppo.index}" 
                  data-valore="${punto.incertezza / punto.accettabilita}">
                <fmt:formatNumber value="${punto.incertezza / punto.accettabilita}" 
                                  maxFractionDigits="3" minFractionDigits="3"/>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</c:forEach>

<script type="text/javascript">
 
 function evidenziaMax() {
  var max = -Infinity;

  // prima passata: trova il massimo globale
  $('.cella-indice').each(function() {
    var v = parseFloat($(this).data('valore'));
    if (v > max) max = v;
  });

  // seconda passata: colora solo le celle con quel valore
  $('.cella-indice').each(function() {
    var v = parseFloat($(this).data('valore'));
    if (v === max) {
    	  if (v <= 0.25) {
    		  $(this).css({ 'background-color': '	#228B22', 'color': '', 'font-weight': 'bold' })
  		  } else if (v <= 0.75) {
  			  $(this).css({ 'background-color': '#FFFF8F', 'color': '', 'font-weight': 'bold' })
  		  } else {
  			  $(this).css({ 'background-color': 'orange', 'color': '', 'font-weight': 'bold' })
  		  }
    } else {
      $(this).css({ 'background-color': '', 'color': '', 'font-weight': '' });
    }
  });
}

evidenziaMax();
</script>