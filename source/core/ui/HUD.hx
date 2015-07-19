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
	var _infoText:HudText;
	var _playerWaypoints:TypedPool<PlayerHudWaypoint> = new TypedPool<PlayerHudWaypoint>();
	public var canvas:Canvas;
	
	public function new() 
	{
		trace('construct');
		super();
		add(canvas = new Canvas());
		add(_titleText = new HudText(FlxPoint.weak(16, FlxG.height+50), FlxPoint.weak(16, FlxG.height-50)));
		add(_pauseText = new HudText(FlxPoint.weak(FlxG.width - 150, 6 - 50), FlxPoint.weak(FlxG.width - 150, 6), 32, 'right', 0.4));
		add(_infoText = new HudText(FlxPoint.weak(6, -56), FlxPoint.weak(6, 6), 32, 'left', 0.3));
		add(_playerWaypoints);
	}
	
	public function showTitle(message:String):Void { _titleText.show(message); }	// TODO info object?
	public function setPause(value:Bool) { value ? _pauseText.show('PAUSED', false) : _pauseText.hide(); }
	public function showInfo(message:String):Void { trace('show info "$message"'); _infoText.show(message); }
	
	// TODO player state hud entity...
	public function addPlayerWaypoint(at:FlxPoint) {
		_playerWaypoints.spawn(PlayerHudWaypoint, at.x, at.y);
	}
	public function clearPlayerWaypoints() {
		_playerWaypoints.killAll();
	}
	public function popWaypoint() {
		_playerWaypoints.killFirst();
	}
	
	override public function destroy() {
		trace('destroy');
		_playerWaypoints.destroy();
		_playerWaypoints = null;
		_titleText = null;
		_pauseText = null;
		_infoText = null;
		super.destroy();
	}
	
}