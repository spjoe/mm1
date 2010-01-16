/*
 * MyToggleGroup.fx
 *
 * Created on 16.01.2010, 13:55:55
 */

package org.tuwien.mm1.controls;

import javafx.scene.control.ToggleGroup;
import javafx.scene.control.ToggleButton;
import java.lang.System;

/**
 * @author camillo
 */

public class MyToggleGroup extends ToggleGroup{
    public var test : ToggleButton = bind selectedButton on replace prev = next {
        System.out.println("LOL");
    };
    

}
