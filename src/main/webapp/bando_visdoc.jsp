<%-- 
    Document   : bando_index2
    Created on : 28-lug-2017, 15.43.51
    Author     : rcosco
--%>

<%@page import="rc.soop.entity.Items"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="rc.soop.entity.Reportistica"%>
<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="rc.soop.entity.Docuserbandi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.soop.action.Liste"%>
<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.util.Utility"%>
<%@page import="rc.soop.action.Constant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>

<!DOCTYPE html>
<%
    if (session.getAttribute("username") == null) {
        Utility.redirect(request, response, "home.jsp");
    } else {
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
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <link href="Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css" />
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

        <!-- FANCYBOX -->
        <script type="text/javascript" src="assets/soop/js/jquery-1.10.1.min.js"></script>
        <script type="text/javascript" src="assets/soop/js/jquery.fancybox.js?v=2.1.5"></script>
        <link rel="stylesheet" type="text/css" href="assets/soop/css/jquery.fancybox.css?v=2.1.5" media="screen" />
        <script type="text/javascript" src="assets/soop/js/fancy.js"></script>


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
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="assets/global/scripts/app.min.js" type="text/javascript"></script>
        <link href="assets/global/plugins/select2/css/select2.min.css" rel="stylesheet"/>
        <script src="assets/global/plugins/select2/js/select2.min.js"></script>
        <script src="assets/global/plugins/select2/js/i18n/it.js"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
        <script src="assets/soop/js/form-input-mask.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
        <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <!-- END THEME LAYOUT SCRIPTS -->
        <script src="assets/global/scripts/datatable.js" type="text/javascript"></script>
        <script src="assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>


        <script type="text/javascript">


            function submitfor() {
                document.forms["f1"].submit();
            }
            function dismiss(name) {
                document.getElementById(name).className = "modal fade";
                document.getElementById(name).style.display = "none";
            }
            function setCaricaDocumento(id) {
                document.getElementById("usernamecaricaconv").value = id;
            }

            function ctrlProt() {
                var prot = document.getElementById("protocollo").value;
                if (prot === "") {
                    $("#div_protocollo").attr("class", "has-error");
                    return false;
                }
                $("#div_protocollo").attr("class", "has-success");

                var decreto = document.getElementById("decreto1").value;
                if (decreto === "") {
                    $("#div_decreto1").attr("class", "has-error");
                    return false;
                }
                $("#div_decreto1").attr("class", "has-success");

                var datadecreto = document.getElementById("datadecreto1").value;
                if (datadecreto === "") {
                    $("#div_decreto2").attr("class", "has-error");
                    return false;
                }
                $("#div_decreto2").attr("class", "has-success");

                return true;
            }

            function setAccettaDomanda(id) {
                document.getElementById("ragsoss").innerHTML = "";
                document.getElementById("usernameDomanda1").value = id;
                $.ajax({
                    type: "GET",
                    url: "Query?tipo=getRagSoc&user=" + id,
                    dataType: "html",
                    success: function (msg)
                    {
                        document.getElementById("ragsoss").innerHTML = msg;
                    },
                    error: function ()
                    {
                        alert("Chiamata fallita, si prega di riprovare...");
                    }
                });
            }

            function ctrlMotivo() {
                var motivo = document.getElementById("motivo").value;
                if (motivo === "") {
                    $("#div_motivo").attr("class", "has-error");
                    return false;
                }
                $("#div_motivo").attr("class", "has-success");

                var prot = document.getElementById("protocollo1").value;
                if (prot === "") {
                    $("#div_protocollo1").attr("class", "has-error");
                    return false;
                }
                $("#div_protocollo1").attr("class", "has-success");

                var decreto = document.getElementById("decreto11").value;
                if (decreto === "") {
                    $("#div_decreto11").attr("class", "has-error");
                    return false;
                }
                $("#div_decreto11").attr("class", "has-success");

                var datadecreto = document.getElementById("datadecreto11").value;
                if (datadecreto === "") {
                    $("#div_decreto21").attr("class", "has-error");
                    return false;
                }
                $("#div_decreto21").attr("class", "has-success");

                return true;
            }

            function setRigettaDomanda(id) {
                document.getElementById("ragsoss2").innerHTML = "";
                document.getElementById("usernameDomanda2").value = id;
                $.ajax({
                    type: "GET",
                    url: "Query?tipo=getRagSoc&user=" + id,
                    dataType: "html",
                    success: function (msg)
                    {
                        document.getElementById("ragsoss2").innerHTML = msg;
                    },
                    error: function ()
                    {
                        alert("Chiamata fallita, si prega di riprovare...");
                    }
                });
                if (ctrlMotivo()) {
                }
            }

        </script>
    </head>
    <%
        String es = request.getParameter("esito");
        String msg = "";
        String inte = "";
        if (es != null) {
            if (es.equals("ok")) {
                inte = "Operazione Completata";
                msg = "Convenzione inviata correttamente.";
            } else if (es.equals("ok1")) {
                inte = "Operazione Completata";
                msg = "Convenzione controfirmata da Roma caricata correttamente. E' ora disponibile per la consultazione.";
            } else if (es.equals("ko1")) {
                inte = "Errore durante il caricamento del documento";
                msg = "La convenzione non è stata caricata. Contattare il supporto tecnico alla email yisucal.supporto@microcredito.gov.it.";
            } else if (es.equals("okR")) {
                inte = "Operazione completata con successo";
                msg = "La presentazione della domanda è stata correttamente rigettata.";
            } else if (es.equals("okA")) {
                inte = "Operazione completata con successo";
                msg = "La presentazione della domanda è stata correttamente accettata.";
            } else if (es.equals("koA")) {
                inte = "Errore dirante l'approvazione della domanda";
                msg = "Errore durante la fase di accettazione della domanda. Contattare il supporto tecnico alla email yisucal.supporto@microcredito.gov.it.";
            } else if (es.equals("ko2")) {
                inte = "Errore durante il caricamento del documento";
                msg = "La convenzione controfirmata da Roma è stata già caricata.";
            } else if (es.equals("ko3")) {
                inte = "Errore durante il caricamento del documento";
                msg = "Il file della convenzione non ha una estensione corretta.";
            } else {
                es = "";
            }

        } else {
            es = "";
        }

    %>


    <%        if (!es.equals("")) {
    %>
    <div class="modal fade" role="dialog">
        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" id="myModal4but" data-target="#myModal4"></button>
        <script>
            $(document).ready(function () {
                $('#myModal4but').click();
            });
        </script>
    </div>
    <%
        }
    %>
    <div id="myModal4" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
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
    <form class="form-horizontal" action="Upload?action=simpleConvenzioni" method="POST" enctype="multipart/form-data">
        <div class="modal fade bs-modal-lg" id="caricadocumento" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content ">
                    <div class="modal-header  bg-red-thunderbird " style="color:white;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title">CARICA CONVENZIONE CONTROFIRMATA</h4>
                    </div>

                    <input type="hidden" name="tipodoc" value="CONROMA"/>
                    <input type="hidden" name="username" id="usernamecaricaconv" value=""/>
                    <input type="hidden" name="data_da"value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_da"))%>"/>
                    <input type="hidden" name="data_a" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_a"))%>"/>
                    <div class="modal-body ">  

                        <div class="form-body">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <label class="text">Seleziona il file da caricare </label><label style="color: red"> &nbsp;*</label><br>
                                <div class="input-group input-large">
                                    <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                        <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                        <span class="fileinput-filename"> </span>
                                    </div>
                                    <span class="input-group-addon btn default btn-file">
                                        <span class="fileinput-new"> Seleziona file </span>
                                        <span class="fileinput-exists"> Cambia </span>
                                        <input type="file" name="file" required> </span>
                                    <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="modal-footer">
                        <div class="form-group">                             
                            <div class="col-md-12"> 
                                <button type="button" class="btn btn-danger large " data-dismiss="modal" onclick="return dismiss('caricadocumento');">Chiudi</button>                    
                                <button type="submit" class="btn btn-success large">Salva file</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>      
    <div class="modal fade bs-modal-lg" id="scartamodal2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">
                <div class="modal-header  bg-red-thunderbird " style="color:white;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">Rigetta domanda <b><span id="ragsoss2"></span></b></h4>
                </div>
                <form action="Operazioni" method="POST">
                    <input type="hidden" name="data_da" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_da"))%>">
                    <input type="hidden" name="data_a" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_a"))%>">
                    <input type="hidden" name="action" value="rigettaDomanda">
                    <input type="hidden" name="accRif" value="R">
                    <input type="hidden" name="usernameDomanda" id="usernameDomanda2" value="">
                    <div class="modal-body">                       
                        <label class="text">Specificare motivazione </label><label style="color: red"> &nbsp;*</label>
                        <div  id="div_motivo">
                            <textarea class="form-control" rows="4" style="resize: none;" id="motivo" name="motivo" placeholder="Motivazione" required></textarea>
                        </div>
                        <hr>
                        <label class="text">Numero di protocollo </label><label style="color: red"> &nbsp;*</label>
                        <div id="div_protocollo1">
                            <input type="text" class="form-control" id="protocollo1" name="protocollo" placeholder="..." required />
                        </div>
                        <hr>
                        <label class="text">Numero Determina: </label><label style="color: red"> &nbsp;*</label>
                        <div id="div_decreto11">
                            <input type="text" class="form-control" id="decreto11" name="decreto" placeholder="..." required />
                        </div>
                        <hr>
                        <label class="text">Data Determina: </label><label style="color: red"> &nbsp;*</label>
                        <div id="div_decreto21">
                            <input type="text" class="form-control date-picker_r" id="datadecreto11" name="datadecreto" placeholder="..."  required />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn dark btn-outline" data-dismiss="modal" onclick="return dismiss('scartamodal2');">Chiudi</button>
                        <button type="submit" class="btn btn-success large " id="conferma_scarta2" onclick="return ctrlMotivo();">Procedi</button> 
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade bs-modal-lg" id="accettamodal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header alert-success">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title color-default uppercase" id="ragioneSocialeScript">Accetta domanda del SA:&nbsp;<b><span id="ragsoss"></span></b></h4>
                </div>
                <form action="Operazioni" method="POST">
                    <input type="hidden" name="data_da" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_da"))%>">
                    <input type="hidden" name="data_a" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_a"))%>">
                    <input type="hidden" name="action" value="accettaDomanda">
                    <input type="hidden" name="accRif" value="A">
                    <input type="hidden" name="usernameDomanda" id="usernameDomanda1" value="">
                    <div class="modal-body">                       
                        <label class="text">Numero di protocollo </label><label style="color: red"> &nbsp;*</label>
                        <div id="div_protocollo">
                            <input type="text" class="form-control" id="protocollo" name="protocollo" placeholder="..." required />
                        </div>
                        <hr>
                        <label class="text">Numero Determina: </label><label style="color: red"> &nbsp;*</label>
                        <div id="div_decreto1">
                            <input type="text" class="form-control" id="decreto1" name="decreto" placeholder="..." required />
                        </div>
                        <hr>
                        <label class="text">Data Determina: </label><label style="color: red"> &nbsp;*</label>
                        <div id="div_decreto2">
                            <input type="text" class="form-control date-picker_r" id="datadecreto1" name="datadecreto" placeholder="..."  required />
                        </div>
                        <hr>
                        <label class="text">Note:</label>
                        <div>
                            <textarea class="form-control" rows="4" style="resize: none;" id="note1" name="note1" placeholder="..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn dark btn-outline" data-dismiss="modal" onclick="return dismiss('accettamodal');">Chiudi</button>
                        <button type="submit" class="btn btn-success large " id="confirmactive" onclick="return ctrlProt();">Procedi</button> 
                    </div>
                </form>
            </div>
        </div>
    </div>
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
                            <a class="nav-link  " href="bando_repag.jsp"><span>HOME</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link active  " href="bando_visdoc.jsp"><span>CONSULTAZIONE</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link  " href="faq_1.jsp"><span>FAQ</span></a>
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
                        String bandorif =Utility.checkAttribute(session,"bandorif");
                        ArrayList<Items> statidomanda = ActionB.query_statodomanda_rc();

                    %>

                    <div class="row">
                        <%if (request.getParameter("search") == null) {%>
                        <div class="col-md-12">
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                    <div class="caption font-red"><i class="fa fa-search font-red"></i> Ricerca</div>
                                </div>
                                <div class="portlet-body form">
                                    <form class="form-horizontal" role="form" name='f1' id="f1" action="bando_visdoc.jsp" method="post">
                                        <input type="hidden" name="search" id="search" value="sra1"/>
                                        <div class="form-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="active control-label col-md-6">Data da:</label>
                                                        <div class="col-md-6">
                                                            <input class="form-control form-control-inline date-picker" size="16" type="text" id="data_da" name="data_da"/>
                                                        </div>
                                                    </div>
                                                </div>   
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="active control-label col-md-6">Data a:</label>
                                                        <div class="col-md-6">
                                                            <input class="form-control form-control-inline date-picker" size="16" type="text" id="data_a" name="data_a"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="active control-label col-md-6">Stato Accreditamento:</label>
                                                        <div class="col-md-6">
                                                            <select id="stato" name="stato" class="form-control select2" data-placeholder="...">
                                                                <option value="">...</option>
                                                                <%for (int p = 0; p < statidomanda.size(); p++) {%>
                                                                <option value="<%=statidomanda.get(p).getCod()%>"><%=statidomanda.get(p).getDescrizione().toUpperCase()%></option>
                                                                <%}%>
                                                            </select>
                                                            <script type="text/javascript">
                                                                $('#' + 'stato').select2({
                                                                    allowClear: true,
                                                                    language: 'it'
                                                                });
                                                            </script>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <div class="pull-right">
                                                                <button type="submit" class="btn btn-outline red"><i class="fa fa-search" ></i> Ricerca</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <%} else {%>
                        <div class="col-md-12">
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                    <div class="caption font-red">
                                        <i class="fa fa-search font-red"></i>Ricerca
                                    </div>
                                </div>
                                <div class="portlet-body form">
                                    <form class="form-horizontal" role="form" name='f1' id="f1" action="bando_visdoc.jsp" method="post">
                                        <input type="hidden" name="search" id="search" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("search"))%>"/>
                                        <div class="form-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-6">Domande consegnate da:</label>
                                                        <div class="col-md-6">
                                                            <input class="form-control form-control-inline date-picker" size="16" type="text" id="data_da" name="data_da" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_da"))%>"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-6">Domande consegnate a:</label>
                                                        <div class="col-md-6">
                                                            <input class="form-control form-control-inline date-picker" size="16" type="text" id="data_a" name="data_a" value="<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_a"))%>"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-6">Stato Accreditamento:</label>
                                                        <div class="col-md-6">
                                                            <select id="stato" name="stato" class="form-control select2" data-placeholder="...">
                                                                <option value="">...</option>
                                                                <%String st1 = Utility.getRequestValue(request, "stato");
                                                                    for (int p = 0; p < statidomanda.size(); p++) {
                                                                        String s = "";
                                                                        if (st1.equals(statidomanda.get(p).getCod())) {
                                                                            s = "selected";
                                                                        }%>
                                                                <option <%=s%> value="<%=statidomanda.get(p).getCod()%>"><%=statidomanda.get(p).getDescrizione().toUpperCase()%></option>
                                                                <%}%>
                                                            </select>
                                                            <script type="text/javascript">
                                                                $('#' + 'stato').select2({
                                                                    allowClear: true,
                                                                    language: 'it'
                                                                });
                                                            </script>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <div class="pull-right">
                                                                <button type="submit" class="btn btn-outline red"><i class="fa fa-search" ></i> Ricerca</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="portlet light bordered ">
                                <div class="portlet-title">
                                    <div class="caption font-blue"><i class="fa fa-bar-chart font-blue"></i><span class="caption-subject">Domande</span></div>
                                    <div class="actions"></div>
                                </div>
                                <div class="portlet-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="portlet-body">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <table class="table table-responsive table-bordered table-hover" id="sample_0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th><b>Codice domanda</b></th>
                                                                    <th><b>Ragione Sociale</b></th>           
                                                                    <th><b>Partita IVA</b></th>                                   
                                                                    <th><b>PEC</b></th>                                      
                                                                    <th><b>Data Consegna</b></th>    
                                                                    <th><b>Stato Accreditamento</b></th>
                                                                    <th><b>Protocollo</b></th>
                                                                    <th><b>Decreto</b></th>
                                                                    <th><b>Azioni</b></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                            <tfoot>
                                                                <tr>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..."></th>
                                                                    <th><input type="text" class="form-control" name="dest1" placeholder="..." disabled=""></th>
                                                                </tr>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <%}%>
                    </div>

                </div>
            </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->
            <!-- END QUICK SIDEBAR -->
        </div>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->

        <!-- BEGIN CORE PLUGINS -->


        <script type="text/javascript">
            jQuery(document).ready(function () {
                var dt1 = function () {
                    var f = $("#sample_0");
                    f.dataTable({
                        language: {aria: {},
                            sProcessing: "Ricerca...",
                            emptyTable: "Nessun risultato trovato.",
                            info: "Mostra _START_ su _END_ di _TOTAL_ risultati",
                            infoEmpty: "Nessun risultato trovato.",
                            infoFiltered: "(filtrati su _MAX_ totali)",
                            lengthMenu: "Mostra _MENU_",
                            search: "Ricerca:",
                            zeroRecords: "Nessun risultato trovato.",
                            paginate: {previous: "Prec", next: "Pros", last: "Ultimo", first: "Primo"}},
                        processing: true,
                        ajax: {
                            url: "Query?tipo=1&search=<%=StringEscapeUtils.escapeHtml4(request.getParameter("search"))%>&stato=<%=StringEscapeUtils.escapeHtml4(request.getParameter("stato"))%>&bandorif=<%=StringEscapeUtils.escapeHtml4(bandorif)%>&data_da=<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_da"))%>&data_a=<%=StringEscapeUtils.escapeHtml4(request.getParameter("data_a"))%>",
                            dataSrc: "aaData",
                            type: "GET"
                        },
                        initComplete: function (settings, json) {
                            $('.popovers').popover();
                        },
                        columnDefs: [
                            {orderable: 1, targets: [0]},
                            {orderable: 1, targets: [1]},
                            {orderable: 1, targets: [2]},
                            {orderable: 1, targets: [3]},
                            {orderable: 1, targets: [4]},
                            {orderable: 1, targets: [5]},
                            {orderable: 1, targets: [6]},
                            {orderable: 1, targets: [7]},
                            {orderable: !1, targets: [8]}
                        ],
                        buttons: [
                            {text: "<i class='fa fa fa-refresh'></i>",
                                className: "btn blue btn-outline",
                                action: function (e, dt, node, config) {
                                    submitfor();
                                }
                            }]
                        ,
                        colReorder: {reorderCallback: function () {
                                console.log("callback");
                            }},
                        lengthMenu: [
                            [25, 50, 100, -1],
                            [25, 50, 100, "All"]
                        ],
                        pageLength: 25,
                        order: [],
                        dom: "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><t><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"
                    });
                    $("#sample_0 tfoot input").keyup(function () {
                        f.fnFilter(this.value, f.oApi._fnVisibleToColumnIndex(
                                f.fnSettings(), $("#sample_0 tfoot input").index(this)));
                    });
                    $("#sample_0 tfoot input").each(function (i) {
                        this.initVal = this.value;
                    });
                    $("#sample_0 tfoot input").focus(function () {
                        if (this.className === "form-control")
                        {
                            this.className = "form-control";
                            this.value = "";
                        }
                    });
                    $("#sample_0 tfoot input").blur(function (i) {
                        if (this.value === "")
                        {
                            this.className = "form-control";
                            this.value = this.initVal;
                        }
                    });
                };
                jQuery().dataTable && dt1();
            });
        </script>

    </body>
</html>
<%}%>
