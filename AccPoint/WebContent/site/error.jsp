<html>
  <head>	<title>AccPoint</title> 

  </head>
  <body>
  <table>
  <%String[] buff=(String[])request.getAttribute("error"); %>
  <tr><td>Errore: </td><td><font color="red"><%=buff[0]%></font></td></tr>
  <tr><td><br></td><td></td></tr>
  <% 
  for(int i=1;i<buff.length;i++)
  {
  %>
  <tr><td></td><td><%=buff[i]%></td></tr>
  <%
  }
  %></table>
  </body>
  </html>