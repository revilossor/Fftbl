package states;
import flixel.FlxG;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Oliver Ross
 */
class InitState extends BaseState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffff00ff;
		_input.onReleased.addOnce(function(at:FlxPoint) { fadeToState(PlayState); } );
	}
}