package core.nape;
import core.entity.PhysicsEntity;
import flixel.FlxG;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import nape.util.Debug;
import nape.util.ShapeDebug;
import Reg;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsSimulation
{
	var _space:Space;
	
	var _width:Float;
	var _height:Float;
	
	var _wallCollisionListener:InteractionListener;
	var _wallCollisionType:CbType = new CbType();
	var _entityCollisionType:CbType = new CbType();
	
	var debug:Debug;
	
	public function new(xp:Float, yp:Float, width:Float, height:Float) 
	{
		_space = new Space();
		addEdges(xp, yp, width, height);
		_wallCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _wallCollisionType, _entityCollisionType, onWallEntityCollision);
		_space.listeners.add(_wallCollisionListener);
		
		debug = new ShapeDebug(Std.int(width), Std.int(height));
		FlxG.addChildBelowMouse(debug.display);
	}
	
	function onWallEntityCollision(collision:InteractionCallback) {
		trace('wall collision');
	}
	
	function addEdges(xp:Float, yp:Float, width:Float, height:Float) {// TODO different spaces?
		addAAWall(xp, yp, width, -32);
		addAAWall(xp, yp + height, width, 32);
		addAAWall(xp, yp, -32, height);
		addAAWall(xp + width, yp, 32, height);
	}
	function addAAWall(xp:Float, yp:Float, width:Float, height:Float) {// TODO wall interaction filter... some stuff can pass through...
		var wall = new Body(BodyType.STATIC);
		wall.cbTypes.add(_wallCollisionType);
		var shape = new Polygon(Polygon.rect(0, 0, width, height));
		wall.shapes.push(shape);
		wall.position.setxy(xp, yp);
		wall.space = _space;
	}
	
	public function update() {
		
		if (!Reg.model.settings.isPaused) { _space.step(FlxG.elapsed * FlxG.timeScale); }
		//FlxG.worldBounds.set(FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + FlxG.width, FlxG.camera.scroll.y + FlxG.height);
		drawDebug();
	}
	function drawDebug():Void {
		if (debug == null || _space == null){ return; }
		debug.clear();
		debug.draw(_space);
		var zoom = FlxG.camera.zoom;
		var sprite = debug.display;
		sprite.scaleX = zoom;
		sprite.scaleY = zoom;
		sprite.x = -FlxG.camera.scroll.x * zoom;
		sprite.y = -FlxG.camera.scroll.y * zoom;
	}
	public function add(object) {
		var entity:PhysicsEntity = cast(object);
		entity.body.cbTypes.add(_entityCollisionType);
		entity.body.space = _space;
	}
	// TODO destroy / remove bodies...
	public function destroy() {
		trace('destroy');
		_space = null;
		_wallCollisionListener = null;
		_wallCollisionType = null;
		_entityCollisionType = null;
		debug = null;
	}
}