
   <section class="content-header">
      <h1>
      Ops!! Errore 500
        <small>Contattare l'assistenza</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">
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
</section>
