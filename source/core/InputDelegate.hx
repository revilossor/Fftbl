package core;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.input.FlxSwipe;
import flixel.util.FlxPoint;
import flixel.util.FlxSignal.FlxTypedSignal;

/**
 * ...
 * @author Oliver Ross
 * 
 * 	TODO hold position data - goto drag state, start recording position nodes for bezier run, aim direction for kick
 * 
 */
class InputDelegate extends FlxBasic
{	
	public var onPressed:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onReleased:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeUp:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeDown:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeLeft:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeRight:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	
	@isVar 
	public var enabled(never, set):Bool; var _enabled:Bool = false;
	public function set_enabled(value:Bool):Bool { trace('set enabled ${value}'); return _enabled = value; }
	
	override public function update() {
		super.update();
		if(_enabled) {
			if (FlxG.mouse.justPressed) { _onPressed(); }		// TODO touch
			if (FlxG.mouse.justReleased) { _onReleased(); }
			if (FlxG.mouse.pressed) { _onHeld(); }
			// TODO FlxG.swipes
			sortSwipes();
		}
	}
	
	function _onPressed() {
		trace('pressed');
		onPressed.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak()));
	}
	function _onHeld() {

	}
	function _onReleased() {
		trace('mouse released');
		onReleased.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak()));
	}
	
	function sortSwipes():Void {
		for (swipe in FlxG.swipes) {
			trace('swipe at ${swipe.startPosition.x}, ${swipe.startPosition.y}, duration ${swipe.duration}, angle ${swipe.angle}');
		}
	}
	
	override public function destroy() {
		trace('destroy');
		onPressed.removeAll();
		onReleased.removeAll();
		onPressed = onReleased = null;
		super.destroy();
	}
}