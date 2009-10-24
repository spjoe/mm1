/*
 * VolumeControl.fx
 *
 * Created on 24.10.2009, 15:17:52
 */

package org.tuwien.mm1.controls;


import javafx.animation.transition.*;
import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.input.*;
import javafx.scene.paint.*;


/**
 * @author camillo
 */

public class VolumeControl extends CustomNode {
    public var x: Number;
    public var y: Number;
    public var width: Number = 20;
    public var height: Number = 130;

    public var volume: Number;
    public var mute: Boolean = false;
    public var barElaspedColor: Color = Color{ red: 17/255.0 green: 17/255.0 blue: 238/255.0 };

    //public-init var initialValue:Number;
    public-read var enabled:Boolean = true;

    public var fill:Color = Color.HOTPINK;
    var disabledColor:Color = Color.LIGHTGRAY;
    var gap:Number = 1;
    var entered:Boolean = false;

    public var buttonWidth: Number = 20;
    public var buttonHeight: Number = 20;

    var scheduleRemoveSlider:PauseTransition = PauseTransition {
        duration: 300ms
        action: function() {
            if(not entered) {
                //removeSlider();
            }
        }
    }

    var slider: Slider = Slider {
        width: buttonWidth
        height: buttonHeight
        vertical: true
        visible: true
        value: bind volume with inverse;

        onMouseEntered: function(me:MouseEvent) {
            entered = true;
            if(scheduleRemoveSlider.running) {
                scheduleRemoveSlider.stop();
            }
        }

        onMouseExited: function(me:MouseEvent) {
            entered = false;
            scheduleRemoveSlider.playFromStart();
        }
    }

   

    public override function create(): Node {
        return Group {
            content: [ slider ]
        }
    }
}
