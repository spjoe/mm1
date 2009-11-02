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
import org.tuwien.mm1.controls.ComboBox;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.control.Label;
import javafx.scene.text.Font;

import javafx.scene.control.Slider;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;

/**
 * @author camillo
 */
var currentMediaFile:String = "/path/to/example.mov";
var mediaFileLabel:Label = Label {
        text: bind currentMediaFile
}

var beginnLabel:Label = Label{
    text: "Beginn:"
}
var beginnSlider:Slider = Slider{

}
var beginnSliderLabel:Label = Label {
    text: bind beginnSlider.value.toString();
}

var dauerLabel:Label = Label{
    text: "Dauer:"
}
var dauerSlider:Slider = Slider{
}
var dauerSliderLabel:Label = Label {
    text: bind dauerSlider.value.toString();
}

var intensitätLabel:Label = Label{
    text: "Intensität:"
}
var intensitätSlider:Slider = Slider{

}
var intensitätSliderLabel:Label = Label {
    text: bind intensitätSlider.value.toString();
}

var höheLabel:Label = Label{
    text: "Höhe:"
}
var höheSlider:Slider = Slider{

}
var höheSliderLabel:Label = Label {
    text: bind höheSlider.value.toString();
}

var breiteLabel:Label = Label{
    text: "Breite:"
}
var breiteSlider:Slider = Slider{

}
var breiteSliderLabel:Label = Label {
    text: bind breiteSlider.value.toString();
}

var offsetXLabel:Label = Label{
    text: "Offset X:"
}
var offsetXSlider:Slider = Slider{

}
var offsetXSliderLabel:Label = Label {
    text: bind offsetXSlider.value.toString();
}

var offsetYLabel:Label = Label{
    text: "Offset Y:"
}
var offsetYSlider:Slider = Slider{

}
var offsetYSliderLabel:Label = Label {
    text: bind offsetYSlider.value.toString();
}

var timeSlider:Slider = Slider{
    layoutInfo: LayoutInfo{width: 350}
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
var openButton:Button = Button{
    layoutInfo: LayoutInfo { hpos: HPos.RIGHT }
    text:"Datei Öffnen"
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Open has been clicked");
    }
}
var mediaView:MediaView = MediaView{
    layoutInfo: LayoutInfo { width: 640 }
    preserveRatio: true
    mediaPlayer: MyMediaPlayer {
        media: Media{ source: ""}
    }
}
var noiseComboBox:ComboBox = ComboBox{
    items: [
    "Uniform",
    "Gauß",
    "Poisson",
    "Laplace",
    "Lorentz"
    ]
}
noiseComboBox.select(0);

var leftSide:VBox = VBox{
    width: 640
    spacing: 10
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
        spacing: 5
        hpos: HPos.LEFT // column will be centered within vbox width
        content: [playButton, pauseButton, stopButton, timeSlider, timeLabel]
    }
    HBox{
        spacing: 15
        layoutInfo: LayoutInfo { width: 640}
        content: [mediaFileLabel, openButton]
    }
    ]
}

var rightSide:VBox = VBox{
    width: 350
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
        spacing: 10
        content:[
        VBox{
            spacing: 10
            content:[beginnLabel, dauerLabel, intensitätLabel, höheLabel,
                breiteLabel, offsetXLabel, offsetYLabel]
        }
        VBox{
            spacing: 10
            content:[beginnSlider, dauerSlider, intensitätSlider, höheSlider,
                breiteSlider, offsetXSlider, offsetYSlider]
        }
        VBox{
            spacing: 10  
            content:[beginnSliderLabel, dauerSliderLabel, intensitätSliderLabel,
                höheSliderLabel, breiteSliderLabel, offsetXSliderLabel,
                offsetYSliderLabel]
        }
        ]
    }
    VBox{
        hpos: HPos.CENTER
        content:[
        Label{
            text: "Art der Verteilung"
        }
        noiseComboBox
        

        ]
    }



    ]

}


var stage:Stage = Stage{
    title: "Our peewee MediaPlayer"
    width: 640+350
    height: 620
    scene: Scene {
        content: 
        HBox{
            spacing: 15
            content:[leftSide,rightSide]
        }
    }
}

