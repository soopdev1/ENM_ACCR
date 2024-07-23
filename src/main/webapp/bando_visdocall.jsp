<%@page import="rc.soop.db.Db_Bando"%>
<%@page import="rc.soop.action.Constant"%>
<%@page import="rc.soop.entity.DocumentiDocente"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="rc.soop.entity.Reportistica"%>
<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="rc.soop.entity.Docuserbandi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.soop.action.Liste"%>
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
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 


        <script type="text/javascript">
            function submitfor() {
                document.forms["f1"].submit();
            }
        </script>
    </head>
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
                    <%
                        String bandorif =Utility.checkAttribute(session"bandorif");
                        String username = request.getParameter("userdoc").replaceAll("'", "''");
                        Db_Bando db1 = new Db_Bando();
                        ArrayList<String[]> richiesti = ActionB.listacodDocRichiesti(db1, bandorif, username);
                        ArrayList<Docuserbandi> listadoc = db1.listaDocUserBandoNocontent(bandorif, username);
                        db1.closeDB();
                        if (!listadoc.isEmpty()) {
                            String ragsoc = ActionB.getRagioneSociale(username);
                    %>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption font-blue"> <i class="fa fa-reorder font-blue"></i> Documenti Domanda - Soggetto Attuatore: <%=StringEscapeUtils.escapeHtml4(ragsoc)%></div>
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
                                                    Docuserbandi docuser = listadoc.get(i);
                                                    if (docuser.getCodicedoc().equals("ALB1")) {
                                                        continue;
                                                    }
                                                    String note = docuser.getNote();
                                                    if (note == null || note.equals("-")) {
                                                        note = ragsoc;
                                                    }
                                            %>
                                            <tr>
                                                <td><%=StringEscapeUtils.escapeHtml4(docuser.getCodicedoc())%></td> 
                                                <td><%=Liste.formatTipoDoc2(StringEscapeUtils.escapeHtml4(docuser.getCodicedoc(), richiesti)).toUpperCase()%></td> 
                                                <td><%=StringEscapeUtils.escapeHtml4(note)%></td> 
                                                <td><%=Utility.formatStringtoStringDate(StringEscapeUtils.escapeHtml4(docuser.getDatacar()))%></td>
                                                <td>
                                                    <div class="clearfix">
                                                        <form role="form" action="<%=request.getContextPath() + "/Download?action=docbandoconsrup"%>" method="post" target="_blank">
                                                            <input type="hidden" name="tipodoc" value="<%=StringEscapeUtils.escapeHtml4(docuser.getCodicedoc())%>"/>
                                                            <input type="hidden" name="tipologia" value="<%=StringEscapeUtils.escapeHtml4(docuser.getTipodoc())%>"/>
                                                            <input type="hidden" name="userdoc" value="<%=StringEscapeUtils.escapeHtml4(docuser.getUsername())%>"/>
                                                            <input type="hidden" name="note" value="<%=StringEscapeUtils.escapeHtml4(docuser.getNote())%>"/>
                                                            <button class="btn btn-sm btn-outline blue popovers" type="submit">
                                                                <i class='fa fa-file-o'></i></button>
                                                        </form>
                                                    </div>
                                                </td> 
                                            </tr>
                                            <%
                                                }
                                                ArrayList<DocumentiDocente> dubd = ActionB.listaDocUserBandoDocenti(username, false);
                                                for (int i = 0; i < dubd.size(); i++) {
                                            %>
                                            <tr>
                                                <td>CVD_<%=StringEscapeUtils.escapeHtml4(dubd.get(i).getCoddoc())%></td> 
                                                <td class="uppercase">Curriculum Vitae, sottoscritto con firma leggibile</td> 
                                                <td>Docente: <%=StringEscapeUtils.escapeHtml4(dubd.get(i).getNomecognome())%></td> 
                                                <td><%=Utility.formatStringtoStringDate(StringEscapeUtils.escapeHtml4(dubd.get(i).getData()))%></td>
                                                <td>
                                                    <div class="clearfix">
                                                        <form role="form" action="<%=request.getContextPath() + "/Download?action=docbandoconsrupB1"%>" method="post" target="_blank">
                                                            <input type="hidden" name="username" value="<%=StringEscapeUtils.escapeHtml4(username)%>"/>
                                                            <input type="hidden" name="indice" value="<%=StringEscapeUtils.escapeHtml4(dubd.get(i).getCoddoc())%>"/>
                                                            <input type="hidden" name="cod" value="CV"/>
                                                            <button class="btn btn-sm btn-outline blue popovers" type="submit">
                                                                <i class='fa fa-file-o'></i></button>
                                                        </form>
                                                    </div>

                                                </td> 
                                            </tr>
                                            <tr>
                                                <td>ALB1_<%=StringEscapeUtils.escapeHtml4(dubd.get(i).getCoddoc())%></td> 
                                                <td>TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE</td> 
                                                <td>Docente: <%=StringEscapeUtils.escapeHtml4(dubd.get(i).getNomecognome())%></td>  
                                                <td><%=Utility.formatStringtoStringDate(StringEscapeUtils.escapeHtml4(dubd.get(i).getData()))%></td>
                                                <td>
                                                    <div class="clearfix">
                                                        <form role="form" action="<%=StringEscapeUtils.escapeHtml4(request.getContextPath()) + "/Download?action=docbandoconsrupB1"%>" method="post" target="_blank">
                                                            <input type="hidden" name="username" value="<%=StringEscapeUtils.escapeHtml4(username)%>"/>
                                                            <input type="hidden" name="indice" value="<%=StringEscapeUtils.escapeHtml4(dubd.get(i).getCoddoc())%>"/>
                                                            <input type="hidden" name="cod" value="ALB1"/>
                                                            <button class="btn btn-sm btn-outline blue popovers" type="submit">
                                                                <i class='fa fa-file-o'></i></button>
                                                        </form>
                                                    </div>
                                                </td> 
                                            </tr>
                                            <tr>
                                                <td>DRDC_<%=StringEscapeUtils.escapeHtml4(dubd.get(i).getCoddoc())%></td> 
                                                <td class="uppercase">Documento di identit&#224;, in corso di validit&#224;</td> 
                                                <td>Docente: <%=StringEscapeUtils.escapeHtml4(dubd.get(i).getNomecognome())%></td>  
                                                <td><%=Utility.formatStringtoStringDate(StringEscapeUtils.escapeHtml4(dubd.get(i).getData()))%></td>
                                                <td>
                                                    <div class="clearfix">
                                                        <form role="form" action="<%=request.getContextPath() + "/Download?action=docbandoconsrupB1"%>" method="post" target="_blank">
                                                            <input type="hidden" name="username" value="<%=StringEscapeUtils.escapeHtml4(username)%>"/>
                                                            <input type="hidden" name="indice" value="<%=StringEscapeUtils.escapeHtml4(dubd.get(i).getCoddoc())%>"/>
                                                            <input type="hidden" name="cod" value="DR"/>
                                                            <button class="btn btn-sm btn-outline blue popovers" type="submit">
                                                                <i class='fa fa-file-o'></i></button>
                                                        </form>
                                                    </div>

                                                </td> 
                                            </tr>
                                            <%}
                                            %>
                                        </tbody>
                                    </table>
                                    <form role="form" action="<%=request.getContextPath() + "/Download?action=zipdomanda"%>" method="post" target="_blank">
                                        <input type="hidden" name="userdoc" value="<%=StringEscapeUtils.escapeHtml4(username)%>"/>
                                        <button  type="submit" class="btn red btn-outline "> <i class="fa fa-download"></i> Scarica ZIP</button>
                                    </form>  
                                    <%if (request.getParameter("esito") != null) {
                                            String esi = request.getParameter("esito");
                                            if (esi.equals("ko1")) {%>
                                    <br>
                                    <div class="alert alert-danger">
                                        <i class="fa fa-exclamation-triangle"></i> 
                                        <strong>Errore!</strong> Impossibile creare file .zip degli allegati. Riprovare.
                                    </div>
                                    <%}

                                        }%>

                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->
            <!-- END QUICK SIDEBAR -->
            <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->



        <script type="text/javascript" src="assets/soop/js/jquery-1.10.1.min.js"></script>
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