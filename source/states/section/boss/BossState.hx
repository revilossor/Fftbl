package states.section.boss;
import core.Reg;
import flixel.FlxG;

/**
 * ...
 * @author Oliver Ross
 * 
 */
class BossState extends SectionState
{

	override public function create() {
		super.create();
		FlxG.camera.bgColor = 0xffCF7222;
		Reg.hud.showTitle('base boss state');
		Reg.input.onTap.addOnce(function(at) { fadeToState(Reg.world.getNext(BossResolution.Left)); } );
	}
	
}
enum BossResolution {
	Left;
	Right;
}