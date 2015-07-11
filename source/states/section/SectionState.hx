package states.section;
import core.InputDelegate.Swipe;
import core.nape.PhysicsSimulation;
import core.world.tiled.TiledLevel;
import entities.player.Player;
import Reg;
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
	var _level:TiledLevel;
	
	override public function create() {
		super.create();
		Reg.input.onTap.add(onTap);
		Reg.input.onSwipe.add(onSwipe);
		Reg.input.onHeld.add(onHeld);
		Reg.input.onHeldTick.add(onHeldTick);
		Reg.input.onReleased.add(onReleased);
		_level = new TiledLevel("assets/data/sections/test.tmx");
		_physics = new PhysicsSimulation(0, 0, _level.fullWidth, _level.fullHeight);
		add(_level.environment);
		add(_player = new Player(300, 700));		// TODO player start in level model
		add(Reg.hud);
	}
	
	function setPaused(value:Bool) {
		Reg.hud.setPause(Reg.model.settings.isPaused = value);
	}
	function onTap(at):Void {
		trace('on tap');
	}
	function onSwipe(swipe:Swipe) {
		trace('on swipe'); 
	}
	function onHeld(at):Void {		// TODO drag to shoot if have ball, run if dont
		setPaused(true);
	}
	function onHeldTick(at, index) {	// TODO drag to change aim if ball, draw path if dont
		trace('on held tick');
	}
	function onReleased(at):Void {
		setPaused(false);
	}
	override public function destroy() {
		_player.destroy(); _player = null;
		_level = null;
		super.destroy();
	}
}