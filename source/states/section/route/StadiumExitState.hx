package states.section.route;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumExitState extends RouteState
{
	override public function create() {
		super.create();
		_hud.showTitle('stadium exit state');
	}
}