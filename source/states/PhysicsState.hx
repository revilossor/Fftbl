package states;
import core.entity.PhysicsEntity;
import core.nape.PhysicsSimulation;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsState extends BaseState
{	
	var _physics:PhysicsSimulation;
	
	override public function create() {
		super.create();
		initPhysics();
	}
	
	function initPhysics() {
		trace('init new physics simulation');
	 	_physics = new PhysicsSimulation(0, 0, FlxG.width, FlxG.height);
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
		super.destroy();
	}
}