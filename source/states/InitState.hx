package states;
import core.model.ModelLoader;
import core.world.World;
import flixel.FlxG;
import Reg;

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
		// TODO load config / world models here
		var loader = new ModelLoader();
		loader.get('https://dl.dropboxusercontent.com/u/20197634/fftbl/model.xml', function(model) {
			Reg.model = model;
			//Reg.sectionStage = SectionStage.Intro;
			//_input.onReleased.addOnce(function(at) { fadeToState(MenuState); } );
			Reg.input.onReleased.addOnce(function(at) { fadeToState(Reg.model.world.getCurrentIntro()); } );	// TODO shortcuts getter in model
		});
	}
}