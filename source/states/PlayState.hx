package states;
import flixel.FlxG;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Oliver Ross
 */
class PlayState extends BaseState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xff4A9C4A;
		_input.onReleased.addOnce(function(at:FlxPoint) { fadeToState(PlayState); } );		
		trace('world is ${Reg.world}');
	}
}