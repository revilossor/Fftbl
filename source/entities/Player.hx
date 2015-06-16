package entities;
import core.entity.PhysicsEntity;
import flixel.util.FlxPoint;
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
	}
	
	override function onPressedOn(at:FlxPoint) {
		animation.play(DOWN);
	}
	override function onReleased(at:FlxPoint) {
		super.onReleased(at);
		animation.play(UP);
	}
}