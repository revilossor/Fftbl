package core.world.parallax;
import core.entity.Entity;
import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Oliver Ross
 */
class ParallaxLayer extends FlxGroup
{
	var _front:Entity;
	var _back:Entity; 
	var _lastPosition:Float;
	
	public function new(imagePath:String, scrollFactor:Float) 
	{
		super();
		addSprites(imagePath, scrollFactor);
		_lastPosition = FlxG.camera.scroll.x;
	}
	
	function addSprites(imagePath:String, scrollFactor:Float) {
		_front = new Entity(0, 0, imagePath);
		_back = new Entity(_front.width, 0, imagePath);
		_front.scrollFactor.set(scrollFactor, 1);
		_back.scrollFactor.set(scrollFactor, 1);
		add(_front);
		add(_back);
	}
	override public function update():Void {
		positionForCamera();
		super.update();
	}
	function positionForCamera() {
		if (FlxG.camera.scroll.x > _lastPosition) {
			var scaledCameraLeft:Float = FlxG.camera.scroll.x * _front.scrollFactor.x;
			if (scaledCameraLeft > _front.x + _front.width) {
				_front.x = _back.x + _back.width;
			}
			if (scaledCameraLeft > _back.x + _back.width) {
				_back.x = _front.x + _front.width;
			}
		}else if (FlxG.camera.scroll.x < _lastPosition) {
			var scaledCameraRight:Float = (FlxG.camera.scroll.x * _front.scrollFactor.x) + FlxG.width;
			if (scaledCameraRight < _front.x) {
				_front.x = _back.x - _front.width;
			}
			if (scaledCameraRight < _back.x) {
				_back.x = _front.x - _back.width;
			}
		}
		_lastPosition = FlxG.camera.scroll.x;
	}
}