package states.section.intro;
import core.Reg;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class IntroState extends SectionState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xff21C629;
		_hud.showTitle('base intro state');
		
		//_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getNext()); } );	// TODO flush signals on stateChange
	}
	
}