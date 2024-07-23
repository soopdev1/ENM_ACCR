<%-- 
    Document   : bando_index2
    Created on : 28-lug-2017, 15.43.51
    Author     : rcosco
--%>

<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="rc.soop.entity.Docuserbandi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.soop.action.Liste"%>
<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.action.Constant"%>
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
        <script src="assets/soop/js/moment.js" type="text/javascript"></script>

        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 

        <%
            String bandorif = Utility.checkAttribute(session,"bandorif");
            String username = Utility.checkAttribute(session,"username");

            boolean isAnnullata = ActionB.domandaAnnullata(bandorif, username);
            String descbando = ActionB.getDescrizioneBando(bandorif);
            String scabando = ActionB.getScadenzaBando(bandorif);
            boolean isDomandaPresente = ActionB.isDomandaPresente(bandorif, username);
            boolean statoDomanda = ActionB.getStatoDomanda(username);
            String inviodomanda_presente = ActionB.getStatoDomandaInviata(username);
            String decretodomanda = ActionB.getDecretoDomandaInviata(username);
            String protocollo = ActionB.getProtocolloDomandaInviata(username);
            String datainvio = ActionB.getDataInvioDomanda(username);

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

        %>
        <script type="text/javascript">
            function confirmsend() {
                document.getElementById("confirmsend").className = document.getElementById("confirmsend").className + " in";
                document.getElementById("confirmsend").style.display = "block";
                return false;
            }
            function confcanc() {
                document.getElementById("confirmcanc").className = document.getElementById("confirmcanc").className + " in";
                document.getElementById("confirmcanc").style.display = "block";
                return false;
            }

            function confirmrem(nameform) {
                document.getElementById("confirmremsi").onclick = function () {
                    submitfor(nameform);
                };
                document.getElementById("confirmrem").className = document.getElementById("confirmrem").className + " in";
                document.getElementById("confirmrem").style.display = "block";
                return false;
            }

            function confirmremAllegatoA(nameform) {
                document.getElementById("confirmremsi").onclick = function () {
                    submitfor(nameform);
                };
                document.getElementById("confirmremAllegatoA").className = document.getElementById("confirmremAllegatoA").className + " in";
                document.getElementById("confirmremAllegatoA").style.display = "block";
                return false;
            }

            function confirmremAllegatoB(nameform) {
                document.getElementById("confirmremsi").onclick = function () {
                    submitfor(nameform);
                };
                document.getElementById("confirmremAllegatoB").className = document.getElementById("confirmremAllegatoB").className + " in";
                document.getElementById("confirmremAllegatoB").style.display = "block";
                return false;
            }

            function confirmremAllegatoC2(nameform) {
                document.getElementById("confirmremsiC2").onclick = function () {
                    submitfor(nameform);
                };
                document.getElementById("confirmremAllegatoC2").className = document.getElementById("confirmremAllegatoC2").className + " in";
                document.getElementById("confirmremAllegatoC2").style.display = "block";
                return false;
            }




            function confirmremDef(nameform) {
                document.getElementById("confirmremsiDef").onclick = function () {
                    submitfor(nameform);
                };
                document.getElementById("confirmremDef").className = document.getElementById("confirmremDef").className + " in";
                document.getElementById("confirmremDef").style.display = "block";
                return false;
            }

            function submitfor(nameform) {
                document.forms[nameform].submit();
            }
            function dismiss(name) {
                document.getElementById(name).className = "modal fade";
                document.getElementById(name).style.display = "none";
            }

            function clitoastr(cl) {
                document.getElementById(cl).click();
            }
            function clierr() {
                document.getElementById('showtoast2').click();
            }

            function controlladataBando() {
                var ch1 = moment('<%=StringEscapeUtils.escapeHtml4(scabando)%>', 'DD/MM/YYYY HH:mm:ss');
                var limitdate = moment();
                if (limitdate.isSameOrAfter(ch1)) {
                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                    document.getElementById('errorlarge').style.display = "block";
                    document.getElementById('errorlargetext').innerHTML = "Il Bando è scaduto in data " + "<%=StringEscapeUtils.escapeHtml4(scabando)%>" + " non è possbile inviare la domanda.";
                    return false;
                }
                submitfor('fsend');
            }
            function closeanother(attuale) {
                var cusid_ele = document.getElementsByClassName('task-list');
                for (var i = 0; i < cusid_ele.length; ++i) {
                    var item = cusid_ele[i];
                    if (item.id !== attuale) {
                        item.className = "task-list panel-collapse collapse";
                    }
                }
            }

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

            function confirmRemConvenzioni(nameform) {
                document.getElementById("confirmRemConvenzionisi").onclick = function () {
                    eseguiForm('Operazioni', {'tipodoc': nameform, 'username': '<%=username%>', 'action': 'eliminaconv'});
                };
                document.getElementById("confirmRemConvenzioni").className = document.getElementById("confirmRemConvenzioni").className + " in";
                document.getElementById("confirmRemConvenzioni").style.display = "block";
                return false;
            }

            function confirmRemConvenzioni1() {
                document.getElementById("confirmRemConvenzioni1si").onclick = function () {
                    eseguiForm('Operazioni', {'tipodoc': 'MOD1', 'username': '<%=username%>', 'action': 'eliminaconv'});
                };
                document.getElementById("confirmRemConvenzioni1").className = document.getElementById("confirmRemConvenzioni1").className + " in";
                document.getElementById("confirmRemConvenzioni1").style.display = "block";
                return false;
            }

            function confirmRemConvenzioni2() {
                document.getElementById("confirmRemConvenzioni2si").onclick = function () {
                    eseguiForm('Operazioni', {'tipodoc': 'MOD2', 'username': '<%=username%>', 'action': 'eliminaconv'});
                };
                document.getElementById("confirmRemConvenzioni2").className = document.getElementById("confirmRemConvenzioni2").className + " in";
                document.getElementById("confirmRemConvenzioni2").style.display = "block";
                return false;
            }

            function confirmSendConvenzione() {
                document.getElementById("inviaConvenzioniConferma").onclick = function () {
                    eseguiForm('Operazioni', {'username': '<%=username%>', 'action': 'sendConvenzioni'});
                };
                document.getElementById("inviaConvenzioni").className = document.getElementById("inviaConvenzioni").className + " in";
                document.getElementById("inviaConvenzioni").style.display = "block";
                return false;
            }

        </script>
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>

    </head>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-closed">
        <%@include file="menu/header.jsp" %>
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
                    <div id="inviaConvenzioni" class="modal fade" tabindex="-1" data-backdrop="confirmrem" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma invio convenzioni</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler inviare i documenti all'Ente Microcredito?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" id="inviaConvenzioniConferma"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('inviaConvenzioni');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmRemConvenzioni" class="modal fade" tabindex="-1" data-backdrop="confirmrem" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione documento</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario caricare nuovamente il documento.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" id="confirmRemConvenzionisi"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmRemConvenzioni');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmRemConvenzioni1" class="modal fade" tabindex="-1" data-backdrop="confirmrem" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione documento</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario caricare nuovamente il documento.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" id="confirmRemConvenzioni1si"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmRemConvenzioni1');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmRemConvenzioni2" class="modal fade" tabindex="-1" data-backdrop="confirmrem" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione documento</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario caricare nuovamente il documento.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" id="confirmRemConvenzioni2si"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmRemConvenzioni2');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmcanc" class="modal fade" tabindex="-1" data-backdrop="confirmcanc" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma cancellazione domanda</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler procedere con la cancellazione?<br>
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" onclick="return submitfor('fann');"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmcanc');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmsend" class="modal fade" tabindex="-1" data-backdrop="confirmsend" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma invio domanda</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler procedere con l'invio?<br>
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green-jungle" onclick="return controlladataBando();"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmsend');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmrem" class="modal fade" tabindex="-1" data-backdrop="confirmrem" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione documento</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario caricare nuovamente il documento.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green"  id="confirmremsi"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmrem');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmremAllegatoA" class="modal fade" tabindex="-1" data-backdrop="confirmremAllegatoA" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione dati</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario reinserire i dati dell'allegato A, B e B1 in quanto i dati inseriti in questa fase sono propedeutici per gli allegati indicati.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green"  id="confirmremsi" onclick="return document.getElementById('f5DONLA').submit();"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmremAllegatoA');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmremAllegatoB" class="modal fade" tabindex="-1" data-backdrop="confirmremAllegatoB" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione dati</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario reinserire i dati dell'allegato B e B1 in quanto i dati inseriti in questa fase sono propedeutici per gli allegati indicati.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green"  id="confirmremsi" onclick="return document.getElementById('f6DONLB').submit();"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmremAllegatoB');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmremAllegatoC2" class="modal fade" tabindex="-1"
                         data-backdrop="confirmremAllegatoC2" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione dati</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; necessario reinserire i dati.</b></u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" id="confirmremsiC2" onclick="return document.getElementById('f5MOD2').submit();"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmremAllegatoC2');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="confirmremDef" class="modal fade" tabindex="-1" data-backdrop="confirmremDef" data-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Conferma eliminazione documento</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Sei sicuro di voler eliminare il documento selezionato?<br> 
                                        <u><b>
                                                L'operazione non potr&#224; pi&#249; essere annullata e sar&#224; 
                                                necessario caricare nuovamente tutti i documenti finora caricati,
                                                anche quelli degli step successivi.
                                            </b>
                                        </u>
                                    </p>
                                </div>
                                <div class="modal-footer" id="groupbtn2">
                                    <button type="button" class="btn green" id="confirmremsiDef"><i class="fa fa-check"></i> SI</button>
                                    <button type="button" data-dismiss="modal" class="btn red" onclick="return dismiss('confirmremDef');"><i class="fa fa-times"></i> NO</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="errorlarge" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                    <h4 class="modal-title font-red uppercase"><b>Messaggio di errore</b></h4>
                                </div>
                                <div class="modal-body" id="errorlargetext">ERRORE</div>
                                <div class="modal-footer">
                                    <button type="button" class="btn dark btn-outline" onclick="return dismiss('errorlarge');" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <div id="myModal" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-lg">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Step 2 - Selezionare una delle due opzioni disponibili</h4>
                                </div>
                                <div class="modal-body">
                                    <p><a href="bando_onlinenew.jsp" class="btn green"> Compilare dati di dettaglio del risparmio energetico percentuale atteso </a></p>
                                    <br>
                                    <p><button class="btn blue" data-toggle="modal" data-dismiss="modal" data-target="#myModal2">Passare direttamente all'inserimento dei soli dati contenuti nella relazione progettuale </button></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn red" data-dismiss="modal">Chiudi</button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <%if (!es.equals("")) {%>
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
                    <%}
                        Liste li = new Liste(bandorif, username);
                        int obbligatori = 0;
                        int presenti = 0;

                        ArrayList<Docbandi> lid1 = li.getLid1();
                        ArrayList<Docbandi> lidCONV = li.getLid2();
                        ArrayList<Docuserbandi> lid2 = li.getLidUser();

                        Domandecomplete doco = ActionB.isDomandaCompletaConsolidata(bandorif, username);
                        boolean mod = true;
                        if (doco != null) {
                            // mod = false;
                        }
                        int ind = 0;
                        for (int i = 0; i < lid1.size(); i++) {
                            boolean multiplopresente = false;
                            for (int j = 0; j < lid2.size(); j++) {
                                if (lid2.get(j).getCodicedoc().equals(lid1.get(i).getCodicedoc())) {
                                    if (lid1.get(i).getObbl().equals("1")) {
                                        if (lid1.get(i).getCollegati().equals("1")) {
                                            multiplopresente = true;
                                        } else {
                                            presenti++;
                                        }
                                    }
                                }
                            }
                            if (multiplopresente) {
                                presenti++;
                            }
                        }
                        for (int i = 0; i < lid1.size(); i++) {
                            if (lid1.get(i).getObbl().equals("1")) {
                                obbligatori++;
                            }
                            for (int j = 0; j < lid2.size(); j++) {
                                if (lid2.get(j).getCodicedoc().equals(lid1.get(i).getCodicedoc())) {
                                    ind = i;
                                }
                            }
                        }
                        double denom = (double) obbligatori;
                        double num = (double) presenti;
                        double perc = (num / denom) * 100;
                        int prc = (int) perc;
                        if (prc > 100) {
                            prc = 100;
                        }
                        boolean abilitainvio = prc == 100;
                        boolean esisteAllegatoA = ActionB.esisteAllegatoA(username);
                        boolean esisteAllegatoB = ActionB.esisteAllegatoB(username);
                        boolean esisteAllegatoB1 = ActionB.esisteAllegatoB1(username);
                        boolean domandaCompleta = ActionB.verificaDomandaCompleta(username);
                    %>

                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
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
                    <%if (isAnnullata) {%>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert alert-danger" style="text-align: center;">
                                <strong>Attenzione! La sua domanda &#232; stata annullata, nessuna operazione disponibile.</strong>
                            </div>
                        </div>
                    </div>
                    <%} else {
                        boolean convenzioneinviata = ActionB.verificaInvioConvenzione(username);
                        String datainvioconvenzione = ActionB.getDataInvioConvenzione(username);
                        String datafirmaroma = ActionB.getDatafirmaConvenzioneROMA(username);
                        boolean convenzionefirmataROMA = !ActionB.getConvenzioneROMA(username).trim().equals("");
                        if (!inviodomanda_presente.equals("")) {

                            String alert = "alert-info";
                            String txt_alert = "Domanda di partecipazione inviata il " + datainvio + ". ";

                            if (inviodomanda_presente.equals("S")) {
                                alert = "alert-info";
                                txt_alert += "La domanda &#232; in attesa di essere processata.";
                            } else if (inviodomanda_presente.equals("A")) {
                                alert = "alert-success";
                                txt_alert += "La domanda &#232; stata <u>accettata</u>. <b>protocollo</b>: " + protocollo + " - <b>Determina</b>: " + decretodomanda;
                                if (convenzionefirmataROMA) {
                                    //txt_alert += "<br><u><b>&#200; disponibile La convenzione controfirmata dall'Ente Nazionale Microcredito. Il percorso di accreditamento &#232; stato completato con successo.</b><u>";
                                    txt_alert += "<br><u><b>IN DATA " + datafirmaroma + " &#200; STATA CONTROFIRMATA LA CONVENZIONE DALL’ENM, SCARICABILE SELEZIONANDO IL PULSANTE VERDE SOTTOSTANTE. A BREVE RICEVER&#192; ISTRUZIONI PER RICHIEDERE AUTORIZZAZIONE AD AVVIARE IL PRIMO PERCORSO FORMATIVO.</b><u>";
                                } else if (convenzioneinviata) {
                                    txt_alert += "<br><u><b>La convenzione &#232; stata inviata all'Ente Nazionale Microcredito in data: " + datainvioconvenzione + ".</b><u>";
                                }

                            } else if (inviodomanda_presente.equals("R")) {
                                alert = "alert-danger";
                                txt_alert += "La domanda &#232; stata <u>respinta</u>. <b>Determina</b>: " + decretodomanda;
                            }


                    %>
                    <div class="row">
                        <div class="col-md-12"> 
                            <div class="alert <%=alert%> uppercase">
                                <%=StringEscapeUtils.escapeHtml4(txt_alert)%>
                            </div>
                        </div>
                    </div>

                    <%

                        }

                        String tipeexp = "collapse";
                        String collapsed = "";

                        String conv_tipeexp = "collapse";
                        String conv_collapsed = "";

                        if (statoDomanda) {
                            tipeexp = "expand";
                            collapsed = "portlet-collapsed";
                            Docbandi doc_fase1 = Utility.estraidaLista(lidCONV, "CONV");
                            Docbandi doc_fase2 = Utility.estraidaLista(lidCONV, "MOD1");
                            Docbandi doc_fase3 = Utility.estraidaLista(lidCONV, "MOD2");
                            Docbandi doc_fase4 = Utility.estraidaLista(lidCONV, "MOD3");
                            String sog_tipo = ActionB.getTipoSoggetto(username);
                            int totali_conv = 4;
                            if (sog_tipo.equals("soggettosingolo")) {
                                totali_conv = 3;
                            }
                            boolean convprontaperinvio = (ActionB.countDocumentConvenzioni(username) == totali_conv) && !convenzioneinviata;
                            boolean conv_fase1 = ActionB.verPresenzaConvenzioni(username, doc_fase1.getCodicedoc());
                            boolean conv_fase2 = ActionB.verPresenzaConvenzioni(username, doc_fase2.getCodicedoc());
                            boolean conv_fase3 = ActionB.verPresenzaConvenzioni(username, doc_fase3.getCodicedoc());
                            boolean conv_fase4 = ActionB.verPresenzaConvenzioni(username, doc_fase4.getCodicedoc());

                            int presenti_conv = 0;

                            if (conv_fase1) {
                                presenti_conv++;
                            }
                            if (conv_fase2) {
                                presenti_conv++;
                            }
                            if (conv_fase3) {
                                presenti_conv++;
                            }
                            if (conv_fase4) {
                                presenti_conv++;
                            }

                            if (convenzionefirmataROMA
                                    || convenzioneinviata) {
                                conv_tipeexp = "expand";
                                conv_collapsed = "portlet-collapsed";
                            }


                    %>
                    <div class="row">
                        <div class="col-md-12"> 
                            <div class="row">
                                <div class="col-md-9"> 
                                    <div class="portlet light bordered">
                                        <div class="portlet-title uppercase">
                                            <div class="caption font-dark"><i class="fa fa-pencil-square-o font-dark"></i> Stato avanzamento INVIO CONVENZIONE</div>
                                            <div class="tools">
                                                <a href="javascript:;" class="<%=conv_tipeexp%>" data-original-title="" title=""></a>
                                            </div>
                                        </div>
                                        <div class="portlet-body <%=conv_collapsed%>">
                                            <div class="mt-element-list">
                                                <div class="mt-list-head list-todo">
                                                    <div class="list-head-title-container">
                                                        <div class="list-head-count">
                                                            <div class="list-head-count-item font-green-jungle popovers" data-trigger="hover" 
                                                                 data-container="body" data-placement="right" data-content="STEP COMPLETATI">
                                                                <i class="fa fa-check font-green-jungle"></i> <%=presenti_conv%></div>
                                                            <div class="list-head-count-item font-red popovers"data-trigger="hover" 
                                                                 data-container="body" data-placement="right" data-content="STEP DA COMPLETARE">
                                                                <i class="fa fa-hourglass-half font-red "></i> <%=(totali_conv - presenti_conv)%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mt-list-container list-todo">
                                                    <div class="list-todo-line dark"></div>
                                                    <ul>
                                                        <%
                                                            for (int i = 1; i < (totali_conv + 1); i++) {
                                                                String tipol = "-";
                                                                String titolo = "";
                                                                String info = "";
                                                                boolean pres = false;
                                                                String linkscarica = "";
                                                                String linkmodello = "";
                                                                String linkupload = "";

                                                                if (i == 1) {
                                                                    titolo = doc_fase1.getTitolo();
                                                                    info = doc_fase1.getInfo();
                                                                    tipol = "CONV";
                                                                    if (conv_fase1) {
                                                                        pres = true;
                                                                        linkscarica = "Download?action=viewFileConvenzioni&codicedoc=" + tipol;
                                                                    } else {
                                                                        if (!doc_fase1.getDownload().equals("-")) {
                                                                            linkmodello = "Download?ctrl=1&action=downconv";
                                                                            linkupload = "bando_updocacc.jsp?tipodoc=" + tipol;
                                                                        }
                                                                    }
                                                                } else if (i == 2) {
                                                                    titolo = doc_fase2.getTitolo();
                                                                    info = doc_fase2.getInfo();
                                                                    tipol = "MOD1";
                                                                    if (conv_fase2) {
                                                                        pres = true;
                                                                        linkscarica = "Download?action=viewFileConvenzioni&codicedoc=" + tipol;
                                                                    } else {
                                                                        if (!doc_fase2.getDownload().equals("-")) {
                                                                            linkmodello = "Download?ctrl=2&action=downconv";
                                                                            linkupload = "bando_updocacc.jsp?tipodoc=" + tipol;
                                                                        }
                                                                    }
                                                                } else if (i == 3) {
                                                                    titolo = doc_fase3.getTitolo();
                                                                    info = doc_fase3.getInfo();
                                                                    tipol = "MOD2";
                                                                    if (conv_fase3) {
                                                                        pres = true;
                                                                        linkscarica = "Download?action=viewFileConvenzioni&codicedoc=" + tipol;
                                                                    } else {
                                                                        if (!doc_fase3.getDownload().equals("-")) {
                                                                            linkmodello = "Download?ctrl=3&action=downconv";
                                                                            linkupload = "bando_updocacc.jsp?tipodoc=" + tipol;
                                                                        }
                                                                    }
                                                                } else if (i == 4) {
                                                                    titolo = doc_fase4.getTitolo();
                                                                    info = doc_fase4.getInfo();
                                                                    tipol = "MOD3";
                                                                    linkmodello = "-";
                                                                    linkupload = "bando_updocacc.jsp?tipodoc=" + tipol;
                                                                    if (conv_fase4) {
                                                                        pres = true;
                                                                        linkscarica = "Download?action=viewFileConvenzioni&codicedoc=" + tipol;
                                                                    }
                                                                }

                                                                String fontcolor = "font-red";
                                                                String badgecolor = "badge-danger";
                                                                String color = "red";
                                                                String done = "";
                                                                String pres_string = "<i class='fa fa-times'></i>";
                                                                String in = "in";

                                                                if (pres) {
                                                                    fontcolor = "font-green";
                                                                    badgecolor = "badge-greensucc";
                                                                    color = "green-jungle";
                                                                    done = "done";
                                                                    pres_string = "<i class='fa fa-check'></i>";
                                                                    in = "";
                                                                }


                                                        %>

                                                        <li class="mt-list-item" data-close-others="true">
                                                            <div class="list-todo-icon bg-white <%=fontcolor%>">
                                                                <div class="badge <%=badgecolor%> bold"><%=i%></div>
                                                            </div>
                                                            <div class="list-todo-item <%=color%>">
                                                                <a class="list-toggle-container font-white" data-toggle="collapse" href="#taskcv-<%=i%>">
                                                                    <div class="list-toggle <%=done%> uppercase">
                                                                        <div class="row">
                                                                            <div class="col-md-12">
                                                                                <div class="col-md-11">
                                                                                    <div class="list-toggle-title bold "><%=StringEscapeUtils.escapeHtml4(titolo)%></div>
                                                                                </div>
                                                                                <div class="col-md-1">
                                                                                    <div class="badge <%=badgecolor%> pull-right bold"><%=pres_string%></div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                                <div class="task-list panel-collapse collapse <%=in%>" id="taskcv-<%=i%>">
                                                                    <ul>
                                                                        <li class="task-list-item <%=done%>">
                                                                            <p><%=StringEscapeUtils.escapeHtml4(info)%></p>
                                                                        </li>
                                                                    </ul>
                                                                    <hr>
                                                                    <div class="task-footer bordered">
                                                                        <div class="row">
                                                                            <div class="col-md-4">
                                                                                <%if (pres) {%>
                                                                                <a class="btn btn-outline green-jungle" href="<%=linkscarica%>">
                                                                                    Scarica Documento <i class="fa fa-download"></i>
                                                                                </a>
                                                                                <%} else {
                                                                                    if (!linkmodello.equals("-")) {
                                                                                %>
                                                                                <a class="btn btn-outline green-jungle" href="<%=linkmodello%>">
                                                                                    Scarica Modello <i class="fa fa-download"></i>
                                                                                </a>
                                                                                <%}
                                                                            }%>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <%if (pres && !convenzioneinviata) {%>
                                                                                <a class="btn btn-outline red" onclick="return confirmRemConvenzioni('<%=tipol%>');">
                                                                                    Elimina <i class="fa fa-trash"></i>
                                                                                </a>                                                       
                                                                                <%} else if (!pres) {%>                                                                                
                                                                                <a class="btn btn-outline red"  href="<%=linkupload%>">
                                                                                    Carica <i class="fa fa-upload"></i>
                                                                                </a>                                                                                    
                                                                                <%}%>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <%}%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <form id="f5MOD2" name="f5MOD2" role="form" action="Operazioni?action=remdatiAllegatoC2" method="post"></form>
                                <%
                                    if (convprontaperinvio) {
                                %>
                                <div class="col-md-3">
                                    <div class="portlet light">
                                        <a  class="mt-element-list popovers" style="text-decoration: none;"
                                            onclick="return document.getElementById('fsendb').click();"
                                            data-trigger="hover" data-container="body" data-placement="bottom"
                                            data-content="Invia la Convenzione ed i suoi allegati ad Ente Microcredito" 
                                            data-original-title="Invio definitivo della Convenzione">
                                            <div class="mt-list-head list-news font-white bg-yellow" 
                                                 onclick="return confirmSendConvenzione();">
                                                <div class="list-head-title-container">
                                                    <br>
                                                    <h2 class="list-title uppercase" ><i class="fa fa-save" ></i> INVIA CONVENZIONE</h2>
                                                    <br>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <%} else if (convenzionefirmataROMA) {%>
                                <div class="col-md-3">
                                    <div class="portlet light">
                                        <a target="_blank" href="Download?action=docbandoconsConv" class="mt-element-list popovers" style="text-decoration: none;"
                                           data-trigger="hover" data-container="body" data-placement="bottom"
                                           data-content="DOWNLOAD DELLA CONVENZIONE CONTROFIRMATA DA ENTE NAZIONALE MICROCREDITO" 
                                           data-original-title="SCARICA">
                                            <div class="mt-list-head list-news font-white bg-green-jungle">
                                                <div class="list-head-title-container">
                                                    <br>
                                                    <h2 class="list-title uppercase" ><i class="fa fa-file" ></i> SCARICA CONVENZIONE</h2>
                                                    <br>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <%}%>                    
                                </div>
                            </div>
                        </div>
                        <%}%>
                        <div class="row">
                            <div class="col-md-12">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <!--SEZIONE DOMANDA-->
                            <div class="row">
                                <div class="col-md-12"> 
                                    <div class="col-md-9"> 
                                        <div class="portlet light bordered">
                                            <div class="portlet-title uppercase">
                                                <div class="caption font-dark"><i class="fa fa-pencil-square-o font-dark"></i> Stato avanzamento domanda</div>
                                                <div class="tools">
                                                    <a href="javascript:;" class="<%=tipeexp%>" data-original-title="" title=""></a>
                                                </div>
                                            </div>
                                            <div class="portlet-body <%=collapsed%>">
                                                <div class="mt-element-list">
                                                    <div class="mt-list-head list-todo">
                                                        <div class="list-head-title-container">
                                                            <div class="list-head-count">
                                                                <div class="list-head-count-item font-green-jungle popovers" data-trigger="hover" data-container="body" data-placement="right" data-content="STEP COMPLETATI">
                                                                    <i class="fa fa-check font-green-jungle"></i> <%=presenti%></div>
                                                                <div class="list-head-count-item font-red popovers"data-trigger="hover" 
                                                                     data-container="body" data-placement="right" data-content="STEP DA COMPLETARE">
                                                                    <i class="fa fa-hourglass-half font-red "></i> <%=(obbligatori - presenti)%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mt-list-container list-todo">
                                                        <div class="list-todo-line dark"></div>
                                                        <ul>
                                                            <%
                                                                for (int i = 0; i < lid1.size(); i++) {
                                                                    Docbandi dba = lid1.get(i);
                                                                    String tipol = "-";
                                                                    boolean pres = false;
                                                                    for (int j = 0; j < lid2.size(); j++) {
                                                                        Docuserbandi docuser = lid2.get(j);
                                                                        if (docuser.getCodicedoc().equals(dba.getCodicedoc())) {
                                                                            pres = true;
                                                                            tipol = docuser.getTipodoc();
                                                                            break;
                                                                        }
                                                                    }
                                                                    String fontcolor = "font-red";
                                                                    String badgecolor = "badge-danger";
                                                                    String color = "red";
                                                                    String done = "";
                                                                    String pres_string = "<i class='fa fa-times'></i>";
                                                                    if (pres) {
                                                                        fontcolor = "font-green";
                                                                        badgecolor = "badge-greensucc";
                                                                        color = "green-jungle";
                                                                        done = "done";
                                                                        pres_string = "<i class='fa fa-check'></i>";
                                                                    } else {
                                                                        if (!dba.getObbl().equals("1")) {
                                                                            fontcolor = "font-yellow-lemon";
                                                                            badgecolor = "badge-warning";
                                                                            color = "yellow-lemon";
                                                                        }
                                                                        if ((dba.getCodicedoc().equals("DONLA") && esisteAllegatoA) || (dba.getCodicedoc().equals("DONLB") && esisteAllegatoB)) {
                                                                            fontcolor = "";
                                                                            badgecolor = "badge-info";
                                                                            color = "blue";
                                                                            pres_string = "<i class='fa fa-hourglass-half'></i>";
                                                                        }

                                                                    }
                                                                    String in = "";

                                                                    if (ind == 0) {
                                                                        if (lid2.size() > 0) {
                                                                            if (i == ind + 1) {
                                                                                in = "in";
                                                                            }
                                                                        } else {
                                                                            if (i == ind) {
                                                                                in = "in";
                                                                            }
                                                                        }
                                                                    } else if (ind == (lid1.size() - 1)) {
                                                                        if (i == ind) {
                                                                            in = "in";
                                                                        }
                                                                    } else if (i == (ind + 1)) {
                                                                        in = "in";
                                                                    }
                                                            %>
                                                            <li class="mt-list-item" data-close-others="true">
                                                                <div class="list-todo-icon bg-white <%=fontcolor%>">
                                                                    <div class="badge <%=badgecolor%> bold"><%=(i + 1)%></div>
                                                                </div>
                                                                <div class="list-todo-item <%=color%>">
                                                                    <a class="list-toggle-container font-white" data-toggle="collapse" href="#task-<%=i%>" aria-expanded="false" data-close-others="true" onclick="return closeanother('task-<%=i%>')">
                                                                        <div class="list-toggle <%=done%> uppercase">
                                                                            <div class="row">
                                                                                <div class="col-md-12">
                                                                                    <div class="col-md-11">
                                                                                        <div class="list-toggle-title bold "><%=dba.getTitolo()%></div>
                                                                                    </div>
                                                                                    <div class="col-md-1">
                                                                                        <div class="badge <%=badgecolor%> pull-right bold"><%=pres_string%></div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                    <div class="task-list panel-collapse collapse <%=in%>" id="task-<%=i%>" aria-expanded="false" style="height: 0px;" data-close-others="true">
                                                                        <ul>
                                                                            <li class="task-list-item <%=done%>">
                                                                                <p><%=dba.getInfo()%></p>
                                                                            </li>
                                                                        </ul>
                                                                        <hr>
                                                                        <div class="task-footer bordered">
                                                                            <div class="row">
                                                                                <%
                                                                                    if (pres && mod) {
                                                                                        if (!domandaCompleta && (dba.getCodicedoc().equals("DONLA")
                                                                                                || dba.getCodicedoc().equals("DONLB")
                                                                                                || dba.getCodicedoc().equals("DOCR")
                                                                                                || dba.getCodicedoc().startsWith("DONL"))) {
                                                                                %>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline green-jungle" type="submit" onclick="return submitfor('f3<%=dba.getCodicedoc()%>');">
                                                                                        Scarica  <i class="fa fa-download"></i>
                                                                                    </button> 
                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline red" type="submit" onclick="return confirmrem('f4<%=dba.getCodicedoc()%>');">
                                                                                        Elimina <i class="fa fa-trash-o"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <%  } else {
                                                                                    if (domandaCompleta
                                                                                            && dba.getCodicedoc().equals("ALB1") || !domandaCompleta && dba.getCodicedoc().equals("ALB1")) {
                                                                                %>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline blue" type="submit" onclick="return submitfor('x1<%=dba.getCodicedoc()%>');">
                                                                                        Visualizza fascicolo/i documenti <i class="fa fa-database"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <%} else {%>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline green" type="submit" onclick="return submitfor('f3<%=dba.getCodicedoc()%>');">
                                                                                        Scarica <i class="fa fa-download"></i>
                                                                                    </button> 
                                                                                </div>
                                                                                <%}
                                                                                    }
                                                                                } else {
                                                                                    if (mod) {
                                                                                        if (dba.getCodicedoc().equals("DONLA")) {
                                                                                            if (esisteAllegatoA) {%>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline blue" type="submit" onclick="return confirmremAllegatoA('f5<%=dba.getCodicedoc()%>');">
                                                                                        Elimina Dati inseriti <i class="fa fa-trash-o"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline green-jungle" type="submit" onclick="return submitfor('f1<%=dba.getCodicedoc()%>');">
                                                                                        Scarica Documento <i class="fa fa-download"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline red" type="submit" onclick="return submitfor('f2<%=dba.getCodicedoc()%>');">
                                                                                        Carica <i class="fa fa-upload"></i>
                                                                                    </button> 
                                                                                </div>
                                                                                <%} else {%>
                                                                                <div class="col-md-4">
                                                                                    <form action="bando_onlinecomp2.jsp" method="POST">
                                                                                        <input type="hidden" name="allegato_A_B" value="A" />
                                                                                        <button class="btn btn-outline red" type="submit">
                                                                                            Compila <i class="fa fa-pencil-square-o"></i>
                                                                                        </button>  
                                                                                    </form>
                                                                                </div>
                                                                                <%}
                                                                                    }
                                                                                    if (dba.getCodicedoc().equals("DONLB")) {
                                                                                        if (esisteAllegatoB) {
                                                                                %>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline blue" type="submit" onclick="return confirmremAllegatoB('f6<%=dba.getCodicedoc()%>');">
                                                                                        Elimina Dati inseriti <i class="fa fa-trash-o"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline green-jungle" type="submit" onclick="return submitfor('f1<%=dba.getCodicedoc()%>');">
                                                                                        Scarica Documento <i class="fa fa-download"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <%if (esisteAllegatoB1) {%>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline red" type="submit" onclick="return submitfor('f2<%=dba.getCodicedoc()%>');">
                                                                                        Carica <i class="fa fa-upload"></i>
                                                                                    </button> 
                                                                                </div>
                                                                                <%}%>
                                                                                <%
                                                                                } else {
                                                                                    if (esisteAllegatoA) {
                                                                                %>

                                                                                <div class="col-md-4">
                                                                                    <form action="bando_onlinecomp2.jsp" method="POST">
                                                                                        <input type="hidden" name="allegato_A_B" value="B" />
                                                                                        <button class="btn btn-outline red" type="submit">
                                                                                            Compila <i class="fa fa-pencil-square-o"></i>
                                                                                        </button>  
                                                                                    </form>
                                                                                </div>
                                                                                <%}
                                                                                        }
                                                                                    }
                                                                                    if (dba.getCodicedoc().equals("ALB1")) {
                                                                                        if (esisteAllegatoB1) {
                                                                                %>

                                                                                <%
                                                                                } else if (esisteAllegatoB) {
                                                                                %>

                                                                                <div class="col-md-4">
                                                                                    <form action="bando_onlinecomp2.jsp" method="POST">
                                                                                        <input type="hidden" name="allegato_A_B" value="C" />
                                                                                        <button class="btn btn-outline red" type="submit">
                                                                                            Compila <i class="fa fa-pencil-square-o"></i>
                                                                                        </button>  
                                                                                    </form>
                                                                                </div>
                                                                                <% }
                                                                                    }
                                                                                    if (!dba.getDownload().equals("-") && !dba.getCodicedoc().equals("ALB1") && !dba.getCodicedoc().startsWith("DONLA") && !dba.getCodicedoc().equals("DONLB")) {%>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline green-jungle" type="submit" onclick="return submitfor('f1<%=dba.getCodicedoc()%>');">
                                                                                        Scarica Documento <i class="fa fa-download"></i>
                                                                                    </button> 
                                                                                </div>
                                                                                <%}
                                                                            if (!dba.getCodicedoc().equals("DONLA") && !dba.getCodicedoc().equals("DONLB") && !dba.getCodicedoc().equals("ALB1")) {%>
                                                                                <div class="col-md-4">
                                                                                    <button class="btn btn-outline red" type="submit" onclick="return submitfor('f2<%=dba.getCodicedoc()%>');">
                                                                                        Carica <i class="fa fa-upload"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <%}
                                                                                        }
                                                                                    }
                                                                                %>
                                                                                <form name="f1<%=dba.getCodicedoc()%>" role="form" action="Download?action=modellodoc"
                                                                                      method="post" target="_blank">
                                                                                    <input type="hidden" name="tipodoc" value="<%=dba.getCodicedoc()%>"/>
                                                                                </form>
                                                                                <form name="f2<%=dba.getCodicedoc()%>" role="form" action="bando_updoc.jsp" method="post">
                                                                                    <input type="hidden" name="tipodoc" value="<%=dba.getCodicedoc()%>"/>
                                                                                </form>
                                                                                <form name="f3<%=dba.getCodicedoc()%>" role="form" action="Download?action=docbando" method="post" target="_blank">
                                                                                    <input type="hidden" name="tipodoc" value="<%=dba.getCodicedoc()%>"/>
                                                                                    <input type="hidden" name="tipologia" value="<%=StringEscapeUtils.escapeHtml4(tipol)%>"/>
                                                                                </form>
                                                                                <form name="f4<%=dba.getCodicedoc()%>" role="form" action="Operazioni?action=remdoc" method="post">
                                                                                    <input type="hidden" name="tipodoc" value="<%=dba.getCodicedoc()%>"/>
                                                                                    <input type="hidden" name="tipologia" value="<%=StringEscapeUtils.escapeHtml4(tipol)%>"/>
                                                                                </form>
                                                                                <!--// ELEMINATA I DATI DI ALLEGATO A-->
                                                                                <form id="f5<%=dba.getCodicedoc()%>" name="f5<%=dba.getCodicedoc()%>" role="form" action="Operazioni?action=remdatiAllegatoA" method="post"></form>
                                                                                <!--// ELEMINATA I DATI DI ALLEGATO B-->
                                                                                <form id="f6<%=dba.getCodicedoc()%>" name="f6<%=dba.getCodicedoc()%>" role="form" action="Operazioni?action=remdatiAllegatoB" method="post"></form>
                                                                                <form name="x1<%=dba.getCodicedoc()%>" role="form" action="bando_onlinecomp2.jsp" method="post">
                                                                                    <input type="hidden" name="allegato_A_B" value="C"/>
                                                                                </form>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <%}%>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row ">
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">
                                                            <div class="row">
                                                                <%if (prc == 100) {%>
                                                                <form role="form" action="Download?action=zipdomanda" method="post" target="_blank">
                                                                    <input type="hidden" name="userdoc" value="<%=username%>"/>
                                                                    <button  type="submit" class="btn blue btn-block btn-outline "> <i class="fa fa-download"></i> Scarica l'intera domanda (.zip)</button>
                                                                </form>
                                                                <%}%>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4"></div>
                                                        <div class="col-md-4">
                                                            <div class="easy-pie-chart">
                                                                <div class="number visits" data-percent="<%=prc%>"><span><%=prc%></span>%</div>
                                                                Percentuale di completamento domanda
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <%

                                        String txts = "Invia domanda";
                                        String dis = "disabled";
                                        String classinvio = "bg-grey-silver";
                                        String datacontent1 = "IMPOSSIBILE INVIARE.";
                                        if (abilitainvio && !isDomandaPresente) {
                                            if (prc < 100) {
                                                txts = "Invia domanda (INCOMPLETA)";
                                                classinvio = "bg-yellow";
                                                datacontent1 = "Occorre allegare tutti i documenti obbligatori richiesti dal bando";
                                            } else {
                                                dis = "";
                                                if (mod == false) {
                                                    abilitainvio = false;
                                                    classinvio = "bg-grey-silver";
                                                    datacontent1 = "La domanda ed i suoi allegati sono stati già inviati.";
                                                } else {
                                                    classinvio = "bg-green-jungle";
                                                    datacontent1 = "La domanda ed i suoi allegati sono pronti per essere inviati.";
                                                }
                                            }
                                        }

                                        String txtann = "";
                                        if (doco == null || doco.getConsolidato().equals("0")) {
                                            txtann = "Consente di eliminare in maniera definitva la domanda e/o le operazioni effettuate.";
                                        } else {
                                            txtann = "Non è possibile annullare la domanda in quanto in fase di istruttoria.";
                                        }

                                    %>
                                    <div class="col-md-3">    
                                        <%if (abilitainvio && !isDomandaPresente) {%>
                                        <div class="row">
                                            <form role="form" name="fsend" id="fsend"
                                                  action="Operazioni?action=inviadomanda"
                                                  method="post" 
                                                  <%if (abilitainvio && !isDomandaPresente) {%>
                                                  onsubmit="return confirmsend();"
                                                  <%} else {%>
                                                  onsubmit="return false;"
                                                  <%}%>
                                                  >
                                                <div class="modal fade">
                                                    <button type="submit" id="fsendb" />
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="portlet light">
                                                        <a <%=dis%> class="mt-element-list popovers" style="text-decoration: none;" onclick="return document.getElementById('fsendb').click();"
                                                                    data-trigger="hover" data-container="body" data-placement="bottom"
                                                                    data-content="<%=datacontent1%>" 
                                                                    data-original-title="Invio definitivo della domanda di partecipazione">
                                                            <div class="mt-list-head list-news font-white <%=classinvio%>">
                                                                <div class="list-head-title-container">
                                                                    <br>
                                                                    <h2 class="list-title uppercase"><i class="fa fa-save"></i> <%=txts%></h2>
                                                                    <br>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <div class="col-md-9">
                                <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption font-blue"><i class="fa fa-info-circle font-blue"></i>Informazioni Bando</div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <p class="text-justify">
                                                    <strong>Il bando &#232; attivo.</strong> 
                                                </p>
                                                <p class="text-justify"> 
                                                    <strong >Nome bando: </strong> <%=StringEscapeUtils.escapeHtml4(descbando)%>.
                                                </p>
                                                <p class="text-justify">
                                                    <strong>Per la scadenza del bando, consultare il sito dell'Ente Nazionale per il microcredito.</strong>
                                                    <br>
                                                    <a href="https://www.microcredito.gov.it/gare-e-bandi-in-corso.html" target="_blank">https://www.microcredito.gov.it/gare-e-bandi-in-corso.html</a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 btn-group-devided">
                                            <%
                                                boolean avvisook = ActionB.getPath("pdf.avviso") != null;
                                                boolean guida2ok = ActionB.getPath("pdf.guidaconvenzione") != null;
                                                if (avvisook) {
                                            %>
                                            <a class="btn btn-outline blue" href="Download?action=avviso" target="_blank"><i class="fa fa-archive"></i> Scarica Avviso</a>
                                            <%}
                                                if (guida2ok) {
                                            %>
                                            <a class="btn btn-outline blue" href="Download?action=guidaConvenzioni" target="_blank"><i class="fa fa-file-pdf-o"></i> Guida alla firma della Convenzione</a>
                                            <%}%>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
             <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
        </div>
        <!-- END CONTENT -->
        <!-- BEGIN QUICK SIDEBAR -->
        <!-- END QUICK SIDEBAR -->

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
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
        <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>

        <script>
                                                            //window.onunload = function(){ $.get("LoginOperations?type=out"); }
        </script>

    </body>
</html>
<%}%>
