
  <form name="frm" method="post" id="fr" action="#">
<div id="dialog-message" title="Errore">
  <p>
    <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
    Sessione Scaduta !!
  </p>
</div>
</form>

  <script>
  $( function() {
    $( "#dialog-message" ).dialog({
      modal: true,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
          window.top.location.href = "http://localhost:8080/AccPoint/";
        }
      }
    });
  } );
  </script>