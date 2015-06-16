package states.section;
import core.Reg;
import flixel.FlxG;
import states.PhysicsState;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO exit to deathstate
 */
class SectionState extends PhysicsState
{		
	override public function create() {
		super.create();
		Reg.input.onHeld.add(function(at) { setPaused(true); } );
		Reg.input.onReleased.add(function(at) { setPaused(false); } );		// BUG tween out behaves a bit odd here... on held firing multiple timas????
	}
	
	function setPaused(value:Bool) {
		_hud.setPause(Reg.isPaused = value);
	}
}