/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.action;

import static rc.soop.action.ActionB.listaDocRichiesti;
import rc.soop.db.Db_Bando;
import rc.soop.entity.Docbandi;
import rc.soop.entity.Docuserbandi;
import rc.soop.entity.Items;
import rc.soop.entity.Prov_rc;
import java.util.ArrayList;

/**
 *
 * @author raffaele
 */
public class Liste {

    public ArrayList<Docbandi> lid1 = null;
    public ArrayList<Docbandi> lid2 = null;
    public ArrayList<Docuserbandi> lidUser = null;

    ArrayList<Prov_rc> province = null;
    ArrayList<Prov_rc> reg = null;
    ArrayList<Items> fonti = null;
    ArrayList<Items> aree = null;
    ArrayList<Items> titolistudio = null;
    ArrayList<Items> qualifiche = null;
    ArrayList<Items> inquadr = null;
    ArrayList<Items> disponibilita = null;

    public Liste() {
    }

    public Liste(String bando, String username) {

        Db_Bando db1 = new Db_Bando();
        this.lid1 = listaDocRichiesti(db1, bando, username);
        this.lid2 = db1.listaDocRichiestiBando(bando + "_A");
        this.lidUser = db1.listaDocUserBando(bando, username);
        this.province = db1.query_province_rc();
        this.reg = db1.query_regione_rc();
        this.fonti = db1.query_fontifin_rc();
        this.aree = db1.query_aree_rc();
        this.titolistudio = db1.query_titolistudio_rc();
        this.qualifiche = db1.query_qualificazione_rc();
        this.inquadr = db1.query_inquadramento_rc();
        this.disponibilita = db1.query_disponibilita_rc();
        db1.closeDB();
    }

    public ArrayList<Docbandi> getLid2() {
        return lid2;
    }

    public void setLid2(ArrayList<Docbandi> lid2) {
        this.lid2 = lid2;
    }

    public ArrayList<Docuserbandi> getLidUser() {
        return lidUser;
    }

    public void setLidUser(ArrayList<Docuserbandi> lidUser) {
        this.lidUser = lidUser;
    }

    public ArrayList<Docbandi> getLid1() {
        return lid1;
    }

    public void setLid1(ArrayList<Docbandi> lid1) {
        this.lid1 = lid1;
    }

    public String formatTipoDoc(String cod) {

        if (cod.equals("RALL")) {
            return "ALLEGATO CARICATO DA OPERATORE MCN";
        }

        for (int i = 0; i < lid1.size(); i++) {
            if (lid1.get(i).getCodicedoc().equals(cod)) {
                return lid1.get(i).getTitolo();
            }
        }

        return "-";
    }

    public static String formatTipoDoc2(String cod, ArrayList<String[]> ing) {
        if (cod.equals("RALL")) {
            return "ALLEGATO CARICATO DA OPERATORE MCN";
        }
        for (int i = 0; i < ing.size(); i++) {
            if (ing.get(i)[0].equals(cod)) {
                return ing.get(i)[1];
            }
        }
       return "-";
    }
    
    public static String formatTipoDoc(String cod, ArrayList<Docbandi> ing) {

        if (cod.equals("RALL")) {
            return "ALLEGATO CARICATO DA OPERATORE MCN";
        }
        for (int i = 0; i < ing.size(); i++) {
            if (ing.get(i).getCodicedoc().equals(cod)) {
                return ing.get(i).getTitolo();
            }
        }
       return "-";
    }

    public ArrayList<Prov_rc> getProvince() {
        return province;
    }

    public void setProvince(ArrayList<Prov_rc> province) {
        this.province = province;
    }

    public ArrayList<Prov_rc> getReg() {
        return reg;
    }

    public void setReg(ArrayList<Prov_rc> reg) {
        this.reg = reg;
    }

    public ArrayList<Items> getFonti() {
        return fonti;
    }

    public void setFonti(ArrayList<Items> fonti) {
        this.fonti = fonti;
    }

    public ArrayList<Items> getAree() {
        return aree;
    }

    public void setAree(ArrayList<Items> aree) {
        this.aree = aree;
    }

    public ArrayList<Items> getTitolistudio() {
        return titolistudio;
    }

    public void setTitolistudio(ArrayList<Items> titolistudio) {
        this.titolistudio = titolistudio;
    }

    public ArrayList<Items> getQualifiche() {
        return qualifiche;
    }

    public void setQualifiche(ArrayList<Items> qualifiche) {
        this.qualifiche = qualifiche;
    }

    public ArrayList<Items> getInquadr() {
        return inquadr;
    }

    public void setInquadr(ArrayList<Items> inquadr) {
        this.inquadr = inquadr;
    }

    public ArrayList<Items> getDisponibilita() {
        return disponibilita;
    }

    public void setDisponibilita(ArrayList<Items> disponibilita) {
        this.disponibilita = disponibilita;
    }

}
