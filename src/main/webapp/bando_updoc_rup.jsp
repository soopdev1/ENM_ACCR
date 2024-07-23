<%@page import="rc.soop.action.Constant"%>
<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.util.Utility"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
        <meta charset="utf-8"/>
        <title><%=Constant.nomevisual%></title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1" name="viewport"/>
        <meta content="" name="description"/>
        <meta content="" name="author"/>
        <meta name="MobileOptimized" content="320">
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


        <!-- END THEME STYLES -->
        <link rel="shortcut icon" href="favicon.ico"/>
        <script type="text/javascript">
            function controlla() {
                var filedoc = document.f1.file.value;
                if (filedoc === "" || filedoc === "...") {
                    document.getElementById("valoretxt").innerHTML = "Impossibile procedere. Scegliere il file da caricare";
                    document.getElementById("static").className = document.getElementById("static").className + " in";
                    document.getElementById("static").style.display = "block";
                    return false;
                }
                var tipologia = document.f1.tipologia.value;
                if (tipologia === "" || tipologia === "...") {
                    document.getElementById("valoretxt").innerHTML = "Impossibile procedere. Scegliere la tipologia documentale da caricare.";
                    document.getElementById("static").className = document.getElementById("static").className + " in";
                    document.getElementById("static").style.display = "block";
                    return false;
                }
            }
            function controllacompl() {
                var filedocF = document.f2.fileF.value;
                var filedocR = document.f2.fileR.value;
                if (filedocF === "" || filedocR === "") {
                    document.getElementById("valoretxt").innerHTML = "Impossibile procedere. Necessario scegliere <span style='color:red;'>entrambi</span> i file da caricare.";
                    document.getElementById("static").className = document.getElementById("static").className + " in";
                    document.getElementById("static").style.display = "block";
                    return false;
                }
            }
            function dismiss(name) {
                document.getElementById(name).className = "modal fade";
                document.getElementById(name).style.display = "none";
            }
        </script>
    </head>
    <!-- END HEAD -->
    <!-- BEGIN BODY -->
    <body class="page-full-width page-footer-fixed" style="height: 500px; background-color: white;">
        <%@ include file="menu/header.jsp"%>
        <%@include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp" %>
        <!-- SETA JAVA -->

        <div id="static" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Errore</h4>
                    </div>
                    <div class="modal-body">
                        <p id="valoretxt">

                        </p>
                    </div>
                    <div class="modal-footer" id="groupbtn2">
                        <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('static');">Chiudi</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- END HEADER -->
        <%
            String username = request.getParameter("userdoc");
        %>

        <!-- END SIDEBAR -->
        <!-- BEGIN CONTENT -->
        <div class="page-content-wrapper">
            <div class="page-content">
                <div class="row">
                    <div class="col-md-12">
                        <form action="Upload?action=simpleRUP"" method="POST" enctype="multipart/form-data" 
                              name="f1" onsubmit="return controlla();">
                            <input type="hidden" name="userdoc" value="<%=StringEscapeUtils.escapeHtml4(username)%>"/>
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                    <div class="caption font-blue"><i class="fa fa-upload font-blue"></i>Carica allegato alla domanda:</div>
                                </div>
                                <div class="portlet-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="control-label col-md-1">File <b style="color: red;">*</b> </label>
                                                <div class="col-md-11">
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new"> Select file </span>
                                                                <span class="fileinput-exists"> Change </span>
                                                                <input type="file" name="file" required> </span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>

                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                            <br>
                                            <hr>
                                        </div>
                                        <div class="col-md-2">
                                            <a class="btn btn btn-lg btn-block red" href="bando_index.jsp"><i class="fa fa-arrow-left"></i> Indietro</a>
                                        </div>
                                        <div class="col-md-10">
                                            <button type="submit" class="btn btn-lg green-jungle btn-block">
                                                <i class="fa fa-upload"></i> Carica</button>
                                        </div>                            
                                    </div>
                                </div>
                            </div>



                        </form>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->
                <!-- END PAGE CONTENT-->
                <%
                    String es = request.getParameter("esito");
                    if (es != null) {
                        String msg = "";
                        String cl = "";
                        if (es.equals("0")) {
                            cl = "alert-success";
                            msg = "Documento caricato con successo";
                        }
                        if (es.equals("1")) {
                            cl = "alert-danger";
                            msg = "Errore durante il caricamento del file. Riprovare.";
                        }
                        if (es.equals("2")) {
                            cl = "alert-danger";
                            msg = "File corrotto o non disponibile. Riprovare.";
                        }
                        if (es.equals("3")) {
                            cl = "alert-danger";
                            msg = "Impossibile careicare il documento. Contattare l'amministratore del sistema.";
                        }
                %>
                <br>
                <div class="row">
                    <div class="col-md-6">
                        <div class="alert <%=cl%>" style="text-align: center;">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
                            <strong><%=msg%></strong>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
                <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
        </div>
        <!-- END FOOTER -->
        <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
        <!-- BEGIN CORE PLUGINS -->
        <!--[if lt IE 9]>
           <script src="assets/plugins/respond.min.js"></script>
           <script src="assets/plugins/excanvas.min.js"></script> 
           <![endif]-->
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
        <script src="assets/pages/scripts/components-bootstrap-select.min.js" type="text/javascript"></script>
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
        <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
    </body>
    <!-- END BODY -->
</html>
<!-- Localized -->