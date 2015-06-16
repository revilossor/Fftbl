package core;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.input.FlxSwipe;
import flixel.util.FlxPoint;
import flixel.util.FlxSignal.FlxTypedSignal;
import nape.geom.Vec2;

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
	public var onHeld:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();			// returns array of points    
	public var onSwipeUp:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeDown:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeLeft:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipeRight:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	
	var _swipeNodes:Array<Vec2> = [];
	var _isPressed:Bool = false;
	var _holdThreshold:UInt = 10;
	var _holdTimer:UInt = 0;		// TODO bit hacky, make class?
	
	@isVar 
	public var enabled(never, set):Bool; var _enabled:Bool = false;
	public function set_enabled(value:Bool):Bool { trace('set enabled ${value}'); return _enabled = value; }
	
	override public function update() {
		super.update();
		if(_enabled) {
			if (FlxG.mouse.justPressed) { _onPressed(); }		// TODO touch
			if (FlxG.mouse.justReleased) { _onReleased(); }
			if (FlxG.mouse.pressed) { _onHeld(); }
			//sortSwipes();
			if (_isPressed) {
				_holdTimer++;
				if (_holdTimer >= _holdThreshold) {
					trace('this is a hold');
					onHeld.dispatch(FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y));		// TODO unify touch in pointer class
				}
			}
		}
	}
	
	function _onPressed() {
		trace('pressed');
		_isPressed = true;
		_swipeNodes.splice(0, _swipeNodes.length);
		onPressed.dispatch(FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y));		// TODO weak Vec2
	}
	function _onHeld() {
		_swipeNodes.push(Vec2.get(FlxG.mouse.x, FlxG.mouse.y, true));	// TODO touch, samplerate, dispatch if durations > swipe duration
	}
	function _onReleased() {
		_isPressed = false;
		_holdTimer = 0;
		trace('mouse released - timer is ${_holdTimer}');
		onReleased.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak()));
		sortSwipes();	// TODO dispatch onHeld
	}
	
	function sortSwipes():Void {
		for (swipe in FlxG.swipes) {
			trace('swipe at ${swipe.startPosition.x}, ${swipe.startPosition.y}, duration ${swipe.duration}, angle ${swipe.angle}');
			// TODO if duration < swipe duration threshold
			// TODO get swipe direction and dispatch appropriate signal
			
			
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