<html>
  <head>	
  <title>AccPoint</title> 
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link id="metalinkicon" rel="icon" type="image/x-icon" href="./images/favico.ico" sizes="48x48">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link href="css/style.css" rel="stylesheet" type="text/css">
  </head>
  <body>
   <%String[] buff=(String[])request.getAttribute("error"); %>
  <div id="dialog-error" title="Error" class="errorDialog">
 <p>
    <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
   <%=buff[0]%>
  </p>
    <% 
  for(int i=1;i<buff.length;i++)
  {
  %>
  <p><span style="padding-left: 25px;"><%=buff[i]%></span></p>
  <%
  }
  %>
  </div>


  <script>
   
  $(document).ready(function() {
	
	    $( "#dialog-error" ).dialog({
	        modal: true,
	        width: "800px",
	        buttons: {
	          "Home": function() {
	            $( this ).dialog( "close" );
	            document.location.href="/AccPoint/";
	          }
	        }
	      });
  });
  </script>
  </body>
  </html>