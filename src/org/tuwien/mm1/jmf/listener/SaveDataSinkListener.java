/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.tuwien.mm1.jmf.listener;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.media.datasink.DataSinkEvent;
import javax.media.datasink.DataSinkListener;
import javax.media.datasink.EndOfStreamEvent;
/**
 *
 * @author camillo
 */
public class SaveDataSinkListener implements DataSinkListener{
    
    /*@Override*/
    /**
     *
     * @param e
     */
    public void dataSinkUpdate(DataSinkEvent e) {
        if(e instanceof EndOfStreamEvent){
            try {
                System.out.println("Juhu Fertig mit Speichern");
                e.getSourceDataSink().stop();
                e.getSourceDataSink().close();
            } catch (IOException ex) {
                Logger.getLogger(SaveDataSinkListener.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        System.out.println(e);
    }

}
