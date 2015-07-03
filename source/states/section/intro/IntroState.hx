package states.section.intro;
import core.Reg;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 */
class IntroState extends SectionState
{
	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xff21C629;
		Reg.hud.showTitle('base intro state');
	}
	
}