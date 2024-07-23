/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.action;

import java.util.ResourceBundle;
import static rc.soop.action.ActionB.trackingAction;
import static rc.soop.util.Utility.estraiEccezione;
import static rc.soop.util.Utility.formatStringtoStringDate;

import org.joda.time.DateTime;
import static org.joda.time.format.DateTimeFormat.forPattern;
import org.joda.time.format.DateTimeFormatter;

public class Constant {

    public static final ResourceBundle conf = ResourceBundle.getBundle("conf.conf");

    public static final String bando = "BAT1";
    public static final boolean test = conf.getString("test").equals("SI");
    public static final boolean demo = false;
    public static final boolean faq = true;
    public static final String nomevisual = conf.getString("name.visual");
    public static final String version = conf.getString("version");

    //Classic
    public static final String slash = "/";

    public static final String homePage = "bando_index.jsp";
    public static final String homePageAz = "bando_azind.jsp";
    public static final String homePageRup = "bando_repag.jsp";
    //otp
    public static final String otp = "home_otp.jsp";
    //Reset
    public static final String reset = "home_acc1.jsp";
    public static final String resetIOK = "home_acc1.jsp?esito=ok";
    public static final String resetIKO = "home_acc1.jsp?esito=ko";
    public static final String errLogin = "home.jsp?esito=";

    //OPERAZIONI
    public static final String pdfext = ".pdf";
//    public static final String secret = "6LdXcR8TAAAAAA-LTbETf8FGo-4PRvgPCXsdUant";
    public static final String USER_AGENT = "Mozilla/5.0";

    //time
    public static final String patternSql = "yyyy-MM-dd";
    public static final String patternITA = "dd/MM/yyyy";
    public static final String timestampSQL = "yyyy-MM-dd HH:mm:ss";
    public static final String timestampITA = "dd/MM/yyyy HH:mm:ss";
    public static final String timestamp = "yyyyMMddHHmmssSSS";

    ///////////////////////////////////////////////////////////////////
    public static final String datainizio = formatStringtoStringDate("2023-07-01", patternSql, patternITA, false);
    ///////////////////////////////////////////////////////////////////

    public static final String extpdf = ".pdf";
    public static final String extdocx = ".docx";

    public static boolean checkRegistrazione() {
        try {
            DateTimeFormatter formatter = forPattern(patternSql);
            DateTime inizio = formatter.parseDateTime("2021-03-01").withMillisOfDay(0);
            DateTime oggi = new DateTime().withMillisOfDay(0);
            boolean ok = inizio.isBefore(oggi) || inizio.isEqual(oggi);
            return ok;
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM", estraiEccezione(e));
        }
        return false;
    }

}
