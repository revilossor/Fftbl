package states;
import core.Reg;
import core.world.World;
import flixel.FlxG;
import states.menu.MenuState;

/**
 * ...
 * @author Oliver Ross
 */
class InitState extends BaseState		// TODO some of the init stuff in here might have to go in MenuState for death / win
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffff00ff;
		_hud.showTitle('init state');
		Reg.world = new World();
		Reg.sectionStage = SectionStage.Intro;
		//_input.onReleased.addOnce(function(at) { fadeToState(MenuState); } );
		_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getCurrentIntro()); } );
	}
}