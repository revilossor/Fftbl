package states;
import core.entity.PhysicsEntity;
import core.nape.PhysicsSimulation;
import core.world.tiled.TiledLevel;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsState extends BaseState
{	
	var _physics:PhysicsSimulation;
	
	override public function create() {
		super.create();
	}
	
	function initPhysics(width, height) {
		trace('init new physics simulation');
	 	_physics = new PhysicsSimulation(0, 0, width, height);
	}
	override public function add(entity){ // TODO remove also removes from physics
		super.add(entity);
		if (_physics != null && Std.is(entity, PhysicsEntity)) { _physics.add(entity); }
		return entity;
	}
	
	override public function update() {
		if( _physics != null) { _physics.update(); }
		super.update();
	}
	
	override public function destroy() {
		if( _physics != null) { _physics.destroy(); }
		_physics = null;
		super.destroy();
	}
}