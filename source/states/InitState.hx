package states;
import core.Reg;
import core.world.World;
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
		Reg.world = new World<String>(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']);
		_input.onReleased.addOnce(function(at:FlxPoint) { fadeToState(PlayState); } );
	}
}