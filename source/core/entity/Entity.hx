package core.entity;
import core.InputDelegate.Swipe;
import flixel.FlxSprite;

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
		Reg.input.onTap.add(onTap);
		Reg.input.onHeld.add(onHeld);
		Reg.input.onHeldTick.add(onHeldTick);
		Reg.input.onSwipe.add(onSwipe);
	}
	
	function onPressed(at) {
		if (overlapsPoint(at)) { onPressedOn(at); }
	}
	function onPressedOn(at) { }	
	function onReleased(at) {
		if (overlapsPoint(at)) { onReleasedOn(at); }
	}
	function onReleasedOn(at) { }
	function onTap(at) {
		if (overlapsPoint(at)) { onTapOn(at); }
	}
	function onTapOn(at) { }
	function onHeld(at) {
		if (overlapsPoint(at)) { onHeldOn(at); }
	}
	function onHeldOn(at) { }
	function onHeldTick(at, index) {
		if (overlapsPoint(at)) { onHeldTickOn(at, index); }
	}
	function onHeldTickOn(at, index) { }
	function onSwipe(swipe:Swipe) {
		if (overlapsPoint(swipe.at)) { onSwipeOn(swipe); }
	}
	function onSwipeOn(swipe:Swipe) { }
	override public function update() {
		if (!Reg.isPaused) { super.update(); }
	}
	// TODO destruction tells xml loaded level model entity with this id has been destroyed
}