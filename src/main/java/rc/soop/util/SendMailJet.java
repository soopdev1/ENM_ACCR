/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.util;

/**
 *
 * @author so
 */
import static com.mailjet.client.Base64.encode;
import com.mailjet.client.ClientOptions;
import static com.mailjet.client.ClientOptions.builder;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import static com.mailjet.client.resource.Emailv31.MESSAGES;
import static com.mailjet.client.resource.Emailv31.Message.ATTACHMENTS;
import static com.mailjet.client.resource.Emailv31.Message.BCC;
import static com.mailjet.client.resource.Emailv31.Message.CC;
import static com.mailjet.client.resource.Emailv31.Message.FROM;
import static com.mailjet.client.resource.Emailv31.Message.HTMLPART;
import static com.mailjet.client.resource.Emailv31.Message.SUBJECT;
import static com.mailjet.client.resource.Emailv31.Message.TO;
import static com.mailjet.client.resource.Emailv31.resource;
import com.mailjet.client.resource.Statcounters;
import static rc.soop.action.ActionB.trackingAction;
import rc.soop.db.Db_Bando;
import rc.soop.entity.FileDownload;
import static rc.soop.util.Utility.estraiEccezione;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import static java.nio.file.Files.probeContentType;
import java.util.List;
import java.util.UUID;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.apache.commons.codec.binary.Base64;
import static org.apache.commons.codec.binary.Base64.encodeBase64;
import org.apache.commons.io.FileUtils;
import static org.apache.commons.io.IOUtils.toByteArray;
import org.joda.time.DateTime;
import org.json.JSONArray;
import org.json.JSONObject;
import static rc.soop.util.Utility.createFile;

/**
 *
 * @author
 */
public class SendMailJet {

    public static boolean sendMail(String name, String[] to, String[] cc, String txt, String subject) {
        return sendMail(name, to, cc, txt, subject, null);
    }

    public static boolean sendMailListAttach(String name, String[] to, String[] cc, String txt, String subject, List<FileDownload> listfile, String username) {

        try {
            MailjetClient client;
            MailjetRequest request;
            MailjetResponse response;

            Db_Bando dbb = new Db_Bando();
            String mailjet_api = dbb.getPath("mailjet_api");
            String mailjet_secret = dbb.getPath("mailjet_secret");
            String mailjet_name = dbb.getPath("mailjet_name");
            String pathtemp = dbb.getPath("pathtemp");

            dbb.closeDB();

            ClientOptions options = builder()
                    .apiKey(mailjet_api)
                    .apiSecretKey(mailjet_secret)
                    .build();

            client = new MailjetClient(options);
            JSONArray dest = new JSONArray();
            JSONArray ccn = new JSONArray();
            JSONArray ccj = new JSONArray();

            if (to != null) {
                for (String s : to) {
                    dest.put(new JSONObject().put("Email", s)
                            .put("Name", ""));
                }
            }

            if (cc != null) {
                for (String s : cc) {
                    ccj.put(new JSONObject().put("Email", s)
                            .put("Name", ""));
                }
            }

            JSONObject mail = new JSONObject().put(FROM, new JSONObject()
                    .put("Email", mailjet_name)
                    .put("Name", name))
                    .put(TO, dest)
                    .put(CC, ccj)
                    .put(BCC, ccn)
                    .put(SUBJECT, subject)
                    .put(HTMLPART, txt);

            if (!listfile.isEmpty()) {

                JSONArray contentfiles = new JSONArray();

                try {
                    File zipped = createFile(pathtemp + username + "_" + UUID.randomUUID() + ".zip");
                    try (FileOutputStream fos = new FileOutputStream(zipped); ZipOutputStream zipOut = new ZipOutputStream(fos)) {
                        zipOut.setLevel(Deflater.BEST_COMPRESSION);
                        for (FileDownload cf1 : listfile) {
                            File fileToZip = createFile(pathtemp + cf1.getName());
                            FileUtils.writeByteArrayToFile(fileToZip, Base64.decodeBase64(cf1.getContent()));
                            try (FileInputStream fis = new FileInputStream(fileToZip)) {
                                ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
                                zipOut.putNextEntry(zipEntry);
                                byte[] bytes = new byte[4096];
                                int length;
                                while ((length = fis.read(bytes)) >= 0) {
                                    zipOut.write(bytes, 0, length);
                                }
                            }
                        }

                    }

                    if (zipped.canRead() && zipped.length() > 0) {
                        JSONObject content = new JSONObject()
                                .put("ContentType", "application/zip")
                                .put("Filename", zipped.getName())
                                .put("Base64Content", 
                                        encode(FileUtils.readFileToByteArray(zipped))
                                                );
                        contentfiles.put(content);
                    }

//                    listfile.forEach(fileingresso -> {
//                        JSONObject content = new JSONObject()
//                                .put("ContentType", fileingresso.getMimeType())
//                                .put("Filename", fileingresso.getName())
//                                .put("Base64Content", fileingresso.getContent());
//                        contentfiles.put(content);
//                    });
                    if (!contentfiles.isEmpty()) {
                        mail.put(ATTACHMENTS, contentfiles);
                    }
                } catch (Exception e) {
                    trackingAction("ERROR SYSTEM", estraiEccezione(e));
                    return false;
                }
            }

            request = new MailjetRequest(resource)
                    .property(MESSAGES, new JSONArray()
                            .put(mail));

            response = client.post(request);

            boolean ok = response.getStatus() == 200;

            if (!ok) {
                trackingAction("ERROR SYSTEM", "sendMail - " + response.getStatus() + " -- " + response.getRawResponseContent() + " --- " + response.getData().toList());
            }

            return ok;
        } catch (Exception ex) {
            trackingAction("ERROR SYSTEM", estraiEccezione(ex));
        }
        return false;

    }

