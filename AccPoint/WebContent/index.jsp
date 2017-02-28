<html>
 <head>	
 <title>AccPoint</title> 
 <link id="metalinkicon" rel="icon" type="image/x-icon" href="images/favico.ico" >
<script language="JavaScript" src="js/scripts.js"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script> 
<link href="css/style.css" rel="stylesheet" type="text/css">
  </head>
  <body  class="bg">
 
  <form name="frmLogin" method="post" action="">

    <div class="login">
		<div class="login-screen">
			<div class="app-title">
				<!--  <h1>AccPoint</h1>-->
				<img src="./images/logo_acc.jpg" style="width:50%">
			</div>

			<div class="login-form">
				<div class="control-group">
				<input name="uid" type="text" class="login-field" value="" placeholder="username" id="user">
				<label class="login-field-icon fui-user" for="login-name"></label>
				</div>

				<div class="control-group">
				<input name="pwd" type="password" class="login-field" value="" placeholder="password" id="pass">
				<label class="login-field-icon fui-lock" for="login-pass"></label>
				</div>

				<button class="btn btn-primary btn-large btn-block" onclick=Controllo() >Login</button>
				<a class="login-link" href="#">Password dimenticata?</a>

			</div>
		</div>
	</div>
    
    
    
     </form>
     
     <script type="text/javascript">
     
     $('#Mybtn').click( function(){
    	 
         alert($(window).height());
         alert($(window).width());
 });
 </script>
 </body></html>