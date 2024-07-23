/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.entity;

/**
 *
 * @author rcosco
 */
public class Allegati_Valori {

    String allegato, username, campo, valore, timestamp;

    public Allegati_Valori(String allegato, String username, String campo, String valore, String timestamp) {
        this.allegato = allegato;
        this.username = username;
        this.campo = campo;
        this.valore = valore;
        this.timestamp = timestamp;
    }

    public String getAllegato() {
        return allegato;
    }

    public void setAllegato(String allegato) {
        this.allegato = allegato;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCampo() {
        return campo;
    }

    public void setCampo(String campo) {
        this.campo = campo;
    }

    public String getValore() {
        return valore;
    }

    public void setValore(String valore) {
        this.valore = valore;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
    
    
    
    
}
