package;

import openfl.display.BitmapData;
import openfl.geom.Vector3D;
import openfl.geom.ColorTransform;
import openfl.geom.Rectangle;
import away3d.containers.View3D;
import away3d.materials.TextureMaterial;
import away3d.entities.Mesh;
import away3d.utils.Cast;
import away3d.primitives.PlaneGeometry;
import away3d.controllers.HoverController;
import away3d.textures.BitmapTexture;

class Note3D {
    public var mustPress:Bool = false;
    public var noteData:Int = 0;
    public var strumTime:Float = 0;
    
    public var canBeHit:Bool = false;
    public var tooLate:Bool = false;
    public var wasGoodHit:Bool = false;

    public var x(default, set):Float = 0;
    public var y(default, set):Float = 0;
    public var z(default, set):Float = 0;

    public var pitch(default, set):Float = 0;
    public var yaw  (default, set):Float = 0;
    public var roll (default, set):Float = 0;

    public var offsetX:Float = 0;
    public var offsetY:Float = 0;
    public var offsetAngle:Float = 0;
    public var multAlpha:Float = 1;

    public var isSustainNote:Bool = false;
    public var isHoldEnd:Bool = false;
    public var ignoreNote:Bool = false;
    public var noteType:Int = 0;

    public var parentNote:Note3D;

    private function set_x(value:Float):Float
    {
        sPlane.x = value - 580;
        x = value;
        return value;
    }
    private function set_y(value:Float):Float
    {
        sPlane.y = (-value) + 304;
        y = value;
        return value;
    }
    private function set_z(value:Float):Float
    {
        sPlane.z = value;
        z = value;
        return value;
    }

    /////////////// ROTATION ///////////////

    private function set_pitch(value:Float):Float
    {
        sPlane.rotationX = (isSustainNote ? -value : value) - 90;
        pitch = value;
        return value;
    }
    private function set_yaw(value:Float):Float
    {
        sPlane.rotationY = value;
        yaw = value;
        return value;
    }
    private function set_roll(value:Float):Float
    {
        sPlane.rotationZ = value + (ClientPrefs.downScroll && isHoldEnd ? 180 : 0);
        roll = value;
        return value;
    }

    public var prevNote:Note3D = null;
    public var sPlane:Mesh;

    public function new(LstrumTime:Float = 0, LnoteData:Int = 0, Ltexture:TextureMaterial, isSus:Bool){
        var hieght:Float = 108;
        if(isSus) hieght = Conductor.stepCrochet / 100 * 45.5 * PlayState.SONG.speed;

        var pee = new PlaneGeometry(108, hieght, 1, 1, true, true);
        pee.doubleSided = true;
        
        sPlane = new Mesh(pee, Ltexture);
        sPlane.y = 2000;
        sPlane.x = -580;
        //sPlane.y = 304;
        sPlane.rotationX = -90;
		Main.daScene.view.scene.addChild(sPlane);

        strumTime = LstrumTime;
        noteData = LnoteData % 4;
    }

    public function kill(){
        if(Main.daScene.view.scene.contains(sPlane))
            Main.daScene.view.scene.removeChild(sPlane);
        
        sPlane.dispose();
    }
}