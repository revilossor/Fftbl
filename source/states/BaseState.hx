package states;
import core.InputDelegate;
import Reg;
import core.ui.HUD;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

/**
 * ...
 * @author Oliver Ross
 * 
 */
class BaseState extends FlxState
{
	override public function create() {
		trace('construct');
		super.create();
		add(Reg.input = new InputDelegate());
		add(Reg.hud = new HUD());
		FlxG.camera.fade(FlxColor.BLACK, 1, true, function() { Reg.input.enabled = true; } );
	}
	
	function fadeToState(state:Class<FlxState>, ?args:Array<Dynamic> = null) {
		Reg.input.enabled = false;
		FlxG.camera.fade(FlxColor.BLACK, 1, false, function() { FlxG.switchState(Type.createInstance(state, args == null ? [] : args)); } );
	}
	
	override public function destroy() {
		trace('destroy');
		super.destroy();
	}
}