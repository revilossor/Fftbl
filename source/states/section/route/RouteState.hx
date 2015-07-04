package states.section.route;
import Reg;
import flixel.FlxG;
import states.section.SectionState;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO difficulty argument
 * 
 */
class RouteState extends SectionState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffE7AD00;
		Reg.hud.showTitle('base route state');
		
		Reg.input.onReleased.addOnce(function(at) { fadeToState(Reg.model.world.getNext()); } );	// TODO shortcut in model
	}
	
}