<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<div class="row">
<div class="col-sm-12">
<ul class="list-group list-group-bordered">
<c:forEach items="${lista_allegati }" var="allegato">
                <li class="list-group-item">
                  <b>${allegato.nome_file }</b> <a target = "_blank" class="btn btn-danger btn-xs pull-right" href="gestioneRilievi.do?action=download_allegato&id_rilievo=${utl:encryptData(id_rilievo)}&isArchivio=true&filename=${utl:encryptData(allegato.nome_file) }"><i class="fa fa-arrow-down small"></i></a>
                </li>
                </c:forEach>
                </ul>
 </div>
 </div>
 
 <script>
 
console.log("test");
 </script>