<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="referrer" content="no-referrer">
  <title>Reindirizzamento...</title>
</head>
<body onload="document.getElementById('f').submit();">
  <form id="f" method="post" action="<c:out value='${targetUrl}'/>">
    <input type="hidden" name="uid" value="<c:out value='${uid}'/>">
    <input type="hidden" name="pwd" value="<c:out value='${pwd}'/>">
    <noscript><button type="submit">Continua</button></noscript>
  </form>
  <p>Reindirizzamento al documentale...</p>
</body>
</html>