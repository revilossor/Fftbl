package states.section.intro;
import core.util.TypedPool;
import entities.Ball;
import entities.Player;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumState extends IntroState
{
	var _balls:TypedPool<Ball> = new TypedPool<Ball>();
	var _player:Player;
	
	override public function create() {
		super.create();
		_hud.showTitle('stadium intro state');	// TODO this overriding tween in parent makes me nervous
		add(_balls.spawn(Ball, 100, 100));
		add(_player = new Player(300, 700));
	}
	
	override public function update() {
		super.update();
	}
	
	override public function destroy() {
		_balls.destroy();
		_balls = null;
		super.destroy();
	}
	
}