/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import java.io.File;
import static org.apache.commons.lang3.StringUtils.substring;
import rc.soop.db.Db_Bando;
import rc.soop.action.ActionB;
import static rc.soop.util.Utility.createFile;

/**
 *
 * @author Administrator
 */
public class NewFile {

    public static void main(String[] args) {

        try {

            String dir = "C:\\Users\\Administrator\\Desktop\\da caricare\\";
//
            File[] listdir = createFile(dir).listFiles((File dir1, String name) -> name.toLowerCase().endsWith(".p7m"));
            Db_Bando db1 = new Db_Bando();
            for (File f1 : listdir) {
                String username = substring(f1.getName(), f1.getName().lastIndexOf(".") - 10, f1.getName().lastIndexOf("."));
                String update = "UPDATE convenzioniroma SET path = '" + ActionB.preparefileforupload(f1) + "' WHERE username='" + username + "'";
//                String update = "UPDATE docuserconvenzioni SET path = '"+ActionB.preparefileforupload(f1)+"' WHERE codicedoc='CONV' AND username='" + username + "'";

                boolean up1 = db1.getConnection().createStatement().executeUpdate(update) > 0;
                System.out.println(username + ": " + up1);
            }
            db1.closeDB();

//            preparefileforupload();
//            String username= "ADIBEN0622";
//            List<String> userslist = new ArrayList<>();
//            
//            userslist.add("ADIBEN0622");
//            userslist.add("ALARI7277");
//            userslist.add("AMANUN8385");
//            userslist.add("BCULLA0838");
//            userslist.add("CTRIAR5660");
//            userslist.add("DBONFI3376");
//            userslist.add("DLAPIC1505");
//            userslist.add("ECARUL7877");
//            userslist.add("MTRIEL1081");
//             Db_Bando db = new Db_Bando();
//            String protocollo = db.getProtocolloDomandaInviata(username).toUpperCase();
//            String ragsoc = db.getRagioneSociale(username).toUpperCase();
//            String text = db.getPath("mail.invioconvenzione.roma").replaceAll("@prot", protocollo).replaceAll("@ragsoc", ragsoc);
//            db.closeDB();
//            
//for(String username:userslist){
//            System.out.println("test.NewFile.main() "+allegatoC(username).getPath());
//    
//}
//            
//            String to[] = {"raffaele.cosco@smartoop.it"};
//            String cc[] = {"info@smartoop.it"};
//            
//            List<FileDownload> listafiledainviare = ActionB.lista_file_Convenzione(username, protocollo, ragsoc);
//            
//            boolean mailok = sendMailListAttach(
//                    nomevisual, to, cc, text,
//                    nomevisual + " - Invio convenzione da parte del Soggetto Attuatore: " + ragsoc,
//                    listafiledainviare,username);
//            System.out.println("test.NewFile.main() "+mailok);
//            System.out.println(getExtension(new File("C:\\Users\\Administrator\\Desktop\\da caricare\\FMIGLI2000171020220947443.A_All.A.pdf.p7m").getName()));
//            
//            SignedDoc dc = extractSignatureInformation_P7M(readFileToByteArray(new File("C:\\Users\\Administrator\\Desktop\\da caricare\\FMIGLI2000171020220947443.A_All.A.pdf.p7m")));
//            System.out.println("test.NewFile.main() "+dc.getCodicefiscale());
//            System.out.println("test.NewFile.main() "+dc.getErrore());
//            System.out.println("test.NewFile.main() "+dc.isValido());
////        File out1 = allegatoC("FVALOC6567");
////        System.out.println(out1.getPath());
//
//        String username = "DMARRE0776";
//        Db_Bando db = new Db_Bando();
//        ArrayList<Docuserconvenzioni> aldocumenti = db.getDocumentiConvenzioni(username);
//        String protocollo = db.getProtocolloDomandaInviata(username).toUpperCase();
//        String ragsoc = db.getRagioneSociale(username).toUpperCase();
//        db.closeDB();
//        Docuserconvenzioni conv = aldocumenti.stream().filter(d1 -> d1.getCodicedoc().contains("CONV")).findAny().orElse(null);
//        if (conv != null) {
//            File nullaosta = nullaosta(username, protocollo, ragsoc, new DateTime());
//            System.out.println(nullaosta.getPath());
//        }
//        
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
