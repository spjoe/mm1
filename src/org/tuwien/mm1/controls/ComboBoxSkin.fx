/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
 * Copyright 2009 Sun Microsystems, Inc. All rights reserved. Use is subject to license terms.
 *
 * This file is available and licensed under the following license:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *
 *   * Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation
 *     and/or other materials provided with the distribution.
 *
 *   * Neither the name of Sun Microsystems nor the names of its contributors
 *     may be used to endorse or promote products derived from this software
 *     without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package org.tuwien.mm1.controls;

import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.ClosePath;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.Group;
import javafx.scene.control.ListView;
import javafx.scene.shape.Line;
import javafx.scene.control.Skin;
import javafx.scene.input.KeyCode;
import javafx.scene.control.Label;
import javafx.scene.layout.LayoutInfo;
import javafx.scene.layout.HBox;
import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import javafx.scene.control.Behavior;
import javafx.scene.input.KeyEvent;


/**
 * @author Rakesh Menon
 */

public class ComboBoxSkin extends Skin {

    var buttonTop = "#62778a";
    var buttonBottom = "#253a4d";
    var buttonFillTop = "#f6f8fa";
    var buttonFillCenter = "#a8bcce";
    var buttonFillBottom = "#bbd0e3";
    var borderTop = "#95989E";
    var borderBottom = "#585B61";
    var textBG = "#dddfe5";
    var focusBorder = "#0093ff";

    override var behavior = ComboBoxBehavior { };
    
    var buttonWidth = 20.0;

    var listY = 0.0;

    var timeline : Timeline = Timeline {

        keyFrames: [
            KeyFrame {
                time: 0s
                canSkip: true
                values: [
                    listY => (node.localToScene(node.layoutBounds).maxY) - 120
                ]
                action: function() {
                    list.visible = (timeline.rate == 1);
                }
            },
            KeyFrame {
                time: 200ms
                canSkip: true
                values: [
                    listY => (node.localToScene(node.layoutBounds).maxY) + 2 tween Interpolator.EASEOUT
                ]
            }
        ]
    };

    public var showPopup = false on replace {

        if(showPopup) {
            timeline.rate = 1;
            timeline.playFromStart();
            list.visible = true;
            listView.requestFocus();
        } else if(timeline.running) {
            timeline.stop();
            listY = (node.localToScene(node.layoutBounds).maxY) - 120;
        } else {
            timeline.rate = -1;
            timeline.time = 200ms;
            timeline.play();
        }
    }

    public-read var listView : ListView = ListView {

        translateY: bind listY
        
        items: bind (control as ComboBox).items

        onMouseClicked: function(e) {
            showPopup = false;
            control.requestFocus();
        }

        layoutInfo: LayoutInfo {
            width: bind control.width - 10
            height: 120
        }
    };

    public-read var list : HBox = HBox {
        visible: false
        content: [ listView ]
        blocksMouse: true
        clip: bind Rectangle {
            x: -2
            y: bind node.localToScene(node.layoutBounds).maxY
            width: bind control.width + 4
            height: 124
        }
    };
    
    var listViewFocus = bind listView.focused on replace {
        if(not listViewFocus) {
            showPopup = false;
        }
    }

    var listVisible = bind list.visible on replace {
        if(not listVisible) {
            delete list from list.scene.content;
        }
    }
    
    var text : Label = Label {
        font : Font { size : 12 }
        text: bind "{listView.selectedItem}"
        width: bind control.width - buttonWidth - 8
        layoutX: 8
        layoutY: bind (control.height - text.layoutBounds.height)/2.0
    }
    
    var buttonBGRect : Rectangle = Rectangle {

        x: bind borderBGRect.width - buttonWidth + 2
        y: 2
        width: buttonWidth
        height: bind borderBGRect.height

        arcWidth: 10
        arcHeight: 10

        fill: LinearGradient {
            startX: 0.0, startY: 0.0, endX: 0.0, endY: 1.0
            proportional: true
            stops: [
                Stop { offset: 0.0 color: Color.web(buttonFillTop) },
                Stop { offset: 0.3 color: Color.web(buttonFillCenter) },
                Stop { offset: 0.7 color: Color.web(buttonFillBottom) }
            ]
        }

        strokeWidth: 1.5
        stroke: LinearGradient {
            startX: 0.0, startY: 0.0, endX: 0.0, endY: 1.0
            proportional: true
            stops: [
                Stop { offset: 0.0 color: Color.web(buttonTop) },
                Stop { offset: 1.0 color: Color.web(buttonBottom) }
            ]
        }

        clip: Rectangle {
            x: bind buttonBGRect.x + 3
            y: 2
            width: bind buttonWidth
            height: bind buttonBGRect.height
        }
    }

