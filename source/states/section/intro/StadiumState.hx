package states.section.intro;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class StadiumState extends IntroState
{
	override public function create() {
		super.create();
		_hud.showTitle('stadium intro state');	// TODO this overriding tween in parent makes me nervous
	}
	
}