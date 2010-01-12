/*
 * MyMediaPlayer.fx
 *
 * Created on 24.10.2009, 15:16:47
 */

package org.tuwien.mm1.controls;

import javafx.scene.CustomNode;
import javax.media.Manager;
import javax.media.Player;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.transform.Transform;
import javafx.ext.swing.SwingComponent;
import java.lang.System;
import javax.media.PlugInManager;

import org.tuwien.mm1.jmf.filters.SimpleFilter;

class JavaComponent extends SwingComponent{
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

public class MyMediaPlayer extends CustomNode{

    var xpos: Number;
    var ypos: Number;
    var dx: Number;


    public var url: java.net.URL;
    public var autoPlay: Boolean;
    
    var player:Player;

    public function play(){

    }

    public override function create(): Node{
        Manager.setHint(Manager.LIGHTWEIGHT_RENDERER, true);

        player = Manager.createRealizedPlayer(url);

        var s = new SimpleFilter();


        PlugInManager.addPlugIn("org.tuwien..mm1.jmf.filters.SimpleFilter",
            s.getSupportedInputFormats(),
            s.getSupportedOutputFormats(null),
            PlugInManager.EFFECT);

        var vis = player.getVisualComponent();
        var panel = new javax.swing.JPanel();
        var panel2 = new javax.swing.JPanel();
        var pan = player.getControlPanelComponent();


        panel.add(vis);
        panel2.add(pan);
        var view = javafx.ext.swing.SwingComponent.wrap(panel);
        var view2 = javafx.ext.swing.SwingComponent.wrap(panel2);

        if (autoPlay) {
            player.start();
        }

        return Group{
            content: [
                view,
                view2
            ]
            transforms: Transform.translate(xpos, ypos)
        }
    }

}
