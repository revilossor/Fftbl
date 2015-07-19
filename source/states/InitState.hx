package states;
import core.model.Model;
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
		var loader = new ModelLoader();		// TODO error handler ?
		loader.get(Reg.modelURI, function(model) {
			Reg.model = model;
			fadeToState(Reg.model.world.getCurrentIntro());
		}, function(message) {
			trace('error loading model!');  
		});
		Reg.input.onTap.add(function(at) {
			Reg.model = new Model('{}');
			fadeToState(Reg.model.world.getCurrentIntro());
		});
	}
}