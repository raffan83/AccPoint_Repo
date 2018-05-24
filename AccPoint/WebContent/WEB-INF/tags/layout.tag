<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
 
<%@attribute name="title"%>
<%@attribute name="bodyClass"%>
<%@attribute name="extra_css" fragment="true" %>
<%@attribute name="extra_js_header" fragment="true" %>
<%@attribute name="extra_js_footer" fragment="true" %>
<%@attribute name="body_area" fragment="true" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
 <head>

 <title>${title}</title>
	 <t:header />
     <jsp:invoke fragment="extra_css"/>
     <jsp:invoke fragment="extra_js_header"/>
     
 </head>

 <body class="${bodyClass}">
 	 <form id="callActionForm" method="post"></form>
 
     <jsp:invoke fragment="body_area"/>
     
       <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabelHeader">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
 
        <button  type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
           <c:if test="${usrObj.checkPermesso('VISUALIZZA_BUG_REPORT') }"> 
          <%-- <c:if test="${userObj.checkRuolo('OP') }"> --%>  
        
        <button style="display:none"  type="button" class="btn btn-outline" id="visualizza_report" data-dismiss="modal">Visualizza Report</button>        
        </c:if>
        
        <button style="display:none" type="button" class="btn btn-outline" id="report_button" data-dismiss="modal" onClick="sendReport($(this).parents('.modal'))">Invia Report</button>
      </div>
    </div>
  </div>
</div>
     
     <t:footer />
     <jsp:invoke fragment="extra_js_footer"/>

 </body>
</html>