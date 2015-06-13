package states.section.boss;
import core.Reg;
import flixel.FlxG;
import states.BaseState;

/**
 * ...
 * @author Oliver Ross
 * 
 * TODO miniboss - custom event, with difficulty argument
 * 		exits to world.map.left or right
 */
class BossState extends BaseState
{

	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffCF7222;
		_hud.showTitle('base boss state');
		_input.onReleased.addOnce(function(at) { fadeToState(Reg.world.getNext(BossResolution.Left)); } );	// TODO left or right...
	}
	
}