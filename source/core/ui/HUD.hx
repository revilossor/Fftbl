package core.ui;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Oliver Ross
 */
class HUD extends FlxGroup
{
	var _titleText:FlxText;
	
	public function new() 
	{
		trace('construct');
		super();
		initTitle();
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
		trace('hide title');
		new FlxTimer(1, function(timer) {
			trace('title hide timer up');
			FlxTween.tween(_titleText, { y:FlxG.height + 50 }, 0.7, { type:FlxTween.ONESHOT } );
		});
	}
	
	override public function destroy() {
		trace('destroy');
		_titleText = null;
		super.destroy();
	}
	
}