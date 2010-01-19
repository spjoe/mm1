/*
 * SaveControllerListenerFx.fx
 *
 * Created on 18.01.2010, 19:19:12
 */

package org.tuwien.mm1.jmf.listener;

/**
 * @author camillo
 */
import org.tuwien.mm1.controls.MyButton;
import javax.media.ControllerEvent;
import javax.media.ControllerListener;
import javax.media.RealizeCompleteEvent;
import java.lang.*;


public class SaveControllerListenerFx extends ControllerListener{
    public var button: MyButton ;
    

    public override function controllerUpdate(e: ControllerEvent ) {
        if(e instanceof RealizeCompleteEvent){
                System.out.println("test");
                button.isRealized();
                
         }
         if(e instanceof javax.media.DeallocateEvent){
                System.out.println("test");
                button.isDeallocated();

         }if(e instanceof javax.media.ConfigureCompleteEvent){
                System.out.println("test123");
                button.isConfigured();

         }
    }
}
