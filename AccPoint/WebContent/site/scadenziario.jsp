<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AccPoint</title>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.6.0/fullcalendar.css' />
  <link href="css/style.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="css/style_css.css">
  <link rel="stylesheet" href="css/prism.css">
  <link rel="stylesheet" href="css/chosen.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/dataTables.jqueryui.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <link href="css/dark_matter.css" rel="stylesheet" type="text/css">
  
 <script type="text/javascript" src="js/scripts.js"></script>
 <script src="//code.jquery.com/jquery-1.12.4.js"></script> 
 <script src="js/chosen.jquery.js" type="text/javascript"></script>
 <script src="js/prism.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/dataTables.jqueryui.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/fixedcolumns/3.2.2/js/dataTables.fixedColumns.min.js"  type="text/javascript" charset="utf-8"></script>
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src='http://code.jquery.com/jquery-1.11.3.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.6.0/fullcalendar.min.js'></script>


</head>
<body>
  <form name="frm" method="post" id="fr" action="#">
    <div style="width: 100%;padding:10px;height: 30px;text-align:center" class="testo14">Scadenziario</Div>
 
  <div style="width: 100%;padding:10px;height: 80px" >

  <table  cellspacing="5px"  cellpadding="0" width="100%">
 <tr>
 <td width="30%">
 <span  class="button_" style="margin-left:20px;width:60px;" id="btn">+</span>
 <span  class="button_" >-</span>
  </td>
  </tr>
  </table>
  </div>
 <div id='calendar' style="padding:10px;">
<input type="text" name="date" id="date" style="dispaly:none;" >
</div>

</form>
<script type="text/javascript">

$('#btn').click(function(){
	
//	var myCalendar = $('#calendar'); 
//	myCalendar.fullCalendar();
	
	
	
});
$(document).ready(function() {
	
	  $.ajax({
          type: "POST",
          url: "Scadenziario_create.do",
          data: "",
          dataType: "json",
          
          //if received a response from the server
          success: function( data, textStatus) {
          	
             	if(data.success)
              	{
             		 jsonObj = [];
             		for(var i=0 ; i<data.dataInfo.length;i++)
                    {
             			var str =data.dataInfo[i].split(";");
             			item = {};
             	        item ["title"] = str[1];
             	        item ["start"] = str[0];
             	        item ["allDay"] = true;

             	        jsonObj.push(item);
              		}
             		
              		$('#calendar').fullCalendar({
              			 eventRender: function(event, element, view) {
          		             return $('<div class=\"cerchio\" style=\"align:center\"><br><span class=\"panelTitleTxt\"">' 
          		             + event.title + 
          		             '</span></div>');
          		         },	
              		  events:jsonObj,
              		           eventClick: function(calEvent, jsEvent, view) {

              		        	   callListaCampioni(moment(calEvent.start).format());
              		              // alert('Event: ' + moment(calEvent.start).format());              		
              		             
              		               $(this).css('border-color', 'red');

              		           }
              	  }); 
                }
          	
          }
         });
	
	});
	
	function callListaCampioni(moment)
	{
		$('#date').val(moment);
		callAction('listaCampioni.do');
	}
</script>
</body>

</html>