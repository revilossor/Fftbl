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
			if (Std.is(type, member) && !member.alive) {
				return cast(member.renew(xp, yp));
			}
		}
		return add(Type.createInstance(type, [xp, yp]));
	}
}