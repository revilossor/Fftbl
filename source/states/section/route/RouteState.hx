package states.section.route;
import core.Reg;
import flixel.FlxG;
import states.BaseState;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO auto runner bit, with difficulty argument
 * 		exits to world.map.getNext
 * 
 */
class RouteState extends BaseState
{

	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffE7AD00;
		_hud.showTitle('base route state');
		_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getNext()); } );	// TODO flush signals on stateChange
	}
	
}