package states;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class InitState extends BaseState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffff00ff;
	}
}