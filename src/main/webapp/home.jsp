<%@page import="rc.soop.action.ActionB"%>
<%@page import="rc.soop.action.Label"%>
<%@page import="rc.soop.action.Constant"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

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
        <link href="assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <link rel="stylesheet" href="Bootstrap2024/assets/css/bootstrap-italia.min.css"/>
        <!-- BEGIN PAGE LEVEL STYLES -->
        <link href="assets/pages/css/login-2.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 
        
    </head>
    <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" >
        function sel() {
            document.getElementById("us1").focus();
        }
        function checkusr() {
            var usr1 = $('#usrreset').val().trim();
            var er1 = 0;
            $.ajax({
                async: false,
                type: "POST",
                url: "LoginOperations",
                data: {type: "checkusr", usrreset: usr1},
                success: function (data) {
                    if (data === 'KO') {
                        er1++;
                    } else if (data === 'OK') {
                    } else {
                        er1--;
                    }
                },
                dataType: "text"
            });
            if (er1 > 0) {
                $('#alerterrreset1').toggle(true);
            } else if (er1 < 0) {
                $('#alerterrreset2').toggle(true);
            } else {
                document.getElementById('closemodal1').click();
                document.getElementById('okmodalbutton').click();
            }
            return false;
        }

        function clearalert() {
            $('#alerterrreset1').toggle(false);
            $('#alerterrreset2').toggle(false);
        }
    </script>
    <!-- END HEAD -->
    <body class="login" onload="sel();"
          style="background-image: url(assets/pages/img/bg-3.jpg);"
          >
        <%@include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp" %>
        <div class="fade" tabindex="-1" aria-hidden="true">
            <button type="button" id="okmodalbutton" data-toggle="modal" data-target="#okmodal">
                Launch demo modal
            </button>
        </div>
        <div class="modal fade" id="okmodal" tabindex="-1" role="dialog" aria-labelledby="okmodalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="okmodalLabel">RESET PASSWORD</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span class="text-success_r">
                            <i class="fa fa-check-circle"></i> <b>RESET PASSWORD AVVENUTO CON SUCCESSO!</b><br> CONTROLLARE LA PROPRIA CASELLA EMAIL (anche la cartella SPAM).
                        </span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-remove"></i> CHIUDI</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="exampleModalLabel">RESET PASSWORD</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="LoginOperations?type=reset" method="post" onsubmit="return checkusr();">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="usrreset">Username:</label>
                                <input type="text" class="form-control" name="usrreset" id="usrreset" aria-describedby="usrresetHelp" placeholder="Enter your username" autocomplete="off" required onkeyup="return clearalert();" />
                                <small id="usrresetHelp" class="form-text text-muted">A new password will be sent to the email address associated with the entered username.</small>
                            </div>
                            <div class="alert alert-warning" role="alert" id="alerterrreset1" style="display: none;">
                                <strong>Attention!</strong> The entered username is not present. Please try again.
                            </div>
                            <div class="alert alert-warning" role="alert" id="alerterrreset2" style="display: none;">
                                <strong>Attention!</strong> Unable to reset the password. Please try again.
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="closemodal1" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
                            <button type="submit" class="btn btn-success"><i class="fa fa-paper-plane"></i> Send New Password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- BEGIN LOGO -->
        <div class="logo" style="padding: 0px; margin-top: 10px;">
            <img src="assets/soop/img/l2-EU.jpg" alt="" height="54px"/>
            <img src="assets/soop/img/l3-ML.jpg" alt="" height="54px"/>
            <img src="assets/soop/img/l7-AN.png" alt="" height="54px"/>
            <img src="assets/soop/img/l6-GO.jpg" alt="" height="54px"/>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            <!-- BEGIN LOGIN FORM -->
            <form class="login-form" action="LoginOperations?type=log" method="post">
                <div id="widget">
                    <hr>
                    <div class="text-center mb-4">
                        <span class="font-weight-bold text-primary h3">YES I STARTUP TOSCANA</span>
                        <%if (Constant.test) {%>
                        <br>
                        <span class="font-weight-bold text-primary"><img src="assets/soop/img/beta.png" alt="" height="100"/></span>
                            <%}%>
                    </div>
                    <hr>
                    <div class="alert alert-danger d-none" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <span>Inserire Username e Password</span>
                    </div>
                    <%
                        boolean check = Constant.checkRegistrazione();
                        if (request.getParameter("esito") != null) {
                            if (request.getParameter("esito").equals("okr1")) {
                                if (check) {%>
                    <div class="alert alert-success text-justify" role="alert">
                        Nuovo candidato accreditato con successo!
                        <br>Ti abbiamo inviato una mail con  le credenziali di accesso (controlla anche nello spam). <br>
                        Ti abbiamo anche  inviato un sms con la password temporanea da inserire al primo accesso.<br>
                        Tale password deve essere utilizzata entro 12 ore.
                    </div>
                    <%} else {%>
                    <div class="alert alert-success text-justify" role="alert">
                        Nuovo candidato accreditato con successo!
                        <br>
                        Ti abbiamo inviato una mail le istruzioni da seguire quando l'accreditamento verr&#224; attivato.
                    </div>
                    <%}%>
                    <%} else if (request.getParameter("esito").equals("okr2")) {
                    } else {%>
                    <div class="alert alert-danger text-justify" role="alert">
                        <strong>Errore!</strong> <%=Label.getMessageLogin(StringEscapeUtils.escapeHtml4("IT"), StringEscapeUtils.escapeHtml4(request.getParameter("esito")))%>
                    </div>
                    <%}
                        }%>
                    <div class="form-group">
                        <label class="control-label d-block d-lg-none text-uppercase">Username</label>
                        <input class="form-control form-control-solid border border-primary placeholder-no-fix" type="text" autocomplete="off" placeholder="USERNAME" name="username" id="us1" required />
                    </div>
                    <div class="form-group">
                        <label class="control-label d-block d-lg-none text-uppercase">Password</label>
                        <div class="input-group" id="show_hide_password">
                            <input class="form-control form-control-solid border border-primary placeholder-no-fix" type="password" autocomplete="off" placeholder="PASSWORD" id="password" name="password" required />
                        </div>
                    </div>

                    <div class="form-actions row">
                        <%if (check) {%>
                        <div class="col-md-2 p-0">
                            <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModal" data-toggle="popover" title="Password dimenticata?" data-placement="top" data-trigger="hover" data-content="Clicca per ricevere una nuova password di accesso." onclick="return $('#usrreset').val('');">
                                <i class="fa fa-key"></i>
                            </button>
                        </div>
                        <div class="col-md-9 ml-auto p-0">
                            <button type="submit" class="btn btn-danger">LOGIN</button>
                        </div>
                        <%} else {%>
                        <a href="#" class="btn btn-danger text-uppercase" onclick="return false;" data-toggle="popover" title="<i class='fa fa-exclamation-triangle text-danger'></i> <b>ATTENZIONE!!!</b>" data-placement="top" data-trigger="hover" data-content="L'accesso sar&#224; attivo a partire dal <b><%=Constant.datainizio%></b>">LOGIN</a>
                        <%}%>
                    </div>
                </div>
            </form>

            <hr>

            <form id="link1" action="bando_reg.jsp" method="post">
                <input type="hidden" name="bando" value="<%=Constant.bando%>"/>
                <div class="create-account">
                    <p>
                        <button type="submit" class="btn btn-primary uppercase">Accreditati al Bando</button>
                    </p>
                </div>
            </form>

            <hr>
            <div class="copyright text-dark"> 
                <%boolean guidaok = ActionB.getPath("pdf.guida") != null;%>
                <div>
                    <div class="col-md-6">
                        <strong> 
                            <a class="uppercase" href="faq_public.jsp"  style="text-decoration: none;"><i class="fa fa-question-circle-o"></i> FAQ</a>
                        </strong>
                    </div>
                    <%if (guidaok) {%>
                    <div class="col-md-6">
                        <strong> 
                            <a class="uppercase" href="Download?action=guida" target="_blank" style="text-decoration: none;">
                                <i class="fa fa-file-pdf-o"></i> Guida
                            </a>
                        </strong>
                    </div>
                    <%}%>
                </div>

                <div class="logo"> 
                    <img src="assets/soop/img/l4-RT.jpg" alt="" height="54px"/>
                    <img src="assets/soop/img/l1-AR.png" alt="" height="34px"/>
                    <img src="assets/soop/img/logo_blue_1.png" alt="" height="54px"/>
                </div>
                <div class="logo">
                    <%
                        String link = ActionB.getPath("linkmanuale");
                        if (link != null) {%>
                    <iframe height="150" src="https://www.youtube.com/embed/8x-em_a9dGQ" frameborder="0" 
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>

                    </iframe>

                    <%}%> </div>

            </div>
        </div>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>

        <!-- END LOGIN -->
        <!--[if lt IE 9]>
    <script src="../assets/global/plugins/respond.min.js"></script>
    <script src="../assets/global/plugins/excanvas.min.js"></script> 
    <![endif]-->
        <!-- BEGIN CORE PLUGINS -->

        <script src="Bootstrap2024/assets/js/bootstrap-italia.bundle.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>

        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/soop/js/jquery351.min.js"></script>
        <script src="assets/soop/js/bootstrap341.min.js"></script>
        <script>
                            $(document).ready(function () {
                                $('[data-toggle="popover"]').popover();
                            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#show_hide_password a").on('click', function (event) {
                    event.preventDefault();
                    if ($('#show_hide_password input').attr("type") === "text") {
                        $('#show_hide_password input').attr('type', 'password');
                        $('#show_hide_password i').addClass("fa-eye-slash");
                        $('#show_hide_password i').removeClass("fa-eye");
                    } else if ($('#show_hide_password input').attr("type") === "password") {
                        $('#show_hide_password input').attr('type', 'text');
                        $('#show_hide_password i').removeClass("fa-eye-slash");
                        $('#show_hide_password i').addClass("fa-eye");
                    }
                });
            });

        </script>



        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <!-- END THEME LAYOUT SCRIPTS -->

    </body>

</html>