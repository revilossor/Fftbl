package states.menu;
import core.Reg;
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
		_hud.showTitle('map state');
		_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getCurrentIntro()); } );	// TODO flush signals on stateChange
	}
	
}