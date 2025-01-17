<%@page import="rc.soop.entity.Docuserconvenzioni"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="rc.soop.entity.Reportistica"%>
<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.soop.action.Liste"%>
<%@page import="rc.soop.action.Constant"%>
<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.util.Utility"%>
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
        <link href="assets/layouts/layout/css/themes/grey.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 

        <%
            String bandorif = Utility.checkAttribute(session,"bandorif");
            String username = request.getParameter("userdoc").replaceAll("'", "''");
            ArrayList<Docuserconvenzioni> listadoc = ActionB.getDocumentiConvenzioni(username);
            String ragsoc = ActionB.getRagioneSociale(username);
        %>
        <script type="text/javascript">

            function eseguiForm(servURL, params) {
                var method = "post"; // il metodo POST è usato di default
                var form = document.createElement("form");
                form.setAttribute("method", method);
                form.setAttribute("action", servURL);
                for (var key in params) {
                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", key);
                    hiddenField.setAttribute("value", params[key]);
                    form.appendChild(hiddenField);
                }
                document.body.appendChild(form);
                form.submit();
            }

            function submitfor() {
                document.forms["f1"].submit();
            }

            function invioEmail() {
                document.getElementById("invioemailSI").onclick = function () {
                    var v1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                    var email = document.getElementById("email").value;
                    var emailcc = document.getElementById("emailcc").value;

                    var validemail = v1.test(email);
                    var validemailcc = v1.test(emailcc);

                    if (email === "" || !validemail) {
                        document.getElementById("msgerr").className = "alert alert-danger";
                        return false;
                    } else if (emailcc === "" || !validemailcc) {
                        document.getElementById("msgerr").className = "alert alert-danger";
                        return false;
                    } else {
                        document.getElementById("msgerr").className = "alert alert-danger fade";
                        eseguiForm('Operazioni', {'tipodoc': 'CONV', 'username': '<%=StringEscapeUtils.escapeHtml4(username)%>', 'action': 'sendconv', 'email': email, 'emailcc': emailcc});
                    }

                };
                document.getElementById("invioemail").className = document.getElementById("invioemail").className + " in";
                document.getElementById("invioemail").style.display = "block";
                return false;
            }

            function dismiss(name) {
                document.getElementById("msgerr").className = "alert alert-danger fade";
                document.getElementById(name).className = "modal fade";
                document.getElementById(name).style.display = "none";
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
            } else {
                es = "";
            }
        } else {
            es = "";
        }
        if (!es.equals("")) {
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
    <div class="modal fade bs-modal-lg" id="invioemail" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">
                <div class="modal-header  bg-red-thunderbird " style="color:white;">
                    <h4 class="modal-title">Invio convenzione per approvazione - Indicare gli indirizzi email:</h4>
                </div>
                <div class="modal-body">                       
                    <div class="form-group">
                        <div class="col-md-12">
                            <span class="help-block">
                                Email Destinatario: <span class="font-red popovers" data-trigger="hover" 
                                                          data-container="body" data-placement="bottom"
                                                          data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                            </span>
                            <div class="input-icon right">
                                <i id="check_email" class="fa"></i>
                                <input type="text" class="form-control" 
                                       name="email" placeholder="..." id="email"
                                       onchange="return fieldNoEuroMail(this.id);" maxlength="50" required /></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <span class="help-block">
                                Email CC: <span class="font-red popovers" data-trigger="hover" 
                                                data-container="body" data-placement="bottom"
                                                data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                            </span>
                            <div class="input-icon right">
                                <i id="check_emailcc" class="fa"></i>
                                <input type="text" class="form-control" 
                                       name="emailcc" placeholder="..." id="emailcc"
                                       onchange="return fieldNoEuroMail(this.id);"
                                       maxlength="50" required />
                            </div>
                        </div>
                    </div>
                    <script type="text/javascript">
                        var v1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                        $('#email').on('keyup', function () {
                            if (this.value.length > 0) {
                                var valid = v1.test(this.value) && this.value.length;
                                if (!valid) {
                                    $('#check_email').removeClass("fa-check");
                                    $('#check_email').removeClass("font-green-jungle");
                                    $('#check_email').addClass("fa-times");
                                    $('#check_email').addClass("font-red");
                                } else {
                                    $('#check_email').addClass("fa-check");
                                    $('#check_email').addClass("font-green-jungle");
                                    $('#check_email').removeClass("fa-times");
                                    $('#check_email').removeClass("font-red");
                                }
                            } else {
                                $('#check_email').removeClass("fa-check");
                                $('#check_email').removeClass("fa-times");
                                $('#check_email').removeClass("font-green-jungle");
                                $('#check_email').removeClass("font-red");
                            }
                        });
                        $('#emailcc').on('keyup', function () {
                            if (this.value.length > 0) {
                                var valid = v1.test(this.value) && this.value.length;
                                if (!valid) {
                                    $('#check_emailcc').removeClass("fa-check");
                                    $('#check_emailcc').removeClass("font-green-jungle");
                                    $('#check_emailcc').addClass("fa-times");
                                    $('#check_emailcc').addClass("font-red");
                                } else {
                                    $('#check_emailcc').addClass("fa-check");
                                    $('#check_emailcc').addClass("font-green-jungle");
                                    $('#check_emailcc').removeClass("fa-times");
                                    $('#check_emailcc').removeClass("font-red");
                                }
                            } else {
                                $('#check_emailcc').removeClass("fa-check");
                                $('#check_emailcc').removeClass("fa-times");
                                $('#check_emailcc').removeClass("font-green-jungle");
                                $('#check_emailcc').removeClass("font-red");
                            }
                        });
                    </script>
                    <br>
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="alert alert-danger fade" id="msgerr">Tutti i campi sono obbligatori.</div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="form-group">                             
                        <div class="col-md-12"> 
                            <button type="button" class="btn btn-danger large " data-dismiss="modal" onclick="return dismiss('invioemail');"><i class="fa fa-remove"></i> CHIUDI</button>                    
                            <a class="btn btn-success large " id="invioemailSI" ><i class="fa fa-envelope-o"></i> INVIA</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <body class= "page-full-width page-content-white ">
                <%@ include file="menu/header.jsp"%>
        <%@include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp" %>
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
                            <h3 class="page-title">Visualizza <small>Documenti</small></h3>
                        </div>
                        <div class="col-md-3" style="text-align: right;">
                            <img src="assets/soop/img/logo_blue_1.png" alt="logo" height="70px"/>
                        </div>
                    </div>


                    <%if (!listadoc.isEmpty()) {

                            Liste li = new Liste(bandorif, username);
                            ArrayList<Docbandi> lidCONV = li.getLid2();
                            String varsendMailRoma = ActionB.getConvenzioneROMA(username);
                            boolean mailinviataroma = !ActionB.getInvioEmailROMA(username).equals("0");
                            Docbandi doc_fase1 = Utility.estraidaLista(lidCONV, "CONV");
                            Docbandi doc_fase2 = Utility.estraidaLista(lidCONV, "MOD1");
                            Docbandi doc_fase3 = Utility.estraidaLista(lidCONV, "MOD2");

                    %>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption font-blue"> <i class="fa fa-reorder font-blue"></i> Documenti Convenzione  - Soggetto Attuatore: <%=StringEscapeUtils.escapeHtml4(ragsoc)%></div>
                                </div>
                                <div class="portlet-body" id="dvData">
                                    <table class="table table-striped table-bordered table-hover" id="sample_1">
                                        <thead class=" font-blue">
                                            <tr>
                                                <th><b>Codice documento</b></th>
                                                <th><b>Titolo documento</b></th>
                                                <th><b>Note</b></th>
                                                <th><b>Data caricamento</b></th>                                      
                                                <th><b>Scarica</b></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (int i = 0; i < listadoc.size(); i++) {
                                                    Docuserconvenzioni docuser = listadoc.get(i);
                                                    String codicedoc = docuser.getCodicedoc();
                                                    String desc = "";
                                                    if (codicedoc.equals("CONV")) {
                                                        desc = doc_fase1.getTitolo();
                                                    }
                                                    if (codicedoc.equals("MOD1")) {
                                                        desc = doc_fase2.getTitolo();
                                                    }
                                                    if (codicedoc.equals("MOD2")) {
                                                        desc = doc_fase3.getTitolo();
                                                    }
                                                    String note = docuser.getNote();
                                                    if (note == null || note.equals("-")) {
                                                        note = ragsoc;
                                                    }
                                            %>
                                            <tr>
                                                <td><%=StringEscapeUtils.escapeHtml4(docuser.getCodicedoc())%></td> 
                                                <td><%=StringEscapeUtils.escapeHtml4(desc)%></td> 
                                                <td><%=StringEscapeUtils.escapeHtml4(note)%></td> 
                                                <td><%=Utility.formatStringtoStringDate(StringEscapeUtils.escapeHtml4(docuser.getDatacar()))%></td>
                                                <td>
                                                    <%if (!docuser.getPath().equals("-")) {%>
                                                    <div class="clearfix">
                                                        <form role="form" action="<%=request.getContextPath() + "/Download?action=viewFileConvenzioniRUP"%>" method="post" target="_blank">
                                                            <input type="hidden" name="tipologia" value="<%=StringEscapeUtils.escapeHtml4(docuser.getCodicedoc())%>"/>
                                                            <input type="hidden" name="userdoc" value="<%=StringEscapeUtils.escapeHtml4(docuser.getUsername())%>"/>
                                                            <button class="btn btn-sm btn-outline blue popovers" type="submit">
                                                                <i class='fa fa-file-o'></i></button>
                                                        </form>
                                                    </div>
                                                    <%}%>
                                                </td> 
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <%
                                        if (varsendMailRoma.equals("")) {
                                            if (!mailinviataroma) {
                                    %>
                                    <button  type="button" class="btn red btn-outline " onclick="return invioEmail();"> <i class="fa fa-envelope"></i> Invio ad Ente Nazionale Microcredito</button>
                                    <%
                                    } else {
                                    %>
                                    <div class="alert alert-info"><i class="fa fa-angle-double-up"></i>&nbsp;&nbsp;Email già inviata</div>
                                    <%
                                        }
                                    %>
                                    <%if (request.getParameter("esito") != null) {
                                            String esi = request.getParameter("esito");
                                            if (esi.equals("ko1")) {%>
                                    <br>
                                    <%}
                                            }

                                        }%>

                                </div>
                            </div>
                        </div>
                    </div>
                    <%

                        if (!varsendMailRoma.equals("")) {


                    %>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption font-blue"> <i class="fa fa-reorder font-blue"></i> Convenzione controfirmata da Ente Nazionale Microcredito</div>
                                </div>
                                <div class="portlet-body" id="dvData">
                                    <table class="table table-striped table-bordered table-hover" id="sample_1">
                                        <thead class="font-blue">
                                            <tr>
                                                <th><b>Codice documento</b></th>
                                                <th><b>Titolo documento</b></th>
                                                <th><b>Note</b></th>
                                                <th><b>Scarica</b></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>CONVROMA</td> 
                                                <td>Convenzione controfirmata da Ente Nazionale Microcredito</td> 
                                                <td><%=StringEscapeUtils.escapeHtml4(ragsoc)%></td> 
                                                <td>
                                                    <div class="clearfix">
                                                        <form role="form" action="<%=StringEscapeUtils.escapeHtml4(request.getContextPath()) + "/Download?action=docbandoconsConv"%>" method="post" target="_blank">
                                                            <input type="hidden" name="userdoc" value="<%=StringEscapeUtils.escapeHtml4(username)%>"/>
                                                            <button class="btn btn-sm btn-outline green popovers" type="submit">
                                                                <i class='fa fa-file-o'></i></button>
                                                        </form>
                                                    </div>
                                                </td> 
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>


        <%}%>
    </div>
</div>
<!-- END CONTENT -->
<!-- BEGIN QUICK SIDEBAR -->
<!-- END QUICK SIDEBAR -->
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->




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

<script src="assets/global/scripts/datatable.js" type="text/javascript"></script>
<script src="assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>

<script type="text/javascript">
                                        jQuery(document).ready(function () {
                                            var dt1 = function () {
                                                var f = $("#sample_1");
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
                                                    initComplete: function (settings, json) {
                                                        $('.popovers').popover();
                                                    },
                                                    columnDefs: [
                                                        {orderable: 1, targets: [0]},
                                                        {orderable: 1, targets: [1]},
                                                        {orderable: 1, targets: [2]},
                                                        {orderable: 1, targets: [3]},
                                                        {orderable: !1, targets: [4]}
                                                    ], buttons: []
                                                    ,
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