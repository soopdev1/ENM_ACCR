<%-- 
    Document   : bando_index2
    Created on : 28-lug-2017, 15.43.51
    Author     : rcosco
--%>

<%@page import="java.util.List"%>
<%@page import="rc.soop.entity.AllegatoB"%>
<%@page import="rc.soop.entity.Items"%>
<%@page import="rc.soop.entity.Prov_rc"%>
<%@page import="rc.soop.entity.Docenti"%>
<%@page import="rc.soop.entity.Domandecomplete"%>
<%@page import="rc.soop.entity.Docbandi"%>
<%@page import="rc.soop.entity.Docuserbandi"%>
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
        <link href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css"/>

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
        </script>
        <script type="text/javascript">
            <%
                String bandorif = Utility.checkAttribute(session,"bandorif");
                String username = Utility.checkAttribute(session,"username");
                String allegato_A_B = request.getParameter("allegato_A_B");
                Liste li = new Liste(bandorif, username);

                ArrayList<Prov_rc> province = li.getProvince();
                ArrayList<Prov_rc> reg = li.getReg();
                ArrayList<Items> titolistudio = li.getTitolistudio();
                ArrayList<Items> qualifiche = li.getQualifiche();
                ArrayList<Items> inquadr = li.getInquadr();
                ArrayList<Items> disponibilita = li.getDisponibilita();
                boolean statoDomanda = ActionB.getStatoDomanda(username);

            %>

            function controllaReg1() {
                var regexpMAIL = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                var tipologia = '<%=StringEscapeUtils.escapeHtml4(allegato_A_B)%>';
                var output = "0";
                if (tipologia === "A") {
                    var ch1 = document.getElementsByName("ch1")[0].checked;
                    var ch2 = document.getElementsByName("ch2")[0].checked;
                    var ch3 = document.getElementsByName("ch3")[0].checked;
                    var ch4 = document.getElementsByName("ch4")[0].checked;
                    var ch5 = document.getElementsByName("ch5")[0].checked;
                    var ch6 = document.getElementsByName("ch6")[0].checked;
                    var iscrizione = document.getElementById("iscrizione").value.trim();
                    var aule = document.getElementById("aule").value.trim() + "";

                    var ctrlAula1 = false;
                    var ctrlAula2 = false;
                    var ctrlAula3 = false;
                    var ctrlAula4 = false;
                    var ctrlAula5 = false;
                    var pec = document.getElementById("pec").value.trim();
                    var msg = "";
                    // CONTROLLO AULE

                    // AULA 1
                    var regioneaula = document.getElementById("regioneaula").value.trim();
                    var citta = document.getElementById("citta").value.trim();
                    var provincia = document.getElementById("provincia").value.trim();
                    var indirizzo = document.getElementById("indirizzo").value.trim();
                    var estremi = document.getElementById("estremi").value.trim();
                    var titolo = document.getElementById("titolo").value.trim();
                    var accreditamento = document.getElementById("accreditamento").value.trim();
                    var responsabile = document.getElementById("responsabile").value.trim();
                    var mailresponsabile = document.getElementById("mailresponsabile").value.trim();
                    var telresponsabile = document.getElementById("telresponsabile").value.trim();
                    var responsabileAmm = document.getElementById("responsabileAmm").value.trim();
                    var mailresponsabileAmm = document.getElementById("mailresponsabileAmm").value.trim();
                    var telresponsabileAmm = document.getElementById("telresponsabileAmm").value.trim();
                    // AULA 2
                    var regioneaula2 = document.getElementById("regioneaula2").value.trim();
                    var citta2 = document.getElementById("citta2").value.trim();
                    var provincia2 = document.getElementById("provincia2").value.trim();
                    var indirizzo2 = document.getElementById("indirizzo2").value.trim();
                    var estremi2 = document.getElementById("estremi2").value.trim();
                    var titolo2 = document.getElementById("titolo2").value.trim();
                    var accreditamento2 = document.getElementById("accreditamento2").value.trim();
                    var responsabile2 = document.getElementById("responsabile2").value.trim();
                    var mailresponsabile2 = document.getElementById("mailresponsabile2").value.trim();
                    var telresponsabile2 = document.getElementById("telresponsabile2").value.trim();
                    var responsabileAmm2 = document.getElementById("responsabileAmm2").value.trim();
                    var mailresponsabileAmm2 = document.getElementById("mailresponsabileAmm2").value.trim();
                    var telresponsabileAmm2 = document.getElementById("telresponsabileAmm2").value.trim();
                    // AULA 3
                    var regioneaula3 = document.getElementById("regioneaula3").value.trim();
                    var citta3 = document.getElementById("citta3").value.trim();
                    var provincia3 = document.getElementById("provincia3").value.trim();
                    var indirizzo3 = document.getElementById("indirizzo3").value.trim();
                    var estremi3 = document.getElementById("estremi3").value.trim();
                    var titolo3 = document.getElementById("titolo3").value.trim();
                    var accreditamento3 = document.getElementById("accreditamento3").value.trim();
                    var responsabile3 = document.getElementById("responsabile3").value.trim();
                    var mailresponsabile3 = document.getElementById("mailresponsabile3").value.trim();
                    var telresponsabile3 = document.getElementById("telresponsabile3").value.trim();
                    var responsabileAmm3 = document.getElementById("responsabileAmm3").value.trim();
                    var mailresponsabileAmm3 = document.getElementById("mailresponsabileAmm3").value.trim();
                    var telresponsabileAmm3 = document.getElementById("telresponsabileAmm3").value.trim();
                    // AULA 4
                    var regioneaula4 = document.getElementById("regioneaula4").value.trim();
                    var citta4 = document.getElementById("citta4").value.trim();
                    var provincia4 = document.getElementById("provincia4").value.trim();
                    var indirizzo4 = document.getElementById("indirizzo4").value.trim();
                    var estremi4 = document.getElementById("estremi4").value.trim();
                    var titolo4 = document.getElementById("titolo4").value.trim();
                    var accreditamento4 = document.getElementById("accreditamento4").value.trim();
                    var responsabile4 = document.getElementById("responsabile4").value.trim();
                    var mailresponsabile4 = document.getElementById("mailresponsabile4").value.trim();
                    var telresponsabile4 = document.getElementById("telresponsabile4").value.trim();
                    var responsabileAmm4 = document.getElementById("responsabileAmm4").value.trim();
                    var mailresponsabileAmm4 = document.getElementById("mailresponsabileAmm4").value.trim();
                    var telresponsabileAmm4 = document.getElementById("telresponsabileAmm4").value.trim();
                    // AULA 5
                    var regioneaula5 = document.getElementById("regioneaula5").value.trim();
                    var citta5 = document.getElementById("citta5").value.trim();
                    var provincia5 = document.getElementById("provincia5").value.trim();
                    var indirizzo5 = document.getElementById("indirizzo5").value.trim();
                    var estremi5 = document.getElementById("estremi5").value.trim();
                    var titolo5 = document.getElementById("titolo5").value.trim();
                    var accreditamento5 = document.getElementById("accreditamento5").value.trim();
                    var responsabile5 = document.getElementById("responsabile5").value.trim();
                    var mailresponsabile5 = document.getElementById("mailresponsabile5").value.trim();
                    var telresponsabile5 = document.getElementById("telresponsabile5").value.trim();
                    var responsabileAmm5 = document.getElementById("responsabileAmm5").value.trim();
                    var mailresponsabileAmm5 = document.getElementById("mailresponsabileAmm5").value.trim();
                    var telresponsabileAmm5 = document.getElementById("telresponsabileAmm5").value.trim();

                    if (ch1 === false && ch2 === false && ch3 === false && ch4 === false && ch5 === false) {
                        output = "1";
                        msg += "<span style='color:red;'>E' obbligatorio selezionare almeno una delle possibili voci del 'Punto 1'</span><br/>";
                    }

                    if (ch6 === true && iscrizione === "") {
                        output = "1";
                        msg += "<span style='color:red;'>E' obbligatorio copilare il campo 'n. di iscrizione'</span><br/>";
                    }
                    //PUNTO 4

                    if (pec === "" || !regexpMAIL.test(pec.trim())) {
                        output = "1";
                        msg += "<span style='color:red;'>E' obbligatorio indicare una email PEC valida</span><br/>";
                    }

                    if (aule === 1 || aule === "1" || aule === "01") {
                        ctrlAula1 = true;
                        ctrlAula2 = false;
                        ctrlAula3 = false;
                        ctrlAula4 = false;
                        ctrlAula5 = false;
                    }

                    if (aule === 2 || aule === "2" || aule === "02") {
                        ctrlAula1 = true;
                        ctrlAula2 = true;
                        ctrlAula3 = false;
                        ctrlAula4 = false;
                        ctrlAula5 = false;
                    }
                    if (aule === 3 || aule === "3" || aule === "03") {
                        ctrlAula1 = true;
                        ctrlAula2 = true;
                        ctrlAula3 = true;
                        ctrlAula4 = false;
                        ctrlAula5 = false;
                    }
                    if (aule === 4 || aule === "4" || aule === "04") {
                        ctrlAula1 = true;
                        ctrlAula2 = true;
                        ctrlAula3 = true;
                        ctrlAula4 = true;
                        ctrlAula5 = false;
                    }
                    if (aule === 5 || aule === "5" || aule === "05") {
                        ctrlAula1 = true;
                        ctrlAula2 = true;
                        ctrlAula3 = true;
                        ctrlAula4 = true;
                        ctrlAula5 = true;
                    }

                    if (ctrlAula1 === true) {
                        if (indirizzo === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Indirizzo'.</span><br/>";
                        }
                        if (citta === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Citt&#224;'.</span><br/>";
                        }
                        if (provincia === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Provincia'.</span><br/>";
                        }
                        if (regioneaula === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Regione'.</span><br/>";
                        }
                        if (estremi === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Estremi -Mq aula'.</span><br/>";
                        }
                        if (titolo === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Titolo di disponibilit&#224;'.</span><br/>";
                        }
                        if (accreditamento === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Accreditamento Regionale'.</span><br/>";
                        }
                        if (responsabile === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Nominativo responsabile'.</span><br/>";
                        }
                        if (mailresponsabile === "" || !regexpMAIL.test(mailresponsabile)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Mail Responsabile'.</span><br/>";
                        }
                        if (telresponsabile === "" || !$.isNumeric(telresponsabile)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Telefono Responsabile'.</span><br/>";
                        }
                        if (responsabileAmm === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Nominativo Referente Amministrativo'.</span><br/>";
                        }
                        if (mailresponsabileAmm === "" || !regexpMAIL.test(mailresponsabileAmm)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Mail Referente Amministrativo'.</span><br/>";
                        }
                        if (telresponsabileAmm === "" || !$.isNumeric(telresponsabileAmm)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 1. E' obbligatorio compilare il campo 'Telefono Referente Amministrativo'.</span><br/>";
                        }

                    }
                    if (ctrlAula2 === true) {
                        if (indirizzo2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Indirizzo'.</span><br/>";
                        }
                        if (citta2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Citt&#224;'.</span><br/>";
                        }
                        if (provincia2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Provincia'.</span><br/>";
                        }
                        if (regioneaula2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Regione'.</span><br/>";
                        }
                        if (estremi2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Estremi -Mq aula'.</span><br/>";
                        }

                        if (titolo2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Titolo di disponibilit&#224;'.</span><br/>";
                        }

                        if (accreditamento2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Accreditamento Regionale'.</span><br/>";
                        }
                        if (responsabile2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Nominativo responsabile'.</span><br/>";
                        }
                        if (mailresponsabile2 === "" || !regexpMAIL.test(mailresponsabile2)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Mail Responsabile'.</span><br/>";
                        }
                        if (telresponsabile2 === "" || !$.isNumeric(telresponsabile2)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Telefono Responsabile'.</span><br/>";
                        }

                        if (responsabileAmm2 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Nominativo referente Amministrativo'.</span><br/>";
                        }
                        if (mailresponsabileAmm2 === "" || !regexpMAIL.test(mailresponsabileAmm2)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Mail Referente Amministrativo'.</span><br/>";
                        }
                        if (telresponsabileAmm2 === "" || !$.isNumeric(telresponsabileAmm2)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 2. E' obbligatorio compilare il campo 'Telefono Referente Amministrativo'.</span><br/>";
                        }
                    }
                    if (ctrlAula3 === true) {
                        if (indirizzo3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Classe 3. E' obbligatorio compilare il campo 'Indirizzo'.</span><br/>";
                        }
                        if (citta3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Citt&#224;'.</span><br/>";
                        }
                        if (provincia3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Provincia'.</span><br/>";
                        }
                        if (regioneaula3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Regione'.</span><br/>";
                        }
                        if (estremi3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Estremi -Mq aula'.</span><br/>";
                        }
                        if (titolo3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Titolo di disponibilit&#224;'.</span><br/>";
                        }
                        if (accreditamento3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Accreditamento Regionale'.</span><br/>";
                        }
                        if (responsabile3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Nominativo responsabile'.</span><br/>";
                        }
                        if (mailresponsabile3 === "" || !regexpMAIL.test(mailresponsabile3)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Mail Responsabile'.</span><br/>";
                        }
                        if (telresponsabile3 === "" || !$.isNumeric(telresponsabile3)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Telefono Responsabile'.</span><br/>";
                        }
                        if (responsabileAmm3 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Nominativo referente Amministrativo'.</span><br/>";
                        }
                        if (mailresponsabileAmm3 === "" || !regexpMAIL.test(mailresponsabileAmm3)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Mail Referente Amministrativo'.</span><br/>";
                        }
                        if (telresponsabileAmm3 === "" || !$.isNumeric(telresponsabileAmm3)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 3. E' obbligatorio compilare il campo 'Telefono Referente Amministrativo'.</span><br/>";
                        }
                    }

                    if (ctrlAula4 === true) {
                        if (indirizzo4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Indirizzo'.</span><br/>";
                        }
                        if (citta4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Citt&#224;'.</span><br/>";
                        }
                        if (provincia4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Provincia'.</span><br/>";
                        }
                        if (regioneaula4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Regione'.</span><br/>";
                        }
                        if (estremi4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Estremi -Mq aula'.</span><br/>";
                        }

                        if (titolo4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Titolo di disponibilit&#224;'.</span><br/>";
                        }

                        if (accreditamento4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Accreditamento Regionale'.</span><br/>";
                        }
                        if (responsabile4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Nominativo responsabile'.</span><br/>";
                        }
                        if (mailresponsabile4 === "" || !regexpMAIL.test(mailresponsabile4)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Mail Responsabile'.</span><br/>";
                        }
                        if (telresponsabile4 === "" || !$.isNumeric(telresponsabile4)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Telefono Responsabile'.</span><br/>";
                        }
                        if (responsabileAmm4 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Nominativo referente Amministrativo'.</span><br/>";
                        }
                        if (mailresponsabileAmm4 === "" || !regexpMAIL.test(mailresponsabileAmm4)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Mail Referente Amministrativo'.</span><br/>";
                        }
                        if (telresponsabileAmm4 === "" || !$.isNumeric(telresponsabileAmm4)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 4. E' obbligatorio compilare il campo 'Telefono Referente Amministrativo'.</span><br/>";
                        }


                    }
                    if (ctrlAula5 === true) {
                        if (indirizzo5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Indirizzo'.</span><br/>";
                        }
                        if (citta5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Citt&#224;'.</span><br/>";
                        }
                        if (provincia5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Provincia'.</span><br/>";
                        }
                        if (regioneaula5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Regione'.</span><br/>";
                        }
                        if (estremi5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Estremi -Mq aula'.</span><br/>";
                        }
                        if (titolo5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Titolo di disponibilit&#224;'.</span><br/>";
                        }
                        if (accreditamento5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Accreditamento Regionale'.</span><br/>";
                        }
                        if (responsabile5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Nominativo responsabile'.</span><br/>";
                        }
                        if (mailresponsabile5 === "" || !regexpMAIL.test(mailresponsabile5)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Mail Responsabile'.</span><br/>";
                        }
                        if (telresponsabile5 === "" || !$.isNumeric(telresponsabile5)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Telefono Responsabile'.</span><br/>";
                        }

                        if (responsabileAmm5 === "") {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Nominativo referente Amministrativo'.</span><br/>";
                        }
                        if (mailresponsabileAmm5 === "" || !regexpMAIL.test(mailresponsabileAmm5)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Mail Referente Amministrativo'.</span><br/>";
                        }
                        if (telresponsabileAmm5 === "" || !$.isNumeric(telresponsabileAmm5)) {
                            output = "1";
                            msg += "<span style='color:red;'>Sezione Aula 5. E' obbligatorio compilare il campo 'Telefono Referente Amministrativo'.</span><br/>";
                        }
                    }
                } else if (tipologia === "B") {



                    msg = "";

                    for (var indice = 1; indice < 6; indice++) {

                        var Nome1 = document.getElementById("docNome" + indice).value.trim();
                        var Cognome1 = document.getElementById("docCognome" + indice).value.trim();
                        var CF1 = document.getElementById("docCF" + indice).value.trim();
                        var Comune1 = document.getElementById("doccomune" + indice).value.trim();
                        var ComuneCF1 = document.getElementById("comunecf" + indice).value.trim();
                        var Datanascita1 = document.getElementById("docdatanascita" + indice).value.trim();
                        var Sesso1 = document.getElementById("docsesso" + indice).value.trim();
                        var Regione1 = document.getElementById("docregione" + indice).value.trim();
                        var Mail1 = document.getElementById("docmail" + indice).value.trim();
                        var Pec1 = document.getElementById("docpec" + indice).value.trim();
                        var Tel1 = document.getElementById("doctel" + indice).value.trim();
                        var Titolistudio1 = document.getElementById("doctitolistudio" + indice).value.trim();
                        var Qualifiche1 = document.getElementById("docqualifiche" + indice).value.trim();

                        var Inquadr = document.getElementById("docinquadr" + indice).value.trim();

                        if ($("#docenteclasse" + indice).is(":visible")) {
                            if (Nome1 === "" || Cognome1 === ""
                                    || CF1 === "" || Comune1 === ""
                                    || Datanascita1 === "" || Sesso1 === ""
                                    || Regione1 === "" || Mail1 === ""
                                    || Pec1 === "" || Tel1 === ""
                                    || Titolistudio1 === "" || Qualifiche1 === ""
                                    || Inquadr === ""
                                    )
                            {
                                output = "1";
                                msg += "<span style='color:red;'>E' obbligatorio compilare TUTTI i campi della sezione <b>'Docente " + indice + "'</b></span><br/>";
                            } else {

                                if (!checkCF(CF1)) {
                                    output = "1";
                                    msg += "<span style='color:red;'>Sezione Docente " + indice + ". E' obbligatorio compilare il campo 'Codice Fiscale' con un valore corretto.</span><br/>";
                                } else {


                                    var controllocf = controllaCF_completo(CF1, Nome1, Cognome1, Datanascita1, Sesso1, ComuneCF1, indice);
                                    if (controllocf !== "") {
                                        output = "1";
                                        msg += controllocf;
                                    }

                                }

                                if (!regexpMAIL.test(Mail1)) {
                                    output = "1";
                                    msg += "<span style='color:red;'>Sezione Docente " + indice + ". E' obbligatorio compilare il campo 'Indirizzo Email' con un valore corretto.</span><br/>";
                                }

                                if (!regexpMAIL.test(Pec1)) {
                                    output = "1";
                                    msg += "<span style='color:red;'>Sezione Docente " + indice + ". E' obbligatorio compilare il campo 'Indirizzo PEC' con un valore corretto.</span><br/>";
                                }

                                if (!$.isNumeric(Tel1)) {
                                    output = "1";
                                    msg += "<span style='color:red;'>Sezione Docente " + indice + ". E' obbligatorio compilare il campo 'Numero di cellulare (Senza +39)' con un valore corretto.</span><br/>";
                                }
                            }
                        }
                    }
                } else {
                    return false;
                }

                if (output !== "0") {
                    document.getElementById("msgcompil").innerHTML = msg;
                    document.getElementById("confirm").className = document.getElementById("confirm").className + " in";
                    document.getElementById("confirm").style.display = "block";
                    return false;
                }
                if (tipologia === "A") {
                    document.getElementById("formModelloA").submit();
                } else {
                    document.getElementById("formModelloB").submit();
                }
            }

            function mostraAuleFx() {
                var x = '<%=StringEscapeUtils.escapeHtml4(allegato_A_B)%>';
                if (x === "A") {
                    mostraaule('aule');
                } else if (x === "B") {
                    mostraDocenti('1');
                }
            }

            function scaricaFile(servURL, params) {
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

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-closed" onload="mostraAuleFx();">
                        <%@ include file="menu/header.jsp"%>

        <%@include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp" %>
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
                            <h3 class="page-title">Inserimento Dati</h3>
                        </div>
                        <div class="col-md-3" style="text-align: right;">
                            <img src="assets/soop/img/logo_blue_1.png" alt="logo" height="70px"/>
                        </div>
                    </div>
                    <%
                        boolean esisteAllegatoA = ActionB.esisteAllegatoA(username);
                        boolean esisteAllegatoB = ActionB.esisteAllegatoB(username);
                        boolean esisteAllegatoC2 = ActionB.esisteAllegatoC2(username);

                        boolean verificaDomandaCompleta = ActionB.verificaDomandaCompleta(username);

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
                            } else if (es.equals("ok2")) {
                                inte = "<i class='fa fa-exclamation-triangle font-green'></i> Operazione Completata";
                                msg = "Sezione compilata con successo.";
                            } else if (es.equals("ok3")) {
                                inte = "<i class='fa fa-exclamation-triangle font-green'></i> Operazione Completata";
                                msg = "Eliminazione dati allegato B1 completata con successo.";
                            } else if (es.equals("okb1")) {
                                inte = "<i class='fa fa-exclamation-triangle font-green'></i> Operazione Completata";
                                msg = "Puoi ora tornare alla Home per caricare gli eventuali documenti rimanenti.";
                            } else if (es.equals("ko")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Errore inserimento";
                                msg = "Impossibile salvare i file, riprovare.";
                            } else if (es.equals("ko1")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Errore durante la fase di eliminazione";
                                msg = "Impossibile eliminare il fascicolo del docente, riprovare.";
                            } else if (es.equals("ko2")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Errore durante la fase di compilazione";
                                msg = "Impossibile completare tale operazione, riprovare.";
                            } else if (es.equals("ko3")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Errore durante la fase di cancellazione";
                                msg = "Impossibile completare tale operazione, riprovare.";
                            } else if (es.equals("ko4")) {
                                inte = "<i class='fa fa-exclamation-triangle font-red'></i> Impossibile caricare i files. Verificare che l'estensione sia corretta";
                                msg = "Impossibile completare tale operazione, riprovare.";
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
                    <div class="row">
                        <div class="col-md-12"> 
                            <div class="alert alert-info uppercase text-justify">
                                Controlla con attenzione i dati inseriti in questa sezione prima di salvare, completata la procedura non sar&#224; possibile modificare i dati ma solo eliminare l'intera sezione e compilare nuovamente la sezione.
                                <%if (allegato_A_B.equals("C2")) {%>
                                <br><b>NELLA SEZIONE "DATI RICHIEDENTE" VANNO INSERITI I DATI DEL FIRMATARIO DELLA DOMANDA DI ACCREDITAMENTO.</b>  
                                <%} else if (allegato_A_B.equals("C")) {%>
                                <br><b>N.B. ciascun CV, pena esclusione, deve essere debitamente firmato dal docente (firma leggibile e per esteso nell'ultima pagina), 
                                    contenere l'autorizzazione al trattamento dei dati personali ai sensi del GDPR 2016/679,
                                    contenere la dichiarazione ai sensi della 445/2000 sulla veridicit&#192; dei dati dichiarati.</b>
                                    <%}%>
                            </div>
                            <% if (allegato_A_B.equals("A") && !esisteAllegatoA) {%>

                            <div class="portlet box yellow">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa fa-pencil-square-o"></i> Compilazione Dichiarazioni</div>
                                    <div class="tools">
                                        <a href="javascript:;" class="collapse"></a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <form name="formregist" role="form" action="Operazioni?action=allegato_A" method="post" class="form-horizontal" id="formModelloA">
                                        <input type="hidden" name="username" value="<%=username%>"/>
                                        <!--Operazioni?action=complinea1-->
                                        <div class="col-md-12 form-inline">
                                            ai sensi degli articoli 46 e 47 del DPR 28.12.2000 n. 445, consapevole delle sanzioni penali previste dall’articolo 76 del medesimo D.P.R., per le ipotesi di falsit&#224; in atti e dichiarazioni mendaci ivi indicate:<br>
                                            <br>

                                            <b>PUNTO 1)</b> di essere (selezionare le caselle di interesse):<span class="font-red popovers" data-trigger="hover" 
                                                                                                                  data-container="body" data-placement="bottom"
                                                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                            <ul>
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="ch1" id="ch1" class="md-checkbox" /> 
                                                    <label for="ch1">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Soggetto Singolo
                                                    </label>
                                                </div>
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="ch2" id="ch2" class="md-checkbox" /> 
                                                    <label for="ch2">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Costituenda ATI/ATS o costituenda rete di imprese.
                                                    </label>
                                                </div>
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="ch3" id="ch3" class="md-checkbox" /> 
                                                    <label for="ch3">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Costituita ATI/ATS che preveda mandato di rappresentanza specifico al capofila.
                                                    </label>
                                                </div>
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="ch4" id="ch4" class="md-checkbox" /> 
                                                    <label for="ch4">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Costituita rete contratto dotata di organo comune con potere di rappresentanza.
                                                    </label>
                                                </div>
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="ch5" id="ch5" class="md-checkbox" /> 
                                                    <label for="ch5">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Consorzio/Fondazione/Rete soggetto (Rete di imprese dotata di organo comune e di soggettività giuridica).
                                                    </label>
                                                </div>
                                                <br/>
                                                Con il seguente requisito:<br/>
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="ch6" id="ch6" class="md-checkbox" /> 
                                                    <label for="ch6">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span>
                                                    </label>
                                                    Agenzia Formativa accreditata presso la Regione Toscana ai sensi della Delibera n.1407/2016. N. di iscrizione 
                                                    <i class="fa fa-info-circle popovers" data-trigger="hover" 
                                                       data-container="body" data-placement="bottom"
                                                       data-content="in caso di costituenda/costituita ATI/ATS o di costituenda/costituita rete di imprese – Rete contratto, indicare il n° di iscrizione della Mandataria"></i>
                                                    <input class="form-control form-control-static uppercase" maxlength="20"
                                                           id="iscrizione" name="iscrizione" style="width: 200px" placeholder="...." type="text" readonly="readonly"/>
                                                </div>                

                                                <div id="tabati" style="display: none;">
                                                    <hr>
                                                    <label>In caso di costituenda/costituita ATI/ATS o di costituenda/costituita rete di imprese – Rete contratto, elencare gli Enti/Società mandanti e relativo numero di iscrizione presso la Regione Toscana ai sensi della Delibera n.1407/2016:</label>
                                                    <br/>
                                                    Elencare gli Enti/Società mandanti: <input class="form-control uppercase" id="elencoenti" name="elencoenti" 
                                                                                               placeholder="...." type="text" onchange="return fieldNoEuro(this.id);" size="60" /> 
                                                    ed il numero di iscrizione: <input class="form-control uppercase" id="numiscrreg" name="numiscrreg" 
                                                                                       placeholder="...." type="text" onchange="return fieldNoEuro(this.id);" />
                                                </div>
                                            </ul>
                                            <script type="text/javascript">

                                                $('#ch1').on('change', function () {
                                                    if (this.checked) {
                                                        $('#ch2').prop('checked', false);
                                                        $('#ch3').prop('checked', false);
                                                        $('#ch4').prop('checked', false);
                                                        $('#ch5').prop('checked', false);
                                                        document.getElementById("tabati").style.display = "none";
                                                    }
                                                });

                                                $('#ch2').on('change', function () {
                                                    if (this.checked) {
                                                        $('#ch1').prop('checked', false);
                                                        $('#ch3').prop('checked', false);
                                                        $('#ch4').prop('checked', false);
                                                        $('#ch5').prop('checked', false);
                                                        document.getElementById("tabati").style.display = "block";
                                                    } else {
                                                        document.getElementById("tabati").style.display = "none";
                                                    }
                                                });

                                                $('#ch3').on('change', function () {
                                                    if (this.checked) {
                                                        $('#ch1').prop('checked', false);
                                                        $('#ch2').prop('checked', false);
                                                        $('#ch4').prop('checked', false);
                                                        $('#ch5').prop('checked', false);
                                                        document.getElementById("tabati").style.display = "block";

                                                    } else {
                                                        document.getElementById("tabati").style.display = "none";
                                                    }
                                                });

                                                $('#ch4').on('change', function () {
                                                    if (this.checked) {
                                                        $('#ch1').prop('checked', false);
                                                        $('#ch2').prop('checked', false);
                                                        $('#ch3').prop('checked', false);
                                                        $('#ch5').prop('checked', false);
                                                        document.getElementById("tabati").style.display = "block";

                                                    } else {
                                                        document.getElementById("tabati").style.display = "none";
                                                    }
                                                });

                                                $('#ch5').on('change', function () {
                                                    if (this.checked) {
                                                        $('#ch1').prop('checked', false);
                                                        $('#ch2').prop('checked', false);
                                                        $('#ch3').prop('checked', false);
                                                        $('#ch4').prop('checked', false);
                                                        document.getElementById("tabati").style.display = "none";
                                                    } else {
                                                        document.getElementById("tabati").style.display = "none";
                                                    }
                                                });

                                                $('#ch6').on('change', function () {
                                                    $('#iscrizione').val("");
                                                    if (this.checked) {
                                                        $('#iscrizione').prop('readonly', false);
                                                    } else {
                                                        $('#iscrizione').prop('readonly', true);
                                                    }
                                                });

                                            </script>
                                            <br/>
                                            <b>PUNTO 2)</b> di disporre, secondo quanto riportato nella sottostante tabella/e di n.&nbsp;
                                            <select id="aule" name="aule" class="form-control select2" 
                                                    data-placeholder="..." onchange="return mostraaule(this.id);">
                                                <option value="1">01</option>
                                                <option value="2">02</option>
                                                <option value="3">03</option>
                                                <option value="4">04</option>
                                                <option value="5">05</option>
                                            </select>
                                            <script type="text/javascript">
                                                $('#' + 'aule').select2({
                                                    language: 'it',
                                                    theme: "classic"
                                                });

                                                function mostraaule(ids) {
                                                    var sel = document.getElementById(ids).value;
                                                    for (var x = 1; x < 6; x++) {
                                                        if (x <= sel) {
                                                            $(".classe" + x).toggle(true);
                                                        } else {
                                                            $(".classe" + x).toggle(false);
                                                            document.getElementById("citta" + x).value = '';
                                                            document.getElementById("provincia" + x).value = '';
                                                            document.getElementById("indirizzo" + x).value = '';
                                                            document.getElementById("estremi" + x).value = '';
                                                            document.getElementById("accreditamento" + x).value = '';
                                                            document.getElementById("responsabile" + x).value = '';
                                                            document.getElementById("responsabileAmm" + x).value = '';
                                                            //document.getElementById("recapiti" + x).value = '';
                                                        }
                                                    }
                                                }
                                            </script>
                                            &nbsp;aula/e da destinare alle attivit&#224; formativa oggetto di affidamento dell’Avviso in parola - Qualora, tra le sedi sottoindicate, ci siano locali non registrati ai sensi della DGR 1407/2016 e ss.mm.ii., è necessario redigere l’Allegato F.
                                            <br>
                                        </div>
                                        <div class="clearfix"></div>
                                        <hr>
                                        <table style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th colspan="2" style="text-align: center; background-color: silver;"><h4><b>Compilazione aule</b> 
                                                        </h4>
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                        <hr>
                                        <table style="width: 100%;">
                                            <%for (int i = 1; i < 6; i++) {
                                                    String indicet1 = "";
                                                    if (i > 1) {
                                                        indicet1 = String.valueOf(i);
                                                    }

                                            %>
                                            <tr style="border-bottom: 3px;" class="classe<%=i%>">
                                                <th colspan="4" style="text-align: center;" ><span class="help-block bordered">
                                                        Aula <%=i%> 
                                                    </span> <hr>
                                                </th>
                                            </tr>
                                            <tr class="classe<%=i%>">
                                                <td>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Indirizzo<span class="font-red popovers" data-trigger="hover" 
                                                                                           data-container="body" data-placement="bottom"
                                                                                           data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase" name="indirizzo<%=indicet1%>" placeholder="..." id="indirizzo<%=indicet1%>" maxlength="100" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Citt&#224;<span class="font-red popovers" data-trigger="hover" 
                                                                                            data-container="body" data-placement="bottom"
                                                                                            data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="citta<%=indicet1%>" name="citta<%=indicet1%>" class="form-control select2" data-placeholder="..."></select>
                                                                        <script type="text/javascript">
                                                                            $('#citta' + '<%=indicet1%>').select2({
                                                                                allowClear: true,
                                                                                minimumInputLength: 3,
                                                                                placeholder: "Seleziona Comune",
                                                                                theme: "classic",
                                                                                language: 'it',
                                                                                ajax: {
                                                                                    url: "Query?tipo=comune",
                                                                                    dataType: 'json',
                                                                                    delay: 250,
                                                                                    data: function (params) {
                                                                                        return {
                                                                                            q: params.term, // search term
                                                                                            page: params.page
                                                                                        };
                                                                                    },
                                                                                    processResults: function (data, params) {
                                                                                        params.page = params.page || 1;
                                                                                        return {
                                                                                            results: data.items,
                                                                                            pagination: {
                                                                                                more: (params.page * 30) < data.total_count
                                                                                            }
                                                                                        };
                                                                                    },
                                                                                    cache: true
                                                                                },
                                                                                escapeMarkup: function (markup) {
                                                                                    return markup; // let our custom formatter work
                                                                                },
                                                                                templateResult: function (repo) {
                                                                                    if (repo.loading)
                                                                                        return repo.text;
                                                                                    return repo.full_name;
                                                                                },
                                                                                templateSelection: function (repo) {
                                                                                    return repo.full_name || repo.text;
                                                                                }
                                                                            });

                                                                            $('#citta' + '<%=indicet1%>').on('select2:select', function (e) {
                                                                                var data = e.params.data;
                                                                                enable_sel2('regioneaula' + '<%=indicet1%>', 'formModelloA');
                                                                                enable_sel2('provincia' + '<%=indicet1%>', 'formModelloA');
                                                                                $('#regioneaula' + '<%=indicet1%>').val(data.reg).trigger('change');
                                                                                $('#provincia' + '<%=indicet1%>').val(data.prov).trigger('change');
                                                                                disable_sel2('regioneaula' + '<%=indicet1%>', 'formModelloA');
                                                                                disable_sel2('provincia' + '<%=indicet1%>', 'formModelloA');
                                                                            });
                                                                            $('#citta' + '<%=indicet1%>').on("select2:unselecting", function (e) {
                                                                                enable_sel2('regioneaula' + '<%=indicet1%>', 'formModelloA');
                                                                                enable_sel2('provincia' + '<%=indicet1%>', 'formModelloA');
                                                                                $('#regioneaula' + '<%=indicet1%>').val($('#regioneaula' + '<%=indicet1%>' + ' option:first-child').val()).trigger('change');
                                                                                $('#provincia' + '<%=indicet1%>').val($('#provincia' + '<%=indicet1%>' + ' option:first-child').val()).trigger('change');
                                                                                disable_sel2('regioneaula' + '<%=indicet1%>', 'formModelloA');
                                                                                disable_sel2('provincia' + '<%=indicet1%>', 'formModelloA');
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Provincia<span class="font-red popovers" data-trigger="hover" 
                                                                                           data-container="body" data-placement="bottom"
                                                                                           data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="provincia<%=indicet1%>" name="provincia<%=indicet1%>" class="form-control select2" data-placeholder="...">
                                                                            <option value="">...</option>
                                                                            <%for (int p = 0; p < province.size(); p++) {%>
                                                                            <option value="<%=StringEscapeUtils.escapeHtml4(province.get(p).getCodiceprovincia())%>"><%=StringEscapeUtils.escapeHtml4(province.get(p).getProvincia()).toUpperCase()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#provincia' + '<%=indicet1%>').select2({
                                                                                allowClear: true,
                                                                                theme: "classic",
                                                                                language: 'it'
                                                                            });

                                                                            $(function () {
                                                                                disable_sel2('provincia' + '<%=indicet1%>', 'formModelloA');
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Regione<span class="font-red popovers" data-trigger="hover" 
                                                                                         data-container="body" data-placement="bottom"
                                                                                         data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="regioneaula<%=indicet1%>" name="regioneaula<%=indicet1%>" class="form-control select2" data-placeholder="...">
                                                                            <option value="">...</option>
                                                                            <%for (int p = 0; p < reg.size(); p++) {%>
                                                                            <option value="<%=StringEscapeUtils.escapeHtml4(reg.get(p).getCodiceprovincia())%>"><%=StringEscapeUtils.escapeHtml4(reg.get(p).getProvincia()).toUpperCase()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#regioneaula' + '<%=indicet1%>').select2({
                                                                                allowClear: true,
                                                                                theme: "classic",
                                                                                language: 'it'
                                                                            });
                                                                            $(function () {
                                                                                disable_sel2('regioneaula' + '<%=indicet1%>', 'formModelloA');
                                                                            });
                                                                        </script>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix row"></div>                        
                                                        <div class="col-md-12">
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Titolo di disponibilit&#224;<span class="font-red popovers" data-trigger="hover" 
                                                                                                              data-container="body" data-placement="bottom"
                                                                                                              data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="titolo<%=indicet1%>" name="titolo<%=indicet1%>" class="form-control select2" data-placeholder="...">
                                                                            <option value="">...</option>
                                                                            <%for (int p = 0; p < disponibilita.size(); p++) {%>
                                                                            <option value="<%=StringEscapeUtils.escapeHtml4(String.valueOf(disponibilita.get(p).getCodice()))%>"><%=StringEscapeUtils.escapeHtml4(disponibilita.get(p).getDescrizione()).toUpperCase()%></option>
                                                                            <%}%>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#titolo' + '<%=indicet1%>').select2({
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
                                                                    <div class="col-md-6">
                                                                        <span class="help-block">
                                                                            Estremi - Mq aula<span class="font-red popovers" data-trigger="hover" 
                                                                                                   data-container="body" data-placement="bottom"
                                                                                                   data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase decimalvalue" 
                                                                               name="estremi<%=indicet1%>" 
                                                                               placeholder="..." id="estremi<%=indicet1%>" max="10" />
                                                                    </div>
                                                                    <script type="text/javascript">
                                                                        $(document).ready(function () {
                                                                            $('.decimalvalue').keypress(function (event) {
                                                                                return isNumber(event, this);
                                                                            });
                                                                            $('.decimalvalue').keyup(function () {
                                                                                var val = $(this).val();
                                                                                var str = val.replace('.', ',');
                                                                                $(this).val(str);
                                                                            });
                                                                            $('.decimalvalue').change(function (event) {
                                                                                var val = $(this).val();
                                                                                if (isNaN(val)) {
                                                                                    val = val.replace(/[^0-9\,]/g, '');
                                                                                    if (val.split(',').length > 2)
                                                                                        val = val.replace(/\,+$/, "");
                                                                                }
                                                                                $(this).val(val);
                                                                            });

                                                                        });
                                                                        // THE SCRIPT THAT CHECKS IF THE KEY PRESSED IS A NUMERIC OR DECIMAL VALUE.
                                                                        function isNumber(evt, element) {
                                                                            var charCode = (evt.which) ? evt.which : event.keyCode;
                                                                            if ((charCode !== 46) &&
                                                                                    (charCode !== 44 || $(element).val().indexOf(',') !== -1) //VIRGOLA E SOLO 1
                                                                                    && (charCode < 48 || charCode > 57)) {
                                                                                return false;
                                                                            }
                                                                            return true;
                                                                        }

                                                                    </script>
                                                                    <div class="col-md-6">
                                                                        <span class="help-block">
                                                                            Accr. Regionale<span class="font-red popovers" data-trigger="hover" 
                                                                                                 data-container="body" data-placement="bottom"
                                                                                                 data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <select id="accreditamento<%=indicet1%>" name="accreditamento<%=indicet1%>" class="form-control select2" data-placeholder="...">
                                                                            <option value="">...</option>
                                                                            <option value="SI">SI</option>
                                                                            <option value="NO">NO</option>
                                                                        </select>
                                                                        <script type="text/javascript">
                                                                            $('#accreditamento' + '<%=indicet1%>').select2({
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
                                                                            Nominativo Responsabile<span class="font-red popovers" data-trigger="hover" 
                                                                                                         data-container="body" data-placement="bottom"
                                                                                                         data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase" name="responsabile<%=indicet1%>" placeholder="..." id="responsabile<%=indicet1%>" maxlength="50" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Mail Responsabile<span class="font-red popovers" data-trigger="hover" 
                                                                                                   data-container="body" data-placement="bottom"
                                                                                                   data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <div class="input-icon right">
                                                                            <i id="check_mailresponsabile<%=indicet1%>" class="fa"></i>                                  
                                                                            <input type="text" class="form-control" maxlength="50"
                                                                                   name="mailresponsabile<%=indicet1%>" id="mailresponsabile<%=indicet1%>" placeholder="..."
                                                                                   onchange="return fieldNoEuroMail(this.id);" 
                                                                                   maxlength="50" required />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <script type="text/javascript">
                                                                $('#mailresponsabile' + '<%=indicet1%>').on('keyup', function () {
                                                                    var v1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                                                                    if (this.value.length > 0) {
                                                                        var valid = v1.test(this.value) && this.value.length;
                                                                        if (!valid) {
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("fa-check");
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("font-green-jungle");
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').addClass("fa-times");
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').addClass("font-red");
                                                                        } else {
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').addClass("fa-check");
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').addClass("font-green-jungle");
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("fa-times");
                                                                            $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("font-red");
                                                                        }
                                                                    } else {
                                                                        $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("fa-check");
                                                                        $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("fa-times");
                                                                        $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("font-green-jungle");
                                                                        $('#check_mailresponsabile' + '<%=indicet1%>').removeClass("font-red");
                                                                    }
                                                                });
                                                            </script>
                                                        </div><div class="clearfix row"></div>

                                                        <div class="col-md-12">
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Telefono Responsabile<span class="font-red popovers" data-trigger="hover" 
                                                                                                       data-container="body" data-placement="bottom"
                                                                                                       data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase" name="telresponsabile<%=indicet1%>" placeholder="..." id="telresponsabile<%=indicet1%>"
                                                                               onchange="return fieldOnlyNumber(this.id);"  maxlength="20"  />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Nominativo Ref. Amministrativo<span class="font-red popovers" data-trigger="hover" 
                                                                                                                data-container="body" data-placement="bottom"
                                                                                                                data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase" name="responsabileAmm<%=indicet1%>" placeholder="..." id="responsabileAmm<%=indicet1%>"  maxlength="50" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Mail Ref. Amministrativo<span class="font-red popovers" data-trigger="hover" 
                                                                                                          data-container="body" data-placement="bottom"
                                                                                                          data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <div class="input-icon right">
                                                                            <i id="check_mailresponsabileAmm<%=indicet1%>" class="fa"></i>                                  
                                                                            <input type="text" class="form-control" maxlength="50"
                                                                                   name="mailresponsabileAmm<%=indicet1%>" id="mailresponsabileAmm<%=indicet1%>" placeholder="..."
                                                                                   onchange="return fieldNoEuroMail(this.id);" 
                                                                                   maxlength="50" required />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <script type="text/javascript">
                                                                $('#mailresponsabileAmm' + '<%=indicet1%>').on('keyup', function () {
                                                                    var v1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                                                                    if (this.value.length > 0) {
                                                                        var valid = v1.test(this.value) && this.value.length;
                                                                        if (!valid) {
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("fa-check");
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("font-green-jungle");
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').addClass("fa-times");
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').addClass("font-red");
                                                                        } else {
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').addClass("fa-check");
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').addClass("font-green-jungle");
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("fa-times");
                                                                            $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("font-red");
                                                                        }
                                                                    } else {
                                                                        $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("fa-check");
                                                                        $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("fa-times");
                                                                        $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("font-green-jungle");
                                                                        $('#check_mailresponsabileAmm' + '<%=indicet1%>').removeClass("font-red");
                                                                    }
                                                                });
                                                            </script>
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <div class="col-md-12">
                                                                        <span class="help-block">
                                                                            Telefono Ref. Amministrativo<span class="font-red popovers" data-trigger="hover" 
                                                                                                              data-container="body" data-placement="bottom"
                                                                                                              data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                        </span>
                                                                        <input type="text" class="form-control uppercase"
                                                                               name="telresponsabileAmm<%=indicet1%>" placeholder="..." 
                                                                               id="telresponsabileAmm<%=indicet1%>" onchange="return fieldOnlyNumber(this.id);"  maxlength="20" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <%}%>
                                        </table>
                                        <div class="clearfix"></div>
                                        <hr>
                                        <div class="row">
                                            <br/>
                                            <div class="col-md-12 form-inline">
                                                <b>PUNTO 3)</b>

                                                <div class="row col-md-12">
                                                    che la PEC ove potranno essere inviate le comunicazioni relative al presente procedimento, 
                                                    anche ai fini del controllo sui requisiti richiesti, &#232; <span class="font-red popovers" data-trigger="hover" 
                                                                                                                      data-container="body" data-placement="bottom"
                                                                                                                      data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                    <div class="input-icon">
                                                        <i id="check_pec" class="fa"></i>                                  
                                                        <input type="text" class="form-control" maxlength="50"
                                                               name="pec" id="pec" placeholder="..."
                                                               onchange="return fieldNoEuroMail(this.id);" 
                                                               maxlength="50" required />
                                                    </div>
                                                </div>
                                                <script type="text/javascript">
                                                    $('#pec').on('keyup', function () {
                                                        var v1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                                                        if (this.value.length > 0) {
                                                            var valid = v1.test(this.value) && this.value.length;
                                                            if (!valid) {
                                                                $('#check_pec').removeClass("fa-check");
                                                                $('#check_pec').removeClass("font-green-jungle");
                                                                $('#check_pec').addClass("fa-times");
                                                                $('#check_pec').addClass("font-red");
                                                            } else {
                                                                $('#check_pec').addClass("fa-check");
                                                                $('#check_pec').addClass("font-green-jungle");
                                                                $('#check_pec').removeClass("fa-times");
                                                                $('#check_pec').removeClass("font-red");
                                                            }
                                                        } else {
                                                            $('#check_pec').removeClass("fa-check");
                                                            $('#check_pec').removeClass("fa-times");
                                                            $('#check_pec').removeClass("font-green-jungle");
                                                            $('#check_pec').removeClass("font-red");
                                                        }
                                                    });
                                                </script>
                                                <!--
                                                <input class="form-control form-inline" id="pec" name="pec"  placeholder="...."
                                                       type="text" onchange="return fieldNoEuroMail(this.id);" 
                                                       style="width: 300px;" maxlength="50"/>
                                                -->


                                            </div>
                                            <div class="col-md-12">
                                                <hr>
                                            </div>
                                            <div class="col-md-12 form-inline">
                                                <b>PUNTO 4)</b> Saranno allegati 
                                                <select id="numeroDocenti" name="numeroDocenti" class="form-control select2" data-placeholder="...">
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                </select>
                                                <script type="text/javascript">
                                                    $('#' + 'numeroDocenti').select2({
                                                        language: 'it',
                                                        theme: "classic"
                                                    });
                                                </script>
                                                Fascicolo/i Docente, comprensivi di:
                                                <ul>
                                                    - Allegato B1 per ciascun docente inserito nell'elenco docenti di cui all’Allegato B.
                                                    <br/>
                                                    - Curriculum Vitae docente, sottoscritto dal docente con firma leggibile, con allegato relativo documento di identit&#224; fronte/retro in corso di validit&#224;.
                                                </ul>
                                            </div>
                                            <div class="col-md-12">
                                                <hr>
                                            </div>
                                            <div class="col-md-12 form-inline">
                                                <b>PUNTO 5)</b> Consenso al trattamento dei dati:
                                            </div>
                                            <div class="col-md-12 form-inline">
                                                <br/>
                                            </div>
                                            <div class="col-md-12 form-inline">
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="privacy1" id="privacy1" class="md-checkbox" /> 
                                                    <label for="privacy1">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Autorizzo, ai sensi dell’art. 13 del Regolamento (UE) 2016/679, al trattamento dei propri dati, anche personali, per l’invio di newsletter ed eventi organizzati dall’Ente Nazionale Per il Microcredito.
                                                    </label>
                                                </div>
                                            </div>
                                            <br/>
                                            <div class="col-md-12 form-inline">
                                                <div class="md-checkbox">
                                                    <input type="checkbox" name="privacy2" id="privacy2" class="md-checkbox" /> 
                                                    <label for="privacy2">
                                                        <span></span>
                                                        <span class="check"></span>
                                                        <span class="box"></span> Autorizzo l'analisi delle mie preferenze e degli interessi desunti, ad esempio, dai click online su articoli/sezioni del sito web dell’Ente Nazionale per il Microcredito per l’invio di comunicazioni personalizzate e per effettuare azioni mirate di business intelligence.
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <hr>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <a class="btn btn btn-lg btn-block blue-hoki" href="bando_index.jsp"><i class="fa fa-arrow-left"></i> Indietro</a>
                                        </div>
                                        <div class="col-md-10">
                                            <button type="button" class="btn btn-lg green-jungle btn-block" onclick="return controllaReg1();"><i class="fa fa-save"  ></i> Salva dati</button>
                                        </div>                            
                                    </div>
                                </div>
                            </div>
                            <%} else if (allegato_A_B.equals("B") && !esisteAllegatoB) {
                                int totaledocenti = ActionB.getDocentiAllegatoA(username);
                                //String tiposoggetto = ActionB.getTipoSoggetto(username);
%>
                            <div class="portlet-body">
                                <form name="formregist" role="form" action="Operazioni?action=allegato_B" method="post"  class="form-horizontal" id="formModelloB">
                                    <input type="hidden" name="username" value="<%=username%>"/>
                                    <input type="hidden" name="totaledocenti" value="<%=totaledocenti%>"/>

                                    <table style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th colspan="2" style="text-align: center; background-color: silver;">
                                                    <h4><b>ELENCO DOCENTI</b></h4>
                                                </th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <hr>
                                    <table style="width: 100%;">
                                        <%for (int s = 1; s < 6; s++) {%>
                                        <tr style="border-bottom: 3px;" class="docenteclasse<%=s%>" id="docenteclasse<%=s%>">
                                            <th colspan="4" style="text-align: center;" ><span class="help-block bordered">
                                                    Docente <%=s%> 
                                                </span> <hr>
                                            </th>
                                        </tr>
                                        <tr class="docenteclasse<%=s%>">
                                            <td>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Nome<span class="font-red popovers" data-trigger="hover" 
                                                                                  data-container="body" data-placement="bottom"
                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <input class="form-control uppercase" id="docNome<%=s%>" name="docNome<%=s%>" required
                                                                           placeholder="...." type="text" onchange="return fieldNoEuro(this.id);" maxlength="50" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Cognome<span class="font-red popovers" data-trigger="hover" 
                                                                                     data-container="body" data-placement="bottom"
                                                                                     data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <input class="form-control uppercase" id="docCognome<%=s%>" name="docCognome<%=s%>" required
                                                                           placeholder="...." type="text"  onchange="return fieldNoEuro(this.id);" maxlength="50" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Codice Fiscale<span class="font-red popovers" data-trigger="hover" 
                                                                                            data-container="body" data-placement="bottom"
                                                                                            data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <input class="form-control uppercase" id="docCF<%=s%>" 
                                                                           name="docCF<%=s%>" required
                                                                           placeholder="...." type="text"  onchange="return fieldNoEuro(this.id);" maxlength="16"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Comune di Nascita <span class="font-red popovers" data-trigger="hover" 
                                                                                                data-container="body" data-placement="bottom"
                                                                                                data-content="CAMPO OBBLIGATORIO"> &#42;</span><small>(per stranieri indicare la NAZIONE)</small>
                                                                    </span>
                                                                    <input type="hidden" id="comunecf<%=s%>" name="comunecf<%=s%>" />
                                                                    <select id="doccomune<%=s%>" name="doccomune<%=s%>" class="form-control select2" data-placeholder="..." required></select>
                                                                    <script type="text/javascript">
                                                                        $('#doccomune' + '<%=s%>').select2({
                                                                            allowClear: true,
                                                                            minimumInputLength: 3,
                                                                            placeholder: "Seleziona Comune",
                                                                            language: 'it',
                                                                            width: 'resolve',
                                                                            theme: "classic",
                                                                            ajax: {
                                                                                url: "Query?tipo=comuninazioni",
                                                                                dataType: 'json',
                                                                                delay: 250,
                                                                                data: function (params) {
                                                                                    return {
                                                                                        q: params.term,
                                                                                        page: params.page
                                                                                    };
                                                                                },
                                                                                processResults: function (data, params) {
                                                                                    params.page = params.page || 1;
                                                                                    return {
                                                                                        results: data.items,
                                                                                        pagination: {
                                                                                            more: (params.page * 30) < data.total_count
                                                                                        }
                                                                                    };
                                                                                },
                                                                                cache: true
                                                                            },
                                                                            escapeMarkup: function (markup) {
                                                                                return markup; // let our custom formatter work
                                                                            },
                                                                            templateResult: function (repo) {
                                                                                if (repo.loading)
                                                                                    return repo.text;
                                                                                return repo.full_name;
                                                                            },
                                                                            templateSelection: function (repo) {
                                                                                return repo.full_name || repo.text;
                                                                            }
                                                                        });

                                                                        $('#doccomune' + '<%=s%>').on('select2:select', function (e) {
                                                                            var data = e.params.data;
                                                                            $('#comunecf' + '<%=s%>').val(data.cf);
                                                                        });

                                                                        $('#doccomune' + '<%=s%>').on("select2:unselecting", function (e) {
                                                                            $('#comunecf' + '<%=s%>').val('');
                                                                        });
                                                                    </script>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Data di Nascita<span class="font-red popovers" data-trigger="hover" 
                                                                                             data-container="body" data-placement="bottom"
                                                                                             data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <input class="form-control form-control-inline date-picker_r" 
                                                                           size="16" type="text" id="docdatanascita<%=s%>" required
                                                                           name="docdatanascita<%=s%>" maxlength="10"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Sesso<span class="font-red popovers" data-trigger="hover" 
                                                                                   data-container="body" data-placement="bottom"
                                                                                   data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <select id="docsesso<%=s%>" name="docsesso<%=s%>" class="form-control select2" data-placeholder="..." required>
                                                                        <option value="">...</option>
                                                                        <option value="M">MASCHILE</option>
                                                                        <option value="F">FEMMINILE</option>
                                                                    </select>
                                                                    <script type="text/javascript">
                                                                        $('#docsesso' + '<%=s%>').select2({
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
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Regione di Residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                                  data-container="body" data-placement="bottom"
                                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <select id="docregione<%=s%>" name="docregione<%=s%>" class="form-control select2" data-placeholder="..." required>
                                                                        <option value="">...</option>
                                                                        <%for (int p = 0; p < reg.size(); p++) {%>
                                                                        <option value="<%=StringEscapeUtils.escapeHtml4(reg.get(p).getCodiceprovincia())%>"><%=StringEscapeUtils.escapeHtml4(reg.get(p).getProvincia()).toUpperCase()%></option>
                                                                        <%}%>
                                                                        <option value="EE">ESTERO</option>
                                                                    </select>
                                                                    </select>
                                                                    <script type="text/javascript">
                                                                        $('#docregione' + '<%=s%>').select2({
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
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Indirizzo Email<span class="font-red popovers" data-trigger="hover" 
                                                                                             data-container="body" data-placement="bottom"
                                                                                             data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <div class="input-icon right">
                                                                        <i id="check_docmail<%=s%>" class="fa"></i>
                                                                        <input type="text" class="form-control" 
                                                                               name="docmail<%=s%>" placeholder="..." id="docmail<%=s%>"
                                                                               onchange="return fieldNoEuroMail(this.id);" maxlength="50" required /></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Indirizzo PEC<span class="font-red popovers" data-trigger="hover" 
                                                                                           data-container="body" data-placement="bottom"
                                                                                           data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>

                                                                    <div class="input-icon right">
                                                                        <i id="check_docpec<%=s%>" class="fa"></i>
                                                                        <input type="text" class="form-control" 
                                                                               name="docpec<%=s%>" placeholder="..." 
                                                                               id="docpec<%=s%>"
                                                                               onchange="return fieldNoEuroMail(this.id);" 
                                                                               maxlength="50" required />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <script type="text/javascript">
                                                            var v1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+.([a-zA-Z])+([a-zA-Z])+/;
                                                            $('#docmail' + '<%=s%>').on('keyup', function () {
                                                                if (this.value.length > 0) {
                                                                    var valid = v1.test(this.value) && this.value.length;
                                                                    if (!valid) {
                                                                        $('#' + 'check_docmail' + '<%=s%>').removeClass("fa-check");
                                                                        $('#' + 'check_docmail' + '<%=s%>').removeClass("font-green-jungle");
                                                                        $('#' + 'check_docmail' + '<%=s%>').addClass("fa-times");
                                                                        $('#' + 'check_docmail' + '<%=s%>').addClass("font-red");
                                                                    } else {
                                                                        $('#' + 'check_docmail' + '<%=s%>').addClass("fa-check");
                                                                        $('#' + 'check_docmail' + '<%=s%>').addClass("font-green-jungle");
                                                                        $('#' + 'check_docmail' + '<%=s%>').removeClass("fa-times");
                                                                        $('#' + 'check_docmail' + '<%=s%>').removeClass("font-red");
                                                                    }
                                                                } else {
                                                                    $('#' + 'check_docmail' + '<%=s%>').removeClass("fa-check");
                                                                    $('#' + 'check_docmail' + '<%=s%>').removeClass("fa-times");
                                                                    $('#' + 'check_docmail' + '<%=s%>').removeClass("font-green-jungle");
                                                                    $('#' + 'check_docmail' + '<%=s%>').removeClass("font-red");
                                                                }
                                                            });

                                                            $('#docpec' + '<%=s%>').on('keyup', function () {
                                                                if (this.value.length > 0) {
                                                                    var valid = v1.test(this.value) && this.value.length;
                                                                    if (!valid) {
                                                                        $('#' + 'check_docpec' + '<%=s%>').removeClass("fa-check");
                                                                        $('#' + 'check_docpec' + '<%=s%>').removeClass("font-green-jungle");
                                                                        $('#' + 'check_docpec' + '<%=s%>').addClass("fa-times");
                                                                        $('#' + 'check_docpec' + '<%=s%>').addClass("font-red");
                                                                    } else {
                                                                        $('#' + 'check_docpec' + '<%=s%>').addClass("fa-check");
                                                                        $('#' + 'check_docpec' + '<%=s%>').addClass("font-green-jungle");
                                                                        $('#' + 'check_docpec' + '<%=s%>').removeClass("fa-times");
                                                                        $('#' + 'check_docpec' + '<%=s%>').removeClass("font-red");
                                                                    }
                                                                } else {
                                                                    $('#' + 'check_docpec' + '<%=s%>').removeClass("fa-check");
                                                                    $('#' + 'check_docpec' + '<%=s%>').removeClass("fa-times");
                                                                    $('#' + 'check_docpec' + '<%=s%>').removeClass("font-green-jungle");
                                                                    $('#' + 'check_docpec' + '<%=s%>').removeClass("font-red");
                                                                }
                                                            });
                                                        </script>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Numero di cellulare (Senza +39)<span class="font-red popovers" data-trigger="hover" 
                                                                                                             data-container="body" data-placement="bottom"
                                                                                                             data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <input type="text" class="form-control" name="doctel<%=s%>"
                                                                           placeholder="..." id="doctel<%=s%>" onchange="return fieldOnlyNumber(this.id);" maxlength="20" required />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Titolo di Studio pi&#249; Elevato<span class="font-red popovers" data-trigger="hover" 
                                                                                                               data-container="body" data-placement="bottom"
                                                                                                               data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <select id="doctitolistudio<%=s%>" name="doctitolistudio<%=s%>" class="form-control select2" data-placeholder="..." required>
                                                                        <option value="">...</option>
                                                                        <%for (int p = 0; p < titolistudio.size(); p++) {%>
                                                                        <option value="<%=StringEscapeUtils.escapeHtml4(String.valueOf(titolistudio.get(p).getCodice()))%>"><%=StringEscapeUtils.escapeHtml4(titolistudio.get(p).getDescrizione()).toUpperCase()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                    <script type="text/javascript">
                                                                        $('#doctitolistudio' + '<%=s%>').select2({
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
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Area prevalente di qualificazione<span class="font-red popovers" data-trigger="hover" 
                                                                                                               data-container="body" data-placement="bottom"
                                                                                                               data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <select id="docqualifiche<%=s%>" name="docqualifiche<%=s%>" class="form-control select2" data-placeholder="..." required >
                                                                        <option value="">...</option>
                                                                        <%for (int p = 0; p < qualifiche.size(); p++) {%>
                                                                        <option value="<%=StringEscapeUtils.escapeHtml4(String.valueOf(qualifiche.get(p).getCodice()))%>"><%=StringEscapeUtils.escapeHtml4(qualifiche.get(p).getDescrizione()).toUpperCase()%></option>
                                                                        <%}%>
                                                                    </select>
                                                                    <script type="text/javascript">
                                                                        $('#docqualifiche' + '<%=s%>').select2({
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
                                                                <label class="control-label col-md-1"></label>
                                                                <div class="col-md-11">
                                                                    <span class="help-block">
                                                                        Inquadramento<span class="font-red popovers" data-trigger="hover" 
                                                                                           data-container="body" data-placement="bottom"
                                                                                           data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                    </span>
                                                                    <select id="docinquadr<%=s%>" name="docinquadr<%=s%>" class="form-control select2" data-placeholder="..." required >
                                                                        <option value="">...</option>
                                                                        <%for (int p = 0; p < inquadr.size(); p++) {%>
                                                                        <option
                                                                            value="<%=StringEscapeUtils.escapeHtml4(String.valueOf(inquadr.get(p).getCodice()))%>">
                                                                            <%=StringEscapeUtils.escapeHtml4(inquadr.get(p).getDescrizione()).toUpperCase()%>
                                                                        </option>
                                                                        <%}%>
                                                                    </select>
                                                                    <script type="text/javascript">
                                                                        $('#docinquadr' + '<%=s%>').select2({
                                                                            allowClear: true,
                                                                            theme: "classic",
                                                                            language: 'it'
                                                                        });
                                                                    </script>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <%}%>




                                        <script type="text/javascript">
                                            function mostraDocenti() {
                                                var sel = <%=totaledocenti%>;
                                                for (var x = 1; x < 6; x++) {
                                                    if (x <= sel) {
                                                        $(".classe" + x).toggle(true);
                                                        $(".docenteclasse" + x).toggle(true);
                                                    } else {
                                                        $(".classe" + x).toggle(false);
                                                        $(".docenteclasse" + x).toggle(false);

                                                    }
                                                }
                                            }
                                        </script>
                                    </table>
                                </form>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-2">
                                            <a class="btn btn btn-lg btn-block blue-hoki" href="bando_index.jsp"><i class="fa fa-arrow-left"></i> Indietro</a>
                                        </div>
                                        <div class="col-md-10">
                                            <button type="button" class="btn btn-lg green-jungle btn-block"   onclick="return controllaReg1();"><i class="fa fa-save"></i> Salva dati</button>
                                        </div>                            
                                    </div>                            
                                </div>
                            </div>
                            <%} else if (allegato_A_B.equals("C") && esisteAllegatoA && esisteAllegatoB) {%>



                            <div class="portlet-title">
                                <table style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th colspan="2" style="text-align: center; background-color: silver;">
                                                <h4><i class="fa fa-pencil-square-o"></i> Allegato/i B1 - Caricamento documenti docente/i</h4>
                                            </th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                            <br/>
                            <%
                                List<AllegatoB> al = ActionB.getAllegatoB(username);
                                for (int x = 0; x < al.size(); x++) {
                                    AllegatoB docente = al.get(x);

                            %>
                            <blockquote class="blockquote col-md-12">
                                <div class="row">
                                    <p class="mb-0 col-md-12 uppercase"><u><b>Docente:</b> <%=StringEscapeUtils.escapeHtml4(docente.getNome())%>&nbsp;<%=StringEscapeUtils.escapeHtml4(docente.getCognome())%> - <b>CF:</b> <%=StringEscapeUtils.escapeHtml4(docente.getCF())%></u></p>
                                </div>
                                <br>
                                <div class="row">
                                    <%
                                        boolean isPresenzaAllegatoB1 = ActionB.isPresenzaAllegatoB1(String.valueOf(docente.getId()), username);
                                        boolean presenzaFieldB1 = ActionB.esisteAllegatoB1Field(username, docente.getId());
                                    %>

                                    <%if (isPresenzaAllegatoB1) {%>
                                    <div class="col-md-12">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-6">
                                                    <label class="control-label">
                                                        <i class="fa fa-check font-green-jungle"></i>
                                                        TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE
                                                    </label>
                                                </div>
                                                <div class="col-md-6">
                                                    <button class="btn btn-outline green-jungle" type="button" 
                                                            onclick="return submitfor('f4<%=docente.getId()%>');">
                                                        Scarica <i class="fa fa-download"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div> 
                                        <div class="col-md-12"><hr></div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-6">
                                                    <label class="control-label uppercase">
                                                        <i class="fa fa-check font-green-jungle"></i> Curriculum Vitae, sottoscritto con firma leggibile 
                                                    </label>
                                                </div>
                                                <div class="col-md-6">
                                                    <button class="btn btn-outline green-jungle" type="button" 
                                                            onclick="return submitfor('f1<%=docente.getId()%>');">
                                                        Scarica <i class="fa fa-download"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12"><hr></div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-6">
                                                    <label class="control-label uppercase"><i class="fa fa-check font-green-jungle"></i>
                                                        Documento di identit&#224;, in corso di validit&#224;</label>
                                                </div>
                                                <div class="col-md-6">
                                                    <button class="btn btn-outline green-jungle" type="button" 
                                                            onclick="return submitfor('f5<%=docente.getId()%>');">
                                                        Scarica <i class="fa fa-download"></i>
                                                    </button>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-12"><hr></div>
                                            <%if (!verificaDomandaCompleta) {%>
                                        <div class="col-md-2 col-md-offset-5">
                                            <button type="button" class="btn btn-lg red btn-block"
                                                    onclick="return submitfor('eiliminaDoc<%=docente.getId()%>');">
                                                <i class="fa fa-trash-o"></i> Elimina dati
                                            </button>
                                        </div>
                                        <%}%>
                                    </div>

                                    <form name="f0<%=docente.getId()%>" role="form" action="Download?action=docbandoDocente" method="post" target="_blank">
                                    </form>
                                    <form name="f1<%=docente.getId()%>" role="form" action="Download?action=docbandoDocente" method="post" target="_blank">
                                        <input type="hidden" name="tipodoc" value="cv"/>
                                        <input type="hidden" name="username" value="<%=username%>"/>
                                        <input type="hidden" name="indice" value="<%=docente.getId()%>"/>
                                    </form>
                                    <form name="f4<%=docente.getId()%>" role="form" action="Download?action=docbandoDocente" method="post" target="_blank">
                                        <input type="hidden" name="tipodoc" value="b1"/>
                                        <input type="hidden" name="username" value="<%=username%>"/>
                                        <input type="hidden" name="indice" value="<%=docente.getId()%>"/>
                                    </form>
                                    <form name="f5<%=docente.getId()%>" role="form" action="Download?action=docbandoDocente" method="post" target="_blank">
                                        <input type="hidden" name="tipodoc" value="ci"/>
                                        <input type="hidden" name="username" value="<%=username%>"/>
                                        <input type="hidden" name="indice" value="<%=docente.getId()%>"/>
                                    </form>
                                    <form name="eiliminaDoc<%=docente.getId()%>" role="form" action="Operazioni?action=delDocDocenti" method="post">
                                        <input type="hidden" name="id_doc" value="<%=docente.getId()%>"/>
                                        <input type="hidden" name="username" value="<%=username%>"/>
                                    </form>


                                    <%} else {%>
                                    <form 
                                        id="formregist<%=docente.getId()%>" role="form" action="Operazioni?action=UploadMultiplo" method="post"  
                                        id="doc<%=docente.getId()%>" 
                                        enctype="multipart/form-data" 
                                        onsubmit="return controllamultiplo('<%=docente.getId()%>');">   
                                        <%if (!presenzaFieldB1) {%>  
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label"><i class="fa fa-dot-circle-o font-red"></i> TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE</label>
                                                    <a href='allegatoB1.jsp?iddocente=<%=docente.getId()%>'
                                                       type="submit" class="btn btn-outline red"> Compila <i class="fa fa-pencil-square-o"></i></a>
                                                </div>
                                            </div>

                                        </div>
                                        <%} else {%>
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label uppercase"><i class="fa fa-check font-green-jungle"></i> TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE</label>
                                                </div>
                                            </div>
                                            <!--
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label uppercase"><i class="fa fa-dot-circle-o font-red"></i> UPLOAD TABELLA RIEPILOGATIVA FIRMATA DAL SOGGETTO ATTUATORE IN FORMATO .P7M</label>
                                                </div>
                                            </div>-->
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <button class="btn btn-outline green" type="button"
                                                            onclick="scaricaFile('Download', {
                                                                        'iddocente': '<%=docente.getId()%>',
                                                                        'username': '<%=username%>',
                                                                        'action': 'docAllegatoB1'
                                                                    });">
                                                        Scarica <i class="fa fa-download"></i>
                                                    </button>
                                                    <button class="btn btn-outline red" type="button" 
                                                            onclick="scaricaFile('Operazioni', {'iddocente': '<%=docente.getId()%>',
                                                                        'username': '<%=username%>', 'action': 'delDocAllegatoB1'});">
                                                        Elimina <i class="fa fa-trash-o"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <%if (false) {%>
                                            <!--
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="input-group input-large">
                                                <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                    <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                                    <span class="fileinput-filename"> </span>
                                                </div>
                                                <span class="input-group-addon btn default btn-file">
                                                    <span class="fileinput-new"> Select file </span>
                                                    <span class="fileinput-exists"> Change </span>
                                                    <input required type="file" name="b1_<%=docente.getId()%>" id="b1_<%=docente.getId()%>" class="upmc1"> 
                                                </span>
                                                <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>--><%}%>
                                        </div>
                                        <%}%>
                                        <div class="col-md-12">
                                            <hr>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <%if (presenzaFieldB1) {%>
                                                <div class="form-group">
                                                    <label class="control-label uppercase"><i class="fa fa-dot-circle-o font-red"></i> Curriculum Vitae, sottoscritto con firma leggibile 
                                                    </label>
                                                    <div class="row separator"></div>
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new"> Select file </span>
                                                                <span class="fileinput-exists"> Change </span>
                                                                <input required type="file" name="cv_<%=docente.getId()%>" id="cv_<%=docente.getId()%>" class="upmc2"> </span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%} else {%>
                                                <div class="form-group">
                                                    <label class="control-label uppercase"><i class="fa fa-dot-circle-o font-red"></i> Curriculum Vitae, sottoscritto con firma leggibile 
                                                    </label>
                                                    <div class="alert alert-info" style="font-size: 14px;"><i class="fa fa-info-circle"></i> PRIMA DI CARICARE QUESTO DOCUMENTO &#200; NECESSARIO COMPILARE LA TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE.</div>
                                                </div>
                                                <%}%>            
                                            </div>
                                            <div class="col-md-6">   
                                                <%if (presenzaFieldB1) {%>
                                                <div class="form-group">
                                                    <label class="control-label uppercase"><i class="fa fa-dot-circle-o font-red"></i> Documento di identit&#224;, in corso di validit&#224; 
                                                    </label>
                                                    <div class="row separator"></div>
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="input-group input-large">
                                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                                <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                                                <span class="fileinput-filename"> </span>
                                                            </div>
                                                            <span class="input-group-addon btn default btn-file">
                                                                <span class="fileinput-new"> Select file </span>
                                                                <span class="fileinput-exists"> Change </span>
                                                                <input required type="file" name="di_<%=docente.getId()%>" id="di_<%=docente.getId()%>" class="upmc2"> </span>
                                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
                                                        </div>
                                                    </div>

                                                </div>
                                                <%} else {%>
                                                <div class="form-group">
                                                    <label class="control-label uppercase"><i class="fa fa-dot-circle-o font-red"></i> Documento di identit&#224;, in corso di validit&#224; 
                                                    </label>
                                                    <div class="alert alert-info" style="font-size: 14px;"><i class="fa fa-info-circle"></i> PRIMA DI CARICARE QUESTO DOCUMENTO &#200; NECESSARIO COMPILARE LA TABELLA RIEPILOGATIVA DELLE ATTIVIT&#192; SVOLTE.</div>
                                                </div>
                                                <%}%>
                                            </div>

                                        </div>

                                        <%if (presenzaFieldB1) {%>
                                        <div class="col-md-2 col-md-offset-5">
                                            <input type="hidden" name="username" value="<%=username%>"/>
                                            <input type="hidden" name="id" value="<%=docente.getId()%>"/>
                                            <button type="submit" class="btn btn-lg green-jungle btn-block"><i class="fa fa-save"></i>
                                                Salva dati</button>
                                        </div>    
                                        <script type="text/javascript">


                                            $(".upmc1").change(function () {
                                                var fileExtension = ['pdf', 'p7m'];
                                                if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) === -1 && $(this).val() !== "") {
                                                    document.getElementById("msgcompil").innerHTML = "I formati consentiti sono: " + fileExtension.join(', ');
                                                    document.getElementById("confirm").className = document.getElementById("confirm").className + " in";
                                                    document.getElementById("confirm").style.display = "block";
                                                    $(this).val("");
                                                }
                                            });

                                            $(".upmc2").change(function () {
                                                var fileExtension = ['pdf', 'p7m'];
                                                //var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp', 'pdf'];
                                                if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) === -1 && $(this).val() !== "") {
                                                    document.getElementById("msgcompil").innerHTML = "I formati consentiti sono: " + fileExtension.join(', ');
                                                    document.getElementById("confirm").className = document.getElementById("confirm").className + " in";
                                                    document.getElementById("confirm").style.display = "block";
                                                    $(this).val("");
                                                }
                                            });

                                            function controllamultiplo(iddocente) {
                                                var doc = "<%=StringEscapeUtils.escapeHtml4(docente.getNome())%>" + " " + "<%=StringEscapeUtils.escapeHtml4(docente.getCognome())%>";

                                                //var B1 = $('#b1_' + iddocente).get(0).files.length;
                                                var DI = $('#di_' + iddocente).get(0).files.length;
                                                var CV = $('#cv_' + iddocente).get(0).files.length;


                                                var output = "0";
                                                var msg = "";

                                                if (
                                                        //B1 === 0 || 
                                                        DI === 0 || CV === 0) {
                                                    output = "1";
                                                    msg += "<span style='color:red;'>E' obbligatorio selezionare tutti i file da caricare per il docente <b> " + doc + "</b>.</span><br/>";
                                                }

                                                if (output !== "0") {
                                                    document.getElementById("msgcompil").innerHTML = msg;
                                                    document.getElementById("confirm").className = document.getElementById("confirm").className + " in";
                                                    document.getElementById("confirm").style.display = "block";
                                                    return false;
                                                }

                                            }
                                        </script>
                                        <%}%>
                                    </form>
                                    <%}%>    
                                    <div class="form-group col-12">
                                        <hr>
                                    </div>
                            </blockquote>
                            <div class="row">
                                <div class="col-md-12">
                                    <hr>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-2">
                                        <a class="btn btn btn-lg btn-block blue-hoki" href="bando_index.jsp"><i class="fa fa-arrow-left"></i> Indietro</a>
                                    </div>                                                   
                                </div>                                                   
                            </div>       
                            <%}%>
                            <%} else if (allegato_A_B.equals("C2") && statoDomanda && !esisteAllegatoC2) {%>
                            <div class="portlet-title">
                                <table style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th colspan="2" style="text-align: center; background-color: silver;">
                                                <h4><i class="fa fa-pencil-square-o"></i> ALLEGATO 2 - DICHIARAZIONE SOSTITUTIVA &#34;TRACCIABILIT&#192; DEI FLUSSI FINANZIARI&#34;</h4>
                                            </th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                            <br/>
                            <script type="text/javascript">
                                function controllac2() {
                                    var output = "0";
                                    var msg = "";

                                    var validIBAN = checkIBAN(document.getElementById('iban1'));
                                    if (!validIBAN) {
                                        output = "1";
                                        msg += "Il campo <span style='color:red;'><b>IBAN</b></span> non &#232; corretto.<br/>";
                                    }

                                    if ($('#unico1').val() === "NO") {

                                        var Nome1 = document.getElementById("nomesogg1").value.trim();
                                        var Cognome1 = document.getElementById("cognomesogg1").value.trim();
                                        var CF1 = document.getElementById("cfsogg1").value.trim();
                                        var ComuneCF1 = document.getElementById("comunecfsogg1").value.trim();
                                        var Datanascita1 = document.getElementById("datanascitasogg1").value.trim();
                                        var Sesso1 = document.getElementById("sessosogg1").value.trim();

                                        if (!checkCF(CF1)) {
                                            output = "1";
                                            msg += "Soggetto Delegato 1. E' obbligatorio compilare il campo <b style='color:red;'>'Codice Fiscale'</b> con un valore corretto.<br/>";
                                        } else {
                                            var controllocf = controllaCF_delegato(CF1, Nome1, Cognome1, Datanascita1, Sesso1, ComuneCF1, "1");
                                            if (controllocf !== "") {
                                                output = "1";
                                                msg += controllocf;
                                            }
                                        }

                                        var Nome2 = document.getElementById("nomesogg2").value.trim();
                                        var Cognome2 = document.getElementById("cognomesogg2").value.trim();
                                        var CF2 = document.getElementById("cfsogg2").value.trim();
                                        var ComuneCF2 = document.getElementById("comunecfsogg2").value.trim();
                                        var Datanascita2 = document.getElementById("datanascitasogg2").value.trim();
                                        var Sesso2 = document.getElementById("sessosogg2").value.trim();

                                        if (Nome2 !== "" || Cognome2 !== "" || CF2 !== "" || ComuneCF2 !== "" || Datanascita2 !== "" || Sesso2 !== "") {
                                            if (Nome2 === "" || Cognome2 === "" || CF2 === "" || ComuneCF2 === "" || Datanascita2 === "" || Sesso2 === "") {
                                                output = "1";
                                                msg += "Soggetto Delegato 2. E' obbligatorio compilare tutti i campi in quanto ne risulta almeno uno compilato.<br/>";
                                            } else {
                                                if (!checkCF(CF2)) {
                                                    output = "1";
                                                    msg += "Soggetto Delegato 2. E' obbligatorio compilare il campo <b style='color:red;'>'Codice Fiscale'</b> con un valore corretto.<br/>";
                                                } else {
                                                    var controllocf = controllaCF_delegato(CF2, Nome2, Cognome2, Datanascita2, Sesso2, ComuneCF2, "2");
                                                    if (controllocf !== "") {
                                                        output = "1";
                                                        msg += controllocf;
                                                    }
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
                                }
                            </script>
                            <div class="portlet-body">
                                <form name="formregist" role="form" action="Operazioni?action=allegato_C2" method="post" 
                                      class="form-horizontal" id="formModelloC2" onsubmit="return controllac2();">
                                    <input type="hidden" name="username" value="<%=username%>"/>

                                    <div class="form-body">
                                        <h3 class="form-section">Dati Richiedente 
                                            <small>
                                                <i class="fa fa-info-circle popovers" data-trigger="hover" data-container="body" data-placement="bottom"
                                                   data-content="NELLA SEZIONE 'DATI RICHIEDENTE' VANNO INSERITI I DATI DEL FIRMATARIO DELLA DOMANDA DI ACCREDITAMENTO." 
                                                   data-original-title="INFO"></i>
                                            </small>
                                        </h3>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                Provincia di Nascita<span class="font-red popovers" data-trigger="hover" 
                                                                                          data-container="body" data-placement="bottom"
                                                                                          data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <select id="provincia1" name="provincia1" class="form-control select2" data-placeholder="..." required>
                                                                <option value="">...</option>
                                                                <%for (int p = 0; p < province.size(); p++) {%>
                                                                <option value="<%=StringEscapeUtils.escapeHtml4(province.get(p).getCodiceprovincia())%>"><%=StringEscapeUtils.escapeHtml4(province.get(p).getProvincia()).toUpperCase()%></option>
                                                                <%}%>
                                                            </select>
                                                            <script type="text/javascript">
                                                                $('#provincia1').select2({
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
                                                                Indirizzo di Residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                            data-container="body" data-placement="bottom"
                                                                                            data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <input type="text" class="form-control uppercase" 
                                                                   name="indirizzo1" placeholder="..." 
                                                                   id="indirizzo1" maxlength="100" required />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                CAP di Residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                      data-container="body" data-placement="bottom"
                                                                                      data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <input type="text" class="form-control uppercase" 
                                                                   name="cap1" placeholder="..." 
                                                                   id="cap1" maxlength="6" onchange="return fieldOnlyNumber(this.id);" required />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                Citt&#224; di Residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                             data-container="body" data-placement="bottom"
                                                                                             data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <input type="text" class="form-control uppercase" 
                                                                   name="citta1" placeholder="..." 
                                                                   id="citta1" maxlength="100" required />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row"><hr></div>
                                        <h3 class="form-section">Dati Bancari</h3>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                Nome Banca<span class="font-red popovers" data-trigger="hover" 
                                                                                data-container="body" data-placement="bottom"
                                                                                data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <input type="text" class="form-control uppercase" 
                                                                   name="nomebanca1" placeholder="..." 
                                                                   id="nomebanca1" maxlength="100" required />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                Nome Agenzia<span class="font-red popovers" data-trigger="hover" 
                                                                                  data-container="body" data-placement="bottom"
                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <input type="text" class="form-control uppercase" 
                                                                   name="nomeagenzia1" placeholder="..." 
                                                                   id="nomeagenzia1" maxlength="100" required />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                Intestatario<span class="font-red popovers" data-trigger="hover" 
                                                                                  data-container="body" data-placement="bottom"
                                                                                  data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <input type="text" 
                                                                   class="form-control uppercase" 
                                                                   name="intest1" placeholder="..." 
                                                                   id="intest1" maxlength="100" required />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                IBAN<span class="font-red popovers" data-trigger="hover" 
                                                                          data-container="body" data-placement="bottom"
                                                                          data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <div class="input-icon right">
                                                                <i id="check_iban1" class="fa"></i>
                                                                <input type="text" class="form-control" 
                                                                       name="iban1" placeholder="..." 
                                                                       id="iban1"
                                                                       maxlength="30" required />
                                                            </div>
                                                            <script type="text/javascript">
                                                                $('#iban1').on('keyup', function () {

                                                                    if (this.value.length > 0) {
                                                                        var valid = checkIBAN(this);
                                                                        if (!valid) {
                                                                            $('#' + 'check_iban1').removeClass("fa-check");
                                                                            $('#' + 'check_iban1').removeClass("font-green-jungle");
                                                                            $('#' + 'check_iban1').addClass("fa-times");
                                                                            $('#' + 'check_iban1').addClass("font-red");
                                                                        } else {
                                                                            $('#' + 'check_iban1').addClass("fa-check");
                                                                            $('#' + 'check_iban1').addClass("font-green-jungle");
                                                                            $('#' + 'check_iban1').removeClass("fa-times");
                                                                            $('#' + 'check_iban1').removeClass("font-red");
                                                                        }

                                                                    } else {
                                                                        $('#' + 'check_iban1').removeClass("fa-check");
                                                                        $('#' + 'check_iban1').removeClass("fa-times");
                                                                        $('#' + 'check_iban1').removeClass("font-green-jungle");
                                                                        $('#' + 'check_iban1').removeClass("font-red");
                                                                    }

                                                                });
                                                            </script>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <span class="help-block">
                                                                Unico soggetto titolato ad operare sul conto:<span class="font-red popovers" data-trigger="hover" 
                                                                                                                   data-container="body" data-placement="bottom"
                                                                                                                   data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                            </span>
                                                            <select id="unico1" name="unico1" class="form-control select2" data-placeholder="..." required>
                                                                <option value="">...</option>
                                                                <option value="SI">SI</option>
                                                                <option value="NO">NO</option>
                                                            </select>
                                                            <script type="text/javascript">
                                                                $('#unico1').select2({
                                                                    allowClear: true,
                                                                    theme: "classic",
                                                                    language: 'it'
                                                                });
                                                                $('#unico1').on('select2:select', function (e) {
                                                                    var data = e.params.data;
                                                                    if (data.text === "SI") {
                                                                        $('#delegatosino').toggle(false);
                                                                        $('#delegatosino').find('input').val('');
                                                                        $('#delegatouno').find('input').removeAttr('required');
                                                                        $('#delegatosino').find('select').val($(this).find('option:first-child').val()).trigger('change');
                                                                        $('#delegatouno').find('select').removeAttr('required');
                                                                    } else if (data.text === "NO") {
                                                                        $('#delegatosino').toggle(true);
                                                                        $('#delegatouno').find('input').attr("required", true);
                                                                        $('#delegatouno').find('select').attr("required", true);
                                                                    }
                                                                });
                                                                $('#unico1').on("select2:unselecting", function (e) {
                                                                    $('#delegatosino').toggle(false);
                                                                    $('#delegatosino').find('input').val('');
                                                                    $('#delegatouno').find('input').removeAttr('required');
                                                                    $('#delegatosino').find('select').val($(this).find('option:first-child').val()).trigger('change');
                                                                    $('#delegatouno').find('select').removeAttr('required');
                                                                });
                                                            </script>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="delegatosino" style="display:none;">
                                            <h4 class="form-section">Soggetto Delegato 1</h4>
                                            <div class="row" id="delegatouno">
                                                <div class="col-md-12">
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Nome<span class="font-red popovers" data-trigger="hover" 
                                                                              data-container="body" data-placement="bottom"
                                                                              data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="nomesogg1" placeholder="..." 
                                                                       id="nomesogg1" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Cognome<span class="font-red popovers" data-trigger="hover" 
                                                                                 data-container="body" data-placement="bottom"
                                                                                 data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="cognomesogg1" placeholder="..." 
                                                                       id="cognomesogg1" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Codice Fiscale<span class="font-red popovers" data-trigger="hover" 
                                                                                        data-container="body" data-placement="bottom"
                                                                                        data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="cfsogg1" placeholder="..." 
                                                                       id="cfsogg1" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Comune di Nascita <span class="font-red popovers" data-trigger="hover" 
                                                                                            data-container="body" data-placement="bottom"
                                                                                            data-content="CAMPO OBBLIGATORIO"> &#42;</span><small>(per stranieri indicare la NAZIONE)</small>
                                                                </span>
                                                                <input type="hidden" id="comunecfsogg1" name="comunecfsogg1" />
                                                                <select id="comunesogg1" name="comunesogg1" class="form-control select2" data-placeholder="..." style="width:100%"></select>
                                                                <script type="text/javascript">
                                                                    $('#comunesogg1').select2({
                                                                        allowClear: true,
                                                                        minimumInputLength: 3,
                                                                        placeholder: "Seleziona Comune",
                                                                        language: 'it',
                                                                        width: 'resolve',
                                                                        theme: "classic",
                                                                        ajax: {
                                                                            url: "Query?tipo=comuninazioni",
                                                                            dataType: 'json',
                                                                            delay: 250,
                                                                            data: function (params) {
                                                                                return {
                                                                                    q: params.term,
                                                                                    page: params.page
                                                                                };
                                                                            },
                                                                            processResults: function (data, params) {
                                                                                params.page = params.page || 1;
                                                                                return {
                                                                                    results: data.items,
                                                                                    pagination: {
                                                                                        more: (params.page * 30) < data.total_count
                                                                                    }
                                                                                };
                                                                            },
                                                                            cache: true
                                                                        },
                                                                        escapeMarkup: function (markup) {
                                                                            return markup; // let our custom formatter work
                                                                        },
                                                                        templateResult: function (repo) {
                                                                            if (repo.loading)
                                                                                return repo.text;
                                                                            return repo.full_name;
                                                                        },
                                                                        templateSelection: function (repo) {
                                                                            return repo.full_name || repo.text;
                                                                        }
                                                                    });

                                                                    $('#comunesogg1').on('select2:select', function (e) {
                                                                        var data = e.params.data;
                                                                        $('#comunecfsogg1').val(data.cf);
                                                                    });

                                                                    $('#comunesogg1').on("select2:unselecting", function (e) {
                                                                        $('#comunecfsogg1').val('');
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
                                                                    Data di Nascita<span class="font-red popovers" data-trigger="hover" 
                                                                                         data-container="body" data-placement="bottom"
                                                                                         data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input class="form-control form-control-inline date-picker_rtop" 
                                                                       size="16" type="text" id="datanascitasogg1" name="datanascitasogg1" maxlength="10"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Sesso<span class="font-red popovers" data-trigger="hover" 
                                                                               data-container="body" data-placement="bottom"
                                                                               data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <select id="sessosogg1" name="sessosogg1" class="form-control select2" 
                                                                        data-placeholder="..." style="width:100%">
                                                                    <option value="">...</option>
                                                                    <option value="M">MASCHILE</option>
                                                                    <option value="F">FEMMINILE</option>
                                                                </select>
                                                                <script type="text/javascript">
                                                                    $('#sessosogg1').select2({
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
                                                                    Indirizzo di residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                                data-container="body" data-placement="bottom"
                                                                                                data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="indirizzosogg1" placeholder="..." 
                                                                       id="indirizzosogg1" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Citt&#224; di Residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                                 data-container="body" data-placement="bottom"
                                                                                                 data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="cittasogg1" placeholder="..." 
                                                                       id="cittasogg1" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <h4 class="form-section">Soggetto Delegato 2</h4>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Nome<span class="font-red popovers" data-trigger="hover" 
                                                                              data-container="body" data-placement="bottom"
                                                                              data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="nomesogg2" placeholder="..." 
                                                                       id="nomesogg2" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Cognome<span class="font-red popovers" data-trigger="hover" 
                                                                                 data-container="body" data-placement="bottom"
                                                                                 data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="cognomesogg2" placeholder="..." 
                                                                       id="cognomesogg2" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Codice Fiscale<span class="font-red popovers" data-trigger="hover" 
                                                                                        data-container="body" data-placement="bottom"
                                                                                        data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="cfsogg2" placeholder="..." 
                                                                       id="cfsogg2" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Comune di Nascita <span class="font-red popovers" data-trigger="hover" 
                                                                                            data-container="body" data-placement="bottom"
                                                                                            data-content="CAMPO OBBLIGATORIO"> &#42;</span><small>(per stranieri indicare la NAZIONE)</small>
                                                                </span>
                                                                <input type="hidden" id="comunecfsogg2" name="comunecfsogg2" />
                                                                <select id="comunesogg2" name="comunesogg2" class="form-control select2" data-placeholder="..." style="width:100%"></select>
                                                                <script type="text/javascript">
                                                                    $('#comunesogg2').select2({
                                                                        allowClear: true,
                                                                        minimumInputLength: 3,
                                                                        placeholder: "Seleziona Comune",
                                                                        language: 'it',
                                                                        width: 'resolve',
                                                                        theme: "classic",
                                                                        ajax: {
                                                                            url: "Query?tipo=comuninazioni",
                                                                            dataType: 'json',
                                                                            delay: 250,
                                                                            data: function (params) {
                                                                                return {
                                                                                    q: params.term,
                                                                                    page: params.page
                                                                                };
                                                                            },
                                                                            processResults: function (data, params) {
                                                                                params.page = params.page || 1;
                                                                                return {
                                                                                    results: data.items,
                                                                                    pagination: {
                                                                                        more: (params.page * 30) < data.total_count
                                                                                    }
                                                                                };
                                                                            },
                                                                            cache: true
                                                                        },
                                                                        escapeMarkup: function (markup) {
                                                                            return markup; // let our custom formatter work
                                                                        },
                                                                        templateResult: function (repo) {
                                                                            if (repo.loading)
                                                                                return repo.text;
                                                                            return repo.full_name;
                                                                        },
                                                                        templateSelection: function (repo) {
                                                                            return repo.full_name || repo.text;
                                                                        }
                                                                    });

                                                                    $('#comunesogg2').on('select2:select', function (e) {
                                                                        var data = e.params.data;
                                                                        $('#comunecfsogg2').val(data.cf);
                                                                    });

                                                                    $('#comunesogg2').on("select2:unselecting", function (e) {
                                                                        $('#comunecfsogg2').val('');
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
                                                                    Data di Nascita<span class="font-red popovers" data-trigger="hover" 
                                                                                         data-container="body" data-placement="bottom"
                                                                                         data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input class="form-control form-control-inline date-picker_rtop" 
                                                                       size="16" type="text" id="datanascitasogg2" name="datanascitasogg2" maxlength="10"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Sesso<span class="font-red popovers" data-trigger="hover" 
                                                                               data-container="body" data-placement="bottom"
                                                                               data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <select id="sessosogg2" name="sessosogg2" class="form-control select2" 
                                                                        data-placeholder="..." style="width:100%">
                                                                    <option value="">...</option>
                                                                    <option value="M">MASCHILE</option>
                                                                    <option value="F">FEMMINILE</option>
                                                                </select>
                                                                <script type="text/javascript">
                                                                    $('#sessosogg2').select2({
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
                                                                    Indirizzo di residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                                data-container="body" data-placement="bottom"
                                                                                                data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="indirizzosogg2" placeholder="..." 
                                                                       id="indirizzosogg2" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <span class="help-block">
                                                                    Citt&#224; di Residenza<span class="font-red popovers" data-trigger="hover" 
                                                                                                 data-container="body" data-placement="bottom"
                                                                                                 data-content="CAMPO OBBLIGATORIO"> &#42;</span>
                                                                </span>
                                                                <input type="text" class="form-control uppercase" 
                                                                       name="cittasogg2" placeholder="..." 
                                                                       id="cittasogg2" maxlength="100" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row"><hr></div>
                                        <div class="col-md-2 col-md-offset-5">
                                            <button type="submit" class="btn btn-lg green-jungle btn-block"><i class="fa fa-save"></i>
                                                Salva dati</button></center>   
                                        </div> 
                                    </div> 
                                </form>                          
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-2">
                                    <a class="btn btn btn-lg btn-block blue-hoki" href="bando_index.jsp"><i class="fa fa-arrow-left"></i> Indietro</a>
                                </div>                                                   
                            </div>                                                   
                        </div>
                    </div>

                    <%} else {%>
                    <script>
                        location.href = "bando_index.jsp";
                    </script>
                    <%}%>
                </div>  
            </div>
        </div>

        <!-- END CONTENT -->
        <!-- BEGIN QUICK SIDEBAR -->
        <!-- END QUICK SIDEBAR -->
    </div>
    <!-- END CONTAINER -->
    <!-- BEGIN FOOTER -->


</body>
</html>
<%}%>