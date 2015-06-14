package entities;
import core.entity.PhysicsEntity;
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
		body.velocity.setxy( -1 + (Math.random() * 2) * 2000, -1 + (Math.random() * 2) * 2000); 
	}
}