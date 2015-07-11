package states;
import core.entity.PhysicsEntity;
import core.nape.PhysicsSimulation;
import core.world.tiled.TiledLevel;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsState extends BaseState
{	
	var _physics:PhysicsSimulation;
	var _level:TiledLevel;	// TODO in sectionState?

	
	override public function create() {
		_level = new TiledLevel("assets/data/sections/test.tmx");		// TODO path is in loaded model, init physics with w / h
		add(_level.environment);		// TTODO level state?
		super.create();
		initPhysics();
	}
	
	function initPhysics() {
		trace('init new physics simulation');
	 	_physics = new PhysicsSimulation(0, 0, _level.fullWidth, _level.fullHeight);
	}
	override public function add(entity){ // TODO remove also removes from physics
		super.add(entity);
		if (_physics != null && Std.is(entity, PhysicsEntity)) { _physics.add(entity); }
		return entity;
	}
	
	override public function update() {
		_physics.update();
		super.update();
	}
	
	override public function destroy() {
		_physics.destroy();
		_physics = null;
		_level = null;
		super.destroy();
	}
}