<%-- 
    Document   : bando_index2
    Created on : 28-lug-2017, 15.43.51
    Author     : rcosco
--%>

<%@page import="rc.soop.util.Utility.checkAttribute(...)"%>
<%@page import="rc.soop.util.Utility.checkAttribute(...)"%>
<%@page import="rc.soop.action.Constant"%>
<%@page import="rc.soop.entity.Faq"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@page import="org.apache.commons.text.RandomStringGenerator"%>
<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="rc.soop.entity.Docuserbandi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.soop.action.Liste"%>
<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.util.Utility"%>
<%@ page language="java" pageEncoding="UTF-8"%>
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
        <script src="assets/soop/js/moment.js" type="text/javascript"></script>

        <!-- FANCYBOX -->
        <script type="text/javascript" src="assets/soop/js/jquery-1.10.1.min.js"></script>
        <script type="text/javascript" src="assets/soop/js/jquery.fancybox.js?v=2.1.5"></script>
        <link rel="stylesheet" type="text/css" href="assets/soop/css/jquery.fancybox.css?v=2.1.5" media="screen" />
        <script type="text/javascript" src="assets/soop/js/fancy.js"></script>

        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />

        <link href="assets/pages/css/faq.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 



        <%
            String tipo =  Utility.checkAttribute(session,"tipo");
        %>

        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="assets/soop/js/jquery-1.10.1.min.js"></script>
        <script type="text/javascript" src="assets/soop/js/bootstrap-show-modal.js"></script>
        <script src="assets/soop/tinymce/tinymce.min.js?apiKey=ma1upy7t6aft708fnem5ewb25zj40b36gdnl9ovb046gcbqx"></script>
    </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-closed">
        <%@ include file="menu/header.jsp"%>
        <%@ include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp"%>

        <!-- BEGIN HEADER -->
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <!-- BEGIN MENU -->
        <!-- END MENU -->

        <%if (tipo.equals("1")) {%>
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
                            <a class="nav-link  " href="bando_visdoc.jsp"><span>CONSULTAZIONE</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link active " href="faq_1.jsp"><span>FAQ</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <%} else {%>
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
                            <a class="nav-link active " href="faq.jsp"><span>FAQ</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <%}%>
        <div class="clearfix"> </div>

        <div class="page-container">

            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <%
                        String es = request.getParameter("esito");
                        String msg = "";
                        String inte = "";
                        if (es != null) {
                            if (es.equals("ok")) {
                                inte = "Operazione Completata";
                                msg = "Documento caricato con successo. Puoi procedere allo step successivo.";
                            } else if (es.equals("ok1")) {
                                inte = "Operazione Completata";
                                msg = "Documento compilato con successo. Puoi procedere allo step successivo.";
                            } else if (es.equals("okrem")) {
                                inte = "Operazione Completata";
                                msg = "Documento eliminato con successo.";
                            } else if (es.equals("okrem1")) {
                                inte = "Operazione Completata";
                                msg = "Dati eliminati con successo.";
                            } else if (es.equals("okinvio")) {
                                inte = "Operazione Completata";
                                msg = "Domanda inviata con successo.";
                            } else if (es.equals("korem")) {
                                inte = "Errore";
                                msg = "Impossibile eliminare il documento, contattare l'amministratore del sistema. <u>yisucal.supporto@microcredito.gov.it</u>";
                            } else if (es.equals("ko1")) {
                                inte = "Errore";
                                msg = "Impossibile salvare i dati della domanda, contattare l'amministratore del sistema. <u>yisucal.supporto@microcredito.gov.it</u>";
                            } else if (es.equals("ko2")) {
                                inte = "Errore";
                                msg = "Impossibile salvare i dati dell'allegato B, contattare l'amministratore del sistema. <u>yisucal.supporto@microcredito.gov.it</u>";
                            } else if (es.equals("koinvio")) {
                                inte = "Errore";
                                msg = "Impossibile inviare la domanda, contattare l'amministratore del sistema. <u>yisucal.supporto@microcredito.gov.it</u>";
                            } else if (es.equals("koinviopresente")) {
                                inte = "Errore";
                                msg = "Impossibile inviare la domanda in quanto risulta già inviata.";
                            } else if (es.equals("kocanc")) {
                                inte = "Errore";
                                msg = "Impossibile annullare la domanda, contattare l'amministratore del sistema. <u>yisucal.supporto@microcredito.gov.it</u>";
                            } else if (es.equals("kodop")) {
                                inte = "Errore";
                                msg = "Documento già presente. Impossibile caricare documento.";
                            } else if (es.equals("koest")) {
                                inte = "Errore";
                                msg = "Tipo documento non valido, è stato forzato il link alla pagina.";
                            } else if (es.equals("kocarest")) {
                                inte = "Errore";
                                msg = "I documenti convenzione, Modello 1 e Modello 2 devono essere firmati digitalmente e quindi devono avere il formato <b>.p7m</b>.";
                            } else if (es.equals("okconv")) {
                                inte = "Operazione Completata";
                                msg = "Convenzione inviata con successo.";
                            } else if (es.equals("koconv")) {
                                inte = "Errore";
                                msg = "Impossibile inviare i dati della convenzione, contattare l'amministratore del sistema. <u>yisucal.supporto@microcredito.gov.it</u>";
                            } else if (es.equals("koconv2")) {
                                inte = "Errore";
                                msg = "Impossibile inviare i dati della convenzione, convenzione già inviata";
                            } else {
                                es = "";
                            }
                        } else {
                            es = "";
                        }

                        List<Faq> al = ActionB.elencoFAQ(null);

                        if (!es.equals("")) {%>
                    <div class="modal fade" role="dialog">
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
                    <%}%>
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <!-- END THEME PANEL -->
                    <!-- BEGIN PAGE BAR -->
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <div class="row">
                        <div class="col-md-9">
                            <h3 class="page-title">FAQ</h3>
                        </div>
                        <div class="col-md-3" style="text-align: right;">
                            <img src="assets/soop/img/logo_blue_1.png" alt="logo" height="70px"/>
                        </div>
                    </div>
                    <div class="faq-page faq-content-1">
                        <div class="faq-content-container" id="faq-list">
                            <div class="row">
                                <div class="col-md-9">
                                    <div class="search-bar bordered">
                                        <div class="input-group" id="filter-form">
                                            <input type="text" class="form-control noEnterSubmit" placeholder="Cerca..."  id="filter" /> 
                                        </div>
                                        <small>
                                            <span id="filter-help-block" class="help-block">
                                            </span>
                                        </small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <a class="mt-element-list popovers fancyBoxRafreload" style="text-decoration: none;" href="faq_add.jsp">
                                        <div class="mt-list-head list-news font-white bg-green-jungle">
                                            <div class="list-head-title-container">
                                                <br>
                                                <h2 class="list-title uppercase"><i class="fa fa-plus-square-o"></i> AGGIUNGI NUOVA</h2>
                                                <br>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>


                            <script>
                                function removefaq(idfaq) {
                                    var ok = 0;
                                    $.showConfirm({
                                        title: "Conferma eliminazione FAQ", body: "Sicuro di voler eliminare la FAQ selezionata?",
                                        textTrue: "SI", textFalse: "NO",
                                        onSubmit: function (result) {
                                            if (result) {
                                                $.ajax({
                                                    async: false,
                                                    type: "POST",
                                                    url: "Operazioni?action=deletefaq&idfaq=" + idfaq,
                                                    dataType: "text",
                                                    success: function (msg) {
                                                        if (msg === "OK") {
                                                            location.reload();
                                                        } else {
                                                            $.showAlert({title: "ERRORE", body: "Impossibile elimare FAQ. Riprovare."});
                                                        }
                                                    },
                                                    error: function () {
                                                        $.showAlert({title: "ERRORE", body: "Impossibile elimare FAQ. Riprovare."});
                                                    }
                                                });
                                            }
                                        }
                                    });
                                }



                            </script>

                            <%if (al.size() > 0) {%>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="faq-section bordered">
                                        <h2 class="uppercase font-blue">ELENCO FAQ</h2>
                                        <hr>
                                        <div class="panel-group accordion faq-content" id="accordion1">
                                            <%for (int x = 0; x < al.size(); x++) {
                                                    Faq f1 = al.get(x);
                                                    String domandavis = f1.getDomanda_mod();
                                                    if (domandavis == null || domandavis.trim().equals("")) {
                                                        domandavis = f1.getDomanda();
                                                    }
                                            %>
                                            <div class="panel panel-default">
                                                <%if (tipo.equals("1")) {%>
                                                <div class="btn-group-devided pull-right">
                                                    <a href="faq_add.jsp?idfaq=<%=f1.getIdfaq()%>" 
                                                       class="btn btn-circle blue btn-icon-only popovers fancyBoxRafreload"
                                                       data-trigger="hover" data-container="body" data-placement="left"
                                                       data-content="Modifica/Rispondi alla FAQ" 
                                                       data-original-title="Gestisci"
                                                       ><i class="fa fa-edit"></i>
                                                    </a>
                                                    <button type="button" onclick="return removefaq('<%=f1.getIdfaq()%>')"
                                                            class="btn red btn-circle btn-icon-only popovers"
                                                            data-trigger="hover" data-container="body" data-placement="left"
                                                            data-content="Elimina FAQ" 
                                                            data-original-title="Elimina"
                                                            ><i class="fa fa-remove"></i>
                                                    </button>



                                                </div>
                                                <%}%>
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <%if (tipo.equals("1")) {%>
                                                        <%if (f1.getTipo() == 2) {%>    
                                                        <i class="fa fa-check font-green-jungle popovers" data-trigger="hover" data-container="body" data-placement="TOP"
                                                           data-content="APPROVATA IN DATA <%=StringEscapeUtils.escapeHtml4(f1.getDate_answer())%>" 
                                                           >
                                                        </i>
                                                        <%} else if (f1.getTipo() == 1) {%>    
                                                        <i class="fa fa-exclamation-triangle font-yellow popovers" 
                                                           data-trigger="hover" data-container="body" data-placement="right"
                                                           data-content="IN ATTESA DI RISPOSTA" 
                                                           ></i>
                                                        <%}%>

                                                        <%} else {%>
                                                        <i class="fa fa-circle"></i>
                                                        <%}%>
                                                        <a class="accordion-toggle collapsed" data-toggle="collapse" 
                                                           data-parent="#accordion1" 
                                                           href="#collapse_<%=x%>" aria-expanded="false">
                                                            <span class="uppercase"><%=StringEscapeUtils.escapeHtml4(domandavis)%></span>
                                                            <small>(<%=StringEscapeUtils.escapeHtml4(f1.getDate_ask())%>)</small>
                                                            <%if (f1.getTipo() == 1) {%><small class="badge badge-danger">IN ATTESA DI RISPOSTA</small><%}%>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <br>
                                                <div id="collapse_<%=x%>" class="panel-collapse collapse "
                                                     aria-expanded="false" style="height: 0px;">
                                                    <div class="panel-body uppercase">
                                                        <%=StringEscapeUtils.escapeHtml4(f1.getRisposta())%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                                <hr>
                                            </div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>  
                            <%} else {%>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-warning bold">
                                        NON &#200; PRESENTE ALCUNA FAQ.
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>




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
        <script src="assets/soop/js/select2.full.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="assets/global/scripts/app.min.js" type="text/javascript"></script>
        <script src="assets/pages/scripts/dashboard.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-select/js/bootstrap-select.min.js" type="text/javascript"></script>
        <script src="assets/pages/scripts/components-bootstrap-select.min.js" type="text/javascript"></script>
        <script src="assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
        <script src="assets/soop/js/form-input-mask.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
        <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <script type="text/javascript">

                                                        $(document).ready(function () {

                                                            (function ($) {
                                                                var $form = $('#filter-form');
                                                                var $helpBlock = $("#filter-help-block");
                                                                $('#filter').keyup(function () {
                                                                    var filter = $(this).val();
                                                                    $form.removeClass("has-success has-error");
                                                                    if (filter === "") {
                                                                        $helpBlock.text("");
                                                                        $('.faq-content .panel').show();
                                                                    } else {
                                                                        $('.collapse.in').removeClass('in');
                                                                        $('.faq-content .panel').hide();
                                                                        var regex = new RegExp(filter, 'i');
                                                                        var filterResult = $('.faq-content .panel').filter(function () {
                                                                            return regex.test($(this).text());
                                                                        });
                                                                        if (filterResult) {
                                                                            if (filterResult.length !== 0) {
                                                                                $form.addClass("has-success");
                                                                                if (filterResult.length > 1) {
                                                                                    $helpBlock.text(filterResult.length + " FAQ TROVATE.");
                                                                                } else {
                                                                                    $helpBlock.text(filterResult.length + " FAQ TROVATA.");
                                                                                }
                                                                                filterResult.show();
                                                                            } else {
                                                                                $form.addClass("has-error").removeClass("has-success");
                                                                                $helpBlock.text("NESSUNA FAQ CORRISPONDENTE.");
                                                                            }
                                                                        } else {
                                                                            $form.addClass("has-error").removeClass("has-success");
                                                                            $helpBlock.text("NESSUNA FAQ CORRISPONDENTE.");
                                                                        }
                                                                    }
                                                                });
                                                            }($));
                                                        });
                                                        $('.noEnterSubmit').keypress(function (e) {
                                                            if (e.which === 13)
                                                                e.preventDefault();
                                                        });

        </script>


    </body> 
</html>
<%}%>
