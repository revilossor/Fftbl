package states;
import core.Reg;
import core.world.World;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class InitState extends BaseState		// TODO some of the init stuff in here might have to go in MenuState for death / win
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffff00ff;
		Reg.hud.showTitle('init state');
		Reg.world = new World();
		Reg.sectionStage = SectionStage.Intro;
		//_input.onReleased.addOnce(function(at) { fadeToState(MenuState); } );
		Reg.input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getCurrentIntro()); } );
	}
}