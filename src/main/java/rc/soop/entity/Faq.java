/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.entity;

/**
 *
 * @author raffaele
 */
public class Faq {

    int idfaq, tipo;
    String date_answer, date_ask, domanda, domanda_mod, risposta, timestamp, usernamesoggetto, usernamerisposta;

    public Faq() {
    }

    public Faq(int idfaq, int tipo, String date_answer, String date_ask, String domanda, String domanda_mod, String risposta, String timestamp, String usernamesoggetto, String usernamerisposta) {
        this.idfaq = idfaq;
        this.tipo = tipo;
        this.date_answer = date_answer;
        this.date_ask = date_ask;
        this.domanda = domanda;
        this.domanda_mod = domanda_mod;
        this.risposta = risposta;
        this.timestamp = timestamp;
        this.usernamesoggetto = usernamesoggetto;
        this.usernamerisposta = usernamerisposta;
    }

    public int getIdfaq() {
        return idfaq;
    }

    public void setIdfaq(int idfaq) {
        this.idfaq = idfaq;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public String getDate_answer() {
        return date_answer;
    }

    public void setDate_answer(String date_answer) {
        this.date_answer = date_answer;
    }

    public String getDate_ask() {
        return date_ask;
    }

    public void setDate_ask(String date_ask) {
        this.date_ask = date_ask;
    }

    public String getDomanda() {
        return domanda;
    }

    public void setDomanda(String domanda) {
        this.domanda = domanda;
    }

    public String getDomanda_mod() {
        return domanda_mod;
    }

    public void setDomanda_mod(String domanda_mod) {
        this.domanda_mod = domanda_mod;
    }

    public String getRisposta() {
        return risposta;
    }

    public void setRisposta(String risposta) {
        this.risposta = risposta;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getUsernamesoggetto() {
        return usernamesoggetto;
    }

    public void setUsernamesoggetto(String usernamesoggetto) {
        this.usernamesoggetto = usernamesoggetto;
    }

    public String getUsernamerisposta() {
        return usernamerisposta;
    }

    public void setUsernamerisposta(String usernamerisposta) {
        this.usernamerisposta = usernamerisposta;
    }

}
