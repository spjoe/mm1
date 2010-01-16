/*
 * MyMediaPlayer.fx
 *
 * Created on 24.10.2009, 15:16:47
 */

package org.tuwien.mm1.controls;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ArrayBlockingQueue;
import javafx.scene.CustomNode;
import javax.media.Manager;
import javax.media.Player;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.transform.Transform;
import javafx.ext.swing.SwingComponent;
import java.lang.System;
import javax.media.PlugInManager;
import javax.media.Processor;
import javax.media.format.VideoFormat;
import javax.media.UnsupportedPlugInException;
import javax.media.ControllerListener;
import javax.media.ControllerEvent;
import javax.media.ConfigureCompleteEvent;
import javax.media.RealizeCompleteEvent;

import org.tuwien.mm1.jmf.filters.SimpleFilter;

class JavaComponent extends SwingComponent  {
    var comp: java.awt.Component;

    public override function createJComponent():javax.swing.JComponent{
        var panel = new javax.swing.JPanel();
        System.out.println(comp.toString());
        comp = javax.swing.JPanel{
            
        }

        if(comp == null)
            return panel;
        panel.add(comp);
        return panel;
    }
}

/**
 * @author camillo
 */

public class MyMediaPlayer extends ControllerListener,CustomNode{

    var xpos: Number;
    var ypos: Number;
    var dx: Number;

    var proc:Processor;
    var panel = new javax.swing.JPanel();
    var panel2 = new javax.swing.JPanel();

    var blocking:BlockingQueue;


    public var url: java.net.URL;
    public var autoPlay: Boolean;

    public var Filter: org.tuwien.mm1.jmf.filters.SimpleFilter;

    public function play(){

    }
    //override var onEvent = function(e: Event){
      //  if(e instanceof ConfigureCompleteEvent){

        //}
    //}
    public override function create(): Node{
        blocking = new ArrayBlockingQueue(10);
        Manager.setHint(Manager.LIGHTWEIGHT_RENDERER, true);
        var s = new SimpleFilter();


        PlugInManager.addPlugIn("org.tuwien.mm1.jmf.filters.SimpleFilter",
            s.getSupportedInputFormats(),
            s.getSupportedOutputFormats(null),
            PlugInManager.EFFECT);
        
        PlugInManager.commit();

        //player = Manager.createRealizedPlayer(url);

        proc = Manager.createProcessor(url);
        proc.addControllerListener(this);
        proc.configure();

        //where is sync in javaFx?
        var test = blocking.take();
        System.out.println(test);
        System.out.println(proc.getState());

        //panel.setPreferredSize(new java.awt.Dimension(640,480));
        //panel2.setPreferredSize(new java.awt.Dimension(640,100));

        panel.add(proc.getVisualComponent());
        panel2.add(proc.getControlPanelComponent());
        var view = javafx.ext.swing.SwingComponent.wrap(panel);
        var view2 = javafx.ext.swing.SwingComponent.wrap(panel2);

        if(autoPlay)
            proc.start();

        return Group{
        content: [
            view,
            view2
        ]
        transforms: Transform.translate(xpos, ypos)
        }
    }
    public override function controllerUpdate(e:ControllerEvent){
            if(e instanceof ConfigureCompleteEvent){
                System.out.println("juhu");
                proc.setContentDescriptor(null);
                var tc = proc.getTrackControls();

                for(t in tc){
                    var format = t.getFormat();
                    System.out.println(format);
                    if(format instanceof VideoFormat){
                        System.out.println("juhu3");
                        Filter = new SimpleFilter();
                        var codec = [Filter];
                        //System.out.println(t.getCodecChain());
                        t.setCodecChain(codec);
                    }

                }

                proc.realize();
            }
            if(e instanceof RealizeCompleteEvent){
                System.out.println("juhu2");
                blocking.put("bla");
                //proc.prefetch();
            }

    }



}
