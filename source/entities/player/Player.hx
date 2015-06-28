package entities.player;
import core.entity.PhysicsEntity;
import core.InputDelegate;
import core.Reg;
import flixel.FlxG;
import flixel.util.FlxColor;
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
	var _waypoints:Array<FlxPoint> = [];
	
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
		_isDragging = true;	// TODO ideally this would only flip when not a swipe...
	}
	override function onReleased(at:FlxPoint) {
		super.onReleased(at);
		animation.play(UP);
		if(_isDragging) {// TODO need a nicer way to do this...
			_isDragging = false;
		}
	}
	override function onSwipeOn(swipe:Swipe) {
		Reg.hud.showInfo('swipe on player');
		switch(swipe.direction) {
			case InteractionDirection.Up	:	body.applyImpulse(Vec2.get(0, -(FlxG.height), true));
			case InteractionDirection.Down	:	body.applyImpulse(Vec2.get(0, (FlxG.height), true));
			case InteractionDirection.Left	:	body.applyImpulse(Vec2.get(-(FlxG.height), 0, true));
			case InteractionDirection.Right	:	body.applyImpulse(Vec2.get((FlxG.height), 0, true));
			case InteractionDirection.None	:	// TODO spin????
		}	/// TODO apply vector of swipe?
	}
	override public function onHeldOn(at) {
		Reg.hud.showInfo("held on player");
	}
	override public function onHeldTick(at:FlxPoint, index:UInt) {
		super.onHeldTick(at, index);
		if (_isDragging) { 
			Reg.hud.showInfo('drag player position node'); 
			Reg.hud.addPlayerWaypoint(at);
			_waypoints.push(at);
			FlxG.camera.flash(FlxColor.WHITE, 0.1);
			// TODO draw spline
		}
	}
	
	override public function update() {
		super.update();
		if (!_isDragging) {
			if (_waypoints.length > 0) {	// not dragging, but waypoints - must have just added them
				followPath();
			}
		}
	}
	function followPath() {
		//Reg.hud.clearPlayerWaypoints();
		trace('follow path, there are ${_waypoints.length} waypoints');
		seekNextWaypoint();
	}
	function seekNextWaypoint() {
		var dest = _waypoints[0];
		if (dest == null) { return; }
		var vec = getBetween(body.worldCOM, Vec2.weak(_waypoints[0].x, _waypoints[0].y));
		// if close, pop and get next
		var dist = getMagnitudeSq(vec);
		(dist < (1000)) ?
			popWaypoint() :
			body.applyImpulse(Vec2.weak(vec.x*0.1, vec.y*0.1));
	}
	function popWaypoint() {
		trace('pop waypoint');
		_waypoints.splice(0, 1);
	}

	function distanceCheck(a:Vec2, b:Vec2, threshold:Float):Bool {
		return getMagnitudeSq(getBetween(a, b)) <= (threshold * threshold) ? true : false;
	}
	function getBetween(a:Vec2, b:Vec2):Vec2 {
		return Vec2.weak(b.x - a.x, b.y - a.y);
	}
	function getMagnitudeSq(v:Vec2):Float {
		return Math.pow(v.x, 2) + Math.pow(v.y, 2);
	}
	
}