package states.section.boss;
import Reg;
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
		Reg.input.onTap.addOnce(function(at) { fadeToState(Reg.model.world.getNext(BossResolution.Left)); } );// TODO shortcut in model
	}
	
}
enum BossResolution {
	Left;
	Right;
}