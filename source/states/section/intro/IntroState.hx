package states.section.intro;
import core.Reg;
import flixel.FlxG;
import states.BaseState;

/**
 * ...
 * @author Oliver Ross
 * 
 * Intro event to route / boss
 * 		eg, 	stadium intro / route through changing rooms to exit / power kick gates open
 *		exits to world.map.getNext
 * 		exit to deathstate / mapstate / restart this state or menu?
 * 
 */
class IntroState extends BaseState
{

	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xff21C629;
		_hud.showTitle('base intro state');
		_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getNext()); } );	// TODO flush signals on stateChange
	}
	
}