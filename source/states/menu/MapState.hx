package states.menu;
import Reg;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class MapState extends BaseState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xff428C4A;
		Reg.hud.showTitle('map state');
		Reg.input.onTap.addOnce(function(at) { fadeToState(Reg.model.world.getCurrentIntro()); } );// TODO shortcut in model
	}
	
}