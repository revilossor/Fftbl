package core.entity;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Oliver Ross
 */
class Entity extends FlxSprite
{
	public function new(?xp:Float = 0, ?yp:Float = 0, ?graphic:Dynamic) 
	{
		trace('create');
		super(xp, yp, graphic);
		Reg.input.onPressed.add(onPressed);
		Reg.input.onReleased.add(onReleased);
	}
	
	function onPressed(at:FlxPoint) {
		if (overlapsPoint(at)) { onPressedOn(at); }
	}
	function onPressedOn(at:FlxPoint) {}
	function onReleased(at:FlxPoint) {
		if (overlapsPoint(at)) { onReleasedOn(at); }
	}
	function onReleasedOn(at:FlxPoint) {}
	override public function update() {
		if (!Reg.isPaused) {
			super.update();
		}
	}
	// TODO destruction tells xml loaded level model entity with this id has been destroyed
}