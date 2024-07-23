/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.servlet;

import rc.soop.action.ActionB;
import static rc.soop.action.ActionB.getAllegatoB1;
import static rc.soop.action.ActionB.getConvenzioneROMA;
import static rc.soop.action.ActionB.getPath;
import static rc.soop.action.ActionB.getPathConvenzioni;
import static rc.soop.action.ActionB.listaDocUserBandoDocenti;
import static rc.soop.action.ActionB.listaDocUserBando_nofilemcn;
import static rc.soop.action.ActionB.listaDocuserbando;
import static rc.soop.action.ActionB.preparefilefordownload;
import static rc.soop.action.ActionB.trackingAction;
import static rc.soop.action.Pdf_new.allegatoA_fase1;
import static rc.soop.action.Pdf_new.allegatoB1;
import static rc.soop.action.Pdf_new.allegatoB_fase1;
import static rc.soop.action.Pdf_new.allegatoC;
import rc.soop.db.Db_Bando;
import rc.soop.entity.AllegatoB1;
import rc.soop.entity.DocumentiDocente;
import rc.soop.entity.Docuserbandi;
import rc.soop.entity.FileDownload;
import rc.soop.util.Utility;
import static rc.soop.util.Utility.createDir;
import static rc.soop.util.Utility.estraiEccezione;
import static rc.soop.util.Utility.getRequestValue;
import static rc.soop.util.Utility.redirect;
import static rc.soop.util.Utility.sanitizeInput;
import static rc.soop.util.Utility.zipListFiles;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import static java.lang.String.format;
import static java.nio.file.Files.probeContentType;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64;
import static org.apache.commons.codec.binary.Base64.decodeBase64;
import org.apache.commons.io.FileUtils;
import org.joda.time.DateTime;
import static rc.soop.action.Constant.bando;
import static rc.soop.action.Constant.extdocx;
import static rc.soop.action.Constant.extpdf;
import rc.soop.entity.Docbandi;
import static rc.soop.util.Utility.createFile;
import static rc.soop.util.Utility.sanitizeOriginUrl;

/**
 *
 * @author raffaele
 */
@SuppressWarnings("serial")
public class Download extends HttpServlet {

