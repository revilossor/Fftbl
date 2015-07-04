package states.section.route;
import Reg;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumExitState extends RouteState
{
	override public function create() {
		super.create();
		Reg.hud.showTitle('stadium exit state');
	}
}