package core.nape;
import core.entity.PhysicsEntity;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.FluidProperties;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.space.Space;
import nape.util.BitmapDebug;
import nape.util.Debug;
import nape.util.ShapeDebug;
import openfl.display.Stage;
import openfl.events.Event;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsSimulation
{
	var _space:Space;
	
	var _width:Float;
	var _height:Float;
	
	var _floorInteractionFilter:InteractionFilter = new InteractionFilter(-1, -1, -1, -1, 1, -1);
	//var _wallInteractionFilter:InteractionFilter = new InteractionFilter(1, -1, -1, -1, -1, -1);
	//var _ballInteractionFilter:InteractionFilter = new InteractionFilter(1, -1, -1, -1, 1, -1);
	
	
	var _wallCollisionListener:InteractionListener;
	var _wallCollisionType:CbType = new CbType();
	var _ballCollisionType:CbType = new CbType();
	
	var debug:Debug;
	
	public function new(xp:Float, yp:Float, width:Float, height:Float) 
	{
		_space = new Space();
		addFloor(xp, yp, width, height);
		addEdges(xp, yp, width, height);
		_wallCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _wallCollisionType, _ballCollisionType, onWallCollision);
		_space.listeners.add(_wallCollisionListener);
		
		debug = new ShapeDebug(FlxG.width, FlxG.height);
		FlxG.addChildBelowMouse(debug.display);
		FlxG.stage.addEventListener(Event.RESIZE, onResize);
	}
	
	function onResize(e:Event):Void {
		//debug.display.scaleX = FlxG.camera.flashSprite.scaleX;
		//debug.display.scaleY = FlxG.camera.flashSprite.scaleY;
		//debug.display.x = FlxG.camera.flashSprite.x - FlxG.camera.flashSprite.width / 2;
		//debug.display.y = FlxG.camera.flashSprite.y - FlxG.camera.flashSprite.height / 2;
		//
		/*var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		if (zoom == -1) {
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}*/
		
	}
	
	function onWallCollision(collision:InteractionCallback) {
		trace('wall collision');
	}
	
	function addFloor(xp:Float, yp:Float, width:Float, height:Float):Body {	// TODO dont track floor in var, just add by w, h, material, fluidProps so can have different areas
		var floor = new Body(BodyType.STATIC);
		var shape = new Polygon(Polygon.rect(0, 0, width, height), Material.sand(), _floorInteractionFilter);	// TODO materials for floor types, should xp, yp be 0 for LCS
		//shape.sensorEnabled = false;	// TODO spawn particles sensor on floor?
		shape.fluidEnabled = true;
		floor.shapes.push(shape);
		floor.position.setxy(xp, yp);
		floor.space = _space;
		return floor;
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
		_space.step(FlxG.elapsed);
		
		//// Clear the debug display.
		//debug.clear();
		//// Draw our Space.
		//debug.draw(_space);
		//// Flush draw calls, until this is called nothing will actually be displayed.
		//debug.flush();
		
		//#if !FLX_NO_DEBUG
		if (debug == null || _space == null)
		{
			return;
		}
		
		debug.clear();
		debug.draw(_space);
		
		var zoom = FlxG.camera.zoom;
		var sprite = debug.display;
		
		sprite.scaleX = zoom;
		sprite.scaleY = zoom;
		
		sprite.x = -FlxG.camera.scroll.x * zoom;
		sprite.y = -FlxG.camera.scroll.y * zoom;
		//#end
	}
	public function add(object:FlxBasic):PhysicsEntity {
		var entity:PhysicsEntity = cast(object);
		// TODO get body via marching squares and add
		var body = new Body();
		var shape:Polygon = new Polygon(Polygon.box(32, 32, true), Material.wood());
		body.shapes.push(shape);		// TODO marching squares body
		body.cbTypes.add(_ballCollisionType);
		body.position.setxy(entity.x + entity.width / 2, entity.y + entity.height / 2);
		body.space = _space;
		entity.body = body;
		object = null;	
		return entity;
	}
	
}