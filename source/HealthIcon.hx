package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
		switch (char) {
			case 'steve':
				loadGraphic(Paths.image('icons/steve'), true, 150, 150);
				animation.add('ronsip', [0, 1], 0, false, isPlayer);
			case 'doll':
				loadGraphic(Paths.image('icons/doll'), true, 150, 150);
				animation.add('ronsip-ex', [0, 1], 0, false, isPlayer);
			case 'crash':
				loadGraphic(Paths.image('icons/crash'), true, 150, 150);
				animation.add('ronsip-ex', [0, 1], 0, false, isPlayer);
			case 'endo':
				loadGraphic(Paths.image('icons/endo'), true, 150, 150);
				animation.add('gloopy', [0, 1], 0, false, isPlayer);
			case 'skeleton':
				loadGraphic(Paths.image('icons/skeleton'), true, 150, 150);
				animation.add('gloopy-ex', [0, 1], 0, false, isPlayer);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			loadGraphic(file, true, 150, 150);
			animation.add(char, [0, 1], 0, false, isPlayer);
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	public function getCharacter():String {
		return char;
	}
}
