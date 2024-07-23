/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.otp;

import static rc.soop.action.ActionB.trackingAction;
import static rc.soop.util.Utility.estraiEccezione;
import static java.lang.Class.forName;
import java.sql.Connection;
import static java.sql.DriverManager.getConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.ResourceBundle;

/**
 *
 * @author rcosco
 */
public class Db_OTP {

    private Connection conn = null;
    private static final ResourceBundle conf = ResourceBundle.getBundle("conf.conf");

    public Db_OTP() {

        String driver = "com.mysql.cj.jdbc.Driver";
        String user = conf.getString("db.user");
        String password = conf.getString("db.pass");
        String host = conf.getString("db.host") + ":3306/enm_otp";

        try {
            forName(driver).newInstance();
            Properties p = new Properties();
            p.put("user", user);
            p.put("password", password);
            p.put("characterEncoding", "UTF-8");
            p.put("passwordCharacterEncoding", "UTF-8");
            p.put("useSSL", "false");
            p.put("connectTimeout", "1000");
            p.put("useUnicode", "true");
            this.conn = getConnection("jdbc:mysql://" + host, p);
        } catch (Exception ex) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(ex));
            if (this.conn != null) {
                try {
                    this.conn.close();
                } catch (Exception ex1) {
                }
            }
            this.conn = null;
        }
    }

    public Db_OTP(Connection conn) {
        try {
            this.conn = conn;
        } catch (Exception ex) {
        }
    }

    public Connection getConnectionDB() {
        return conn;
    }

    public void closeDB() {
        try {
            if (conn != null) {
                this.conn.close();
            }
        } catch (SQLException ex) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(ex));
        }
    }

    public boolean cambiastato(String codProgetto, String user, int idsms, String statodest) {
        PreparedStatement ps = null;
        try {
            String update = "UPDATE ctrlotp SET stato = ? WHERE stato = 'A' AND codprogetto = ? AND user = ? AND idsms = ?";
            ps = this.conn.prepareStatement(update);
            ps.setString(1, statodest);
            ps.setString(2, codProgetto);
            ps.setString(3, user);
            ps.setInt(4, idsms);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(e));
            return false;
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } catch (SQLException ex) {
                trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(ex));
            }
        }
    }

    public boolean insOtp(String codProgetto, String user, String codOtp, String numcell, int idsms) {
        try {
            cambiastato(codProgetto, user, idsms, "KO");
            String upd = "insert into ctrlotp (codprogetto,user,codotp,numcell,idsms) values (?,?,?,?,?)";
            try (PreparedStatement ps = this.conn.prepareStatement(upd)) {
                ps.setString(1, codProgetto);
                ps.setString(2, user);
                ps.setString(3, codOtp);
                ps.setString(4, numcell);
                ps.setInt(5, idsms);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(e));
        }
        return false;
    }

    public String getSMS(String codprogetto, int codMsg) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT msg FROM sms WHERE codprogetto = ? AND idsms = ?";
            ps = this.conn.prepareStatement(sql);
            ps.setString(1, codprogetto);
            ps.setInt(2, codMsg);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("msg");
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(e));
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException ex) {
                trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(ex));
            }
        }
        return null;
    }

    public boolean isOK(String codprogetto, String user, String otp, int idsms) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT codprogetto FROM ctrlotp WHERE codprogetto = ? AND user = ? AND codotp = ? AND stato = ? AND idsms = ?";
            ps = this.conn.prepareStatement(sql);
            ps.setString(1, codprogetto);
            ps.setString(2, user);
            ps.setString(3, otp);
            ps.setString(4, "A");
            ps.setInt(5, idsms);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(e));
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException ex) {
                trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(ex));
            }
        }
        return false;
    }

    public String getPath(String id) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT url FROM path WHERE id = ?";
            ps = this.conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("url");
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(e));
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException ex) {
                trackingAction("ERROR SYSTEM DBOTP", estraiEccezione(ex));
            }
        }
        return null;
    }

}
