package core.entity;
import flixel.FlxSprite;

/**
 * ...
 * @author Oliver Ross
 */
class Entity extends FlxSprite
{
	public function new(?xp:Float = 0, ?yp:Float = 0, ?graphic:Dynamic) 
	{
		trace('create');
		super(xp, yp, graphic);
	}
	// TODO destruction tells xml loaded level model entity with this id has been destroyed
}