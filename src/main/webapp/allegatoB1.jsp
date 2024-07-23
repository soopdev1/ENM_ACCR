<%-- 
    Document   : bando_index2
    Created on : 28-lug-2017, 15.43.51
    Author     : rcosco
--%>

<%@page import="rc.soop.entity.Items"%>
<%@page import="rc.soop.entity.AllegatoB"%>
<%@page import="java.util.List"%>
<%@page import="rc.soop.entity.Docenti"%>
<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="rc.soop.entity.Docuserbandi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.action.Constant"%>
<%@page import="rc.soop.util.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>

<!DOCTYPE html>
<%
    String user = Utility.checkAttribute(session,"username");
    int x = Utility.parseIntR(request.getParameter("iddocente"));
    if (user == null) {
        Utility.redirect(request, response, "home.jsp");
    } else {
        if (request.getParameter("iddocente") == null) {
%>
<script>
    location.href = "bando_onlinecomp2.jsp?allegato_A_B=C";</script>
    <%
    } else if (ActionB.esisteAllegatoB1Field(user, x)) {
        try {
            List<AllegatoB> al = ActionB.getAllegatoB(user);
            if (x <= al.size()) {
                if (ActionB.esisteAllegatoB1Field(user, x)) {
    %>
<script>
    location.href = "bando_onlinecomp2.jsp?allegato_A_B=C";</script>
    <%
        }
    } else {
    %>
<script>
    location.href = "bando_onlinecomp2.jsp?allegato_A_B=C";</script>
    <%
        }
    } catch (Exception e) {
    %>
<script>
    location.href = "bando_onlinecomp2.jsp?allegato_A_B=C";</script>
    <%
        }
    } else {

        String username = Utility.checkAttribute(session,"username");
        String iddocente = request.getParameter("iddocente");

        AllegatoB docente = ActionB.getAllegatoB(username, iddocente);
        if (docente != null) {
    %>
<html>
    <head>
        <meta charset="utf-8" />
        <title><%=Constant.nomevisual%></title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="assets/soop/fontg/fontsgoogle1.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/clockface/css/clockface.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 
        <script type="text/javascript">
            function dismiss(name) {
                document.getElementById(name).className = "modal fade";
                document.getElementById(name).style.display = "none";
            }

            function submitfor() {
                document.forms["formregist"].submit();
            }

            function submitfor(nameform) {
                console.log(nameform);
                document.forms[nameform].submit();
            }

            function controllaReg1() {
                var output = "0";
                var msg = "";
                for (var indice = 1; indice < 6; indice++) {
                    var Tipologia = document.getElementById("elenco" + indice).value.trim();
                    var Committente = document.getElementById("sa" + indice).value.trim();
                    var DataDa = document.getElementById("periododa" + indice).value.trim();
                    var DataA = document.getElementById("periodoa" + indice).value.trim();
                    var Durata = document.getElementById("durata" + indice).value.trim();
                    var Unità = document.getElementById("ggmm" + indice).value.trim();
                    var Incarico = document.getElementById("tipo" + indice).value.trim();
                    var Fonte = document.getElementById("fonte" + indice).value.trim();
                    var Progressivo = document.getElementById("progr" + indice).value.trim();
                    if (indice === 1) {
                        if (Tipologia === "" || Committente === ""
                                || DataDa === ""
                                || DataA === ""
                                || Durata === ""
                                || Unità === "" || Incarico === ""
                                || Fonte === "" || Progressivo === "")
                        {
                            output = "1";
                            msg += "<span style='color:red;'>E' obbligatorio compilare TUTTI i campi della sezione <b>'Attivit&#224; " + indice + "'</b>.</span><br/>";
                        }
                    } else {

                        if (Tipologia !== "" || Committente !== ""
                                || DataDa !== ""
                                || DataA !== ""
                                || Incarico !== "" || Durata !== "" || Unità !== "" || Fonte !== "" || Progressivo !== "") {

                            if (Tipologia === "" || Committente === ""
                                    || DataDa === ""
                                    || DataA === "" || Durata === ""
                                    || Unità === "" || Incarico === ""
                                    || Fonte === "" || Progressivo === "") {
                                output = "1";
                                msg = "<span style='color:red;'> ' obbligatorio compilare TUTTI i campi della sezione <b>'Attivit&#224; " + indice + "'</b>, in quanto almeno uno di essi risulta compilato.</span><br/>";
                            }
                        }
                    }
                }

                if (output !== "0") {
                    document.getElementById("msgcompil").innerHTML = msg;
                    document.getElementById("confirm").className = document.getElementById("confirm").className + " in";
                    document.getElementById("confirm").style.display = "block";
                    return false;
                }
                document.getElementById("formModello").submit();
            }

        </script>
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-easypiechart/jquery.easypiechart.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="assets/global/scripts/app.min.js" type="text/javascript"></script>
        <link href="assets/global/plugins/select2/css/select2.min.css" rel="stylesheet"/>
        <script src="assets/global/plugins/select2/js/select2.min.js"></script>
        <script src="assets/global/plugins/select2/js/i18n/it.js"></script>
        <script src="assets/pages/scripts/dashboard.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/global/plugins/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>
        <script src="assets/pages/scripts/components-bootstrap-select.min.js" type="text/javascript"></script>
        <script src="assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
        <script src="assets/soop/js/form-input-mask.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
        <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/soop/js/moment-with-locales.min.js"></script>
        <script type="text/javascript" src="assets/soop/js/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="assets/soop/css/daterangepicker.css" />

        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <script src="assets/soop/js/jscontrolli.js"></script>
    </head>

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-closed">
        <%@ include file="menu/header.jsp"%>
        <%@ include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>
        <nav class="navbar navbar-expand-lg has-megamenu" aria-label="Menu principale">
            <button type="button" aria-label="Mostra o nascondi il menu" class="custom-navbar-toggler" aria-controls="menu" aria-expanded="false" data-bs-toggle="navbarcollapsible" data-bs-target="#navbar-E">
                <span>
                    <svg role="img" class="icon"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-burger"></use></svg>
                </span>
            </button>
            <div class="navbar-collapsable" id="navbar-E">
                <div class="overlay fade"></div>
                <div class="close-div">
                    <button type="button" aria-label="Chiudi il menu" class="btn close-menu">
                        <span><svg role="img" class="icon"><use href="../../Bootstrap2024/assets/svg/sprites.svg#it-close-big"></use></svg></span>
                    </button>
                </div>
                <div class="menu-wrapper justify-content-lg-between">
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link active " href="bando_index.jsp"><span>HOME</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link  " href="faq.jsp"><span>FAQ</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- BEGIN HEADER -->
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN MENU -->
            <!-- END MENU -->

            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">

                    <div id="confirm" class="modal fade" tabindex="-1" data-backdrop="confirm" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Verifica Compilazione</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="primariga">
                                        Verificare che tutti i campi siano compilati correttamente.
                                    </p>
                                    <p id="msgcompil">

                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirm');">CHIUDI</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="confirm2" class="modal fade" tabindex="-1" data-backdrop="confirm2" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Verifica Compilazione</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler procedere nella compilazione della domanda?
                                    </p>
                                    <p id="msgcompil2">

                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" onclick="return submitfor();">SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirm2');">NO</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <!--    VUOTO RAF  -->
                    <!-- END THEME PANEL -->
                    <!-- BEGIN PAGE BAR -->
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <div class="row">
                        <div class="col-md-9">
                            <h3 class="page-title">Homepage</h3>
                        </div>
                        <div class="col-md-3" style="text-align: right;">
                            <img src="assets/soop/img/logo_blue_1.png" alt="logo" height="70px"/>
                        </div>
                    </div>
                    <%
                        String es = request.getParameter("esito");
                        String msg = "";
                        String inte = "";
                        if (es != null) {
                            if (es.equals("ok")) {
                                inte = "<i class='fa fa-exclamation-triangle font-green'></i> Operazione Completata";
                                msg = "Documenti docente caricati con successo.";
                            } else if (es.equals("ok1")) {
                                inte = "<i class='fa fa-exclamation-triangle font-green'></i> Operazione Completata";
                                msg = "Documenti docente eliminato con successo.";
                            } else if (es.equals("ko")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Errore inserimento";
                                msg = "Impossibile salvare i file, riprovare.";
                            } else if (es.equals("ko1")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Errore durante la fase di eliminazione";
                                msg = "Impossibile eliminare il fascicolo del docente, riprovare.";
                            }
                    %>
                    <br>
                    <div class="modal fade" role="dialog" >
                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" id="myModal4but" data-target="#myModal4"></button>
                        <script>
                            $(document).ready(function () {
                                $('#myModal4but').click();
                            });
                        </script>
                    </div>
                    <div id="myModal4" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-lg">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">durata
                                    <h4 class="modal-title"><%=inte%></h4>
                                </div>
                                <div class="modal-body">
                                    <%=msg%>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" data-dismiss="modal" class="btn blue" onclick="return dismiss('myModal4');">OK</button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <%}
                        ArrayList<Items> attivita = ActionB.query_attivita_docenti_rc();
                        ArrayList<Items> inquadr = ActionB.query_inquadramento_rc();
                        ArrayList<Items> fonti = ActionB.query_fontifin_rc();
                    %>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert alert-info uppercase text-justify">
                                Controlla con attenzione i dati inseriti in questa sezione prima di salvare, completata la procedura non sar&#224; possibile modificare i dati ma solo eliminare l'intera sezione e compilare nuovamente la sezione.
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="portlet-body">
                                <blockquote class="blockquote col-md-12">
                                    <div class="row">
                                        <p class="mb-0 col-md-6 uppercase"><u><b>Docente:</b> <%=StringEscapeUtils.escapeHtml4(docente.getNome())%>&nbsp;<%=StringEscapeUtils.escapeHtml4(docente.getCognome())%></u></p>
                                        <p class="mb-0 col-md-6"><b>CF:</b> <%=StringEscapeUtils.escapeHtml4(docente.getCF())%></p>
                                    </div>
                                    <div class="row">
                                        <hr>
                                    </div>
                                    <form name="formModello" role="form" action="Operazioni?action=modb1" method="post"  class="form-horizontal" id="formModello">
                                        <input type="hidden" name="username" value="<%=username%>"/>
                                        <input type="hidden" name="iddocente" value="<%=StringEscapeUtils.escapeHtml4(iddocente)%>"/>
                                        <table style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">
                                                        <label class="control-label"><i class="fa fa-edit"></i>
                                                            TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE</label>
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                        <hr>
                                        <table style="width: 100%;">
                                            <%for (int s = 1; s < 6; s++) {%>
                                            <tr style="border-bottom: 3px;">
                                                <th colspan="4" style="text-align: center;">
                                                    <span class="help-block bordered">
                                                        ATTIVIT&#192; <%=s%>
                                                    </span>
                                                    <hr>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Tipologia di attivit&#224;<span class="font-red popovers" data-trigger="hover" 
                                                                                                            data-container="body" data-placement="bottom"
                                                                                                            data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="elenco<%=s%>" name="elenco<%=s%>" class="form-control select2" data-placeholder="...">
                                                                            <option value="">...</option>
                                                                            <%for (int p = 0; p < attivita.size(); p++) {%>
                                                                            <option value="<%=attivita.get(p).getCodice()%>"><%=attivita.get(p).getDescrizione()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#elenco' + '<%=s%>').select2({
                                                                                allowClear: true,
                                                                                theme: "classic",
                                                                                language: 'it'
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Committente<span class="font-red popovers" data-trigger="hover" 
                                                                                             data-container="body" data-placement="bottom"
                                                                                             data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase" name="sa<%=s%>" placeholder="..." id="sa<%=s%>" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Data inizio periodo di riferimento<span class="font-red popovers" data-trigger="hover" 
                                                                                                                    data-container="body" data-placement="bottom"
                                                                                                                    data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input class="form-control form-control-inline date-picker_r"
                                                                               onchange="return setperiodo(this.id);"
                                                                               size="16" type="text" 
                                                                               id="periododa<%=s%>" name="datada<%=s%>" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Data fine periodo di riferimento<span class="font-red popovers" data-trigger="hover" 
                                                                                                                  data-container="body" data-placement="bottom"
                                                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input class="form-control form-control-inline" size="16" type="text" 
                                                                               id="periodoa<%=s%>" name="dataa<%=s%>"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Durata<span class="font-red popovers" data-trigger="hover" 
                                                                                        data-container="body" data-placement="bottom"
                                                                                        data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input class="form-control" id="durata<%=s%>" name="durata<%=s%>"
                                                                               placeholder="...." type="text"  
                                                                               onchange="return changedurata(this.id);"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Unit&#224; di misura<span class="font-red popovers" data-trigger="hover" 
                                                                                                      data-container="body" data-placement="bottom"
                                                                                                      data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="ggmm<%=s%>" name="ggmm<%=s%>" class="form-control select2" data-placeholder="...">
                                                                            <option value="">...</option>
                                                                            <option value="gg">GIORNI</option>
                                                                            <option value="mm">MESI</option>
                                                                            <option value="aa">ANNI</option>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#ggmm' + '<%=s%>').select2({
                                                                                allowClear: true,
                                                                                theme: "classic",
                                                                                language: 'it'
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Tipologia di incarico<span class="font-red popovers" data-trigger="hover" 
                                                                                                       data-container="body" data-placement="bottom"
                                                                                                       data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="tipo<%=s%>" name="tipo<%=s%>" class="form-control select2" data-placeholder="..." >
                                                                            <option value="">...</option>
                                                                            <%for (int p = 0; p < inquadr.size(); p++) {%>
                                                                            <option value="<%=inquadr.get(p).getCodice()%>"><%=inquadr.get(p).getDescrizione()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#tipo' + '<%=s%>').select2({
                                                                                allowClear: true,
                                                                                theme: "classic",
                                                                                language: 'it'
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Fonte di finanziamento<span class="font-red popovers" data-trigger="hover" 
                                                                                                        data-container="body" data-placement="bottom"
                                                                                                        data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="fonte<%=s%>" name="fonte<%=s%>" class="form-control select2" data-placeholder="..." style="width: 100%" >
                                                                            <option value="">...</option>
                                                                            <%for (int p = 0; p < fonti.size(); p++) {%>
                                                                            <option value="<%=fonti.get(p).getCodice()%>"><%=fonti.get(p).getDescrizione()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#fonte' + '<%=s%>').select2({
                                                                                allowClear: true,
                                                                                theme: "classic",
                                                                                language: 'it'
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            N. progressivo di rif.
                                                                            <span class="font-red popovers" data-trigger="hover" 
                                                                                  data-container="body" data-placement="bottom"
                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;
                                                                            </span>
                                                                            <i class="fa fa-info-circle popovers" 
                                                                               data-trigger="hover" 
                                                                               data-container="body" 
                                                                               data-placement="bottom"
                                                                               data-content="Nel caso in cui le esperienze per il docente siano contenute in sezioni separate del cv, raggruppare le attivit&#224; per tipologia e attribuire un numero progressivo da 1 a 5." 
                                                                               data-original-title="NUMERO PROGRESSIVO DI RIFERIMENTO CV"></i>
                                                                        </span>
                                                                        <input type="text" class="form-control" name="progr<%=s%>" placeholder="..." 
                                                                               id="progr<%=s%>" onchange="return fieldOnlyNumber(this.id);" maxlength="3" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr style="border-bottom: 3px;">
                                                <th colspan="4" style="text-align: center;">
                                                    <hr>
                                                </th>
                                            </tr>
                                            <%}%>
                                        </table>
                                    </form>
                                    <script type="text/javascript">
                                        function changedurata(idfield) {
                                            fieldOnlyNumber(idfield);
                                        }
                                    </script>
                                </blockquote>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <a class="btn btn btn-lg btn-block red" href="bando_onlinecomp2.jsp?allegato_A_B=C"><i class="fa fa-arrow-left"></i> Indietro</a>
                                </div>
                                <div class="col-md-10">
                                    <button type="button" class="btn btn-lg green-jungle btn-block"   onclick="return controllaReg1();"><i class="fa fa-save"  ></i> Salva dati</button>
                                </div>                            
                            </div>
                        </div>  
                    </div>
                </div>
                <!-- END CONTENT -->
                <!-- BEGIN QUICK SIDEBAR -->
                <!-- END QUICK SIDEBAR -->
                <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
            </div>
            <!-- END CONTAINER -->
            <!-- BEGIN FOOTER -->
            
            <script type="text/javascript">
                $(".date-picker").change(function () {
                    var varDate = $("#" + this.id).datepicker('getDate');
                    if (varDate !== null) {
                        var today = new Date();
                        today.setHours(0, 0, 0, 0);
                        if (varDate > today) {
                            document.getElementById("msgcompil").innerHTML = "La Data deve essere minore della data odierna!";
                            document.getElementById("confirm").className = document.getElementById("confirm").className + " in";
                            document.getElementById("confirm").style.display = "block";
                            $("#" + this.id).datepicker('setDate', null);
                            return false;
                        }
                    }
                });

            </script>
    </body>
</html>
<%}
        }
    }%>