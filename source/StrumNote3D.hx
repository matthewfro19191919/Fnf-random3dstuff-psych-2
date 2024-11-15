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

using StringTools;

class StrumNote3D
{
	//public var resetAnim:Float = 0;
	public var noteData:Int = 0;
	public var player:Int;
	public var ID:Int;

	public var sPlane:Mesh;
	public var isGray:Bool = true;

	public var x(default, set):Float = 0;
    public var y(default, set):Float = 0;
    public var z(default, set):Float = 0;

    public var pitch(default, set):Float = 0;
    public var yaw  (default, set):Float = 0;
    public var roll (default, set):Float = 0;

	public var defX:Float = 0;
	public var defY:Float = 0;
	public var defZ:Float = 0;

	/////////////////////////////////////////////

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
		sPlane.rotationX = value - 90;
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
		sPlane.rotationZ = value;
		roll = value;
		return value;
	}
	
	public var sGeom:PlaneGeometry;
	public function new(leData:Int, player:Int, Ltexture:TextureMaterial) {
		noteData = leData;
		this.player = player;
		this.noteData = leData;
		//if(PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;

		sGeom = new PlaneGeometry(108, 108, 1, 1, true, true);
		sGeom.doubleSided = true;

		sPlane = new Mesh(sGeom, Ltexture);
        //sPlane.y = L_y;
        sPlane.x = -580;
        //sPlane.y = 304;
        sPlane.rotationX = -90;
		Main.daScene.view.scene.addChild(sPlane);
	}

	public function postAddedToGroup() {
		ID = noteData;
	}

	public function kill(){
        Main.daScene.view.scene.removeChild(sPlane);
        sPlane.dispose();
    }
}
