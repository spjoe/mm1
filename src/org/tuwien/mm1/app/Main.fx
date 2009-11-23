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
import java.util.Properties;
import java.io.FileOutputStream;
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

import javax.swing.JFileChooser;

/**
 * @author camillo
 */
 //var sec:Number = bind mediaView.mediaPlayer.media.duration.toSeconds();
var sec:Integer = 10000;
var videoHöhe:Integer = 640;
var videoBreite:Integer = 480;
var currentMediaFile:String = "http://sun.edgeboss.net/download/sun/media/1460825906/1460825906_11810873001_09c01923-00.flv";
var mediaFileLabel:Label = Label {
        text: bind currentMediaFile
}

var beginnLabel:Label = Label{
    text: "Beginn:"
}
var beginnSlider:Slider = Slider{

}
var beginnSliderLabel:Label = Label {
    var currentsec:Integer  = bind sec * beginnSlider.value/100;
    var hour:Integer = bind  currentsec/3600;
    var min:Integer  = bind (currentsec-hour*3600)/60;
    var sec2:Integer = bind (currentsec-hour*3600-min*60);
    var shour:String = bind "{hour}:{min}:{sec2}";
    text: bind shour
}

var dauerLabel:Label = Label{
    text: "Dauer:"
}
var dauerSlider:Slider = Slider{
}
var dauerSliderLabel:Label = Label {
    var currentsec:Integer  = bind sec * dauerSlider.value/100;
    var hour:Integer = bind  currentsec/3600;
    var min:Integer  = bind (currentsec-hour*3600)/60;
    var sec2:Integer = bind (currentsec-hour*3600-min*60);
    var shour:String = bind "{hour}:{min}:{sec2}";
    text: bind shour
}

var intensitätLabel:Label = Label{
    text: "Intensität:"
}
var intensitätSlider:Slider = Slider{

}
var intensitätSliderLabel:Label = Label {
    var out:Integer = bind intensitätSlider.value;
    text: bind "{out}%";
}

var höheLabel:Label = Label{
    text: "Höhe:"
}
var höheSlider:Slider = Slider{
    min: 0
    max: bind videoHöhe
    snapToTicks: false

}
var höheSliderLabel:Label = Label {
    var out:Integer = bind höheSlider.value;
    text: bind "{out} px";
}

var breiteLabel:Label = Label{
    text: "Breite:"
}
var breiteSlider:Slider = Slider{
    min: 0
    max: videoBreite
}
var breiteSliderLabel:Label = Label {
    var out:Integer = bind breiteSlider.value;
    text: bind "{out} px";
}

var offsetXLabel:Label = Label{
    text: "Offset X:"
}
var offsetXSlider:Slider = Slider{
    min: 0
    max: videoBreite

}
var offsetXSliderLabel:Label = Label {
    var out:Integer = bind offsetXSlider.value;
    text: bind "{out} px";
}

var offsetYLabel:Label = Label{
    text: "Offset Y:"
}
var offsetYSlider:Slider = Slider{
    min: 0
    max: videoHöhe
}
var offsetYSliderLabel:Label = Label {
    var out:Integer = bind offsetYSlider.value;
    text: bind "{out} px";
}

var timeSlider:Slider = Slider{
    layoutInfo: LayoutInfo{width: 350}
}

var timeLabel:Label =Label {
    var currentsec:Integer  = bind sec * timeSlider.value/100;
    var hour:Integer = bind  currentsec/3600;
    var min:Integer  = bind (currentsec-hour*3600)/60;
    var sec2:Integer = bind (currentsec-hour*3600-min*60);
    var shour:String = bind "{hour}:{min}:{sec2}";
    text:bind shour
}


var playButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/play3.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Play has been clicked");
        mediaView.mediaPlayer.play();
    }
}
var pauseButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/pause.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Pause has been clicked");
        mediaView.mediaPlayer.pause();
    }
}
var stopButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/stop.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Stop has been clicked");
        mediaView.mediaPlayer.stop();
    }
}
var chooser: JFileChooser = new JFileChooser();
var openButton:Button = Button{
    layoutInfo: LayoutInfo { hpos: HPos.RIGHT }
    hpos: HPos.RIGHT
    text:"Datei Öffnen"
    
    action: function() {
        if (JFileChooser.APPROVE_OPTION == chooser.showOpenDialog(null)) {
            var file = chooser.getSelectedFile();
            currentMediaFile = file.toURI().toString();
        }
    }
}
var mediaView:MediaView = MediaView{
    layoutInfo: LayoutInfo { width: 640 }
    preserveRatio: true
    mediaPlayer: MyMediaPlayer {
        media: Media{ source: bind currentMediaFile}
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
    nodeHPos: HPos.CENTER
    hpos: HPos.CENTER
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
                breiteLabel, offsetYLabel, offsetXLabel]
        }
        VBox{
            spacing: 10
            content:[beginnSlider, dauerSlider, intensitätSlider, höheSlider,
                breiteSlider, offsetYSlider, offsetXSlider]
        }
        VBox{
            spacing: 10  
            content:[beginnSliderLabel, dauerSliderLabel, intensitätSliderLabel,
                höheSliderLabel, breiteSliderLabel, offsetYSliderLabel,
                offsetXSliderLabel]
        }
        ]
    }

    VBox{
        nodeHPos: HPos.CENTER
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
            layoutX: 3
            layoutY: 5
            spacing: 15
            content:[leftSide,rightSide]
        }
    }
     onClose: function(){
            var propFile = ClassLoader.getSystemResource("mplayer.properties");
            println("Properties file:  {propFile}\nContent:");
            var prop = new Properties();
            prop.load(propFile.openStream());
            prop.setProperty("currentMediaFile", currentMediaFile);
            prop.setProperty("beginnSlider", beginnSlider.value.toString());
            prop.setProperty("dauerSlider", dauerSlider.value.toString());
            prop.setProperty("intensitätSlider", intensitätSlider.value.toString());
            prop.setProperty("höheSlider", höheSlider.value.toString());
            prop.setProperty("breiteSlider", breiteSlider.value.toString());
            prop.setProperty("offsetXSlider", offsetXSlider.value.toString());
            prop.setProperty("offsetYSlider", offsetYSlider.value.toString());
            prop.setProperty("noise", noiseComboBox.selectedItem.toString());

            var outStream = new FileOutputStream(propFile.getFile());
            prop.store(outStream, "bla");
        }
}

function run(args : String[]) {
     // Convert Strings to Integers
    

     noiseComboBox.select(0);

    var propFile = ClassLoader.getSystemResource("mplayer.properties");
    println("Properties file:  {propFile}\nContent:");
    var prop = new Properties();
    prop.load(propFile.openStream());
    if(prop.containsKey("currentMediaFile"))
        currentMediaFile = prop.getProperty("currentMediaFile");
    if(prop.containsKey("beginnSlider"))
        beginnSlider.value = Double.parseDouble(prop.getProperty("beginnSlider"));
    if(prop.containsKey("dauerSlider"))
        dauerSlider.value = Double.parseDouble(prop.getProperty("dauerSlider"));
    if(prop.containsKey("intensitätSlider"))
        intensitätSlider.value = Double.parseDouble(prop.getProperty("intensitätSlider"));
    if(prop.containsKey("höheSlider"))
        höheSlider.value = Double.parseDouble(prop.getProperty("höheSlider"));
    if(prop.containsKey("breiteSlider"))
        breiteSlider.value = Double.parseDouble(prop.getProperty("breiteSlider"));
    if(prop.containsKey("offsetXSlider"))
        offsetXSlider.value = Double.parseDouble(prop.getProperty("offsetXSlider"));
    if(prop.containsKey("offsetYSlider"))
        offsetYSlider.value = Double.parseDouble(prop.getProperty("offsetYSlider"));
    if(prop.containsKey("noise")){
        var tmp = prop.getProperty("noise");
        if(tmp.equals("Gauß"))
            noiseComboBox.select(1);
        if(tmp.equals("Poisson"))
            noiseComboBox.select(2);
        if(tmp.equals("Laplace"))
            noiseComboBox.select(3);
        if(tmp.equals("Lorentz"))
            noiseComboBox.select(4);
    }

     def mediaurl = args[0];
     if(mediaurl != null)
        currentMediaFile = mediaurl;
}