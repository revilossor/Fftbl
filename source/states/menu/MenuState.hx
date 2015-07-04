package states.menu;
import Reg;
import flixel.FlxG;
import states.BaseState;

/**
 * ...
 * @author Oliver Ross
 */
class MenuState extends BaseState
{

	override public function create() 
	{
		super.create();
		FlxG.camera.bgColor = 0xff635231;
		Reg.hud.showTitle('menu state');
		Reg.input.onTap.addOnce(function(at) { fadeToState(MapState); } );
	}
	
}