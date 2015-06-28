package entities.player;
import core.entity.PhysicsEntity;
import core.InputDelegate;
import core.Reg;
import flixel.FlxG;
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
	
	var _isDragging:Bool = false;	// TODO need to see this elsewhere for state change ui stuff...
	
	public function new(?xp:Float = 0, ?yp:Float = 0) 
	{
		super(xp, yp);
		loadGraphic('assets/images/player.png', true, 100, 70);
		animation.add(UP, [0]);
		animation.add(DOWN, [1]);
		animation.play(UP);
		makeBoxBody(Material.wood());
	}
	
	override function onPressedOn(at:FlxPoint) {
		animation.play(DOWN);
	}
	override function onReleased(at:FlxPoint) {
		super.onReleased(at);
		animation.play(UP);
		if(_isDragging) {// TODO need a nicer way to do this...
			_isDragging = false;
			Reg.hud.clearPlayerWaypoints();
			Reg.hud.showInfo('clear player position nodes');
		}
	}
	override function onSwipeOn(swipe:Swipe) {
		Reg.hud.showInfo('swipe on player');
		switch(swipe.direction) {
			case InteractionDirection.Up	:	body.applyImpulse(Vec2.get(0, -(FlxG.height), true));
			case InteractionDirection.Down	:	body.applyImpulse(Vec2.get(0, (FlxG.height), true));
			case InteractionDirection.Left	:	body.applyImpulse(Vec2.get(-(FlxG.height), 0, true));			// TODO figure this out for aspect ratio
			case InteractionDirection.Right	:	body.applyImpulse(Vec2.get((FlxG.height), 0, true));
			case InteractionDirection.None	:	// TODO spin????
		}	/// TODO apply vector of swipe?
	}
	override public function onHeldOn(at) {
		Reg.hud.showInfo("held on player");
		_isDragging = true;
	}
	override public function onHeldTick(at:FlxPoint, index:UInt) {
		super.onHeldTick(at, index);
		if(_isDragging) { Reg.hud.showInfo('drag player position node'); Reg.hud.addPlayerWaypoint(at); }
		// TODO draw spline
	}
}