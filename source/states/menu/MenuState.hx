package states.menu;
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
		_hud.showTitle('menu state');
		_input.onReleased.addOnce(function(at) { fadeToState(MapState); } );
	}
	
}