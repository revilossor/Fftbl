package states.section.intro;
import core.entity.PhysicsEntity;
import core.util.TypedPool;
import entities.Ball;
import entities.player.Player;
import flixel.FlxG;
import Reg;

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
		Reg.hud.showTitle('stadium intro state');	// TODO this overriding tween in parent makes me nervous		
		add(_balls.spawn(Ball, 100, 100));			// TODO in map
		FlxG.camera.follow(_player);
	}
	
	override function onPlayerEntityCollision(entity) {
		switch(Type.getClass(entity)) {
			case Ball : trace('player hit ball');
		}
	}
	
	override public function update() {
		super.update();
	}
	override public function destroy() {
		_balls.destroy(); _balls = null;
		super.destroy();
	}	
}