package core.ui;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Oliver Ross
 */
class HudText extends FlxText
{
	var _start:FlxPoint;
	var _end:FlxPoint;
	var _speed:Float;
	
	public function new(start:FlxPoint, end:FlxPoint, ?size:Int = 32, ?alignment:String = 'left', ?speed:Float = 0.7) 
	{
		super(start.x, start.y, 0, '', size);
		setFormat(null, size, 0xffF2FAFF, alignment, FlxText.BORDER_SHADOW, 0xff0C0C0C);
		_start = start;
		_end = end;
		_speed = speed;
	}
	public function show(message:String, ?autohide:Bool = true):Void {
		text = message;
		FlxTween.tween(this, { x:_end.x, y:_end.y }, _speed, autohide ? {complete:hide, type:FlxTween.ONESHOT} : {type:FlxTween.ONESHOT});
	}
	public function hide(?tween:FlxTween) {
		new FlxTimer(tween == null ? 0.1 : _speed, function(timer) {
			FlxTween.tween(this, { x:_start.x, y:_start.y }, _speed, { type:FlxTween.ONESHOT } );
		});
	}
	
}