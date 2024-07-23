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
public class Items {
    
    String cod;
    int codice;
    String descrizione;

    public Items(String cod, String descrizione) {
        this.cod = cod;
        this.descrizione = descrizione;
    }
    
    
    
    public Items(int codice, String descrizione) {
        this.codice = codice;
        this.descrizione = descrizione;
    }

    public String getCod() {
        return cod;
    }

    public void setCod(String cod) {
        this.cod = cod;
    }
    
    public int getCodice() {
        return codice;
    }

    public void setCodice(int codice) {
        this.codice = codice;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

}
