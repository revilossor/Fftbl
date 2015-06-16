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
		makeCircleBody(Material.rubber());
		body.velocity.setxy	((-1 + (Math.random() * 2)) * 1000, (-1 + (Math.random() * 2)) * 1000);
	}
	
	override public function update() {
		super.update();
		body.angularVel *= 0.9;
	}
	override function onPressedOn(at:FlxPoint) {}
	override function onReleasedOn(at:FlxPoint) {
		body.applyImpulse(Vec2.get(-1 + (Math.random() * 2) * 2000, -1 + (Math.random() * 2) * 2000, true));
	}
}