package entities.player;
import core.entity.PhysicsEntity;
import core.InputDelegate.InteractionDirection;
import core.InputDelegate.Swipe;
import core.util.Vec2Func;
import flixel.FlxG;
import flixel.util.FlxPoint;
import nape.geom.Vec2;
import nape.phys.Material;
import Reg;

/**
 * ...
 * @author Oliver Ross
 * 
 */
class Player extends PhysicsEntity
{
	public static var UP:String = 'up';
	public static var DOWN:String = 'down';
	
	var _isDragging:Bool = false;	// TODO need to see this elsewhere for state change ui stuff...
	var _waypoints:Array<FlxPoint> = [];
	
	var _hasBall:Bool = false;
	
	public function new(?xp:Float = 0, ?yp:Float = 0) 
	{
		super(xp, yp, 4500);
		loadGraphic('assets/images/player.png', true, 100, 70);
		animation.add(UP, [0]);
		animation.add(DOWN, [1]);
		animation.play(UP);
		makeBoxBody(Material.wood());
		body.allowRotation = false;
	}
	
	override function onPressedOn(at:FlxPoint) {
		animation.play(DOWN);
		_isDragging = true;				// TODO ideally this would only flip when not a swipe...	
	}
	override function onReleased(at:FlxPoint) {
		super.onReleased(at);
		animation.play(UP);
		if(_isDragging) {				// TODO need a nicer way to do this...
			_isDragging = false;
		}
	}
	override function onSwipeOn(swipe:Swipe) {
		Reg.hud.showInfo('swipe on player');
		switch(swipe.direction) {
			case InteractionDirection.Up	:	dodge(Vec2.get(0,-((FlxG.height * 100) * FlxG.elapsed), true));
			case InteractionDirection.Down	:	dodge(Vec2.get(0,((FlxG.height * 100) * FlxG.elapsed), true));
			case InteractionDirection.Left	:	dodge(Vec2.get(-((FlxG.width * 100) * FlxG.elapsed), 0, true));
			case InteractionDirection.Right	:	dodge(Vec2.get(((FlxG.width * 100) * FlxG.elapsed), 0, true));
			case InteractionDirection.None	:	
		}
	}
	override public function onHeldOn(at) {
		Reg.hud.showInfo("held on player");
		endPath();
	}
	override public function onHeldTick(at:FlxPoint, index:UInt) {
		super.onHeldTick(at, index);
		if (_isDragging) { 
			Reg.hud.addPlayerWaypoint(at);
			_waypoints.push(at);
			//FlxG.camera.flash(FlxColor.WHITE, 0.1);
			// TODO draw spline in hud
		}
	}
	
	override public function update() {
		super.update();
		if (!_isDragging) {
			if (_waypoints.length > 0) {
				followPath();
			}
		}
	}
	function followPath() {
		seekNextWaypoint();
	}
	function seekNextWaypoint() {
		var between = Vec2Func.getBetween(body.worldCOM, Vec2.weak(_waypoints[0].x, _waypoints[0].y));
		var distance = Vec2Func.getDistanceBetween(body.worldCOM, Vec2.weak(_waypoints[0].x, _waypoints[0].y));
		distance < 50 ?
			popWaypoint() :
			move(Vec2Func.magnify(between, distance));
	}
	function popWaypoint() {
		if (_waypoints.length == 1) { endPath(); }		
		else {
			Reg.hud.popWaypoint();
			_waypoints[0].put();
			_waypoints.splice(0, 1);
		}
	}
	
	function endPath():Void {
		_forward.setxy(0, 0);
		while (_waypoints.length > 0) {
			Reg.hud.popWaypoint();
			_waypoints[0].put();
			_waypoints.splice(0, 1);
		}
	}
	
	
}