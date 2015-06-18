package entities.player;
import core.entity.PhysicsEntity;
import core.InputDelegate;
import flixel.util.FlxPoint;
import nape.geom.Vec2;
import nape.phys.Material;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO bezier path or seek nodes?
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
	override public function onSwipeOn(at, direction) {
		switch(direction) {
			case InteractionDirection.Up	:	body.applyImpulse(Vec2.get(0, -2500, true));
			case InteractionDirection.Down	:	body.applyImpulse(Vec2.get(0, 2500, true));
			case InteractionDirection.Left	:	body.applyImpulse(Vec2.get(-2500, 0, true));			// TODO figure this out for aspect ratio
			case InteractionDirection.Right	:	body.applyImpulse(Vec2.get(2500, 0, true));
			case InteractionDirection.None	:	// TODO spin????
		}
	}
}