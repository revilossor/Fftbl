package core.ui;
import core.ui.player.PlayerHudWaypoint;
import core.util.TypedPool;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Oliver Ross
 */
class HUD extends FlxGroup
{
	var _titleText:FlxText;
	var _pauseText:FlxText;
	var _playerWaypoints:TypedPool<PlayerHudWaypoint> = new TypedPool<PlayerHudWaypoint>();
	
	public function new() 
	{
		trace('construct');
		super();
		initTitle();
		initPause();
		add(_playerWaypoints);
	}
	
	function initTitle() {
		_titleText = new FlxText(16, FlxG.height + 50, FlxG.width, '', 32);
		_titleText.setFormat(null, 32, 0xffF2FAFF, 'left', FlxText.BORDER_SHADOW, 0xff0C0C0C);
		add(_titleText);
	}
	public function showTitle(message:String):Void {
		_titleText.text = message;
		FlxTween.tween(_titleText, { y:FlxG.height - 50 }, 0.7, {complete:hideTitle, type:FlxTween.ONESHOT});
	}
	function hideTitle(tween:FlxTween) {
		new FlxTimer(1, function(timer) {
			FlxTween.tween(_titleText, { y:FlxG.height + 50 }, 0.7, { type:FlxTween.ONESHOT } );
		});
	}
	
	function initPause() {
		_pauseText = new FlxText(8, 6 - 50, FlxG.width - 16, 'PAUSED', 32);
		_pauseText.setFormat(null, 32, 0xffF2FAFF, 'right', FlxText.BORDER_SHADOW, 0xff0C0C0C);
		add(_pauseText);
	}
	public function setPause(value:Bool) {
		value ?
			FlxTween.tween(_pauseText, { y: 6 }, 0.2, { type:FlxTween.ONESHOT } ):
			FlxTween.tween(_pauseText, { y: 6 - 50 }, 0.2, { type:FlxTween.ONESHOT } );
	}
	
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