/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.servlet;

import rc.soop.action.ActionB;
import static rc.soop.action.ActionB.getDomandeComplete;
import static rc.soop.action.ActionB.getRagioneSociale;
import static rc.soop.action.ActionB.trackingAction;
import static rc.soop.action.Constant.timestampITA;
import static rc.soop.action.Constant.timestampSQL;
import rc.soop.db.Db_Bando;
import rc.soop.entity.Ateco;
import rc.soop.entity.Comuni_rc;
import rc.soop.entity.Domandecomplete;
import static rc.soop.util.Utility.estraiEccezione;
import static rc.soop.util.Utility.formatStringtoStringDate;
import static rc.soop.util.Utility.formatUTFtoLatin;
import static rc.soop.util.Utility.getRequestValue;
import static rc.soop.util.Utility.redirect;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.text.StringEscapeUtils;

/**
 *
 * @author rcosco
 */
@SuppressWarnings("serial")
public class Query extends HttpServlet {

    private static String correggi(String ing) {
        if (ing != null) {
            ing = ing.replaceAll("\\\\", "");
            ing = ing.replaceAll("\n", "");
            ing = ing.replaceAll("\r", "");
            ing = ing.replaceAll("\t", "");
            ing = ing.replaceAll("'", "\'");
            ing = ing.replaceAll("“", "\'");
            ing = ing.replaceAll("‘", "\'");
            ing = ing.replaceAll("”", "\'");
            return ing.replaceAll("\"", "\'");
        } else {
            return "-";
        }
    }

    protected void query1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("text/plain; charset=ISO-8859-1");
            response.setCharacterEncoding("ISO-8859-1");

