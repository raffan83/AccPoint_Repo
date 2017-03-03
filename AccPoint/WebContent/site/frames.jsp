<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en"> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL="SHORTCUT ICON" HREF= "../site/favicon.ico">
<TITLE>AccPoint </TITLE>
 <link id="metalinkicon" rel="icon" type="image/x-icon" href="./images/favico.ico" sizes="48x48">
</head>

  <FRAMESET  rows="50,150,*,23"   framespacing="0" border="0" frameborder="NO"> 
  <FRAME name="areaUtente"   frameborder="0" src="site/areaUtente.jsp"  scrolling="no"  marginwidth="0" marginheight="0"></FRAME>
  <FRAME name="menuframe"   frameborder="0" src="site/menuDW1.jsp"  scrolling="no"  marginwidth="0" marginheight="0"></FRAME>
  <frameset cols="200,*"   framespacing="0" border="0" frameborder="NO">
  <FRAME name="corpoframe" id="sidebar" frameborder="0" src="site/sidebar.jsp"  scrolling="auto"  marginwidth="0" marginheight="0" >
  <FRAME name="corpoframe" id="corpoFrame" frameborder="0" src=<%=(String)request.getAttribute("forward") %>  scrolling="auto" noresize="noresize" marginwidth="0"  marginheight="10" >
  </frameset>
 
  <FRAME name="footerframe" frameborder="0" src="site/righe.jsp" scrolling="no"   marginwidth="0" marginheight="0"></FRAME>
</FRAMESET>
</html>