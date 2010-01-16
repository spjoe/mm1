/*
 * Main.fx
 * @author: camillo
 * Created on 24.10.2009, 14:16:17
 */

package org.tuwien.mm1.app;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.ToggleGroup;
import javafx.scene.control.ToggleButton;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.scene.layout.LayoutInfo;
import java.lang.*;
import java.util.Properties;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.net.URL;
import javafx.scene.input.MouseEvent;
import javafx.geometry.HPos;
import org.tuwien.mm1.jmf.filters.noise.*;


import org.tuwien.mm1.controls.MyMediaPlayer;
import org.tuwien.mm1.controls.MyToggleGroup;
import org.tuwien.mm1.controls.ComboBox;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.control.Label;
import javafx.scene.text.Font;

import javafx.scene.control.Slider;

import javax.swing.JFileChooser;
import javafx.scene.control.RadioButton;

var sec:Number =123;// bind mediaView.mediaPlayer.media.duration.toSeconds();
//var sec:Integer = 10000;
var videoHöhe:Integer = 640;
var videoBreite:Integer = 480;

var currentMediaFile:String = "file://home/camillo/Videos/test_video.mov";//"http://sun.edgeboss.net/download/sun/media/1460825906/1460825906_11810873001_09c01923-00.flv";
/**
    Label, welches den Pfad der gerade vorgeführten Datei anzeigt
*/
var mediaFileLabel:Label = Label {
        text: bind currentMediaFile
}

/**
    Bezeichnung für den beginn Schieber
*/
var beginnLabel:Label = Label{
    text: "Beginn:"
}
/**
    Der Schieber für die Beginnzeit des Filters
*/
var beginnSlider:Slider = Slider{

}
/**
    Der Wert des Schieber für die Beginnzeit des Filters
*/
var beginnSliderLabel:Label = Label {
    var currentsec:Integer  = bind sec * beginnSlider.value/100;
    var hour:Integer = bind  currentsec/3600;
    var min:Integer  = bind (currentsec-hour*3600)/60;
    var sec2:Integer = bind (currentsec-hour*3600-min*60);
    var shour:String = bind "{hour}:{min}:{sec2}";
    text: bind shour
}

/**
    Bezeichnung für den dauer Schieber
*/
var dauerLabel:Label = Label{
    text: "Dauer:"
}
/**
    Der Schieber für die Dauer des Filters
*/
var dauerSlider:Slider = Slider{
}
/**
    Der Wert des Schieber für die Dauer des Filters
*/
var dauerSliderLabel:Label = Label {
    var currentsec:Integer  = bind sec * dauerSlider.value/100;
    var hour:Integer = bind  currentsec/3600;
    var min:Integer  = bind (currentsec-hour*3600)/60;
    var sec2:Integer = bind (currentsec-hour*3600-min*60);
    var shour:String = bind "{hour}:{min}:{sec2}";
    text: bind shour
}
/**
    Bezeichnung für den intensität Schieber
*/
var intensitätLabel:Label = Label{
    text: "Intensität:"
}
/**
    Der Schieber für die Intensität des Filters
*/
var intensitätSlider:Slider = Slider{

}
/**
    Der Wert des Schieber für die Intensität des Filters
*/
var intensitätSliderLabel:Label = Label {
    var out:Integer = bind intensitätSlider.value;
    text: bind "{out}%";
}

/**
    Bezeichnung für den höhe Schieber
*/
var höheLabel:Label = Label{
    text: "Höhe:"
}
/**
    Der Schieber für die Höhe des Filters
*/
var höheSlider:Slider = Slider{
    min: 0
    max: bind videoHöhe
    snapToTicks: false

}
/**
    Der Wert des Schieber für die Höhe des Filters
*/
var höheSliderLabel:Label = Label {
    var out:Integer = bind höheSlider.value;
    text: bind "{out} px";
}

/**
    Bezeichnung für den breite Schieber
*/
var breiteLabel:Label = Label{
    text: "Breite:"
}
/**
    Der Schieber für die Breite des Filters
*/
var breiteSlider:Slider = Slider{
    min: 0
    max: videoBreite
}
/**
    Der Wert des Schieber für die Breite des Filters
*/
var breiteSliderLabel:Label = Label {
    var out:Integer = bind breiteSlider.value;
    text: bind "{out} px";
}

/**
    Bezeichnung für den Seitenabstand Schieber
*/
var offsetXLabel:Label = Label{
    text: "Offset X:"
}
/**
    Der Schieber für den Seitenabstand des Filters
*/
var offsetXSlider:Slider = Slider{
    min: 0
    max: videoBreite

}
/**
    Der Wert des Schieber für die Seitenabstand des Filters
*/
var offsetXSliderLabel:Label = Label {
    var out:Integer = bind offsetXSlider.value;
    text: bind "{out} px";
}

/**
    Bezeichnung für den Bodenabstand Schieber
*/
var offsetYLabel:Label = Label{
    text: "Offset Y:"
}
/**
    Der Schieber für die Bodenabstand des Filters
*/
var offsetYSlider:Slider = Slider{
    min: 0
    max: videoHöhe
}
/**
    Der Wert des Schieber für die Bodenabstands des Filters
*/
var offsetYSliderLabel:Label = Label {
    var out:Integer = bind offsetYSlider.value;
    text: bind "{out} px";
}

