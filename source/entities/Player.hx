package entities;
import core.entity.PhysicsEntity;
import core.Reg;
import core.Reg;
import flixel.FlxG;
import nape.geom.Vec2;
import nape.phys.Material;

/**
 * ...
 * @author Oliver Ross
 */
class Player extends PhysicsEntity
{
	public static var UP:String = 'up';
	public static var DOWN:String = 'down';
	
	public function new(?xp:Float = 0, ?yp:Float = 0) 
	{
		super(xp, yp);
		loadGraphic('assets/images/player.png', true, 100, 70);
		animation.add(UP, [0]);
		animation.add(DOWN, [1]);
		animation.play(UP);
		makeBoxBody(Material.rubber());
		connectToInput();
	}
	
	function connectToInput() {
		Reg.input.onPressed.add(function(at) {
			if (overlapsPoint(at)) {
				animation.play(DOWN);
			}
		});
		Reg.input.onReleased.add(function(at) {
			animation.play(UP);
		});
	}
	
/*	override public function update() {
		super.update();
		if (FlxG.keys.anyJustPressed(['UP'])) {
			body.applyImpulse(Vec2.get(-50 + (Math.random()*100), -1000, true));		// TODO timestep
		}
		if (FlxG.keys.anyJustPressed(['DOWN'])) {
			body.applyImpulse(Vec2.get(-50 + (Math.random()*100), 1000, true));		// TODO timestep
		}
		if (FlxG.keys.anyJustPressed(['LEFT'])) {
			body.applyImpulse(Vec2.get(-1000, -50 + (Math.random()*100),  true));		// TODO timestep
		}
		if (FlxG.keys.anyJustPressed(['RIGHT'])) {
			body.applyImpulse(Vec2.get(1000, -50 + (Math.random()*100), true));		// TODO timestep
		}
	}*/
}