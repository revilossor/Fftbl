package states.section.intro;
import core.world.tiled.TiledLevel;
import flixel.FlxG;
import Reg;
import core.util.TypedPool;
import entities.Ball;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumState extends IntroState
{
	var _balls:TypedPool<Ball> = new TypedPool<Ball>();
	var _level:TiledLevel;	// TODO in sectionState?
	
	override public function create() {
		_level = new TiledLevel("assets/data/sections/test.tmx");		// TODO path is in loaded model
		add(_level.environment);
		super.create();
		Reg.input.enabled = true;
		Reg.hud.showTitle('stadium intro state');	// TODO this overriding tween in parent makes me nervous		
		add(_balls.spawn(Ball, 100, 100));			// TODO in map
		FlxG.camera.follow(_player);
	}
	
	override public function update() {
		super.update();
	}
	override public function destroy() {
		_balls.destroy(); _balls = null;
		super.destroy();
	}	
}