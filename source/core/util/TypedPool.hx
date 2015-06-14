package core.util;
import core.entity.PoolableEntity;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author Oliver Ross
 */
@generic
class TypedPool<T:PoolableEntity> extends FlxTypedGroup<T>		// TODO nape entities - space in sectionState, ui popups, text, yesNo, 
{
	public function new() 
	{
		super();
	}
	public function spawn(type:Class<T>, ?xp:Float = 0, ?yp:Float = 0):T {	// TODO move dead entities to dead list
		for (member in members) {
			if (Std.is(type, member) && !member.alive) {
				return cast(member.renew(xp, yp));
			}
		}
		return add(Type.createInstance(type, [xp, yp]));	// TODO all runtime instantiation should be done here
	}
}