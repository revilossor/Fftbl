package core.ui;
import core.ui.player.PlayerHudWaypoint;
import core.util.TypedPool;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Oliver Ross
 */
class HUD extends FlxGroup
{
	var _titleText:HudText;
	var _pauseText:HudText;
	var _playerWaypoints:TypedPool<PlayerHudWaypoint> = new TypedPool<PlayerHudWaypoint>();
	
	public function new() 
	{
		trace('construct');
		super();
		add(_titleText = new HudText(FlxPoint.weak(16, FlxG.height+50), FlxPoint.weak(16, FlxG.height-50)));
		add(_pauseText = new HudText(FlxPoint.weak(FlxG.width - 150, 6 - 50), FlxPoint.weak(FlxG.width - 150, 6), 32, 'right', 0.2));
		add(_playerWaypoints);
	}
	
	public function showTitle(message:String):Void { _titleText.show(message); }
	public function setPause(value:Bool) { value ? _pauseText.show('PAUSED', false) : _pauseText.hide(); }
	
	public function addPlayerWaypoint(at:FlxPoint) {
		_playerWaypoints.spawn(PlayerHudWaypoint, at.x, at.y);
	}
	public function clearPlayerWaypoints() {
		_playerWaypoints.callAll('kill');
	}
	
	override public function destroy() {
		trace('destroy');
		_titleText = null;
		_pauseText = null;
		super.destroy();
	}
	
}