    var borderLine = Line {
        startX: bind buttonBGRect.x + 3
        startY: 2
        endX: bind buttonBGRect.x + 3
        endY: bind buttonBGRect.height
        strokeWidth: 1.5
        stroke: bind buttonBGRect.stroke
    }

    var borderBGRect = Rectangle {

        x: 2
        y: 2
        width: bind control.width - 4
        height: bind control.height - 4
        arcWidth: 10
        arcHeight: 10

        strokeWidth: 1.5
        stroke: LinearGradient {
            startX: 0.0, startY: 0.0, endX: 0.0, endY: 1.0
            proportional: true
            stops: [
                Stop { offset: 0.0 color: Color.web(borderTop) },
                Stop { offset: 1.0 color: Color.web(borderBottom) }
            ]
        }

        fill: LinearGradient {
            startX: 0.0, startY: 0.0, endX: 0.0, endY: 1.0
            proportional: true
            stops: [
                Stop { offset: 0.0 color: Color.WHITE },
                Stop { offset: 0.3 color: Color.web(textBG) },
                Stop { offset: 0.7 color: Color.WHITE }
            ]
        }
    }

    var focusBorderColor = Color.web(focusBorder);
    var focusRect = Rectangle {
        width: bind control.width
        height: bind control.height
        arcWidth: 10
        arcHeight: 10
        fill: bind if(control.focused or listView.focused) {
            focusBorderColor
        } else {
            Color.TRANSPARENT
        }
    }

    var arrow : Path = Path {

        layoutX: bind buttonBGRect.x + 6
        layoutY: bind (control.height - arrow.layoutBounds.height)/2.0 + 2

        elements: [
            MoveTo { x: 0.0 y: 0.0 },
            LineTo { x: bind (buttonBGRect.width - 10) y: 0.0 },
            LineTo { x: bind (buttonBGRect.width - 10)/2.0 y: 6 },
            ClosePath { }
        ]

        strokeWidth: 1.0
        fill: Color.BLACK
        stroke: Color.web("#9B9B9B")
    };

    override function intersects(x, y, w, h) : Boolean {
        return node.intersects(x, y, w, h);
    }

    override function contains(x, y) : Boolean {
        return node.contains(x, y);
    }

    init {
        
        node = Group {
            content: [ 
                focusRect, borderBGRect, text, buttonBGRect, borderLine, arrow
            ]
            focusTraversable: false
        }

        node.onMousePressed = function(e) {
            var x = e.sceneX - e.x;
            var y = e.sceneY - e.y + node.layoutBounds.height;
            var visible = not showPopup;
            show(x, y, visible);
        }

        /**
         * Redirect key events on ListView to Control
         */

        listView.onKeyPressed = function(e) {
            if(e.code == KeyCode.VK_ENTER) {
                list.visible = false;
                control.requestFocus();
            } else if(e.code == KeyCode.VK_ESCAPE) {
                show(0, 0, false);
            } else if(not ((e.code == KeyCode.VK_UP) or (e.code == KeyCode.VK_DOWN))) {
                control.onKeyPressed(e);
            }
        }
        
        listView.onKeyReleased = function(e) {
            if(not ((e.code == KeyCode.VK_UP) or (e.code == KeyCode.VK_DOWN))) {
                control.onKeyReleased(e);
            }
        }

        listView.onKeyTyped = function(e) {
            control.onKeyTyped(e);
        }
    }

    function show(x : Number, y : Number, visible : Boolean) {

        if(not visible) {
            showPopup = false;
            control.requestFocus();
            return;
        }

        // Ensure that we are not adding twice
        delete list from node.scene.content;
        insert list into node.scene.content;

        list.layoutX = x + 4;
        showPopup = true;
    }

    override protected function getMinHeight() : Number {
        return 24;
    }

    override protected function getMinWidth() : Number {
        return 50;
    }

    override protected function getPrefHeight(width: Number) : Number {
        return 24;
    }

    override protected function getPrefWidth(height: Number) : Number {
        return 100;
    }

}

class ComboBoxBehavior extends Behavior {

    public override function callActionForEvent(e: KeyEvent) : Void {
        if(e.code == KeyCode.VK_DOWN) {
            var x = node.localToScene(node.layoutBounds).minX + 2;
            var y = node.localToScene(node.layoutBounds).maxY + 3;
            show(x, y, true);
        } else if(e.code == KeyCode.VK_ESCAPE) {
            show(0, 0, false);
        }
    }
}
