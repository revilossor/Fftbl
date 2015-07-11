package core;
import core.util.FlxPointFunc;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.util.FlxSignal.FlxTypedSignal;

/**
 * ...
 * @author Oliver Ross
 * 
 * 
 */
class InputDelegate extends FlxBasic
{	
	public var onHeld:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onHeldTick:FlxTypedSignal<FlxPoint->UInt->Void> = new FlxTypedSignal<FlxPoint->UInt->Void>();
	public var onTap:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onSwipe:FlxTypedSignal<Swipe->Void> = new FlxTypedSignal<Swipe->Void>();
	public var onPressed:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	public var onReleased:FlxTypedSignal<FlxPoint->Void> = new FlxTypedSignal<FlxPoint->Void>();
	
	var _holdTickLength:UInt = 5;
	var _holdTimer:UInt = 0;
	var _holdTicks:UInt = 0;
	var _swipeDistanceThreshold:Float = 10;		// TODO min / max ?
	
	@isVar 
	public var enabled(never, set):Bool; var _enabled:Bool = false;
	public function set_enabled(value:Bool):Bool { return _enabled = value; }
	
	public function new() {
		super();
		//FlxG.signals.stateSwitched.add(flush);
	}
	// TODO debug keys
	override public function update() {
		super.update();
		if(_enabled) {
			if (FlxG.mouse.justPressed) { onPress(); }
			if (FlxG.mouse.justReleased) { onRelease(); }
			if (FlxG.mouse.pressed) { if (_holdTimer++ >= _holdTickLength) { holdTick(); } }
		}
	}
	
	function onPress() {
		onPressed.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak()));
	}
	function onRelease() {
		//if (_holdTicks == 0) { sortSwipes(); }		// TODO need to seperate swipes and drag path better	
		sortSwipes();
		_holdTimer = _holdTicks = 0;
		onReleased.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak()));
	}
	function holdTick() {
		_holdTicks++ == 0 ? 
			onHeld.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak())):
			onHeldTick.dispatch(FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.weak()), _holdTicks);
		_holdTimer = 0;
	}
	function sortSwipes() {
		for (swipe in FlxG.swipes) {
			FlxPointFunc.distanceCheck(swipe.startPosition, swipe.endPosition, _swipeDistanceThreshold) ?
				onTap.dispatch(swipe.startPosition):
				onSwipe.dispatch({at:swipe.startPosition, direction:getInteractionDirection(swipe.angle), vector:FlxPointFunc.getBetween(swipe.startPosition, swipe.endPosition)});
		}
	}
	function getInteractionDirection(angle):InteractionDirection {
		var absAngle = Math.abs(angle);
		if (absAngle <= 45) 		{ return InteractionDirection.Up; 		}
		else if (absAngle >= 135)	{ return InteractionDirection.Down; 	}
		else if (angle > 0)			{ return InteractionDirection.Right; 	}
		else if (angle < 0)			{ return InteractionDirection.Left; 	}
		else 						{ return InteractionDirection.None; 	}
	}
	
	override public function destroy() {
		flush();
		onSwipe = null;			onHeld = null;			onHeldTick = null;
		onTap = null;			onPressed = null;		onReleased = null;
		super.destroy();
	}
	function flush() {
		onSwipe.removeAll();	onHeld.removeAll();		onHeldTick.removeAll();
		onTap.removeAll();		onPressed.removeAll();	onReleased.removeAll();
	}
}
enum InteractionDirection {
	Up;
	Down;
	Left;
	Right;
	None;
}
typedef Swipe = {
	at:FlxPoint,
	direction:InteractionDirection,
	vector:FlxPoint	
}