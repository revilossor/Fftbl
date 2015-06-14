package states.menu;
import core.Reg;
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
		_hud.showTitle('win state');
		Reg.input.onReleased.addOnce(function(at) { fadeToState(MenuState); } );
	}		
}