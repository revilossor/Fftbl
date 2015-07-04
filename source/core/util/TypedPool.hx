package core.util;
import core.entity.PoolableEntity;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author Oliver Ross
 */
@generic
class TypedPool<T:PoolableEntity> extends FlxTypedGroup<T>
{
	public function new() 
	{
		super();
	}
	public function spawn(type:Class<T>, ?xp:Float = 0, ?yp:Float = 0):T {
		for (member in members) {
			if (type == Type.getClass(member) && !member.alive) {
				trace('revive');
				return cast(member.renew(xp, yp));
			}
		}
		return add(Type.createInstance(type, [xp, yp]));
	}
	public function killAll() {
		forEach(function(member) {
			member.kill();
		});
	}
	public function killFirst() {
		getFirstAlive().kill();
	}
	override public function destroy() {
		killAll();
		forEach(function(member) {
			member.destroy();
		});
		super.destroy();
	}
}