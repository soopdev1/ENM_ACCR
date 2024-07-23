/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.soop.otp;

import com.sinch.xms.ApiConnection;
import com.sinch.xms.SinchSMSApi;
import com.sinch.xms.api.MtBatchTextSmsResult;
import static rc.soop.action.ActionB.trackingAction;
import rc.soop.db.Db_Bando;
import static rc.soop.util.Utility.estraiEccezione;

/**
 *
 * @author rcosco
 */
public class Sms {

    public static boolean sendSMS2024(String cell, String msg) {
        try {

            Db_Bando dbb = new Db_Bando();
            String servicePlanId = dbb.getPath("sms.synch.sp.id");
            String token = dbb.getPath("sms.synch.token");
            String sender = dbb.getPath("sms.synch.sender");
            dbb.closeDB();
            try (ApiConnection conn = ApiConnection.builder()
                    .servicePlanId(servicePlanId)
                    .token(token)
                    .start()) {
                String[] recipients = {"39" + cell};
                MtBatchTextSmsResult batch
                        = conn.createBatch(
                                SinchSMSApi.batchTextSms()
                                        .sender(sender)
                                        .addRecipient(recipients)
                                        .body(msg)
                                        .build());
                trackingAction("SYSTEM", "OK SEND SMS: " + recipients[0] + " - ID: " + batch.id().toString());
                return true;
            }
        } catch (Exception e) {
            trackingAction("ERROR SYSTEM", estraiEccezione(e));
        }
        return false;
    }
    
}
