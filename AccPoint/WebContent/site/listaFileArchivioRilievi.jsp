<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<div class="row">
<div class="col-sm-12">
<c:choose>
<c:when test="${lista_allegati.size()>0 }">
<ul class="list-group list-group-bordered">
<c:forEach items="${lista_allegati }" var="allegato">
                <li class="list-group-item">
                <div class="row">
	                <div class="col-xs-10">
	                  <b>${allegato.nome_file }</b>
	                  </div>
	                  <div class="col-xs-2"> 	                  
	                  <a target = "_blank" class="btn btn-danger btn-xs " href="gestioneRilievi.do?action=download_allegato&id_rilievo=${utl:encryptData(id_rilievo)}&isArchivio=true&filename=${utl:encryptData(allegato.nome_file) }"><i class="fa fa-arrow-down small"></i></a>
	                  <a class="btn btn-danger btn-xs"><i class="fa fa-trash" onClick="eliminaAllegatoArchivio('${allegato.id}')"></i></a>
	                  </div>
                  </div>
                </li>
                </c:forEach>
                </ul>
</c:when>
<c:otherwise>

 <li class="list-group-item">
Nessun file nell'archivio del rilievo!
</li>
</c:otherwise>
</c:choose>

 </div>
 </div>
 
 <script type="text/javascript">

console.log("test");



 </script>
 
 
 