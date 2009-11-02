/*
 * Main.fx
 *
 * Created on 24.10.2009, 14:16:17
 */

package org.tuwien.mm1.app;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.media.Media;
import javafx.scene.media.MediaView;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.scene.layout.LayoutInfo;
import java.lang.*;
import javafx.scene.input.MouseEvent;
import javafx.geometry.HPos;


import org.tuwien.mm1.controls.MyMediaPlayer;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.control.ToggleGroup;
import javafx.scene.control.Label;
import javafx.scene.text.Font;

import javafx.scene.control.Slider;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;

/**
 * @author camillo
 */
 def group = ToggleGroup{};

var currentMediaFile:String = "";
var MediaFileLable:Label = Label {
        text: bind currentMediaFile


var beginnSlider:Slider = Slider{

}
var beginnSliderLabel:Label = Label {
    text: bind beginnSlider.value.toString();
}

var dauerSlider:Slider = Slider{
}
var dauerSliderLabel:Label = Label {
    text: bind dauerSlider.value.toString();
}

var intensitätSlider:Slider = Slider{

}
var höheSlider:Slider = Slider{

}
var breiteSlider:Slider = Slider{

}
var offsetXSlider:Slider = Slider{

}
var offsetYSlider:Slider = Slider{

}
var timeSlider:Slider = Slider{

}
var timeLabel:Label =Label {
    text: bind timeSlider.value.toString();
}


var playButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/play3.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Play has been clicked");
    }
}
var pauseButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/pause.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Pause has been clicked");
    }
}
var stopButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/stop.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Stop has been clicked");
    }
}
var mediaView:MediaView = MediaView{
    layoutInfo: LayoutInfo { width: 640 }
    preserveRatio: true
    mediaPlayer: MyMediaPlayer {
        media: Media{ source: ""}
    }
}

var leftSide:VBox = VBox{
    width: 640
    spacing: 0
    content:[
    HBox{
        layoutInfo: LayoutInfo { height: 480 }
        content:[
        Rectangle {
            x: 0, y: 0
            width: 640, height: 480
            fill: Color.BLACK
        }
        mediaView
        ]
    }
    HBox{
        layoutInfo: LayoutInfo { width: 640}
        spacing: 15
        hpos: HPos.LEFT // column will be centered within vbox width
        content: [playButton, pauseButton, stopButton, timeSlider, timeLabel]
    }
    ]
}

var rightSide:VBox = VBox{
    width: 200
    spacing: 15
    content:[
    Label{
        font: Font {
            name: "Serif"
            size: 20
          }
        text: "Effekt Config"
    }
    HBox{
        content:[beginnSlider,beginnSliderLabel]
    }
    HBox{
        content:[dauerSlider,beginnSliderLabel]
    }


    ]

}


var stage:Stage = Stage{
    title: "Our peewee MediaPlayer"
    width: 840
    height: 540
    scene: Scene {
        content: 
        HBox{
            spacing: 15
            content:[leftSide,rightSide]
        }
    }
}

