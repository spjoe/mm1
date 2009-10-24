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
import org.tuwien.mm1.controls.VolumeControl;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;


/**
 * @author camillo
 */

var stage:Stage = Stage{
    title: "Our peewee MediaPlayer"
    width: 640
    height: 540
    scene: Scene {
        content: [
        VBox{
            spacing: 0
            content:[
            HBox{
                layoutInfo: LayoutInfo { height: 480 }
                content:
                MediaView {
                    layoutInfo: LayoutInfo { width: 640 }
                    preserveRatio: true
                    mediaPlayer: MyMediaPlayer {
                        media: Media{ source: ""}
                    }
                }
            }
            HBox{
                layoutInfo: LayoutInfo { width: 640}
                spacing: 15
                hpos: HPos.CENTER // column will be centered within vbox width
                content: [
                Button{
                    graphic: ImageView {
                        image: Image {url: "file:///home/camillo/NetBeansProjects/mm1/src/org/tuwien/mm1/data/play3.png"}
                    }
                    //text:"Play"
                    onMouseClicked: function( e: MouseEvent ):Void {
                        System.out.println("Play has been clicked");
                }
                }
                Button{
                    graphic: ImageView {
                        image: Image {url: "file:///home/camillo/NetBeansProjects/mm1/src/org/tuwien/mm1/data/pause.png"}
                    }
                    //text:"Pause"
                    onMouseClicked: function( e: MouseEvent ):Void {
                        System.out.println("Pause has been clicked");
                    }
                }
                Button{
                    graphic: ImageView {
                        image: Image {url: "file:///home/camillo/NetBeansProjects/mm1/src/org/tuwien/mm1/data/stop.png"}
                    }
                    //text:"Stop"
                    onMouseClicked: function( e: MouseEvent ):Void {
                        System.out.println("Stop has been clicked");
                    }
                }
                VolumeControl{
                    onMouseClicked: function( e: MouseEvent ):Void {
                        System.out.println("VolumeControl has been clicked");
                    }
                }
                Button{
                    text:"Close"
                    onMouseClicked: function( e: MouseEvent ):Void {
                        stage.close();
                    }
                }
                ]
            }
            ]
        }
        ]
    }
}