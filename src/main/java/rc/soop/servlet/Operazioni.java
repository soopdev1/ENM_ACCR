/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.servlet;

import rc.soop.action.ActionB;
import static rc.soop.action.ActionB.checkfileuploadmultiplo;
import static rc.soop.action.ActionB.delAllAllegatiDocenti;
import static rc.soop.action.ActionB.delAllegatiDocenti;
import static rc.soop.action.ActionB.delAllegatoB1Field;
import static rc.soop.action.ActionB.domandaAnnullata;
import static rc.soop.action.ActionB.esisteAllegatoB1;
import static rc.soop.action.ActionB.generateUsername;
import static rc.soop.action.ActionB.getSino;
import static rc.soop.action.ActionB.insAllegatoA;
import static rc.soop.action.ActionB.insAllegatoB;
import static rc.soop.action.ActionB.insAllegatoB1;
import static rc.soop.action.ActionB.insertAllegatoC2;
import static rc.soop.action.ActionB.insertDocUserBando;
import static rc.soop.action.ActionB.isPresenteUsername;
import static rc.soop.action.ActionB.preparefileforupload;
import static rc.soop.action.ActionB.remDocConvenzioni;
import static rc.soop.action.ActionB.removeSingleDocUserBando;
import static rc.soop.action.ActionB.setStatoDomandaAccRif;
import static rc.soop.action.ActionB.setStatoInvioDocumenti;
import static rc.soop.action.ActionB.settaInvioEmailROMA;
import static rc.soop.action.ActionB.trackingAction;
import static rc.soop.action.ActionB.verificaBando;
import static rc.soop.action.ActionB.verificaInvioConvenzione;
import rc.soop.action.Constant;
import static rc.soop.action.Constant.bando;
import static rc.soop.action.Constant.checkRegistrazione;
import static rc.soop.action.Constant.datainizio;
import static rc.soop.action.Constant.timestampSQL;
import static rc.soop.action.Pdf_new.allegatoB1;
import rc.soop.db.Db_Bando;
import rc.soop.entity.AllegatoB;
import rc.soop.entity.AllegatoC2;
import rc.soop.entity.Docuserbandi;
import rc.soop.entity.Domandecomplete;
import rc.soop.entity.FileDownload;
import rc.soop.entity.UserBando;
import rc.soop.entity.UserValoriReg;
import rc.soop.otp.Db_OTP;
import static rc.soop.util.Utility.convMd5;
import static rc.soop.util.Utility.formatDate;
import static rc.soop.util.Utility.generaId;
import static rc.soop.util.Utility.redirect;
import static rc.soop.otp.OTP.generaOTP;
import static rc.soop.otp.OTP.verificaOTP;
import static rc.soop.otp.Sms.sendSMS2024;
import static rc.soop.util.GoogleRecaptcha.isValid;
import static rc.soop.util.SendMailJet.sendMail;
import static rc.soop.util.SendMailJet.sendMailListAttach;
import static rc.soop.util.Utility.createDir;
import static rc.soop.util.Utility.estraiEccezione;
import static rc.soop.util.Utility.getRequestCheckbox;
import static rc.soop.util.Utility.getRequestValue;
import static rc.soop.util.Utility.parseIntR;
import static rc.soop.util.Utility.randomP;
import static rc.soop.util.Utility.replaeSpecialCharacter;
import static rc.soop.util.Utility.utf8;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.joda.time.DateTime;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Thread.sleep;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.core.RequestContext;
import org.apache.commons.fileupload2.jakarta.JakartaServletFileUpload;
import static org.apache.commons.fileupload2.jakarta.JakartaServletFileUpload.isMultipartContent;
import static org.apache.commons.lang3.RandomStringUtils.random;
import static org.apache.commons.lang3.StringUtils.remove;
import static org.apache.commons.lang3.StringUtils.removeEnd;
import static org.apache.commons.lang3.StringUtils.replace;
import static org.apache.commons.validator.routines.EmailValidator.getInstance;
import org.json.JSONObject;
import static rc.soop.util.Utility.createFile;

/**
 *
 * @author raffaele
 */
@SuppressWarnings("serial")
public class Operazioni extends HttpServlet {

    private ArrayList<UserValoriReg> convertValori(ArrayList<String[]> valueUser, String dateReg, String bandorif, String username) {
        ArrayList<UserValoriReg> liout = new ArrayList<>();
        for (int i = 0; i < valueUser.size(); i++) {
            UserValoriReg uv = new UserValoriReg(bandorif, username, valueUser.get(i)[0], valueUser.get(i)[1], dateReg);
            liout.add(uv);
        }
        return liout;
    }

