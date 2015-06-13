package states.section.route;
import core.Reg;
import flixel.FlxG;
import states.section.SectionState;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO auto runner bit, with difficulty argument
 * 
 */
class RouteState extends SectionState
{

	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffE7AD00;
		_hud.showTitle('base route state');
		_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getNext()); } );	// TODO flush signals on stateChange
	}
	
}