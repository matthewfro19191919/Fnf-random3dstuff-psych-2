package;

import openfl.geom.Vector3D;
import openfl.display.BitmapData;
import away3d.containers.View3D;
import away3d.materials.TextureMaterial;
import away3d.entities.Mesh;
import away3d.utils.Cast;
import away3d.primitives.PlaneGeometry;
import away3d.controllers.HoverController;

import flixel.addons.ui.FlxUIState;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.FlxG;

class Scene3D {
    public static var qualityDiv:Float = 1;

    public var view:View3D;
    public var screen:FlxSprite = new FlxSprite();
    public var dadata:BitmapData;

    private var width :Float = 1280;
    private var height:Float = 720;
    //public var texMat:TextureMaterial;

    private var modelIndex:Int;
    public  var models:Array<Dynamic> = [];
    public  var inGaem:Bool = false;

    // if you're wondering where this is called from, it's from titlestate. NOT MAIN
    public function new(){
        width  /= qualityDiv;
        height /= qualityDiv;

        view = new View3D();
		view.camera.z = -620;
		view.camera.y = 0;
		view.camera.lookAt(new Vector3D());
        view.width = width;
		view.height = height;
        view.camera.lens.far = 5000;
        view.backgroundAlpha = 0;

		FlxG.addChildBelowMouse(view);

        dadata = new BitmapData(Std.int(view.width), Std.int(view.height), true, 0);
        screen.loadGraphic(dadata);
        screen.origin.set(0,0);
        screen.scale.set(qualityDiv, qualityDiv);

        inGaem = true;
    }

    /*public function addSomething(buh:Dynamic){
        if(Std.isOfType(note, Note3D)){
            models.push(note);
            note.modelIndex = this.modelIndex;
            modelIndex++;
            trace(note.strumTime);
            view.scene.addChild(note.daMesh);
        }
    }*/

    public function kill(){
        for(i in 0...view.scene.numChildren){
            if(view.scene.getChildAt(i) != null){
                view.scene.removeChildAt(i);
            }
        }
    }

    // not use if this needs to be used.
    public function resetBitmapData(){
        /*dadata.dispose();
        dadata = null;
        dadata = new BitmapData(Std.int(view.width), Std.int(view.height), true, 0);

        screen.destroy();
        screen = null;
        screen = new FlxSprite().loadGraphic(dadata);*/
    }

    public function render(){
        view.renderer.queueSnapshot(dadata);
        view.render();

        //screen.framePixels = dadata;
    }
}