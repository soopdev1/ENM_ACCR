/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.entity;

import static rc.soop.util.Utility.cp_toUTF;

/**
 *
 * @author rcosco
 */
public class Prov_rc {

    String codiceprovincia, provincia;

    public Prov_rc(String codiceprovincia, String provincia) {
        this.codiceprovincia = codiceprovincia;
        this.provincia = cp_toUTF(provincia);
    }

    public String getCodiceprovincia() {
        return codiceprovincia;
    }

    public void setCodiceprovincia(String codiceprovincia) {
        this.codiceprovincia = codiceprovincia;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

}
