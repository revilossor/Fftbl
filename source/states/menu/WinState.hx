package states.menu;
import Reg;
import flixel.FlxG;
import states.menu.MenuState;

/**
 * ...
 * @author Oliver Ross
 */
class WinState extends BaseState
{

	override public function create() 
	{
		super.create();
		FlxG.camera.bgColor = 0xff4A73D6;
		Reg.hud.showTitle('win state');
		Reg.input.onTap.addOnce(function(at) { fadeToState(MenuState); } );
	}		
}