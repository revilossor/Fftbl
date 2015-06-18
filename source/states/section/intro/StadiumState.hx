package states.section.intro;
import core.Reg;
import core.util.TypedPool;
import entities.Ball;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumState extends IntroState
{
	var _balls:TypedPool<Ball> = new TypedPool<Ball>();
	
	override public function create() {
		super.create();
		Reg.input.enabled = true;
		_hud.showTitle('stadium intro state');	// TODO this overriding tween in parent makes me nervous
		add(_balls.spawn(Ball, 100, 100));
	}
	
	override public function update() {
		super.update();
	}
	override public function destroy() {
		_balls.destroy(); _balls = null;
		super.destroy();
	}
	
}