package states;
import core.InputDelegate;
import core.ui.HUD;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO overridale functions for holdPlayer, swipePlayer[up, down, left, right], pathPlayer, holdSection, swipeSection[up, down, left, right], pathSection
 */
class BaseState extends FlxState
{
	var _input:InputDelegate;
	var _hud:HUD;
	
	override public function create() {
		super.create();
		trace('construct');
		FlxG.camera.fade(FlxColor.BLACK, 1, true, function() { _input.enabled = true; } );
		add(_input = new InputDelegate());
		add(_hud = new HUD());
	}
	
	function fadeToState(state:Class<FlxState>, ?args:Array<Dynamic> = null) {
		_input.enabled = false;
		FlxG.camera.fade(FlxColor.BLACK, 1, false, function() { FlxG.switchState(Type.createInstance(state, args == null ? [] : args)); } );
	}
	
	override public function destroy() {
		trace('destroy');
		super.destroy();
	}
}