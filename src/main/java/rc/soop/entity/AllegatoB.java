/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.entity;

/**
 *
 * @author so
 */
public class AllegatoB {

    public AllegatoB() {
        this.id = -1;
        this.username = "";
        this.Nome = "";
        this.Cognome = "";
        this.CF = "";
        this.Comune = "";
        this.Datanascita = "";
        this.Sesso = "";
        this.Regione = "";
        this.Mail = "";
        this.Pec = "";
        this.Tel = "";
        this.Titolistudio = "";
        this.Qualifiche = "";
        this.elencoenti = "";
        this.Inquadramento = "";
    }

    public AllegatoB(String username, int id, String Nome, String Cognome, String CF, String Comune, String Datanascita,
            String Sesso, String Regione, String Mail, String Pec, String Tel, String Titolistudio, String Qualifiche, String elencoenti, String Inquadramento) {
        this.username = username;
        this.id = id;
        this.Nome = Nome;
        this.Cognome = Cognome;
        this.CF = CF;
        this.Comune = Comune;
        this.Datanascita = Datanascita;
        this.Sesso = Sesso;
        this.Regione = Regione;
        this.Mail = Mail;
        this.Pec = Pec;
        this.Tel = Tel;
        this.Titolistudio = Titolistudio;
        this.Qualifiche = Qualifiche;
        this.elencoenti = elencoenti;
        this.Inquadramento = Inquadramento;
    }

    String username;
    int id;
    String Nome, Cognome, CF, Comune, Datanascita, Sesso, Regione, Mail, Pec, Tel, Titolistudio, Qualifiche, elencoenti, Inquadramento;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public String getCognome() {
        return Cognome;
    }

    public void setCognome(String Cognome) {
        this.Cognome = Cognome;
    }

    public String getCF() {
        return CF;
    }

    public void setCF(String CF) {
        this.CF = CF;
    }

    public String getComune() {
        return Comune;
    }

    public void setComune(String Comune) {
        this.Comune = Comune;
    }

    public String getDatanascita() {
        return Datanascita;
    }

    public void setDatanascita(String Datanascita) {
        this.Datanascita = Datanascita;
    }

    public String getSesso() {
        return Sesso;
    }

    public void setSesso(String Sesso) {
        this.Sesso = Sesso;
    }

    public String getRegione() {
        return Regione;
    }

    public void setRegione(String Regione) {
        this.Regione = Regione;
    }

    public String getMail() {
        return Mail;
    }

    public void setMail(String Mail) {
        this.Mail = Mail;
    }

    public String getPec() {
        return Pec;
    }

    public void setPec(String Pec) {
        this.Pec = Pec;
    }

    public String getTel() {
        return Tel;
    }

    public void setTel(String Tel) {
        this.Tel = Tel;
    }

    public String getTitolistudio() {
        return Titolistudio;
    }

    public void setTitolistudio(String Titolistudio) {
        this.Titolistudio = Titolistudio;
    }

    public String getQualifiche() {
        return Qualifiche;
    }

    public void setQualifiche(String Qualifiche) {
        this.Qualifiche = Qualifiche;
    }

    public String getElencoenti() {
        return elencoenti;
    }

    public void setElencoenti(String elencoenti) {
        this.elencoenti = elencoenti;
    }

    public String getInquadramento() {
        return Inquadramento;
    }

    public void setInquadramento(String Inquadramento) {
        this.Inquadramento = Inquadramento;
    }

}
