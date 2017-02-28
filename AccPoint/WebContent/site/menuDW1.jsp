<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/scripts.js"></script>

<title>AccPoint</title>
</head>
<body >
<div style="overflow-x:auto;overflow-y:auto " >

<form name="frmLogin" method="post" >

<table border="0"  cellspacing="0" cellpadding="0" width="100%" style="height:150px" border="2">
	<tr>

	<td colspan="2" align="center"><img src="../images/logo_Acc_cut.jpg" height="20%"></img></td>
	</tr>
	<tr height="20%" >
	<td class="testo1" bgcolor="#EE1C25"  width="30%">Utente<img src="../images/avanti.gif"><%=(String)request.getSession().getAttribute("nomeUtente") %> </td>
	<td width="70%" bgcolor="#EE1C25"></td>
	
	</tr>
</table>
</form>
</div>
</body> 
</html>
