package states.section.boss;
import core.Reg;
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