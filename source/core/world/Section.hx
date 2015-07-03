package core.world;
import flixel.FlxState;

/**
 * @author Oliver Ross
 */

typedef Section =
{
	// TODO map screen icon, custom win / death states
	index:UInt,
	intro:Class<FlxState>,
	route:Class<FlxState>,
	boss:Class<FlxState>
}