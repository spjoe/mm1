/*
 * JavaComponent.fx
 *
 * Created on 12.01.2010, 09:52:56
 */

package org.tuwien.mm1.controls;

import javafx.ext.swing.SwingComponent;
import java.lang.System;

/**
 * @author camillo
 */

class JavaComponent extends SwingComponent{
    var comp: java.awt.Component;

    public override function createJComponent():javax.swing.JComponent{
        var panel = new javax.swing.JPanel();
        System.out.println(comp.toString());
        if(comp == null)
            return panel;
        panel.add(comp);
        return panel;
    }
}
