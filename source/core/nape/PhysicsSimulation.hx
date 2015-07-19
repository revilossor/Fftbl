package core.nape;
import core.entity.PhysicsEntity;
import flixel.FlxG;
import flixel.util.FlxSignal.FlxTypedSignal;
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
	var _entityCollisionListener:InteractionListener;
	var _wallCollisionType:CbType = new CbType();
	var _entityCollisionType:CbType = new CbType();
	
	var _debug:Debug;
	
	public var onEntityEntityCollision:FlxTypedSignal<PhysicsEntity->PhysicsEntity->Void> = new FlxTypedSignal<PhysicsEntity->PhysicsEntity->Void>();
	
	public function new(xp:Float, yp:Float, width:Float, height:Float) 
	{
		_space = new Space();
		addEdges(xp, yp, width, height);
		_wallCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _wallCollisionType, _entityCollisionType, wallEntityCollision);
		_space.listeners.add(_wallCollisionListener);
		_entityCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _entityCollisionType, _entityCollisionType, entityEntityCollision);
		_space.listeners.add(_entityCollisionListener);
		
		_debug = new ShapeDebug(Std.int(width), Std.int(height));
		FlxG.addChildBelowMouse(_debug.display);
	}
	
	function wallEntityCollision(collision:InteractionCallback) { 
		trace('wall collision'); 
	}
	function entityEntityCollision(collision:InteractionCallback) {
		onEntityEntityCollision.dispatch(collision.int1.userData.entity, collision.int2.userData.entity);		
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
		if (_debug == null || _space == null){ return; }
		_debug.clear();
		_debug.draw(_space);
		var zoom = FlxG.camera.zoom;
		var sprite = _debug.display;
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
		_debug = null;
	}
}