    public static boolean sendMail(String name, String[] to, String[] cc, String txt, String subject, File file) {
        try {
            MailjetClient client;
            MailjetRequest request;
            MailjetResponse response;

            String filename = "";
            String content_type = "";
            String b64 = "";

            Db_Bando dbb = new Db_Bando();
            String mailjet_api = dbb.getPath("mailjet_api");
            String mailjet_secret = dbb.getPath("mailjet_secret");
            String mailjet_name = dbb.getPath("mailjet_name");
            dbb.closeDB();

            ClientOptions options = builder()
                    .apiKey(mailjet_api)
                    .apiSecretKey(mailjet_secret)
                    .build();

            client = new MailjetClient(options);

            JSONArray dest = new JSONArray();
            JSONArray ccn = new JSONArray();
            JSONArray ccj = new JSONArray();

            if (to != null) {
                for (String s : to) {
                    dest.put(new JSONObject().put("Email", s)
                            .put("Name", ""));
                }
            }

            if (cc != null) {
                for (String s : cc) {
                    ccj.put(new JSONObject().put("Email", s)
                            .put("Name", ""));
                }
            }

            JSONObject mail = new JSONObject().put(FROM, new JSONObject()
                    .put("Email", mailjet_name)
                    .put("Name", name))
                    .put(TO, dest)
                    .put(CC, ccj)
                    .put(BCC, ccn)
                    .put(SUBJECT, subject)
                    .put(HTMLPART, txt);

            if (file != null) {
                try {
                    filename = file.getName();
                    content_type = probeContentType(file.toPath());
                    try (InputStream i = new FileInputStream(file)) {
                        b64 = new String(encodeBase64(toByteArray(i)));
                    }
                } catch (Exception e) {
                    trackingAction("ERROR SYSTEM", estraiEccezione(e));
                }
                mail.put(ATTACHMENTS, new JSONArray()
                        .put(new JSONObject()
                                .put("ContentType", content_type)
                                .put("Filename", filename)
                                .put("Base64Content", b64)));
            }

            request = new MailjetRequest(resource)
                    .property(MESSAGES, new JSONArray()
                            .put(mail));

            response = client.post(request);

            boolean ok = response.getStatus() == 200;

            if (!ok) {
                trackingAction("ERROR SYSTEM", "sendMail - " + response.getStatus() + " -- " + response.getRawResponseContent() + " --- " + response.getData().toList());
            }

            return ok;
        } catch (Exception ex) {
            trackingAction("ERROR SYSTEM", estraiEccezione(ex));
        }
        return false;
    }

    public static int countMail(String today) {
        int sending;
        try {
            Db_Bando dbb = new Db_Bando();
            String mailjet_api = dbb.getPath("mailjet_api");
            String mailjet_secret = dbb.getPath("mailjet_secret");
            dbb.closeDB();
            MailjetClient client;
            ClientOptions options = builder()
                    .apiKey(mailjet_api)
                    .apiSecretKey(mailjet_secret)
                    .build();
            client = new MailjetClient(options);
            MailjetRequest request;
            MailjetResponse response;
            if (today == null) {
                today = new DateTime().withMillisOfDay(0).toString("yyyy-MM-dd'T'HH:mm:ss");
            }
            request = new MailjetRequest(Statcounters.resource).filter(Statcounters.COUNTERSOURCE, "APIKey").filter(Statcounters.COUNTERTIMING, "Message")
                    .filter(Statcounters.COUNTERRESOLUTION, "Day").filter(Statcounters.FROMTS, today).filter(Statcounters.TOTS, today);
            response = client.get(request);
            if (response.getStatus() == 200) {
                try {
                    sending = new JSONArray(response.getData()).getJSONObject(0).getInt("Total");
                } catch (Exception e) {
                    sending = 0;
                }
            } else {
                sending = -1;
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM", estraiEccezione(e));
            sending = -1;
        }
        return sending;
    }
}
