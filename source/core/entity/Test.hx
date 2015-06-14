package core.entity;
import flixel.FlxG;
import nape.geom.Vec2;

/**
 * ...
 * @author Oliver Ross
 */
class Test extends PhysicsEntity
{
	public function new(?xp:Float = 0, ?yp:Float = 0) 
	{
		super(xp, yp);
		makeGraphic(32, 32, 0xffFFFFFF);
	}
	
	override public function update() {
		super.update();
		if (FlxG.keys.anyJustReleased(['UP'])) {
			body.applyImpulse(Vec2.get(-50 + (Math.random()*100), -1000, true));		// TODO timestep
		}
		if (FlxG.keys.anyJustReleased(['DOWN'])) {
			body.applyImpulse(Vec2.get(-50 + (Math.random()*100), 1000, true));		// TODO timestep
		}
		if (FlxG.keys.anyJustReleased(['LEFT'])) {
			body.applyImpulse(Vec2.get(-1000, -50 + (Math.random()*100),  true));		// TODO timestep
		}
		if (FlxG.keys.anyJustReleased(['RIGHT'])) {
			body.applyImpulse(Vec2.get(1000, -50 + (Math.random()*100), true));		// TODO timestep
		}
	}
	
}