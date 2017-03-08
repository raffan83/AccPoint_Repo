<%@ tag language="java" pageEncoding="ISO-8859-1"%>
 <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header">Menu</li>
        <!-- Optionally, you can add icons to the links -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Anagrafica</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="#" onclick="explore('gestioneCommessa.do');">Gestione Anagrafica</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Commesse</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="#" onclick="explore('gestioneCommessa.do');">Gestione Commessa</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Strumenti</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
                <li><a href="#" onclick="explore('listaStrumenti.do');">Gestione Strumenti</a></li>
    			<li><a href="#" onclick="explore('listaStrumentiNew.do');">Gestione Strumenti [NEW]</a></li>
    			<li><a href="#" onclick="explore('abbinaSchede.do');">Abbina Schede</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Campioni</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="#" onclick="explore('listaCampioni.do');"><i class="fa fa-link"></i>Lista Campioni</a></li>
			<li><a href="#" onclick="explore('scadenziario.do');"><i class="fa fa-link"></i>Scadenziario</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Prenotazione Campioni</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="#" onclick="explore('listaPrenotazioni.do');"><i class="fa fa-link"></i>Prenotazioni</a></li>
			<li><a href="#" onclick="explore('scadenziario.do');"><i class="fa fa-link"></i>Richieste</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Old Dash</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="#" onclick="explore('areaUtente.do');"><i class="fa fa-link"></i>Dash</a></li>
          </ul>
        </li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>