package entities;
import core.entity.PhysicsEntity;
import flixel.util.FlxPoint;
import nape.geom.Vec2;
import nape.phys.Material;

/**
 * ...
 * @author Oliver Ross
 */
class Ball extends PhysicsEntity
{
	public function new(?xp:Float = 0, ?yp:Float = 0) 
	{
		super(xp, yp);
		loadGraphic('assets/images/ball.png');
		makeCircleBody(new Material(1, 1.4, 1.5, 0.01));
		body.mass = 0.1;
	}
	
	override public function update() {
		super.update();
		body.angularVel *= 0.9;
	}
	override function onTapOn(at:FlxPoint) {
		body.applyImpulse(Vec2.get(-1 + (Math.random() * 2) * 100, -1 + (Math.random() * 2) * 100, true));
	}
}