            String data_da = getRequestValue(request, "data_da");
            String data_a = getRequestValue(request, "data_a");
            String stato = getRequestValue(request, "stato");

//            if (mobile) {
//                target = "target='_blank'";
//            }
            SimpleDateFormat sdf_in = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // creo l'oggetto
//            Date da = sdf_in.parse(data_da);
            String dt_a = "";
            String dt_da = "";
            if (!data_a.trim().equals("")) {
                Date a = sdf_in.parse(data_a);
                dt_a = sdf.format(a);
            }
            if (!data_da.trim().equals("")) {
                Date da = sdf_in.parse(data_da);
                dt_da = sdf.format(da);
            }
//            dt_da = sdf.format(da);
            ArrayList<Domandecomplete> lista = getDomandeComplete(dt_da, dt_a, stato);
            try (PrintWriter out = response.getWriter()) {
                String inizio = "{ \"aaData\": [";
                String fine = "] }";
                String valore = "";
                if (!lista.isEmpty()) {
                    for (int i = 0; i < lista.size(); i++) {
                        String azioni = "";

                        String statodomanda = lista.get(i).formatStatoDomanda();
//                        boolean convenzionedainviare = db.countDocumentConvenzioni(lista.get(i).getUsername()) == 3;
//                        boolean convenzioneinviataROMA = db.getInvioEmailROMA(lista.get(i).getUsername()).equals("1");
//                        boolean convenzionecaricatacontrofirmata = !db.getConvenzioneROMA(lista.get(i).getUsername()).trim().equals("");

                        if (lista.get(i).getStatoDomanda().equals("S")) {
                            azioni = "<li><a class='btn btn-sm white popovers' data-toggle='modal' onclick='return setAccettaDomanda(&#34" + lista.get(i).getUsername() + "&#34)' href='#accettamodal' data-trigger='hover' data-placement='top' data-content='Accetta'><i class='fa fa-check-circle'></i> Accetta domanda</a></li>"
                                    + "<li><a class='btn btn-sm white popovers' data-toggle='modal' onclick='return setRigettaDomanda(&#34" + lista.get(i).getUsername() + "&#34)' href='#scartamodal2' data-trigger='hover' data-placement='top' data-content='Rigetta'><i class='fa fa-times-circle'></i>  Rigetta domanda</a></li>";
                        }

                        if (lista.get(i).isConvenzionedainviare()) {
                            azioni = "<li><a class='btn btn-sm white popovers fancyBoxRafreload' data-toggle='modal' href='bando_conv.jsp?userdoc=" + lista.get(i).getUsername() + "' data-trigger='hover' data-placement='top' data-content='Visualizza'><i class='fa fa-eye'></i> Visualizza Convenzione</a></li>";

                        }
                        if (lista.get(i).isConvenzioneinviataROMA()) {
                            if (!lista.get(i).isConvenzionecaricatacontrofirmata()) {
                                azioni = "<li><a class='btn btn-sm white popovers' data-toggle='modal' onclick='return setCaricaDocumento(&#34" + lista.get(i).getUsername() + "&#34)' href='#caricadocumento' data-trigger='hover' data-placement='top' data-content='Carica'><i class='fa fa-check-circle'></i> Carica Convenzione controfirmata</a></li>";
                            }
                        }

                        azioni += "<li><a class='btn btn-sm white fancyBoxRaf' " + "href='bando_updoc_rup.jsp?userdoc=" + lista.get(i).getUsername() + "'><i class='fa fa-upload'></i> Carica Allegati Domanda</a></li>";

                        String az2 = "<div class='clearfix'><div class='task-config'>"
                                + "<div class='task-config-btn btn-group' style='text-align:left;'>"
                                + "<a class='btn btn-default btn-xs' href='#' data-toggle='dropdown' data-hover='dropdown' data-close-others='true'><i class='fa fa-cog'>"
                                + "</i><i class='fa fa-angle-down'></i></a><ul class='dropdown-menu pull-right'>"
                                + "<li><a href='bando_visdocall.jsp?userdoc=" + lista.get(i).getUsername() + "' "
                                + "class='btn btn-sm white popovers fancyBoxRaf' container='body' data-trigger='hover' data-container='body' data-placement='top' "
                                + "data-content='Visualizza Documenti'>"
                                + "<i class='fa fa-file'></i> Visualizza documenti</a></li>"
                                + azioni
                                + "</ul></div></div></div>";
                        valore = valore + " [ \""
                                + correggi(lista.get(i).getId()) + "\", \""
                                + correggi(lista.get(i).getRagsoc()).toUpperCase() + "\", \""
                                + correggi(lista.get(i).getPiva()).toUpperCase() + "\", \""
                                + correggi(lista.get(i).getCodfissog()).toUpperCase() + "\", \""
                                + formatStringtoStringDate(lista.get(i).getDatainvio(), timestampSQL, timestampITA, false) + "\", \""
                                + statodomanda + "\", \""
                                + correggi(lista.get(i).getProtocollo()).toUpperCase() + "\", \""
                                + correggi(lista.get(i).getDecreto()).toUpperCase() + "\", \""
                                + az2 + "\"],";
                    }
                    String x = inizio + valore.substring(0, valore.length() - 1) + fine;
                    out.print(x);
                } else {
                    out.print(inizio + fine);
                }
            }
        } catch (Exception ex) {
            trackingAction("ERROR SYSTEM", estraiEccezione(ex));
        }
    }

    protected void comuninazioni(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = request.getParameter("q");
        Db_Bando db = new Db_Bando();
        ArrayList<Comuni_rc> result = db.query_comuninazioni_rc(q);
        db.closeDB();
        try (PrintWriter out = response.getWriter()) {
            String inizio = "{ \"items\": [ ";
            String fine = "]}";
            String valore = "";
            if (!result.isEmpty()) {
                for (int i = 0; i < result.size(); i++) {
                    valore = valore + "{"
                            + "      \"id\": \"" + result.get(i).getId() + "\","
                            + "      \"name\": \"" + formatUTFtoLatin(result.get(i).getNome()) + "\","
                            + "      \"prov\": \"" + formatUTFtoLatin(result.get(i).getCodiceprovincia()) + "\","
                            + "      \"reg\": \"" + formatUTFtoLatin(result.get(i).getCodiceregione()) + "\","
                            + "      \"cf\": \"" + result.get(i).getCodicefiscale() + "\","
                            + "      \"full_name\": \"" + formatUTFtoLatin(result.get(i).getNome()) + "\""
                            + "},";
                }
                String x = inizio + valore.substring(0, valore.length() - 1) + fine;
                out.print(StringEscapeUtils.escapeHtml4(x));
            } else {
                out.print(inizio + fine);
            }
        }

    }

    protected void comune(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String q = request.getParameter("q");
        Db_Bando db = new Db_Bando();
        ArrayList<Comuni_rc> result = db.query_comuni_rc(q);
        db.closeDB();
        try (PrintWriter out = response.getWriter()) {
            String inizio = "{ \"items\": [ ";
            String fine = "]}";
            String valore = "";
            if (!result.isEmpty()) {
                for (int i = 0; i < result.size(); i++) {
                    valore = valore + "{"
                            + "      \"id\": \"" + result.get(i).getId() + "\","
                            + "      \"name\": \"" + formatUTFtoLatin(result.get(i).getNome()) + "\","
                            + "      \"prov\": \"" + formatUTFtoLatin(result.get(i).getCodiceprovincia()) + "\","
                            + "      \"reg\": \"" + formatUTFtoLatin(result.get(i).getCodiceregione()) + "\","
                            + "      \"full_name\": \"" + formatUTFtoLatin(result.get(i).getNome()) + "\""
                            + "},";
                }
                String x = inizio + valore.substring(0, valore.length() - 1) + fine;
                out.print(StringEscapeUtils.escapeHtml4(x));
            } else {
                out.print(inizio + fine);
            }
        }
    }

    protected void ateco(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String q = request.getParameter("q");
        Db_Bando db = new Db_Bando();
        ArrayList<Ateco> result = db.query_ateco(q);
        db.closeDB();
        try (PrintWriter out = response.getWriter()) {
            String inizio = "{ \"items\": [ ";
            String fine = "]}";
            String valore = "";
            if (!result.isEmpty()) {
                for (int i = 0; i < result.size(); i++) {
                    valore = valore + "{"
                            + "      \"id\": \"" + result.get(i).getCodice() + "\","
                            + "      \"name\": \"" + formatUTFtoLatin(result.get(i).getDescrizione()) + "\","
                            + "      \"full_name\": \"" + result.get(i).getCodice()
                            + " - " + formatUTFtoLatin(result.get(i).getDescrizione()) + "\""
                            + "},";
                }
                String x = inizio + valore.substring(0, valore.length() - 1) + fine;
                out.print(StringEscapeUtils.escapeHtml4(x));
            } else {
                out.print(inizio + fine);
            }
        }
    }

    protected void verificaok(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String value = getRequestValue(request, "value");
        List<String> ok = ActionB.elencoaccreditati();
        try (PrintWriter out = response.getWriter()) {
            if (ok.contains(value)) {
                out.print("KO");
            } else {
                out.print("OK");
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = getRequestValue(request, "tipo");
        if (request.getSession().getAttribute("username") == null) {
            switch (type) {
                case "ateco" -> ateco(request, response);
                case "comune" -> comune(request, response);
                case "verificaok" -> verificaok(request, response);
                default -> redirect(request, response, "home.jsp");
            }
        } else {
            response.setContentType("text/plain; charset=ISO-8859-1");
            response.setCharacterEncoding("ISO-8859-1");
            switch (type) {
                case "ateco" -> ateco(request, response);
                case "comune" -> comune(request, response);
                case "1" -> query1(request, response);
                case "getRagSoc" -> getRagSoc(request, response);
                case "comuninazioni" -> comuninazioni(request, response);
                default -> redirect(request, response, "home.jsp");
            }

        }

    }

    protected void getRagSoc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("user").replaceAll("'", "''");
        String regSoc = getRagioneSociale(user);
        response.getWriter().print(StringEscapeUtils.escapeHtml4(regSoc));
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