    protected void registraUtente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ok = "0";
        String gRecaptchaResponse = "";
        String bandorif = null;
        boolean isMultipart = isMultipartContent(request);
        if (isMultipart) {
            try {
                ArrayList<String[]> valueUser = new ArrayList<>();
                JakartaServletFileUpload upload = new JakartaServletFileUpload();
                List<FileItem> items = upload.parseRequest((RequestContext) request);
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        if (item.getFieldName().trim().equals("g-recaptcha-response")) {
                            gRecaptchaResponse = item.getString().trim();
                        } else if (!item.getFieldName().trim().equals("privacy1")) {
                            String[] val = {item.getFieldName().trim(), replaeSpecialCharacter(item.getString().trim())};
                            valueUser.add(val);
                        }
                    }
                }
                boolean verify = isValid(gRecaptchaResponse);
                if (verify) {
                    if (!valueUser.isEmpty()) {
                        String nome = null;
                        String cognome = null;
                        String numcell = null;
                        String email = null;
//                        String cf = null;
                        for (int i = 0; i < valueUser.size(); i++) {
                            if (valueUser.get(i)[0].trim().equals("bandorif")) {
                                bandorif = valueUser.get(i)[1];
                            }
                            if (valueUser.get(i)[0].trim().equals("nome")) {
                                nome = valueUser.get(i)[1];
                            }
                            if (valueUser.get(i)[0].trim().equals("cognome")) {
                                cognome = valueUser.get(i)[1];
                            }
                            if (valueUser.get(i)[0].trim().equals("cell")) {
                                numcell = valueUser.get(i)[1];
                            }
                            if (valueUser.get(i)[0].trim().equals("email")) {
                                email = valueUser.get(i)[1];
                            }
//                            if (valueUser.get(i)[0].trim().equals("cf")) {
//                                cf = valueUser.get(i)[1];
//                            }
                        }

                        Db_Bando dbb = new Db_Bando();
                        String linkweb = dbb.getPath("linkweb");
                        String linknohttpweb = remove(linkweb, "https://");
                        linknohttpweb = removeEnd(linknohttpweb, "/");
                        if (bandorif != null && email != null) {
                            if (verificaBando(bandorif)) {
                                String username = generateUsername(nome, cognome);
                                while (isPresenteUsername(username)) {
                                    username = generateUsername(nome, cognome);
                                }
                                if (getInstance().isValid(email)) {
                                    String pass = randomP();
                                    String passmd5 = convMd5(pass);
                                    String dateReg = new DateTime().toString("yyyy-MM-dd HH:mm:ss");
                                    UserBando ub = new UserBando(username, passmd5, bandorif, dateReg, numcell, email, "0", getSino(username));
                                    boolean ins = dbb.insertUserReg(ub);
                                    if (ins) {
                                        ArrayList<UserValoriReg> liout = convertValori(valueUser, dateReg, bandorif, username);
                                        int insert = dbb.insertUserRegistration(liout);
                                        if (insert > 0) {
                                            if (checkRegistrazione()) { // OK
                                                String esitoOTP = generaOTP(bandorif, numcell, username);
                                                if (esitoOTP.equals("SUCCESS")) {
                                                    String dest[] = {email};

                                                    String mailreg = replace(dbb.getPath("mail.registrazioneutente"), "@username", username);
                                                    mailreg = replace(mailreg, "@password", pass);
                                                    mailreg = replace(mailreg, "@linkweb", linkweb);
                                                    mailreg = replace(mailreg, "@linknohttpweb", linknohttpweb);

                                                    if (!mailreg.equals("-")) {
                                                        String mailsender = dbb.getPath("mailsender");
                                                        boolean es = sendMail(mailsender, dest, new String[]{}, mailreg, mailsender + " Registrazione");
                                                        if (es) {
                                                            trackingAction("service", "Registrato nuovo Utente: " + username);
                                                            ok = "1";
                                                        } else {
                                                            trackingAction("service", "registraUtente - Error: MAIL");
                                                            ok = "4";
                                                        }
                                                    } else {
                                                        trackingAction("service", "registraUtente - Error: MAIL DB NOT FOUND");
                                                        ok = "5";
                                                    }
                                                } else {
                                                    trackingAction("service", "registraUtente - Error: OTP");
                                                    ok = "3";
                                                }
                                            } else { //ALTRA EMAIL
                                                String dest[] = {email};

                                                String mailreg = replace(dbb.getPath("mail.registrazioneutente.datainizio"), "@datainizio", datainizio);
                                                mailreg = replace(mailreg, "@linkweb", linkweb);
                                                mailreg = replace(mailreg, "@linknohttpweb", linknohttpweb);
                                                if (!mailreg.equals("-")) {
                                                    String mailsender = dbb.getPath("mailsender");
                                                    boolean es = sendMail(mailsender, dest, new String[]{}, mailreg, mailsender + " Registrazione");
                                                    if (es) {
                                                        dbb.cambiaStatoUser(username, "R");
                                                        trackingAction("service", "Registrato nuovo Utente: " + username);
                                                        ok = "1";
                                                    } else {
                                                        trackingAction("service", "registraUtente - Error: MAIL");
                                                        ok = "4";
                                                    }
                                                } else {
                                                    trackingAction("service", "registraUtente - Error: MAIL DB NOT FOUND");
                                                    ok = "5";
                                                }
                                            }
                                        } else {
                                            trackingAction("service", "registraUtente - Error: INSERT REG");
                                            ok = "7";
                                        }
                                    } else {
                                        trackingAction("service", "registraUtente - Error: INSERT REG");
                                        ok = "7";
                                    }
                                } else {
                                    trackingAction("service", "registraUtente - Error: MAIL " + email);
                                    ok = "8";
                                }
                            } else {
                                trackingAction("service", "registraUtente - Error: BANDO ERROR");
                                ok = "9";
                            }
                        }
                        dbb.closeDB();
                    } else {
                        trackingAction("service", "registraUtente - Error: DB ERROR REG");
                        ok = "10";
                    }
                } else {
                    trackingAction("service", "registraUtente - Error: ROBOT GOOGLE");
                    ok = "2";
                }
            } catch (Exception ex) {
                trackingAction("service", "registraUtente - Error: " + ex.getMessage());
            }
        }
        if (ok.equals("1")) {
            redirect(request, response, "home.jsp?esito=okr1");
        } else {
            redirect(request, response, "bando_reg.jsp?esito=KO" + ok + "&bando=" + bandorif);
        }
    }

    //registra nuova azienda
    //compilazione online
    //cancellazione domanda
    protected void erase(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codconf = request.getParameter("c");
        String confmd5 = convMd5(codconf);
        Db_Bando dbb = new Db_Bando();

        String sc = dbb.getScadenzaBando(bando);
        DateTime datafine = formatDate(sc, timestampSQL);
        DateTime datenow = formatDate(dbb.curtime(), timestampSQL);

        if (!datafine.isAfter(datenow)) {
            dbb.closeDB();
            redirect(request, response, "pageko.jsp?err=3A");
        } else {

            String[] v = dbb.controllaDomandadaEliminare(confmd5);
            String msg = "0";
            if (v != null) {
                String idrichiesta = v[0];
                String codbando = v[1];
                String username = v[2];

//                Domandecomplete doco = dbb.isDomandaCompletaConsolidata(codbando, username);
//                if (doco != null && doco.getConsolidato().equals("0")) {
                boolean es1 = dbb.cambiaStatoUser(username, "3");                   //      cambio stato
                boolean es2 = dbb.removeAllDocUserBando(codbando, username);        //      elimino i doc caricati
                boolean es3 = dbb.removeAllValoriUserBando(codbando, username);     //      ELIMINO I DATI DELL'UTENTE
                boolean es4 = dbb.annullaDomandaCompleta(codbando, username);       //      ANNULLO LA DOMANDA COMPLETA
                boolean es8 = dbb.removeAllcampiDomanda(codbando, username); //     
                if (es1 && es2 && es3 && es4 && es8) {
                    boolean es7 = dbb.cambiaStatoRichiestaAnnulla(idrichiesta, "1");
                    if (!es7) {
                        msg = "2";
                    } else {
                        trackingAction(username, "Domanda da annullare per il bando " + codbando);
                    }
                } else {
                    msg = "1";
                }
//                } else {
//                    msg = "2A";
//                }
            } else {
                msg = "3";
            }
            dbb.closeDB();
            if (msg.equals("0")) {
                redirect(request, response, "page_ok.html");
            } else {
                redirect(request, response, "pageko.jsp?err=" + msg);
            }
        }
    }

    protected void remdocdef(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codbando = request.getSession().getAttribute("bandorif").toString();
        String username = request.getSession().getAttribute("username").toString();
        Db_Bando dbb = new Db_Bando();
        String msg = "0";
        boolean es2 = dbb.removeAllDocUserBando(codbando, username);        //      elimino i doc caricati
        boolean es3 = dbb.removeAllValoriUserBandoDOC1(codbando, username); //      ELIMINO I DATI DELL'UTENTE
        boolean es4 = dbb.annullaDomandaCompleta(codbando, username);       //      ANNULLO LA DOMANDA COMPLETA
        boolean es7 = dbb.removeAllcampiDomanda(codbando, username);  //      elimno la riga inserita con i campi della domanda
        if (es2 && es3 && es4 && es7) {

        } else {
            msg = "1";
        }
        dbb.closeDB();
        if (msg.equals("0")) {
            redirect(request, response, "bando_index.jsp?esito=okrem");
        } else {
            redirect(request, response, "bando_index.jsp?esito=korem");
        }
    }

    //eliminazione doc bando
    protected void remdoc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String username = request.getSession().getAttribute("username").toString();
        String tipodoc = request.getParameter("tipodoc");
        Db_Bando dbb = new Db_Bando();
        String msg = "0";
        String tipologia = request.getParameter("tipologia");
        boolean es2 = dbb.removeSingleDocUserBando(bandorif, username, tipodoc, tipologia); // elimino i doc caricati
        if (!es2) {
            msg = "1";
        }
        dbb.closeDB();
        if (msg.equals("0")) {
            trackingAction(username, "Eliminazione documento Bando: " + bandorif + " Tipodoc: " + tipodoc);
            redirect(request, response, "bando_index.jsp?esito=okrem");
        } else {
            trackingAction(username, "Errore Eliminazione documento Bando: " + bandorif + " Tipodoc: " + tipodoc);
            redirect(request, response, "bando_index.jsp?esito=korem");
        }
    }

    protected void remdocAltri(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String username = request.getSession().getAttribute("username").toString();
        String tipodoc = request.getParameter("tipodoc");
        String tipologia = request.getParameter("tipologia");
        String note = request.getParameter("notemodal");

        Db_Bando dbb = new Db_Bando();
        String msg = "0";
        boolean es2 = dbb.removeSingleDocUserBandoAltri(bandorif, username, tipodoc, tipologia, note); // elimino i doc caricati
        if (!es2) {
            msg = "1";
        }
        dbb.closeDB();
        if (msg.equals("0")) {
            trackingAction(username, "Eliminazione documento Bando: " + bandorif + " Tipodoc: " + tipodoc);
            redirect(request, response, "bando_updoc.jsp?esito=0&tipodoc=" + tipodoc);
        } else {
            redirect(request, response, "bando_index.jsp?esito=korem");
        }
    }

    //invio domanda
    protected void inviadomanda(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String username = request.getSession().getAttribute("username").toString();
        String indemail = request.getSession().getAttribute("indemail").toString();
        Db_Bando dbb = new Db_Bando();
        boolean pres = false;
        if (dbb.isDomandaPresente(bandorif, username)) {
            pres = true;
        }
        boolean att = dbb.bandoAttivoRaf(bandorif);
        dbb.closeDB();
        if (att) {
            if (!pres) {

                String datainvio = new DateTime().toString("yyyy-MM-dd HH:mm:ss");
                String idd = generaId() + username;
                Domandecomplete doc = new Domandecomplete(idd, bandorif, username, datainvio);
                Db_Bando dbb1 = new Db_Bando();

                boolean es = dbb1.inviaDomanda(doc);
                String text = dbb1.getPath("mail.inviodomanda.sa").replaceAll("@codicedocumenti", idd);
                String text2 = dbb1.getPath("mail.inviodomanda.mc").replaceAll("@codicedocumenti", idd).replaceAll("@nomesoggetto", dbb1.getRagioneSociale(username));
                String emailmcn = dbb1.getPath("mail.destinatari.mcn");
                String numuser = dbb1.getCellUtente(username);
                dbb1.closeDB();

                if (es) {
                    String[] dest = {indemail};
                    String[] dest2 = {emailmcn};
                    try {
                        sendMail(
                                Constant.nomevisual, dest, new String[]{}, text,
                                Constant.nomevisual + " - Conferma invio domanda di partecipazione");

                        //MAIL MICRO
                        sendMail(
                                Constant.nomevisual, dest2, new String[]{}, text2,
                                Constant.nomevisual + " - Domanda di partecipazione ricevuta");

                        //SMS S-A
                        Db_OTP db = new Db_OTP();
                        String msg = db.getSMS(bando, 3);
                        db.closeDB();
                        sendSMS2024(numuser, msg);

                        trackingAction(username, "Invio domanda partecipazione: " + bandorif + " Id domanda: " + idd);
                        redirect(request, response, "bando_index.jsp?esito=okinvio");
                    } catch (Exception e) {
                        trackingAction(username, estraiEccezione(e));
                    }
                } else {
                    redirect(request, response, "bando_index.jsp?esito=koinvio");

                }
            } else {
                redirect(request, response, "bando_index.jsp?esito=koinviopresente");
            }
        } else {
            trackingAction(request.getSession().getAttribute("username").toString(), "Invio domanda fuori tempo - Logout portale");
            request.getSession().setAttribute("bandorif", null);
            request.getSession().setAttribute("statouser", null);
            request.getSession().setAttribute("username", null);
            request.getSession().setAttribute("lang", null);
            request.getSession().setAttribute("numcell", null);
            request.getSession().setAttribute("indemail", null);
            request.getSession().setAttribute("tipo", null);
            request.getSession().invalidate();
            redirect(request, response, "pageko.jsp?err=FT");
        }
    }

    protected void annulladomanda(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String msg = "0";
        DateTime el = new DateTime();
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String username = request.getSession().getAttribute("username").toString();
        String mail = request.getSession().getAttribute("indemail").toString();
        String datacanc = el.toString(timestampSQL);
        String codconf = generaId(20) + username + generaId(20);
        String confmd5 = convMd5(codconf);
        Db_Bando dbb = new Db_Bando();
        String contpath = dbb.getPath("linkweb");
        String link = "<a class='link-title' href='" + contpath + "/Operazioni?action=26eb25b14d930f9d5f59b2c50798a9a4&c=" + codconf + "'>Conferma cancellazione domanda</a>";
        String text = dbb.getPath("mail.annulladomanda").replaceAll("@linkreg", link);
        boolean es1 = dbb.insertDomandaDaCanc(bandorif, username, datacanc, confmd5);
        dbb.closeDB();
        if (es1) {
            String dest[] = {mail};
            try {
                boolean es = sendMail(
                        Constant.nomevisual, dest, new String[]{}, text,
                        Constant.nomevisual + " - Cancellazione Domanda di Partecipazione");
                if (!es) {
                    msg = "1";
                }
            } catch (Exception ex) {
                trackingAction("ERROR SYSTEM", estraiEccezione(ex));
            }
        } else {
            msg = "2";
        }
        if (msg.equals("0")) {
            trackingAction(username, "Richiesta annullamento domanda: " + bandorif);
            redirect(request, response, "LoginOperations?type=out");
        } else {
            redirect(request, response, "bando_index.jsp?esito=kocanc");
        }
    }

    protected void deletefaq(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idfaq = getRequestValue(request, "idfaq");

        String tipo = request.getSession().getAttribute("tipo").toString();

        if (tipo.equals("1")) {
            Db_Bando dbb = new Db_Bando();
            boolean es1 = dbb.delete_faq(idfaq);
            dbb.closeDB();

            if (es1) {
                response.getWriter().print("OK");
            } else {
                response.getWriter().print("ko1");
            }

        } else {
            response.getWriter().print("ko2");
        }

    }

    protected void editfaq(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Db_Bando dbb = new Db_Bando();
        String pathtemp = dbb.getPath("pathtemp");
        dbb.closeDB();
        createDir(pathtemp);
        String username = getRequestValue(request, "username");
        String tipo = getRequestValue(request, "tipo");
        String titolo = utf8(getRequestValue(request, "titolo"));
        String testo = utf8(getRequestValue(request, "testo"));
        String idfaq = getRequestValue(request, "idfaq");
        if (tipo.equals("1")) {
            Db_Bando dbb1 = new Db_Bando();
            boolean es1 = dbb1.edit_faq(idfaq, titolo, testo, username);
            dbb1.closeDB();
            if (es1) {
                redirect(request, response, "page_ok.html");
            } else {
                redirect(request, response, "faq_add.jsp?esito=ko&idfaq=" + idfaq);
            }
        } else {
            redirect(request, response, "faq_add.jsp?esito=ko&idfaq=" + idfaq);
        }
    }

    protected void addfaq(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = getRequestValue(request, "username");
        String tipo = getRequestValue(request, "tipo");
        String titolo = utf8(getRequestValue(request, "titolo"));
        String testo = utf8(getRequestValue(request, "testo"));
        Db_Bando dbb = new Db_Bando();
        boolean es1 = dbb.addFaq(titolo, testo, username, tipo);
        dbb.closeDB();
        if (es1) {
            redirect(request, response, "page_ok.html");
        } else {
            redirect(request, response, "faq_add.jsp?esito=ko");
        }
    }

    protected void sendconvmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        Utility.printRequest(request);