    protected void guidabando(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String b64 = getPath("pdf.guida");
        if (b64 != null) {
            response.setContentType("application/pdf");
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", "Manuale Candidato.pdf");
            response.setHeader(headerKey, headerValue);
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(b64));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void guidaConvenzioni(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String b64 = getPath("pdf.guidaconvenzione");
        if (b64 != null) {
            trackingAction(request.getSession().getAttribute("username").toString(), "Download File Manuale Gestione Convenzioni");
            response.setContentType("application/pdf");
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", "Manuale Gestione Convenzioni.pdf");
            response.setHeader(headerKey, headerValue);
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(b64));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void avvisobando(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String b64 = getPath("pdf.avviso");
        if (b64 != null) {
            trackingAction(request.getSession().getAttribute("username").toString(), "Download File Avviso");
            response.setContentType("application/pdf");
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", "Avviso YISU 2122.pdf");
            response.setHeader(headerKey, headerValue);
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(b64));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void viewFileConvenzioniRUP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codicedoc = request.getParameter("tipologia").replaceAll("'", "''");
        String username = request.getParameter("userdoc").replaceAll("'", "''");
        String b64 = getPathConvenzioni(username, codicedoc);
        if (b64 != null) {
            FileDownload fw = preparefilefordownload(b64);
            if (fw != null) {
                trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
                String mimeType = fw.getMimeType();
                if (mimeType == null) {
                    mimeType = "application/octet-stream";
                }
                response.setContentType(mimeType);
                String headerKey = "Content-Disposition";
                String headerValue = format("attachment; filename=\"%s\"", fw.getName());
                response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                try (OutputStream outStream = response.getOutputStream()) {
                    outStream.write(decodeBase64(fw.getContent()));
                }
            } else {
                redirect(request, response, "page_fnf.html");
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void viewFileConvenzioni(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getSession().getAttribute("username").toString();
        String codicedoc = getRequestValue(request, "codicedoc");
        String b64 = getPathConvenzioni(username, codicedoc);
        if (b64 != null) {
            FileDownload fw = preparefilefordownload(b64);
            if (fw != null) {
                trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
                String mimeType = fw.getMimeType();
                if (mimeType == null) {
                    mimeType = "application/octet-stream";
                }
                response.setContentType(mimeType);
                String headerKey = "Content-Disposition";
                String headerValue = format("attachment; filename=\"%s\"", fw.getName());
                response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                try (OutputStream outStream = response.getOutputStream()) {
                    outStream.write(decodeBase64(fw.getContent()));
                }
            } else {
                redirect(request, response, "page_fnf.html");
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    //download docmento del bando
    protected void docbando(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipodoc = request.getParameter("tipodoc");
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String username = request.getSession().getAttribute("username").toString();

        Db_Bando dbb = new Db_Bando();
        String b64 = dbb.getPathDocUserBando(bandorif, username, tipodoc);
        dbb.closeDB();

        if (b64 != null) {
            FileDownload fw = preparefilefordownload(b64);
            if (fw != null) {
                trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
                String mimeType = fw.getMimeType();
                if (mimeType == null) {
                    mimeType = "application/octet-stream";
                }
                response.setContentType(mimeType);
                String headerKey = "Content-Disposition";
                String headerValue = format("attachment; filename=\"%s\"", fw.getName());
                response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                try (OutputStream outStream = response.getOutputStream()) {
                    outStream.write(decodeBase64(fw.getContent()));
                }
            } else {
                redirect(request, response, "page_fnf.html");
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void docbandoconsrup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipodoc = request.getParameter("tipodoc");
        String tipologia = request.getParameter("tipologia");
        String username = request.getParameter("userdoc");
        String note = request.getParameter("note");
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String path = request.getParameter("path");
        String filePath;

        if (path == null || path.trim().equals("")) {
            Db_Bando dbb = new Db_Bando();
            filePath = dbb.getPathDocUserBando(bandorif, username, tipodoc, tipologia, note);
            dbb.closeDB();
        } else {
            filePath = path;
        }

        FileDownload fw = preparefilefordownload(filePath);

        if (fw != null) {
            trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
            String mimeType = fw.getMimeType();
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", fw.getName());
            response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(fw.getContent()));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }

    }

    protected void docbandoconsConv(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = getRequestValue(request, "userdoc");
        if (username.equals("")) {
            username = request.getSession().getAttribute("username").toString();
        }
        String path = getRequestValue(request, "path");

        String filePath;
        if (path == null || path.trim().equals("")) {
            filePath = getConvenzioneROMA(username);
        } else {
            filePath = path;
        }

        FileDownload fw = preparefilefordownload(filePath);

        if (fw != null) {
            trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
            String mimeType = fw.getMimeType();
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", fw.getName());
            response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(fw.getContent()));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void docbandoconsrupB1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = getRequestValue(request, "username");
        String cod = getRequestValue(request, "cod");
        String indice = getRequestValue(request, "indice");

//        ArrayList<DocumentiDocente> dubd = ActionB.listaDocUserBandoDocenti(username, true);
        String content = ActionB.listaDocUserBandoDocenti(username, cod, indice);
//        if (cod.equals("ALB1")) {
//            content = dubd.get(indice).getB1();
//        } else if (cod.equals("CV")) {
//            content = dubd.get(indice).getCv();
//        } else if (cod.equals("DR")) {
//            content = dubd.get(indice).getDr();
//        }

        FileDownload fw = preparefilefordownload(content);
        if (fw != null) {
            trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
            String mimeType = fw.getMimeType();
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", fw.getName());
            response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(fw.getContent()));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }

    }

    protected void modellodoc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("username") == null) {
            redirect(request, response, "home.jsp");
        } else {
            String tipodoc = sanitizeInput(request.getParameter("tipodoc").replaceAll("'", "''"));
            String username = request.getSession().getAttribute("username").toString();
            String bandorif = request.getSession().getAttribute("bandorif").toString();
            Db_Bando dbb = new Db_Bando();
            String pathtemp = dbb.getPath("pathtemp");
            String filePath = dbb.getPathDocModello(bandorif, tipodoc);
            File downloadFile = null;
            String tiposoggetto = dbb.getTipoSoggetto(username);
            dbb.closeDB();
            switch (tipodoc) {
                case "DONLA" ->  {
                    File f1 = allegatoA_fase1(username);
                    if (f1 != null) {
                        downloadFile = f1;
                    }
                }
                case "DONLB" ->  {
                    File f1 = allegatoB_fase1(username);
                    if (f1 != null) {
                        downloadFile = f1;
                    }
                }
                case "DONLC" ->  {
                    switch (tiposoggetto) {
                        case "soggettosingolo" ->  {
                            downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + extdocx);
                            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(ActionB.getPath("allegatoc.1.soggettosingolo")));
                        }
                        case "costituenda" ->  {
                            downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + extdocx);
                            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(ActionB.getPath("allegatoc.2.costituenda")));
                        }
                        case "costituita" ->  {
                            downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + extdocx);
                            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(ActionB.getPath("allegatoc.3.costituita")));
                        }
                        case "rete" ->  {
                            downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + extdocx);
                            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(ActionB.getPath("allegatoc.4.rete")));
                        }
                        case "consorzio" ->  {
                            downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + extdocx);
                            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(ActionB.getPath("allegatoc.5.consorzio")));
                        }
                        default -> downloadFile = null;
                    }
                }
                case "DONLD", "DONLE", "DONLF" -> {
                    if (filePath.startsWith("/")) {
                        downloadFile = createFile(filePath);
                    } else {
                        downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + extdocx);
                        FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(filePath));
                    }
                }
                default -> {
                    if (filePath.startsWith("/")) {
                        downloadFile = createFile(filePath);
                    } else {
                        downloadFile = createFile(pathtemp + File.separator + tipodoc + "_" + Utility.generaId(50) + ".pdf");
                        FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(filePath));
                    }
                }
            }

            if (downloadFile != null && downloadFile.exists()) {
                trackingAction(request.getSession().getAttribute("username").toString(), "Download File (con modello) " + downloadFile.getName());
                OutputStream outStream;
                try (FileInputStream inStream = new FileInputStream(downloadFile)) {
                    String mimeType = probeContentType(downloadFile.toPath());
                    if (mimeType == null) {
                        mimeType = "application/octet-stream";
                    }
                    response.setContentType(mimeType);
                    String headerKey = "Content-Disposition";
                    String headerValue = format("attachment; filename=\"%s\"", downloadFile.getName());
                    response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                    outStream = response.getOutputStream();
                    byte[] buffer = new byte[4096 * 4096];
                    int bytesRead;
                    while ((bytesRead = inStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                }
                outStream.close();
            } else {
                redirect(request, response, "page_fnf.html");
            }
        }
    }

    protected void zipdomanda(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bandorif = request.getSession().getAttribute("bandorif").toString();
        String username = sanitizeInput(request.getParameter("userdoc").replaceAll("'", "''"));

        String tipo = request.getSession().getAttribute("tipo").toString();

        ArrayList<Docuserbandi> lid1 = new ArrayList<>();

        if (tipo.equals("0")) {
            lid1 = listaDocUserBando_nofilemcn(bandorif, username);
        } else if (tipo.equals("1")) {
            lid1 = listaDocuserbando(bandorif, username);
        }

        ArrayList<DocumentiDocente> al = listaDocUserBandoDocenti(username, true);

        ArrayList<FileDownload> ff = new ArrayList<>();

        for (int i = 0; i < lid1.size(); i++) {
            if (!lid1.get(i).getPath().equals("-")) {
                ff.add(preparefilefordownload(lid1.get(i).getPath()));
            }
        }
        for (int i = 0; i < al.size(); i++) {
            ff.add(preparefilefordownload(al.get(i).getB1()));
            ff.add(preparefilefordownload(al.get(i).getCv()));
            ff.add(preparefilefordownload(al.get(i).getDr()));
        }

        Db_Bando dbb = new Db_Bando();
        String pathtemp = dbb.getPath("pathtemp");
        dbb.closeDB();
        createDir(pathtemp);
        String name = bandorif + username + new DateTime().toString("yyyyMMddHHmmssSSS") + ".zip";
        File zipout = createFile(pathtemp + name);
        if (zipListFiles(ff, zipout)) {
            OutputStream outStream;
            try (FileInputStream inStream = new FileInputStream(zipout)) {
                String mimeType = probeContentType(zipout.toPath());
                if (mimeType == null) {
                    mimeType = "application/octet-stream";
                }
                response.setContentType(mimeType);
                String headerKey = "Content-Disposition";
                String headerValue = format("attachment; filename=\"%s\"", zipout.getName());
                response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                outStream = response.getOutputStream();
                byte[] buffer = new byte[4096 * 4096];
                int bytesRead;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
            }
            outStream.close();
        } else {
            redirect(request, response, "page_fnf.html");
        }
    }

    protected void excelcom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void excelcomParziale(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String data_da = request.getParameter("data_da");
            String data_a = request.getParameter("data_a");
            SimpleDateFormat sdf_in = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // creo l'oggetto
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
            Db_Bando db = new Db_Bando();
            String path = db.expexcel_ricerca(dt_da, dt_a);
            db.closeDB();
            File downloadFile = createFile(path);
            if (downloadFile.exists()) {
                OutputStream outStream;
                try (FileInputStream inStream = new FileInputStream(downloadFile)) {
                    String mimeType = probeContentType(downloadFile.toPath());
                    if (mimeType == null) {
                        mimeType = "application/octet-stream";
                    }
                    response.setContentType(mimeType);
                    String headerKey = "Content-Disposition";
                    String headerValue = format("attachment; filename=\"%s\"", downloadFile.getName());
                    response.setHeader(headerKey, headerValue);
                    outStream = response.getOutputStream();
                    byte[] buffer = new byte[4096 * 4096];
                    int bytesRead;
                    while ((bytesRead = inStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                }
                outStream.close();
            } else {
                redirect(request, response, "page_fnf.html");
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM", estraiEccezione(e));
        }
    }

    protected void downconv(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getSession().getAttribute("username").toString();
        File downloadFile = null;
        String var = request.getParameter("ctrl");
        Db_Bando dbb = new Db_Bando();
        String pathtemp = dbb.getPath("pathtemp");
        ArrayList<Docbandi> lidCONV = dbb.listaDocRichiestiBando(bando + "_A");
        Docbandi doc_fase2 = Utility.estraidaLista(lidCONV, "MOD1");
        Docbandi doc_fase3 = Utility.estraidaLista(lidCONV, "MOD2");
        Docbandi doc_fase4 = Utility.estraidaLista(lidCONV, "MOD3");
        
        
        System.out.println("rc.soop.servlet.Download.downconv() "+var);
        
        if (var.equals("1")) {
            File f1 = allegatoC(username);
            if (f1 != null) {
                downloadFile = f1;
            }
        }

        if (var.equals("2")) {
            downloadFile = createFile(pathtemp + File.separator + "G1_" + Utility.generaId(50) + extdocx);
            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(doc_fase2.getDownload()));
        }

        if (var.equals("3")) {
            downloadFile = createFile(pathtemp + File.separator + "G2_" + Utility.generaId(50) + extpdf);
            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(doc_fase3.getDownload()));
        }

        if (var.equals("4")) {
            downloadFile = createFile(pathtemp + File.separator + "G3_" + Utility.generaId(50) + extpdf);
            FileUtils.writeByteArrayToFile(downloadFile, Base64.decodeBase64(doc_fase4.getDownload()));
        }

        dbb.closeDB();

        if (downloadFile != null) {
            OutputStream outStream;
            try (FileInputStream inStream = new FileInputStream(downloadFile)) {
                String mimeType = probeContentType(downloadFile.toPath());
                if (mimeType == null) {
                    mimeType = "application/octet-stream";
                }
                response.setContentType(mimeType);
                String headerKey = "Content-Disposition";
                String headerValue = format("attachment; filename=\"%s\"", downloadFile.getName());
                response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                outStream = response.getOutputStream();
                byte[] buffer = new byte[4096 * 4096];
                int bytesRead;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
            }
            outStream.close();
        } else {
            //redirect(request, response, "page_fnf.html");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {

        try {

            response.setContentType("text/html;charset=UTF-8");
            String action = request.getParameter("action");
            if (action.equals("guida")) {
                guidabando(request, response);
            }
            if (action.equals("guidaConvenzioni")) {
                guidaConvenzioni(request, response);
            }
            if (action.equals("avviso")) {
                avvisobando(request, response);
            }
            if (request.getSession().getAttribute("username") == null) {
                redirect(request, response, "home.jsp");
            } else {
                if (action.equals("docbando")) {
                    docbando(request, response);
                }
                if (action.equals("viewFileConvenzioniRUP")) {
                    viewFileConvenzioniRUP(request, response);
                }
                if (action.equals("docbandoconsrup")) {
                    docbandoconsrup(request, response);
                }
                if (action.equals("docbandoconsrupB1")) {
                    docbandoconsrupB1(request, response);
                }
                if (action.equals("modellodoc")) {
                    modellodoc(request, response);
                }
                if (action.equals("zipdomanda")) {
                    zipdomanda(request, response);
                }
                if (action.equals("docbandoDocente")) {
                    docbandoDocenti(request, response);
                }
                if (action.equals("docAllegatoB1")) {
                    docAllegatoB1(request, response);
                }
                if (action.equals("excelcom")) {
                    excelcom(request, response);
                }
                if (action.equals("excelcomParziale")) {
                    excelcomParziale(request, response);
                }
                if (action.equals("viewFileConvenzioni")) {
                    viewFileConvenzioni(request, response);
                }
                if (action.equals("docbandoconsConv")) {
                    docbandoconsConv(request, response);
                }
                if (action.equals("downconv")) {
                    downconv(request, response);
                }
            }
        } catch (ServletException | IOException ex) {
            trackingAction("service", "Error:processRequestDownload: " + ex.getMessage());
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

    //download docmento del bando
    protected void docbandoDocenti(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipodoc = request.getParameter("tipodoc");
        String indice = request.getParameter("indice");
        String username = request.getSession().getAttribute("username").toString();
        String pathing = "";
        ArrayList<AllegatoB1> al = getAllegatoB1(username, indice);
        for (int i = 0; i < al.size(); i++) {
            switch (tipodoc) {
                case "cv" -> pathing = al.get(i).getAllegatocv();
                case "b1" -> pathing = al.get(i).getAllegatob1();
                case "ci" -> pathing = al.get(i).getAllegatodr();
                default -> {
                }
            }
        }

        //new
        FileDownload fw = preparefilefordownload(pathing);

        if (fw != null) {
            trackingAction(request.getSession().getAttribute("username").toString(), "Download File " + fw.getName());
            String mimeType = fw.getMimeType();
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            String headerKey = "Content-Disposition";
            String headerValue = format("attachment; filename=\"%s\"", fw.getName());
            response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
            try (OutputStream outStream = response.getOutputStream()) {
                outStream.write(decodeBase64(fw.getContent()));
            }
        } else {
            redirect(request, response, "page_fnf.html");
        }

    }

    protected void docAllegatoB1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //     Utility.printRequest(request);
        String username = request.getSession().getAttribute("username").toString();
        String iddocente = sanitizeInput(request.getParameter("iddocente").replaceAll("'", "''"));
//        String pathing = "";
//        String nomeDocente = request.getParameter("nomeDocente");
        File downloadFile = allegatoB1(username, iddocente);
        try {
            if (downloadFile.exists()) {
                trackingAction(request.getSession().getAttribute("username").toString(), "Download File (con modello) " + downloadFile.getName());
                OutputStream outStream;
                try (FileInputStream inStream = new FileInputStream(downloadFile)) {
                    String mimeType = probeContentType(downloadFile.toPath());
                    if (mimeType == null) {
                        mimeType = "application/octet-stream";
                    }
                    response.setContentType(mimeType);
                    String headerKey = "Content-Disposition";
                    String headerValue = format("attachment; filename=\"%s\"", downloadFile.getName());
                    response.setHeader(sanitizeOriginUrl(headerKey), sanitizeOriginUrl(headerValue));
                    outStream = response.getOutputStream();
                    byte[] buffer = new byte[4096 * 4096];
                    int bytesRead;
                    while ((bytesRead = inStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                }
                outStream.close();
            } else {
                redirect(request, response, "page_fnf.html");
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM", estraiEccezione(e));
            redirect(request, response, "page_fnf.html");
        }
    }

}
