package states.section.boss;
import Reg;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumGatesBossState extends BossState
{
	override public function create() {
		super.create();
		Reg.hud.showTitle('locked gates boss state');
	}
	
}