/**
    Schieber für die vergangene Zeit
*/
var timeSlider:Slider = Slider{
    layoutInfo: LayoutInfo{width: 350}
    //value: bind (mediaView.mediaPlayer.currentTime.toSeconds() / mediaView.mediaPlayer.media.duration.toSeconds()) * 100
}
/**
    Der Wert des Schieber für die vergangene Zeit
*/
var timeLabel:Label =Label {
    var currentsec:Integer  = bind sec * timeSlider.value/100;
    var hour:Integer = bind  currentsec/3600;
    var min:Integer  = bind (currentsec-hour*3600)/60;
    var sec2:Integer = bind (currentsec-hour*3600-min*60);
    var shour:String = bind "{hour}:{min}:{sec2}";
    text:bind shour
}

/**
    Knopf zum starten des Filmes
*/
var playButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/play3.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Play has been clicked");
        //mediaView.mediaPlayer.play();
    }
}
/**
    Knopf zum pausieren des Filmes
*/
var pauseButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/pause.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Pause has been clicked");
        //mediaView.mediaPlayer.pause();
    }
}
/**
    Knopf zum stoppen des Filmes
*/
var stopButton:Button = Button{
    graphic: ImageView {
        image: Image {url: "{__DIR__}data/stop.png"}

    }
    onMouseClicked: function( e: MouseEvent ):Void {
        System.out.println("Stop has been clicked");
        //mediaView.mediaPlayer.stop();
    }
}
/**
    Öffnen Dialog
*/
var chooser: JFileChooser = new JFileChooser();
/**
    Knopf zum öffnen eines Filmes
*/
var openButton:Button = Button{
    layoutInfo: LayoutInfo { hpos: HPos.RIGHT }
    hpos: HPos.RIGHT
    text:"Öffnen"
    
    action: function() {
        if (JFileChooser.APPROVE_OPTION == chooser.showOpenDialog(null)) {
            var file = chooser.getSelectedFile();
            currentMediaFile = file.toURI().toString();
        }
    }
}
/**
    Knopf zum speichern des Filmes
*/
var saveButton:Button = Button{
    layoutInfo: LayoutInfo { hpos: HPos.RIGHT }
    hpos: HPos.RIGHT
    text:"Speichern"

    action: function() {
        if (JFileChooser.APPROVE_OPTION == chooser.showOpenDialog(null)) {
            var file = chooser.getSelectedFile();
            var url = new URL(currentMediaFile);

            
            var in = url.openStream();
            var out = new FileWriter(file);
            
            var c:Integer;

            while ((c = in.read()) != -1)
              out.write(c);

            in.close();
            out.close();

        }
    }
}
/**
    Bereich wo der Film angezeigt wird
*/

var mediaView:MyMediaPlayer =  MyMediaPlayer{
    url: new java.net.URL(currentMediaFile)
    autoPlay: true;
}
/**
    Auswahl der noise Funktion
*/
var noiseComboBox:ComboBox = ComboBox{
    items: [
    "Uniform",
    "Gauß",
    "Poisson",
    "Laplace",
    "Lorentz"
    ]
}
def group = ToggleGroup{};
def choiceText = ["Uniform", "Gauß", "Poisson","Laplace","Lorentz"];

def choices = for (text in choiceText)
RadioButton{
        toggleGroup: group
        text: text
        
}


/**
    Linke Seite der GUI:
        mediaView,
        play,pause,stop,open,time
        curretnfile, open,save buttons
*/
var leftSide:VBox = VBox{
    width: 640
    spacing: 10
    content:[
    HBox{
        layoutInfo: LayoutInfo { height: 480 }
        content:[mediaView]
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
        content: [mediaFileLabel, openButton,saveButton]
    }
    ]
}
/**
    Rechte Seite der GUI:
        Konfguration des Filters
*/
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
        noiseComboBox,
        choices
        ]
    }
    ]
}

/**
    Behältnis der gesamten Szene
*/
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
    /**
        Wird beim schließen aufgerufen, setzen der Properties!
    */
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
/**
 * Einstiegspunkt der Applikation. Einlesen der Argumente und des properties files
 */
function run(args : String[]) {
    // Convert Strings to Integers


    noiseComboBox.select(0);
    choices[0].fire();

    var lol = bind noiseComboBox.selectedItem on replace old {
        if(mediaView.Filter == null){
            return
        }
        if(lol.toString().equals("Gauß")){
            mediaView.Filter.setNoiseRender(new GaussNoise(15));
        }else if(lol.toString().equals("Lorentz")){
            mediaView.Filter.setNoiseRender(new LorentzNoise(15));
        }else if(lol.toString().equals("Laplace")){
            mediaView.Filter.setNoiseRender(new LaplaceNoise(15));
        }else if(lol.toString().equals("Uniform")){
            mediaView.Filter.setNoiseRender(new UniformNoise(320));
        }else if(lol.toString().equals("Poisson")){
            mediaView.Filter.setNoiseRender(new PoissonNoise(1));
        }
    }
     var lol2 = bind group.selectedButton on replace old {
        if(mediaView.Filter != null){
            var radio: ToggleButton = lol2;
            System.out.println(radio.text);
            if(radio.text.equals("Gauß")){
                mediaView.Filter.setNoiseRender(new GaussNoise(20));
            }else if(radio.text.equals("Lorentz")){
                mediaView.Filter.setNoiseRender(new LorentzNoise(15));
            }else if(radio.text.equals("Laplace")){
                mediaView.Filter.setNoiseRender(new LaplaceNoise(15));
            }else if(radio.text.equals("Uniform")){
                mediaView.Filter.setNoiseRender(new UniformNoise(320));
            }else if(radio.text.equals("Poisson")){
                mediaView.Filter.setNoiseRender(new PoissonNoise(1));
            }
        }
    }
    

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