//        if (true) {
//            return;
//        }
        String username = getRequestValue(request, "username");
        try {
//            String tipodoc = getRequestValue(request, "tipodoc");

            String to[] = {getRequestValue(request, "email").toLowerCase()};
            String cc[] = {getRequestValue(request, "emailcc").toLowerCase()};

            Db_Bando db = new Db_Bando();
            String protocollo = db.getProtocolloDomandaInviata(username).toUpperCase();
            String ragsoc = db.getRagioneSociale(username).toUpperCase();
            String text = db.getPath("mail.invioconvenzione.roma").replaceAll("@prot", protocollo).replaceAll("@ragsoc", ragsoc);
            db.closeDB();

//            File filedainviare = ActionB.creaZip_Convenzione(username, protocollo, ragsoc);
            List<FileDownload> listafiledainviare = ActionB.lista_file_Convenzione(username, protocollo, ragsoc);

//            boolean mailok = sendMail(
//                    Constant.nomevisual, to, cc, text,
//                    Constant.nomevisual + " - Invio convenzione da parte del Soggetto Attuatore: " + ragsoc,
//                    filedainviare);
            boolean mailok = sendMailListAttach(
                    Constant.nomevisual, to, cc, text,
                    Constant.nomevisual + " - Invio convenzione da parte del Soggetto Attuatore: " + ragsoc,
                    listafiledainviare, username);

            if (mailok) {
                if (settaInvioEmailROMA(username)) {
                    response.sendRedirect("bando_conv.jsp?esito=ok&userdoc=" + username);
                }
            } else {
                response.sendRedirect("bando_conv.jsp?esito=ko&userdoc=" + username);
            }
        } catch (Exception ex) {
            trackingAction("ERROR SYSTEM", estraiEccezione(ex));
            response.sendRedirect("bando_conv.jsp?esito=ko&userdoc=" + username);
        }
    }

    protected void sendConvenzioni(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getSession().getAttribute("username").toString();

        if (!verificaInvioConvenzione(username)) {
            if (setStatoInvioDocumenti(username)) {

                try {

                    Db_Bando db = new Db_Bando();
                    String emailuser = db.getEmailUtente(username);
                    String email = db.getPath("mail.destinatari.mcn");
                    String dest[] = email.split(",");
                    String text = db.getPath("mail.invioconvenzione.sa").replaceAll("@codicedocumento", db.getCodiceDomandaInviata(username)).replaceAll("@ragsoc", db.getRagioneSociale(username));
                    String text_2 = db.getPath("mail.invioconvenzione.sogatt");
                    db.closeDB();

                    sendMail(
                            Constant.nomevisual, dest, new String[]{}, text,
                            Constant.nomevisual + " - Invio Convenzione da parte di un Soggetto Attuatore");

                    //ADD SA
                    String dest_user[] = {emailuser};
                    sendMail(
                            Constant.nomevisual, dest_user, new String[]{}, text_2,
                            Constant.nomevisual + " - Comunicazione esito invio convenzione");

                } catch (Exception ex) {
                    trackingAction("ERROR SYSTEM", estraiEccezione(ex));
                }
                response.sendRedirect("bando_index.jsp?esito=okconv");
            } else {
                response.sendRedirect("bando_index.jsp?esito=koconv");
            }
        } else {
            response.sendRedirect("bando_index.jsp?esito=koconv2");
        }

    }

    public void eliminaconv(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getSession().getAttribute("username").toString();
        String tipodoc = request.getParameter("tipodoc").replaceAll("'", "''");
        if (remDocConvenzioni(username, tipodoc)) {
            response.sendRedirect("bando_index.jsp?esito=okrem");
        } else {
            response.sendRedirect("bando_index.jsp?esito=korem");
        }
    }

    public void accettaDomanda(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        printRequest(request);
//        if (true) {
//            return;
//        }
        String username = getRequestValue(request, "usernameDomanda");
        String accRif = getRequestValue(request, "accRif");
        String data_da = getRequestValue(request, "data_da");
        String data_a = getRequestValue(request, "data_a");
        String protocollo = utf8(getRequestValue(request, "protocollo"));
        String decreto = utf8(getRequestValue(request, "decreto"));
        String datadecreto = getRequestValue(request, "datadecreto");

        String note = utf8(getRequestValue(request, "note1"));

        if (setStatoDomandaAccRif(username, accRif, protocollo, note, decreto, datadecreto)) {

            Db_Bando db = new Db_Bando();
//            String var[] = db.getValoriPerEmail(username);
            String emailuser = db.getEmailUtente(username);
            String numuser = db.getCellUtente(username);
            String text = db.getPath("mail.inviodomanda.accettata")
                    .replaceAll("@codicedecreto", decreto)
                    .replaceAll("@datadecreto", datadecreto)
                    .replaceAll("@noteenm", "Note ENM: " + note);

            db.closeDB();

            try {

                String dest[] = {emailuser};
                sendMail(
                        Constant.nomevisual, dest, new String[]{}, text,
                        Constant.nomevisual + " – Comunicazione esito candidatura");

                Db_OTP dbo = new Db_OTP();
                String msg = dbo.getSMS(bando, 4);
                dbo.closeDB();

                sendSMS2024(numuser, msg);

            } catch (Exception ex) {
                trackingAction("ERROR SYSTEM", estraiEccezione(ex));
            }

            redirect(request, response, "bando_visdoc.jsp?search=1&esito=okA&data_da=" + data_da + "&data_a=" + data_a);
        } else {
            redirect(request, response, "bando_visdoc.jsp?search=1&esito=koA&data_da=" + data_da + "&data_a=" + data_a);
        }
    }

    public void rigettaDomanda(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = getRequestValue(request, "usernameDomanda");
        String accRif = getRequestValue(request, "accRif");
        String data_da = getRequestValue(request, "data_da");
        String data_a = getRequestValue(request, "data_a");
        String motivazione = utf8(getRequestValue(request, "motivo"));
        String protocollo = getRequestValue(request, "protocollo");
        String decreto = getRequestValue(request, "decreto");
        String datadecreto = getRequestValue(request, "datadecreto");

        if (setStatoDomandaAccRif(username, accRif, protocollo, motivazione, decreto, datadecreto)) {

            Db_Bando db = new Db_Bando();
//            String var[] = db.getValoriPerEmail(username);
            String emailuser = db.getEmailUtente(username);
            String numuser = db.getCellUtente(username);
            String text = db.getPath("mail.inviodomanda.rigettata")
                    .replaceAll("@codicedecreto", decreto)
                    .replaceAll("@datadecreto", datadecreto)
                    .replaceAll("@motivazioni", motivazione);
            db.closeDB();

            try {

                String dest[] = {emailuser};
                sendMail(
                        Constant.nomevisual, dest, new String[]{}, text,
                        Constant.nomevisual + " – Comunicazione esito candidatura"
                );

                Db_OTP dbo = new Db_OTP();
                String msg = dbo.getSMS(bando, 4);
                dbo.closeDB();

                sendSMS2024(numuser, msg);

            } catch (Exception ex) {
                trackingAction("ERROR SYSTEM", estraiEccezione(ex));
            }
            redirect(request, response, "bando_visdoc.jsp?search=1&esito=okR&data_da=" + data_da + "&data_a=" + data_a);
        } else {
            redirect(request, response, "bando_visdoc.jsp?search=1&esito=ko&data_da=" + data_da + "&data_a=" + data_a);
        }
    }

    public void salva_allegato_a(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = getRequestValue(request, "username");

        String soggettosingolo = getRequestCheckbox(request, "ch1");
        String costituenda = getRequestCheckbox(request, "ch2");
        String costituita = getRequestCheckbox(request, "ch3");
        String rete = getRequestCheckbox(request, "ch4");
        String consorzio = getRequestCheckbox(request, "ch5");

        String accreditata = getRequestCheckbox(request, "ch6");
        String iscrizione = utf8(getRequestValue(request, "iscrizione"));
        String numaule = getRequestValue(request, "aule");

        String elencoenti = utf8(getRequestValue(request, "elencoenti"));
        String numiscrreg = utf8(getRequestValue(request, "numiscrreg"));

        String indirizzo1 = utf8(getRequestValue(request, "indirizzo"));
        String citta1 = getRequestValue(request, "citta");
        String provincia1 = getRequestValue(request, "provincia");
        String regioneaula1 = getRequestValue(request, "regioneaula");
        String titolo1 = utf8(getRequestValue(request, "titolo"));
        String estremi1 = utf8(getRequestValue(request, "estremi"));

        String accreditamento1 = utf8(getRequestValue(request, "accreditamento"));
        String responsabile1 = utf8(getRequestValue(request, "responsabile"));
        String mailresponsabile1 = utf8(getRequestValue(request, "mailresponsabile"));
        String telresponsabile1 = utf8(getRequestValue(request, "telresponsabile"));
        String amministrativo1 = utf8(getRequestValue(request, "responsabileAmm"));
        String mailamministrativo1 = utf8(getRequestValue(request, "mailresponsabileAmm"));
        String telamministrativo1 = utf8(getRequestValue(request, "telresponsabileAmm"));

        String indirizzo2 = utf8(getRequestValue(request, "indirizzo2"));
        String citta2 = getRequestValue(request, "citta2");
        String provincia2 = getRequestValue(request, "provincia2");
        String regioneaula2 = getRequestValue(request, "regioneaula2");

        String titolo2 = utf8(getRequestValue(request, "titolo2"));
        String estremi2 = utf8(getRequestValue(request, "estremi2"));
        String accreditamento2 = utf8(getRequestValue(request, "accreditamento2"));
        String responsabile2 = utf8(getRequestValue(request, "responsabile2"));
        String mailresponsabile2 = utf8(getRequestValue(request, "mailresponsabile2"));
        String telresponsabile2 = utf8(getRequestValue(request, "telresponsabile2"));
        String amministrativo2 = utf8(getRequestValue(request, "responsabileAmm2"));
        String mailamministrativo2 = utf8(getRequestValue(request, "mailresponsabileAmm2"));
        String telamministrativo2 = utf8(getRequestValue(request, "telresponsabileAmm2"));

        String indirizzo3 = utf8(getRequestValue(request, "indirizzo3"));
        String citta3 = getRequestValue(request, "citta3");
        String provincia3 = getRequestValue(request, "provincia3");
        String regioneaula3 = getRequestValue(request, "regioneaula3");
        String titolo3 = utf8(getRequestValue(request, "titolo3"));
        String estremi3 = utf8(getRequestValue(request, "estremi3"));
        String accreditamento3 = utf8(getRequestValue(request, "accreditamento3"));
        String responsabile3 = utf8(getRequestValue(request, "responsabile3"));
        String mailresponsabile3 = utf8(getRequestValue(request, "mailresponsabile3"));
        String telresponsabile3 = utf8(getRequestValue(request, "telresponsabile3"));
        String amministrativo3 = utf8(getRequestValue(request, "responsabileAmm3"));
        String mailamministrativo3 = utf8(getRequestValue(request, "mailresponsabileAmm3"));
        String telamministrativo3 = utf8(getRequestValue(request, "telresponsabileAmm3"));

        String indirizzo4 = utf8(getRequestValue(request, "indirizzo4"));
        String citta4 = getRequestValue(request, "citta4");
        String provincia4 = getRequestValue(request, "provincia4");
        String regioneaula4 = getRequestValue(request, "regioneaula4");
        String titolo4 = utf8(getRequestValue(request, "titolo4"));
        String estremi4 = utf8(getRequestValue(request, "estremi4"));
        String accreditamento4 = utf8(getRequestValue(request, "accreditamento4"));
        String responsabile4 = utf8(getRequestValue(request, "responsabile4"));
        String mailresponsabile4 = utf8(getRequestValue(request, "mailresponsabile4"));
        String telresponsabile4 = utf8(getRequestValue(request, "telresponsabile4"));
        String amministrativo4 = utf8(getRequestValue(request, "responsabileAmm4"));
        String mailamministrativo4 = utf8(getRequestValue(request, "mailresponsabileAmm4"));
        String telamministrativo4 = utf8(getRequestValue(request, "telresponsabileAmm4"));

        String indirizzo5 = utf8(getRequestValue(request, "indirizzo5"));
        String citta5 = getRequestValue(request, "citta5");
        String provincia5 = getRequestValue(request, "provincia5");
        String regioneaula5 = getRequestValue(request, "regioneaula5");
        String titolo5 = utf8(getRequestValue(request, "titolo5"));
        String estremi5 = utf8(getRequestValue(request, "estremi5"));
        String accreditamento5 = utf8(getRequestValue(request, "accreditamento5"));
        String responsabile5 = utf8(getRequestValue(request, "responsabile5"));
        String mailresponsabile5 = utf8(getRequestValue(request, "mailresponsabile5"));
        String telresponsabile5 = utf8(getRequestValue(request, "telresponsabile5"));
        String amministrativo5 = utf8(getRequestValue(request, "responsabileAmm5"));
        String mailamministrativo5 = utf8(getRequestValue(request, "mailresponsabileAmm5"));
        String telamministrativo5 = utf8(getRequestValue(request, "telresponsabileAmm5"));

        String pec = utf8(getRequestValue(request, "pec"));
        String numdocenti = utf8(getRequestValue(request, "numeroDocenti"));

        String privacy1 = getRequestCheckbox(request, "privacy1");
        String privacy2 = getRequestCheckbox(request, "privacy2");

        boolean esitoinserimento = insAllegatoA(
                username, soggettosingolo, costituenda, costituita, rete, consorzio,
                accreditata, iscrizione,
                //PUNTO 2
                numaule,
                //AULA 1
                indirizzo1, citta1,
                provincia1,
                regioneaula1, titolo1,
                estremi1, accreditamento1,
                responsabile1, mailresponsabile1, telresponsabile1,
                amministrativo1, mailamministrativo1, telamministrativo1,
                //AULA 2
                indirizzo2, citta2,
                provincia2, regioneaula2, titolo2,
                estremi2, accreditamento2,
                responsabile2, mailresponsabile2, telresponsabile2,
                amministrativo2, mailamministrativo2, telamministrativo2,
                //AULA 3
                indirizzo3, citta3,
                provincia3, regioneaula3, titolo3, estremi3, accreditamento3,
                responsabile3, mailresponsabile3, telresponsabile3,
                amministrativo3, mailamministrativo3, telamministrativo3,
                //AULA 4
                indirizzo4, citta4,
                provincia4, regioneaula4, titolo4, estremi4, accreditamento4,
                responsabile4, mailresponsabile4, telresponsabile4,
                amministrativo4, mailamministrativo4, telamministrativo4,
                //AULA 5
                indirizzo5, citta5,
                provincia5, regioneaula5, titolo5, estremi5, accreditamento5,
                responsabile5, mailresponsabile5, telresponsabile5,
                amministrativo5, mailamministrativo5, telamministrativo5,
                //PUNTO 4
                pec,
                //PUNTO 5
                numdocenti,
                //PRIVACY
                privacy1, privacy2,
                elencoenti, numiscrreg);

        if (esitoinserimento) {
            redirect(request, response, "bando_index.jsp?esito=ok1");
        } else {
            redirect(request, response, "bando_index.jsp?esito=ko1");
        }

    }

    private void remdatiAllegatoA(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        boolean esitoremove = ActionB.remdatiAllegatoA(username);
        if (esitoremove) {
            ActionB.remdatiAllegatoB(username);
            removeSingleDocUserBando(bando, username, "DONLB", "-");
            removeSingleDocUserBando(bando, username, "ALB1", "-");
            delAllAllegatiDocenti(username);
            delAllegatoB1Field(username);
            redirect(request, response, "bando_index.jsp?esito=okrem1");
        } else {
            redirect(request, response, "bando_index.jsp?esito=korem");
        }
    }

    private void salva_allegato_c2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = getRequestValue(request, "username");
        String provincianascita = getRequestValue(request, "provincia1");
        String indirizzoresidenza = utf8(getRequestValue(request, "indirizzo1"));
        String capresidenza = utf8(getRequestValue(request, "cap1"));
        String cittaresidenza = utf8(getRequestValue(request, "citta1"));
        String banca_nome = utf8(getRequestValue(request, "nomebanca1"));
        String banca_agenzia = utf8(getRequestValue(request, "nomeagenzia1"));
        String banca_intestatario = utf8(getRequestValue(request, "intest1"));
        String iban = utf8(getRequestValue(request, "iban1"));
        String unico1 = getRequestValue(request, "unico1");
        String unicosi = "NO";
        String unicono = "NO";

        String soggetto1_nome = utf8(getRequestValue(request, "nomesogg1"));
        String soggetto1_cognome = utf8(getRequestValue(request, "cognomesogg1"));
        String soggetto1_cf = utf8(getRequestValue(request, "cfsogg1"));
        String soggetto1_luogonascita = utf8(getRequestValue(request, "comunesogg1"));
        String soggetto1_datanascita = utf8(getRequestValue(request, "datanascitasogg1"));
        String soggetto1_sesso = utf8(getRequestValue(request, "sessosogg1"));
        String soggetto1_indirizzoresidenza = utf8(getRequestValue(request, "indirizzosogg1"));
        String soggetto1_cittaresidenza = utf8(getRequestValue(request, "cittasogg1"));

        String soggetto2_nome = utf8(getRequestValue(request, "nomesogg2"));
        String soggetto2_cognome = utf8(getRequestValue(request, "cognomesogg2"));
        String soggetto2_cf = utf8(getRequestValue(request, "cfsogg2"));
        String soggetto2_luogonascita = utf8(getRequestValue(request, "comunesogg2"));
        String soggetto2_datanascita = utf8(getRequestValue(request, "datanascitasogg2"));
        String soggetto2_sesso = utf8(getRequestValue(request, "sessosogg2"));
        String soggetto2_indirizzoresidenza = utf8(getRequestValue(request, "indirizzosogg2"));
        String soggetto2_cittaresidenza = utf8(getRequestValue(request, "cittasogg2"));

        if (unico1.equals("SI")) {
            unicosi = "SI";

            soggetto1_nome = "";
            soggetto1_cognome = "";
            soggetto1_cf = "";
            soggetto1_luogonascita = "";
            soggetto1_datanascita = "";
            soggetto1_sesso = "";
            soggetto1_indirizzoresidenza = "";
            soggetto1_cittaresidenza = "";

            soggetto2_nome = "";
            soggetto2_cognome = "";
            soggetto2_cf = "";
            soggetto2_luogonascita = "";
            soggetto2_datanascita = "";
            soggetto2_sesso = "";
            soggetto2_indirizzoresidenza = "";
            soggetto2_cittaresidenza = "";

        } else if (unico1.equals("NO")) {
            unicono = "SI";
        }

        AllegatoC2 valore = new AllegatoC2(username, provincianascita, indirizzoresidenza, capresidenza, cittaresidenza,
                banca_nome, banca_agenzia, banca_intestatario, iban, unicosi, unicono,
                soggetto1_nome, soggetto1_cognome, soggetto1_cf, soggetto1_luogonascita, soggetto1_datanascita, soggetto1_sesso, soggetto1_indirizzoresidenza, soggetto1_cittaresidenza,
                soggetto2_nome, soggetto2_cognome, soggetto2_cf, soggetto2_luogonascita, soggetto2_datanascita, soggetto2_sesso, soggetto2_indirizzoresidenza, soggetto2_cittaresidenza);

        if (insertAllegatoC2(valore)) {
            redirect(request, response, "bando_index.jsp?esito=ok1");
        } else {
            redirect(request, response, "bando_index.jsp?esito=ko2");
        }

    }

    private void salva_allegato_b(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = getRequestValue(request, "username");
        int totaledocenti = parseIntR(getRequestValue(request, "totaledocenti"));

        boolean ok = false;
        List<AllegatoB> valori = new ArrayList<>();

        for (int indice = 1; indice <= totaledocenti; indice++) {
            valori.add(new AllegatoB(username, indice,
                    utf8(getRequestValue(request, "docNome" + indice)), utf8(getRequestValue(request, "docCognome" + indice)),
                    utf8(getRequestValue(request, "docCF" + indice)), utf8(getRequestValue(request, "doccomune" + indice)),
                    utf8(getRequestValue(request, "docdatanascita" + indice)), utf8(getRequestValue(request, "docsesso" + indice)),
                    utf8(getRequestValue(request, "docregione" + indice)), utf8(getRequestValue(request, "docmail" + indice)),
                    utf8(getRequestValue(request, "docpec" + indice)), utf8(getRequestValue(request, "doctel" + indice)),
                    utf8(getRequestValue(request, "doctitolistudio" + indice)), utf8(getRequestValue(request, "docqualifiche" + indice)),
                    "", utf8(getRequestValue(request, "docinquadr" + indice))));
            ok = true;
        }

        if (ok) {
            if (insAllegatoB(valori)) {
                redirect(request, response, "bando_index.jsp?esito=ok1");
            } else {
                redirect(request, response, "bando_index.jsp?esito=ko2");
            }
        } else {
            redirect(request, response, "bando_index.jsp?esito=ko2");
        }

    }

    private void remdatiAllegatoC2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        if (ActionB.remdatiAllegatoC2(username)) {
            redirect(request, response, "bando_index.jsp?esito=okrem1");
        } else {
            redirect(request, response, "bando_index.jsp?esito=korem");
        }

    }

    private void remdatiAllegatoB(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        if (ActionB.remdatiAllegatoB(username)) {
            removeSingleDocUserBando(bando, username, "DONLB", "-");
            removeSingleDocUserBando(bando, username, "ALB1", "-");
            delAllAllegatiDocenti(username);
            delAllegatoB1Field(username);
            redirect(request, response, "bando_index.jsp?esito=okrem1");
        } else {
            redirect(request, response, "bando_index.jsp?esito=korem");
        }
    }

    protected void uploadMultiplo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Db_Bando dbb = new Db_Bando();
        String pathtemp = dbb.getPath("pathtemp");
        dbb.closeDB();
        createDir(pathtemp);
        String nomiFiles[] = new String[3];
        String username = (String) request.getSession().getAttribute("username");
        String id = "";
        boolean isMultipart = isMultipartContent(request);
