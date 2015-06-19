package states.section;
import core.InputDelegate.Swipe;
import core.Reg;
import entities.player.Player;
import states.PhysicsState;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO exit to deathstate
 */
class SectionState extends PhysicsState
{	
	var _player:Player;
	
	override public function create() {
		super.create();
		Reg.input.onTap.add(onTap);
		Reg.input.onSwipe.add(onSwipe);
		Reg.input.onHeld.add(onHeld);
		Reg.input.onHeldTick.add(onHeldTick);
		Reg.input.onReleased.add(onReleased);
		add(_player = new Player(300, 700));
	}	
	
	function setPaused(value:Bool) {
		_hud.setPause(Reg.isPaused = value);
	}
	function onTap(at):Void {
		trace('on tap');
	}
	function onSwipe(swipe:Swipe) {
		trace('on swipe'); 
	}
	function onHeld(at):Void {
		setPaused(true);
	}
	function onHeldTick(at, index) {
		trace('on held tick');
		_hud.addPlayerWaypoint(at);		// BUG this should only be when starts on player
		// TODO draw spline
	}
	function onReleased(at):Void {
		setPaused(false);
		_hud.clearPlayerWaypoints();
	}
	override public function destroy() {
		_player.destroy(); _player = null;
		super.destroy();
	}
}