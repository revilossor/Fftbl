package states;
import core.InputDelegate;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

/**
 * ...
 * @author Oliver Ross
 */
class BaseState extends FlxState
{
	var _input:InputDelegate;
	
	override public function create() {
		super.create();
		trace('construct');
		FlxG.camera.fade(FlxColor.BLACK, 1, true, function() { _input.enabled = true; } );
		add(_input = new InputDelegate());
	}
	
	function fadeToState(state:Class<FlxState>) {
		_input.enabled = false;
		FlxG.camera.fade(FlxColor.BLACK, 1, false, function() { FlxG.switchState(Type.createInstance(state, [])); } );
	}
	
	override public function destroy() {
		trace('destroy');
		super.destroy();
	}
}