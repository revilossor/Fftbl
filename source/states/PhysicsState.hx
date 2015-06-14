package states;
import core.entity.Test;
import core.nape.PhysicsSimulation;
import core.util.TypedPool;
import flixel.FlxBasic;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsState extends BaseState
{	
	var _group:TypedPool<Test>;
	var _physics:PhysicsSimulation;
	
	override public function create() {
		super.create();
		initPhysics();
		_group = new TypedPool<Test>();
		add(_group.spawn(Test, 0, 0));
	}
	
	function initPhysics() {
		trace('init new physics simulation');
	 	_physics = new PhysicsSimulation(0, 0, FlxG.width, FlxG.height);		// TODO ???? nape scale is different to flixel pixels....
	}
	override public function add(object:FlxBasic) {
		super.add(object);
		if (_physics != null) { _physics.add(object); }
		return object;
	}
	
	override public function update() {
		_physics.update();
		super.update();
	}
	
	override public function destroy() {
		_group = null;
		_physics = null;
		super.destroy();
	}
}