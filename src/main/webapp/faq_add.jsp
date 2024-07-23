<%@ page language="java" pageEncoding="UTF-8"%>
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
        <link href="assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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

        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/themes/grey.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />

        <link href="assets/pages/css/faq.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 
        <script type="text/javascript" src="assets/soop/js/jquery-1.10.1.min.js"></script>

        <%
            String username = Utility.checkAttribute(session,"username");
            String tipo = Utility.checkAttribute(session,"tipo");

            String idfaq = request.getParameter("idfaq").replaceAll("'", "''");

            if (idfaq == null) {
                idfaq = "";
            }

            Faq f1 = null;

            String actionform = "addfaq";
            String domanda = "";
            String risposta = "";
            String testobottone = "Aggiungi";
            if (!idfaq.equals("")) {
                f1 = ActionB.getFAQ(idfaq);
                domanda = f1.getDomanda_mod();
                risposta = f1.getRisposta();
                actionform = "editfaq";
                testobottone = "Salva Modifiche";
            }

            String es = request.getParameter("esito");
            String msg = "";
            String inte = "";
            if (es != null) {
                if (es.equals("ko")) {
                    inte = "Errore";
                    msg = "Impossibile salvare i dati della faq, contattare il supporto.";
                }
            } else {
                es = "";
            }
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
                    <button type="button" data-dismiss="modal" class="btn blue">OK</button>
                </div>
            </div>

        </div>
    </div>
    <%}%>

    <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>

</head>
<body class= "page-full-width page-content-white ">
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet light">
                            <div class="portlet-title">
                                <div class="caption font-blue"> <i class="fa fa-reorder font-blue"></i> NUOVA FAQ </div>
                            </div>
                            <div class="portlet-body">
                                <form method="POST" action="Operazioni?action=<%=actionform%>" 
                                      onsubmit="return checkfaq();">
                                    <%if (tipo.equals("1") && f1 == null) {%>
                                    <div class="alert alert-warning">
                                        <b>ATTENZIONE!</b> LA FAQ CHE SI STA INSERENDO VERR&#192; RESA PUBBLICA IMMEDIATAMENTE.
                                    </div>
                                    <%}%>
                                    <div class="form-group">
                                        <label class="h3">DOMANDA:</label>
                                        <input id="titolo" name="titolo" type="text" class="form-control" placeholder="..." required maxlength="250" value="<%=StringEscapeUtils.escapeHtml4(domanda)%>"/>
                                    </div>
                                    <%if (tipo.equals("1")) {%>
                                    <div class="form-group">
                                        <hr>
                                    </div>
                                    <div class="form-group">
                                        <label class="h3">RISPOSTA:</label>
                                        <textarea id="testo" name="testo" rows="10" class="tinyta" placeholder="..."><%=StringEscapeUtils.escapeHtml4(risposta)%></textarea>
                                        <center><span class="bootstrap-maxlength label label-important" id="testolabel"></span></center>
                                    </div>
                                        
                                        
                                    <%} else {%>
                                    <input name="testo" type="hidden" value="-"/>
                                    <%}%>
                                    <br>
                                    <div class="form-group">
                                        <hr>
                                    </div>
                                    <div class="col-md-2 col-md-offset-5">
                                        <button type="submit" class="btn btn-lg green-jungle btn-block">
                                            <i class="fa fa-save"></i> <%=testobottone%>
                                        </button>
                                    </div>
                                    <!--HIDDEN-->
                                    <input type="hidden" name="username" value="<%=StringEscapeUtils.escapeHtml4(username)%>"  />
                                    <input type="hidden" name="tipo" value="<%=StringEscapeUtils.escapeHtml4(tipo)%>"  />
                                    <input type="hidden" name="idfaq" value="<%=StringEscapeUtils.escapeHtml4(idfaq)%>"    />
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>




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
    <script src="assets/global/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>

    <!-- END PAGE LEVEL SCRIPTS -->
    <!-- BEGIN THEME LAYOUT SCRIPTS -->
    <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
    <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>

    <script src="assets/soop/tinymce/tinymce.min.js?apiKey=ma1upy7t6aft708fnem5ewb25zj40b36gdnl9ovb046gcbqx"></script>
    <script>

            function checkfaq() {

                var titolo = $('#titolo').val();
                var testo = getStats('testo').chars;

                if (titolo === "" || testo === 0) {

                    return false;
                }

            }

            $(function () {
                tinymce.init({
                    selector: '.tinyta',
                    height: 250,
                    statusbar: false,
                    resize: false,
                    menubar: false,
                    branding: false,
                    schema: 'html5',
                    toolbar1: 'undo redo | fontsizeselect fontselect | bold italic underline',
                    fontsize_formats: '6pt 8pt 9pt 10pt 11pt 12pt 14pt 18pt 20pt',
                    setup: function (editor) {
                        var maxlength = 2000;
                        editor.on("keydown", function (e) {
                            var num = getStats(this.id).chars;
                            if (num === 0) {
                                $('#testolabel').removeClass('label-success');
                                $('#testolabel').removeClass('label-warning');
                                $('#testolabel').removeClass('label-danger');
                                $('#testolabel').html('');
                                $('#testolabel').toggle(false);
                            } else if (num > 0 && num < (maxlength - 200 + 1)) {
                                $('#testolabel:not(.label-success)').addClass('label-success');
                                $('#testolabel').html(num + "/" + maxlength);
                                $('#testolabel').toggle(true);
                            } else if (num < maxlength + 1) {
                                $('#testolabel:not(.label-warning)').addClass('label-warning');
                                $('#testolabel').html(num + "/" + maxlength);
                                $('#testolabel').toggle(true);
                            } else {
                                $('#testolabel:not(.label-danger)').addClass('label-danger');
                                $('#testolabel').html(num + "/" + maxlength);
                                $('#testolabel').toggle(true);
                                if (e.keyCode === 46 || e.keyCode === 8) {
                                } else {
                                    e.stopPropagation();
                                    return false;
                                }
                            }
                        });
                        editor.on("focusin", function (e) {
                            $('#testolabel').toggle(true);
                        });
                        editor.on("focusout", function (e) {
                            $('#testolabel').toggle(false);
                        });

                    }
                });

                $('#titolo').maxlength({
                    alwaysShow: true,
                    threshold: 10,
                    warningClass: "label label-success",
                    limitReachedClass: "label label-danger"
                });

            });

            function getStats(id) {
                var body = tinymce.get(id).getBody(), text = tinymce.trim(body.innerText || body.textContent);
                return {
                    chars: text.length,
                    words: text.split(/[\w\u2019\'-]+/).length
                };
            }
    </script>

</body> 
</html>
<%}%>
