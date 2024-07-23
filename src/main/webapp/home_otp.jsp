<%@page import="rc.soop.action.Label"%>
<%@page import="rc.soop.action.Constant"%>
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
        <link href="Bootstrap2024/assets/css/bootstrap-italia.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN PAGE LEVEL STYLES -->
        <link href="assets/pages/css/login-2.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> </head>
    <script type="text/javascript" >
        function sel() {
            document.getElementById("otp").focus();
        }

    </script>
    <!-- END HEAD -->

    <body class=" login" onload="sel();" style="background-image: url(assets/pages/img/bg-3.jpg);">
        <!-- BEGIN LOGO -->
        <%@include file="Bootstrap2024/index/index_SoggettoAttuatore/Header_soggettoAttuatore.jsp" %>
        <div class="logo">
            <img src="assets/soop/img/l2-EU.jpg" alt="" height="54px"/>
            <img src="assets/soop/img/l3-ML.jpg" alt="" height="54px"/>
            <img src="assets/soop/img/l7-AN.png" alt="" height="54px"/>
            <img src="assets/soop/img/l6-GO.jpg" alt="" height="54px"/>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            <!-- BEGIN LOGIN FORM -->
            <form class="form-resetPass"action="LoginOperations?type=otp" method="post" role="form" >
                <hr>

                <div class="text-center">
                    <span class="bold text-center text-primary center-block h3">YES I STARTUP TOSCANA <br>CONFERMA REGISTRAZIONE</span>
                        <%if (Constant.test) {%>
                    <br>
                    <span class="bold text-center text-primary center-block"><img src="assets/soop/img/beta.png" alt="" height="100"/></span>
                        <%}%>
                </div>
                <div class="alert alert-danger display-hide">
                    <button class="close" data-close="alert"></button>
                    <span>Inserire Username e Password</span>
                </div>

                <%if (request.getParameter("esito") != null) {%>
                <div class="alert alert-danger text-justify">
                    <strong>Errore!</strong> Codice OTP errato o non conforme a quanto richiesto, riprovare.
                </div>
                <%
                    }%>
                <div class="form-group text-center">
                    <label class="control-label text-primary">Inserire la Password Temporanea ricevuta per SMS</label>
                </div>
                <div>
                    <hr>
                </div>
                <div class="form-group">
                    <div class="input-group" id="show_hide_password">
                        <input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Password Temporanea" type="text" id="otp" name="otp" />
                        <div class="input-group-addon">
                            <a href=""><i class="fa fa-eye-slash" aria-hidden="true"></i></a>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn red btn-block uppercase">Conferma</button>
                    <hr>
                    <a href="home.jsp" class="btn blue btn-block uppercase"><i class="fa fa-home"></i> Homepage</a>
                </div>
            </form>
            <hr>
            <!-- END LOGIN FORM -->
            <!-- BEGIN FORGOT PASSWORD FORM -->
        </div>

        <div class="logo"> 
            <img src="assets/soop/img/l4-RT.jpg" alt="" height="54px"/>
            <img src="assets/soop/img/l1-AR.png" alt="" height="34px"/>
            <img src="assets/soop/img/logo_blue_1.png" alt="" height="54px"/>
        </div>
        <%@include file="Bootstrap2024/index/login/Footer_login.jsp" %>
        <!-- END LOGIN -->
        <!--[if lt IE 9]>
<script src="../assets/global/plugins/respond.min.js"></script>
<script src="../assets/global/plugins/excanvas.min.js"></script> 
<![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <!-- END THEME LAYOUT SCRIPTS -->

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

    </body>

</html>