//        Date date = new Date();
        if (!isMultipart) {
        } else {
            JakartaServletFileUpload upload = new JakartaServletFileUpload();
            List<FileItem> items = upload.parseRequest((RequestContext) request);
            Iterator<FileItem> itr = items.iterator();
            //primo elemento è la tabella 
//            int i = 0;
            int i = 1;
            while (itr.hasNext()) {
                FileItem item = itr.next();
                if (item.isFormField()) {
                    if (item.getFieldName().equals("id")) {
                        id = item.getString();
                    }
                } else {
                    try {
                        String estensione = item.getName().substring(item.getName().lastIndexOf("."));
                        if (estensione.equalsIgnoreCase(".pdf") || estensione.equalsIgnoreCase(".p7m")) {
                            String generatedString = random(30, true, true);
                            File savedFile = createFile(pathtemp + username + generatedString + estensione);
                            item.write(savedFile.toPath());
                            nomiFiles[i] = preparefileforupload(savedFile);
                            i++;
                        } else {
                            nomiFiles[i] = "FILE ERROR";
                        }
                    } catch (Exception e) {
                        trackingAction("ERROR SYSTEM", estraiEccezione(e));
                    }
                }
            }

            File downloadFileB1 = allegatoB1(username, id);
            nomiFiles[0] = preparefileforupload(downloadFileB1);

            if (checkfileuploadmultiplo(nomiFiles)) {
                if (insAllegatoB1(
                        id,
                        username,
                        nomiFiles[1], //CV
                        nomiFiles[2], //DR
                        nomiFiles[0]) //B1
                        ) {
                    try {
                        sleep(500);
                    } catch (Exception e) {

                    }
                    if (esisteAllegatoB1(username)) {
                        Docuserbandi dub = new Docuserbandi(bando, username, "ALB1", "1", "-",
                                new DateTime().toString("yyyy-MM-dd hh:mm:ss"), "-", "-");
                        insertDocUserBando(dub);
                    }
                    if (esisteAllegatoB1(username)) {
                        redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=okb1");
                    } else {
                        redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ok");
                        redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ok");

                    }
                    redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ok");
                } else {
                    redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ko");
                }
            } else {
                redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ko4");
            }
        }
    }

    protected void delDocDocenti(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id_doc = request.getParameter("id_doc");
        String username = request.getParameter("username");
        if (delAllegatiDocenti(username, id_doc)) {
            redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ok1");
        } else {
            redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ko1");
        }
    }

    protected void modelloB1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = getRequestValue(request, "username");
        String iddocente = getRequestValue(request, "iddocente");

        String Tipologia = getRequestValue(request, "elenco1");
        String Committente = utf8(getRequestValue(request, "sa1"));
        String DataDa = getRequestValue(request, "datada1");
        String DataA = getRequestValue(request, "dataa1");

        String Durata = getRequestValue(request, "durata1");
        String Unità = getRequestValue(request, "ggmm1");
        String Incarico = getRequestValue(request, "tipo1");
        String Fonte = getRequestValue(request, "fonte1");
        String Progr = getRequestValue(request, "progr1");

        Db_Bando db = new Db_Bando();
        boolean insAllb1_1 = db.insAllegatoB1Field(iddocente, username, DataDa + " - " + DataA, Durata + " - " + Unità,
                Incarico, Fonte, Tipologia, Committente, Progr);
        boolean insAllb1_2 = true;
        boolean insAllb1_3 = true;
        boolean insAllb1_4 = true;
        boolean insAllb1_5 = true;

        if (!utf8(getRequestValue(request, "elenco2")).equals("")) {
            Tipologia = getRequestValue(request, "elenco2");
            Committente = utf8(getRequestValue(request, "sa2"));
            DataDa = getRequestValue(request, "datada2");
            DataA = getRequestValue(request, "dataa2");
            Durata = getRequestValue(request, "durata2");
            Unità = getRequestValue(request, "ggmm2");
            Incarico = getRequestValue(request, "tipo2");
            Fonte = getRequestValue(request, "fonte2");
            Progr = getRequestValue(request, "progr2");
            insAllb1_2 = db.insAllegatoB1Field(iddocente, username, DataDa + " - " + DataA, Durata + " - " + Unità,
                    Incarico, Fonte, Tipologia, Committente, Progr);
        }
        if (!utf8(getRequestValue(request, "elenco3")).equals("")) {
            Tipologia = getRequestValue(request, "elenco3");
            Committente = utf8(getRequestValue(request, "sa3"));
            DataDa = getRequestValue(request, "datada3");
            DataA = getRequestValue(request, "dataa3");
            Durata = getRequestValue(request, "durata3");
            Unità = getRequestValue(request, "ggmm3");
            Incarico = getRequestValue(request, "tipo3");
            Fonte = getRequestValue(request, "fonte3");
            Progr = getRequestValue(request, "progr3");
            insAllb1_3 = db.insAllegatoB1Field(iddocente, username, DataDa + " - " + DataA, Durata + " - " + Unità,
                    Incarico, Fonte, Tipologia, Committente, Progr);
        }
        if (!utf8(getRequestValue(request, "elenco4")).equals("")) {
            Tipologia = getRequestValue(request, "elenco4");
            Committente = utf8(getRequestValue(request, "sa4"));
            DataDa = getRequestValue(request, "datada4");
            DataA = getRequestValue(request, "dataa4");
            Durata = getRequestValue(request, "durata4");
            Unità = getRequestValue(request, "ggmm4");
            Incarico = getRequestValue(request, "tipo4");
            Fonte = getRequestValue(request, "fonte4");
            Progr = getRequestValue(request, "progr4");
            insAllb1_4 = db.insAllegatoB1Field(iddocente, username, DataDa + " - " + DataA, Durata + " - " + Unità,
                    Incarico, Fonte, Tipologia, Committente, Progr);
        }

        if (!utf8(getRequestValue(request, "elenco5")).equals("")) {
            Tipologia = getRequestValue(request, "elenco5");
            Committente = utf8(getRequestValue(request, "sa5"));
            DataDa = getRequestValue(request, "datada5");
            DataA = getRequestValue(request, "dataa5");
            Durata = getRequestValue(request, "durata5");
            Unità = getRequestValue(request, "ggmm5");
            Incarico = getRequestValue(request, "tipo5");
            Fonte = getRequestValue(request, "fonte5");
            Progr = getRequestValue(request, "progr5");
            insAllb1_5 = db.insAllegatoB1Field(iddocente, username, DataDa + " - " + DataA, Durata + " - " + Unità,
                    Incarico, Fonte, Tipologia, Committente, Progr);
        }

        db.closeDB();

        if (insAllb1_1 && insAllb1_2 && insAllb1_3 && insAllb1_4 && insAllb1_5) {
            redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ok2");
        } else {
            delAllegatoB1Field(iddocente, username);
            redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ko2");
        }
    }

    protected void delDocAllegatoB1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String iddocente = request.getParameter("iddocente");
        if (delAllegatoB1Field(iddocente, username)) {
            redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ok3");
        } else {
            redirect(request, response, "bando_onlinecomp2.jsp?allegato_A_B=C&esito=ko3");
        }
    }

    protected void botAreU(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        Map<String, Boolean> elements = new HashMap<>();
        try {
            elements.put("result", isValid(request.getParameter("g-recaptcha-response")));
        } catch (Exception ex) {
            elements.put("result", false);
            trackingAction("ERROR SYSTEM", estraiEccezione(ex));
        }
        try (PrintWriter pw = response.getWriter()) {
            pw.write(new JSONObject(elements).toString());
        }
    }

    protected void checkotp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = getRequestValue(request, "otp");
        String tipodoc = getRequestValue(request, "tipodoc");
        String user = (String) request.getSession().getAttribute("username");
        boolean esito = verificaOTP(bando, otp, user, 2);
        try (PrintWriter out = response.getWriter()) {
            if (esito) {
                DateTime el = new DateTime();
                String dateReg = el.toString("yyyy-MM-dd HH:mm:ss");
                String datesign = el.toString("dd/MM/yyyy HH:mm:ss");
                String content = "FILE ERROR";
                Docuserbandi dub = new Docuserbandi(bando, user, tipodoc, "1",
                        content,
                        dateReg, "-", "FIRMATO TRAMITE OTP IN DATA " + datesign);
                boolean es1 = insertDocUserBando(dub);
                if (es1) {
                    out.print("true");
                } else {
                    out.print("IMPOSSIBILE FIRMARE IL DOCUMENTO RICHIESTO. CONTATTARE L'AMMINISTRATORE.");
                }
            } else {
                out.print("IL CODICE OTP INSERITO NON &#200; VALIDO");
            }
        }
    }

    protected void requestotpsign(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String esitoOTP = "SUCCESS";
        try (PrintWriter out = response.getWriter()) {
            if (esitoOTP.equals("SUCCESS")) {
                out.print("true");
            } else {
                out.print(esitoOTP);
            }
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html;charset=UTF-8");
            String action = request.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "botAreU" ->
                        botAreU(request, response);
                    case "reg" ->
                        registraUtente(request, response);
                    case "26eb25b14d930f9d5f59b2c50798a9a4" ->
                        erase(request, response);
                    default -> {
                        if (request.getSession().getAttribute("username") == null) {
                            redirect(request, response, "home.jsp");
                        } else {
                            String bandorif = (String) request.getSession().getAttribute("bandorif");
                            String username = (String) request.getSession().getAttribute("username");
                            if (bandorif != null || username != null) {
                                if (!domandaAnnullata(bandorif, username)) {

                                    if (action.equals("annulladomanda")) {
                                        annulladomanda(request, response);
                                    }
                                    if (action.equals("remdoc")) {
                                        remdoc(request, response);
                                    } else if (action.equals("remdocAltri")) {
                                        remdocAltri(request, response);
                                    }
                                    if (action.equals("remdocdef")) {
                                        remdocdef(request, response);
                                    }
                                    if (action.equals("inviadomanda")) {
                                        inviadomanda(request, response);
                                    }
                                    if (action.equals("allegato_A")) {
                                        salva_allegato_a(request, response);
                                    }
                                    if (action.equals("allegato_B")) {
                                        salva_allegato_b(request, response);
                                    }
                                    if (action.equals("allegato_C2")) {
                                        salva_allegato_c2(request, response);
                                    }
                                    if (action.equals("remdatiAllegatoA")) {
                                        remdatiAllegatoA(request, response);
                                    }
                                    if (action.equals("remdatiAllegatoB")) {
                                        remdatiAllegatoB(request, response);
                                    }
                                    if (action.equals("remdatiAllegatoC2")) {
                                        remdatiAllegatoC2(request, response);
                                    }
                                    if (action.equals("UploadMultiplo")) {
                                        uploadMultiplo(request, response);
                                    }
                                    if (action.equals("delDocDocenti")) {
                                        delDocDocenti(request, response);
                                    }
                                    if (action.equals("modb1")) {
                                        modelloB1(request, response);
                                    }
                                    if (action.equals("delDocAllegatoB1")) {
                                        delDocAllegatoB1(request, response);
                                    }
                                    if (action.equals("accettaDomanda")) {
                                        accettaDomanda(request, response);
                                    }
                                    if (action.equals("rigettaDomanda")) {
                                        rigettaDomanda(request, response);
                                    }
                                    if (action.equals("eliminaconv")) {
                                        eliminaconv(request, response);
                                    }
                                    if (action.equals("sendConvenzioni")) {
                                        sendConvenzioni(request, response);
                                    }
                                    if (action.equals("sendconv")) {
                                        sendconvmail(request, response);
                                    }
                                    if (action.equals("requestotpsign")) {
                                        requestotpsign(request, response);
                                    }
                                    if (action.equals("checkotp")) {
                                        checkotp(request, response);
                                    }
                                    if (action.equals("addfaq")) {
                                        addfaq(request, response);
                                    }
                                    if (action.equals("editfaq")) {
                                        editfaq(request, response);
                                    }
                                    if (action.equals("deletefaq")) {
                                        deletefaq(request, response);
                                    }
                                } else {
                                    redirect(request, response, "LoginOperations?type=out");
                                }
                            } else {
                                redirect(request, response, "LoginOperations?type=out");
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            trackingAction("ERROR SYSTEM", estraiEccezione(ex));
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
