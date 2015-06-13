package states;
import core.Reg;
import core.world.World;
import flixel.FlxG;
import states.menu.MenuState;

/**
 * ...
 * @author Oliver Ross
 */
class InitState extends BaseState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffff00ff;
		_hud.showTitle('init state');
		Reg.world = new World();
		_input.onReleased.addOnce(function(at) { fadeToState(MenuState); } );
	}
}