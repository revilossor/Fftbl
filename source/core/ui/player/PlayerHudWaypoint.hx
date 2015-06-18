package core.ui.player;
import core.entity.Entity;
import core.entity.PoolableEntity;

/**
 * ...
 * @author ...
 * 
 * This is mostly just a view class - could do some flashy interaction stuff....
 * 
 */
class PlayerHudWaypoint extends PoolableEntity
{	
	public function new(xp:Float, yp:Float) 
	{
		super(xp, yp);
		makeGraphic(16, 16);	// TODO animated ?
		x -= 8; y -= 8;
	}
	
}