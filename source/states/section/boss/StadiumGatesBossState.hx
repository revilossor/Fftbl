package states.section.boss;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumGatesBossState extends BossState
{
	override public function create() {
		super.create();
		_hud.showTitle('locked gates boss state');
	}
	
}