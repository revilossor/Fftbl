package core.entity;

/**
 * ...
 * @author Oliver Ross
 */
class PoolableEntity extends Entity // TODO option to get nape body from collection of pre calculated marching squares bodies for graphic 
{

	public function new(?xp:Float = 0, ?yp:Float = 0, ?graphic:Dynamic) 
	{
		super(xp, yp, graphic); 
	}
	public function renew(?xp:Float = 0, ?yp:Float = 0):PoolableEntity {
		trace('renew, new position {${xp}, ${yp}}');
		super.revive();
		return this;
	}
}