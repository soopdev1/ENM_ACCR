/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.servlet;

import static rc.soop.action.ActionB.newsessionid;
import static rc.soop.action.ActionB.trackingAction;
import static rc.soop.action.Constant.errLogin;
import static rc.soop.action.Constant.homePage;
import static rc.soop.action.Constant.homePageAz;
import static rc.soop.action.Constant.homePageRup;
import static rc.soop.action.Constant.otp;
import static rc.soop.action.Constant.reset;
import static rc.soop.action.Constant.timestampSQL;
import rc.soop.db.Db_Bando;
import rc.soop.entity.UserBando;
import static rc.soop.util.Utility.redirect;
import static rc.soop.otp.OTP.verificaOTP;
import static rc.soop.util.SendMailJet.sendMail;
import static rc.soop.util.Utility.convMd5;
import static rc.soop.util.Utility.getRequestValue;
import static rc.soop.util.Utility.printClientInfo;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import static org.apache.commons.lang3.StringUtils.remove;
import static org.apache.commons.lang3.StringUtils.replace;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.joda.time.DateTime;

/**
 *
 * @author Administrator
 */
@SuppressWarnings("serial")
public class LoginOperations extends HttpServlet {

    //LOGOUT
    protected void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("username") == null) {
            redirect(request, response, "home.jsp");
        } else {
            trackingAction(request.getSession().getAttribute("username").toString(), "Logout portale - INFO: " + printClientInfo(request));
            request.getSession().setAttribute("bandorif", null);
            request.getSession().setAttribute("statouser", null);
            request.getSession().setAttribute("username", null);
            request.getSession().setAttribute("lang", null);
            request.getSession().setAttribute("numcell", null);
            request.getSession().setAttribute("indemail", null);
            request.getSession().setAttribute("tipo", null);
            request.getSession().invalidate();
            request.getSession().setMaxInactiveInterval(1);
            redirect(request, response, "home.jsp");
        }
    }

    //redirect alla pagina desiderata
    private String getSiteRedirect(String stato, String tipo) {

        if (tipo.equals("0")) { //    UTENTE
            switch (stato) {
                case "0" -> {
                    return otp;
                }
                case "2" -> {
                    //resetPass
                    return reset;
                }
                case "1" -> {
                    return homePage;
                }
                default -> {
                }
            }
        }
        if (tipo.equals("1")) { //    RUP
            if (stato.equals("2")) { // resetPass
                return reset;
            } else if (stato.equals("1")) {
                return homePageRup;
            }
        }
        if (tipo.equals("2")) {
            switch (stato) {
                case "0" -> {
                    return otp;
                }
                case "2" -> {
                    //resetPass
                    return reset;
                }
                case "1" -> {
                    return homePageAz;
                }
                default -> {
                }
            }
        }
        return errLogin + "KO5";
    }

    //RESET
    //Changepsw
    //controllo OTP
    protected void otpbando(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("username") == null) {
            redirect(request, response, "home.jsp");
        } else {
            String user = request.getSession().getAttribute("username").toString();
            String bando = request.getSession().getAttribute("bandorif").toString();
            String tipo = request.getSession().getAttribute("tipo").toString();
            String otp = getRequestValue(request, "otp");

            if (otp == null || otp.trim().equals("")) {
                redirect(request, response, otp + "?esito=KO1");
            } else {
                boolean esito = verificaOTP(bando, otp, user, 1);
                if (esito) {
                    Db_Bando dbb = new Db_Bando();
                    boolean es = dbb.cambiaValoreUser(user, "stato", "1");
                    dbb.closeDB();
                    trackingAction(request.getSession().getAttribute("username").toString(), "Verifica OTP");
                    if (es) {
                        redirect(request, response, getSiteRedirect("1", tipo));
                    } else {
                        redirect(request, response, otp + "?esito=KO2");
                    }
                } else {
                    redirect(request, response, otp + "?esito=KO3");
                }
            }
        }
    }

    //LOGIN
    protected void loginBando(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String user = getRequestValue(request, "username");
        String pass = getRequestValue(request, "password");

        if (user != null && pass != null) {
            if (!user.trim().equals("") && !pass.trim().equals("")) {
                String password = convMd5(pass);
                Db_Bando dbb = new Db_Bando();
                UserBando ub = dbb.getUser(user, password);
                dbb.closeDB();
                if (ub != null) {
//                    HttpSessionCollector.print();
                    newsessionid(request.getSession().getId(), user, new DateTime(request.getSession().getCreationTime()).toString(timestampSQL));
                    request.getSession().setAttribute("bandorif", ub.getCodiceBando());
                    request.getSession().setAttribute("statouser", ub.getStato());
                    request.getSession().setAttribute("username", ub.getUsername());
                    request.getSession().setAttribute("lang", "IT");
                    request.getSession().setAttribute("numcell", ub.getCell());
                    request.getSession().setAttribute("indemail", ub.getMail());
                    request.getSession().setAttribute("tipo", ub.getTipo());
                    request.getSession().setAttribute("sino", ub.getSino());
                    trackingAction(ub.getUsername(), "Login Portale - INFO: " + printClientInfo(request));
                    redirect(request, response, getSiteRedirect(ub.getStato(), ub.getTipo()));
                } else {
                    redirect(request, response, errLogin + "KO1");
                }
            } else {
                redirect(request, response, errLogin + "KO2");
            }
        } else {
            redirect(request, response, errLogin + "KO3");
        }
    }

    //RESET PASSWORD
    protected void checkusr(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = getRequestValue(request, "usrreset");

        Db_Bando dbb = new Db_Bando();
        UserBando ub = dbb.getUser(username);

        try (PrintWriter pw = response.getWriter()) {
            if (ub == null) {
                pw.write("KO");
            } else {
                String newp = dbb.changeUserPassword(username);
                if (newp != null) {
                    String linkweb = dbb.getPath("linkweb");
                    String linknohttpweb = remove(linkweb, "https://");
                    String dest[] = {ub.getMail()};
                    String mailreg = replace(dbb.getPath("mail.resetpassword"), "@username", username);
                    mailreg = replace(mailreg, "@password", newp);
                    mailreg = replace(mailreg, "@linkweb", linkweb);
                    mailreg = replace(mailreg, "@linknohttpweb", linknohttpweb);

                    if (!mailreg.equals("-")) {
                        String mailsender = dbb.getPath("mailsender");
                        try {
                            boolean es = sendMail(mailsender, dest, new String[]{}, mailreg, mailsender + " Reset Password");
                            if (es) {
                                trackingAction("service", "Reset Password OK" + username);
                                pw.write("OK");
                            } else {
                                pw.write("KO_4");
                                trackingAction("service", "resetPassword - Error: MAIL");
                            }
                        } catch (Exception e) {
                            pw.write("KO_3");
                            trackingAction("service", "resetPassword - Error: MAIL " + ExceptionUtils.getStackTrace(e));
                        }
                    } else {
                        trackingAction("service", "resetPassword - Error: MAIL DB NOT FOUND");
                        pw.write("KO_2");
                    }
                } else {
                    pw.write("KO_1");
                }
            }
            dbb.closeDB();
        }
    }

    protected void reset(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = getRequestValue(request, "usrreset");

        Db_Bando dbb = new Db_Bando();
        UserBando ub = dbb.getUser(username);
        dbb.closeDB();

        if (ub != null) {

        } else {
            redirect(request, response, "home.jsp?esito=KO1");
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        try {
            String param = request.getParameter("type");
            if (param == null) {
                param = "";
            }
            if (param.equals("out")) {
                logout(request, response);
            }
            if (param.equals("log")) {
                loginBando(request, response);
            }
            if (param.equals("otp")) {
                otpbando(request, response);
            }
            if (param.equals("reset")) {
                reset(request, response);
            }
            if (param.equals("checkusr")) {
                checkusr(request, response);
            }

        } catch (ServletException | IOException ex) {
            trackingAction("service", "Error:LoginOperation: " + ex.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
